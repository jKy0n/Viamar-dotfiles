# Editor padrão
export EDITOR=nvim
export SUDO_EDITOR=nvim

# Garante ZSH como shell padrão no TMUX
[[ -z "$TMUX" ]] && export SHELL=$(which zsh)