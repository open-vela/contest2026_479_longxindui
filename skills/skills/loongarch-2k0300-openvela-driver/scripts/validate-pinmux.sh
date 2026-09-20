#!/bin/bash
# validate-pinmux.sh — 检查 bringup.c 中是否为指定外设配置了引脚复用
# 契约：成功 exit 0 静默，失败 exit 2 + stderr
# 用法：validate-pinmux.sh <bringup.c路径> <外设模块>
#   外设模块取值：i2c1 | spi2 | led | key | buzzer | pwm | uart2 | all
#
# 示例：
#   validate-pinmux.sh nuttx/boards/.../src/ls2k0300_bringup.c all

BRINGUP="${1:-}"
MODULE="${2:-all}"

if [ -z "$BRINGUP" ] || [ ! -f "$BRINGUP" ]; then
  echo "ERROR: bringup.c not found: '$BRINGUP'" >&2
  echo "用法: $0 <bringup.c路径> <i2c1|spi2|led|key|buzzer|pwm|uart2|all>" >&2
  exit 2
fi

# 模块 -> 期望出现的 ls_pinmux_pin_setup(<pin>, ...) 引脚号
declare -A PINS
PINS[i2c1]="50 51"
PINS[spi2]="64 65 66 67"
PINS[led]="72 73"
PINS[key]="86 87"
PINS[buzzer]="75"
PINS[pwm]="88"
PINS[uart2]="44 45"

if [ "$MODULE" = "all" ]; then
  MODS="i2c1 spi2 led key buzzer pwm uart2"
else
  MODS="$MODULE"
fi

ERRORS=0
for mod in $MODS; do
  if [ -z "${PINS[$mod]:-}" ]; then
    echo "ERROR: 未知外设模块 '$mod' (可选: i2c1 spi2 led key buzzer pwm uart2 all)" >&2
    exit 2
  fi
  for pin in ${PINS[$mod]}; do
    # 匹配 ls_pinmux_pin_setup( <pin> ,  或 ls_pinmux_pin_setup(<pin>,
    if ! grep -qE "ls_pinmux_pin_setup\(\s*${pin}\b" "$BRINGUP"; then
      echo "FAIL [$mod]: GPIO${pin} 缺少 ls_pinmux_pin_setup() 配置 (bringup: $BRINGUP)" >&2
      ERRORS=$((ERRORS + 1))
    fi
  done
done

if [ "$ERRORS" -gt 0 ]; then
  echo "" >&2
  echo "提示: 引脚复用为双层设置，应用层仍需通过 /dev/pinctrl0 +" >&2
  echo "      PINCTRLC_SETFUNCTION 再次确认引脚功能（见 board_registration.md）。" >&2
  echo "提示: PWM2(GPIO88) 与蓝色 LED 冲突，二者不可同时配置为不同功能。" >&2
  exit 2
fi

exit 0
