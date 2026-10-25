# pinanek's dotfiles

My dotfiles for macOS and Linux, managed with [chezmoi](https://www.chezmoi.io/).

## Overview

- Theme: [Catppina](https://github.com/pinanek/catppina), a custom theme based on [Catppuccin](https://catppuccin.com/).
- Font: [JetBrains Mono](https://www.jetbrains.com/lp/mono/).
- Terminal: [Ghostty](https://ghostty.org/) on macOS.
- Editors: [Helix](https://helix-editor.com/) and [Zed](https://zed.dev/) on macOS.
- Shell: [Zsh](https://www.zsh.org/).
- Prompt: [Pure](https://github.com/sindresorhus/pure).
- Session manager: [zmx](https://github.com/neurosnap/zmx).
- Tools: [`btop`](https://github.com/aristocratos/btop), [`delta`](https://github.com/dandavison/delta), [`eza`](https://github.com/eza-community/eza), [`fzf`](https://github.com/junegunn/fzf), [`vivid`](https://github.com/sharkdp/vivid), [`yazi`](https://github.com/sxyazi/yazi), and more.

## Profiles

During `chezmoi init`, choose one profile:

| Profile | Platform | Package manager |
| --- | --- | --- |
| `pinamac` | macOS | Homebrew Bundle |
| `isl-server` | Debian/Linux | APT, `bin`, and `uv` |

The selected profile is saved in chezmoi's generated configuration under `[data]`.

## Installation

Initialize and apply the dotfiles from GitHub:

```sh
sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply pinanek
```

Or, with `wget`:

```sh
sh -c "$(wget -qO- https://get.chezmoi.io/lb)" -- init --apply pinanek
```

Choose `pinamac` or `isl-server` when prompted. To apply later changes:

```sh
chezmoi apply
```

Use `chezmoi diff` to preview managed-file changes before applying them.

## Repository layout

```text
.chezmoiroot              # Uses ./home as the chezmoi source root
home/
├── .chezmoi.toml.tmpl    # Prompts for and persists the selected profile
├── .chezmoiignore        # Profile-specific file and script filtering
├── .chezmoiscripts/      # Ordered run_onchange bootstrap scripts
├── .chezmoitemplates/    # Package manifests and shared script templates
├── dot_config/           # Managed ~/.config contents
└── dot_zshrc             # Managed ~/.zshrc
```

## Dots CLI

```sh
dots update                  # Update all packages for the active profile
dots update system           # Homebrew/MAS or APT only
dots update node             # fnm and Node.js LTS
dots update rust             # Rust toolchains and Cargo tools
dots update editors          # Helix and Mitos
dots update tools            # bin, pnpm, and uv tools/Python

dots theme update           # Sync Catppina themes and apply dotfiles

dots diff                    # Preview managed-file changes
dots apply                   # Apply dotfiles, including bootstrap scripts
dots pull                    # Fast-forward from origin main without applying dotfiles
dots push                    # Commit all changes as "chore: update" and push to origin main

dots completion zsh          # Generate Zsh completion
dots help                    # Show commands and active profile
```

## Local configuration

Keep machine-specific settings in unmanaged local files:

- `~/.zshrc_local` is sourced by `~/.zshrc` and can contain local aliases, environment variables, or shell settings.
- `~/.gitconfig.local` is included by `~/.gitconfig` and can contain local Git identity or repository-specific settings.

```zsh
# ~/.zshrc_local
export EXAMPLE_LOCAL_SETTING=value
```

```ini
# ~/.gitconfig.local
[user]
    name = Your Name
    email = you@example.com
```
