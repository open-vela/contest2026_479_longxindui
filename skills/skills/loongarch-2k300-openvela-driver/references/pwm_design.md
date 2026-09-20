# 硬件 PWM 驱动设计文档

## 1. 功能概述

LS2K300 集成 4 路 PWM 控制器（PWM0-PWM3），用于产生脉冲宽度调制信号。
每路 PWM 有独立的计数器、周期/占空比缓冲寄存器和控制寄存器。
该板仅引出了 PWM2（GPIO88）。

### PWM 通道与引脚映射

| PWM 通道 | 设备路径 | 输出引脚 | 功能选择 | 说明 |
|---------|---------|---------|---------|------|
| PWM2 | /dev/pwm2 | GPIO88 | SECOND_FUNC (0x2) | 该板仅引出 PWM2 |

> ⚠️ GPIO88 同时也是蓝色 LED 引脚。使用硬件 PWM 时，
> 不能同时在 test_led.c 中将 GPIO88 作为 GPIO LED 控制。

## 2. 板级配置（⚠️ 必须先完成）

### 2.1 引脚复用（两步都必须做！）

**第一步：bringup.c 中设置**

在 `nuttx/boards/loongarch/ls2k300/hummingbird-ls2k300/src/ls2k300_bringup.c`
的 `ls2k300_hardware_init()` 中添加：

```c
/* PWM2: GPIO88 → SECOND_FUNC */
ls_pinmux_pin_setup(88, LS_PINMUX_MODE_AS_SECOND_FUNC);
```

**第二步：应用层通过 pinctrl 设置（必须！）**

仅在 bringup.c 中设置不够，应用层还必须通过 `/dev/pinctrl0` 设置：

```c
struct pinctrl_param_s param;
int fd = open("/dev/pinctrl0", O_RDWR);
param.pin = 88;
param.para.function = 2;  /* SECOND_FUNC */
ioctl(fd, PINCTRLC_SETFUNCTION, (unsigned long)&param);
close(fd);
```

> 这是因为系统启动后，其他驱动（如 LED 测试）可能会将引脚重新设置为 GPIO 模式。
> PWM 测试程序必须在使用前主动将引脚切换回 PWM 功能。

### 2.2 Kconfig 使能

在 defconfig 中添加：

```
CONFIG_LS2K300_PWM=y
CONFIG_LS2K300_PWM2=y
```

## 3. 硬件原理

### 3.1 PWM 控制器架构

```
系统时钟 (200MHz)
     │
     ▼
┌─────────┐    ┌──────────────┐    ┌──────────┐
│ Full    │───>│  递减计数器   │───>│ PWM 输出  │
│ Buffer  │    │              │    │ (OE控制)  │
└─────────┘    │  Low Buffer  │    └──────────┘
               └──────────────┘
```

### 3.2 PWM 波形产生原理

PWM 输出初始为低电平。计数器从 Full_buffer 值开始递减：
- 当计数器减到 Low_buffer 值时，输出变为高电平
- 当计数器减到 1 时，输出变为低电平，重新加载缓冲值

```
输出：  ┌──────┐         ┌──────┐
        │      │         │      │
  ──────┘      └─────────┘      └─────
        |←High→|← Low  →|
        |←    Full_buffer × Tclk  →|
```

- 高电平时间 = (Full_buffer - Low_buffer) × Tclk
- 周期 = Full_buffer × Tclk
- 占空比 = (Full_buffer - Low_buffer) / Full_buffer

### 3.3 占空比计算

在驱动中：
- `full_buffer = clock_freq × frequency / 1000000`
  - 例：200MHz × 1kHz / 1000000 = 200000
- `low_buffer = full_buffer × duty / 65536`
  - duty 范围 0~65536（NuttX 固定点格式，65536=100%）

## 4. PWM CTRL 寄存器关键位

| Bit | 名称 | 说明 |
|-----|------|------|
| 0 | EN | 计数器使能（1=计数，0=停止） |
| 3 | OE | **脉冲输出使能（低有效！）** |
| 4 | SINGLE | 单脉冲模式 |
| 7 | RST | 计数器重置 |
| 9 | INVERT | 输出翻转 |

> ⚠️ **OE 位是低有效的**（Datasheet page 201, 表21-3）：
> - OE=0 → 脉冲输出使能
> - OE=1 → 脉冲输出屏蔽
>
> 驱动中启动 PWM 时必须清除 OE 位（OE=0），否则输出被屏蔽！

## 5. NuttX PWM API 使用流程

```c
/* 1. 打开设备 */
int fd = open("/dev/pwm2", O_RDONLY);

/* 2. 设置参数 */
struct pwm_info_s info;
info.frequency = 1000;    /* 1kHz */
info.duty      = 32768;   /* 50% (32768/65536) */
ioctl(fd, PWMIOC_SETCHARACTERISTICS, (unsigned long)&info);

/* 3. 启动 */
ioctl(fd, PWMIOC_START, 0);

/* 4. 动态调整占空比 */
info.duty = 16384;  /* 25% */
ioctl(fd, PWMIOC_SETCHARACTERISTICS, (unsigned long)&info);

/* 5. 停止 */
ioctl(fd, PWMIOC_STOP, 0);
close(fd);
```

## 6. 注意事项

1. **OE 位低有效**：这是最常见的坑。驱动中 `ls2k300_pwm_start()` 必须清除 OE 位（OE=0）才能使能输出。

2. **引脚复用双层设置**：bringup.c 中的 `ls_pinmux_pin_setup()` 设置初始引脚功能，但应用层可能被其他驱动覆盖，必须在使用前通过 `PINCTRLC_SETFUNCTION` 重新设置。

3. **GPIO88 冲突**：GPIO88 同时是蓝色 LED 和 PWM2 输出。使用硬件 PWM 时，必须从 test_led.c 和 test_key.c 中移除 GPIO88 的 LED 逻辑。

4. **PWMIOC_START 流程**：LS2K300 的 `ls2k300_pwm_ioctl()` 在处理 PWMIOC_START 时会先调用 `ls2k300_pwm_setup()`（禁用 EN，复位计数器），再调用 `ls2k300_pwm_start()`（设置缓冲值，使能 EN）。

5. **时钟频率**：LS2K300 PWM 时钟为 200MHz。对于 1kHz PWM，full_buffer = 200000。

6. **呼吸灯平滑度**：占空比步进越小、每步延时越长，呼吸效果越平滑。典型配置：100步 × 30ms/步 = 3秒一个完整呼吸周期。

## 7. 调试技巧

1. **PWM 无输出**：
   - 检查 OE 位是否为 0（OE 是低有效，OE=1 会屏蔽输出）
   - 检查引脚复用是否正确（GPIO88 → SECOND_FUNC）
   - 检查应用层是否通过 pinctrl 设置了引脚功能
   - 检查 defconfig 中 `CONFIG_LS2K300_PWM=y` 和 `CONFIG_LS2K300_PWM2=y` 是否启用
   - 用示波器测量 PWM 输出引脚

2. **占空比不正确**：
   - 检查 INVERT 位设置
   - 确认 full_buffer 和 low_buffer 计算正确

3. **LED 不亮但 PWM 有输出**：
   - 检查 LED 极性（高电平亮还是低电平亮）
   - 如果需要反转极性，使用 ioctl 0x2001 设置 INVERT 位

4. **设备节点不存在**：
   - 检查 defconfig 中 `CONFIG_LS2K300_PWM=y` 和对应通道的 CONFIG
   - 检查 bringup.c 中是否调用了 `ls2k300_pwm_initialize(port)`

5. **PWM 与 LED 冲突**：
   - GPIO88 同时是蓝灯和 PWM2，不能同时作为 GPIO LED 和 PWM 使用
   - 使用 PWM 时，test_led.c 中不能将 GPIO88 作为 GPIO LED 控制


---

## 8. 完整模板代码（Template Source）

> 以下为经过验证、可直接使用的驱动模板源码（原 `assets/pwm_template.c`）。
> 寄存器访问位宽（8/32 位）、时序控制（如 SPI EOT 等待）、片选（CS）管理、
> OE 低有效等逻辑均已验证，请勿随意修改核心实现。编写驱动时以此为骨架，
> 将占位符替换为实际值即可。

```c
/****************************************************************************
 * pwm_template.c
 *
 * Hardware PWM 呼吸灯驱动模板 - 龙芯 2K300 NuttX 平台
 *
 * Hummingbird 2K300 板 PWM 引脚（仅引出 PWM2）：
 *   PWM2 → GPIO88 (SECOND_FUNC)
 *
 * 注意：GPIO88 同时也是蓝色 LED 引脚，使用硬件 PWM 时
 *       不能同时作为 GPIO LED 控制。
 *
 * 关键寄存器（PWM CTRL, bit3=OE 低有效）：
 *   OE=0 → 脉冲输出使能
 *   OE=1 → 脉冲输出屏蔽
 *
 * 编译条件：
 *   CONFIG_LS2K300_PWM=y
 *   CONFIG_LS2K300_PWM2=y
 ****************************************************************************/

/****************************************************************************
 * Included Files
 ****************************************************************************/

#include <nuttx/config.h>

#include <sys/ioctl.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>

#include <nuttx/arch.h>
#include <nuttx/timers/pwm.h>
#include <nuttx/pinctrl/pinctrl.h>

/****************************************************************************
 * Pre-processor Definitions
 ****************************************************************************/

/* PWM 设备和引脚配置（按需修改） */

#define PWM_DEVICE          "/dev/pwm2"
#define PWM_GPIO            88          /* PWM2 输出引脚 */
#define PWM_FUNCTION        2           /* SECOND_FUNC for PWM */
#define PWM_FREQUENCY       1000        /* 1kHz */

/* 呼吸灯参数 */

#define BREATH_STEPS        100         /* 占空比步数 */
#define BREATH_DELAY_MS     30          /* 每步延时(ms) */
#define BREATH_CYCLES       3           /* 完整呼吸周期数 */

/* NuttX PWM 占空比范围: 0 ~ 65536 */

#define PWM_DUTY_MAX        65536

/****************************************************************************
 * Private Functions
 ****************************************************************************/

/* 通过 pinctrl 将 GPIO 引脚切换为 PWM 功能
 *
 * 关键点：仅在 bringup.c 中调用 ls_pinmux_pin_setup() 是不够的，
 * 还必须在应用层通过 /dev/pinctrl0 设置 PINCTRLC_SETFUNCTION，
 * 否则引脚可能仍处于 GPIO 模式。
 */

static int pwm_pinctrl_setup(void)
{
  struct pinctrl_param_s param;
  int fd;
  int ret;

  printf("[PWM] Setting GPIO%d to function %d...\n",
         PWM_GPIO, PWM_FUNCTION);

  fd = open("/dev/pinctrl0", O_RDWR);
  if (fd < 0)
    {
      printf("[PWM] ERROR: open /dev/pinctrl0: %d\n", errno);
      return -errno;
    }

  param.pin = PWM_GPIO;
  param.para.function = PWM_FUNCTION;
  ret = ioctl(fd, PINCTRLC_SETFUNCTION, (unsigned long)&param);
  if (ret < 0)
    {
      printf("[PWM] ERROR: SETFUNCTION GPIO%d func=%d: %d\n",
             PWM_GPIO, PWM_FUNCTION, errno);
      close(fd);
      return -errno;
    }

  printf("[PWM] GPIO%d -> function %d OK\n", PWM_GPIO, PWM_FUNCTION);
  close(fd);
  return OK;
}

/****************************************************************************
 * Public Functions
 ****************************************************************************/

int test_pwm(void)
{
  int fd;
  int ret;
  struct pwm_info_s info;
  int cycle;
  int step;
  uint32_t duty;

  printf("[PWM] === Hardware PWM Breathing LED Test ===\n");
  printf("[PWM] Device: %s (GPIO%d)\n", PWM_DEVICE, PWM_GPIO);

  /* Step 1: 引脚复用配置（必须！） */

  ret = pwm_pinctrl_setup();
  if (ret < 0)
    {
      printf("[PWM] ERROR: pinctrl setup failed\n");
      return ret;
    }

  /* Step 2: 打开 PWM 设备 */

  fd = open(PWM_DEVICE, O_RDONLY);
  if (fd < 0)
    {
      printf("[PWM] ERROR: open %s: %d\n", PWM_DEVICE, errno);
      return -errno;
    }

  printf("[PWM] %s opened, fd=%d\n", PWM_DEVICE, fd);

  /* Step 3: 设置 PWM 参数 */

  info.frequency = PWM_FREQUENCY;
  info.duty      = 0;

  ret = ioctl(fd, PWMIOC_SETCHARACTERISTICS,
              (unsigned long)(uintptr_t)&info);
  if (ret < 0)
    {
      printf("[PWM] ERROR: SETCHARACTERISTICS: %d\n", errno);
      close(fd);
      return -errno;
    }

  /* Step 4: 启动 PWM */

  ret = ioctl(fd, PWMIOC_START, 0);
  if (ret < 0)
    {
      printf("[PWM] ERROR: START: %d\n", errno);
      close(fd);
      return -errno;
    }

  printf("[PWM] PWM started, breathing...\n");

  /* Step 5: 呼吸灯循环 */

  for (cycle = 0; cycle < BREATH_CYCLES; cycle++)
    {
      printf("[PWM] Cycle %d/%d\n", cycle + 1, BREATH_CYCLES);

      /* 渐亮: 0% → 100% */

      for (step = 0; step <= BREATH_STEPS; step++)
        {
          duty = (uint32_t)step * PWM_DUTY_MAX / BREATH_STEPS;
          info.frequency = PWM_FREQUENCY;
          info.duty      = duty;
          ioctl(fd, PWMIOC_SETCHARACTERISTICS,
                (unsigned long)(uintptr_t)&info);
          up_mdelay(BREATH_DELAY_MS);
        }

      /* 渐暗: 100% → 0% */

      for (step = BREATH_STEPS; step >= 0; step--)
        {
          duty = (uint32_t)step * PWM_DUTY_MAX / BREATH_STEPS;
          info.frequency = PWM_FREQUENCY;
          info.duty      = duty;
          ioctl(fd, PWMIOC_SETCHARACTERISTICS,
                (unsigned long)(uintptr_t)&info);
          up_mdelay(BREATH_DELAY_MS);
        }
    }

  /* Step 6: 停止 PWM */

  info.frequency = PWM_FREQUENCY;
  info.duty      = 0;
  ioctl(fd, PWMIOC_SETCHARACTERISTICS, (unsigned long)(uintptr_t)&info);
  ioctl(fd, PWMIOC_STOP, 0);

  printf("[PWM] Breathing complete, PWM stopped.\n");
  close(fd);

  printf("[PWM] Done.\n");
  return OK;
}

```
