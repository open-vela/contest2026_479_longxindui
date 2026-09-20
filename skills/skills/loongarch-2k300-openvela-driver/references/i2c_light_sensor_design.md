# I2C 光照传感器驱动设计文档（BH1750 范例）

## 1. 功能概述

通过 I2C 总线读取 BH1750 环境光传感器的光照强度值。

### BH1750 特性
- I2C 接口，7-bit 地址 `0x23`（ADDR 引脚低）或 `0x5C`（ADDR 引脚高）
- 分辨率：1 lux
- 测量范围：1~65535 lux
- 两种测量模式：连续/单次 × 高/低分辨率

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
```

## 3. I2C 总线配置

### 3.1 I2C 时序参数

| 参数 | 标准模式 | 快速模式 |
|------|---------|---------|
| 时钟频率 | 100 kHz | 400 kHz |
| SCL 高电平 | 4.0 μs | 0.6 μs |
| SCL 低电平 | 4.7 μs | 1.3 μs |

### 3.2 NuttX I2C API

```c
/* 打开 I2C 设备 */
int fd = open("/dev/i2c<N>", O_RDWR);

/* 构造传输消息 */
struct i2c_msg_s msg;
msg.addr   = <slave_addr>;     /* 7-bit 地址，无需左移 */
msg.flags  = 0;                /* 写操作 */
msg.buffer = tx_buf;
msg.length = tx_len;

struct i2c_transfer_s xfer;
xfer.msgv = &msg;
xfer.msgc = 1;

/* 执行传输 */
ioctl(fd, I2CIOC_TRANSFER, &xfer);
```

> ⚠️ **注意**：NuttX 的 `I2CIOC_TRANSFER`（非 `I2C_TRANSFER`），地址无需左移。

## 4. BH1750 命令集

| 命令 | 字节 | 说明 |
|------|------|------|
| 断电 | `0x00` | 进入低功耗模式 |
| 通电 | `0x01` | 等待测量指令 |
| 重置 | `0x07` | 重置数据寄存器 |
| 连续高分辨率 | `0x10` | 连续模式，1 lux 分辨率 |
| 连续高分辨率2 | `0x11` | 连续模式，0.5 lux 分辨率 |
| 连续低分辨率 | `0x13` | 连续模式，4 lux 分辨率 |
| 单次高分辨率 | `0x20` | 单次模式，1 lux 分辨率 |
| 单次高分辨率2 | `0x21` | 单次模式，0.5 lux 分辨率 |
| 单次低分辨率 | `0x23` | 单次模式，4 lux 分辨率 |

## 5. 初始化流程

```c
int bh1750_init(int fd)
{
  uint8_t cmd;
  struct i2c_msg_s msg;
  struct i2c_transfer_s xfer;

  /* Step 1: 上电 */
  cmd = BH1750_POWER_ON;
  msg.addr   = BH1750_ADDR;
  msg.flags  = 0;
  msg.buffer = &cmd;
  msg.length = 1;
  xfer.msgv  = &msg;
  xfer.msgc  = 1;
  ioctl(fd, I2CIOC_TRANSFER, &xfer);

  /* Step 2: 重置 */
  cmd = BH1750_RESET;
  msg.buffer = &cmd;
  msg.length = 1;
  ioctl(fd, I2CIOC_TRANSFER, &xfer);

  up_mdelay(10);
  return 0;
}
```

## 6. 读取流程

### 6.1 单次读取

```c
int bh1750_read_once(int fd, uint16_t *lux)
{
  uint8_t cmd;
  uint8_t buf[2];
  struct i2c_msg_s msgs[2];
  struct i2c_transfer_s xfer;

  /* Step 1: 发送单次测量命令 */
  cmd = BH1750_ONE_HRES;
  msgs[0].addr   = BH1750_ADDR;
  msgs[0].flags  = 0;           /* 写 */
  msgs[0].buffer = &cmd;
  msgs[0].length = 1;

  xfer.msgv = &msgs[0];
  xfer.msgc = 1;
  ioctl(fd, I2CIOC_TRANSFER, &xfer);

  /* Step 2: 等待测量完成（高分辨率约 180ms） */
  up_mdelay(180);

  /* Step 3: 读取 2 字节结果 */
  msgs[0].addr   = BH1750_ADDR;
  msgs[0].flags  = I2C_M_READ;  /* 读 */
  msgs[0].buffer = buf;
  msgs[0].length = 2;

  xfer.msgv = &msgs[0];
  xfer.msgc = 1;
  ioctl(fd, I2CIOC_TRANSFER, &xfer);

  /* Step 4: 合并高低字节 */
  *lux = ((uint16_t)buf[0] << 8) | buf[1];

  return 0;
}
```

### 6.2 数值换算

```c
/* BH1750 原始值 → 实际 lux（整数运算） */
uint32_t bh1750_raw_to_lux(uint16_t raw)
{
  /* 原始值 / 1.2 ≈ 实际 lux */
  /* 用整数：raw * 10 / 12 */
  return ((uint32_t)raw * 10 + 6) / 12;
}
```

## 7. 连续读取模式

```c
int bh1750_start_continuous(int fd)
{
  uint8_t cmd = BH1750_CONT_HRES;
  struct i2c_msg_s msg;
  struct i2c_transfer_s xfer;

  msg.addr   = BH1750_ADDR;
  msg.flags  = 0;
  msg.buffer = &cmd;
  msg.length = 1;
  xfer.msgv  = &msg;
  xfer.msgc  = 1;

  return ioctl(fd, I2CIOC_TRANSFER, &xfer);
}

int bh1750_read_continuous(int fd, uint16_t *lux)
{
  uint8_t buf[2];
  struct i2c_msg_s msg;
  struct i2c_transfer_s xfer;

  msg.addr   = BH1750_ADDR;
  msg.flags  = I2C_M_READ;
  msg.buffer = buf;
  msg.length = 2;
  xfer.msgv  = &msg;
  xfer.msgc  = 1;

  int ret = ioctl(fd, I2CIOC_TRANSFER, &xfer);
  if (ret < 0) return ret;

  *lux = ((uint16_t)buf[0] << 8) | buf[1];
  return 0;
}
```

## 8. 注意事项

1. **I2C 地址**：BH1750 的 7-bit 地址为 `0x23`（ADDR 脚接 GND）或 `0x5C`（ADDR 脚接 VCC）。NuttX 中直接使用 7-bit 地址，无需左移。
2. **测量等待时间**：高分辨率模式需等待 180ms，低分辨率需等待 24ms。
3. **时钟频率**：BH1750 支持最高 400kHz（快速模式）。
4. **上拉电阻**：I2C 总线需要外部上拉电阻（4.7kΩ 典型值）。
5. **无 FPU**：lux 换算使用整数运算 `raw * 10 / 12` 替代 `raw / 1.2`。

## 9. 调试技巧

1. **I2C 通信失败/NACK**：
   - 用 `i2cdetect` 工具扫描总线，确认设备地址
   - 检查 SDA/SCL 上拉电阻（4.7kΩ 典型值）是否焊接
   - 确认 I2C 时钟频率设置（BH1750 支持最高 400kHz）
   - I2C 通信 NACK：检查设备地址是否正确、上拉电阻是否焊接、I2C 时钟频率是否过高

2. **读数始终为 0**：
   - 确认已发送上电命令（BH1750_POWER_ON = 0x01）
   - 确认已发送测量命令并等待足够时间（H模式 180ms）

3. **读数异常偏大/偏小**：
   - 检查遮光/漏光情况
   - 确认换算公式正确（lux = raw * 1000 / 12）

4. **设备节点不存在（open /dev/i2c1 失败）**：
   - 检查 defconfig 中 `CONFIG_LS2K300_I2C=y`、`CONFIG_LS2K300_I2C1=y`、`CONFIG_I2C_DRIVER=y` 是否启用
   - 检查 bringup.c 中是否调用了 `ls2k300_i2c_initialize(1)`


---

## 10. 完整模板代码（Template Source）

> 以下为经过验证、可直接使用的驱动模板源码（原 `assets/i2c_light_sensor_template.c`）。
> 寄存器访问位宽（8/32 位）、时序控制（如 SPI EOT 等待）、片选（CS）管理、
> OE 低有效等逻辑均已验证，请勿随意修改核心实现。编写驱动时以此为骨架，
> 将占位符替换为实际值即可。

```c
/****************************************************************************
 * i2c_light_sensor_template.c (已内联于本文档"完整模板代码"章节)
 *
 * I2C 光照传感器驱动模板（以 BH1750 为范例）
 *
 * Hummingbird 2K300 板 I2C1 引脚：
 *   - I2C1_SDA: GPIO50 (MAIN_FUNC)
 *   - I2C1_SCL: GPIO51 (MAIN_FUNC)
 *
 * 使用说明：
 *   1. 引脚复用在 ls2k300_bringup.c 中已配置
 *   2. 根据传感器 datasheet 调整命令和读取流程
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
#define SLAVE_ADDR      0x23                /* BH1750 默认 7-bit 地址 */

/* BH1750 命令定义 */

#define BH1750_POWER_ON     0x01
#define BH1750_RESET        0x07
#define BH1750_CONT_HRES    0x10    /* 连续高分辨率模式 */
#define BH1750_CONT_HRES2   0x11    /* 连续高分辨率模式2 */
#define BH1750_CONT_LRES    0x13    /* 连续低分辨率模式 */
#define BH1750_ONE_HRES     0x20    /* 单次高分辨率模式 */
#define BH1750_ONE_HRES2    0x21    /* 单次高分辨率模式2 */
#define BH1750_ONE_LRES     0x23    /* 单次低分辨率模式 */

/* 测量等待时间（毫秒） */

#define BH1750_HRES_WAIT_MS  180
#define BH1750_LRES_WAIT_MS  24

static int g_i2c_fd = -1;

/****************************************************************************
 * Name: i2c_write_cmd
 *
 * Description:
 *   向 I2C 设备写入单字节命令。
 ****************************************************************************/

static int i2c_write_cmd(uint8_t cmd)
{
  struct i2c_msg_s msg;
  struct i2c_transfer_s xfer;

  msg.addr   = SLAVE_ADDR;
  msg.flags  = 0;           /* 写操作 */
  msg.buffer = &cmd;
  msg.length = 1;

  xfer.msgv = &msg;
  xfer.msgc = 1;

  return ioctl(g_i2c_fd, I2CIOC_TRANSFER, &xfer);
}

/****************************************************************************
 * Name: i2c_read_bytes
 *
 * Description:
 *   从 I2C 设备读取指定长度数据。
 ****************************************************************************/

static int i2c_read_bytes(uint8_t *buf, uint8_t len)
{
  struct i2c_msg_s msg;
  struct i2c_transfer_s xfer;

  msg.addr   = SLAVE_ADDR;
  msg.flags  = I2C_M_READ;
  msg.buffer = buf;
  msg.length = len;

  xfer.msgv = &msg;
  xfer.msgc = 1;

  return ioctl(g_i2c_fd, I2CIOC_TRANSFER, &xfer);
}

/****************************************************************************
 * Name: light_sensor_init
 *
 * Description:
 *   初始化光照传感器。
 ****************************************************************************/

int light_sensor_init(void)
{
  int ret;

  g_i2c_fd = open(I2C_BUS, O_RDWR);
  if (g_i2c_fd < 0)
    {
      printf("[LIGHT] ERROR: open %s: %d\n", I2C_BUS, errno);
      return -errno;
    }

  /* 上电 */

  ret = i2c_write_cmd(BH1750_POWER_ON);
  if (ret < 0)
    {
      printf("[LIGHT] ERROR: power on: %d\n", ret);
      return ret;
    }

  /* 重置 */

  ret = i2c_write_cmd(BH1750_RESET);
  if (ret < 0)
    {
      printf("[LIGHT] ERROR: reset: %d\n", ret);
      return ret;
    }

  up_mdelay(10);

  printf("[LIGHT] BH1750 init done, addr=0x%02x\n", SLAVE_ADDR);
  return 0;
}

/****************************************************************************
 * Name: light_sensor_read_once
 *
 * Description:
 *   单次测量模式读取光照强度。
 *
 * Output Parameters:
 *   lux - 光照强度（单位：lux）
 *
 * Returned Value:
 *   0 on success, negative errno on failure.
 ****************************************************************************/

int light_sensor_read_once(uint16_t *lux)
{
  uint8_t buf[2];
  int ret;
  uint16_t raw;

  /* 发送单次高分辨率测量命令 */

  ret = i2c_write_cmd(BH1750_ONE_HRES);
  if (ret < 0)
    {
      return ret;
    }

  /* 等待测量完成 */

  up_mdelay(BH1750_HRES_WAIT_MS);

  /* 读取 2 字节结果 */

  ret = i2c_read_bytes(buf, 2);
  if (ret < 0)
    {
      return ret;
    }

  /* 合并高低字节 */

  raw = ((uint16_t)buf[0] << 8) | buf[1];

  /* 换算：raw / 1.2 ≈ lux（整数：raw * 10 / 12） */

  *lux = (uint16_t)(((uint32_t)raw * 10 + 6) / 12);

  return 0;
}

/****************************************************************************
 * Name: light_sensor_start_continuous
 *
 * Description:
 *   启动连续测量模式。
 ****************************************************************************/

int light_sensor_start_continuous(void)
{
  return i2c_write_cmd(BH1750_CONT_HRES);
}

/****************************************************************************
 * Name: light_sensor_read_continuous
 *
 * Description:
 *   在连续模式下读取光照强度（不发送测量命令）。
 ****************************************************************************/

int light_sensor_read_continuous(uint16_t *lux)
{
  uint8_t buf[2];
  int ret;
  uint16_t raw;

  ret = i2c_read_bytes(buf, 2);
  if (ret < 0)
    {
      return ret;
    }

  raw = ((uint16_t)buf[0] << 8) | buf[1];
  *lux = (uint16_t)(((uint32_t)raw * 10 + 6) / 12);

  return 0;
}

/****************************************************************************
 * Name: light_sensor_deinit
 ****************************************************************************/

void light_sensor_deinit(void)
{
  if (g_i2c_fd >= 0)
    {
      i2c_write_cmd(0x00);  /* 断电 */
      close(g_i2c_fd);
      g_i2c_fd = -1;
    }
}

```
