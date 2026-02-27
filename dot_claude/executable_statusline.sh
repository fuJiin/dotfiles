#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "?"')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
DIR=$(echo "$input" | jq -r '.workspace.current_dir // ""')

# Progress bar
BAR_WIDTH=10
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
BAR=""
[ "$FILLED" -gt 0 ] && BAR=$(printf "%${FILLED}s" | tr ' ' '#')
[ "$EMPTY" -gt 0 ] && BAR="${BAR}$(printf "%${EMPTY}s" | tr ' ' '-')"

# Color based on context usage
RED='\033[31m'
YELLOW='\033[33m'
GREEN='\033[32m'
CYAN='\033[36m'
DIM='\033[2m'
RESET='\033[0m'

if [ "$PCT" -ge 90 ]; then BAR_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then BAR_COLOR="$YELLOW"
else BAR_COLOR="$GREEN"
fi

# Directory (basename only)
DIR_NAME="${DIR##*/}"

# Git branch
BRANCH=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
fi

# Assemble: model | usage | dir | branch
OUT="${CYAN}${MODEL}${RESET} ${DIM}|${RESET} ${BAR_COLOR}${BAR}${RESET} ${PCT}%"
[ -n "$DIR_NAME" ] && OUT="${OUT} ${DIM}|${RESET} ${DIR_NAME}"
[ -n "$BRANCH" ] && OUT="${OUT} ${DIM}|${RESET} ${BRANCH}"

printf '%b\n' "$OUT"
