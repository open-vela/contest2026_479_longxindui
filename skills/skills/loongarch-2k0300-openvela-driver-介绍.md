# loongarch-2k0300-openvela-driver Skill 介绍

> 龙芯 LoongArch 2K0300（2K0300）板卡在 **OpenVela / NuttX RTOS** 平台下的驱动开发 Skill。
> 当前版本：**v2.0 + UART 扩展**（origin.txt 完成结构重构为 v2.0；uart_change.txt 在其基础上加入 UART 外设与源文件双登记校验）。

---

## 一、Skill 概述

本 Skill 用于指导在龙芯 2K0300 / OpenVela（NuttX）平台上编写各类外设驱动。参考 `nuttx-driver-development` 的结构组织，按 **Preparation → Implementation → Verification** 全生命周期推进，保持每次改动小而可测。

核心理念：

- **模板驱动，禁止从零编写**。所有外设的完整驱动模板源码已内联在对应 reference 文档的「完整模板代码（Template Source）」章节，编写时直接复制骨架并替换占位符。
- **板级配置先行**。遗漏 pinmux / Kconfig / defconfig 是最常见错误，必须在写代码前完成，并由脚本自动校验。
- **平台陷阱内置**。龙芯平台特有的寄存器位宽（8/32 位）、非缓存地址、SPI EOT 等待、CS 管理、PWM OE 低有效、无 FPU 整数运算等规则集中沉淀在 `coding_rules.md`。

2K0300 平台所有外设均通过 NuttX **POSIX VFS 驱动模型**访问，设备以文件形式出现在 `/dev/`。

---

## 二、支持的外设

| 外设 | 触发关键词 | Reference 文档 | 模板源码 |
|------|-----------|----------------|---------|
| GPIO 按键 | 按键 / 中断 / key | `key_design.md` | gpio_key_template |
| GPIO LED | LED / 灯 | `led_design.md` | gpio_led_template |
| GPIO 蜂鸣器 | 蜂鸣器 / buzzer / 声音 | `buzzer_design.md` | gpio_buzzer_template |
| 硬件 PWM（呼吸灯） | PWM / 呼吸灯 / 脉宽调制 | `pwm_design.md` | pwm_template |
| SPI ADC | ADC / SPI / 模数转换 | `spi_adc_design.md` | spi_template |
| SPI Flash 存储 | Flash / W25Q / GD25Q / 存储 | `spi_flash_design.md` | spi_flash_template |
| I2C 光照传感器 | 光照 / 亮度 / BH1750 | `i2c_light_sensor_design.md` | i2c_light_sensor_template |
| I2C OLED 显示 | 显示 / 屏幕 / SSD1306 | `i2c_oled_design.md` | i2c_oled_template |
| I2C EEPROM 存储 | EEPROM / AT24C / 存储 | `i2c_eeprom_design.md` | i2c_eeprom_template |
| UART 串口 | 串口 / UART / ttyS | `uart_design.md` | uart_template |

---

## 三、目录结构

```
loongarch-2k0300-openvela-driver/
├── SKILL.md                          # 核心指令（调度表、Kconfig 依赖、工作流）
├── references/                       # 技术参考手册（含完整模板源码）
│   ├── hardware_spec.md              # 硬件规格：引脚、寄存器、时钟、Kconfig 依赖表
│   ├── key_design.md                 # 按键驱动设计 + 完整模板代码
│   ├── led_design.md                 # LED 驱动设计 + 完整模板代码
│   ├── buzzer_design.md              # 蜂鸣器驱动设计 + 完整模板代码
│   ├── pwm_design.md                 # 硬件 PWM 驱动设计 + 完整模板代码
│   ├── spi_adc_design.md             # SPI ADC 驱动设计 + 完整模板代码
│   ├── spi_flash_design.md           # SPI Flash 驱动设计 + 完整模板代码
│   ├── i2c_light_sensor_design.md   # I2C 光照传感器设计 + 完整模板代码
│   ├── i2c_oled_design.md            # I2C OLED 显示设计 + 完整模板代码
│   ├── i2c_eeprom_design.md          # I2C EEPROM 存储设计 + 完整模板代码
│   ├── uart_design.md                # UART 串口驱动设计 + 完整模板代码（新增）
│   ├── board_registration.md         # 板级注册：pinmux 双层、Kconfig、bringup、引脚冲突
│   ├── coding_rules.md               # 平台编码与内核 API 规则
│   └── verification_checklist.md     # 驱动验证自查清单 + 报告模板
└── scripts/                          # 验证与工作流脚本
    ├── validate-boardconfig.sh       # defconfig CONFIG 项检查
    ├── validate-pinmux.sh            # bringup.c 引脚复用检查
    ├── validate-template.sh           # 驱动源码模板/模式检查
    ├── validate-sourcereg.sh         # 测试源文件 Makefile+CMakeLists 双登记检查（新增）
    └── workflow-state.sh             # 5 步工作流状态管理与门控
```

板级修改（不在 Skill 目录内）：`ls2k0300_bringup.c`（pinmux）、`defconfig`（Kconfig，⚠️ 须含 `CONFIG_I2C_DRIVER=y`）、`ls2k0300_pwm.c`（OE 位低有效）、`ls2k0300_serial.c` / `ls2k0300_config.h`（UART 内核 serial 注册）、`apps/examples/ls_driver_test/`（测试程序）。

---

## 四、开发工作流（5 步）

1. **需求分析** — 确认外设类型、芯片型号、硬件连接（引脚号 / 总线号）。
2. **查阅硬件规格** — 打开 `hardware_spec.md`，确认引脚复用、寄存器基地址（如 SPI2 `0x1610c000`、I2C1 `0x16109000`）、时钟（APB 200MHz、SPI 1MHz、I2C 100/400kHz）、非缓存地址宏 `PHYS_TO_UNCACHED()`。
3. **配置板级支持**（⚠️ 不可跳过）— pinmux 双层设置（bringup.c 的 `ls_pinmux_pin_setup` + 应用层 `/dev/pinctrl0` 的 `PINCTRLC_SETFUNCTION`）、Kconfig 使能、引脚冲突检查（GPIO88 同时是蓝色 LED 与 PWM2）。
4. **选取模板与设计文档**（⚠️ 禁止跳过）— 从对应 reference 的「完整模板代码」章节复制骨架，阅读设计章节逐步实现。
5. **编写与调试** — 替换占位符、pinctrl 确认引脚、编译、上板测试，对照 `verification_checklist.md` 自查。

---

## 五、Kconfig 依赖速查

| 外设模块 | 必需的 Kconfig 选项 |
|---------|-------------------|
| GPIO（LED/KEY/Buzzer） | `CONFIG_LS2K0300_GPIO=y`, `CONFIG_LS2K0300_PINCTRL=y` |
| I2C1（BH1750/SSD1306/EEPROM） | `CONFIG_LS2K0300_I2C=y`, `CONFIG_LS2K0300_I2C1=y`, `CONFIG_I2C_DRIVER=y` |
| SPI2（MCP3204/SPI Flash） | `CONFIG_LS2K0300_SPI=y`, `CONFIG_LS2K0300_SPIIO2=y` |
| ADC | `CONFIG_LS2K0300_ADC=y` |
| PWM | `CONFIG_LS2K0300_PWM=y`, `CONFIG_LS2K0300_PWM2=y` |
| UART2（新增） | `CONFIG_LS2K0300_UART=y`, `CONFIG_LS2K0300_UART2=y`（须内核 serial 注册） |

易遗漏：`CONFIG_LS2K0300_PINCTRL=y` 缺失则 `/dev/pinctrl0` 不创建；`CONFIG_I2C_DRIVER=y` 是用户空间 I2C 设备必要配置，defconfig 常缺失，须手动添加。

---

## 六、平台编码规则要点（coding_rules.md）

- **寄存器位宽**：GPIO/SPI/I2C/PWM 的控制/状态寄存器多为 32 位（`getreg32/putreg32`）；**SPI IO 的 DR 数据寄存器为 8 位**（字节宽度 FIFO，`getreg8/putreg8`）；UART2（16550）为 8 位（`getreg8/putreg8`）。
- **非缓存地址**：访问硬件寄存器须用 `PHYS_TO_UNCACHED()` 映射。
- **SPI EOT 等待**：传输完成须等 EOT，CS 三段管理（选中→传输→释放）。
- **PWM OE 低有效**：输出使能位须清零，否则输出被屏蔽。
- **无 FPU**：龙芯该核无 FPU，浮点须改整数运算。
- **格式说明符**：`printf` 格式符须与参数类型严格匹配。
- **中断与错误清理**：ISR 轻量，错误路径按申请逆序释放资源。
- **源文件双登记**（UART 改动新增 B6 校验）：测试源文件须同时登记进 `Makefile` 的 `CSRCS` 与 `CMakeLists.txt` 的 `SRCS`，漏登 CMakeLists 会导致链接期未定义引用。

---

## 七、验证体系（verification_checklist.md + 脚本）

- **板级配置（必须全 PASS）**：defconfig CONFIG、pinmux、pinctrl、测试注册（B6 双登记）、GPIO88 冲突、UART 内核 serial 注册（B8）。
- **代码正确性**：寄存器位宽、非缓存地址、EOT 等待、CS 三段、PWM OE、整数运算、格式说明符、错误清理、ISR 轻量。
- **平台陷阱**：SPI Flash 地址模式、OLED 分页、BH1750 测量等待、EEPROM 页写等待、ADC 通道、PWM 200MHz 基准、UART 波特率分频。

自动检查脚本（均实测 exit 0 通过）：

```bash
scripts/validate-boardconfig.sh <defconfig> <gpio|spi|i2c|pwm|uart|all>
scripts/validate-pinmux.sh    <bringup.c> <i2c1|spi2|uart2|all>
scripts/validate-template.sh  <源码.c>     <key|led|buzzer|pwm|spi|uart>
scripts/validate-sourcereg.sh <测试目录> <源文件.c>   # 拦截 CMake 漏登
scripts/workflow-state.sh     init                       # 5 步工作流门控
```

---

## 八、触发模板

### 原始模板

```
请你严格按照skill的要求，写一份龙芯2k0300的驱动代码，功能为......
```

### 优化后的模板（推荐）

```
请你严格按照 loongarch-2k0300-openvela-driver skill 的要求，为龙芯 2K0300
（OpenVela / NuttX 平台）编写一份外设驱动代码，功能为：<在此填写具体功能，
例如“通过 I2C1 读取 BH1750 光照值并每秒打印”或“用硬件 PWM2 驱动 LED 实现呼吸灯”>。

请完整走 Preparation → Implementation → Verification 流程：
1. 查阅 references/hardware_spec.md，确认所用外设的引脚号、寄存器基地址与时钟；
2. 完成板级配置（bringup.c 的 ls_pinmux_pin_setup 双层设置 + defconfig 的 Kconfig
   使能，注意 CONFIG_I2C_DRIVER=y / CONFIG_LS2K0300_PINCTRL=y 等易遗漏项），并用
   scripts/validate-boardconfig.sh 与 validate-pinmux.sh 自检；
3. 从对应 reference 的「完整模板代码」章节复制骨架（⚠️ 禁止从零编写），按
   coding_rules.md 替换占位符（寄存器位宽、非缓存地址、EOT/CS/OE 等平台陷阱）；
4. 测试源文件须同时在 Makefile CSRCS 与 CMakeLists.txt SRCS 登记，用
   validate-sourcereg.sh 校验；
5. 对照 verification_checklist.md 逐项自查并给出验证报告。
```

**优化要点说明**：

- 明确平台（OpenVela/NuttX）与芯片型号（2K0300），避免被误判为通用 Linux 驱动。
- 把抽象的「功能为……」收敛为带示例的填空，引导用户给出引脚/总线/芯片型号等必要参数。
- 显式列出 skill 的 5 步全生命周期与必须加载的 reference / 脚本，让模型不跳过板级配置、不跳过模板、不漏 CMake 登记。
- 点名三处最易踩坑的配置项（`CONFIG_I2C_DRIVER`、`CONFIG_LS2K0300_PINCTRL`、源文件双登记），直接对齐 skill 的 B6/B8 校验逻辑。
