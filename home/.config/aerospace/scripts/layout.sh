#!/bin/bash
# Usage: layout.sh stack|grid
# stack: 3 windows -> left | (top / bottom) ; grid: 4 windows -> 2x2
mode=$1
aerospace flatten-workspace-tree
aerospace layout tiles horizontal
ids=($(aerospace list-windows --workspace focused --format '%{window-id} %{window-layout}' | awk '$2!="floating"{print $1}'))
n=${#ids[@]}
case $mode in
  stack)
    [ "$n" -ge 3 ] && aerospace join-with --window-id "${ids[1]}" right
    ;;
  grid)
    if [ "$n" -ge 4 ]; then
      aerospace join-with --window-id "${ids[2]}" right
      aerospace join-with --window-id "${ids[0]}" right
    fi
    ;;
esac
aerospace balance-sizes
