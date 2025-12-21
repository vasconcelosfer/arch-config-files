#!/bin/bash

# 1. Obtener el nombre del reproductor (ej: spotify, firefox, vlc)
player_name=$(playerctl metadata --format '{{playerName}}')

# 2. Asignar un icono según el programa
case "$player_name" in
    spotify)  icon="" ;; # Icono de Spotify
    firefox)  icon="" ;; # Icono de Firefox
    chrome*)  icon="" ;; # Icono de Chrome
    vlc)      icon="󰕼" ;; # Icono de VLC
    mpv)      icon="" ;; # Icono de MPV
    *)        icon="" ;; # Icono genérico (nota musical)
esac

# 3. Obtener la información de la canción
song_info=$(playerctl metadata --format "{{title}}  $icon   {{artist}}")

# 4. Mostrar resultado
echo "$song_info"
