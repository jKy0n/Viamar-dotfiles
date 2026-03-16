#!/usr/bin/env bash
#
#       Title:      start-apps-viamar-pc.sh
#       Brief:      Script para iniciar os aplicativos de inicialização do Viamar PC
#       Path:       /home/jkyon/.config/awesome/scripts/start-apps-viamar-pc.sh
#       Author:     John Kennedy a.k.a. jKyon
#       Created:    2026-03-16
#       Updated:    2026-03-16
#       Notes:
#
#


set -u

USER_NAME="${USER:-$(id -un)}"
HOME_DIR="${HOME:-$(getent passwd "$USER_NAME" | cut -d: -f6)}"
LOGIN_SHELL="${SHELL:-$(getent passwd "$USER_NAME" | cut -d: -f7)}"

if [[ -z "$LOGIN_SHELL" || ! -x "$LOGIN_SHELL" ]]; then
    LOGIN_SHELL="/bin/bash"
fi

export USER="$USER_NAME"
export LOGNAME="${LOGNAME:-$USER_NAME}"
export HOME="$HOME_DIR"
export SHELL="$LOGIN_SHELL"

run_with_user_shell() {
    local command="$1"
    "$LOGIN_SHELL" -lic "$command" >/dev/null 2>&1 &
}

start_app() {
    local process_name="$1"
    local command="$2"

    if pgrep -u "$USER_NAME" -x "$process_name" >/dev/null; then
        printf '%s ja esta em execucao.\n' "$process_name"
        return 0
    fi

    printf 'Iniciando %s...\n' "$process_name"
    run_with_user_shell "$command"
}

start_app "pavucontrol" "pavucontrol"
start_app "code" "code"
start_app "obsidian" "obsidian"
start_app "rambox" "rambox"
start_app "spotify" "spotify"
start_app "firefox" "firefox"

exit 0