# 🐚 zsh config 🎛️

Minha configuração modular para Zsh, projetada para ser granular, organizada e fácil de manter.

<details>
    <summary>🇧🇷 Descrição em Português:</summary>
        <br>
            O zsh foi modularizado para ser mais granular e ter melhor organização do código.
        </br>
</details>

<details>
    <summary>🇬🇧 English Description:</summary>
        <br>
            The zsh was modularized for better granularity and organization of code.
        </br>
</details>

![zsh dir](https://github.com/jKy0n/Viamar-dotfiles/blob/master/Pictures/Viamar-PC-media/zsh_-_2025-09-23.png)

## ✨ Recursos

*   **🚀 Inicialização Rápida:** Carrega apenas os módulos necessários, garantindo um tempo de inicialização otimizado.
*   **🧩 Modular:** As configurações são divididas em módulos, facilitando a manutenção e personalização.
*   **🎨 Tema Powerlevel10k:** Tema altamente personalizável e informativo.
*   **🤖 Autocompletar e Sugestões:** Usa `zsh-autocomplete` e `zsh-autosuggestions` para uma experiência de linha de comando mais inteligente.
*   **📜 Histórico Persistente:** Compartilha o histórico entre as sessões do terminal.
*   **⌨️ Atalhos de Teclado:** Atalhos de teclado personalizados para uma navegação mais eficiente.
*   **🔒 Gerenciamento de Segredos:** Suporte para carregar chaves de API e outros segredos de forma segura.

## 📂 Estrutura Modular

A configuração é dividida nos seguintes módulos:

*   `zshrc`: O arquivo principal que detecta o ambiente (distribuição Linux, TTY) e carrega o arquivo de configuração apropriado.
*   `zshrc-arch.zsh`: Carrega todos os módulos e configurações específicas para o Arch Linux.
*   `aliases.zsh`: Carrega um arquivo de aliases externo.
*   `environment.zsh`: Define as variáveis de ambiente.
*   `history.zsh`: Configura o histórico do Zsh.
*   `keybinds.zsh`: Define os atalhos de teclado personalizados.
*   `plugins-arch.zsh`: Carrega os plugins do Zsh específicos para o Arch Linux.
*   `theme.zsh`: Carrega e configura o tema Powerlevel10k.
*   `tmux.zsh`: Inicia o `tmux` automaticamente em novas sessões do terminal.

## 🛠️ Instalação

1.  **Clone o repositório:**

    ```bash
    git clone https://github.com/seu-usuario/seu-repositorio.git ~/.config/zsh
    ```

2.  **Defina o Zsh como seu shell padrão:**

    ```bash
    chsh -s $(which zsh)
    ```

3.  **Inicie uma nova sessão do terminal.**

## ⚙️ Personalização

Para personalizar a configuração, você pode editar os arquivos de módulo individuais. Por exemplo, para adicionar um novo alias, edite o arquivo `aliases.zsh`. Para alterar as variáveis de ambiente, edite o arquivo `environment.zsh`.

## 🤝 Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir uma *issue* ou enviar um *pull request*.

## 📄 Licença

Este projeto está licenciado sob a licença MIT. Consulte o arquivo `LICENSE` para obter mais detalhes.