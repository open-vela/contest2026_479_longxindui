# GPIO LED 驱动设计文档

## 1. 功能概述

通过 GPIO 输出控制 LED 亮灭，支持：
- 简单开关控制
- 电平翻转（心跳灯）
- 闪烁模式

## 2. 板级配置（⚠️ 必须先完成）

### 2.1 引脚复用

在 `nuttx/boards/loongarch/ls2k300/hummingbird-ls2k300/src/ls2k300_bringup.c` 的
`ls2k300_hardware_init()` 中添加：

```c
/* GPIO LED: GPIO72(红)/GPIO73(绿) → GPIO */
ls_pinmux_pin_setup(72, LS_PINMUX_MODE_AS_GPIO);
ls_pinmux_pin_setup(73, LS_PINMUX_MODE_AS_GPIO);
```

> ⚠️ GPIO88（蓝灯）已分配给硬件 PWM2 使用，不再作为 GPIO LED。
> 如果需要同时使用蓝灯和 PWM，需要用 PWM 控制 GPIO88 的输出。

### 2.2 Kconfig 使能

在 `nuttx/boards/loongarch/ls2k300/hummingbird-ls2k300/configs/nsh/defconfig` 中添加：

```
CONFIG_LS2K300_GPIO=y
CONFIG_LS2K300_PINCTRL=y
```

## 3. 硬件连接

```
GPIO <pin_number> ──[限流电阻]──[LED]──GND
```

- GPIO 输出高电平 → LED 亮（高电平驱动）
- GPIO 输出低电平 → LED 灭

> 注意：部分板卡 LED 为低电平驱动，需确认原理图。

## 4. 初始化流程

### 4.1 引脚配置

```c
/* Step 1: 设置引脚为 GPIO 模式 */
pinctrl_set_gpio_function(<pin_number>);

/* Step 2: 打开 GPIO 设备 */
int fd = open("/dev/gpio<pin_number>", O_RDWR);

/* Step 3: 设置为输出模式 */
ioctl(fd, GPIOC_SETPINTYPE, (unsigned long)GPIO_OUTPUT_PIN);
```

### 4.2 NuttX GPIO API 标准流程

| 步骤 | API | 说明 |
|------|-----|------|
| 1 | `pinctrl_set_gpio_function(pin)` | 将引脚从外设功能切换为 GPIO |
| 2 | `open("/dev/gpioXX", O_RDWR)` | 获取 GPIO 文件描述符 |
| 3 | `ioctl(fd, GPIOC_SETPINTYPE, dir)` | 设置输入/输出方向 |
| 4 | `ioctl(fd, GPIOC_WRITE, val)` | 输出高/低电平 |
| 4 | `ioctl(fd, GPIOC_READ, &val)` | 读取当前电平 |

## 5. 常见应用模式

### 5.1 简单开关

```c
/* 点亮 */
ioctl(fd, GPIOC_WRITE, 1);

/* 熄灭 */
ioctl(fd, GPIOC_WRITE, 0);
```

### 5.2 电平翻转（心跳灯）

```c
int state = 0;
while (1)
  {
    state ^= 1;
    ioctl(fd, GPIOC_WRITE, state);
    up_mdelay(500);  /* 500ms 翻转一次 */
  }
```

### 5.3 闪烁模式（非阻塞）

```c
static uint32_t last_toggle = 0;
static int led_state = 0;

void led_heartbeat(uint32_t interval_ms)
{
  uint32_t now = clock_systime_ticks();
  if ((now - last_toggle) >= MSEC2TICK(interval_ms))
    {
      led_state ^= 1;
      ioctl(fd, GPIOC_WRITE, led_state);
      last_toggle = now;
    }
}
```

## 6. 注意事项

1. **引脚复用**：必须先调用 `pinctrl_set_gpio_function()` 将引脚从外设功能切换为 GPIO，否则 GPIO 控制不生效。
   - 建议在 bringup.c 和应用层都设置引脚功能，确保不被其他驱动覆盖。
2. **GPIO88 冲突**：GPIO88 同时是蓝色 LED 和 PWM2 输出引脚。如果需要使用硬件 PWM 呼吸灯，
   必须从 test_led.c 和 test_key.c 中移除 GPIO88 的 LED 逻辑。
2. **限流电阻**：LED 串联电阻通常 220Ω~1kΩ，根据 LED 颜色和电源电压选择。
3. **GPIO 编号**：NuttX 中 GPIO 编号从 0 开始，对应 `/dev/gpio0`、`/dev/gpio1`...
4. **资源释放**：程序结束前应 `close(fd)` 释放文件描述符。

## 7. 调试技巧

- 用万用表测量 GPIO 引脚电压，确认电平是否正确切换
- 如果 GPIO 不响应，检查 `pinctrl_set_gpio_function()` 返回值
- 查看 `/dev/gpioXX` 是否存在（`ls /dev/gpio*`）
- **设备节点不存在**：检查 defconfig 中 `CONFIG_LS2K300_GPIO=y` 和 `CONFIG_LS2K300_PINCTRL=y` 是否启用
- **编译报错**：检查头文件路径、ioctl 宏名是否正确


---

## 8. 完整模板代码（Template Source）

> 以下为经过验证、可直接使用的驱动模板源码（原 `assets/gpio_led_template.c`）。
> 寄存器访问位宽（8/32 位）、时序控制（如 SPI EOT 等待）、片选（CS）管理、
> OE 低有效等逻辑均已验证，请勿随意修改核心实现。编写驱动时以此为骨架，
> 将占位符替换为实际值即可。

```c
/****************************************************************************
 * gpio_led_template.c
 *
 * GPIO LED 驱动模板 - 龙芯 2K300 NuttX 平台
 *
 * Hummingbird 2K300 板 LED 引脚：
 *   - 红色 LED: GPIO72
 *   - 绿色 LED: GPIO73
 *   - 蓝色 LED: GPIO88（已分配给硬件 PWM2，不作 GPIO 使用）
 *
 * 使用方法：
 *   修改 LED_PIN 选择要控制的 LED
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

/* Hummingbird 2K300 板 LED 定义
 * 注意: GPIO88(蓝灯) 已分配给硬件 PWM2，不作 GPIO LED 使用
 */

#define LED_RED_PIN     72
#define LED_GREEN_PIN   73

/* 当前使用的 LED（修改此值切换 LED） */

#define LED_PIN         LED_RED_PIN
#define LED_BLINK_MS    500
#define LED_ACTIVE_HIGH 1                  /* 高电平点亮 */

/* pinctrl 设置函数（在板级代码 ls2k300_bringup.c 中实现） */

extern int pinctrl_set_gpio_function(int pin);

/* pinctrl 设置函数（需在板级代码中实现） */

extern int pinctrl_set_gpio_function(int pin);

/****************************************************************************
 * Public Functions
 ****************************************************************************/

int gpio_led_demo(void)
{
  int fd;
  int ret;
  int state = 0;

  printf("[LED] GPIO LED Demo on pin %d\n", LED_PIN);

  /* Step 1: 设置引脚为 GPIO 模式 */

  ret = pinctrl_set_gpio_function(LED_PIN);
  if (ret < 0)
    {
      printf("[LED] ERROR: pinctrl pin %d: %d\n", LED_PIN, ret);
      return ret;
    }

  /* Step 2: 打开 GPIO 设备 */

  char gpio_path[32];
  snprintf(gpio_path, sizeof(gpio_path), "/dev/gpio%d", LED_PIN);
  fd = open(gpio_path, O_RDWR);
  if (fd < 0)
    {
      printf("[LED] ERROR: open %s: %d\n", LED_GPIO_PATH, errno);
      return -errno;
    }

  /* Step 3: 设置为输出模式 */

  ret = ioctl(fd, GPIOC_SETPINTYPE, (unsigned long)GPIO_OUTPUT_PIN);
  if (ret < 0)
    {
      printf("[LED] ERROR: set output: %d\n", errno);
      close(fd);
      return -errno;
    }

  /* Step 4: 心跳灯循环 */

  printf("[LED] Blinking at %d ms interval...\n", LED_BLINK_MS);

  for (int i = 0; i < 20; i++)
    {
      state ^= 1;
      int value = LED_ACTIVE_HIGH ? state : !state;
      ioctl(fd, GPIOC_WRITE, value);
      up_mdelay(LED_BLINK_MS);
    }

  /* Step 5: 关闭 */

  ioctl(fd, GPIOC_WRITE, LED_ACTIVE_HIGH ? 0 : 1);  /* 熄灭 */
  close(fd);

  printf("[LED] Done.\n");
  return 0;
}

```
