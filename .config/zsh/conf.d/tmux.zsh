# ~/.config/zsh/conf.d/tmux.zsh

# Inicia o tmux automaticamente se:
# 1. O comando tmux existir
# 2. Não estivermos já dentro de uma sessão tmux
# 3. O shell for interativo
if [[ -x "$(command -v tmux)" ]] && [[ -z "$TMUX" ]] && [[ $- == *i* ]]; then
  # Cria uma nova sessão com nome único (evita conflito)
  tmux new-session -s "$(($(tmux list-sessions | wc -l) + 1))"  # Nome baseado em timestamp
fi