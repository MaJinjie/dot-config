#!/usr/bin/env bash

# 获取所有当前存在的 workspace 的编号（num 字段）
USED=$(swaymsg -t get_workspaces -r | jq '.[].num')

# 从 1 到 20 查找未被占用的编号
for i in {1..20}; do
    if ! echo "$USED" | grep -qx "$i"; then
        swaymsg workspace number "$i"
        exit 0
    fi
done

# 如果都被占用了，可以给出提示（可选）
notify-send "Sway" "No empty workspace found in range 1-20"
