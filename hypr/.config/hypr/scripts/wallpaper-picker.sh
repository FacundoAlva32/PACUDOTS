#!/bin/bash

DIR="/home/pacu/Downloads/wallpaper"
MENU_FILE="/tmp/wallpaper_menu"
THEME="$HOME/.config/rofi/wallpaper.rasi"

# Generar la lista para Rofi
ls "$DIR" | while read -r img; do
  echo -en "$img\0icon\x1f$DIR/$img\n"
done >"$MENU_FILE"

# Lanzar Rofi usando el archivo de tema externo
SELECCION=$(cat "$MENU_FILE" | rofi -dmenu -i -p "Fondo de Pantalla" -theme "$THEME")

if [ -n "$SELECCION" ]; then
  swww img "$DIR/$SELECCION" --transition-type grow --transition-fps 60
fi
