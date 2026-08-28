install_bin_tools() {
    if [[ ! -x "$bin_manager" ]]; then
        log_warning 'Cannot install development binary tools: bin is unavailable.'
        return
    fi

    while read -r source executable asset_pattern; do
        [[ -n "$source" && -n "$executable" && "$source" != \#* ]] || continue

        if [[ -x "$local_bin/$executable" ]]; then
            log_info "$executable is already installed."
        else
            log_info "Installing $executable with bin..."
            env PATH="$local_bin:$PATH" \
                "$bin_manager" install --name "$asset_pattern" \
                "$source" "$local_bin/$executable"
        fi
    done
}
