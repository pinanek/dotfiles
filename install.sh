#!/bin/sh

set -eu

DOTFILES_REPO="${DOTFILES_REPO:-git@github.com:pinanek/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
MISE_INSTALL_PATH="${MISE_INSTALL_PATH:-$HOME/.local/bin/mise}"

error() {
  printf 'bootstrap: %s\n' "$*" >&2
  exit 1
}

command -v git >/dev/null 2>&1 ||
  error "git is required"

if command -v mise >/dev/null 2>&1; then
  mise_bin="$(command -v mise)"
elif [ -x "$MISE_INSTALL_PATH" ]; then
  mise_bin="$MISE_INSTALL_PATH"
else
  command -v curl >/dev/null 2>&1 ||
    error "curl is required to install mise"

  mkdir -p "$(dirname "$MISE_INSTALL_PATH")"

  curl -fsSL https://mise.run |
    MISE_INSTALL_PATH="$MISE_INSTALL_PATH" sh

  mise_bin="$MISE_INSTALL_PATH"
fi

export PATH="$(dirname "$mise_bin"):$PATH"

if [ -d "$DOTFILES_DIR/.git" ]; then
  printf 'Updating dotfiles at %s\n' "$DOTFILES_DIR"
  git -C "$DOTFILES_DIR" pull --ff-only
elif [ -e "$DOTFILES_DIR" ]; then
  error "$DOTFILES_DIR already exists but is not a Git repository"
else
  printf 'Cloning dotfiles into %s\n' "$DOTFILES_DIR"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

cd "$DOTFILES_DIR"

"$mise_bin" trust

set -- --yes

if [ "${DRY_RUN:-0}" = "1" ]; then
  set -- "$@" --dry-run
fi

if [ "${FORCE_DOTFILES:-0}" = "1" ]; then
  set -- "$@" --force-dotfiles
fi

"$mise_bin" bootstrap "$@"

printf '\nBootstrap completed successfully.\n'
