#/usr/bin/env bash

# set -eufo

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
    echo -e "$formatted_message" >&2
  else
    echo -e "$formatted_message"
  fi
}

function prepare_env() {
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
  export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
  export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
  export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
  export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

  if [[ ":$PATH:" != *":$XDG_BIN_HOME:"* ]]; then
    export PATH="$XDG_BIN_HOME:$PATH"
  fi
}

function install_doot() {
  # Stolen from https://github.com/pol-rivero/doot/blob/main/install.sh

  if command -v doot >/dev/null 2>&1; then
    log info "\`doot\` is already in \$PATH."
    return
  fi

  repo_name="pol-rivero/doot"

  os=$(uname -s)
  if [ "$os" = "Linux" ]; then
    log debug "Detected OS: Linux"
    base_name="doot-linux"
  elif [ "$os" = "Darwin" ]; then
    log debug "Detected OS: macOS"
    base_name="doot-darwin"
  else
    log error "Your OS is not supported. Consider downloading and installing the binary manually."
    exit 1
  fi

  arch=$(uname -m)
  if [ "$arch" = "x86_64" ]; then
    log debug "Detected architecture: x86_64"
    base_name="$base_name-x86_64"
  elif [ "$arch" = "aarch64" ] || [ "$arch" = "arm64" ]; then
    log debug "Detected architecture: arm64 (aarch64)"
    base_name="$base_name-arm64"
  else
    log info "Your CPU architecture is not supported. Consider compiling from source."
    exit 1
  fi

  log info "Downloading the latest release..."

  download_url=$(curl -s https://api.github.com/repos/$repo_name/releases/latest |
    grep "browser_download_url.*$base_name" |
    cut -d '"' -f 4)

  if [ $? -ne 0 ]; then
    log error "Failed to fetch the latest release information. Please check your internet connection or the GitHub API status."
    exit 1
  fi

  if [ -z "$download_url" ]; then
    log error "No suitable binary found for your OS and architecture. Please check the GitHub releases page."
    exit 1
  fi

  curl -L -o doot "$download_url"
  if [ $? -ne 0 ]; then
    log error "Failed to download the binary. Please check your internet connection or the URL: $download_url"
    exit 1
  fi

  chmod +x doot
  if [ $? -ne 0 ]; then
    log error "Failed to make ./doot executable. Please check your permissions."
    exit 1
  fi

  log info "The binary will now be moved to /usr/local/bin/doot, you may be prompted for your password."
  sudo mv doot /usr/local/bin/doot
  if [ $? -ne 0 ]; then
    log error "Failed to move the binary to /usr/local/bin. Please check your permissions."
    exit 1
  fi

  log success "Installation complete! You can now run \`doot\` from anywhere in your terminal."
}

function main() {
  prepare_env
  install_doot

  dotfiles_repo="pinanek/dotfiles"
  dotfiles_dir="$XDG_DATA_HOME/dotfiles"

  # doot bootstrap pinanek/dotfiles $dotfiles_dir
  . "$dotfiles_dir/scripts/bootstrap.$(hostname).sh"
}

main
