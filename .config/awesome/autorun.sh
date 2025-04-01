#!/usr/bin/env bash

# Inicia openrgb se não estiver em execução
if ! pgrep -x openrgb > /dev/null; then
    openrgb --startminimized --profile Viamar-PC &
fi

# Inicia picom se não estiver em execução
if ! pgrep -x picom > /dev/null; then
    picom -b &
fi

# Inicia polkit-gnome-authentication-agent-1 se não estiver em execução
if ! pgrep -f polkit-gnome-authentication-agent-1 > /dev/null; then
    sleep 1 && /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi