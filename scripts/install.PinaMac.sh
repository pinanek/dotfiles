function prepare_env() {
  brew_bin_path='/opt/homebrew/bin'
  if [[ ":$PATH:" != *":$brew_bin_path:"* ]]; then
    export PATH="$brew_bin_path:$PATH"
  fi
}

function install_brew() {
  echo
  log info 'Installing `brew`...'

  if [ ! -f /opt/homebrew/bin/brew ]; then
    sudo echo -n
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    log success '`brew` is installed.'
  else
    log info '`brew` is already installed.'
  fi

  log info 'Installing `brew` packages...'
  brew bundle install --global
  log success 'All package are installed.'
}

function install_mise() {
  echo
  log info 'Installing mise...'
  if ! command -v mise &>/dev/null; then
    curl -s https://mise.run | sh >/dev/null
  fi
  log success '`mise` is installed.' echo

  echo
  log info 'Installing `mise` packages...'
  mise install -y
  mise prune -y
  log success 'All `mise` packages are installed.'
}

function install_rust() {
  echo
  log info 'Installing `rust` using `rustup`...'
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  log success '`rust` is installed!'

  log info 'Installing `cargo` packages...'

  log debug 'Installing `cargo-binstall`...'
  curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
  log debug '`cargo-binstall` is installed.'

  crates=(
    bat
    cargo-update
    eza
    fd-find
    gitui
    macchina
    ouch
    resvg
    ripgrep
    scooter
    vivid
    yazi-fm
  )
  cargo binstall --no-confirm "${crates[@]}"
  log success 'All `cargo` packages all installed.'
}

function build_helix() {
  echo
  source $HOME/.zshrc.d/00_functions/build-helix.zsh
  build-helix
}

function build_bat_cache() {
  echo
  source $HOME/.zshrc.d/00_functions/build-bat-cache.zsh
  build-bat-cache
}

function configure_macos_defaults() {
  echo
  log info "Configuring MacOS defaults..."

  # Hold control+command to drag the window
  defaults write -g NSWindowShouldDragOnGesture -bool true

  # Dock
  # Hide recent apps in the dock
  defaults write com.apple.dock show-recents -bool false

  # Auto hide the dock
  defaults write com.apple.dock autohide -bool true

  # Place the dock on the bottom of the screen
  defaults write com.apple.dock orientation -string bottom

  # Scroll to exposé app
  defaults write com.apple.dock scroll-to-open -bool true

  # The icon size of dock items
  defaults write com.apple.dock tilesize -int 80

  # The magnification size of dock items
  defaults write com.apple.dock largesize -int 120

  # Disable automatic space switching
  defaults write com.apple.dock workspaces-auto-swoosh -bool false

  # Keyboard
  # The key repeat rate
  defaults write NSGlobalDomain KeyRepeat -int 2

  # The initial key repeat rate
  defaults write NSGlobalDomain InitialKeyRepeat -int 25

  # App-specific behavior when a key is held down
  defaults write -g ApplePressAndHoldEnabled 0

  log success "MacOS defaults configured."
}

function main() {
  prepare_env

  install_brew
  install_mise
  install_rust

  build_helix
  build_bat_cache

  configure_macos_defaults
}

main
