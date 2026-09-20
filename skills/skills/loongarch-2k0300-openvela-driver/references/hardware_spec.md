# 龙芯 2K0300 硬件规格参考（Hummingbird 板）

## 1. 引脚分配表

### 1.1 I2C1 总线

| 信号 | GPIO 编号 | 功能选择 | 说明 |
|------|----------|---------|------|
| I2C1_SDA | GPIO50 | MAIN_FUNC (0x3) | I2C1 数据线 |
| I2C1_SCL | GPIO51 | MAIN_FUNC (0x3) | I2C1 时钟线 |

- I2C1 设备路径：`/dev/i2c1`
- I2C1 基地址：`0x16109000`

### 1.2 SPI2 总线（SPI0 40Pin 接口）

| 信号 | GPIO 编号 | 功能选择 | 说明 |
|------|----------|---------|------|
| SPI2_CLK | GPIO64 | MAIN_FUNC (0x3) | SPI2 时钟 |
| SPI2_MISO | GPIO65 | MAIN_FUNC (0x3) | SPI2 数据输入 |
| SPI2_MOSI | GPIO66 | MAIN_FUNC (0x3) | SPI2 数据输出 |
| CSN1 | GPIO67 | GPIO (0x0) | MCP3204 软件片选 |

- SPI2 基地址：`0x1610c000`
- 非缓存地址：`0x8000000000000000UL | 0x1610c000UL`

### 1.3 UART2 总线（用户串口）

| 信号 | GPIO 编号 | 功能选择 | 说明 |
|------|----------|---------|------|
| UART2_TX | GPIO44 | MAIN_FUNC (0x3) | UART2 发送 |
| UART2_RX | GPIO45 | MAIN_FUNC (0x3) | UART2 接收 |

- UART2 设备路径：`/dev/ttyS2`（由内核 `ls2k0300_serial.c` 注册）
- UART2 基地址：`0x16100800`（非缓存 `0x8000000016100800`）
- UART0 基地址：`0x16100000`（控制台，已固定）
- 波特率分频基准：APB 200MHz，`div_val = (200MHz + baud*8)/(baud*16)`

### 1.4 LED

| LED | GPIO 编号 | 电平驱动 | 说明 |
|-----|----------|---------|------|
| 红色 LED | GPIO72 | 低电平亮 | 可作 GPIO LED |
| 绿色 LED | GPIO73 | 低电平亮 | 可作 GPIO LED |
| 蓝色 LED | GPIO88 | 低电平亮 | ⚠️ 已分配给硬件 PWM2 |

> ⚠️ GPIO88 同时是蓝色 LED 和 PWM2 输出引脚。使用硬件 PWM 时，
> 不能同时将 GPIO88 作为 GPIO LED 控制。

### 1.5 PWM

| PWM 通道 | 设备路径 | 输出引脚 | 功能选择 | 时钟频率 | 说明 |
|---------|---------|---------|---------|---------|------|
| PWM2 | /dev/pwm2 | GPIO88 | SECOND_FUNC (0x2) | 200MHz | 该板仅引出 PWM2 |

> PWM CTRL 寄存器 bit3（OE）为低有效：OE=0 输出使能，OE=1 输出屏蔽。

### 1.6 按键

| 按键 | GPIO 编号 | 按下电平 |
|------|----------|---------|
| KEY1 | GPIO87 | 低电平（按下=0） |
| KEY2 | GPIO86 | 低电平（按下=0） |

## 2. 关键寄存器地址

### 2.1 系统配置寄存器

| 寄存器 | 地址 | 说明 |
|-------|------|------|
| GENERAL_CFG5 | `0x8000000016000114` | SPI2/3 时钟门控，bit[18:17] |

### 2.2 GPIO 寄存器

| 寄存器 | 地址 | 说明 |
|-------|------|------|
| GPIO_DIR | `0x8000000016004000` | GPIO 方向寄存器 |
| GPIO_IN | `0x8000000016004000` | GPIO 输入寄存器 |
| GPIO_OUT | `0x8000000016004000` | GPIO 输出寄存器 |
| GPIO_0_15_MULTI_CFG | `0x8000000016000490` | GPIO 0-15 复用配置 |
| GPIO_16_31_MULTI_CFG | `0x8000000016000494` | GPIO 16-31 复用配置 |
| GPIO_32_47_MULTI_CFG | `0x8000000016000498` | GPIO 32-47 复用配置 |
| GPIO_48_63_MULTI_CFG | `0x800000001600049c` | GPIO 48-63 复用配置 |
| GPIO_64_79_MULTI_CFG | `0x80000000160004a0` | GPIO 64-79 复用配置 |
| GPIO_80_95_MULTI_CFG | `0x80000000160004a4` | GPIO 80-95 复用配置 |

### 2.3 SPI2 控制器寄存器

基地址（非缓存）：`0x800000001610c000`

| 寄存器 | 偏移量 | 说明 |
|-------|--------|------|
| CR1 | 0x00 | 控制寄存器 1（SPE, CSTART, AUTOSUS） |
| CR3 | 0x08 | 控制寄存器 3（TSIZE） |
| CR4 | 0x0c | 控制寄存器 4 |
| SR1 | 0x14 | 状态寄存器（RXA, TXA, RXE, EOT） |
| CFG1 | 0x20 | 配置 1（DSIZE, CPOL, CPHA） |
| CFG2 | 0x24 | 配置 2（波特率分频） |
| CFG3 | 0x28 | 配置 3（MSTR, DIE, DOE, SSMODE） |
| DR | 0x40 | 数据寄存器（⚠️ 8 位访问，其余寄存器 32 位） |

### 2.4 I2C1 控制器寄存器

基地址（非缓存）：`0x8000000016109000`

| 寄存器 | 偏移量 | 说明 |
|-------|--------|------|
| CR | 0x00 | 控制寄存器 |
| SR | 0x04 | 状态寄存器 |
| ADDR | 0x08 | 从机地址寄存器 |
| DATA | 0x0c | 数据寄存器 |
| CCR | 0x10 | 时钟分频寄存器 |

### 2.5 UART2 控制器寄存器（16550）

基地址（非缓存）：`0x8000000016100800`，寄存器位宽 **8 位**。

| 寄存器 | 偏移量 | 说明 |
|-------|--------|------|
| RBR / THR | 0x00 | 接收缓冲 / 发送保持（DLAB=0） |
| IER | 0x01 | 中断使能（ERBFI/ETBEI） |
| IIR / FCR | 0x02 | 中断标识 / FIFO 控制 |
| LCR | 0x03 | 线路控制（WLEN8/DLAB） |
| LSR | 0x05 | 线路状态（DR/THRE/TEMT） |
| DLL / DLH | 0x00 / 0x01 | 分频低/高（DLAB=1） |

## 3. 时钟频率

| 参数 | 值 |
|------|-----|
| APB 总线时钟 | 200 MHz |
| SPI2 目标时钟 | 1 MHz |
| I2C 标准模式 | 100 kHz |
| I2C 快速模式 | 400 kHz |

## 4. 引脚复用配置函数

```c
/* 板级引脚复用设置（在 ls2k0300_bringup.c 中调用） */
void ls2k0300_hardware_init(void)
{
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

  /* PWM2: GPIO88 → SECOND_FUNC */
  ls_pinmux_pin_setup(88, LS_PINMUX_MODE_AS_SECOND_FUNC);
}
```

## 5. Kconfig 依赖表

板级 defconfig 位于：`nuttx/boards/loongarch/ls2k0300/hummingbird-ls2k0300/configs/nsh/defconfig`

| 外设模块 | 必需的 Kconfig 选项 | 说明 |
|---------|-------------------|------|
| GPIO（LED/KEY） | `CONFIG_LS2K0300_GPIO=y`, `CONFIG_LS2K0300_PINCTRL=y` | GPIO 子系统 + 引脚控制 |
| I2C1（BH1750/SSD1306） | `CONFIG_LS2K0300_I2C=y`, `CONFIG_LS2K0300_I2C1=y` | I2C 总线驱动 + I2C1 端口 |
| SPI2（MCP3204） | `CONFIG_LS2K0300_SPI=y`, `CONFIG_LS2K0300_SPIIO2=y` | SPI 总线驱动 + SPIIO2 端口 |
| ADC | `CONFIG_LS2K0300_ADC=y` | ADC 子系统 |
| PWM | `CONFIG_LS2K0300_PWM=y`, `CONFIG_LS2K0300_PWM2=y` | PWM 子系统 + PWM2 通道 |
| UART2 | `CONFIG_LS2K0300_UART2=y`, `CONFIG_UART2_BAUD=115200` | UART2 端口（/dev/ttyS2） |
| 测试应用 | `CONFIG_EXAMPLES_LS_DRIVER_TEST=y` | 驱动测试程序 |

## 6. 通用数据结构定义

```c
/* 物理地址转非缓存地址 */
#define PHYS_TO_UNCACHED(addr)  (0x8000000000000000UL | (addr))

/* SPI2 寄存器访问（DR 数据寄存器用 8 位，其余用 32 位） */
#define SPI2_BASE               (0x8000000000000000UL | 0x1610c000UL)
#define SPI_REG32(off)          (*(volatile uint32_t *)(SPI2_BASE + (off)))
#define SPI_REG8(off)           (*(volatile uint8_t  *)(SPI2_BASE + (off)))

/* I2C1 寄存器访问 */
#define I2C1_BASE               (0x8000000000000000UL | 0x16109000UL)
#define I2C_REG32(off)          (*(volatile uint32_t *)(I2C1_BASE + (off)))

/* UART2 寄存器访问（8 位，应用层一般走 /dev/ttyS2，无需直接访问） */
#define UART2_BASE              (0x8000000000000000UL | 0x16100800UL)
#define UART_REG8(off)          (*(volatile uint8_t *)(UART2_BASE + (off)))

/* 系统配置寄存器 */
#define GENERAL_CFG5_ADDR       (0x8000000000000000UL | 0x16000114UL)
#define CFG5_REG                (*(volatile uint32_t *)GENERAL_CFG5_ADDR)

/* GPIO 设备路径模板 */
#define GPIO_DEV_PATH(pin)      "/dev/gpio" #pin
```
