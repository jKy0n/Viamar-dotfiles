# ~/.config/zsh/conf.d/ssh-agent.zsh

# Inicializa o ssh-agent
eval "$(ssh-agent -s)" > /dev/null

# Inicializa o keychain
eval $(keychain --eval --quiet Viamar-GitHub)