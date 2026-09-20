#!/bin/bash
# workflow-state.sh — loongarch-2k300 驱动开发 5 步工作流状态管理
# 契约：成功 exit 0，失败 exit 2 + stderr
#
# 用法：
#   workflow-state.sh init                         初始化 .driver-workflow/
#   workflow-state.sh complete <step> [validated]  标记步骤完成（validated=true 表示验证脚本已执行）
#   workflow-state.sh check <step>                  检查步骤是否完成 + 验证是否执行
#   workflow-state.sh gate <step>                   门控：上一步必须完成且验证通过才放行
#   workflow-state.sh status                        输出当前进度
#
# 步骤定义（对应 SKILL.md Workflow）：
#   1 需求分析       需求分析：外设类型/芯片型号/硬件连接
#   2 硬件规格       查阅 hardware_spec.md：引脚/寄存器/时钟
#   3 板级配置       引脚复用 + Kconfig 使能（⚠️ 关键，不可跳过）
#   4 模板与设计     选取 reference 完整模板 + 设计文档（⚠️ 禁止从零编写）
#   5 编写与调试     替换占位符、pinctrl 确认、编译上板测试

STATE_DIR=".driver-workflow"
STATE_FILE="$STATE_DIR/progress.json"

cmd="$1"
step="$2"
validated="${3:-false}"

init_state() {
  mkdir -p "$STATE_DIR"
  cat > "$STATE_FILE" << 'INIT'
{
  "workflow": "loongarch-2k300-openvela-driver",
  "started": "",
  "steps": {
    "1": {"name": "需求分析",     "status": "pending", "validated": false},
    "2": {"name": "硬件规格",     "status": "pending", "validated": false},
    "3": {"name": "板级配置",     "status": "pending", "validated": false},
    "4": {"name": "模板与设计",   "status": "pending", "validated": false},
    "5": {"name": "编写与调试",   "status": "pending", "validated": false}
  }
}
INIT
  INIT_TIME=$(date -Iseconds 2>/dev/null || date)
  python3 -c "
import json
with open('$STATE_FILE') as f: d = json.load(f)
d['started'] = '$INIT_TIME'
with open('$STATE_FILE', 'w') as f: json.dump(d, f, indent=2, ensure_ascii=False)
" 2>/dev/null || sed -i "s/\"started\": \"\"/\"started\": \"$INIT_TIME\"/" "$STATE_FILE"
  echo "initialized: $STATE_FILE"
}

require_state() {
  if [ ! -f "$STATE_FILE" ]; then
    echo "ERROR: $STATE_FILE not found. Run 'workflow-state.sh init' first." >&2
    exit 2
  fi
}

valid_step() {
  case "$step" in
    1|2|3|4|5) return 0 ;;
    *) echo "ERROR: Unknown step '$step' (1-5)" >&2; exit 2 ;;
  esac
}

complete_step() {
  require_state
  valid_step
  python3 -c "
import json
with open('$STATE_FILE') as f: d = json.load(f)
d['steps']['$step']['status'] = 'completed'
d['steps']['$step']['validated'] = $( [ "$validated" = "true" ] && echo "True" || echo "False" )
with open('$STATE_FILE', 'w') as f: json.dump(d, f, indent=2, ensure_ascii=False)
" 2>/dev/null || {
    echo "ERROR: python3 json update failed (需 python3)" >&2
    exit 2
  }
  echo "completed: step $step"
}

check_step() {
  require_state
  valid_step
  python3 -c "
import json
with open('$STATE_FILE') as f: d = json.load(f)
s = d['steps']['$step']
print(f'step $step ({s[\"name\"]}): status={s[\"status\"]} validated={str(s[\"validated\"]).lower()}')
" 2>/dev/null
  return 0
}

gate_step() {
  require_state
  # gate 检查的是上一步
  prev=$(( step - 1 ))
  if [ "$prev" -lt 1 ]; then
    echo "gate: step $step is the first step, pass" >&2
    exit 0
  fi
  python3 -c "
import json, sys
with open('$STATE_FILE') as f: d = json.load(f)
s = d['steps']['$prev']
if s['status'] != 'completed':
    print(f'GATE BLOCKED: step $prev ({s[\"name\"]}) 未完成，不可进入步骤 $step', file=sys.stderr)
    sys.exit(2)
if not s['validated']:
    print(f'GATE WARN: step $prev 未运行验证脚本（建议运行 validate-*.sh）', file=sys.stderr)
" 2>/dev/null
  rc=$?
  exit $rc
}

status_state() {
  require_state
  python3 -c "
import json
with open('$STATE_FILE') as f: d = json.load(f)
print('workflow:', d['workflow'])
print('started:', d.get('started',''))
for n in sorted(d['steps'], key=int):
    s = d['steps'][n]
    mark = '✅' if s['status']=='completed' else '⬜'
    v = ' [validated]' if s['validated'] else ''
    print(f'  {mark} step {n}: {s[\"name\"]}{v}')
" 2>/dev/null
}

case "$cmd" in
  init) init_state ;;
  complete) complete_step ;;
  check) check_step ;;
  gate) gate_step ;;
  status) status_state ;;
  "") echo "用法: $0 {init|complete|check|gate|status} [step] [validated]" >&2; exit 2 ;;
  *) echo "ERROR: 未知命令 '$cmd'" >&2; exit 2 ;;
esac
