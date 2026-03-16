#!/usr/bin/env sh

set -eu

zsh_bin="$(command -v zsh)"

exec tmux new-session -A -s fastfetch "exec ${zsh_bin} -lc 'fastfetch --config ~/.config/fastfetch/ffetch-viamar-PC.jsonc; exec ${zsh_bin} -l'"