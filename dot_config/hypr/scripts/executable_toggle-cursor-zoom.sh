#!/usr/bin/env bash

ZOOM_FACTOR=2

# 获取当前 zoom_factor 值
CURRENT=$(hyprctl getoption cursor:zoom_factor -j | jq -r '.float')

# 设置切换逻辑
if echo "$CURRENT == 1.0" | bc | grep -q 1; then
    hyprctl keyword cursor:zoom_factor $ZOOM_FACTOR
else
    hyprctl keyword cursor:zoom_factor 1.0
fi
