function build_mosh
    echo
    log info "Building `mosh`..."

    set mosh_path "$XDG_DATA_HOME/mosh"
    set mosh_repo "https://github.com/jdrouhard/mosh"

    log info "Checking if $mosh_path exists and is a Git repository..."
    if test -d $mosh_path -a -d "$mosh_path/.git"
        log info "Directory exists and is a Git repo. Pulling latest changes..."

        pushd $mosh_path
        git pull
        popd $mosh_path
    else
        log info "Directory does not exist or is not a Git repo. Re-cloning..."
        rm -rf $mosh_path
        git clone $mosh_repo $mosh_path
    end

    log info "Installing mosh ..."
    pushd $mosh_path
    ./autogen.sh
    ./configure
    make
    sudo make install
    popd $mosh_path

    log success "`mosh` is built."
end
