# 基于龙芯 2K0300 的 openvela 系统移植与外设驱动验证

> 2026 首届 openvela AI 硬件开发者大赛 ｜ 队伍编号 **479** ｜ 队伍名称 **longxindui**

## 〇、公共仓库改动 Fork 地址与板卡购买链接

本作品涉及对 openvela **公共仓库**的改动（新增 LoongArch 架构支持等），按大赛规则 fork 后在各自仓库提交 PR。共改动 4 个公共仓库，fork 地址如下（均基于 `dev-ls` 分支开发）：

| 公共仓库 | 本队 Fork 地址 |
|---|---|
| `nuttx` | https://github.com/lingluan9/nuttx |
| `nuttx-apps` | https://github.com/lingluan9/nuttx-apps |
| `vendor` | https://github.com/lingluan9/vendor |
| `nuttx_libs_libxx_libcxx` | https://github.com/lingluan9/nuttx_libs_libxx_libcxx |

各仓库的具体替换配置与改动清单见本仓 `contest2026_479_longxindui.xml`。

**硬件采购**：本作品使用的开发板为**先锋派 2K0300**（LOONG-HAT），需购买 **先锋派 + 拓展版 + OLED** 组合（OLED 屏与拓展版上的传感器、Flash、EEPROM 等外设接口配套，驱动测试套件依赖这些硬件），淘宝购买链接：https://item.taobao.com/item.htm?ft=t&id=1014023893734&skuId=6186298055402&spm=a21dvs.23580594.0.0.52d9645e1Xrwc3

## 一、作品简介

本作品将 **OpenVela（NuttX RTOS）** 完整移植到**龙芯 LoongArch 架构 2K0300 处理器**（先锋派开发板 + 扩展板）上，并交付一套覆盖全部常用外设的驱动测试套件 `ls_driver_test`。

**要解决的问题**：OpenVela 此前不支持 LoongArch 架构，本作品为其增加了 LoongArch 的内核架构支持、板级支持包（BSP）与片上/板载外设驱动，让 OpenVela 可以在国产龙芯处理器上运行，并通过可复现的测试用例逐项验证驱动正确性。

**亮点**：

- **全新架构移植**：在 NuttX 中新增 `arch/loongarch/`、`boards/loongarch/` 与 `libc/machine/loongarch/` 支持，修复 libcxx 原子操作，从零完成 2K0300 的启动、串口与最小系统移植，可从uboot启动系统。
- **外设驱动全覆盖**：测试套件覆盖 GPIO（LED/按键/蜂鸣器）、硬件 PWM（呼吸灯）、硬件 UART、硬件 SPI（ADC、SPI Flash）、I2C（OLED、光照传感器、EEPROM）以及 Thermal/Watchdog/RTC 等共 13 项测试。
- **系统级测试通过**：cmocka 内存管理等 openvela 通用测试在真机全部通过，结果与串口日志见 `evidence/`。
- **经验沉淀为 Skill**：开发中踩坑沉淀为自建 Skill `skills/loongarch-2k0300-openvela-driver/`，包含各外设驱动模板、引脚表、寄存器表与自动检查脚本。
- **提供预编译产物**：`prebuilt/nuttx.bin` 可直接烧录验证。

## 二、选题方向

**新硬件适配**。

理由：本作品的核心是为 openvela 添加一个此前不支持的处理器架构（LoongArch 2K0300）——从内核架构移植、板级 BSP 到外设驱动逐层打通，正是"新硬件适配"赛道的目标场景。

## 三、目录结构

本仓是 manifest 仓：`repo sync` 后，`nuttx/`、`apps/`、`vendor/` 会按 `contest2026_479_longxindui.xml` 的配置替换为本队的 fork（`dev-ls` 分支），**作品代码全部位于这三个仓库内**：

| 位置 | 内容 |
|---|---|
| `nuttx/arch/loongarch/`、`nuttx/boards/loongarch/` | LoongArch 架构支持与 2K0300 板级支持包 |
| `nuttx/libs/libc/machine/loongarch/` | LoongArch libc 机器相关实现 |
| `apps/examples/ls_driver_test/` | 外设驱动测试套件（详见 `docs/驱动测试说明.md`） |
| `apps/system/ls2k0300_power/` | 2K0300 电源管理 |
| `vendor/loongson/` | 龙芯编译脚本（`help.sh` / `set_env.sh`） |

本仓各目录：

```text
contest2026_479_longxindui/
├── contest2026_479_longxindui.xml   本仓 manifest（fork 替换 + 工具链说明）
├── openvela.xml                     openvela 基础工程 manifest
├── prebuilt/
│   └── nuttx.bin                              预编译固件（可直接烧录验证）
├── docs/                            技术报告、烧录方法（含截图）、驱动测试说明、原理图、引脚复用图、用户手册
├── evidence/                        真机照片与 openvela 通用测试结果
├── skills/loongarch-2k0300-openvela-driver/    自建驱动开发 Skill（模板/引脚表/检查脚本）
└── logs/                            AI Coding 对话日志（组委会要求格式）
```

## 四、运行方式

实测环境：Ubuntu 22.04。

### 4.1 获取工程

```bash
repo init -u https://github.com/open-vela/contest2026_479_longxindui \
  -b dev-ai-contest-2026 -m contest2026_479_longxindui.xml
repo sync -c -j8
```

同步后本仓位于工作区 `contest2026_479_longxindui/`，openvela 全量源码在外层（`nuttx/`、`apps/`、`vendor/` 等，已被 manifest 替换为本队 fork）。以下命令均在外层工作区执行。

### 4.2 部署龙芯工具链

交叉编译工具链体积过大，无法随 git 仓库提交，请通过百度网盘获取：

1. 打开网盘链接：https://pan.baidu.com/s/1FZcnFcmTGd5GcyP8ayFm5A?pwd=1234 （提取码：`1234`）
2. 进入目录 **广东龙芯2K300先锋派&锋鸟板-v2.0/05-交叉工具链**，下载 `loongarch64-linux-gnu-gcc13.3.tar.gz`
3. 解压到 `/opt`：

```bash
sudo tar xf loongarch64-linux-gnu-gcc13.3.tar.gz -C /opt
```

再复制编译脚本（在 openvela 根目录进行 ）：

```bash
cp vendor/loongson/help.sh .
cp vendor/loongson/set_env.sh .
```

### 4.3 编译

```bash
./help.sh
```

编译产物 `nuttx.bin` 生成在 `cmake_out/hummingbird-ls2k0300_nsh/` 下。

### 4.4 烧录与部署

烧录与部署步骤**配有完整截图**，请对照 `docs/2k0300烧录openvela方法.pdf`（同名 `.docx` 一并附上）逐步操作即可。烧录完成后，用串口终端连接板卡即可进入 nsh 命令行（波特率参数见烧录文档）。

> 不想本地编译的话，可直接使用本仓 `prebuilt/nuttx.bin`（预编译产物）按上述文档烧录。

### 4.5 驱动测试运行

在板卡 nsh 串口终端下执行测试程序 `ls_driver_test`：

```bash
# 单项测试
ls_driver_test <选项>
ls_driver_test -h    # 查看帮助
```

支持的子命令一览：

| 选项 | 说明 | 所需外设 |
|------|------|----------|
| `led` | LED 闪烁（GPIO72/73，低电平点亮） | 板载 LED |
| `key` | 按键 + LED（KEY1/KEY2 翻转红/绿灯，30 秒） | 按键 |
| `oled` | SSD1306 OLED 显示（I2C1，0x3C） | OLED 屏 |
| `thermal` | 片上温度传感器 | — |
| `pwm` | PWM2 呼吸灯（GPIO88） | 板载蓝 LED |
| `watchdog` | 看门狗定时器 | — |
| `rtc` | 实时时钟 | — |
| `adc` | MCP3204 ADC 读取（SPI2） | MCP3204 模块 |
| `sensor` | BH1750 光照 + OLED 显示 | BH1750 + OLED |
| `eeprom` | EEPROM 存储光照数据（按键控制） | AT24C02 + BH1750 |
| `buzzer` | 蜂鸣器 + 按键控制 | 蜂鸣器 |
| `spiflash` | SPI Flash 存储光照数据（按键控制） | SPI Flash + BH1750 |
| `uart2` | UART2 回显（TX=GPIO44 / RX=GPIO45） | 串口线 |

> 注意：`sensor`、`eeprom`、`buzzer`、`spiflash`、`uart2` 五项需要交互（按键/外接设备），不在默认序列中，必须显式传子命令运行。

每项测试的**工作原理、引脚连接、串口打印与预期现象**，逐项详见 `docs/驱动测试说明.md`；外设接线引脚与扩展板接口对照 `docs/2k0300引脚复用图.png` 与 `docs/ls2k0300loong-hat扩展板原理图.pdf`。

### 4.6 openvela 通用测试

除驱动测试外，本作品还通过了 openvela 通用系统测试（cmocka 内存管理等），指令、配置与完整串口日志见 `evidence/ls2k0300 openvela通用测试结果.md`。

## 五、AI Coding 使用说明

本作品从架构移植调研、驱动编写到真机调试，全程与 AI 结对完成：

- **需求拆解与方案设计**：与 AI 梳理 LoongArch 架构在 NuttX 中的接入点（arch / boards / libc 三层），规划 2K0300 外设的驱动模式（VFS 设备节点 + pinctrl 复用）。
- **编码**：测试套件各外设驱动由 AI 按"模板 → 填引脚/寄存器 → 调试"的方式生成，配合龙芯用户手册与扩展板原理图核对寄存器地址与时序。**架构层移植**方面，参考了龙芯实验室的 rt-thread 项目（https://github.com/LoongsonLab/rt-thread）对 LoongArch 的适配思路，在此基础上针对 NuttX 的架构接口（`arch/loongarch/`）完成上下文切换、中断与异常入口、系统调用、fork 与信号、idle 调度等核心模块的移植，形成了"架构层 → SoC 层 → 板级 → 驱动"的分层移植路径。
- **调试**：AI 直接分析串口日志与栈回溯定位问题，重点排查架构级错误，例如：SPI DR 寄存器位宽错误（32 位误用为 8 位，导致 FIFO 数据错乱）、SPI EOT 等待缺失（传输未完成即读 DR，得到错位数据）、pinctrl 二次覆盖引脚配置（LED 测试将 GPIO88 重置为 GPIO 模式，导致后续 PWM 无输出）、无 FPU 浮点异常（龙芯 2K0300 无硬件浮点单元，代码中使用 `float`/`double` 会触发非法指令，需全部改为整数运算与定点格式）、非缓存地址映射遗漏（物理地址未叠加 `0x8000000000000000` 段基址导致 MMIO 读写异常）、PWM OE 位低有效陷阱（OE=1 时输出被屏蔽，配置全对但无波形输出）等平台特有陷阱。
- **经验固化**：AI 将踩坑沉淀为自建 Skill `skills/loongarch-2k0300-openvela-driver/`——含各外设完整驱动模板、硬件规格表、Kconfig 依赖表与自动检查脚本，后续同类驱动可直接复用。
- **文档**：技术报告（`docs/基于龙芯 2K0300 的 openvela 系统移植-技术报告.pdf`）与本 README 均由 AI 依据开发记录整理生成。

完整 AI 对话日志见 `logs/` 目录（按组委会要求的 `manifest.json` + `<日期>/<工具>__<会话id>.jsonl` 结构组织）。
