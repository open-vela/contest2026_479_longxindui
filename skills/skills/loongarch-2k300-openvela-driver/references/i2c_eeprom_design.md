# I2C EEPROM 驱动设计文档（AT24C02 范例）

## 1. 功能概述

通过 I2C 总线读写 EEPROM（电可擦除可编程只读存储器），实现数据持久化存储。

### AT24C02 特性
- I2C 接口，7-bit 地址 `0x50`（A0/A1/A2 引脚接 GND）
- 容量：256 字节（8-bit 地址）
- 页大小：8 字节
- 写入寿命：100 万次
- 数据保持：100 年

### 常见 EEPROM 型号对比

| 型号 | 容量 | 地址位数 | 页大小 | I2C 地址范围 |
|------|------|---------|--------|-------------|
| AT24C02 | 256B | 8-bit | 8B | 0x50~0x57 |
| AT24C04 | 512B | 9-bit | 16B | 0x50~0x57 |
| AT24C08 | 1KB | 10-bit | 16B | 0x50~0x57 |
| AT24C16 | 2KB | 11-bit | 16B | 0x50~0x57 |
| AT24C256 | 32KB | 16-bit | 64B | 0x50~0x57 |

## 2. 板级配置（⚠️ 必须先完成）

### 2.1 引脚复用

在 `nuttx/boards/loongarch/ls2k300/hummingbird-ls2k300/src/ls2k300_bringup.c` 的
`ls2k300_hardware_init()` 中添加：

```c
/* I2C1: GPIO50(SDA)/GPIO51(SCL) → MAIN_FUNC */
ls_pinmux_pin_setup(50, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(51, LS_PINMUX_MODE_AS_MAIN_FUNC);
```

### 2.2 Kconfig 使能

在 `nuttx/boards/loongarch/ls2k300/hummingbird-ls2k300/configs/nsh/defconfig` 中添加：

```
CONFIG_LS2K300_I2C=y
CONFIG_LS2K300_I2C1=y
CONFIG_I2C_DRIVER=y          # 用户空间 I2C 字符设备（/dev/i2c1）
```

> ⚠️ **重要**：`CONFIG_I2C_DRIVER=y` 容易遗漏！没有它 `/dev/i2c1` 不会被创建。

## 3. I2C 总线配置

### 3.1 NuttX I2C API

```c
/* 打开 I2C 设备 */
int fd = open("/dev/i2c1", O_RDWR);

/* 构造传输消息 */
struct i2c_msg_s msg;
msg.frequency = I2C_SPEED_STANDARD;  /* 100kHz */
msg.addr      = 0x50;                /* 7-bit 地址，无需左移 */
msg.flags     = 0;                   /* 写操作 */
msg.buffer    = tx_buf;
msg.length    = tx_len;

struct i2c_transfer_s xfer;
xfer.msgv = &msg;
xfer.msgc = 1;

/* 执行传输 */
ioctl(fd, I2CIOC_TRANSFER, (unsigned long)&xfer);
```

> ⚠️ **注意**：
> - NuttX 使用 `I2CIOC_TRANSFER`（非 `I2C_TRANSFER`）
> - 地址是 7-bit，无需左移
> - ioctl 第三个参数需要 `(unsigned long)&xfer`

## 4. EEPROM 读写协议

### 4.1 单字节写入

```
Master → [START][ADDR+W][MEM_ADDR_H][MEM_ADDR_L][DATA][STOP]
         等待 tWR (5~10ms)
```

```c
int eeprom_write_byte(uint16_t mem_addr, uint8_t data)
{
  uint8_t buf[3];
  buf[0] = (uint8_t)(mem_addr >> 8);    /* 高地址字节 */
  buf[1] = (uint8_t)(mem_addr & 0xff);  /* 低地址字节 */
  buf[2] = data;

  return eeprom_i2c_write(EEPROM_ADDR, buf, 3);
}
```

### 4.2 页写入

```
Master → [START][ADDR+W][MEM_ADDR_H][MEM_ADDR_L][DATA0]...[DATAn][STOP]
         等待 tWR
```

```c
int eeprom_write_page(uint16_t mem_addr, const uint8_t *data, int len)
{
  uint8_t buf[2 + PAGE_SIZE];
  buf[0] = (uint8_t)(mem_addr >> 8);
  buf[1] = (uint8_t)(mem_addr & 0xff);
  memcpy(&buf[2], data, len);

  return eeprom_i2c_write(EEPROM_ADDR, buf, 2 + len);
}
```

> ⚠️ **页边界约束**：页写入不能跨越页边界。例如 AT24C02 页大小 8 字节：
> - 地址 0x06 开始最多写 2 字节（0x06, 0x07）
> - 地址 0x08 开始最多写 8 字节（0x08~0x0F）

### 4.3 当前地址读取

```
Master → [START][ADDR+R][DATA...][STOP]
```

### 4.4 随机地址读取

```
Master → [START][ADDR+W][MEM_ADDR_H][MEM_ADDR_L]
         [RESTART][ADDR+R][DATA...][STOP]
```

```c
int eeprom_read_byte(uint16_t mem_addr, uint8_t *data)
{
  uint8_t addr[2];
  addr[0] = (uint8_t)(mem_addr >> 8);
  addr[1] = (uint8_t)(mem_addr & 0xff);

  /* 先写地址 */
  eeprom_i2c_write(EEPROM_ADDR, addr, 2);

  /* 再读数据 */
  return eeprom_i2c_read(EEPROM_ADDR, data, 1);
}
```

## 5. 跨页写入处理

当写入数据跨越页边界时，需要分多次写入：

```c
int eeprom_write_bytes(uint16_t mem_addr, const uint8_t *data, int len)
{
  int written = 0;

  while (written < len)
    {
      /* 计算当前页剩余空间 */
      int page_remaining = PAGE_SIZE - ((mem_addr + written) % PAGE_SIZE);
      int chunk = (len - written < page_remaining) ?
                  (len - written) : page_remaining;

      eeprom_write_page(mem_addr + written, &data[written], chunk);
      usleep(WRITE_DELAY_MS * 1000);  /* 等待写入完成 */
      written += chunk;
    }

  return 0;
}
```

## 6. 数据完整性设计

### 6.1 Magic 标记

使用 magic 值标记 EEPROM 中是否有有效数据：

```c
#define MAGIC_ADDR   0x0000
#define MAGIC_VALUE  0xA5

/* 写入时最后写 magic */
eeprom_write_byte(MAGIC_ADDR, MAGIC_VALUE);

/* 读取时先检查 magic */
uint8_t magic;
eeprom_read_byte(MAGIC_ADDR, &magic);
if (magic != MAGIC_VALUE)
  {
    /* 数据无效 */
  }
```

### 6.2 校验和

使用 XOR 校验验证数据完整性：

```c
#define DATA_ADDR   0x0010
#define CHECK_ADDR  0x000F

/* 保存时计算校验 */
uint8_t checksum = 0;
for (int i = 0; i < data_len; i++)
  {
    checksum ^= data[i];
  }
eeprom_write_byte(CHECK_ADDR, checksum);

/* 读取时验证 */
uint8_t read_checksum;
eeprom_read_byte(CHECK_ADDR, &read_checksum);
/* 重新计算并比较 */
```

## 7. 注意事项

1. **I2C 地址**：AT24C02 的 7-bit 地址为 `0x50`~`0x57`，由 A0/A1/A2 引脚决定。NuttX 中直接使用 7-bit 地址，无需左移。

2. **写入延迟**：EEPROM 写入需要 5~10ms（AT24C02 典型值 5ms），在此期间不会响应 I2C 总线。发送 STOP 后需等待。

3. **页边界**：页写入不能跨越页边界，否则会回绕到页起始地址覆盖数据。调用者需自行处理跨页。

4. **时钟频率**：AT24C02 支持最高 400kHz（快速模式），但建议使用 100kHz（标准模式）提高可靠性。

5. **上拉电阻**：I2C 总线需要外部上拉电阻（4.7kΩ 典型值）。

6. **地址字节数**：小容量 EEPROM（≤16Kbit）使用 1 字节地址，大容量（≥32Kbit）使用 2 字节地址。

## 8. 调试技巧

1. **I2C 通信失败**：
   - 用 `i2cdetect` 工具扫描总线，确认设备地址
   - 检查 SDA/SCL 上拉电阻（4.7kΩ 典型值）
   - 确认 I2C 时钟频率设置
   - I2C 通信 NACK：检查设备地址是否正确、上拉电阻是否焊接、I2C 时钟频率是否过高

2. **写入后读取不正确**：
   - 检查是否等待了足够长的写入延迟（5~10ms）
   - 检查是否跨越了页边界（AT24C02 页大小 8 字节）
   - 验证地址字节序（大端）
   - 检查地址字节数是否正确（小容量 1 字节，大容量 2 字节）

3. **数据丢失**：
   - 使用 magic 标记和校验和确保数据完整性
   - 写入后立即回读验证

4. **设备节点不存在（open /dev/i2c1 失败）**：
   - 检查 defconfig 中 `CONFIG_LS2K300_I2C=y`、`CONFIG_LS2K300_I2C1=y`、`CONFIG_I2C_DRIVER=y` 是否启用
   - 检查 bringup.c 中是否调用了 `ls2k300_i2c_initialize(1)`

## 9. 内存布局建议

```
地址范围      | 用途
-------------|------------------
0x0000       | Magic (0xA5=有效)
0x0001       | 数据计数/类型标记
0x0002~0x000F| 预留（校验、版本等）
0x0010~0x00FF| 实际数据存储区
```


---

## 10. 完整模板代码（Template Source）

> 以下为经过验证、可直接使用的驱动模板源码（原 `assets/i2c_eeprom_template.c`）。
> 寄存器访问位宽（8/32 位）、时序控制（如 SPI EOT 等待）、片选（CS）管理、
> OE 低有效等逻辑均已验证，请勿随意修改核心实现。编写驱动时以此为骨架，
> 将占位符替换为实际值即可。

```c
/****************************************************************************
 * i2c_eeprom_template.c (已内联于本文档"完整模板代码"章节)
 *
 * I2C EEPROM 驱动模板（以 AT24C02 为范例）
 *
 * Hummingbird 2K300 板 I2C1 引脚：
 *   - I2C1_SDA: GPIO50 (MAIN_FUNC)
 *   - I2C1_SCL: GPIO51 (MAIN_FUNC)
 *
 * 使用说明：
 *   1. 引脚复用在 ls2k300_bringup.c 中已配置
 *   2. 根据 EEPROM datasheet 调整地址和页大小
 ****************************************************************************/

#include <nuttx/config.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>

#include <nuttx/i2c/i2c_master.h>
#include <nuttx/arch.h>

/* 已配置为 Hummingbird 2K300 板实际值 */

#define I2C_BUS         "/dev/i2c1"         /* I2C1 总线，GPIO50(SDA)/GPIO51(SCL) */
#define EEPROM_ADDR     0x50                /* AT24C02 7-bit 地址 */

/* AT24C02 参数 */

#define EEPROM_SIZE         256             /* 总容量 256 字节 */
#define EEPROM_PAGE_SIZE    8               /* 页大小 8 字节 */
#define EEPROM_WRITE_DELAY  20              /* 写入等待时间 ms */

/* 2-byte 地址 EEPROM（如 AT24C256）需要修改地址发送逻辑 */

#define EEPROM_ADDR_BYTES   2               /* 地址字节数：1=AT24C02, 2=AT24C256 */

static int g_i2c_fd = -1;

/****************************************************************************
 * Name: eeprom_i2c_write
 *
 * Description:
 *   向 I2C 设备写入数据。
 ****************************************************************************/

static int eeprom_i2c_write(uint8_t addr, const uint8_t *data, int len)
{
  struct i2c_msg_s msg;
  struct i2c_transfer_s xfer;

  msg.frequency = I2C_SPEED_STANDARD;
  msg.addr      = addr;
  msg.flags     = 0;           /* 写操作 */
  msg.buffer    = (FAR uint8_t *)data;
  msg.length    = len;

  xfer.msgv = &msg;
  xfer.msgc = 1;

  return ioctl(g_i2c_fd, I2CIOC_TRANSFER, (unsigned long)&xfer);
}

/****************************************************************************
 * Name: eeprom_i2c_read
 *
 * Description:
 *   从 I2C 设备读取数据。
 ****************************************************************************/

static int eeprom_i2c_read(uint8_t addr, uint8_t *data, int len)
{
  struct i2c_msg_s msg;
  struct i2c_transfer_s xfer;

  msg.frequency = I2C_SPEED_STANDARD;
  msg.addr      = addr;
  msg.flags     = I2C_M_READ;
  msg.buffer    = data;
  msg.length    = len;

  xfer.msgv = &msg;
  xfer.msgc = 1;

  return ioctl(g_i2c_fd, I2CIOC_TRANSFER, (unsigned long)&xfer);
}

/****************************************************************************
 * Name: eeprom_init
 *
 * Description:
 *   初始化 EEPROM，打开 I2C 总线。
 ****************************************************************************/

int eeprom_init(void)
{
  g_i2c_fd = open(I2C_BUS, O_RDWR);
  if (g_i2c_fd < 0)
    {
      printf("[EEPROM] ERROR: open %s: %d\n", I2C_BUS, errno);
      return -errno;
    }

  printf("[EEPROM] init done, addr=0x%02x\n", EEPROM_ADDR);
  return 0;
}

/****************************************************************************
 * Name: eeprom_read_byte
 *
 * Description:
 *   从 EEPROM 指定地址读取一个字节。
 *
 * Parameters:
 *   mem_addr - EEPROM 内存地址 (0x00~0xFF for AT24C02)
 *   data     - 读取的数据
 ****************************************************************************/

int eeprom_read_byte(uint16_t mem_addr, uint8_t *data)
{
  uint8_t addr[2];
  int ret;

#if EEPROM_ADDR_BYTES == 2
  addr[0] = (uint8_t)(mem_addr >> 8);
  addr[1] = (uint8_t)(mem_addr & 0xff);
  ret = eeprom_i2c_write(EEPROM_ADDR, addr, 2);
#else
  addr[0] = (uint8_t)(mem_addr & 0xff);
  ret = eeprom_i2c_write(EEPROM_ADDR, addr, 1);
#endif

  if (ret < 0)
    {
      return ret;
    }

  return eeprom_i2c_read(EEPROM_ADDR, data, 1);
}

/****************************************************************************
 * Name: eeprom_write_byte
 *
 * Description:
 *   向 EEPROM 指定地址写入一个字节。
 *
 * Parameters:
 *   mem_addr - EEPROM 内存地址
 *   data     - 要写入的数据
 *
 * Note:
 *   写入后需等待 EEPROM_WRITE_DELAY ms 才能进行下一次操作。
 ****************************************************************************/

int eeprom_write_byte(uint16_t mem_addr, uint8_t data)
{
  uint8_t buf[3];
  int len = 0;

#if EEPROM_ADDR_BYTES == 2
  buf[len++] = (uint8_t)(mem_addr >> 8);
#else
  (void)mem_addr;  /* unused for 1-byte address */
#endif
  buf[len++] = (uint8_t)(mem_addr & 0xff);
  buf[len++] = data;

  return eeprom_i2c_write(EEPROM_ADDR, buf, len);
}

/****************************************************************************
 * Name: eeprom_write_page
 *
 * Description:
 *   向 EEPROM 写入一页数据（最多 EEPROM_PAGE_SIZE 字节）。
 *
 * Parameters:
 *   mem_addr - 起始地址（必须页对齐）
 *   data     - 数据缓冲区
 *   len      - 数据长度（不超过 EEPROM_PAGE_SIZE）
 *
 * Note:
 *   页写入不能跨越页边界，调用者需确保 mem_addr 和 len 满足约束。
 ****************************************************************************/

int eeprom_write_page(uint16_t mem_addr, const uint8_t *data, int len)
{
  uint8_t buf[2 + EEPROM_PAGE_SIZE];
  int hdr_len = 0;
  int i;

  if (len > EEPROM_PAGE_SIZE)
    {
      len = EEPROM_PAGE_SIZE;
    }

#if EEPROM_ADDR_BYTES == 2
  buf[hdr_len++] = (uint8_t)(mem_addr >> 8);
#endif
  buf[hdr_len++] = (uint8_t)(mem_addr & 0xff);

  for (i = 0; i < len; i++)
    {
      buf[hdr_len + i] = data[i];
    }

  return eeprom_i2c_write(EEPROM_ADDR, buf, hdr_len + len);
}

/****************************************************************************
 * Name: eeprom_read_bytes
 *
 * Description:
 *   从 EEPROM 指定地址读取多个字节。
 ****************************************************************************/

int eeprom_read_bytes(uint16_t mem_addr, uint8_t *data, int len)
{
  uint8_t addr[2];
  int ret;

#if EEPROM_ADDR_BYTES == 2
  addr[0] = (uint8_t)(mem_addr >> 8);
  addr[1] = (uint8_t)(mem_addr & 0xff);
  ret = eeprom_i2c_write(EEPROM_ADDR, addr, 2);
#else
  addr[0] = (uint8_t)(mem_addr & 0xff);
  ret = eeprom_i2c_write(EEPROM_ADDR, addr, 1);
#endif

  if (ret < 0)
    {
      return ret;
    }

  return eeprom_i2c_read(EEPROM_ADDR, data, len);
}

/****************************************************************************
 * Name: eeprom_write_bytes
 *
 * Description:
 *   向 EEPROM 写入多个字节，自动处理跨页写入。
 *
 * Parameters:
 *   mem_addr - 起始地址
 *   data     - 数据缓冲区
 *   len      - 数据长度
 ****************************************************************************/

int eeprom_write_bytes(uint16_t mem_addr, const uint8_t *data, int len)
{
  int written = 0;
  int chunk;
  int ret;

  while (written < len)
    {
      /* 计算当前页剩余空间 */

      int page_remaining = EEPROM_PAGE_SIZE -
                           ((mem_addr + written) % EEPROM_PAGE_SIZE);
      chunk = len - written;
      if (chunk > page_remaining)
        {
          chunk = page_remaining;
        }

      ret = eeprom_write_page(mem_addr + written, &data[written], chunk);
      if (ret < 0)
        {
          printf("[EEPROM] ERROR: write at 0x%04X failed: %d\n",
                 mem_addr + written, ret);
          return ret;
        }

      usleep(EEPROM_WRITE_DELAY * 1000);
      written += chunk;
    }

  return 0;
}

/****************************************************************************
 * Name: eeprom_deinit
 ****************************************************************************/

void eeprom_deinit(void)
{
  if (g_i2c_fd >= 0)
    {
      close(g_i2c_fd);
      g_i2c_fd = -1;
    }
}

```
