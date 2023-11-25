#!/usr/bin/env bash
#
change_background()
{
    FILE="$(readlink -f "$1" )"
    echo changing to "$FILE"
    if [ "$GDMSESSION" == "gnome" ] || [ "$GDMSESSION" == "ubuntu" ]; then
        gsettings set org.gnome.desktop.background picture-uri "file://$FILE"
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$FILE"
    else
        feh --bg-scale "$FILE"
    fi
}

main()
{
  local DISPLAY=:0 # ensure this is set
  if [ -v "WALLPAPER" ]; then
    local DIR=$WALLPAPER
  else
    local DIR="$HOME/.config/wallpaper"
  fi
  until [ -d "$DIR" ]
  do
    sleep 0.1
  done
  random_wallpaper=$( ls $DIR/* | shuf -n 1 )
  change_background "$random_wallpaper"
}

main "$@"
