# Editor padrão
export EDITOR=nvim
export SUDO_EDITOR=nvim

export PAY_RESPECTS_REQUIRE_CONFIRMATION='true'  # pay-respect: Pergunta antes de aplicar

# Garante ZSH como shell padrão no TMUX
[[ -z "$TMUX" ]] && export SHELL=$(which zsh)