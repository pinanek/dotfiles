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

  configure_macos_defaults
}

main
