function install_brew() {
  log debug 'Installing `brew`...'
  if [ ! -f /opt/homebrew/bin/brew ]; then
    sudo echo -n
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    log success '`brew` is installed.'
  else
    log info '`brew` is already installed.'
  fi
}

function install_packages() {
  function _install() {
    local bin=$1
    shift

    local packages=("${@}")
    local installed_packages="$($bin list)"

    for package in "${packages[@]}"; do
      if ! echo $installed_packages | grep $package &>/dev/null; then
        log debug "- \`$package\`..."
        $bin install $package
      fi
    done
  }

  formulae=("bat" "eza" "fastfetch" "fish" "fzf" "gh" "git" "gnupg" "mas" "mise" "ouch" "scooter" "pkgconf" "tmux" "vivid" "yazi" "wget")
  casks=("blackhole-2ch cleanupbuddy" "clop" "crystalfetch" "cyberduck" "discord" "firefox@developer-edition" "font-symbols-only-nerd-font" "ghostty" "google-chrome@dev" "hex-fiend" "httpie" "iina" "jordanbaird-ice" "keepingyouawake" "keka" "kekaexternalhelper" "mac-mouse-fix" "messenger" "orion" "pearcleaner" "telegram" "transmission" "utm"
  )
  app_store_apps=(
    1632827132 # Camera Preview
    1545870783 # Color Picker
    1355679052 # Dropover
    6444667067 # Hyperduck
    1433648537 # Passepartout
    1519867270 # Refined Github
    1596706466 # Speediness
    1481853033 # Strongbox
    1662217862 # Wipr
  )

  echo
  log info "Installing packages..."

  log info "Installing formulae..."
  _install brew $(echo "${formulae[@]}")

  log info "Installing casks..."
  _install brew $(echo "${casks[@]}")

  log info "Installing app store apps..."
  _install mas $(echo "${app_store_apps[@]}")

  log success "All package are installed."
}

function change_default_shell() {
  shell_path=/opt/homebrew/bin/fish
  etc_shells_path=/etc/shells

  echo
  log info "Changing the default shell to \"$shell_path\"..."
  if [[ "$SHELL" == "$shell_path" ]]; then
    log info "The default shell is already changed to \"$shell_path\"."
  else
    if ! grep -q "$shell_path" "$etc_shells_path"; then
      log info "\"${shell_path}\" isn't in \"$etc_shells_path\"! Adding to \"$etc_shells_path\"..."
      echo $shell_path | tee -a $etc_shells_path >>/dev/null
    fi
    chsh -s "$shell_path"
    log success "The default shell is changed to \"$shell_path\"."
  fi
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
  defaults write com.apple.dock largesize -int 100

  # Disable automatic space switching
  defaults write com.apple.dock workspaces-auto-swoosh -bool false

  # Keyboard
  # The key repeat rate
  defaults write NSGlobalDomain KeyRepeat -int 2

  # The initial key repeat rate
  defaults write NSGlobalDomain InitialKeyRepeat -int 25

  # App-specific behavior when a key is held down
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

  log success "MacOS defaults configured!"
}

function install_mise_packages() {
  echo
  log info 'Installing `mise` packages...'
  mise install -y
  mise prune -y
  log success 'Done installing `mise` packages!'
}

function build_helix() {
  fish -c "build_helix"
}

function build_bat_cache() {
  fish -c "build_bat_cache"
}

function build_mosh() {
  fish -c "build_mosh"
}

install_brew
install_packages
change_default_shell
configure_macos_defaults
install_mise_packages
build_helix
build_bat_cache
build_mosh
