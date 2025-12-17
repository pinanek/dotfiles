# pinanek's dotfiles

My dotfiles for MacOS and Linux, managed with [chezmoi](https://www.chezmoi.io).

<p align="center">
  <img src="assets/preview.png" alt="An image of helix" />
</p>

## Overview

- Theme: [Catppina](https://github.com/pinanek/catppina) - My custom theme based on [Catpppuccin](https://catppuccin.com/).
- Font: [JetBrains Mono](https://www.jetbrains.com/lp/mono).
- Terminal: [Ghostty](https://ghostty.org).
- Editor: [Helix](https://helix-editor.com).
- Shell: [Zsh](https://www.zsh.org/).
- Prompt: [Pure](https://github.com/sindresorhus/pure).
- Dev env: [Mise](https://mise.jdx.dev/).
- Others: [`bat`](https://github.com/sharkdp/bat), [`btop`](https://github.com/aristocratos/btop), [`delta`](https://github.com/dandavison/delta), [`eza`](https://github.com/eza-community/eza), [`fzf`](https://github.com/junegunn/fzf) [`lazygit`](https://github.com/jesseduffield/lazygit), [`vivid`](https://github.com/sharkdp/vivid), [`yazi`](https://github.com/sxyazi/yazi), etc.

## Installation

```shell
curl -fsSL https://raw.githubusercontent.com/pinanek/dotfiles/refs/heads/main/scripts/install.sh | bash
```

Automatically installs and configures dotfiles based on:

- Hostname:
  - `pinamac`: MacOS
- Fallback by OS detection: `ubuntu`, `debian`.
