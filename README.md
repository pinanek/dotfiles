# pinanek's dotfiles

My dotfiles for macOS and Linux, managed and bootstrapped with [mise](https://mise.jdx.dev/).

## Overview

- Theme: [Catppina](https://github.com/pinanek/catppina), my custom theme based on [Catppuccin](https://catppuccin.com/).
- Font: [JetBrains Mono](https://www.jetbrains.com/lp/mono).
- Terminal: [Ghostty](https://ghostty.org/).
- Editor: [Helix](https://helix-editor.com/) and [Zed](https://zed.dev/).
- Shell: [Zsh](https://www.zsh.org/).
- Prompt: [Pure](https://github.com/sindresorhus/pure).
- Development environment: [mise](https://mise.jdx.dev/).
- Tools: [`bat`](https://github.com/sharkdp/bat), [`btop`](https://github.com/aristocratos/btop), [`delta`](https://github.com/dandavison/delta), [`eza`](https://github.com/eza-community/eza), [`fzf`](https://github.com/junegunn/fzf), [`lazygit`](https://github.com/jesseduffield/lazygit), [`vivid`](https://github.com/sharkdp/vivid), [`yazi`](https://github.com/sxyazi/yazi), and more.

## Installation

```sh
curl -fsSL https://raw.githubusercontent.com/pinanek/dotfiles/refs/heads/main/scripts/install.sh | sh
```

The installation script:

1. Installs mise when it is not already available.
2. Clones this repository to `~/.dotfiles`.
3. Trusts the repository's mise configuration.
4. Installs development tools and system packages.
5. Renders and applies the managed dotfiles.
6. Applies the configuration for the current operating system.

## Platform-specific configuration

The shared configuration is defined in:

```text
mise.toml
```

Platform-specific settings are loaded automatically:

```text
mise.macos.toml
mise.linux.toml
```
