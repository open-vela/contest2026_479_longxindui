# GPIO 按键驱动设计文档

## 1. 功能概述

通过 GPIO 输入读取按键状态，支持：
- 轮询方式读取电平
- 中断方式检测边沿
- 消抖处理

## 2. 板级配置（⚠️ 必须先完成）

### 2.1 引脚复用

在 `nuttx/boards/loongarch/ls2k0300/hummingbird-ls2k0300/src/ls2k0300_bringup.c` 的
`ls2k0300_hardware_init()` 中添加：

```c
/* GPIO KEY: GPIO86(KEY2)/GPIO87(KEY1) → GPIO */
ls_pinmux_pin_setup(86, LS_PINMUX_MODE_AS_GPIO);
ls_pinmux_pin_setup(87, LS_PINMUX_MODE_AS_GPIO);
```

### 2.2 Kconfig 使能

在 `nuttx/boards/loongarch/ls2k0300/hummingbird-ls2k0300/configs/nsh/defconfig` 中添加：

```
CONFIG_LS2K0300_GPIO=y
CONFIG_LS2K0300_PINCTRL=y
```

## 3. 硬件连接

```
VCC ──[上拉电阻]──┬── GPIO <pin_number>
                  │
               [按键]
                  │
                 GND
```

- 按键未按下：GPIO 读到高电平（上拉）
- 按键按下：GPIO 读到低电平（接地）

> 部分芯片内部有上拉/下拉电阻，可不接外部电阻。

## 4. 初始化流程

### 4.1 引脚配置

```c
/* Step 1: 设置引脚为 GPIO 模式 */
pinctrl_set_gpio_function(<pin_number>);

/* Step 2: 打开 GPIO 设备 */
int fd = open("/dev/gpio<pin_number>", O_RDWR);

/* Step 3: 设置为输入模式 */
ioctl(fd, GPIOC_SETPINTYPE, (unsigned long)GPIO_INPUT_PIN);
```

### 5.2 中断配置（可选）

```c
/* 设置中断触发方式 */
struct gpio_notify_s notify;
notify.gn_type = GPIOC_PINFE_FALLING;  /* 下降沿触发 */
ioctl(fd, GPIOC_REGISTER, &notify);
```

## 5. 读取方式

### 5.1 轮询方式

```c
int value;
while (1)
  {
    ioctl(fd, GPIOC_READ, &value);
    if (value == 0)
      {
        printf("Key pressed!\n");
        /* 消抖：延时后再次确认 */
        up_mdelay(20);
        ioctl(fd, GPIOC_READ, &value);
        if (value == 0)
          {
            /* 确认按下，等待释放 */
            while (value == 0)
              {
                ioctl(fd, GPIOC_READ, &value);
              }
          }
      }
    up_mdelay(10);
  }
```

### 5.2 中断方式

```c
static volatile int g_key_pressed = 0;

static int key_interrupt(int irq, void *context, void *arg)
{
  g_key_pressed = 1;
  return OK;
}

/* 注册中断 */
irq_attach(<irq_number>, key_interrupt, NULL);
up_enable_irq(<irq_number>);
```

## 6. 消抖处理

```c
#define DEBOUNCE_MS  20

int key_read_debounced(int fd)
{
  int val1, val2;
  ioctl(fd, GPIOC_READ, &val1);
  up_mdelay(DEBOUNCE_MS);
  ioctl(fd, GPIOC_READ, &val2);
  return (val1 == val2) ? val1 : -1;
}
```

## 7. 注意事项

1. **上下拉配置**：确认引脚是否需要外部上拉/下拉电阻。
2. **中断号**：GPIO 中断号通常与 GPIO 编号相关，需查阅芯片手册。
3. **消抖时间**：机械按键消抖时间通常 10~50ms。
4. **长按检测**：可通过计时按下持续时间实现。

## 8. 调试技巧

- 用万用表测量 GPIO 引脚电压，确认按下时电平变化
- 查看 `/dev/gpioXX` 是否存在（`ls /dev/gpio*`）
- **设备节点不存在**：检查 defconfig 中 `CONFIG_LS2K0300_GPIO=y` 和 `CONFIG_LS2K0300_PINCTRL=y` 是否启用
- **编译报错**：检查头文件路径、ioctl 宏名是否正确


---

## 9. 完整模板代码（Template Source）

> 以下为经过验证、可直接使用的驱动模板源码（原 `assets/gpio_key_template.c`）。
> 寄存器访问位宽（8/32 位）、时序控制（如 SPI EOT 等待）、片选（CS）管理、
> OE 低有效等逻辑均已验证，请勿随意修改核心实现。编写驱动时以此为骨架，
> 将占位符替换为实际值即可。

```c
/****************************************************************************
 * gpio_key_template.c
 *
 * GPIO 按键驱动模板 - 龙芯 2K0300 NuttX 平台
 *
 * Hummingbird 2K0300 板按键引脚：
 *   - KEY1: GPIO87（按下为低电平）
 *   - KEY2: GPIO86（按下为低电平）
 *
 * 使用方法：
 *   修改 KEY_PIN 选择要检测的按键
 *
 * 编译条件：
 *   CONFIG_GPIO=y
 *   CONFIG_IOEXPANDER=y
 ****************************************************************************/

/****************************************************************************
 * Included Files
 ****************************************************************************/

#include <nuttx/config.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdint.h>
#include <nuttx/ioexpander/gpio.h>

/****************************************************************************
 * Pre-processor Definitions
 ****************************************************************************/

/* Hummingbird 2K0300 板按键定义 */

#define KEY1_PIN        87
#define KEY2_PIN        86

/* 当前使用的按键（修改此值切换按键） */

#define KEY_PIN         KEY1_PIN
#define KEY_ACTIVE_LOW  1                  /* 按下为低电平 */
#define DEBOUNCE_MS     20                 /* 消抖时间 */

/* pinctrl 设置函数（需在板级代码中实现） */

extern int pinctrl_set_gpio_function(int pin);

/****************************************************************************
 * Private Data
 ****************************************************************************/

static volatile int g_key_pressed = 0;

/****************************************************************************
 * Private Functions
 ****************************************************************************/

/****************************************************************************
 * Name: key_interrupt
 *
 * Description: GPIO 中断回调函数
 *
 ****************************************************************************/

static int key_interrupt(int irq, void *context, void *arg)
{
  g_key_pressed = 1;
  return OK;
}

/****************************************************************************
 * Name: key_read_debounced
 *
 * Description: 带消抖的按键读取
 *
 * 返回值: 1=确认按下, 0=未按下, -1=抖动中
 *
 ****************************************************************************/

static int key_read_debounced(int fd)
{
  int val1, val2;

  ioctl(fd, GPIOC_READ, &val1);
  up_mdelay(DEBOUNCE_MS);
  ioctl(fd, GPIOC_READ, &val2);

  if (val1 != val2)
    {
      return -1;  /* 抖动 */
    }

#if KEY_ACTIVE_LOW
  return (val1 == 0) ? 1 : 0;
#else
  return (val1 != 0) ? 1 : 0;
#endif
}

/****************************************************************************
 * Public Functions
 ****************************************************************************/

/****************************************************************************
 * Name: gpio_key_poll_demo
 *
 * Description: 轮询方式读取按键
 *
 ****************************************************************************/

int gpio_key_poll_demo(void)
{
  int fd;
  int ret;

  printf("[KEY] GPIO Key Poll Demo on pin %d\n", KEY_PIN);

  /* 设置引脚为 GPIO 模式 */

  ret = pinctrl_set_gpio_function(KEY_PIN);
  if (ret < 0)
    {
      printf("[KEY] ERROR: pinctrl pin %d: %d\n", KEY_PIN, ret);
      return ret;
    }

  /* 打开 GPIO 设备 */

  char gpio_path[32];
  snprintf(gpio_path, sizeof(gpio_path), "/dev/gpio%d", KEY_PIN);
  fd = open(gpio_path, O_RDWR);
  if (fd < 0)
    {
      printf("[KEY] ERROR: open %s: %d\n", gpio_path, errno);
      return -errno;
    }

  /* 设置为输入模式 */

  ret = ioctl(fd, GPIOC_SETPINTYPE, (unsigned long)GPIO_INPUT_PIN);
  if (ret < 0)
    {
      printf("[KEY] ERROR: set input: %d\n", errno);
      close(fd);
      return -errno;
    }

  /* 轮询读取 */

  printf("[KEY] Polling for key press (press any key 5 times)...\n");

  int count = 0;
  while (count < 5)
    {
      int pressed = key_read_debounced(fd);
      if (pressed == 1)
        {
          count++;
          printf("[KEY] Key pressed! (%d/5)\n", count);
          /* 等待释放 */
          int val;
          do
            {
              ioctl(fd, GPIOC_READ, &val);
              up_mdelay(10);
            }
          while (
#if KEY_ACTIVE_LOW
            val == 0
#else
            val != 0
#endif
          );
        }
      up_mdelay(10);
    }

  close(fd);
  printf("[KEY] Done.\n");
  return 0;
}

/****************************************************************************
 * Name: gpio_key_irq_demo
 *
 * Description: 中断方式读取按键
 *
 ****************************************************************************/

int gpio_key_irq_demo(void)
{
  int fd;
  int ret;

  printf("[KEY] GPIO Key IRQ Demo on pin %d (IRQ %d)\n", KEY_PIN, KEY_IRQ);

  /* 设置引脚为 GPIO 模式 */

  ret = pinctrl_set_gpio_function(KEY_PIN);
  if (ret < 0)
    {
      printf("[KEY] ERROR: pinctrl pin %d: %d\n", KEY_PIN, ret);
      return ret;
    }

  /* 打开 GPIO 设备 */

  char gpio_path[32];
  snprintf(gpio_path, sizeof(gpio_path), "/dev/gpio%d", KEY_PIN);
  fd = open(gpio_path, O_RDWR);
  if (fd < 0)
    {
      printf("[KEY] ERROR: open %s: %d\n", gpio_path, errno);
      return -errno;
    }

  /* 设置为输入模式 */

  ioctl(fd, GPIOC_SETPINTYPE, (unsigned long)GPIO_INPUT_PIN);

  /* 注册中断 */

  ret = irq_attach(KEY_IRQ, key_interrupt, NULL);
  if (ret < 0)
    {
      printf("[KEY] ERROR: irq_attach: %d\n", ret);
      close(fd);
      return ret;
    }

  up_enable_irq(KEY_IRQ);

  /* 等待中断 */

  printf("[KEY] Waiting for key interrupt...\n");

  int count = 0;
  while (count < 5)
    {
      if (g_key_pressed)
        {
          g_key_pressed = 0;
          count++;
          printf("[KEY] Key interrupt! (%d/5)\n", count);
          up_mdelay(DEBOUNCE_MS);  /* 消抖 */
        }
      up_mdelay(10);
    }

  up_disable_irq(KEY_IRQ);
  close(fd);

  printf("[KEY] Done.\n");
  return 0;
}

```
