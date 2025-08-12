

# ZSH_AUTOSUGGEST_STRATEGY=(history)  # Estratégia de sugestões
# ZSH_AUTOSUGGEST_USE_ASYNC=1         # Uso assíncrono

# Plugins (mantenha esta ordem!)
for plugin in \
  "/usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh" \
  "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" \
  "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
do
  if [[ -r "$plugin" ]]; then
    # echo "[DEBUG] Carregando ${plugin:t}"
    source "$plugin"
  else
    echo "[ERRO] Não encontrou $plugin"
  fi
done

# Configurações para manter caminhos relativos no autocompletar
zstyle ':autocomplete:*' path-completion relative
zstyle ':autocomplete:*' file-suffixes ''
zstyle ':completion:*' path-completion no
zstyle ':completion:*:*:cd:*' ignore-parents parent pwd


autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES

precmd() {
    if ! [[ -n ${(f)functions[_autocomplete_widget]} ]]; then
        # echo "Recarregando zsh-autocomplete..."
        source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
    fi
}