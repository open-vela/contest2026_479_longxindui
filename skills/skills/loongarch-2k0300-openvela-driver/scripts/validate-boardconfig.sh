#!/bin/bash
# validate-boardconfig.sh — 检查板级 defconfig 是否启用了外设所需的 Kconfig 选项
# 契约：成功 exit 0 静默，失败 exit 2 + stderr
# 用法：validate-boardconfig.sh <defconfig路径> <外设模块>
#   外设模块取值：gpio | i2c | spi | adc | pwm | uart | all
#
# 示例：
#   validate-boardconfig.sh nuttx/boards/.../nsh/defconfig i2c
#   validate-boardconfig.sh .config all

DEFCONFIG="${1:-}"
MODULE="${2:-all}"

if [ -z "$DEFCONFIG" ] || [ ! -f "$DEFCONFIG" ]; then
  echo "ERROR: defconfig not found: '$DEFCONFIG'" >&2
  echo "用法: $0 <defconfig路径> <gpio|spi|...|all>" >&2
  exit 2
fi

# 模块 -> 必需 CONFIG 选项
declare -A REQUIRED
REQUIRED[gpio]="CONFIG_LS2K0300_GPIO CONFIG_LS2K0300_PINCTRL"
REQUIRED[i2c]="CONFIG_LS2K0300_I2C CONFIG_LS2K0300_I2C1 CONFIG_I2C_DRIVER CONFIG_LS2K0300_PINCTRL"
REQUIRED[spi]="CONFIG_LS2K0300_SPI CONFIG_LS2K0300_SPIIO2"
REQUIRED[adc]="CONFIG_LS2K0300_ADC"
REQUIRED[pwm]="CONFIG_LS2K0300_PWM CONFIG_LS2K0300_PWM2 CONFIG_LS2K0300_PINCTRL"
REQUIRED[uart]="CONFIG_LS2K0300_UART2 CONFIG_LS2K0300_GPIO CONFIG_LS2K0300_PINCTRL"

if [ "$MODULE" = "all" ]; then
  MODS="gpio i2c spi adc pwm uart"
else
  MODS="$MODULE"
fi

ERRORS=0
for mod in $MODS; do
  if [ -z "${REQUIRED[$mod]:-}" ]; then
    echo "ERROR: 未知外设模块 '$mod' (可选: gpio i2c spi adc pwm uart all)" >&2
    exit 2
  fi
  for cfg in ${REQUIRED[$mod]}; do
    # 匹配 "CONFIG_XXX=y" 形式
    if ! grep -qE "^${cfg}=y\b" "$DEFCONFIG"; then
      echo "FAIL [$mod]: $cfg 未启用 (defconfig: $DEFCONFIG)" >&2
      ERRORS=$((ERRORS + 1))
    fi
  done
done

# I2C_DRIVER / UART 特殊提示
if [ "$ERRORS" -gt 0 ]; then
  echo "" >&2
  echo "提示: CONFIG_I2C_DRIVER=y 是用户空间 I2C 设备的必要配置," >&2
  echo "      defconfig 中常缺失，必须手动添加。" >&2
  echo "提示: CONFIG_LS2K0300_PINCTRL=y 缺失则 /dev/pinctrl0 不被创建。" >&2
  echo "提示: UART 仅开 CONFIG_LS2K0300_UARTn 不够，还需内核 ls2k0300_serial.c" >&2
  echo "      注册 /dev/ttySn 实例（见 uart_design.md 2.3）。" >&2
  exit 2
fi

exit 0
