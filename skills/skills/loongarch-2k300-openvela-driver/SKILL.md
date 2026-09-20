---
name: loongarch-2k300-openvela-driver
description: >
  龙芯 LoongArch 2K300 板卡驱动开发 Skill，适用于 OpenVela / NuttX RTOS 平台。
  覆盖 GPIO（按键/LED/蜂鸣器）、硬件 PWM（呼吸灯）、硬件 UART（串口收发）、硬件 SPI（ADC 读取、SPI Flash 存储）、
  I2C 传感器（如 BH1750 光照）、I2C OLED 显示屏、I2C EEPROM 存储等外设驱动
  的编写、调试与验证。
  触发关键词：龙芯、LoongArch、openvela、2K300 驱动、I2C 传感器、OLED 显示、
  SPI ADC、SPI Flash、W25Q、GD25Q、spiflash、flash 存储、GPIO 按键、GPIO LED、
  蜂鸣器、buzzer、EEPROM、AT24C、PWM、呼吸灯、硬件 PWM、pwm、UART、串口、
  ttyS、串口收发、NuttX 驱动开发。
version: "2.0"
tags: [loongarch, nuttx, openvela, driver, spi, i2c, gpio, pwm, uart, 2k300, eeprom, buzzer, spiflash]
---

# LoongArch 2K300 驱动开发 Skill（OpenVela / NuttX）

参考 `nuttx-driver-development` 的结构组织：按 Preparation → Implementation → Review
全生命周期推进，保持每次改动小而可测。所有外设的**完整驱动模板源码已内联在对应
reference 文档中**（原 `assets/` 已删除），编写驱动时直接从 reference 的"完整模板代码"
章节复制骨架并替换占位符。

## Table of Contents

1. [Preparation](#preparation)
   - 明确需求与硬件
   - 查阅硬件规格
   - 确定驱动模式（外设调度表）
   - 配置板级支持
2. [Implementation](#implementation)
   - 选取模板与设计文档（⚠️ 禁止从零编写）
   - 编写与调试驱动
3. [平台编码与内核 API 规则](#平台编码与内核-api-规则)
4. [Verification](#verification)
5. [References](#references)

---

## Preparation

### 1) 明确需求与硬件

- 确认用户要驱动的外设类型（GPIO / SPI / I2C / PWM / UART）。
- 确认具体芯片型号（如 MCP3204、BH1750、SSD1306、W25Q/GD25Q、AT24C）。
- 确认硬件连接（引脚号、总线号、UART 通道号）。

### 2) 查阅硬件规格

打开 `references/hardware_spec.md`，确认：

- 引脚分配表（I2C1 / SPI2 / LED / KEY / Buzzer / PWM / UART 的 GPIO 编号与功能选择）
- 寄存器基地址与偏移量（SPI2 `0x1610c000`、I2C1 `0x16109000`、UART2 `0x16100800` 等）
- 时钟频率（APB 200MHz、SPI 目标 1MHz、I2C 100/400kHz、UART 波特率分频基准 200MHz）
- 非缓存地址映射宏 `PHYS_TO_UNCACHED()`

### 3) 确定驱动模式（外设调度表）

2K300 平台外设均通过 NuttX **POSIX VFS 驱动模型**访问（设备以文件形式出现在 `/dev/`）。
按用户需求加载对应 reference 文档：

| 外设 | 触发关键词 | Reference 文档 | 模板源码章节 |
|------|-----------|----------------|-------------|
| **GPIO 按键** | 按键/中断/key | `references/key_design.md` | 完整模板代码（gpio_key_template） |
| **GPIO LED** | LED/灯 | `references/led_design.md` | 完整模板代码（gpio_led_template） |
| **GPIO 蜂鸣器** | 蜂鸣器/buzzer/声音 | `references/buzzer_design.md` | 完整模板代码（gpio_buzzer_template） |
| **硬件 PWM（呼吸灯）** | PWM/呼吸灯/脉宽调制 | `references/pwm_design.md` | 完整模板代码（pwm_template） |
| **硬件 UART（串口收发）** | UART/串口/ttyS/串口收发 | `references/uart_design.md` | 完整模板代码（uart_template） |
| **SPI ADC** | ADC/SPI/模数转换 | `references/spi_adc_design.md` | 完整模板代码（spi_template） |
| **SPI Flash 存储** | Flash/SPI Flash/存储/W25Q/GD25Q | `references/spi_flash_design.md` | 完整模板代码（spi_flash_template） |
| **I2C 光照传感器** | 光照/亮度/传感器/BH1750 | `references/i2c_light_sensor_design.md` | 完整模板代码（i2c_light_sensor_template） |
| **I2C OLED 显示** | 显示/屏幕/OLED/SSD1306 | `references/i2c_oled_design.md` | 完整模板代码（i2c_oled_template） |
| **I2C EEPROM 存储** | EEPROM/存储/AT24C | `references/i2c_eeprom_design.md` | 完整模板代码（i2c_eeprom_template） |

> [!IMPORTANT] 如何使用此调度表
>
> 1. 从用户请求识别外设类型。
> 2. 加载对应的 reference 文档，获取：板级配置、初始化流程、读写时序、**完整模板源码**、调试技巧。
> 3. 该 reference 文档包含此外设的全部专属知识；本 SKILL.md 只包含跨外设的通用知识。

### 4) 配置板级支持（⚠️ 关键步骤，不可跳过）

> [!WARNING] 遗漏板级配置是最常见的错误
>
> 此步骤必须在编写代码前完成。详细流程见 `references/board_registration.md`，
> 可用 `scripts/validate-boardconfig.sh` 与 `scripts/validate-pinmux.sh` 自动检查。

1. **引脚复用（双层设置，缺一不可）**：
   - 第一层：`ls2k300_bringup.c` 中 `ls2k300_hardware_init()` 调用 `ls_pinmux_pin_setup()`。
   - 第二层：应用层通过 `/dev/pinctrl0` + `PINCTRLC_SETFUNCTION` 再次确认（系统启动后其他驱动可能覆盖引脚设置）。
2. **引脚冲突检查**：GPIO88 同时是蓝色 LED 和 PWM2，不能同时作 GPIO LED 和 PWM。
3. **Kconfig 使能**：在板级 defconfig 中添加所需配置项（见下方 Kconfig 依赖表）。

#### Kconfig 依赖表

| 外设模块 | 必需的 Kconfig 选项 |
|---------|-------------------|
| GPIO（LED/KEY/Buzzer） | `CONFIG_LS2K300_GPIO=y`, `CONFIG_LS2K300_PINCTRL=y` |
| I2C1（BH1750/SSD1306/EEPROM） | `CONFIG_LS2K300_I2C=y`, `CONFIG_LS2K300_I2C1=y`, `CONFIG_I2C_DRIVER=y` |
| SPI2（MCP3204/SPI Flash） | `CONFIG_LS2K300_SPI=y`, `CONFIG_LS2K300_SPIIO2=y` |
| ADC | `CONFIG_LS2K300_ADC=y` |
| PWM | `CONFIG_LS2K300_PWM=y`, `CONFIG_LS2K300_PWM2=y` |
| UART2（串口收发） | `CONFIG_LS2K300_UART2=y`, `CONFIG_UART2_BAUD=115200`, `CONFIG_LS2K300_GPIO=y`, `CONFIG_LS2K300_PINCTRL=y` |

> ⚠️ **易遗漏配置**：
> - `CONFIG_LS2K300_PINCTRL=y` 缺失则 `/dev/pinctrl0` 不被创建。
> - `CONFIG_I2C_DRIVER=y` 是用户空间 I2C 设备的必要配置，defconfig 中常缺失，必须手动添加。
> - UART 的 `/dev/ttySn` 节点由内核 serial 驱动注册，仅开 defconfig 不够还需 `ls2k300_serial.c`/`ls2k300_config.h`/`Kconfig` 三处补实例（见 `uart_design.md` 2.3）。

#### 引脚复用配置示例（bringup.c）

```c
/* I2C1: GPIO50/51 → MAIN_FUNC */
ls_pinmux_pin_setup(50, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(51, LS_PINMUX_MODE_AS_MAIN_FUNC);

/* UART2: GPIO44(TX)/GPIO45(RX) → MAIN_FUNC */
ls_pinmux_pin_setup(44, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(45, LS_PINMUX_MODE_AS_MAIN_FUNC);

/* SPI2: GPIO64/65/66 → MAIN_FUNC, GPIO67 → GPIO(软件CS) */
ls_pinmux_pin_setup(64, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(65, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(66, LS_PINMUX_MODE_AS_MAIN_FUNC);
ls_pinmux_pin_setup(67, LS_PINMUX_MODE_AS_GPIO);

/* GPIO LED: GPIO72(红)/GPIO73(绿) → GPIO */
ls_pinmux_pin_setup(72, LS_PINMUX_MODE_AS_GPIO);
ls_pinmux_pin_setup(73, LS_PINMUX_MODE_AS_GPIO);

/* GPIO KEY: GPIO86/87 → GPIO */
ls_pinmux_pin_setup(86, LS_PINMUX_MODE_AS_GPIO);
ls_pinmux_pin_setup(87, LS_PINMUX_MODE_AS_GPIO);

/* GPIO Buzzer: GPIO75 → GPIO */
ls_pinmux_pin_setup(75, LS_PINMUX_MODE_AS_GPIO);

/* PWM2: GPIO88 → SECOND_FUNC（该板仅引出 PWM2） */
ls_pinmux_pin_setup(88, LS_PINMUX_MODE_AS_SECOND_FUNC);
```

## Implementation

> [!info] TLDR
>
> - 从对应 reference 的"完整模板代码"章节复制骨架（⚠️ 禁止从零编写）
> - 同步查阅 reference 的设计章节，确保初始化序列与读写流程正确
> - 应用层通过 pinctrl 确认引脚功能（PWM/I2C/SPI/UART 复用引脚必须添加调试打印、编译、上板测试）

### 1) 选取模板与设计文档（⚠️ 禁止跳过）

> ⚠️ **禁止在没有引用 reference 完整模板代码的情况下从零编写驱动代码！**
>
> 模板包含经过验证的寄存器访问方式（8 位 vs 32 位）、时序控制（EOT 等待）、
> CS 管理逻辑、OE 低有效处理等。从零编写极易犯：
> - DR 寄存器位宽错误（32 位 vs 8 位）
> - 时序遗漏（EOT 等待）
> - CS 管理错误
> - PWM OE 位未清零（输出被屏蔽）

- 从对应 reference 的"完整模板代码（Template Source）"章节复制骨架源码。
- 阅读 reference 的初始化流程 / 读写时序 / 调试技巧章节。
- 按设计文档中的步骤逐步实现。模板中的核心逻辑不可随意修改。

### 2) 编写与调试

- 将模板中的占位符替换为实际值（引脚号、设备地址、通道号等）。
- **⚠️ 引脚复用设置**：编写任何需要复用引脚的功能代码（PWM、I2C、SPI）时，必须在应用层
  通过 `/dev/pinctrl0` + `PINCTRLC_SETFUNCTION` 设置一次引脚功能，不能仅依赖 bringup.c。
- 添加调试打印（`printf`）。
- 编译检查。
- 上板测试，观察串口输出。

## 平台编码与内核 API 规则

编写或审查任何 2K300 驱动代码时，加载 `references/coding_rules.md`，覆盖龙芯平台特有陷阱：
寄存器位宽、非缓存地址、SPI EOT 等待、CS 管理、PWM OE 低有效、无 FPU 整数运算、
格式说明符匹配、中断与临界区、错误清理模式。

快速自查（编写完代码后运行）：

```bash
nuttx/tools/checkpatch.sh -f <your_file.c>
```

## Verification

编写完成后，对照 `references/verification_checklist.md` 逐项自查：

- **板级配置（⚠️ 必须全部 PASS）**：defconfig CONFIG 项、pinmux、pinctrl、测试源文件双登记（Makefile+CMakeLists）、UART 内核 serial 注册、GPIO88 冲突。
- **代码正确性**：寄存器位宽、非缓存地址、EOT 等待、CS 三段、PWM OE、整数运算、格式说明符、错误清理、ISR 轻量。
- **平台陷阱**：SPI Flash 地址模式、OLED 分页、BH1750 测量等待、EEPROM 页写等待、ADC 通道、PWM 200MHz 基准、UART 波特率分频。

自动检查脚本：

```bash
# 板级 defconfig 检查
scripts/validate-boardconfig.sh <defconfig路径> <gpio|spi|uart|...|all>
# bringup.c 引脚复用检查
scripts/validate-pinmux.sh <bringup.c路径> <i2c1|spi2|uart2|...|all>
# 驱动源码模板/模式检查
scripts/validate-template.sh <驱动源码.c> <key|led|buzzer|pwm|uart|...>
# 测试源文件 Makefile/CMakeLists 双登记检查
scripts/validate-sourcereg.sh <测试源目录> <test_xxx.c>
# 5 步工作流状态管理
scripts/workflow-state.sh init
```

## Workflow

### 第一步：需求分析
确认外设类型、芯片型号、硬件连接（引脚号、总线号）。

### 第二步：查阅硬件规格
打开 `references/hardware_spec.md`，确认引脚复用、寄存器基地址、时钟配置。

### 第三步：配置板级支持（⚠️ 关键步骤，不可跳过）
详见 `references/board_registration.md`。先检查现有 defconfig，再补 pinmux 与 Kconfig。

### 第四步：选择模板与设计文档（⚠️ 禁止跳过）
从对应 reference 的"完整模板代码"章节复制骨架，阅读设计章节逐步实现。

### 第五步：编写与调试
替换占位符、pinctrl 确认引脚、编译、上板测试。对照 `references/verification_checklist.md` 自查。

## References

### 外设专属参考（含完整模板源码）

| Reference | 外设 | 模板源码 |
|-----------|------|---------|
| `references/hardware_spec.md` | 硬件规格（引脚、寄存器、时钟、Kconfig 依赖表） | — |
| `references/key_design.md` | GPIO 按键（轮询/中断/消抖） | gpio_key_template |
| `references/led_design.md` | GPIO LED（心跳灯） | gpio_led_template |
| `references/buzzer_design.md` | GPIO 蜂鸣器（方波音调） | gpio_buzzer_template |
| `references/pwm_design.md` | 硬件 PWM（呼吸灯） | pwm_template |
| `references/uart_design.md` | 硬件 UART（串口收发） | uart_template |
| `references/spi_adc_design.md` | SPI ADC（MCP3204） | spi_template |
| `references/spi_flash_design.md` | SPI Flash 存储（W25Q/GD25Q） | spi_flash_template |
| `references/i2c_light_sensor_design.md` | I2C 光照传感器（BH1750） | i2c_light_sensor_template |
| `references/i2c_oled_design.md` | I2C OLED 显示（SSD1306） | i2c_oled_template |
| `references/i2c_eeprom_design.md` | I2C EEPROM 存储（AT24C） | i2c_eeprom_template |

### 跨外设通用参考

| Reference | 何时加载 | 说明 |
|-----------|---------|------|
| `references/board_registration.md` | 配置板级支持时 | 板级文件清单、pinmux 双层设置、bringup.c 配置、Kconfig 依赖表、引脚冲突 |
| `references/coding_rules.md` | 编写或审查任何驱动代码时 | 寄存器位宽、非缓存地址、SPI EOT、CS 管理、PWM OE、无 FPU、格式说明符、中断、错误清理 |
| `references/verification_checklist.md` | 编写完成后自查 | 板级配置/代码正确性/平台陷阱检查项 + 报告模板 |

### Scripts

| Script | 作用 |
|--------|------|
| `scripts/validate-boardconfig.sh` | 检查 defconfig 中外设所需 CONFIG 项是否启用 |
| `scripts/validate-pinmux.sh` | 检查 bringup.c 中引脚复用配置是否齐全 |
| `scripts/validate-template.sh` | 检查驱动源码是否基于模板、是否含平台必需 API/模式 |
| `scripts/validate-sourcereg.sh` | 检查测试源文件是否在 `Makefile` CSRCS 与 `CMakeLists.txt` SRCS 两处都登记 |
| `scripts/workflow-state.sh` | 5 步驱动开发工作流状态管理与门控 |

## 目录结构说明

```
loongarch-2k300-openvela-driver/
├── SKILL.md                              # 本文件 - 核心指令
├── references/                           # 技术参考手册（含完整模板源码）
│   ├── hardware_spec.md                  # 硬件规格（引脚、寄存器、时钟、Kconfig 依赖表）
│   ├── key_design.md                     # 按键驱动设计 + 完整模板代码
│   ├── led_design.md                     # LED 驱动设计 + 完整模板代码
│   ├── buzzer_design.md                  # 蜂鸣器驱动设计 + 完整模板代码
│   ├── pwm_design.md                    # 硬件 PWM 驱动设计 + 完整模板代码
│   ├── uart_design.md                   # 硬件 UART 驱动设计 + 完整模板代码
│   ├── spi_adc_design.md                # SPI ADC 驱动设计 + 完整模板代码
│   ├── spi_flash_design.md              # SPI Flash 驱动设计 + 完整模板代码
│   ├── i2c_light_sensor_design.md       # I2C 光照传感器设计 + 完整模板代码
│   ├── i2c_oled_design.md               # I2C OLED 显示设计 + 完整模板代码
│   ├── i2c_eeprom_design.md             # I2C EEPROM 存储设计 + 完整模板代码
│   ├── board_registration.md             # 板级注册与配置（pinmux/Kconfig/defconfig）
│   ├── coding_rules.md                  # 平台编码与内核 API 规则
│   └── verification_checklist.md         # 驱动验证自查清单
└── scripts/                              # 验证与工作流脚本
    ├── validate-boardconfig.sh           # defconfig CONFIG 检查
    ├── validate-pinmux.sh               # bringup.c 引脚复用检查
    ├── validate-template.sh             # 驱动源码模板/模式检查
    ├── validate-sourcereg.sh            # 测试源文件 Makefile/CMakeLists 双登记检查
    └── workflow-state.sh                 # 5 步工作流状态管理

需要配合修改的板级文件（不在 Skill 目录内）：
├── nuttx/boards/.../src/ls2k300_bringup.c   # 引脚复用配置（ls2k300_hardware_init）
├── nuttx/boards/.../configs/nsh/defconfig    # Kconfig 使能（⚠️ 必须包含 CONFIG_I2C_DRIVER=y）
├── nuttx/arch/.../ls2k300_pwm.c             # PWM 驱动（⚠️ OE 位低有效）
├── nuttx/arch/.../ls2k300_serial.c          # UART 串口驱动（⚠️ 注册 /dev/ttySn 节点）
├── nuttx/arch/.../ls2k300_config.h          # UART 的 HAVE_UART_DEVICE 条件
└── apps/examples/ls_driver_test/             # 测试程序注册（⚠️ Makefile 与 CMakeLists 两处）
```
