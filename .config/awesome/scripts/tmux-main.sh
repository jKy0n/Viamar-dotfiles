#!/usr/bin/env sh

set -eu

zsh_bin="$(command -v zsh)"

exec tmux new-session -A -s main -n panel "exec ${zsh_bin} -l"