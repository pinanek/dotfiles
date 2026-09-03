install_bin_tools() {
    local source
    local executable
    local asset_pattern

    if [[ ! -x "$bin_manager" ]]; then
        log_warning 'Cannot install binary tools: bin is unavailable.'
        return
    fi

    while read -r source executable asset_pattern; do
        [[ -n "$source" && "$source" != \#* && -n "$executable" ]] || continue

        if [[ -x "$local_bin/$executable" ]]; then
            log_info "$executable is already installed."
        elif [[ -n "$asset_pattern" ]]; then
            log_info "Installing $executable with bin..."
            env PATH="$local_bin:$PATH" \
                "$bin_manager" install --name "$asset_pattern" \
                "$source" "$local_bin/$executable"
        else
            log_info "Installing $executable with bin..."
            env PATH="$local_bin:$PATH" \
                "$bin_manager" install "$source" "$local_bin/$executable"
        fi
    done
}
