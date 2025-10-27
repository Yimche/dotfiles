#!/bin/bash

CAVA_CMD="cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'"

if [[ $1 =~ "toggle" ]]; then
    CAVA_PID="$(pgrep -x cava)"
    if [[ $CAVA_PID > 0 && $(ps -o stat= -C cava | grep -c T) == 0 ]]; then
        kill -19 "$CAVA_PID"
        echo "paused\n"
    else
        kill -18 "$CAVA_PID"
        echo "continue\n"
    fi
    exit
fi

killall cava
eval "$CAVA_CMD"
