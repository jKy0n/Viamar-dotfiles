# Alacritty

![Screenshot do Alacritty](https://github.com/jKy0n/Viamar-dotfiles/blob/master/Pictures/Viamar-PC-media/alacritty-2026-02-25.png)

Configuração do **Alacritty** em TOML, com foco em um visual consistente (Catppuccin), boa legibilidade e alguns atalhos úteis (Vi mode e abertura de URLs).

## O que tem aqui

- Tema **Catppuccin Macchiato** via `import`.
- Shell padrão em `zsh` (login shell).
- Fonte **MesloLGS Nerd Font**.
- Janela com `opacity = 0.8` e título dinâmico.
- Cursor em formato *beam* e cursor de *vi mode* em bloco.
- *Hints* para detectar links e abrir no **Firefox**.

## Arquivos

- `alacritty.toml`: configuração principal.
- `catppuccin-macchiato.toml`: paleta de cores do tema.

## Atalhos (Vi mode)

> Observação: os atalhos abaixo funcionam quando o Alacritty está em **Vi mode**.

- Entrar/sair do Vi mode: `Ctrl+Shift+Space`
- Sair do Vi mode: `Esc`
- Movimento: `h` (esq), `j` (baixo), `k` (cima), `l` (dir)
- Início/fim da linha: `0` (início), `$` (fim)

## Hints / abertura de URLs

O bloco `[[hints.enabled]]` está configurado para:

- Detectar URLs com regex (`https?://...`)
- Permitir uso via mouse
- Abrir o link no **Firefox** em uma nova aba (`firefox --new-tab`)

## Requisitos / notas

- Instale a fonte **MesloLGS Nerd Font** no sistema (caso contrário, o Alacritty fará *fallback*).
- Esta configuração assume Alacritty com suporte a TOML e `hints`.
