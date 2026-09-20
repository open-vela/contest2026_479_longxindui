#!/bin/bash
# validate-template.sh — 检查驱动源码是否基于 Skill 模板编写、是否含平台必需模式
# 契约：成功 exit 0 静默，失败 exit 2 + stderr
# 用法：validate-template.sh <驱动源码.c> <外设类型>
#   外设类型取值：key | led | buzzer | pwm | uart | spi_adc | spi_flash | i2c_light | i2c_oled | i2c_eeprom
#
# 检查项：
#   1. 必需头文件（nuttx/config.h、外设对应头文件）
#   2. 平台关键 API/模式（按外设类型）
#   3. 从零编写的高风险反模式（裸寄存器访问而无 EOT 等待等，仅提示）

SRC="${1:-}"
TYPE="${2:-}"

if [ -z "$SRC" ] || [ ! -f "$SRC" ]; then
  echo "ERROR: source file not found: '$SRC'" >&2
  echo "用法: $0 <驱动源码.c> <key|led|buzzer|pwm|uart|spi_adc|spi_flash|...>" >&2
  exit 2
fi

ERRORS=0
WARN_COUNT=0

# 1. 通用必需头文件
for inc in "nuttx/config.h"; do
  if ! grep -qE "#include\s*[<\"]${inc}[>\"]" "$SRC"; then
    echo "FAIL: 缺少 #include <${inc}>" >&2
    ERRORS=$((ERRORS + 1))
  fi
done

# 2. 按外设类型的必需模式
case "$TYPE" in
  key|led|buzzer)
    grep -qE "GPIOC_SETPINTYPE|GPIOC_WRITE|GPIOC_READ" "$SRC" \
      || { echo "FAIL [$TYPE]: 缺少 GPIOC_* ioctl 调用" >&2; ERRORS=$((ERRORS + 1)); }
    grep -qE "/dev/gpio[0-9]+" "$SRC" \
      || { echo "WARN [$TYPE]: 未发现 /dev/gpioN 设备路径" >&2; WARN_COUNT=$((WARN_COUNT + 1)); }
    ;;
  pwm)
    grep -qE "PWMIOC_SETCHARACTERISTICS|PWMIOC_START|PWMIOC_STOP" "$SRC" \
      || { echo "FAIL [$TYPE]: 缺少 PWMIOC_* ioctl 调用" >&2; ERRORS=$((ERRORS + 1)); }
    grep -qE "PINCTRLC_SETFUNCTION" "$SRC" \
      || { echo "WARN [$TYPE]: 应用层未通过 PINCTRLC_SETFUNCTION 设置 GPIO88(PWM2)" >&2; WARN_COUNT=$((WARN_COUNT + 1)); }
    ;;
  uart)
    grep -qE "/dev/ttyS[0-9]+" "$SRC" \
      || { echo "FAIL [$TYPE]: 缺少 /dev/ttySn 设备路径（应走内核 serial 设备）" >&2; ERRORS=$((ERRORS + 1)); }
    grep -qE "tcsetattr|cfsetspeed|tcgetattr" "$SRC" \
      || { echo "WARN [$TYPE]: 未发现 termios 配置（波特率/8N1）" >&2; WARN_COUNT=$((WARN_COUNT + 1)); }
    grep -qE "PINCTRLC_SETFUNCTION" "$SRC" \
      || { echo "WARN [$TYPE]: 应用层未通过 PINCTRLC_SETFUNCTION 设置 TX/RX 引脚主功能" >&2; WARN_COUNT=$((WARN_COUNT + 1)); }
    ;;
  spi_adc|spi_flash)
    grep -qE "SPI_REG32|spi_|SPI_" "$SRC" \
      || { echo "WARN [$TYPE]: 未发现 SPI 寄存器/SPI API 访问" >&2; WARN_COUNT=$((WARN_COUNT + 1)); }
    # SPI Flash 必须 EOT 等待或等价状态轮询
    grep -qE "EOT|SR1|spi_status|up_udelay|up_mdelay" "$SRC" \
      || { echo "WARN [$TYPE]: 未发现 EOT/状态等待逻辑（易致时序 bug）" >&2; WARN_COUNT=$((WARN_COUNT + 1)); }
    ;;
  i2c_light|i2c_oled|i2c_eeprom)
    grep -qE "I2C_TRANSFER|i2c_|I2C_" "$SRC" \
      || { echo "WARN [$TYPE]: 未发现 I2C_TRANSFER/I2C API 访问" >&2; WARN_COUNT=$((WARN_COUNT + 1)); }
    ;;
  *)
    echo "ERROR: 未知外设类型 '$TYPE'" >&2
    echo "可选: key led buzzer pwm uart spi_adc spi_flash i2c_light i2c_oled i2c_eeprom" >&2
    exit 2
    ;;
esac

# 3. 浮点反模式（无 FPU）
#    排除 "double-layer"/"double-buffered" 这类注释里的连词：要求 float/double
#    后紧跟非连字符/非字母数字字符（即真正的类型用法）。
if grep -qE "\b(float|double)\b[^-A-Za-z0-9]" "$SRC"; then
  echo "WARN: 检测到 float/double，2K300 平台应使用整数运算（duty 0~65536 固定点）" >&2
  WARN_COUNT=$((WARN_COUNT + 1))
fi

# 4. 裸 8 位寄存器访问（可能位宽错误，仅提示）
if grep -qE "volatile\s+uint8_t\s*\*" "$SRC" && echo "$TYPE" | grep -q "spi_adc"; then
  echo "WARN: 检测到 8 位寄存器访问，确认目标寄存器确为 8 位（SPI2 控制器寄存器为 32 位）" >&2
  WARN_COUNT=$((WARN_COUNT + 1))
fi

if [ "$ERRORS" -gt 0 ]; then
  exit 2
fi

exit 0
