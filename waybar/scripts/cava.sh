#!/bin/bash

CAVA_CMD="cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'"

get_tooltip() {
    playerctl -i "firefox" metadata | awk '/xesam:title|xesam:album |xesam:albumArtist/{key=$2; sub(/xesam:/,"",key); data[key]=substr($0, index($0,$3))} END{printf "title:       %s\\nalbum:       %s\\nalbumArtist: %s", data["title"], data["album"], data["albumArtist"]}'
}

if [[ $1 =~ "toggle" ]]; then
    CAVA_PID="$(pgrep -x cava)"
    if [[ $CAVA_PID > 0 && $(ps -o stat= -C cava | grep -c T) == 0 ]]; then
        kill -19 "$CAVA_PID"
        echo '{"text": "paused", "tooltip": ""}'
    else
        kill -18 "$CAVA_PID"
        echo '{"text": "continue", "tooltip": ""}'
    fi
    exit
fi

killall cava

eval "$CAVA_CMD" | while IFS= read -r line; do
    tooltip=$(get_tooltip)
    printf '{"text": "%s", "tooltip": "%s"}\n' "$line" "$tooltip"
done
