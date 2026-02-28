#!/bin/bash
# Inspired By: https://github.com/kawarimidoll/dotfiles/blob/master/.config/claude/hooks/validate-bash.sh

input=$(cat)

tool_name=$(echo "$input" | jq -r '.tool_name // ""')
command=$(echo "$input" | jq -r '.tool_input.command // ""')

# Only validate Bash tool
if [[ "$tool_name" != "Bash" ]]; then
  exit 0
fi

# Deny with JSON hookSpecificOutput
deny() {
  jq -n --arg reason "$1" '{
    "hookSpecificOutput": {
      "hookEventName": "PreToolUse",
      "permissionDecision": "deny",
      "permissionDecisionReason": $reason
    }
  }'
  exit 0
}

# Check for forbidden commands
# Use word boundary matching to avoid false positives (e.g., "category" matching "cat")
if echo "$command" | rg -q '\bawk\b'; then
  deny "Use of 'awk' is prohibited. Use 'perl' instead. Example: perl -lane 'print \$F[0]' file.txt"
fi

if echo "$command" | rg -q '\bsed\b'; then
  deny "Use of 'sed' is prohibited. Use 'perl' instead. Example: perl -pi -e 's/old/new/g' file.txt"
fi

if echo "$command" | rg -q '\bpush\b'; then
  deny "Do not execute 'git push'. Please ask the user to execute it."
fi

if echo "$command" | rg -q '\bgit add (-A|--all|\.($|[ ;|&]))'; then
  deny "Do not git-add all files. Specify the file name(s) to add."
fi

if echo "$command" | rg -q '\bgrep\b'; then
  deny "Use of 'grep' is prohibited. Use 'rg' instead. Example: rg 'pattern' file.txt"
fi

exit 0
