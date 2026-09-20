# SPI ADC 驱动设计文档（MCP3204 范例）

## 1. 功能概述

通过硬件 SPI 控制器读取 MCP3204 12 位 ADC 的模拟电压值。

### MCP3204 特性
- 12 位 SAR ADC
- 4 通道单端输入（CH0~CH3）
- SPI 接口，最高 1.2MHz
- 参考电压 VREF 由外部提供

## 2. 板级配置（必须先完成）

### 2.1 引脚复用

在 `nuttx/boards/loongarch/ls2k0300/hummingbird-ls2k0300/src/ls2k0300_bringup.c` 的
`ls2k0300_hardware_init()` 中添加：

```c
/* SPI2: GPIO64/65/66 → MAIN_FUNC, GPIO67 → GPIO(软件CS) */
ls_pinmux_pin_setup(64, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(65, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(66, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(67, LS_PINMUX_MODE_AS_GPIO);
```

### 2.2 Kconfig 使能

在 `nuttx/boards/loongarch/ls2k0300/hummingbird-ls2k0300/configs/nsh/defconfig` 中添加：

```
CONFIG_LS2K0300_SPI=y
CONFIG_LS2K0300_SPIIO2=y
```

## 3. SPI 时序要求

### 3.1 SPI 模式

MCP3204 使用 **SPI Mode 0**（CPOL=0, CPHA=0）：
- 空闲时 SCK 为低电平
- 数据在 SCK 上升沿采样
- 数据在 SCK 下降沿变化

### 3.2 传输时序

```
CS:  ‾‾‾\___________________________________/‾‾‾
SCK: ____|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|____
MOSI:    |S|D|D|D|D|D|D|D|D|x|x|x|x|x|x|x|x|
MISO:    |x|N|D11|D10|D9|D8|D7|D6|D5|D4|D3|D2|D1|D0|x|x|
```

### 3.3 命令字节格式

| 字节 | 内容 | 说明 |
|------|------|------|
| Byte 1 | `0x06` | Start bit=1, Single-ended=1, D2=0 |
| Byte 2 | `channel << 6` | D2=0, D1/D0=通道号 |
| Byte 3 | `0x00` | 无关紧要，用于接收数据 |

### 3.4 接收数据格式

| 字节 | 位内容 |
|------|--------|
| Byte 1 响应 | `null, D11, D10, D9, D8, D7, D6, D5`（延迟 1 位） |
| Byte 2 响应 | `D5, D4, D3, D2, D1, D0, x, x` |
| Byte 3 响应 | 无效数据 |

**注意**：硬件 SPI 存在 1 位流水线延迟，第一个字节的响应在第二个字节传输时才读出。

## 4. 硬件 SPI 控制器配置

### 4.1 初始化流程

```c
/* Step 1: 使能 SPI 时钟门控 */
CFG5_REG |= (0x3u << 17);

/* Step 2: 配置 CFG3 - 主模式、全双工、软件 CS */
SPI_REG32(CFG3_OFFSET) = MSTR | DIE | DOE | SSMODE_SW;

/* Step 3: 配置 CFG1 - 8-bit 帧、SPI Mode 0 */
SPI_REG32(CFG1_OFFSET) = DSIZE_8BIT;

/* Step 4: 配置 CFG2 - 波特率分频 */
uint32_t brint = APB_HZ / TARGET_CLOCK_HZ;
SPI_REG32(CFG2_OFFSET) = brint << BRINT_SHIFT;

/* Step 5: 使能 SPI */
SPI_REG32(CR1_OFFSET) = SPE;
```

### 4.2 单字节传输函数

```c
static int spi_xfer_byte(uint8_t tx, uint8_t *rx)
{
  uint32_t val, sr1;
  uint32_t i;

  /* 1. 使能 SPI */
  val = SPI_REG32(CR1_OFFSET);
  val |= SPE;
  SPI_REG32(CR1_OFFSET) = val;

  /* 2. 终止挂起的传输 */
  val = SPI_REG32(CR1_OFFSET);
  val &= ~(CSTART | AUTOSUS);
  SPI_REG32(CR1_OFFSET) = val;

  /* 3. 清空 FIFO */
  SPI_REG32(CR4_OFFSET) = 0;
  SPI_REG32(CR3_OFFSET) = 0;
  up_udelay(5);

  /* 4. 清除状态标志 */
  SPI_REG32(SR1_OFFSET) = W1C_FLAGS;
  up_udelay(1);

  /* 5. 排空 RXFIFO */
  for (i = 0; i < 4; i++)
    {
      sr1 = SPI_REG32(SR1_OFFSET);
      if (sr1 & RXE) break;
      (void)SPI_REG8(DR_OFFSET);   /* ⚠️ 8 位读取 */
    }

  /* 6. 发送数据 */
  SPI_REG32(CR3_OFFSET) = 0;
  SPI_REG8(DR_OFFSET) = tx;        /* ⚠️ 8 位写入 */

  /* 7. 启动传输 */
  val = SPI_REG32(CR1_OFFSET);
  val |= CSTART;
  SPI_REG32(CR1_OFFSET) = val;

  /* 8. 等待 EOT（传输结束） */
  for (i = 0; i < TIMEOUT_US; i++)
    {
      sr1 = SPI_REG32(SR1_OFFSET);
      if (sr1 & EOT)
        {
          SPI_REG32(SR1_OFFSET) = EOT;  /* 清除 EOT */
          break;
        }
      up_udelay(1);
    }
  if (i >= TIMEOUT_US) goto abort;

  /* 9. 等待 RX 数据 */
  for (i = 0; i < TIMEOUT_US; i++)
    {
      sr1 = SPI_REG32(SR1_OFFSET);
      if (sr1 & RXA)
        {
          if (rx) *rx = SPI_REG8(DR_OFFSET);   /* ⚠️ 8 位读取 */
          else     (void)SPI_REG8(DR_OFFSET);

          val = SPI_REG32(CR1_OFFSET);
          val &= ~(CSTART | AUTOSUS);
          SPI_REG32(CR1_OFFSET) = val;
          return 0;
        }
      up_udelay(1);
    }

abort:
  spi_abort();
  return -1;
}
```

### 4.3 关键注意事项

> ⚠️ **DR 寄存器必须用 8 位访问**：`SPI_REG8(DR_OFFSET)`，不能用 `SPI_REG32`。
> 32 位访问会一次读走 4 字节，破坏 FIFO 顺序，导致后续数据全部错乱。
> 其他寄存器（CR1/CFG/SR1 等）用 32 位访问没问题。

> ⚠️ **必须先等 EOT 再等 RXA**：启动传输后必须先等到 EOT（End Of Transfer）标志，
> 再等 RXA（接收数据可用），最后才能读 DR。只等 RXA 会导致时序不稳定。

## 5. 片选（CS）控制

使用 GPIO 软件控制 CS：

```c
/* CS 拉低 - 开始传输 */
ioctl(cs_fd, GPIOC_WRITE, 0);
up_udelay(1);

/* 执行 SPI 传输 */
spi_xfer_byte(tx1, NULL);
spi_xfer_byte(tx2, &rx_hi);
spi_xfer_byte(tx3, &rx_lo);

/* CS 拉高 - 结束传输 */
ioctl(cs_fd, GPIOC_WRITE, 1);
up_udelay(1);
```

## 6. MCP3204 读取完整流程

```c
int mcp3204_read(uint8_t channel, uint16_t *raw)
{
  uint8_t rx_hi = 0, rx_lo = 0;

  /* CS 低 */
  ioctl(cs_fd, GPIOC_WRITE, 0);
  up_udelay(1);

  /* 发送 3 字节命令 */
  if (spi_xfer_byte(0x06, NULL) != 0 ||               /* Start + Single-ended */
      spi_xfer_byte((channel << 6), &rx_hi) != 0 ||   /* 通道号 */
      spi_xfer_byte(0x00, &rx_lo) != 0)               /* 接收数据 */
    {
      ioctl(cs_fd, GPIOC_WRITE, 1);
      return -1;
    }

  /* CS 高 */
  ioctl(cs_fd, GPIOC_WRITE, 1);
  up_udelay(1);

  /* 过滤无效数据 */
  if (rx_hi == 0xff || rx_lo == 0xff)
    return -1;

  /* 提取 12 位 ADC 值 */
  *raw = ((uint16_t)(rx_hi & 0x0F) << 8) | rx_lo;
  return 0;
}
```

## 7. 电压换算

```c
uint32_t adc_to_voltage_mv(uint16_t raw, uint32_t vref_mv)
{
  return ((uint32_t)raw * vref_mv + (ADC_MAX / 2)) / ADC_MAX;
}
```

> ⚠️ **使用整数运算**：LoongArch 默认无 FPU，禁止使用 float/double。

## 8. 防误码与重试

```c
int mcp3204_read_average(uint8_t channel, uint16_t *raw, int samples)
{
  uint32_t sum = 0;
  int valid = 0;

  for (int i = 0; i < samples * 8; i++)  /* 最多重试 8 倍 */
    {
      uint16_t value;
      if (mcp3204_read(channel, &value) != 0)
        {
          up_mdelay(2);
          continue;  /* 跳过坏数据，继续采样 */
        }

      sum += value;
      if (++valid >= samples)
        break;

      up_mdelay(2);
    }

  if (valid == 0) return -1;

  *raw = (sum + valid / 2) / valid;
  return 0;
}
```

## 9. 调试技巧

1. **所有读取返回 0xff**：
   - 检查 SPI 时钟门控是否使能（CFG5）
   - 检查引脚复用是否配置为 SPI 功能
   - 确认 `spi_xfer_byte` 包含超时 fallback 代码
   - 确认 DR 寄存器使用了 8 位访问（SPI_REG8）

2. **读数不随输入变化**：
   - 检查 CS 是否正确控制（GPIO 方向、电平）
   - 用示波器观察 SCK/MOSI/MISO 波形

3. **读数偏差较大**：
   - 检查 VREF 电压是否稳定
   - 增加采样平均次数
   - 添加 0xff 过滤逻辑

4. **编译报错 undefined reference**：
   - 检查头文件路径是否正确
   - 检查 ioctl 宏名（I2CIOC_TRANSFER vs I2C_TRANSFER）
   - 检查 defconfig 中对应的 CONFIG 是否使能

5. **设备节点不存在（open 失败）**：
   - 检查 defconfig 中对应的 CONFIG 是否使能
   - 检查 bringup.c 中是否注册了该外设
   - 检查是否遗漏了 `CONFIG_I2C_DRIVER=y`（I2C 设备必须）

6. **首次读取正常，后续读取全部失败（返回 0x00 或 0xff）**：
   - **根因**：DR 寄存器用了 32 位访问（`SPI_REG32`），一次读走 4 字节破坏 FIFO
   - **修复**：DR 寄存器必须用 `SPI_REG8`（8 位访问），其他寄存器不受影响
   - 验证方法：grep 源码确认所有 `LS_SPI_IO_DR` 访问都用 `SPI_REG8`

7. **读取数据不稳定，偶尔正确偶尔错误**：
   - **根因**：只等 RXA 没等 EOT（End Of Transfer），时序不确定
   - **修复**：启动传输后必须先等 EOT 标志，再等 RXA，最后读 DR
   - EOT 是传输完成的硬件保证，RXA 只表示 FIFO 有数据


---

## 10. 完整模板代码（Template Source）

> 以下为经过验证、可直接使用的驱动模板源码（原 `assets/spi_template.c`）。
> 寄存器访问位宽（8/32 位）、时序控制（如 SPI EOT 等待）、片选（CS）管理、
> OE 低有效等逻辑均已验证，请勿随意修改核心实现。编写驱动时以此为骨架，
> 将占位符替换为实际值即可。

```c
/****************************************************************************
 * spi_template.c (已内联于本文档"完整模板代码"章节)
 *
 * 硬件 SPI 驱动模板 - SPI 读写接口封装
 *
 * Hummingbird 2K0300 板 SPI2 引脚：
 *   - SPI2_CLK:  GPIO64 (MAIN_FUNC)
 *   - SPI2_MISO: GPIO65 (MAIN_FUNC)
 *   - SPI2_MOSI: GPIO66 (MAIN_FUNC)
 *   - CSN1:      GPIO67 (GPIO, 软件片选)
 *   - SPI2 基地址: 0x1610c000
 *   - APB 时钟: 200MHz
 *
 * 使用说明：
 *   1. 引脚复用在 ls2k0300_bringup.c 中已配置
 *   2. CS_PIN 已设为 GPIO67
 *   3. 根据从设备要求调整 SPI 模式（CPOL/CPHA）
 ****************************************************************************/

#include <nuttx/config.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdint.h>

#include <nuttx/arch.h>
#include <nuttx/ioexpander/gpio.h>

/* Hummingbird 2K0300 板 SPI2 配置 */

#define SPI_BASE_PHYS       0x1610c000UL
#define SPI_BASE            (0x8000000000000000UL | SPI_BASE_PHYS)
#define CS_PIN              67               /* GPIO67 = MCP3204 软件片选 */
#define APB_HZ              (200UL * 1000000UL)
#define SPI_CLOCK_HZ        1000000UL        /* MCP3204 最大 1.2MHz */

/* GENERAL_CFG5: SPI2/3 时钟门控寄存器 */
#define GENERAL_CFG5_ADDR   (0x8000000000000000UL | 0x16000114UL)
#define CFG5_REG            (*(volatile uint32_t *)GENERAL_CFG5_ADDR)
#define SPI_WAIT_TIMEOUT_US 10000U

/* SPI2 寄存器偏移（LS2K0300 通用） */

#define SPI_IO_CR1          0x00
#define SPI_IO_CR3          0x08
#define SPI_IO_CR4          0x0c
#define SPI_IO_SR1          0x14
#define SPI_IO_CFG1         0x20
#define SPI_IO_CFG2         0x24
#define SPI_IO_CFG3         0x28
#define SPI_IO_DR           0x40

/* CR1 位 */

#define SPI_CR1_SPE         (1U << 0)
#define SPI_CR1_CSTART      (1U << 1)
#define SPI_CR1_AUTOSUS     (1U << 2)

/* CFG1: 8-bit frame, Mode 0 */

#define SPI_CFG1_DSIZE_8BIT (7U << 8)

/* CFG3 */

#define SPI_CFG3_MSTR       (1U << 0)
#define SPI_CFG3_DIE        (1U << 2)
#define SPI_CFG3_DOE        (1U << 3)
#define SPI_CFG3_SSMODE_SW  (1U << 8)

/* SR1 */

#define SPI_SR1_RXA         (1U << 0)
#define SPI_SR1_TXA         (1U << 1)
#define SPI_SR1_RXE         (1U << 4)
#define SPI_SR1_EOT         (1U << 15)
#define SPI_SR1_W1C_FLAGS   (SPI_SR1_EOT | (1U << 11) | \
                             (1U << 10) | (1U << 9) | (1U << 8))

/* 寄存器访问（⚠️ DR 必须用 8 位访问，其他寄存器用 32 位） */

#define SPI_REG32(off)  (*(volatile uint32_t *)(SPI_BASE + (off)))
#define SPI_REG8(off)   (*(volatile uint8_t *)(SPI_BASE + (off)))

static int g_fd_cs = -1;

/****************************************************************************
 * Name: spi_init
 *
 * Description:
 *   初始化 SPI 控制器和 CS GPIO。
 ****************************************************************************/

int spi_init(void)
{
  uint32_t brint;
  int ret;

  /* CS GPIO 初始化 */

  ret = pinctrl_set_gpio_function(CS_PIN);
  if (ret < 0) return ret;

  g_fd_cs = open("/dev/gpio" __XSTRING(CS_PIN), O_RDWR);
  if (g_fd_cs < 0) return -errno;

  ret = ioctl(g_fd_cs, GPIOC_SETPINTYPE, (unsigned long)GPIO_OUTPUT_PIN);
  if (ret < 0) return -errno;

  ioctl(g_fd_cs, GPIOC_WRITE, 1);  /* CS 高（空闲） */

  /* 使能 SPI2/3 时钟门控 */
  CFG5_REG |= (0x3u << 17);

  /* CFG3: 主模式、全双工、软件 CS */

  SPI_REG32(SPI_IO_CFG3) = SPI_CFG3_MSTR | SPI_CFG3_DIE |
                            SPI_CFG3_DOE | SPI_CFG3_SSMODE_SW;

  /* CFG1: 8-bit 帧 */

  SPI_REG32(SPI_IO_CFG1) = SPI_CFG1_DSIZE_8BIT;

  /* CFG2: 波特率分频 */

  brint = APB_HZ / SPI_CLOCK_HZ;
  if (brint < 2) brint = 2;
  if (brint > 255) brint = 255;
  SPI_REG32(SPI_IO_CFG2) = brint << 8;

  /* CR1: 使能 SPI */

  SPI_REG32(SPI_IO_CR1) = SPI_CR1_SPE;

  printf("[SPI] Init done, base=0x%lx, sclk=%lu Hz\n",
         (unsigned long)SPI_BASE, (unsigned long)SPI_CLOCK_HZ);
  return 0;
}

/****************************************************************************
 * Name: spi_xfer_byte
 *
 * Description:
 *   单字节 SPI 传输（全双工）。
 *
 * Input Parameters:
 *   tx - 发送字节
 *   rx - 接收字节指针（可为 NULL）
 *
 * Returned Value:
 *   0 on success, -1 on timeout.
 ****************************************************************************/

int spi_xfer_byte(uint8_t tx, uint8_t *rx)
{
  uint32_t val;
  uint32_t sr1;
  uint32_t i;

  /* 1. 使能 SPI */

  val = SPI_REG32(SPI_IO_CR1);
  val |= SPI_CR1_SPE;
  SPI_REG32(SPI_IO_CR1) = val;

  /* 2. 终止待处理传输 */

  val = SPI_REG32(SPI_IO_CR1);
  val &= ~(SPI_CR1_CSTART | SPI_CR1_AUTOSUS);
  SPI_REG32(SPI_IO_CR1) = val;

  /* 3. 清除状态标志 */

  SPI_REG32(SPI_IO_SR1) = SPI_SR1_W1C_FLAGS;

  /* 4. TSIZE = 0（单帧） */

  SPI_REG32(SPI_IO_CR3) = 0;

  /* 5. 等待 TX FIFO 可写 */

  for (i = 0; i < SPI_WAIT_TIMEOUT_US; i++)
    {
      sr1 = SPI_REG32(SPI_IO_SR1);
      if (sr1 & SPI_SR1_TXA) break;
      up_udelay(1);
    }

  if (i >= SPI_WAIT_TIMEOUT_US) goto abort;

  /* 6. 写入 TX 字节（⚠️ 8 位写入！） */

  SPI_REG8(SPI_IO_DR) = tx;

  /* 7. 启动传输（只置 CSTART，不置 AUTOSUS） */

  val = SPI_REG32(SPI_IO_CR1);
  val |= SPI_CR1_CSTART;
  SPI_REG32(SPI_IO_CR1) = val;

  /* 8. 等待 EOT（传输结束标志） */

  for (i = 0; i < SPI_WAIT_TIMEOUT_US; i++)
    {
      sr1 = SPI_REG32(SPI_IO_SR1);
      if (sr1 & SPI_SR1_EOT) break;
      up_udelay(1);
    }

  if (i >= SPI_WAIT_TIMEOUT_US) goto abort;

  /* 9. 清除 EOT */

  SPI_REG32(SPI_IO_SR1) = SPI_SR1_EOT;

  /* 10. 等待 RX FIFO 有数据 */

  for (i = 0; i < SPI_WAIT_TIMEOUT_US; i++)
    {
      sr1 = SPI_REG32(SPI_IO_SR1);
      if (sr1 & SPI_SR1_RXA) break;
      up_udelay(1);
    }

  if (i >= SPI_WAIT_TIMEOUT_US) goto abort;

  /* 11. 读取 RX 字节（⚠️ 8 位读取！） */

  if (rx) *rx = SPI_REG8(SPI_IO_DR);
  else     (void)SPI_REG8(SPI_IO_DR);

  return 0;

abort:
  val = SPI_REG32(SPI_IO_CR1);
  val &= ~(SPI_CR1_CSTART | SPI_CR1_AUTOSUS);
  SPI_REG32(SPI_IO_CR1) = val;
  SPI_REG32(SPI_IO_CR4) = 0;
  SPI_REG32(SPI_IO_CR3) = 0;
  up_udelay(10);
  SPI_REG32(SPI_IO_SR1) = SPI_SR1_W1C_FLAGS;
  for (i = 0; i < 4; i++)
    {
      if (SPI_REG32(SPI_IO_SR1) & SPI_SR1_RXE) break;
      (void)SPI_REG8(SPI_IO_DR);
    }

  ioctl(g_fd_cs, GPIOC_WRITE, 1);
  up_udelay(1);
  return -1;
}

/****************************************************************************
 * Name: spi_cs_low / spi_cs_high
 *
 * Description:
 *   软件控制片选信号。
 ****************************************************************************/

void spi_cs_low(void)
{
  ioctl(g_fd_cs, GPIOC_WRITE, 0);
  up_udelay(1);
}

void spi_cs_high(void)
{
  ioctl(g_fd_cs, GPIOC_WRITE, 1);
  up_udelay(1);
}

/****************************************************************************
 * Name: spi_deinit
 ****************************************************************************/

void spi_deinit(void)
{
  if (g_fd_cs >= 0)
    {
      spi_cs_high();
      close(g_fd_cs);
      g_fd_cs = -1;
    }
}

```
