function upgrade_system() {
  echo
  log info "Upgrading the system..."
  sudo dnf upgrade -y
  log success "The system is upgraded."
}

function install_packages() {
  echo
  log info 'Setting up RPM Fusion...'
  sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm || true
  sudo rpm -Uvh http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm || true
  log success 'RPM Fusion is installed.'

  echo
  log info "Installing packages..."
  sudo dnf group install -y c-development development-tools
  sudo dnf install -y zsh fzf
  log success "All packages are installed."
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
  source $HOME/.zshenv
  log success '`rust` is installed!'

  log info 'Installing `cargo` packages...'

  log debug 'Installing `cargo-binstall`...'
  curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
  log debug '`cargo-binstall` is installed.'

  cargo binstall --no-confirm bat \
    cargo-update \
    eza \
    fd-find \
    gitui \
    macchina \
    ouch \
    resvg \
    ripgrep \
    scooter \
    shpool \
    vivid \
    yazi-fm
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

function setup_shpool() {
  echo
  log info 'Setting up `shpool`...'

  curl -fLo "${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user/shpool.service" --create-dirs https://raw.githubusercontent.com/shell-pool/shpool/master/systemd/shpool.service
  sed -i "s|/usr|$HOME/.cargo|" "${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user/shpool.service"
  curl -fLo "${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user/shpool.socket" --create-dirs https://raw.githubusercontent.com/shell-pool/shpool/master/systemd/shpool.socket
  systemctl --user enable shpool
  systemctl --user start shpool
  loginctl enable-linger

  log success '`shpool` is set up.'
}

function change_default_shell() {
  shell_path="$(which zsh)"

  echo
  log info "Changing the default shell to \"$shell_path\"..."
  if [[ "$SHELL" == "$shell_path" ]]; then
    log info "The default shell is already changed to \"$shell_path\"."
  else
    chsh -s "$shell_path"
    log success "The default shell is changed to \"$shell_path\"."
  fi
}
function main() {
  upgrade_system
  install_packages

  install_mise
  install_rust

  build_helix
  build_bat_cache

  setup_shpool
  change_default_shell
}

main
