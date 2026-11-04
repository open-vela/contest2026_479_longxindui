# SPI Flash 驱动设计文档

## 1. 功能概述

通过 LS2K0300 硬件 SPI2 控制器读写 SPI Flash（如 W25Qxx、GD25Qxx 系列）。
支持 JEDEC ID 读取、扇区擦除、页编程、数据读取等标准操作。

### 典型 SPI Flash 特性
- 容量：512Kbit ~ 256Mbit（64KB ~ 32MB）
- 扇区大小：4KB
- 页大小：256 字节
- SPI 接口，最高 80~133MHz
- 支持 SPI Mode 0 和 Mode 3

## 2. 板级配置（必须先完成）

### 2.1 引脚复用

在 `nuttx/boards/loongarch/ls2k0300/hummingbird-ls2k0300/src/ls2k0300_bringup.c` 的
`ls2k0300_hardware_init()` 中添加：

```c
/* SPI2: GPIO64/65/66 → MAIN_FUNC, GPIO85 → GPIO(Flash 软件CS) */
ls_pinmux_pin_setup(64, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(65, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(66, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(85, LS_PINMUX_MODE_AS_GPIO);
```

> ⚠️ 注意：Flash CS 是 GPIO85，不是 GPIO67！GPIO67 是 MCP3204 ADC 的 CS。

### 2.2 Kconfig 使能

在 `nuttx/boards/loongarch/ls2k0300/hummingbird-ls2k0300/configs/nsh/defconfig` 中添加：

```
CONFIG_LS2K0300_SPI=y
CONFIG_LS2K0300_SPIIO2=y
CONFIG_LS2K0300_GPIO=y
CONFIG_LS2K0300_PINCTRL=y
```

## 3. SPI 寄存器访问规范（⚠️ 关键）

### 3.1 DR 寄存器必须用 8 位访问

LS2K0300 的 SPI IO 控制器 DR 寄存器是 **字节宽度** 的。必须使用 8 位访问：

```c
/* ✅ 正确：8 位访问 */
#define SPI_REG8(off)   (*(volatile uint8_t *)(SPI2_BASE + (off)))
SPI_REG8(LS_SPI_IO_DR) = tx;        /* 写入 */
rx = SPI_REG8(LS_SPI_IO_DR);        /* 读取 */

/* ❌ 错误：32 位访问会导致数据错位 */
#define SPI_REG32(off)  (*(volatile uint32_t *)(SPI2_BASE + (off)))
SPI_REG32(LS_SPI_IO_DR) = tx;       /* 写入4字节到FIFO！ */
rx = SPI_REG32(LS_SPI_IO_DR);       /* 读取4字节！ */
```

**验证方法**：查看 `nuttx/arch/loongarch/src/ls2k0300/ls2k0300_spiio.c` 中的
`spiio_write_reg_byte` 和 `spiio_read_reg_byte` 函数，它们使用 `putreg8`/`getreg8`。

### 3.2 必须等待 EOT 标志

每次传输必须等待 EOT（End Of Transfer）标志，不能只等 RXA：

```c
/* 启动传输 */
SPI_REG32(LS_SPI_IO_CR1) |= LS_SPI_CR1_CSTART;

/* 等待 EOT（必须！） */
while (!(SPI_REG32(LS_SPI_IO_SR1) & LS_SPI_SR1_EOT)) {
    up_udelay(1);
}
SPI_REG32(LS_SPI_IO_SR1) = LS_SPI_SR1_EOT;  /* 清除 */

/* 然后才能读取 RX 数据 */
while (!(SPI_REG32(LS_SPI_IO_SR1) & LS_SPI_SR1_RXA)) {
    up_udelay(1);
}
rx = SPI_REG8(LS_SPI_IO_DR);
```

### 3.3 AUTOSUS 位不能置位

CSTART 配合 AUTOSUS=1 会导致 EOT 永不置位。必须只用 CSTART：

```c
/* ✅ 正确：只置 CSTART */
val |= LS_SPI_CR1_CSTART;

/* ❌ 错误：同时置 AUTOSUS 会导致 EOT 超时 */
val |= LS_SPI_CR1_CSTART | LS_SPI_CR1_AUTOSUS;
```

## 4. SPI Flash 操作时序

### 4.1 命令集（标准 W25/GD25 兼容）

| 命令 | 字节 | 说明 |
|------|------|------|
| Read JEDEC ID | `0x9F` + 3字节读 | 返回厂商ID + 类型 + 容量 |
| Read Status | `0x05` + 1字节读 | bit0=WIP(忙) |
| Write Enable | `0x06` | 擦除/写入前必须发送 |
| Sector Erase | `0x20` + 3字节地址 | 擦除4KB扇区 |
| Page Program | `0x02` + 3字节地址 + 数据 | 写入最多256字节 |
| Read Data | `0x03` + 3字节地址 + 读 | 连续读取 |
| Enable Reset | `0x66` | 软件复位第一步 |
| Reset | `0x99` | 软件复位第二步 |

### 4.2 JEDEC ID 读取

```c
void flash_read_jedec_id(uint8_t id[3])
{
    flash_cs_select();
    flash_xfer(0x9F);           /* 命令 */
    id[0] = flash_xfer(0xFF);   /* 厂商ID */
    id[1] = flash_xfer(0xFF);   /* 内存类型 */
    id[2] = flash_xfer(0xFF);   /* 容量码 */
    flash_cs_deselect();
}
```

常见 JEDEC ID：
- `EF 40 16` = W25Q32 (Winbond, 4MB)
- `EF 40 17` = W25Q64 (Winbond, 8MB)
- `C8 40 15` = GD25Q16 (GD, 2MB)
- `C8 40 14` = GD25Q80 (GD, 1MB)

### 4.3 扇区擦除

```c
int flash_sector_erase(uint32_t addr)
{
    flash_write_enable();           /* 必须先发 WREN */

    flash_cs_select();
    flash_xfer(0x20);              /* Sector Erase 命令 */
    flash_xfer((uint8_t)(addr >> 16));  /* 地址高字节 */
    flash_xfer((uint8_t)(addr >> 8));   /* 地址中字节 */
    flash_xfer((uint8_t)addr);          /* 地址低字节 */
    flash_cs_deselect();

    return flash_wait_ready("erase");   /* 等待完成 */
}
```

### 4.4 页编程（Page Program）

```c
int flash_page_program(uint32_t addr, const uint8_t *data, uint32_t len)
{
    flash_write_enable();           /* 必须先发 WREN */

    flash_cs_select();
    flash_xfer(0x02);              /* Page Program 命令 */
    flash_xfer((uint8_t)(addr >> 16));
    flash_xfer((uint8_t)(addr >> 8));
    flash_xfer((uint8_t)addr);

    for (uint32_t i = 0; i < len; i++) {
        flash_xfer(data[i]);       /* 写入数据 */
    }

    flash_cs_deselect();
    return flash_wait_ready("program");
}
```

> ⚠️ **页边界限制**：单次 Page Program 不能跨越 256 字节页边界。
> 如果数据跨越页边界，需要分多次写入。

### 4.5 数据读取

```c
void flash_read_data(uint32_t addr, uint8_t *data, uint32_t len)
{
    flash_cs_select();
    flash_xfer(0x03);              /* Read Data 命令 */
    flash_xfer((uint8_t)(addr >> 16));
    flash_xfer((uint8_t)(addr >> 8));
    flash_xfer((uint8_t)addr);

    for (uint32_t i = 0; i < len; i++) {
        data[i] = flash_xfer(0xFF);    /* 读取数据 */
    }

    flash_cs_deselect();
}
```

## 5. 总线管理（⚠️ 核心设计原则）

### 5.1 spi2_bus_reset() 的正确用法

`spi2_bus_reset()` 会：
1. 停止当前传输
2. 清空 FIFO 和状态标志
3. 释放所有 CS（拉高）

**必须调用的时机**：
- 程序初始化时
- 从其他 SPI 设备（如 ADC）切换到 Flash 前
- 程序退出前（确保 CS 释放）

**禁止调用的时机**：
- `flash_sector_erase()` 内部
- `flash_page_program()` 内部
- `flash_read_data()` 内部
- `flash_read_status()` 内部（被 wait_ready 循环调用）

**原因**：Flash 操作需要连续的 CS 低电平序列。调用 `spi2_bus_reset()`
会切换 CS 电平，中断正在进行的 flash 操作，导致：
- 写入数据丢失（verify 失败，读回 0xFF）
- Flash 卡死（JEDEC ID 返回 FF FF FF）

### 5.2 多设备共用 SPI 总线

当 ADC 和 Flash 共用 SPI2 总线时：

```c
/* ADC 读取 */
adc_cs_select();
spi2_xfer_byte(...);
adc_cs_deselect();

/* 切换到 Flash 前，必须重置总线 */
spi2_bus_reset();  /* 释放 ADC CS，清空总线状态 */
up_mdelay(10);

/* Flash 操作 */
flash_read_jedec_id(id);
```

### 5.3 程序退出时的清理

```c
/* 退出前必须释放 CS */
spi2_bus_reset();
close(g_fd_flash_cs);
```

如果不释放 CS，Flash 可能卡在命令接收状态，下次启动时 JEDEC ID 返回 FF FF FF。

## 6. 软件复位（恢复 Flash 到已知状态）

某些 Flash 芯片可能卡在连续读模式（Continuous Read Mode）。启动时发送软件复位命令：

```c
void flash_software_reset(void)
{
    flash_cs_select();
    flash_xfer(0x66);  /* Enable Reset */
    flash_cs_deselect();
    up_udelay(1);

    flash_cs_select();
    flash_xfer(0x99);  /* Reset */
    flash_cs_deselect();
    up_mdelay(30);     /* 等待复位完成 */
}
```

## 7. 容量计算

从 JEDEC ID 的第三个字节计算容量：

```c
uint32_t flash_capacity_bytes(const uint8_t id[3])
{
    if (id[2] < 16 || id[2] > 30) return 0;
    return (uint32_t)(1UL << id[2]);
}
```

例如：
- `id[2] = 0x14` → 2^20 = 1MB
- `id[2] = 0x15` → 2^21 = 2MB
- `id[2] = 0x16` → 2^22 = 4MB

## 8. 调试决策树

### 8.1 JEDEC ID 返回 FF FF FF

```
JEDEC ID = FF FF FF
├── 检查 CS 引脚
│   ├── CS 是否配置为 GPIO 输出？
│   ├── CS 默认电平是否为高（空闲态）？
│   └── 用万用表测量 CS 引脚电平
├── 检查 SPI 总线
│   ├── SPI2 时钟门控是否使能？（CFG5 寄存器）
│   ├── 引脚复用是否正确？（GPIO64/65/66 → MAIN_FUNC）
│   └── SCK 是否有输出？（示波器）
├── 检查 Flash 状态
│   ├── 是否发送了软件复位命令？
│   ├── 上次运行是否正确释放了 CS？
│   └── Flash 是否卡在连续读模式？
└── 检查 DR 访问方式
    ├── 是否使用了 8 位访问？（SPI_REG8）
    └── 32 位访问会导致数据错位！
```

### 8.2 JEDEC ID 返回正确但擦除/写入失败

```
JEDEC ID 正确，但 verify 失败
├── 检查 Write Enable
│   ├── 擦除/写入前是否发送了 WREN？
│   └── WREN 后是否有 CS 高电平间隔？
├── 检查地址格式
│   ├── 地址是否为 3 字节？（24 位）
│   └── 字节序是否正确？（高字节先发）
├── 检查 wait_ready
│   ├── 是否等待了 WIP 位清零？
│   └── flash_read_status() 内部是否有 bus_reset？
└── 检查 CS 管理
    ├── flash 操作中途是否调用了 spi2_bus_reset()？
    └── bus_reset() 会切换 CS，中断 flash 操作！
```

### 8.3 第一次运行正常，第二次失败

```
首次正常，再次失败
├── 检查程序退出时是否释放了 CS
│   ├── 退出前是否调用了 spi2_bus_reset()？
│   └── CS 未释放会导致 Flash 卡死
├── 检查启动时是否发送了软件复位
│   ├── flash_software_reset() 是否在 JEDEC ID 读取前调用？
│   └── 复位后是否等待了 30ms？
└── 检查 DR 访问方式
    ├── 32 位访问可能在某些操作中不报错但在其他操作中失败
    └── 统一使用 8 位访问
```

### 8.4 通用问题

- **编译报错 undefined reference**：检查 defconfig 中 `CONFIG_LS2K0300_SPI=y` 和 `CONFIG_LS2K0300_SPIIO2=y` 是否启用
- **设备节点不存在**：检查 bringup.c 中是否调用了 `ls2k0300_spiio_initialize(0)`
- **引脚冲突**：GPIO67 是 ADC CS，GPIO85 是 Flash CS，不要混淆

## 9. 完整初始化流程

```c
int test_spiflash(void)
{
    uint8_t id[3];

    /* 1. 初始化 GPIO */
    g_fd_flash_cs = gpio_open_output(FLASH_CS_PIN);

    /* 2. 初始化 SPI2 控制器 */
    spi2_init();
    up_mdelay(20);

    /* 3. 重置总线 + 软件复位 Flash */
    spi2_bus_reset();
    flash_software_reset();
    spi2_bus_reset();

    /* 4. 读取 JEDEC ID */
    flash_read_jedec_id(id);
    if (!flash_id_valid(id)) {
        printf("Flash not found!\n");
        goto cleanup;
    }

    /* 5. 读取当前内容 */
    flash_read_data(addr, buf, len);

    /* 6. 等待用户操作... */

    /* 7. 退出前清理 */
cleanup:
    spi2_bus_reset();  /* 释放 CS */
    close(g_fd_flash_cs);
}
```


---

## 10. 完整模板代码（Template Source）

> 以下为经过验证、可直接使用的驱动模板源码（原 `assets/spi_flash_template.c`）。
> 寄存器访问位宽（8/32 位）、时序控制（如 SPI EOT 等待）、片选（CS）管理、
> OE 低有效等逻辑均已验证，请勿随意修改核心实现。编写驱动时以此为骨架，
> 将占位符替换为实际值即可。

```c
/****************************************************************************
 * spi_flash_template.c (已内联于本文档"完整模板代码"章节)
 *
 * SPI Flash 驱动模板 - 基于 LS2K0300 硬件 SPI2 控制器
 *
 * Hummingbird 2K0300 板 SPI Flash 接线（LOONG-HAT 40PIN）：
 *   - SPI2_CLK:  GPIO64 (MAIN_FUNC) - J12 Pin23
 *   - SPI2_MISO: GPIO65 (MAIN_FUNC) - J12 Pin21
 *   - SPI2_MOSI: GPIO66 (MAIN_FUNC) - J12 Pin19
 *   - Flash CS:  GPIO85 (GPIO, 软件片选) - J12 Pin26
 *   - SPI2 基地址: 0x1610c000
 *   - APB 时钟: 200MHz
 *
 * 关键设计原则：
 *   1. DR 寄存器必须用 8 位访问（SPI_REG8），不能用 32 位（SPI_REG32）
 *   2. 每次传输必须等待 EOT 标志
 *   3. Flash 操作（erase/program）期间不能调用 spi2_bus_reset()
 *   4. 程序退出前必须释放 CS，否则 flash 可能卡死
 *   5. 启动时发送软件复位命令，恢复 flash 到已知状态
 ****************************************************************************/

#include <nuttx/config.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <stdint.h>

#include <nuttx/ioexpander/gpio.h>
#include <nuttx/arch.h>

/****************************************************************************
 * Pre-processor Definitions
 ****************************************************************************/

/* SPI2 控制器基地址 */

#define SPI2_BASE               (0x8000000000000000UL | 0x1610c000UL)

/* GENERAL_CFG5: SPI2/3 时钟门控 */

#define LS_GENERAL_CFG5_ADDR    (0x8000000000000000UL | 0x16000114UL)

/* SPI IO 寄存器偏移（LS2K0300 手册 ch.10） */

#define LS_SPI_IO_CR1           0x00
#define LS_SPI_IO_CR3           0x08
#define LS_SPI_IO_CR4           0x0c
#define LS_SPI_IO_SR1           0x14
#define LS_SPI_IO_CFG1          0x20
#define LS_SPI_IO_CFG2          0x24
#define LS_SPI_IO_CFG3          0x28
#define LS_SPI_IO_DR            0x40

/* CR1 位 */

#define LS_SPI_CR1_SPE          (1U << 0)
#define LS_SPI_CR1_CSTART       (1U << 1)
#define LS_SPI_CR1_AUTOSUS      (1U << 2)

/* CFG1: 8-bit 帧，SPI Mode 0 */

#define LS_SPI_CFG1_DSIZE_8BIT  (7U << 8)

/* CFG2: 波特率分频 */

#define LS_SPI_CFG2_BRINT_SHIFT 8

/* CFG3: 主模式、全双工、软件 CS */

#define LS_SPI_CFG3_MSTR        (1U << 0)
#define LS_SPI_CFG3_DIE         (1U << 2)
#define LS_SPI_CFG3_DOE         (1U << 3)
#define LS_SPI_CFG3_SSMODE_SW   (1U << 8)

/* SR1 状态位 */

#define LS_SPI_SR1_RXA          (1U << 0)
#define LS_SPI_SR1_TXA          (1U << 1)
#define LS_SPI_SR1_RXE          (1U << 4)
#define LS_SPI_SR1_EOT          (1U << 15)

#define LS_SPI_SR1_W1C_FLAGS    (LS_SPI_SR1_EOT | (1U << 11) | \
                                 (1U << 10) | (1U << 9) | (1U << 8))

/* 时钟配置 */

#define SPI_APB_HZ              (200UL * 1000000UL)
#define SPI_CLOCK_HZ            1000000UL
#define SPI_WAIT_TIMEOUT_US     10000U

/* Flash CS 引脚 */

#define FLASH_CS_PIN            85

/* SPI Flash 命令 */

#define SPIFLASH_CMD_WRITE_ENABLE     0x06
#define SPIFLASH_CMD_READ_STATUS      0x05
#define SPIFLASH_CMD_READ_JEDEC_ID    0x9f
#define SPIFLASH_CMD_READ_DATA        0x03
#define SPIFLASH_CMD_PAGE_PROGRAM     0x02
#define SPIFLASH_CMD_SECTOR_ERASE_4K  0x20
#define SPIFLASH_CMD_ENABLE_RESET     0x66
#define SPIFLASH_CMD_RESET            0x99
#define SPIFLASH_STATUS_WIP           0x01

/* Flash 参数 */

#define SPIFLASH_SECTOR_SIZE          4096U

/* 寄存器访问宏（⚠️ DR 必须用 8 位访问） */

#define SPI_REG32(off)  (*(volatile uint32_t *)(SPI2_BASE + (off)))
#define SPI_REG8(off)   (*(volatile uint8_t *)(SPI2_BASE + (off)))
#define CFG5_REG        (*(volatile uint32_t *)LS_GENERAL_CFG5_ADDR)

/****************************************************************************
 * Private Data
 ****************************************************************************/

static int g_fd_flash_cs = -1;

/****************************************************************************
 * Name: spi2_bus_reset
 *
 * Description:
 *   重置 SPI 总线状态。用于设备切换或错误恢复。
 *   ⚠️ 不要在 flash 操作（erase/program/read）中途调用！
 *      这会切换 CS 电平，中断正在进行的 flash 操作。
 *
 *   正确用法：仅在顶层操作入口调用，如：
 *   - 程序初始化时
 *   - ADC 读取后、Flash 操作前
 *   - 程序退出前
 ****************************************************************************/

static void spi2_bus_reset(void)
{
  uint32_t val;
  uint32_t i;

  val = SPI_REG32(LS_SPI_IO_CR1);
  val &= ~(LS_SPI_CR1_CSTART | LS_SPI_CR1_AUTOSUS);
  SPI_REG32(LS_SPI_IO_CR1) = val;

  SPI_REG32(LS_SPI_IO_CR4) = 0;
  SPI_REG32(LS_SPI_IO_CR3) = 0;
  up_udelay(10);

  SPI_REG32(LS_SPI_IO_SR1) = LS_SPI_SR1_W1C_FLAGS;

  for (i = 0; i < 4; i++)
    {
      if (SPI_REG32(LS_SPI_IO_SR1) & LS_SPI_SR1_RXE)
        {
          break;
        }

      (void)SPI_REG8(LS_SPI_IO_DR);  /* ⚠️ 8 位读取 */
    }

  SPI_REG32(LS_SPI_IO_CR1) = LS_SPI_CR1_SPE;
  ioctl(g_fd_flash_cs, GPIOC_WRITE, 1);  /* 释放 CS */
  up_udelay(10);
}

/****************************************************************************
 * Name: spi2_abort
 *
 * Description:
 *   传输超时时中止当前操作，释放 CS。
 ****************************************************************************/

static void spi2_abort(void)
{
  uint32_t val;
  uint32_t i;

  val = SPI_REG32(LS_SPI_IO_CR1);
  val &= ~(LS_SPI_CR1_CSTART | LS_SPI_CR1_AUTOSUS);
  SPI_REG32(LS_SPI_IO_CR1) = val;

  SPI_REG32(LS_SPI_IO_CR4) = 0;
  SPI_REG32(LS_SPI_IO_CR3) = 0;
  up_udelay(10);

  SPI_REG32(LS_SPI_IO_SR1) = LS_SPI_SR1_W1C_FLAGS;

  for (i = 0; i < 4; i++)
    {
      if (SPI_REG32(LS_SPI_IO_SR1) & LS_SPI_SR1_RXE)
        {
          break;
        }

      (void)SPI_REG8(LS_SPI_IO_DR);
    }

  ioctl(g_fd_flash_cs, GPIOC_WRITE, 1);
  up_udelay(1);
}

/****************************************************************************
 * Name: spi2_xfer_byte
 *
 * Description:
 *   单字节 SPI 全双工传输。
 *   ⚠️ DR 寄存器必须用 8 位访问！32 位访问会导致数据错位。
 *   ⚠️ 必须等待 EOT 标志，不能只等 RXA。
 ****************************************************************************/

static int spi2_xfer_byte(uint8_t tx, uint8_t *rx)
{
  uint32_t val;
  uint32_t sr1;
  uint32_t i;

  /* 1. 使能 SPI */

  val = SPI_REG32(LS_SPI_IO_CR1);
  val |= LS_SPI_CR1_SPE;
  SPI_REG32(LS_SPI_IO_CR1) = val;

  /* 2. 清 CSTART/AUTOSUS */

  val = SPI_REG32(LS_SPI_IO_CR1);
  val &= ~(LS_SPI_CR1_CSTART | LS_SPI_CR1_AUTOSUS);
  SPI_REG32(LS_SPI_IO_CR1) = val;

  /* 3. 清 W1C 状态标志 */

  SPI_REG32(LS_SPI_IO_SR1) = LS_SPI_SR1_W1C_FLAGS;

  /* 4. TSIZE = 0（单帧） */

  SPI_REG32(LS_SPI_IO_CR3) = 0;

  /* 5. 等待 TX FIFO 可写 */

  for (i = 0; i < SPI_WAIT_TIMEOUT_US; i++)
    {
      sr1 = SPI_REG32(LS_SPI_IO_SR1);
      if (sr1 & LS_SPI_SR1_TXA)
        {
          break;
        }

      up_udelay(1);
    }

  if (i >= SPI_WAIT_TIMEOUT_US)
    {
      spi2_abort();
      return -1;
    }

  /* 6. 写入 TX 字节（⚠️ 8 位写入！） */

  SPI_REG8(LS_SPI_IO_DR) = tx;

  /* 7. 启动传输：只置 CSTART，不置 AUTOSUS */

  val = SPI_REG32(LS_SPI_IO_CR1);
  val |= LS_SPI_CR1_CSTART;
  SPI_REG32(LS_SPI_IO_CR1) = val;

  /* 8. 等待 EOT（传输结束标志） */

  for (i = 0; i < SPI_WAIT_TIMEOUT_US; i++)
    {
      sr1 = SPI_REG32(LS_SPI_IO_SR1);
      if (sr1 & LS_SPI_SR1_EOT)
        {
          break;
        }

      up_udelay(1);
    }

  if (i >= SPI_WAIT_TIMEOUT_US)
    {
      spi2_abort();
      return -1;
    }

  /* 9. 清除 EOT */

  SPI_REG32(LS_SPI_IO_SR1) = LS_SPI_SR1_EOT;

  /* 10. 等待 RX FIFO 有数据 */

  for (i = 0; i < SPI_WAIT_TIMEOUT_US; i++)
    {
      sr1 = SPI_REG32(LS_SPI_IO_SR1);
      if (sr1 & LS_SPI_SR1_RXA)
        {
          break;
        }

      up_udelay(1);
    }

  if (i >= SPI_WAIT_TIMEOUT_US)
    {
      spi2_abort();
      return -1;
    }

  /* 11. 读取 RX 字节（⚠️ 8 位读取！） */

  if (rx != NULL)
    {
      *rx = SPI_REG8(LS_SPI_IO_DR);
    }
  else
    {
      (void)SPI_REG8(LS_SPI_IO_DR);
    }

  return 0;
}

/****************************************************************************
 * Name: spi2_init
 *
 * Description:
 *   初始化 SPI2 控制器和 Flash CS GPIO。
 ****************************************************************************/

static int spi2_init(void)
{
  uint32_t brint;
  int ret;

  /* CS GPIO 初始化 */

  ret = pinctrl_set_gpio_function(FLASH_CS_PIN);
  if (ret < 0)
    {
      printf("[SPIFLASH] ERROR: pinctrl GPIO%d: %d\n", FLASH_CS_PIN, ret);
      return ret;
    }

  char path[32];
  snprintf(path, sizeof(path), "/dev/gpio%d", FLASH_CS_PIN);
  g_fd_flash_cs = open(path, O_RDWR);
  if (g_fd_flash_cs < 0)
    {
      return -errno;
    }

  ret = ioctl(g_fd_flash_cs, GPIOC_SETPINTYPE, (unsigned long)GPIO_OUTPUT_PIN);
  if (ret < 0)
    {
      return -errno;
    }

  ioctl(g_fd_flash_cs, GPIOC_WRITE, 1);  /* CS 高（空闲） */

  /* 使能 SPI2/3 时钟门控 */

  CFG5_REG |= (0x3u << 17);

  /* CFG3: 主模式、全双工、软件 CS */

  SPI_REG32(LS_SPI_IO_CFG3) = LS_SPI_CFG3_MSTR | LS_SPI_CFG3_DIE |
                               LS_SPI_CFG3_DOE | LS_SPI_CFG3_SSMODE_SW;

  /* CFG1: 8-bit 帧，SPI Mode 0 */

  SPI_REG32(LS_SPI_IO_CFG1) = LS_SPI_CFG1_DSIZE_8BIT;

  /* CFG2: 波特率分频 */

  brint = SPI_APB_HZ / SPI_CLOCK_HZ;
  if (brint < 2) brint = 2;
  if (brint > 255) brint = 255;
  SPI_REG32(LS_SPI_IO_CFG2) = brint << LS_SPI_CFG2_BRINT_SHIFT;

  /* CR1: 使能 SPI */

  SPI_REG32(LS_SPI_IO_CR1) = LS_SPI_CR1_SPE;

  ioctl(g_fd_flash_cs, GPIOC_WRITE, 1);
  up_udelay(10);

  return OK;
}

/****************************************************************************
 * Flash 底层操作
 ****************************************************************************/

static void flash_cs_select(void)
{
  ioctl(g_fd_flash_cs, GPIOC_WRITE, 0);
  up_udelay(1);
}

static void flash_cs_deselect(void)
{
  ioctl(g_fd_flash_cs, GPIOC_WRITE, 1);
  up_udelay(10);  /* flash 需要较长的 CS 高电平时间 */
}

static uint8_t flash_xfer(uint8_t tx)
{
  uint8_t rx = 0;
  spi2_xfer_byte(tx, &rx);
  return rx;
}

/****************************************************************************
 * Name: flash_software_reset
 *
 * Description:
 *   发送软件复位命令，恢复 flash 到已知状态。
 *   必须在程序启动时调用，防止上次运行残留的脏状态。
 ****************************************************************************/

static void flash_software_reset(void)
{
  flash_cs_select();
  flash_xfer(SPIFLASH_CMD_ENABLE_RESET);
  flash_cs_deselect();
  up_udelay(1);

  flash_cs_select();
  flash_xfer(SPIFLASH_CMD_RESET);
  flash_cs_deselect();
  up_mdelay(30);  /* flash 复位需要约 30ms */
}

static void flash_read_jedec_id(uint8_t id[3])
{
  flash_cs_select();
  flash_xfer(SPIFLASH_CMD_READ_JEDEC_ID);
  id[0] = flash_xfer(0xff);
  id[1] = flash_xfer(0xff);
  id[2] = flash_xfer(0xff);
  flash_cs_deselect();
}

static uint8_t flash_read_status(void)
{
  uint8_t status;

  flash_cs_select();
  flash_xfer(SPIFLASH_CMD_READ_STATUS);
  status = flash_xfer(0xff);
  flash_cs_deselect();

  return status;
}

static void flash_write_enable(void)
{
  flash_cs_select();
  flash_xfer(SPIFLASH_CMD_WRITE_ENABLE);
  flash_cs_deselect();
  up_udelay(1);
}

static int flash_wait_ready(FAR const char *op)
{
  uint8_t status;
  int i;

  for (i = 0; i < 500; i++)
    {
      status = flash_read_status();
      if ((status & SPIFLASH_STATUS_WIP) == 0)
        {
          return OK;
        }

      up_mdelay(10);
    }

  printf("[SPIFLASH] %s timeout, status=0x%02x\n", op, status);
  return -ETIMEDOUT;
}

static int flash_sector_erase(uint32_t addr)
{
  flash_write_enable();

  flash_cs_select();
  flash_xfer(SPIFLASH_CMD_SECTOR_ERASE_4K);
  flash_xfer((uint8_t)(addr >> 16));
  flash_xfer((uint8_t)(addr >> 8));
  flash_xfer((uint8_t)addr);
  flash_cs_deselect();

  return flash_wait_ready("erase");
}

static int flash_page_program(uint32_t addr, FAR const uint8_t *data,
                              uint32_t len)
{
  uint32_t i;

  flash_write_enable();

  flash_cs_select();
  flash_xfer(SPIFLASH_CMD_PAGE_PROGRAM);
  flash_xfer((uint8_t)(addr >> 16));
  flash_xfer((uint8_t)(addr >> 8));
  flash_xfer((uint8_t)addr);

  for (i = 0; i < len; i++)
    {
      flash_xfer(data[i]);
    }

  flash_cs_deselect();

  return flash_wait_ready("program");
}

static void flash_read_data(uint32_t addr, FAR uint8_t *data, uint32_t len)
{
  uint32_t i;

  flash_cs_select();
  flash_xfer(SPIFLASH_CMD_READ_DATA);
  flash_xfer((uint8_t)(addr >> 16));
  flash_xfer((uint8_t)(addr >> 8));
  flash_xfer((uint8_t)addr);

  for (i = 0; i < len; i++)
    {
      data[i] = flash_xfer(0xff);
    }

  flash_cs_deselect();
}

```
