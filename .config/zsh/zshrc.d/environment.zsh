# Editor padrão
export EDITOR=nvim
export SUDO_EDITOR=nvim

# Define compilações em ~/.build
export CARGO_HOME="$HOME/.build/cargo"
export CARGO_TARGET_DIR="/home/jkyon/.build/cargo-target"
export PIP_CACHE_DIR="/home/jkyon/.build/pip-cache"

# Configurações do ccache
export CCACHE_DIR="$HOME/.build/ccache"
export CCACHE_COMPRESS=1
export CCACHE_MAXSIZE=10G

export PATH="$HOME/.local/bin:$PATH"

export PAY_RESPECTS_REQUIRE_CONFIRMATION="true"  # pay-respect: Pergunta antes de aplicar

# Garante ZSH como shell padrão no TMUX
[[ -z "$TMUX" ]] && export SHELL=$(which zsh)
