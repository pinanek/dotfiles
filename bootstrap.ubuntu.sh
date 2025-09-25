function upgrade_system() {
  log info "Upgrading the system..."
  DEBIAN_FRONTEND=noninteractive sudo apt update && sudo apt upgrade -y
  log success "The system is upgraded."
}

function install_packages() {
  packages=("autoconf" "build-essential" "bison" "fish" "libncurses-dev" "protobuf-compiler" "libprotobuf-dev" "pkg-config" "libutempter-dev" "zlib1g-dev" "libssl-dev" "bash-completion" "less")

  echo
  log debug 'Adding `fish` nighlty PPA...'
  sudo add-apt-repository -y ppa:fish-shell/nightly-master

  log info "Installing packages..."
  DEBIAN_FRONTEND=noninteractive sudo apt update -y
  DEBIAN_FRONTEND=noninteractive sudo apt install -y "${packages[@]}"
  log success "All packages are installed."
}

function install_mise() {
  echo
  log info "Installing mise..."

  if ! command -v mise &>/dev/null; then
    curl -s https://mise.run | sh >/dev/null
  fi

  log success "\`mise\` is installed."
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

upgrade_system
install_packages
install_mise
install_mise_packages
build_helix
build_bat_cache
build_mosh
