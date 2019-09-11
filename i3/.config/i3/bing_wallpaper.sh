#!/bin/sh

# systemd example: https://stackoverflow.com/a/50321912
# cron example:
# 0 * * * * ~/.config/sway/scripts/bing_wallpaper.sh

# exit on error
set -e

wlpath=${WALLPAPER_PATH:-"$HOME/Pictures/wallpaper.jpg"}
lswlpath=${LOCK_SCREEN_WALLPAPER_PATH:-"$HOME/Pictures/lockscreen_wallpaper.jpg"}
output=${WALLPAPER_OUTPUT:-"*"}
baseurl="https://www.bing.com/"
wluri=$(curl $baseurl"HPImageArchive.aspx?format=js&idx=0&n=20&mkt=en-US" -s | jq '.images[].url' --raw-output | shuf -n 1)

curl "$baseurl$wluri" -s > $wlpath
nitrogen --restore
convert $wlpath -filter Gaussian -blur 0x8 -level 10%,90%,0.5 $lswlpath
