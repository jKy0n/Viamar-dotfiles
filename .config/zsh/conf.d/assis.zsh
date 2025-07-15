# Assis project.

# Assis is a custom Zsh function that leverages artificial intelligence (via Ollama + Mistral-instruct)
# to act as a virtual assistant directly in the terminal, aiding in administrative tasks and system management.

function assis() {
    local query="$*"
    local context=""

    # Se tiver entrada via pipe (stdin), isso é prioridade de contexto
    if [ ! -t 0 ]; then
        context+="$(cat -)"
    else
        # Casos de RAG por palavras-chave (quando não vem via pipe)
        if [[ "$query" == *"ananicy"* ]]; then
            context+="\n### [/etc/ananicy.conf]\n"
            context+="$(cat /etc/ananicy.conf 2>/dev/null)\n"
        
        elif [[ "$query" == *"dns"* || "$query" == *"resolv"* || "$query" == *"internet"* ]]; then
            context+="\n### [/etc/resolv.conf]\n"
            context+="$(cat /etc/resolv.conf 2>/dev/null)\n"    
        
        elif [[ "$query" == *"fstab"* || "$query" == *"mount"* || "$query" == *"partição"* ]]; then
            context+="\n### [/etc/fstab]\n"
            context+="$(cat /etc/fstab 2>/dev/null)\n"

        elif [[ "$query" == *"hostname"* ]]; then
            context+="\n### [/etc/hostname]\n"
            context+="$(cat /etc/hostname 2>/dev/null)\n"

        elif [[ "$query" == *"NetworkManager"* ]]; then
            context+="\n### [journalctl -u NetworkManager]\n"
            context+="$(journalctl -u NetworkManager -n 20 --no-pager 2>/dev/null)\n"
            context+="\n### [/etc/NetworkManager/NetworkManager.conf]\n"
            context+="$(cat /etc/NetworkManager/NetworkManager.conf 2>/dev/null)\n"

        elif [[ "$query" == *"pacman"* || "$query" == *"mirrorlist"* ]]; then
            context+="\n### [/etc/pacman.conf]\n"
            context+="$(cat /etc/pacman.conf 2>/dev/null)\n"
            context+="\n### [mirrorlist]\n"
            context+="$(grep -v '^#' /etc/pacman.d/mirrorlist 2>/dev/null | head -n 10)\n"

        elif [[ "$query" == *"systemd"* || "$query" == *"boot"* ]]; then
            context+="\n### [/etc/systemd/system.conf]\n"
            context+="$(cat /etc/systemd/system.conf 2>/dev/null)\n"

        elif [[ "$query" == *"sudoers"* || "$query" == *"sudo"* ]]; then
            context+="\n### [/etc/sudoers]\n"
            context+="$(grep -v '^#' /etc/sudoers 2>/dev/null)\n"
        fi
    fi

    # Monta o prompt final
    local prompt=""
    if [[ -n "$context" ]]; then
        prompt="### 📎 Contexto do sistema:\n$context\n\n### ❓Pergunta:\n$query"
    else
        prompt="$query"
    fi

    # Executa o modelo e mostra com glow
    local answer=$(ollama run mistral:7b-instruct-v0.3-q4_K_M "$prompt")
    echo -e "$answer" | glow -s dark -p
}