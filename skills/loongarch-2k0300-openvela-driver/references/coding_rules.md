# 龙芯 2K0300 驱动编码与内核 API 规则（Coding Rules）

> 编写或审查任何 2K0300 驱动代码时加载本文档。内容覆盖龙芯 LoongArch 2K0300 平台
> 特有的编码陷阱（寄存器位宽、非缓存地址、SPI 时序、OE 低有效等）以及 NuttX 通用规则。

## Table of Contents

1. [寄存器访问位宽（⚠️ 最高频 bug）](#寄存器访问位宽-最高频-bug)
2. [非缓存地址映射](#非缓存地址映射)
3. [SPI 时序控制（EOT 等待）](#spi-时序控制eot-等待)
4. [SPI 片选（CS）管理](#spi-片选cs-管理)
5. [PWM OE 位低有效](#pwm-oe-位低有效)
6. [引脚复用双层设置](#引脚复用双层设置)
7. [无 FPU / 整数运算](#无-fpu--整数运算)
8. [格式说明符匹配](#格式说明符匹配)
9. [中断与临界区](#中断与临界区)
10. [错误清理模式](#错误清理模式)
11. [nxstyle 检查](#nxstyle-检查)

---

## 寄存器访问位宽（⚠️ 最高频 bug）

> 从零编写驱动极易犯 **DR 寄存器位宽错误（32 位 vs 8 位）**，这是最隐蔽的 bug 来源。

2K0300 的外设寄存器位宽因控制器而异，必须严格按 datasheet 使用匹配位宽的访问。
特别注意 SPI IO 控制器的 **DR 数据寄存器是 8 位**（字节宽度 FIFO），而 CR/SR/CFG
等控制与状态寄存器是 32 位：

| 控制器 | 寄存器位宽 | 访问方式 |
|--------|----------|---------|
| SPI2 控制/状态寄存器（CR1/CR3/CR4/SR1/CFG1/CFG2/CFG3） | 32 位 | `*(volatile uint32_t *)` |
| SPI2 数据寄存器（DR，0x40） | **8 位** | `*(volatile uint8_t *)` |
| I2C1（CR/SR/ADDR/DATA...） | 32 位 | `*(volatile uint32_t *)` |
| GPIO（DIR/IN/OUT） | 32 位 | `*(volatile uint32_t *)` |
| SPI Flash（W25Q/GD25Q 数据） | 8 位 | `*(volatile uint8_t *)` |
| UART2（16550，RBR/THR/LSR...） | 8 位 | `getreg8`/`putreg8`（内核 serial 驱动用） |

```c
/* ✅ 正确：控制/状态寄存器 32 位，DR 数据寄存器 8 位 */
#define SPI2_BASE  (0x8000000000000000UL | 0x1610c000UL)
#define SPI_REG32(off)  (*(volatile uint32_t *)(SPI2_BASE + (off)))
#define SPI_REG8(off)   (*(volatile uint8_t  *)(SPI2_BASE + (off)))

SPI_REG32(0x00) = ...;              /* CR1 等控制寄存器：32 位 */
uint8_t tx = 0xff;
SPI_REG8(0x40) = tx;                /* DR 数据寄存器：8 位写入 */
uint8_t rx = SPI_REG8(0x40);        /* DR 数据寄存器：8 位读取 */

/* ❌ 错误：用 32 位访问 DR 会一次读/写 4 字节，破坏 FIFO 顺序 */
uint32_t bad = SPI_REG32(0x40);
```

> **规则**：模板中给出的寄存器访问方式（8 位 vs 32 位）均经过验证，不可随意修改。
> DR 寄存器（偏移 0x40）必须用 8 位访问，其余 SPI 寄存器用 32 位访问。

## 非缓存地址映射

LoongArch 2K0300 物理地址需叠加非缓存段基址 `0x8000000000000000UL` 后才能被
MMIO 正确访问（避免缓存导致寄存器读写延迟/丢失）：

```c
#define PHYS_TO_UNCACHED(addr)  (0x8000000000000000UL | (addr))

#define SPI2_BASE   PHYS_TO_UNCACHED(0x1610c000UL)
#define I2C1_BASE   PHYS_TO_UNCACHED(0x16109000UL)
#define GENERAL_CFG5_ADDR  PHYS_TO_UNCACHED(0x16000114UL)
```

## SPI 时序控制（EOT 等待）

> 从零编写极易犯 **时序遗漏（EOT 等待）**，导致读到错位/无效数据。

SPI2 每次 `CSTART` 启动传输后，**必须**轮询 SR1 的 EOT（End of Transfer）位置位
后再读取 DR，否则数据未就绪：

```c
/* 启动传输 */
SPI_REG32(SPI_CR1) |= SPI_CR1_CSTART;

/* ⚠️ 必须等待 EOT */
while ((SPI_REG32(SPI_SR1) & SPI_SR1_EOT) == 0)
  {
    /* 超时保护可选 */
  }

/* EOT 置位后才能读取数据（DR 为 8 位） */
uint8_t rx = SPI_REG8(SPI_DR);
```

其他必须等待的状态位：RXA（RX 可读）、TXA（TX 可写）、RXE（RX 空）。

## SPI 片选（CS）管理

> 从零编写极易犯 **CS 管理错误**。

该板 SPI2 使用 **GPIO67 软件片选**（`LS_PINMUX_MODE_AS_GPIO`）。每次传输的
`SELECT → TRANSFER → DESELECT` 三段必须成对出现：

```c
/* 拉低 CS（选中从机） */
gpio_write(CS_PIN, 0);

/* 传输数据（含 EOT 等待） */
spi_transfer(tx, rx, len);

/* 拉高 CS（释放从机） */
gpio_write(CS_PIN, 1);
```

- CS 拉低后需短暂延时（部分从机需建立时间）。
- 传输期间 CS 必须保持低电平，**不可**在中途拉高。
- 连续多次传输之间应保持 CS 高（释放），除非协议要求连读（如 SPI Flash 连续读）。

## PWM OE 位低有效

> PWM CTRL 寄存器 bit3（OE）为**低有效**：OE=0 输出使能，OE=1 输出屏蔽。

驱动中启动 PWM 时必须**清除** OE 位（OE=0），否则输出被屏蔽（PWM 无输出但配置看似正确）：

```c
/* ✅ 启动：清除 OE（OE=0 使能输出），置位 EN */
ctrl &= ~PWM_CTRL_OE;    /* OE=0 */
ctrl |=  PWM_CTRL_EN;    /* EN=1 */
PWM_REG(PWM_CTRL) = ctrl;
```

> 这是 PWM 调试中最常见的坑：配置全对、占空比计算正确，但 OE=1 导致无输出。

## 引脚复用双层设置

见 [board_registration.md](board_registration.md#引脚复用pinmux双层设置原则)。
编写任何需要复用引脚的功能代码（PWM/I2C/SPI）时，应用层**必须**通过
`/dev/pinctrl0` + `PINCTRLC_SETFUNCTION` 再次确认引脚功能，不能仅依赖 bringup.c。

## 无 FPU / 整数运算

- NuttX RTOS 内核及多数板级代码**默认不使用 FPU**。
- 所有运算应使用**整数运算**，避免 `float`/`double`。
- 占空比使用 NuttX 固定点格式：`duty` 范围 0~65536，65536 = 100%。
  - 例：50% → `32768`，25% → `16384`。
- 频率/分频计算用整数：`full_buffer = clock_freq × frequency / 1000000`。

```c
/* ✅ 正确：整数 + 固定点 */
info.frequency = 1000;   /* 1kHz */
info.duty      = 32768;  /* 50% */

/* ❌ 错误：浮点 */
float duty_f = 0.5f;
```

## 格式说明符匹配

`printf` 格式说明符**必须**与参数类型严格匹配，否则在 LoongArch 64 位平台
上会产生错误输出或崩溃：

| 类型 | 正确格式 | 常见错误 |
|------|---------|---------|
| `int` | `%d` | — |
| `unsigned int` | `%u` / `%x` | 用 `%d` |
| `long` | `%ld` | 用 `%d` |
| `unsigned long` | `%lu` / `%lx` | 用 `%x` |
| `int64_t` | `%" PRId64 "` | 用 `%ld` |
| `size_t` | `%zu` | 用 `%d` |
| 指针 | `%p` | 用 `%x` |

```c
uint32_t val = 0x1234;
printf("val=%lu (0x%lx)\n", (unsigned long)val, (unsigned long)val);
```

## 中断与临界区

- GPIO 中断回调中**只**设置标志位 / 唤信号量，**禁止**在 ISR 中执行耗时操作或 printf。
- 共享可变状态用 `volatile` 标记，跨核/中断访问需配 `irqsave()`/`irqrestore()` 临界区。

```c
static volatile int g_key_pressed = 0;

static int key_interrupt(int irq, void *context, void *arg)
{
  g_key_pressed = 1;   /* 仅置标志 */
  return OK;
}
```

## 错误清理模式

每个资源获取点都要有对应的释放路径，按获取逆序释放：

```c
int fd = open(path, O_RDWR);
if (fd < 0)
  {
    return -errno;
  }

int ret = ioctl(fd, GPIOC_SETPINTYPE, ...);
if (ret < 0)
  {
    printf("ERROR: %d\n", errno);
    close(fd);          /* 清理已打开的 fd */
    return -errno;
  }
```

## nxstyle 检查

```bash
nuttx/tools/checkpatch.sh -f <your_file.c>
```

- 提交前必须通过（若工具可用）。
- 花括号风格：NuttX 要求 `if (...)` 后即使单条语句也用花括号且换行：
  ```c
  if (ret < 0)
    {
      return ret;
    }
  ```
