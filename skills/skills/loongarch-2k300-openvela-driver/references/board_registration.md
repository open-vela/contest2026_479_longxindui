# 板级注册与配置（Board Registration）

> [!IMPORTANT] 这是 2K300 驱动开发中最易出错、最常被遗漏的环节
>
> 板级配置（引脚复用 + Kconfig 使能）**必须在编写驱动代码之前完成**。
> 遗漏板级配置是 Hummingbird 2K300 平台驱动开发中最常见的错误。
> 本文档将原 SKILL.md 中分散的引脚复用、Kconfig 依赖、pinctrl 双层设置等内容集中于此。

## Table of Contents

1. [板级文件清单](#板级文件清单)
2. [引脚复用（Pinmux）双层设置原则](#引脚复用pinmux双层设置原则)
3. [bringup.c 引脚复用配置](#bringupc-引脚复用配置)
4. [应用层 pinctrl 设置](#应用层-pinctrl-设置)
5. [Kconfig 依赖表](#kconfig-依赖表)
6. [引脚冲突检查](#引脚冲突检查)
7. [defconfig 检查流程](#defconfig-检查流程)

---

## 板级文件清单

需要配合修改的板级文件（不在 Skill 目录内）：

| 文件 | 作用 | 关键点 |
|------|------|--------|
| `nuttx/boards/loongarch/ls2k300/hummingbird-ls2k300/src/ls2k300_bringup.c` | 引脚复用配置（`ls2k300_hardware_init`） | 第一层 pinmux |
| `nuttx/boards/loongarch/ls2k300/hummingbird-ls2k300/configs/nsh/defconfig` | Kconfig 使能 | ⚠️ 必须包含 `CONFIG_I2C_DRIVER=y` |
| `nuttx/arch/loongarch/src/ls2k300/ls2k300_pwm.c` | PWM 驱动 | ⚠️ OE 位低有效 |
| `nuttx/arch/loongarch/src/ls2k300/ls2k300_serial.c` | UART 串口驱动 | ⚠️ 注册 `/dev/ttySn` 节点 |
| `nuttx/arch/loongarch/src/ls2k300/ls2k300_config.h` | UART 编译开关 | ⚠️ `HAVE_UART_DEVICE` 需含目标 UART |
| `nuttx/arch/loongarch/src/ls2k300/Kconfig` | UART Kconfig 选项 | `LS2K300_UARTn` + `UARTn_BAUD/RXBUFSIZE/TXBUFSIZE` |
| `apps/examples/ls_driver_test/` | 测试程序注册 | ⚠️ `Makefile` CSRCS 与 `CMakeLists.txt` SRCS 两处都要登记 |

## 引脚复用（Pinmux）双层设置原则

> ⚠️ **引脚复用必须双层设置，缺一不可**

1. **第一层（bringup.c）**：在 `ls2k300_hardware_init()` 中调用 `ls_pinmux_pin_setup()` 设置系统启动时的初始引脚功能。
2. **第二层（应用层 pinctrl）**：应用层使用引脚前，必须通过 `/dev/pinctrl0` + `PINCTRLC_SETFUNCTION` 再次确认引脚功能。
3. **原因**：系统启动过程中，其他驱动可能已覆盖引脚设置（例如 LED 测试会把 GPIO88 重置为 GPIO 模式，导致 PWM 失效）。

> 对于 PWM 驱动，在 test_pwm.c 中**必须**调用 pinctrl 将 GPIO88 设置为 `SECOND_FUNC`。

## bringup.c 引脚复用配置

在 `ls2k300_bringup.c` 的 `ls2k300_hardware_init()` 中添加：

```c
/* I2C1: GPIO50(SDA)/GPIO51(SCL) → MAIN_FUNC */
ls_pinmux_pin_setup(50, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(51, LS_PINMUX_MODE_AS_MAIN_FUNC);

/* UART2: GPIO44(TX)/GPIO45(RX) → MAIN_FUNC */
ls_pinmux_pin_setup(44, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(45, LS_PINMUX_MODE_AS_MAIN_FUNC);

/* SPI2: GPIO64(CLK)/GPIO65(MISO)/GPIO66(MOSI) → MAIN_FUNC,
 * GPIO67(CS) → GPIO（软件片选） */
ls_pinmux_pin_setup(64, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(65, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(66, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(67, LS_PINMUX_MODE_AS_GPIO);

/* GPIO LED: GPIO72(红)/GPIO73(绿) → GPIO */
ls_pinmux_pin_setup(72, LS_PINMUX_MODE_AS_GPIO);
ls_pinmux_pin_setup(73, LS_PINMUX_MODE_AS_GPIO);

/* GPIO KEY: GPIO86(KEY2)/GPIO87(KEY1) → GPIO */
ls_pinmux_pin_setup(86, LS_PINMUX_MODE_AS_GPIO);
ls_pinmux_pin_setup(87, LS_PINMUX_MODE_AS_GPIO);

/* GPIO Buzzer: GPIO75 → GPIO */
ls_pinmux_pin_setup(75, LS_PINMUX_MODE_AS_GPIO);

/* PWM2: GPIO88 → SECOND_FUNC（该板仅引出 PWM2） */
ls_pinmux_pin_setup(88, LS_PINMUX_MODE_AS_SECOND_FUNC);
```

| 功能模式 | 宏 | 值 |
|---------|-----|----|
| GPIO 模式 | `LS_PINMUX_MODE_AS_GPIO` | 0x0 |
| 第二功能（PWM 等） | `LS_PINMUX_MODE_AS_SECOND_FUNC` | 0x2 |
| 主功能（I2C/SPI 总线） | `LS_PINMUX_MODE_AS_MAIN_FUNC` | 0x3 |

## 应用层 pinctrl 设置

```c
struct pinctrl_param_s param;
int fd = open("/dev/pinctrl0", O_RDWR);
if (fd < 0)
  {
    printf("ERROR: open /dev/pinctrl0: %d\n", errno);
    return -errno;
  }

param.pin = 88;                /* GPIO88 */
param.para.function = 2;       /* SECOND_FUNC */
ioctl(fd, PINCTRLC_SETFUNCTION, (unsigned long)&param);
close(fd);
```

> ⚠️ **易遗漏配置**：`CONFIG_LS2K300_PINCTRL=y` 是引脚控制驱动，没有它
> `/dev/pinctrl0` 不会被创建，应用层无法设置引脚功能。

## Kconfig 依赖表

板级 defconfig 路径：
`nuttx/boards/loongarch/ls2k300/hummingbird-ls2k300/configs/nsh/defconfig`

| 外设模块 | 必需的 Kconfig 选项 | 说明 |
|---------|-------------------|------|
| GPIO（LED/KEY/Buzzer） | `CONFIG_LS2K300_GPIO=y`, `CONFIG_LS2K300_PINCTRL=y` | GPIO 子系统 + 引脚控制 |
| I2C1（BH1750/SSD1306/EEPROM） | `CONFIG_LS2K300_I2C=y`, `CONFIG_LS2K300_I2C1=y`, `CONFIG_I2C_DRIVER=y` | I2C 总线 + I2C1 端口 + 用户空间 I2C 设备 |
| SPI2（MCP3204/SPI Flash） | `CONFIG_LS2K300_SPI=y`, `CONFIG_LS2K300_SPIIO2=y` | SPI 总线 + SPIIO2 端口 |
| ADC | `CONFIG_LS2K300_ADC=y` | ADC 子系统 |
| PWM | `CONFIG_LS2K300_PWM=y`, `CONFIG_LS2K300_PWM2=y` | PWM 子系统 + PWM2 通道 |
| UART2（串口收发） | `CONFIG_LS2K300_UART2=y`, `CONFIG_UART2_BAUD=115200`, `CONFIG_LS2K300_GPIO=y`, `CONFIG_LS2K300_PINCTRL=y` | UART2 端口（/dev/ttyS2）+ GPIO/pinctrl（KEY2 退出用） |
| 测试应用 | `CONFIG_EXAMPLES_LS_DRIVER_TEST=y` | 驱动测试程序 |

> ⚠️ **`CONFIG_I2C_DRIVER=y` 是用户空间 I2C 设备的必要配置**，defconfig 中可能未包含，必须手动添加。
>
> ⚠️ **UART 的 `/dev/ttySn` 节点由内核 serial 驱动注册**，仅开 defconfig 不够——
> 还需 `ls2k300_serial.c` 加 `g_uartNport` 实例、`ls2k300_config.h` 的 `HAVE_UART_DEVICE`
> 含目标 UART、`Kconfig` 定义 `LS2K300_UARTn`。详见 `uart_design.md` 2.3。

## 引脚冲突检查

> ⚠️ **GPIO88 同时是蓝色 LED 和 PWM2 输出引脚**

- 使用硬件 PWM 时，**不能**同时将 GPIO88 作为 GPIO LED 控制。
- 使用 PWM 时，必须从 `test_led.c` / `test_key.c` 中移除 GPIO88 的 LED 逻辑。
- bringup.c 中 GPIO88 只能配置为 `SECOND_FUNC`（PWM）**或** GPIO，二者不可兼得。

> ℹ️ **UART2（GPIO44/GPIO45）无引脚冲突**，专用作串口，可放心复用为主功能。
> UART0 为系统控制台，勿改其引脚配置。

## defconfig 检查流程

1. 先读取 `nuttx/boards/.../configs/nsh/defconfig` 和 `cmake_out/ls2k0300_hummingbird_nsh/.config`，确认哪些 CONFIG 已启用。
2. 按上方 Kconfig 依赖表补齐缺失项。
3. 重点检查：
   - `CONFIG_I2C_DRIVER=y` 是否存在（I2C 外设必备）
   - `CONFIG_LS2K300_PINCTRL=y` 是否存在（pinctrl 设备节点必备）
   - 所用外设的通道/端口 CONFIG 是否启用（如 `CONFIG_LS2K300_PWM2=y`、`CONFIG_LS2K300_UART2=y`）
4. UART 额外确认内核 serial 驱动是否已注册目标通道实例（见 `uart_design.md` 2.3）。

运行 `scripts/validate-boardconfig.sh` 可自动检查 defconfig 中的必需 CONFIG 项。
