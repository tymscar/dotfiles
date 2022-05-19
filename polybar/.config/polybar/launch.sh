#!/bin/bash

killall -q polybar

polybar mybarLeft 2>&1 | tee -a /tmp/polybar.log & disown
polybar mybarRight 2>&1 | tee -a /tmp/polybar.log & disown

echo "Polybar launched..."
