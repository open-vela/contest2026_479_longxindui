#!/bin/bash
# validate-sourcereg.sh — 检查测试源文件是否在 Makefile CSRCS 与 CMakeLists.txt SRCS 两处都登记
#
# 背景：本工程同时存在 Makefile（CSRCS）与 CMakeLists.txt（SRCS）两套构建清单。
# CMake 构建以 CMakeLists.txt 为准，仅把源文件加入 Makefile 而漏掉 CMakeLists.txt，
# 会导致链接时报 "undefined reference to <symbol>"。此脚本专门拦截这类遗漏（checklist B6）。
#
# 契约：成功 exit 0 静默，失败 exit 2 + stderr
# 用法：
#   validate-sourcereg.sh <测试源目录> <test_xxx.c>
#
# 示例：
#   validate-sourcereg.sh apps/examples/ls_driver_test test_uart2.c

DIR="${1:-}"
SRC="${2:-}"

if [ -z "$DIR" ] || [ ! -d "$DIR" ]; then
  echo "ERROR: 测试源目录不存在: '$DIR'" >&2
  echo "用法: $0 <测试源目录> <test_xxx.c>" >&2
  exit 2
fi

if [ -z "$SRC" ]; then
  echo "ERROR: 未指定源文件名" >&2
  echo "用法: $0 <测试源目录> <test_xxx.c>" >&2
  exit 2
fi

MAKEFILE="$DIR/Makefile"
CMAKELIST="$DIR/CMakeLists.txt"

ERRORS=0

# 1. 检查 Makefile 的 CSRCS 清单
if [ ! -f "$MAKEFILE" ]; then
  echo "FAIL: 未找到 $MAKEFILE" >&2
  ERRORS=$((ERRORS + 1))
else
  # 匹配行尾或空白分隔的源文件名（避免 test_uart.c 误匹配 test_uart2.c）
  if ! grep -qE "(^|[[:space:]])${SRC}([[:space:]]|$)" "$MAKEFILE"; then
    echo "FAIL: $SRC 未在 $MAKEFILE 的 CSRCS 中登记" >&2
    ERRORS=$((ERRORS + 1))
  fi
fi

# 2. 检查 CMakeLists.txt 的 SRCS 清单（⚠️ 最易遗漏）
if [ ! -f "$CMAKELIST" ]; then
  echo "FAIL: 未找到 $CMAKELIST" >&2
  ERRORS=$((ERRORS + 1))
else
  if ! grep -qE "(^|[[:space:]])${SRC}([[:space:]]|\))" "$CMAKELIST"; then
    echo "FAIL: $SRC 未在 $CMAKELIST 的 SRCS 中登记（CMake 构建以此为准，漏登记会链接报未定义引用）" >&2
    ERRORS=$((ERRORS + 1))
  fi
fi

if [ "$ERRORS" -gt 0 ]; then
  echo "" >&2
  echo "提示: 新增测试源文件必须在 Makefile 的 CSRCS 与 CMakeLists.txt 的 SRCS 两处都登记。" >&2
  exit 2
fi

exit 0
