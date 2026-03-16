#!/usr/bin/env sh

#
#        Title:      tmux-fastfetch.sh
#        Brief:      Script para iniciar a sessão do tmux com fastfetch
#        Path:       /home/jkyon/.config/awesome/scripts/tmux-fastfetch.sh
#        Author:     John Kennedy a.k.a. jKyon
#        Created:    2026-03-16
#        Updated:    2026-03-16
#        Notes:      Apenas um script para iniciar a sessão do tmux com fastfetch, usando o
#

set -eu

zsh_bin="$(command -v zsh)"

exec tmux new-session -A -s fastfetch "exec ${zsh_bin} -lc 'fastfetch --config ~/.config/fastfetch/ffetch-viamar-PC.jsonc; exec ${zsh_bin} -l'"