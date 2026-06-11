#!/bin/bash

CURRENT=$(pactl get-default-sink)

if echo "$CURRENT" | grep -q "hdmi"; then
  TARGET=$(pactl list short sinks | awk '/analog-stereo/{print $2; exit}')
else
  TARGET=$(pactl list short sinks | awk '/hdmi/{print $2; exit}')
fi

[ -n "$TARGET" ] || exit 1

pactl set-default-sink "$TARGET"

pactl list short sink-inputs | awk '{print $1}' | while read -r id; do
  pactl move-sink-input "$id" "$TARGET"
done
