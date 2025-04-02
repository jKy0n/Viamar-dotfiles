# Assis project.

# Assis is a custom Zsh function that leverages artificial intelligence (via Ollama + Mistral-instruct)
# to act as a virtual assistant directly in the terminal, aiding in administrative tasks and system management.

function assis() {
  # Caminho absoluto do Ollama (verifique com 'which ollama')
  local OLLAMA_BIN="/usr/bin/ollama"
  
  # Configuração do sandbox com acesso necessário
  bwrap \
    --ro-bind / / \
    --ro-bind $OLLAMA_BIN $OLLAMA_BIN \
    --ro-bind /usr/lib64 /usr/lib64 \
    --tmpfs /tmp \
    --share-net \
    --unshare-uts \
    $OLLAMA_BIN run mistral:7b-instruct-v0.3-q4_K_M \
    "[CONTEXTO] Kernel: $(uname -r)
    
    Regras do Assis:
    1. Acesso somente leitura a:
       - /etc/*
       - /var/log/**/*.log
       - ~/.config
    2. Formate respostas em markdown
    3. Traduza termos técnicos (PT-BR)
    
    [PERGUNTA] $@" | glow -s dark
}