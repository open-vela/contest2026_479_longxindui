# 硬件 UART 驱动设计文档

## 1. 功能概述

LS2K300 集成 4 路 16550 兼容 UART 控制器（UART0~UART3），用于串口字节收发。
每路 UART 有独立的波特率分频器、FIFO 与中断。Hummingbird 2K300 板将 UART0
引出作系统控制台，UART2 引出到 GPIO44/GPIO45（可接 USB-TTL 做收发测试）。

### UART 通道与引脚映射

| UART 通道 | 设备路径 | TX 引脚 | RX 引脚 | 功能选择 | 说明 |
|----------|---------|--------|---------|---------|------|
| UART0 | /dev/ttyS0 | — | — | — | 系统控制台，已固定 |
| UART2 | /dev/ttyS2 | GPIO44 | GPIO45 | MAIN_FUNC (0x3) | 用户串口，可收发字节 |

> UART2 的 TX/RX 与 GPIO44/GPIO45 复用，二者必须同时配置为 `MAIN_FUNC`。

## 2. 板级配置（⚠️ 必须先完成）

### 2.1 引脚复用（两步都必须做！）

**第一步：bringup.c 中设置**

在 `nuttx/boards/loongarch/ls2k300/hummingbird-ls2k300/src/ls2k300_bringup.c`
的 `ls2k300_hardware_init()` 中添加：

```c
/* UART2: GPIO44(TX)/GPIO45(RX) → MAIN_FUNC */
ls_pinmux_pin_setup(44, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(45, LS_PINMUX_MODE_AS_MAIN_FUNC);
```

**第二步：应用层通过 pinctrl 设置（必须！）**

仅在 bringup.c 中设置不够，应用层还必须通过 `/dev/pinctrl0` 设置：

```c
struct pinctrl_param_s param;
int fd = open("/dev/pinctrl0", O_RDWR);

param.pin = 44;
param.para.function = 3;  /* MAIN_FUNC */
ioctl(fd, PINCTRLC_SETFUNCTION, (unsigned long)&param);

param.pin = 45;
param.para.function = 3;
ioctl(fd, PINCTRLC_SETFUNCTION, (unsigned long)&param);

close(fd);
```

> 这是因为系统启动后，其他驱动可能会覆盖引脚设置。
> UART 测试程序必须在使用前主动将引脚切换回主功能。

### 2.2 Kconfig 使能

在 defconfig 中添加：

```
CONFIG_LS2K300_UART2=y
CONFIG_UART2_BAUD=115200
CONFIG_UART2_RXBUFSIZE=256
CONFIG_UART2_TXBUFSIZE=256
```

### 2.3 内核 serial 驱动注册（⚠️ UART 特有，不可跳过）

与 PWM/I2C/SPI 不同，`/dev/ttyS2` 节点由内核 serial 框架在
`ls2k300_serial.c` 中注册。若内核驱动未为 UART2 注册实例，即使 defconfig
启用了 `CONFIG_LS2K300_UART2`，`/dev/ttyS2` 也不会出现。需确认以下三处：

1. `nuttx/arch/loongarch/src/ls2k300/Kconfig`：已定义 `LS2K300_HAVE_UART2`
   与 `LS2K300_UART2`、`UART2_BAUD/RXBUFSIZE/TXBUFSIZE`。
2. `nuttx/arch/loongarch/src/ls2k300/ls2k300_config.h`：`HAVE_UART_DEVICE`
   条件含 `|| defined(CONFIG_LS2K300_UART2)`。
3. `nuttx/arch/loongarch/src/ls2k300/ls2k300_serial.c`：已定义
   `g_uart2priv`/`g_uart2port`（`.uartbase = LS2K300_UART2_BASE`、
   `.irq = LS2K300_IRQ_UART2`），并在 `loongarch_serialinit()` 中调用
   `uart_register("/dev/ttyS2", &g_uart2port)`。

> Hummingbird 2K300 现有代码已补全以上三处，直接使用即可。
> 新增 UART1/UART3 等通道时，按 UART0/UART2 同样模板补一例。

## 3. 硬件原理

### 3.1 16550 控制器架构

```
APB 200MHz
     │
     ▼
┌──────────────┐    ┌─────────┐    ┌──────────┐
│  波特率分频器  │───>│  TX FIFO │───>│  TX 引脚  │
│  (div_val)    │    └─────────┘    └──────────┘
└──────────────┘    ┌─────────┐    ┌──────────┐
                    │  RX FIFO │<───│  RX 引脚  │
                    └─────────┘    └──────────┘
                          │
                          ▼
                    中断 (LS2K300_IRQ_UART2)
```

### 3.2 波特率分频

16550 用 `DLL`/`DLH` 两个 8 位寄存器组成 16 位分频值 `div_val`：

```
div_val = (uart_ref_clk + baud * 8) / (baud * 16)
```

- `uart_ref_clk = LS2K300_APB_FREQ * 1000000 = 200MHz`
- 例：115200 baud → `(200000000 + 921600) / 1843200 = 109`

> 分频计算由内核 serial 驱动 `up_setup()` 完成，应用层无需关心，
> 只需通过 termios 设置波特率即可。

## 4. 关键寄存器（16550）

寄存器为 **8 位**（驱动用 `getreg8`/`putreg8` 访问），基地址
`LS2K300_UART2_BASE = 0x16100800`（非缓存）。

| 偏移 | 寄存器 | 说明 |
|------|--------|------|
| 0x00 | RBR / THR | 接收缓冲 / 发送保持（DLAB=0） |
| 0x01 | IER | 中断使能（ERBFI/ETBEI） |
| 0x02 | IIR / FCR | 中断识别 / FIFO 控制 |
| 0x03 | LCR | 线路控制（WLEN8/DLAB） |
| 0x05 | LSR | 线路状态（DR/THRE/TEMT） |
| 0x00/0x01 | DLL/DLH | 分频低/高（DLAB=1） |

LSR 关键位：`DR`（bit0，数据就绪）、`THRE`（bit5，THR 空）、`TEMT`（bit6，发送器空）。

> 应用层走 `/dev/ttyS2`，不直接操作这些寄存器；此处仅供理解驱动行为。

## 5. NuttX serial API 使用流程

UART 走标准 POSIX 串口接口（open/read/write + termios），不像 PWM/I2C/SPI
用专用 ioctl：

```c
/* 1. 打开设备（如需轮询退出按键，加 O_NONBLOCK） */

int fd = open("/dev/ttyS2", O_RDWR | O_NONBLOCK);

/* 2. termios 配置 8N1 @ 115200 */

struct termios tio;
tcgetattr(fd, &tio);
tio.c_iflag = 0;                 /* raw input */
tio.c_oflag = 0;                 /* raw output */
tio.c_lflag = 0;                 /* no canonical */

tio.c_cflag &= ~CSIZE;
tio.c_cflag |= CS8;              /* 8 data bits */
tio.c_cflag &= ~(PARENB | CSTOPB); /* no parity, 1 stop */
tio.c_cflag |= CLOCAL | CREAD;   /* ignore modem, enable RX */

cfsetspeed(&tio, B115200);
tcsetattr(fd, TCSANOW, &tio);

/* 3. 发送字节 */

write(fd, "hello", 5);
tcdrain(fd);                      /* 等待 TX 排空 */

/* 4. 接收字节 */

char ch;
ssize_t n = read(fd, &ch, 1);    /* 无数据返回 -1/EAGAIN */

/* 5. 关闭 */

close(fd);
```

## 6. 注意事项

1. **引脚复用双层设置**：bringup.c 设 `MAIN_FUNC` 后，应用层仍需通过
   `PINCTRLC_SETFUNCTION` 重新确认 GPIO44/45，否则可能被其他驱动覆盖。

2. **节点不存在先查内核驱动**：`/dev/ttyS2` 不出现，多半是内核 serial
   驱动未注册 UART2 实例（见 2.3），而非应用层问题。

3. **O_NONBLOCK 与轮询退出**：若 echo 循环里要同时轮询按键，必须用
   `O_NONBLOCK` 打开串口，否则 `read()` 会阻塞，按 KEY2 无法退出。

4. **tcdrain 防溢出**：逐字节 `write` 后调 `tcdrain(fd)`，可避免慢速
   USB-TTL 溢出驱动 TX 缓冲。

5. **控制台不要复用**：UART0 是 `/dev/console`，不要把 UART0 同时
   当用户串口再配 termios，会干扰系统日志。

6. **波特率**：`LS2K300_APB_FREQ = 200`（MHz），115200 对应分频值 109，
   由 `up_setup()` 写入 DLL/DLH。

---

## 7. 完整模板代码（Template Source）

> 以下为经过验证、可直接使用的驱动模板源码。走 `/dev/ttyS2` 标准设备路径
> （非裸寄存器），含 termios 配置、收发回显、KEY2 按下退出。以此为骨架，
> 将占位符替换为实际值即可。

```c
/****************************************************************************
 * uart_template.c
 *
 * UART2 字节收发驱动模板 - 龙芯 2K300 NuttX 平台
 *
 * Hummingbird 2K300 板 UART2 引脚：
 *   UART2_TX → GPIO44 (MAIN_FUNC, 0x3)
 *   UART2_RX → GPIO45 (MAIN_FUNC, 0x3)
 *
 * 设备路径：/dev/ttyS2（由 ls2k300_serial.c 注册）
 *
 * 编译条件：
 *   CONFIG_LS2K300_UART2=y
 *   CONFIG_LS2K300_GPIO=y
 *   CONFIG_LS2K300_PINCTRL=y
 ****************************************************************************/

/****************************************************************************
 * Included Files
 ****************************************************************************/

#include <nuttx/config.h>

#include <sys/ioctl.h>
#include <stdbool.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <termios.h>

#include <nuttx/arch.h>
#include <nuttx/pinctrl/pinctrl.h>
#include <nuttx/ioexpander/gpio.h>

/****************************************************************************
 * Pre-processor Definitions
 ****************************************************************************/

#define UART_DEVICE             "/dev/ttyS2"

#define UART_TX_GPIO            44
#define UART_RX_GPIO            45
#define UART_FUNCTION           3       /* LS_PINMUX_MODE_AS_MAIN_FUNC */

#define UART_BAUD               B115200

/* KEY2 (GPIO86, active-low) 用于退出回显循环 */

#define KEY2_GPIO               86
#define KEY_DEBOUNCE_MS         20

#define UART_ECHO_MAX           64

/****************************************************************************
 * Private Functions
 ****************************************************************************/

/* 通过 pinctrl 将 GPIO44/45 切换为 UART2 主功能
 *
 * 关键点：仅在 bringup.c 中调用 ls_pinmux_pin_setup() 不够，
 * 还必须在应用层通过 /dev/pinctrl0 设置 PINCTRLC_SETFUNCTION，
 * 否则引脚可能被其他驱动覆盖。
 */

static int uart_pinctrl_setup(void)
{
  struct pinctrl_param_s param;
  int fd;
  int ret;

  fd = open("/dev/pinctrl0", O_RDWR);
  if (fd < 0)
    {
      return -errno;
    }

  /* TX pin */

  param.pin = UART_TX_GPIO;
  param.para.function = UART_FUNCTION;
  ret = ioctl(fd, PINCTRLC_SETFUNCTION, (unsigned long)&param);
  if (ret < 0)
    {
      close(fd);
      return -errno;
    }

  /* RX pin */

  param.pin = UART_RX_GPIO;
  param.para.function = UART_FUNCTION;
  ret = ioctl(fd, PINCTRLC_SETFUNCTION, (unsigned long)&param);
  if (ret < 0)
    {
      close(fd);
      return -errno;
    }

  close(fd);
  return OK;
}

static int key2_open(void)
{
  char path[32];
  int fd;
  int ret;

  /* 复用 test_common.c 的 pinctrl helper 选 GPIO 功能 */

  extern int pinctrl_set_gpio_function(int pin);
  ret = pinctrl_set_gpio_function(KEY2_GPIO);
  if (ret < 0)
    {
      return ret;
    }

  snprintf(path, sizeof(path), "/dev/gpio%d", KEY2_GPIO);
  fd = open(path, O_RDWR);
  if (fd < 0)
    {
      return -errno;
    }

  ret = ioctl(fd, GPIOC_SETPINTYPE, (unsigned long)GPIO_INPUT_PIN);
  if (ret < 0)
    {
      close(fd);
      return -errno;
    }

  return fd;
}

static bool key2_is_pressed(int fd)
{
  bool value = true;

  ioctl(fd, GPIOC_READ, (unsigned long)(uintptr_t)&value);
  if (!value)
    {
      up_mdelay(KEY_DEBOUNCE_MS);
      value = true;
      ioctl(fd, GPIOC_READ, (unsigned long)(uintptr_t)&value);
      if (!value)
        {
          return true;
        }
    }

  return false;
}

/****************************************************************************
 * Public Functions
 ****************************************************************************/

int test_uart2(void)
{
  static const char banner[] =
    "\r\n=== LS2K300 UART2 Echo Test ===\r\n"
    "Type characters, they will be echoed back.\r\n";

  struct termios tio;
  const char *p;
  char ch;
  int fd;
  int fd_key;
  int ret;
  int received = 0;
  bool key_exit = false;

  /* Step 1: 引脚复用配置（必须！） */

  ret = uart_pinctrl_setup();
  if (ret < 0)
    {
      return ret;
    }

  /* Step 2: 打开 KEY2 用于退出 */

  fd_key = key2_open();
  if (fd_key < 0)
    {
      return fd_key;
    }

  /* Step 3: 打开串口设备（O_NONBLOCK 以便轮询 KEY2） */

  fd = open(UART_DEVICE, O_RDWR | O_NONBLOCK);
  if (fd < 0)
    {
      close(fd_key);
      return -errno;
    }

  /* Step 4: termios 配置 8N1 @ 115200 */

  tcgetattr(fd, &tio);
  tio.c_iflag = 0;
  tio.c_oflag = 0;
  tio.c_lflag = 0;

  /* 8 data bits, no parity, 1 stop bit, ignore modem, enable RX. */

  tio.c_cflag &= ~CSIZE;
  tio.c_cflag |= CS8;
  tio.c_cflag &= ~(PARENB | CSTOPB);
  tio.c_cflag |= CLOCAL | CREAD;

  cfsetspeed(&tio, UART_BAUD);
  tcsetattr(fd, TCSANOW, &tio);

  /* Step 5: 发送 banner */

  for (p = banner; *p != '\0'; p++)
    {
      write(fd, p, 1);
      tcdrain(fd);
    }

  /* Step 6: 回显循环，按 KEY2 退出 */

  while (received < UART_ECHO_MAX)
    {
      if (key2_is_pressed(fd_key))
        {
          key_exit = true;
          break;
        }

      ssize_t n = read(fd, &ch, 1);
      if (n < 0)
        {
          if (errno == EAGAIN || errno == EINTR)
            {
              up_mdelay(10);
              continue;
            }

          break;
        }

      if (n == 0)
        {
          up_mdelay(10);
          continue;
        }

      printf("RX: 0x%02x\n", (uint8_t)ch);

      /* 回显 */

      write(fd, &ch, 1);

      if (ch == '\r' || ch == '\n')
        {
          char nl = '\n';
          write(fd, &nl, 1);
          break;
        }

      received++;
    }

  printf("Done. Received %d bytes. %s\n", received,
         key_exit ? "(exited via KEY2)" : "");
  close(fd);
  close(fd_key);
  return OK;
}
```
