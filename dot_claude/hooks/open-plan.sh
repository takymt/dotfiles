#!/bin/bash
file_path=$(cat | jq -r '.tool_input.file_path // empty')
if [[ "$file_path" == */.claude/plans/*.md ]]; then
  code "$file_path" &
fi
exit 0
