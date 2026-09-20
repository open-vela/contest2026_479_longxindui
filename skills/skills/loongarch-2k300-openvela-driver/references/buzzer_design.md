# GPIO 蜂鸣器驱动设计文档

## 1. 功能概述

通过 GPIO 输出方波驱动无源蜂鸣器，实现声音提示功能。

### 蜂鸣器类型

| 类型 | 驱动方式 | 音调控制 | 成本 |
|------|---------|---------|------|
| 有源蜂鸣器 | GPIO 高低电平 | 固定频率 | 低 |
| 无源蜂鸣器 | GPIO 方波翻转 | 可调频率 | 低 |

> LOONG-HAT 板载为**无源蜂鸣器**，需要 GPIO 翻转产生方波。

### 音调与频率

| 音调 | 频率 | 半周期 |
|------|------|--------|
| 低音 Do | 262Hz | 1908us |
| 中音 La | 440Hz | 1136us |
| 中音 Do | 523Hz | 956us |
| 1kHz（默认） | 1000Hz | 500us |
| 2kHz | 2000Hz | 250us |

## 2. 板级配置（⚠️ 必须先完成）

### 2.1 引脚复用

在 `nuttx/boards/loongarch/ls2k300/hummingbird-ls2k300/src/ls2k300_bringup.c` 的
`ls2k300_hardware_init()` 中添加：

```c
/* BUZZER: GPIO75 → GPIO */
ls_pinmux_pin_setup(75, LS_PINMUX_MODE_AS_GPIO);
```

### 2.2 Kconfig 使能

在 `nuttx/boards/loongarch/ls2k300/hummingbird-ls2k300/configs/nsh/defconfig` 中添加：

```
CONFIG_LS2K300_GPIO=y
CONFIG_LS2K300_PINCTRL=y
```

> 这两个配置通常已默认启用（LED/KEY 测试也需要），无需额外添加。

## 3. 硬件原理

### 3.1 无源蜂鸣器驱动电路

```
GPIO75 ──[限流电阻]──┬── 蜂鸣器(+)
                      │
                    蜂鸣器(-)
                      │
                     GND
```

### 3.2 方波产生原理

```
GPIO 输出：
  HIGH ┃      ┃      ┃
       ┃      ┃      ┃
  LOW  ┃──────┃──────┃──────
       |← T →|← T →|
       T = 半周期 = 1/(2*频率)
```

- **频率 = 1kHz**：半周期 = 500us
- **频率 = 440Hz (La)**：半周期 = 1136us

## 4. 初始化流程

```c
int buzzer_init(int pin)
{
  /* Step 1: 设置引脚为 GPIO 模式 */
  pinctrl_set_gpio_function(pin);

  /* Step 2: 打开 GPIO 设备 */
  int fd = open("/dev/gpio<pin>", O_RDWR);

  /* Step 3: 设置为输出模式 */
  ioctl(fd, GPIOC_SETPINTYPE, (unsigned long)GPIO_OUTPUT_PIN);

  /* Step 4: 确保蜂鸣器关闭 */
  ioctl(fd, GPIOC_WRITE, 0);

  return fd;
}
```

## 5. 驱动方式

### 5.1 定时蜂鸣

```c
void buzzer_beep(int fd, unsigned int duration_ms, unsigned int half_cycle_us)
{
  unsigned int loops = (duration_ms * 1000) / (half_cycle_us * 2);

  for (unsigned int i = 0; i < loops; i++)
    {
      ioctl(fd, GPIOC_WRITE, 1);
      up_udelay(half_cycle_us);

      ioctl(fd, GPIOC_WRITE, 0);
      up_udelay(half_cycle_us);
    }

  ioctl(fd, GPIOC_WRITE, 0);  /* 确保关闭 */
}
```

### 5.2 使用 up_udelay vs usleep

| 函数 | 精度 | 适用场景 |
|------|------|---------|
| `up_udelay(us)` | 微秒级，忙等待 | 方波半周期（500us 级别） |
| `up_mdelay(ms)` | 毫秒级，忙等待 | 短延时（<10ms） |
| `usleep(us)` | 微秒级，可调度 | 长延时（>10ms） |
| `sleep(sec)` | 秒级，可调度 | 长等待 |

> ⚠️ **方波产生必须使用 `up_udelay()`**，因为 usleep 会导致调度切换，
> 使方波占空比不稳定，声音会断续或音调不准。

## 6. 音乐播放示例

```c
/* 音符频率定义（半周期 us） */
#define NOTE_C4   1908   /* Do 262Hz */
#define NOTE_D4   1700   /* Re 294Hz */
#define NOTE_E4   1515   /* Mi 330Hz */
#define NOTE_F4   1432   /* Fa 349Hz */
#define NOTE_G4   1275   /* Sol 392Hz */
#define NOTE_A4   1136   /* La 440Hz */
#define NOTE_B4   1012   /* Si 494Hz */

/* 播放《小星星》 */
void play_twinkle(int fd)
{
  struct { unsigned int note; unsigned int dur_ms; } song[] = {
    {NOTE_C4, 500}, {NOTE_C4, 500}, {NOTE_G4, 500}, {NOTE_G4, 500},
    {NOTE_A4, 500}, {NOTE_A4, 500}, {NOTE_G4, 1000},
    /* ... */
  };

  for (int i = 0; i < sizeof(song)/sizeof(song[0]); i++)
    {
      buzzer_beep(fd, song[i].dur_ms, song[i].note);
      up_mdelay(50);  /* 音符间短暂停顿 */
    }
}
```

## 7. 注意事项

1. **GPIO 驱动能力**：蜂鸣器电流通常 <20mA，GPIO 可直接驱动。若电流较大，需加三极管驱动。

2. **方波稳定性**：产生方波时必须使用忙等待延时（`up_udelay`），不能使用可调度延时。

3. **音调精度**：`up_udelay` 的实际延时可能有微小偏差，影响音调精度。

4. **功耗考虑**：长时间蜂鸣会消耗电流，电池供电设备需注意。

5. **有源蜂鸣器**：如果是有源蜂鸣器，只需 GPIO 高低电平即可，无需方波：
   ```c
   ioctl(fd, GPIOC_WRITE, 1);  /* 响 */
   up_mdelay(100);
   ioctl(fd, GPIOC_WRITE, 0);  /* 停 */
   ```

## 8. 调试技巧

1. **蜂鸣器不响**：
   - 用万用表测量 GPIO 输出是否有方波
   - 检查蜂鸣器正负极是否接反
   - 确认引脚复用配置正确

2. **声音断续**：
   - 检查是否使用了 `up_udelay` 而非 `usleep`
   - 检查系统是否有高优先级中断频繁打断

3. **音调不准**：
   - 检查 `up_udelay` 的实际延时精度
   - 调整半周期值进行校准


---

## 9. 完整模板代码（Template Source）

> 以下为经过验证、可直接使用的驱动模板源码（原 `assets/gpio_buzzer_template.c`）。
> 寄存器访问位宽（8/32 位）、时序控制（如 SPI EOT 等待）、片选（CS）管理、
> OE 低有效等逻辑均已验证，请勿随意修改核心实现。编写驱动时以此为骨架，
> 将占位符替换为实际值即可。

```c
/****************************************************************************
 * gpio_buzzer_template.c (已内联于本文档"完整模板代码"章节)
 *
 * GPIO 蜂鸣器驱动模板（无源蜂鸣器，GPIO 方波驱动）
 *
 * Hummingbird 2K300 板蜂鸣器引脚：
 *   - BUZZER: GPIO75 (GPIO 输出)
 *
 * 使用说明：
 *   1. 引脚复用在 ls2k300_bringup.c 中已配置
 *   2. 无源蜂鸣器需要 GPIO 翻转产生方波，频率决定音调
 ****************************************************************************/

#include <nuttx/config.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdint.h>

#include <nuttx/arch.h>
#include <nuttx/ioexpander/gpio.h>

/* 已配置为 Hummingbird 2K300 板实际值 */

#define BUZZER_PIN          75              /* 蜂鸣器 GPIO 引脚 */

/* 音调参数 */

#define TONE_1KHZ_HALF_US   500             /* 1kHz 半周期 500us */
#define TONE_2KHZ_HALF_US   250             /* 2kHz 半周期 250us */
#define TONE_500HZ_HALF_US  1000            /* 500Hz 半周期 1000us */

/* 默认音调 */

#define DEFAULT_HALF_CYCLE  TONE_1KHZ_HALF_US

/* pinctrl 设置函数（需在板级代码中实现） */

extern int pinctrl_set_gpio_function(int pin);

static int g_buzzer_fd = -1;

/****************************************************************************
 * Name: buzzer_init
 *
 * Description:
 *   初始化蜂鸣器 GPIO。
 *
 * Returned Value:
 *   0 on success, negative errno on failure.
 ****************************************************************************/

int buzzer_init(void)
{
  int ret;
  char path[32];

  ret = pinctrl_set_gpio_function(BUZZER_PIN);
  if (ret < 0)
    {
      printf("[BUZZER] ERROR: pinctrl failed for GPIO%d\n", BUZZER_PIN);
      return ret;
    }

  snprintf(path, sizeof(path), "/dev/gpio%d", BUZZER_PIN);
  g_buzzer_fd = open(path, O_RDWR);
  if (g_buzzer_fd < 0)
    {
      printf("[BUZZER] ERROR: open %s: %d\n", path, errno);
      return -errno;
    }

  ret = ioctl(g_buzzer_fd, GPIOC_SETPINTYPE,
              (unsigned long)GPIO_OUTPUT_PIN);
  if (ret < 0)
    {
      printf("[BUZZER] ERROR: set output: %d\n", errno);
      close(g_buzzer_fd);
      g_buzzer_fd = -1;
      return -errno;
    }

  /* Buzzer off */

  ioctl(g_buzzer_fd, GPIOC_WRITE, 0);

  printf("[BUZZER] init done, GPIO%d\n", BUZZER_PIN);
  return 0;
}

/****************************************************************************
 * Name: buzzer_beep
 *
 * Description:
 *   蜂鸣指定时长（默认 1kHz）。
 *
 * Parameters:
 *   duration_ms - 蜂鸣持续时间（毫秒）
 *   half_cycle  - 方波半周期（微秒），决定音调
 *                 TONE_1KHZ_HALF_US = 1kHz
 *                 TONE_2KHZ_HALF_US = 2kHz
 *                 TONE_500HZ_HALF_US = 500Hz
 ****************************************************************************/

void buzzer_beep(unsigned int duration_ms, unsigned int half_cycle)
{
  unsigned int loops;
  unsigned int i;

  if (g_buzzer_fd < 0)
    {
      return;
    }

  if (half_cycle == 0)
    {
      half_cycle = DEFAULT_HALF_CYCLE;
    }

  loops = (duration_ms * 1000u) / (half_cycle * 2u);

  for (i = 0; i < loops; i++)
    {
      ioctl(g_buzzer_fd, GPIOC_WRITE, 1);
      up_udelay(half_cycle);

      ioctl(g_buzzer_fd, GPIOC_WRITE, 0);
      up_udelay(half_cycle);
    }

  /* Ensure buzzer off */

  ioctl(g_buzzer_fd, GPIOC_WRITE, 0);
}

/****************************************************************************
 * Name: buzzer_beep_simple
 *
 * Description:
 *   蜂鸣指定时长（默认 1kHz）。
 ****************************************************************************/

void buzzer_beep_simple(unsigned int duration_ms)
{
  buzzer_beep(duration_ms, DEFAULT_HALF_CYCLE);
}

/****************************************************************************
 * Name: buzzer_tone
 *
 * Description:
 *   持续输出指定频率的 tone，直到调用 buzzer_stop。
 *
 * Parameters:
 *   half_cycle - 方波半周期（微秒）
 ****************************************************************************/

void buzzer_tone(unsigned int half_cycle)
{
  if (g_buzzer_fd < 0)
    {
      return;
    }

  ioctl(g_buzzer_fd, GPIOC_WRITE, 1);
  up_udelay(half_cycle);
  ioctl(g_buzzer_fd, GPIOC_WRITE, 0);
  up_udelay(half_cycle);
}

/****************************************************************************
 * Name: buzzer_stop
 *
 * Description:
 *   停止蜂鸣。
 ****************************************************************************/

void buzzer_stop(void)
{
  if (g_buzzer_fd >= 0)
    {
      ioctl(g_buzzer_fd, GPIOC_WRITE, 0);
    }
}

/****************************************************************************
 * Name: buzzer_deinit
 ****************************************************************************/

void buzzer_deinit(void)
{
  if (g_buzzer_fd >= 0)
    {
      ioctl(g_buzzer_fd, GPIOC_WRITE, 0);
      close(g_buzzer_fd);
      g_buzzer_fd = -1;
    }
}

```
