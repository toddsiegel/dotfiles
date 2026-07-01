#!/usr/bin/env bash
# Alert (desktop notification) when memory usage crosses a high-water mark.
# Uses MemAvailable, which reflects real reclaimable memory (what matters for OOM),
# not just "used". Hysteresis avoids repeat alerts every run: fires once when usage
# rises past HIGH, stays quiet until it drops back below RESET.

set -euo pipefail

HIGH=90        # notify when used% >= HIGH
RESET=85       # re-arm once used% drops below RESET
STATE="${XDG_RUNTIME_DIR:-/tmp}/mem-alert.state"

read -r total avail < <(awk '/^MemTotal:/{t=$2}/^MemAvailable:/{a=$2}END{print t, a}' /proc/meminfo)
used=$(( (total - avail) * 100 / total ))

# swap usage for context in the message
read -r swtot swfree < <(awk '/^SwapTotal:/{t=$2}/^SwapFree:/{f=$2}END{print t, f}' /proc/meminfo)
if [ "$swtot" -gt 0 ]; then
  swused=$(( (swtot - swfree) * 100 / swtot ))
else
  swused=0
fi

armed=1
[ -f "$STATE" ] && armed=$(cat "$STATE")

if [ "$used" -ge "$HIGH" ] && [ "$armed" -eq 1 ]; then
  top=$(ps -eo comm= --sort=-rss | head -n1)
  notify-send -u critical -i dialog-warning \
    "Memory at ${used}%" \
    "RAM usage is high (swap ${swused}%). Top consumer: ${top}. Close something before the OOM killer does."
  echo 0 > "$STATE"     # disarm until it recovers
elif [ "$used" -lt "$RESET" ]; then
  echo 1 > "$STATE"     # re-arm
fi
