#/usr/bin/env bash

set -euo pipefail

function log() {
  local level="$1"
  shift
  local title="$1"
  shift

  local log_color std

  case $level in
  debug) log_color=0 ;;
  info) log_color=4 ;;
  success) log_color=2 ;;
  warn) log_color=3 ;;
  error) log_color=1 ;;
  fatal) log_color=5 ;;
  *) log_color=0 ;;
  esac

  case $level in
  warn | error | fatal) std="&2" ;;
  *) std="&1" ;;
  esac

  local color_code="\033[0;3${log_color}m"
  local no_color='\033[0m'

  local uppercase_level="$(printf '%-7s' $level | tr [:lower:] [:upper:])"
  local formatted_message="$(date +%H:%M:%S) ${color_code}${uppercase_level}${no_color} $title $*"

  if [[ "$std" == "&2" ]]; then
    echo "$formatted_message" >&2
  else
    echo "$formatted_message"
  fi
}


function pull_theme() {
  local name=$1
  local url=$2
  local destination=$3

  echo
  log info "Getting the theme for $name..."

  mkdir -p "$(dirname "$destination")"

  # Fetch the file
  if curl -fsSL "$url" -o "$destination"; then
    log success "Downloaded theme for $name to $destination"
  else
    log error "Failed to download theme for $name from $url"
    return 1
  fi
}
function main() {
  pull_theme \
    'bat' \
    'https://raw.githubusercontent.com/pinanek/catppina/refs/heads/main/dist/bat/catppina.tmTheme' \
    $XDG_DATA_HOME/chezmoi/home/dot_config/bat/themes/catppina.tmTheme

  pull_theme \
    'btop' \
    'https://raw.githubusercontent.com/pinanek/catppina/refs/heads/main/dist/btop/catppina.theme' \
    $XDG_DATA_HOME/chezmoi/home/dot_config/btop/themes/catppina.theme

  pull_theme \
    'delta' \
    'https://github.com/pinanek/catppina/raw/refs/heads/main/dist/delta/catppina.gitconfig' \
    $XDG_DATA_HOME/chezmoi/home/dot_config/delta/catppina.gitconfig

  pull_theme \
    'fzf' \
    'https://github.com/pinanek/catppina/raw/refs/heads/main/dist/fzf/catppina.sh' \
    $XDG_DATA_HOME/chezmoi/home/dot_zshrc.d/themes/fzf.zsh

  pull_theme \
    'ghostty' \
    'https://github.com/pinanek/catppina/raw/refs/heads/main/dist/ghostty/catppina.conf' \
    $XDG_DATA_HOME/chezmoi/home/dot_config/ghostty/themes/catppina

  pull_theme \
    'helix' \
    'https://github.com/pinanek/catppina/raw/refs/heads/main/dist/helix/catppina.toml' \
    $XDG_DATA_HOME/chezmoi/home/dot_config/helix/themes/catppina.toml

  pull_theme \
    'lazygit' \
    'https://github.com/pinanek/catppina/raw/refs/heads/main/dist/lazygit/catppina.yml' \
    $XDG_DATA_HOME/chezmoi/home/dot_config/lazygit/theme.yml

  pull_theme \
    'yazi' \
    'https://raw.githubusercontent.com/pinanek/catppina/refs/heads/main/dist/yazi/catppina.toml' \
    $XDG_DATA_HOME/chezmoi/home/dot_config/yazi/theme.toml

  pull_theme \
    'zsh-syntax-highlighting' \
    'https://raw.githubusercontent.com/pinanek/catppina/refs/heads/main/dist/zsh-syntax-highlighting/catppina.zsh' \
    $XDG_DATA_HOME/chezmoi/home/dot_zshrc.d/themes/zsh-syntax-highlighting.zsh
}

main
