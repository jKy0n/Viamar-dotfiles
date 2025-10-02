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

# Configurações do man pages:
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PATH="$HOME/.local/bin:$PATH"

export PAY_RESPECTS_REQUIRE_CONFIRMATION="true"  # pay-respect: Pergunta antes de aplicar

setopt EXTENDED_GLOB  # Habilita padrões estendidos
setopt GLOB_DOTS  # Faz globs pegarem arquivos começados com .

# Garante ZSH como shell padrão no TMUX
[[ -z "$TMUX" ]] && export SHELL=$(which zsh)
