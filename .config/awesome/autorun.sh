#!/bin/sh

# Verifica e executa screenlayout.sh se não estiver em execução
if ! pgrep -f screenlayout.sh > /dev/null; then
    sh /home/jkyon/.screenlayout/screenlayout.sh
fi

# # Define o papel de parede se feh não estiver em execução
# if ! pgrep -x feh > /dev/null; then
    feh --bg-fill --no-xinerama ~/Pictures/Wallpapers/blueNebula.jpg &
# fi

# Inicia openrgb se não estiver em execução
if ! pgrep -x openrgb > /dev/null; then
    openrgb --startminimized &
fi

# Inicia picom se não estiver em execução
if ! pgrep -x picom > /dev/null; then
    picom -b &
fi

# Inicia polkit-gnome-authentication-agent-1 se não estiver em execução
if ! pgrep -f polkit-gnome-authentication-agent-1 > /dev/null; then
    sleep 1 && /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi