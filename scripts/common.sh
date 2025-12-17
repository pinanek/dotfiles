#/usr/bin/env bash

set -euo pipefail

function prepare_env() {
  brew_bin_path=""
  if [[ "$os" == "Darwin" ]]; then
    brew_bin_path="/opt/homebrew/bin"
  elif [[ "$os" == "Linux" ]]; then
    brew_bin_path="/home/linuxbrew/.linuxbrew/bin"
  fi

  if [[ ":$PATH:" != *":$brew_bin_path:"* ]]; then
    export PATH="$brew_bin_path:$PATH"
  fi
}

function install_brew() {
  echo
  log info 'Installing brew...'

  if [ ! -f "$brew_bin_path/brew" ]; then
    sudo echo -n
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    log success 'brew is installed.'
  else
    log info 'brew is already installed.'
  fi

  log info 'Installing brew packages from Brewfiles...'
  eval $("$brew_bin_path/brew" shellenv)
  for brew_file in "$XDG_CONFIG_HOME"/brew/*; do
    if [[ -f "$brew_file" ]]; then
      log info "\tInstalling from $(basename "$brew_file")"
      brew bundle install --file="$brew_file"
    fi
  done
  log success 'All brew packages are installed.'
}

function install_mise() {
  echo
  log info 'Installing mise...'
  if ! command -v mise &>/dev/null; then
    curl -s https://mise.run | sh >/dev/null
  fi
  log success 'mise is installed.' echo

  echo
  log info 'Installing mise packages...'
  mise install -y
  mise prune -y
  log success 'All mise packages are installed.'
}

function change_default_shell() {
  shell_path="$(which zsh)"

  echo
  log info "Changing the default shell to \"$shell_path\"..."
  if [[ "$SHELL" == "$shell_path" ]]; then
    log info "The default shell is already changed to \"$shell_path\"."
  else
    sudo chsh -s $shell_path $USER
    log success "The default shell is changed to \"$shell_path\"."
  fi
}
