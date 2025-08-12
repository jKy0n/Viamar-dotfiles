# zshrc.d/keybinds.zsh

# Apagar segmento de path com Ctrl+Backspace
delete-path-segment-backward() {
  local WORDCHARS_SAVE=$WORDCHARS
  WORDCHARS=${WORDCHARS_SAVE//\//}
  zle backward-kill-word
  WORDCHARS=$WORDCHARS_SAVE
}
zle -N delete-path-segment-backward delete-path-segment-backward


# Modo de edição (emacs ou vi)
bindkey -e  # Usando modo emacs

# Navegação em linhas
bindkey "^[[H"      beginning-of-line   # Home
bindkey "^[[F"      end-of-line         # End
bindkey "^[[3~"     delete-char         # Delete

# Navegação por palavras
bindkey "^[[1;5D"   backward-word       # Ctrl + ←
bindkey "^[[1;5C"   forward-word        # Ctrl + →

# Atalhos específicos
bindkey "^[[1;3B"   menu-complete       # Alt + ↓ (rotação de completions)
bindkey "^[["       backward-kill-word  # Alt + Backspace
bindkey "^[^[[C"    autosuggest-accept  # Aceitar sugestão (→)
bindkey "^H"        delete-path-segment-backward # Ctrl+Backspace — ajuste o código se necessário
