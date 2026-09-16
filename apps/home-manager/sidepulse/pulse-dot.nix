{ pkgs }:
pkgs.writeShellScriptBin "pulse-dot" ''
  LED=/Volumes/PulseDot/LEDS.LED
  [ -w "$LED" ] || exit 0
  prev=$(cat "$LED" 2>/dev/null)
  printf 'brightness 40\noff\n#8000ff 1.6s pulse\nrepeat 3\n' > "$LED"
  sleep 5
  [ -n "$prev" ] && printf '%s\n' "$prev" > "$LED"
''
