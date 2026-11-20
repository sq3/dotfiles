#!/bin/bash
# Claude Code statusline: cwd, context window, session token usage,
# input/output split, and Claude Pro 5h/7d subscription limits.
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir')
case "$cwd" in
  "$HOME") cwd="~" ;;
  "$HOME"/*) cwd="~${cwd#$HOME}" ;;
esac

model=$(echo "$input" | jq -r '.model.display_name // empty')
transcript=$(echo "$input" | jq -r '.transcript_path // empty')

fmt_k() {
  awk -v n="$1" 'BEGIN {
    if (n >= 1000000) printf "%.1fM", n/1000000
    else if (n >= 1000) printf "%.1fk", n/1000
    else printf "%d", n+0
  }'
}

fmt_dur() {
  # seconds -> "Xh Ym" (or "Ym" if under an hour)
  local s=$1
  [ -z "$s" ] || [ "$s" -lt 0 ] 2>/dev/null && { echo ""; return; }
  local h=$((s / 3600))
  local m=$(((s % 3600) / 60))
  if [ "$h" -gt 0 ]; then printf '%dh%02dm' "$h" "$m"; else printf '%dm' "$m"; fi
}

# --- Current context window fullness ---
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
ctx_used=$(echo "$input" | jq -r '
  (.context_window.total_input_tokens // 0) + (.context_window.total_output_tokens // 0)
')

# --- Last-turn input/output split ---
cur_in=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0')
cur_out=$(echo "$input" | jq -r '.context_window.current_usage.output_tokens // 0')

# --- Session-cumulative token usage: sum across the whole transcript ---
session_total=0
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  session_total=$(jq -n '
    reduce inputs as $line (0;
      . + (($line.message.usage.input_tokens // 0)
         + ($line.message.usage.output_tokens // 0)
         + ($line.message.usage.cache_creation_input_tokens // 0)
         + ($line.message.usage.cache_read_input_tokens // 0))
    )
  ' "$transcript" 2>/dev/null)
  [ -z "$session_total" ] && session_total=0
fi

# --- Claude Pro/Max subscription rate limits (5h session, 7d weekly) ---
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_resets=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

now=$(date +%s)

color_for_pct() {
  awk -v p="$1" 'BEGIN {
    if (p >= 90) print "\033[1;31m"
    else if (p >= 75) print "\033[1;33m"
    else print "\033[2m"
  }'
}

# --- Line 1: cwd, model, context window ---
printf '\033[1;37m%s\033[0m' "$cwd"
[ -n "$model" ] && printf ' \033[2m%s\033[0m' "$model"
if [ -n "$ctx_pct" ]; then
  c=$(color_for_pct "$ctx_pct")
  printf ' %sCtx:%.0f%% (%s/%s)\033[0m' "$c" "$ctx_pct" "$(fmt_k "$ctx_used")" "$(fmt_k "$ctx_size")"
fi
printf ' \033[2mIn:%s Out:%s\033[0m' "$(fmt_k "$cur_in")" "$(fmt_k "$cur_out")"
printf ' \033[2mSession:%s\033[0m' "$(fmt_k "$session_total")"

printf '\n'

# --- Line 2: Claude Pro subscription limits ---
printed=0
if [ -n "$five_pct" ]; then
  c=$(color_for_pct "$five_pct")
  reset_str=""
  [ -n "$five_resets" ] && reset_str=" (resets $(fmt_dur $((five_resets - now))))"
  printf '%s5h:%.0f%%%s\033[0m' "$c" "$five_pct" "$reset_str"
  printed=1
fi
if [ -n "$week_pct" ]; then
  [ "$printed" -eq 1 ] && printf ' '
  c=$(color_for_pct "$week_pct")
  reset_str=""
  [ -n "$week_resets" ] && reset_str=" (resets $(fmt_dur $((week_resets - now))))"
  printf '%s7d:%.0f%%%s\033[0m' "$c" "$week_pct" "$reset_str"
  printed=1
fi
[ "$printed" -eq 0 ] && printf '\033[2m(subscription limits unavailable)\033[0m'
exit 0
