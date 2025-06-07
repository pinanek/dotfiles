function build_helix
    set helix_path "$XDG_DATA_HOME/helix"
    set helix_repo "https://github.com/helix-editor/helix"

    echo "[INFO] Checking for cargo..."
    if not type -q cargo
        echo "[ERROR] 'cargo' is not installed or not in PATH. Exiting..."
        exit 1
    end

    echo "[INFO] Checking if $helix_path exists and is a Git repository..."
    if test -d $helix_path -a -d "$helix_path/.git"
        echo "[INFO] Directory exists and is a Git repo. Pulling latest changes..."

        pushd $helix_path
        git pull
        popd $helix_path
    else
        echo "[INFO] Directory does not exist or is not a Git repo. Re-cloning..."
        rm -rf $helix_path
        git clone $helix_repo $helix_path
    end

    echo "[INFO] Installing Helix with cargo..."
    pushd $helix_path
    cargo install --path helix-term --locked
    popd $helix_path

    echo "[INFO] Linking runtime directory..."
    rm -rf $XDG_CONFIG_HOME/helix/runtime && ln -s $helix_path/runtime $XDG_CONFIG_HOME/helix/runtime

    echo "[INFO] build_helix completed successfully."
end
