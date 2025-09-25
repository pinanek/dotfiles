function build_bat_cache
    echo
    log info "Building `bat`'s cache..."
    bat cache --build
    log success "`bat`'s cache is built."
end
