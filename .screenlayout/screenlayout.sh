#!/bin/sh
export DISPLAY="${DISPLAY:-:0}"
export XAUTHORITY="${XAUTHORITY:-$(find /tmp -maxdepth 1 -name 'xauth_*' | head -n1)}"

xrandr \
  --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
  --output DisplayPort-0 --mode 1366x768 --pos 1920x96 --rotate normal
