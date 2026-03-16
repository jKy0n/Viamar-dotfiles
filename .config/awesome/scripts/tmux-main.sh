#!/usr/bin/env sh

#
#       Title:      tmux-main.sh
#       Brief:      Script para iniciar a sessão principal do tmux
#       Path:       /home/jkyon/.config/awesome/scripts/tmux-main.sh
#       Author:     John Kennedy a.k.a. jKyon
#       Created:    2026-03-16
#       Updated:    2026-03-16
#       Notes:      pt-BR: Apenas prepara o terminal para o uso diário.
#                   eng:   Just prepares the terminal for daily use.
#

set -eu

zsh_bin="$(command -v zsh)"

exec tmux new-session -A -s main -n panel "exec ${zsh_bin} -l"