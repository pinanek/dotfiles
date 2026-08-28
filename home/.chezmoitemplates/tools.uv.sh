install_uv_tools() {
    if [[ ! -x "$uv" ]]; then
        log_warning 'Cannot install development uv tools: uv is unavailable.'
        return
    fi

    while read -r package executable; do
        [[ -n "$package" && -n "$executable" && "$package" != \#* ]] || continue

        if command -v "$executable" >/dev/null 2>&1 || [[ -x "$local_bin/$executable" ]]; then
            log_info "$executable is already installed."
        else
            log_info "Installing $package with uv..."
            "$uv" tool install "$package"
        fi
    done
}
