function build_helix
    echo
    log info "Building `helix`..."

    set helix_path "$XDG_DATA_HOME/helix"
    set helix_repo "https://github.com/helix-editor/helix"

    log info "Checking for cargo..."
    if not type -q cargo
        log error "`cargo` is not installed or not in PATH. Exiting..."
        exit 1
    end

    log info "Checking if $helix_path exists and is a Git repository..."
    if test -d $helix_path -a -d "$helix_path/.git"
        log info "Directory exists and is a Git repo. Pulling latest changes..."

        pushd $helix_path
        git pull
        popd $helix_path
    else
        log info "Directory does not exist or is not a Git repo. Re-cloning..."
        rm -rf $helix_path
        git clone $helix_repo $helix_path
    end

    log info "Installing Helix with cargo..."
    pushd $helix_path
    cargo install --path helix-term --locked
    popd $helix_path

    log info "Linking runtime directory..."
    rm -rf $XDG_CONFIG_HOME/helix/runtime && ln -s $helix_path/runtime $XDG_CONFIG_HOME/helix/runtime

    log success "`helix` is built."
end
