# 驱动验证自查清单（Verification Checklist）

> 编写完驱动代码后逐项对照。每项标记 ✅ PASS / ⚠️ WARN / ❌ FAIL。
> ❌ FAIL 项必须在提交前修复；⚠️ WARN 项列出供用户决策。

## Table of Contents

1. [板级配置检查（⚠️ 必须全部 PASS）](#板级配置检查必须全部-pass)
2. [代码正确性检查](#代码正确性检查)
3. [平台特有陷阱检查](#平台特有陷阱检查)
4. [编译与运行检查](#编译与运行检查)
5. [报告模板](#报告模板)

---

## 板级配置检查（⚠️ 必须全部 PASS）

| # | 检查项 | 通过条件 |
|---|--------|---------|
| B1 | defconfig 启用所有必需 CONFIG | 所用外设的 Kconfig 依赖表项全部存在 |
| B2 | `CONFIG_I2C_DRIVER=y`（I2C 外设） | defconfig 中存在 |
| B3 | `CONFIG_LS2K300_PINCTRL=y` | defconfig 中存在（否则无 `/dev/pinctrl0`） |
| B4 | bringup.c 添加引脚复用配置 | `ls_pinmux_pin_setup()` 调用齐全 |
| B5 | 应用层通过 pinctrl 确认引脚功能 | `PINCTRLC_SETFUNCTION` 调用存在 |
| B6 | 测试源文件在 `Makefile` 与 `CMakeLists.txt` 双登记 | `CSRCS` 与 `SRCS` 两处均含该 `.c`（⚠️ CMake 构建以 CMakeLists 为准，漏一处会链接报未定义引用） |
| B7 | `ls_driver_test.c/h` 注册测试函数 | 测试入口已注册 |
| B8 | UART 内核 serial 驱动注册（UART 外设） | `ls2k300_serial.c` 有 `g_uartNport` + `uart_register("/dev/ttySN", ...)`；`ls2k300_config.h` 的 `HAVE_UART_DEVICE` 含目标 UART |
| B9 | GPIO88 冲突已处理 | PWM 与 LED 不同时占用 GPIO88 |

> 运行 `scripts/validate-boardconfig.sh` + `scripts/validate-pinmux.sh` + `scripts/validate-sourcereg.sh` 可自动检查 B1-B6/B8 相关项。

## 代码正确性检查

| # | 检查项 | 通过条件 |
|---|--------|---------|
| C1 | 寄存器位宽正确 | 32 位寄存器用 `uint32_t`，8 位用 `uint8_t` |
| C2 | 非缓存地址基址叠加 | `PHYS_TO_UNCACHED()` / `0x8000000000000000UL` |
| C3 | SPI EOT 等待 | 传输后轮询 EOT 置位再读 DR |
| C4 | SPI CS 三段成对 | SELECT → TRANSFER → DESELECT |
| C5 | PWM OE 清零 | 启动 PWM 时 OE=0 |
| C6 | 整数运算（无 FPU） | 无 `float`/`double`，duty 用 0~65536 固定点 |
| C7 | 格式说明符匹配 | `%lu`/`%lx`/`%zu` 与类型一致 |
| C8 | 错误清理 | 每个获取点有对应释放路径 |
| C9 | 中断回调轻量 | ISR 仅置标志，无 printf/耗时操作 |
| C10 | 基于模板而非从零编写 | 引用对应 reference 的完整模板源码 |
| C11 | UART 走 /dev/ttySn + termios（UART 外设） | 用 `open`/`read`/`write` + `tcsetattr`/`cfsetspeed`，不裸写 16550 寄存器 |
| C12 | UART 轮询退出用 O_NONBLOCK | echo 循环同时轮询按键时，串口须 `O_NONBLOCK` 打开否则 read 阻塞 |

## 平台特有陷阱检查

- [ ] SPI Flash 连续读地址模式正确进入/退出
- [ ] I2C OLED 显存分页（128×64 分 8 页）处理正确
- [ ] BH1750 一次高分辨率测量后等待测量完成（约 120ms）
- [ ] EEPROM 按页写后等待 5ms 写周期
- [ ] ADC 通道选择与 SPI 帧的 channel 字段一致（MCP3204）
- [ ] PWM full_buffer 计算使用 200MHz 时钟基准
- [ ] UART 波特率分频 `div_val = (200MHz + baud*8)/(baud*16)` 由内核 `up_setup()` 完成，应用层仅设 termios

## 编译与运行检查

- [ ] `checkpatch.sh -f` 通过（若可用）
- [ ] 编译无 warning（尤其隐式声明、类型不匹配）
- [ ] 上板串口输出符合预期
- [ ] `/dev/gpio*`、`/dev/i2c1`、`/dev/pwm2` 等节点存在
- [ ] 外设行为正确（LED 闪烁、按键响应、OLED 显示、Flash 读写校验）

## 报告模板

```
驱动：______
模板：references/______.md（完整模板代码章节）
板级配置：B1-B7 = __ PASS / __ WARN / __ FAIL
代码正确性：C1-C10 = __ PASS / __ WARN / __ FAIL
平台陷阱：__ PASS / __ WARN / __ FAIL
FAIL 项（必须修复）：
  - [B2] CONFIG_I2C_DRIVER=y 缺失 → defconfig 补充
  - [C3] SPI 读取未等待 EOT → 增加 EOT 轮询
WARN 项：
  - [C9] ISR 含 printf → 建议改为置标志
结论：☐ 通过  ☐ 需修复后重审
```
