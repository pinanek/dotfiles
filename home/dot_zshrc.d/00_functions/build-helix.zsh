function build-helix() {
  log info "Building helix..."

  helix_path="$XDG_DATA_HOME/helix"
  helix_repo="https://github.com/helix-editor/helix"

  log info "Checking for cargo..."
  if ! command -v cargo >/dev/null 2>&1; then
    log error "cargo is not installed or not in PATH. Exiting..."
    exit 1
  fi

  log info "Checking if $helix_path exists and is a Git repository..."
  if [[ -d "$helix_path" && -d "$helix_path/.git" ]]; then
    log info "Directory exists and is a Git repo. Pulling latest changes..."
    pushd "$helix_path" >/dev/null
    git pull
    popd >/dev/null
  else
    log info "Directory does not exist or is not a Git repo. Re-cloning..."
    rm -rf "$helix_path"
    git clone "$helix_repo" "$helix_path"
  fi

  log info "Installing Helix with cargo..."
  pushd "$helix_path" >/dev/null
  cargo install --path helix-term --locked
  popd >/dev/null

  log info "Linking runtime directory..."
  rm -rf "$XDG_CONFIG_HOME/helix/runtime"
  ln -s "$helix_path/runtime" "$XDG_CONFIG_HOME/helix/runtime"

  log success "helix is built."
}
