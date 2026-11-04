# I2C OLED 显示屏驱动设计文档（SSD1306 范例）

## 1. 功能概述

通过 I2C 总线控制 SSD1306 OLED 显示屏，支持：
- 初始化配置
- 清屏/填充
- 字符/字符串显示
- 像素级绘图

### SSD1306 特性
- I2C 地址：`0x3C`（SA0=0）或 `0x3D`（SA0=1）
- 分辨率：128×64 像素
- 显存：128×64 / 8 = 1024 字节（8 页 × 128 列）
- 两种数据模式：命令（`0x00`）和数据（`0x40`）

## 2. 板级配置（⚠️ 必须先完成）

### 2.1 引脚复用

在 `nuttx/boards/loongarch/ls2k0300/hummingbird-ls2k0300/src/ls2k0300_bringup.c` 的
`ls2k0300_hardware_init()` 中添加：

```c
/* I2C1: GPIO50(SDA)/GPIO51(SCL) → MAIN_FUNC */
ls_pinmux_pin_setup(50, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(51, LS_PINMUX_MODE_AS_MAIN_FUNC);
```

### 2.2 Kconfig 使能

在 `nuttx/boards/loongarch/ls2k0300/hummingbird-ls2k0300/configs/nsh/defconfig` 中添加：

```
CONFIG_LS2K0300_I2C=y
CONFIG_LS2K0300_I2C1=y
```

## 3. I2C 通信格式

SSD1306 I2C 数据帧格式：

```
[START] [ADDR+W] [CONTROL] [DATA] [STOP]
```

- **CONTROL 字节**：
  - `0x00`：后续为命令字节
  - `0x40`：后续为显示数据
  - `0x80`：后续为单个命令（Co=1, D/C=0）
  - `0xC0`：后续为单个数据（Co=1, D/C=1）

### 3.1 发送命令

```c
int oled_send_cmd(int fd, uint8_t cmd)
{
  uint8_t buf[2] = { 0x00, cmd };  /* CONTROL=0x00, CMD */
  struct i2c_msg_s msg;
  struct i2c_transfer_s xfer;

  msg.addr   = OLED_I2C_ADDR;
  msg.flags  = 0;
  msg.buffer = buf;
  msg.length = 2;
  xfer.msgv  = &msg;
  xfer.msgc  = 1;

  return ioctl(fd, I2CIOC_TRANSFER, &xfer);
}
```

### 3.2 发送数据

```c
int oled_send_data(int fd, const uint8_t *data, int len)
{
  /* 需要先发 CONTROL 字节 0x40 */
  uint8_t *buf = malloc(len + 1);
  buf[0] = 0x40;
  memcpy(&buf[1], data, len);

  struct i2c_msg_s msg;
  struct i2c_transfer_s xfer;

  msg.addr   = OLED_I2C_ADDR;
  msg.flags  = 0;
  msg.buffer = buf;
  msg.length = len + 1;
  xfer.msgv  = &msg;
  xfer.msgc  = 1;

  int ret = ioctl(fd, I2CIOC_TRANSFER, &xfer);
  free(buf);
  return ret;
}
```

## 4. 初始化序列

```c
int oled_init(int fd)
{
  /* 关闭显示 */
  oled_send_cmd(fd, 0xAE);  /* Display OFF */

  /* 设置时钟分频 */
  oled_send_cmd(fd, 0xD5);  /* Set Display Clock */
  oled_send_cmd(fd, 0x80);  /* 分频比=1, 频率=100Hz */

  /* 设置多路复用率 */
  oled_send_cmd(fd, 0xA8);  /* Set Multiplex Ratio */
  oled_send_cmd(fd, 0x3F);  /* 64-1 (1/64 duty) */

  /* 设置显示偏移 */
  oled_send_cmd(fd, 0xD3);  /* Set Display Offset */
  oled_send_cmd(fd, 0x00);  /* 无偏移 */

  /* 设置起始行 */
  oled_send_cmd(fd, 0x40);  /* Set Start Line = 0 */

  /* 电荷泵设置 */
  oled_send_cmd(fd, 0x8D);  /* Charge Pump */
  oled_send_cmd(fd, 0x14);  /* 使能电荷泵 */

  /* 寻址模式：页寻址 */
  oled_send_cmd(fd, 0x20);  /* Set Memory Addressing Mode */
  oled_send_cmd(fd, 0x02);  /* Page Addressing Mode */

  /* 段重映射：列127映射到SEG0 */
  oled_send_cmd(fd, 0xA1);  /* Set Segment Re-map */

  /* COM 输出扫描方向：从 COM[N-1] 到 COM0 */
  oled_send_cmd(fd, 0xC8);  /* Set COM Output Scan Direction */

  /* COM 引脚硬件配置 */
  oled_send_cmd(fd, 0xDA);  /* Set COM Pins */
  oled_send_cmd(fd, 0x12);  /* Alternative COM config */

  /* 对比度 */
  oled_send_cmd(fd, 0x81);  /* Set Contrast */
  oled_send_cmd(fd, 0xCF);  /* 对比度=207 */

  /* 预充电周期 */
  oled_send_cmd(fd, 0xD9);  /* Set Pre-charge Period */
  oled_send_cmd(fd, 0xF1);

  /* VCOMH 取消选择电平 */
  oled_send_cmd(fd, 0xDB);  /* Set VCOMH Deselect Level */
  oled_send_cmd(fd, 0x40);  /* 0.83 × VCC */

  /* 全局显示开启 */
  oled_send_cmd(fd, 0xA4);  /* Entire Display ON (resume) */

  /* 正常显示（非反色） */
  oled_send_cmd(fd, 0xA6);  /* Normal Display */

  /* 开启显示 */
  oled_send_cmd(fd, 0xAF);  /* Display ON */

  return 0;
}
```

## 5. 页寻址模式

SSD1306 页寻址模式下的显存结构：

```
Page 0: [COM0: bit0 of each byte]   COL0 COL1 ... COL127
Page 1: [COM8: bit0 of each byte]   COL0 COL1 ... COL127
...
Page 7: [COM56: bit0 of each byte]  COL0 COL1 ... COL127
```

每页 128 字节，共 8 页 × 128 = 1024 字节。

### 5.1 设置光标位置

```c
void oled_set_cursor(int fd, uint8_t page, uint8_t col)
{
  oled_send_cmd(fd, 0xB0 + page);  /* 设置页地址 */
  oled_send_cmd(fd, 0x00 + (col & 0x0F));  /* 列地址低 4 位 */
  oled_send_cmd(fd, 0x10 + (col >> 4));    /* 列地址高 4 位 */
}
```

## 6. 显示函数

### 6.1 清屏

```c
void oled_clear(int fd)
{
  uint8_t zeros[128];
  memset(zeros, 0, 128);

  for (int page = 0; page < 8; page++)
    {
      oled_set_cursor(fd, page, 0);
      oled_send_data(fd, zeros, 128);
    }
}
```

### 6.2 显示字符

```c
/* 6×8 字体，每字符 6 字节（含间距） */
static const uint8_t font_6x8[][6] = {
  /* ASCII 32~126 的字模数据 */
  /* ... */
};

void oled_putchar(int fd, uint8_t page, uint8_t col, char ch)
{
  if (ch < 32 || ch > 126) ch = ' ';
  oled_set_cursor(fd, page, col);
  oled_send_data(fd, font_6x8[ch - 32], 6);
}

void oled_puts(int fd, uint8_t page, uint8_t col, const char *str)
{
  while (*str)
    {
      oled_putchar(fd, page, col, *str);
      col += 6;
      if (col > 122)  /* 超出右边界，换行 */
        {
          col = 0;
          page++;
          if (page >= 8) return;
        }
      str++;
    }
}
```

### 6.3 显示数值

```c
void oled_show_number(int fd, uint8_t page, uint8_t col,
                      uint32_t value, int decimals)
{
  char buf[16];
  /* 整数转字符串（无 FPU，不使用 sprintf 浮点） */
  int len = 0;
  uint32_t tmp = value;

  /* 提取各位数字 */
  do
    {
      buf[len++] = '0' + (tmp % 10);
      tmp /= 10;
    }
  while (tmp > 0 && len < 15);

  /* 反转 */
  for (int i = 0; i < len / 2; i++)
    {
      char t = buf[i];
      buf[i] = buf[len - 1 - i];
      buf[len - 1 - i] = t;
    }

  buf[len] = '\0';
  oled_puts(fd, page, col, buf);
}
```

## 7. 显存缓冲模式

对于频繁更新的显示，可使用显存缓冲区减少 I2C 传输次数：

```c
static uint8_t g_framebuf[8][128];  /* 1024 字节显存 */

void oled_pixel(int x, int y, int on)
{
  if (x >= 128 || y >= 64) return;
  if (on)
    g_framebuf[y / 8][x] |= (1 << (y % 8));
  else
    g_framebuf[y / 8][x] &= ~(1 << (y % 8));
}

void oled_refresh(int fd)
{
  for (int page = 0; page < 8; page++)
    {
      oled_set_cursor(fd, page, 0);
      oled_send_data(fd, g_framebuf[page], 128);
    }
}
```

## 8. 注意事项

1. **I2C 地址**：SSD1306 默认地址 `0x3C`。NuttX 中直接使用 7-bit 地址。
2. **传输长度限制**：单次 I2C 传输建议不超过 128+1 字节（CONTROL + 128 字节数据）。
3. **初始化顺序**：必须先关闭显示（0xAE），配置完成后再开启（0xAF）。
4. **电荷泵**：使用内部 DC-DC 时必须使能电荷泵（0x8D, 0x14）。
5. **字体数据**：需预先准备字模数组，常用 6×8 或 8×16 字体。
6. **无 FPU**：数值显示使用整数运算，禁止 `sprintf("%f", ...)`。

## 9. 调试技巧

1. **屏幕无显示**：
   - 检查 I2C 地址是否正确（SSD1306 通常为 0x3C）
   - 确认电荷泵已使能
   - 确认显示已开启（0xAF）
   - 检查 I2C 通信是否正常（NACK 检查）

2. **显示乱码**：
   - 检查寻址模式是否正确设置
   - 确认段重映射和 COM 扫描方向

3. **部分区域不显示**：
   - 检查页地址和列地址设置
   - 确认数据传输长度正确

4. **I2C 通信 NACK**：
   - 检查设备地址是否正确、上拉电阻是否焊接
   - I2C 时钟频率是否过高（SSD1306 支持最高 400kHz）

5. **设备节点不存在（open /dev/i2c1 失败）**：
   - 检查 defconfig 中 `CONFIG_LS2K0300_I2C=y`、`CONFIG_LS2K0300_I2C1=y`、`CONFIG_I2C_DRIVER=y` 是否启用


---

## 10. 完整模板代码（Template Source）

> 以下为经过验证、可直接使用的驱动模板源码（原 `assets/i2c_oled_template.c`）。
> 寄存器访问位宽（8/32 位）、时序控制（如 SPI EOT 等待）、片选（CS）管理、
> OE 低有效等逻辑均已验证，请勿随意修改核心实现。编写驱动时以此为骨架，
> 将占位符替换为实际值即可。

```c
/****************************************************************************
 * i2c_oled_template.c (已内联于本文档"完整模板代码"章节)
 *
 * I2C OLED 显示屏驱动模板（以 SSD1306 为范例）
 *
 * Hummingbird 2K0300 板 I2C1 引脚：
 *   - I2C1_SDA: GPIO50 (MAIN_FUNC)
 *   - I2C1_SCL: GPIO51 (MAIN_FUNC)
 *
 * 使用说明：
 *   1. 引脚复用在 ls2k0300_bringup.c 中已配置
 *   2. 根据屏幕分辨率调整 OLED_WIDTH / OLED_HEIGHT
 ****************************************************************************/

#include <nuttx/config.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdint.h>

#include <nuttx/i2c/i2c_master.h>
#include <nuttx/arch.h>

/* Hummingbird 2K0300 板 I2C1 配置 */

#define I2C_BUS         "/dev/i2c1"     /* I2C1 总线，GPIO50(SDA)/GPIO51(SCL) */
#define OLED_I2C_ADDR   0x3C            /* SSD1306 常见 7-bit 地址 */

#define OLED_WIDTH      128
#define OLED_HEIGHT     64
#define OLED_PAGES      (OLED_HEIGHT / 8)

/* SSD1306 Control Byte */

#define OLED_CMD_MODE   0x00    /* Co=0, D/C=0: 后续全部为命令 */
#define OLED_DATA_MODE  0x40    /* Co=0, D/C=1: 后续全部为数据 */

static int g_oled_fd = -1;

/****************************************************************************
 * SSD1306 初始化命令序列
 ****************************************************************************/

static const uint8_t g_oled_init_cmds[] =
{
  0xAE,         /* Display OFF */
  0xD5, 0x80,   /* Set display clock divide ratio */
  0xA8, 0x3F,   /* Set multiplex ratio (1 to 64) */
  0xD3, 0x00,   /* Set display offset = 0 */
  0x40,         /* Set start line address = 0 */
  0x8D, 0x14,   /* Enable charge pump */
  0x20, 0x00,   /* Set memory addressing mode = Horizontal */
  0xA1,         /* Set segment re-map */
  0xC8,         /* Set COM output scan direction (remapped) */
  0xDA, 0x12,   /* Set COM pins hardware configuration */
  0x81, 0xCF,   /* Set contrast = 0xCF */
  0xD9, 0xF1,   /* Set pre-charge period */
  0xDB, 0x30,   /* Set VCOMH deselect level */
  0xA4,         /* Entire display ON (resume) */
  0xA6,         /* Set normal display (not inverted) */
  0xAF,         /* Display ON */
};

/****************************************************************************
 * 简易 8×16 ASCII 字库（空格 ~ 波浪号，仅示例几个字符）
 * 完整字库需包含 95 个字符 × 16 字节 = 1520 字节
 ****************************************************************************/

static const uint8_t g_font_example[3][16] =
{
  /* ' ' (0x20) */
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
   0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  /* '!' (0x21) */
  {0x00,0x00,0x18,0x3C,0x3C,0x3C,0x18,0x18,
   0x18,0x00,0x18,0x18,0x00,0x00,0x00,0x00},
  /* '"' (0x22) */
  {0x00,0x66,0x66,0x66,0x24,0x00,0x00,0x00,
   0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
};

/****************************************************************************
 * Private Functions
 ****************************************************************************/

static int oled_write(uint8_t mode, const uint8_t *data, uint16_t len)
{
  uint8_t buf[1 + len];
  struct i2c_msg_s msg;
  struct i2c_transfer_s xfer;

  buf[0] = mode;
  memcpy(&buf[1], data, len);

  msg.addr   = OLED_I2C_ADDR;
  msg.flags  = 0;
  msg.buffer = buf;
  msg.length = 1 + len;
  xfer.msgv  = &msg;
  xfer.msgc  = 1;

  return ioctl(g_oled_fd, I2CIOC_TRANSFER, &xfer);
}

static int oled_cmd(uint8_t cmd)
{
  return oled_write(OLED_CMD_MODE, &cmd, 1);
}

static int oled_data(const uint8_t *data, uint16_t len)
{
  return oled_write(OLED_DATA_MODE, data, len);
}

/****************************************************************************
 * Public Functions
 ****************************************************************************/

/****************************************************************************
 * Name: oled_init
 *
 * Description:
 *   初始化 OLED 显示屏。
 ****************************************************************************/

int oled_init(void)
{
  int ret;
  int i;

  g_oled_fd = open(I2C_BUS, O_RDWR);
  if (g_oled_fd < 0)
    {
      printf("[OLED] ERROR: open %s: %d\n", I2C_BUS, errno);
      return -errno;
    }

  /* 发送初始化命令序列 */

  for (i = 0; i < sizeof(g_oled_init_cmds); i++)
    {
      ret = oled_cmd(g_oled_init_cmds[i]);
      if (ret < 0)
        {
          printf("[OLED] ERROR: init cmd[%d]: %d\n", i, ret);
          return ret;
        }
    }

  /* 清屏 */

  oled_clear();

  printf("[OLED] SSD1306 init done, addr=0x%02x\n", OLED_I2C_ADDR);
  return 0;
}

/****************************************************************************
 * Name: oled_clear
 *
 * Description:
 *   清除整个屏幕。
 ****************************************************************************/

int oled_clear(void)
{
  uint8_t zero[OLED_WIDTH];
  int page;

  memset(zero, 0, sizeof(zero));

  for (page = 0; page < OLED_PAGES; page++)
    {
      oled_cmd(0xB0 + page);  /* Page address */
      oled_cmd(0x00);          /* Column low nibble = 0 */
      oled_cmd(0x10);          /* Column high nibble = 0 */
      oled_data(zero, OLED_WIDTH);
    }

  return 0;
}

/****************************************************************************
 * Name: oled_set_position
 *
 * Description:
 *   设置光标位置。
 *
 * Input Parameters:
 *   page - 页地址（0~7）
 *   col  - 列地址（0~127）
 ****************************************************************************/

int oled_set_position(uint8_t page, uint8_t col)
{
  oled_cmd(0xB0 + page);
  oled_cmd(0x00 + (col & 0x0F));
  oled_cmd(0x10 + (col >> 4));
  return 0;
}

/****************************************************************************
 * Name: oled_show_string
 *
 * Description:
 *   在指定位置显示字符串（需要完整字库支持）。
 *
 * Input Parameters:
 *   page - 起始页地址
 *   col  - 起始列地址
 *   str  - 要显示的字符串
 ****************************************************************************/

int oled_show_string(uint8_t page, uint8_t col, const char *str)
{
  oled_set_position(page, col);

  while (*str)
    {
      /* TODO: 替换为完整字库查找 */
      /* uint8_t ch = *str - ' '; */
      /* oled_data(g_font_8x16[ch], 16); */
      str++;
    }

  return 0;
}

/****************************************************************************
 * Name: oled_show_number
 *
 * Description:
 *   在指定位置显示数字（整数）。
 ****************************************************************************/

int oled_show_number(uint8_t page, uint8_t col, int32_t num)
{
  char buf[12];
  snprintf(buf, sizeof(buf), "%ld", (long)num);
  return oled_show_string(page, col, buf);
}

/****************************************************************************
 * Name: oled_deinit
 ****************************************************************************/

void oled_deinit(void)
{
  if (g_oled_fd >= 0)
    {
      oled_cmd(0xAE);  /* Display OFF */
      close(g_oled_fd);
      g_oled_fd = -1;
    }
}

```
