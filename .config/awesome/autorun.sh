#!/usr/bin/env bash
# filepath: /home/jkyon/.config/awesome/autorun.sh

# Autorun script for AwesomeWM
# Script de inicialização automática para AwesomeWM


# Aplication and command autostart script
# Lista de aplicativos e comandos de inicialização
APPS=(
    # openRGB to manage RGB devices
    "openrgb --startminimized --profile Viamar-PC"
    # Network Manager Applet for network management
    "nm-applet"
    # Clipman to manage clipboard history
    "xfce4-clipman"
    # Light Locker to lockscreen after inactivity
    "light-locker"
    # Gnome Polkit authentication agent
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
)

# Function to check if an application is running and start it if not
# Função que inicia o aplicativo se ele não estiver em execução
start_app() {
    local app_cmd="$1"
    # Captura o nome do executável (primeiro token do comando)
    local proc_name
    proc_name=$(echo "$app_cmd" | awk '{print $1}')

    if pgrep -x "$(basename "$proc_name")" > /dev/null; then
        echo "$proc_name já está em execução."
    else
        echo "Iniciando $proc_name..."
        eval "$app_cmd" &
    fi
}

# Iterates over the list and launches each application
# Itera sobre a lista e inicia cada aplicativo
for app in "${APPS[@]}"; do
    start_app "$app"
done

exit 0