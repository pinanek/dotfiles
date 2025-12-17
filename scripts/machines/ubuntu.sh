function install_system_packages() {
  echo
  log info "Upgrading the system..."
  DEBIAN_FRONTEND=noninteractive sudo apt update && sudo apt upgrade -y
  log success "The system is upgraded."

  echo
  log info "Installing packages..."
  DEBIAN_FRONTEND=noninteractive sudo apt install -y build-essential procps curl file git zsh
  log success "All packages are installed."
}

function main() {
  prepare_env

  install_system_packages

  install_brew
  install_mise

  change_default_shell
}

main
