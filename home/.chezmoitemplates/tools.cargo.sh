install_cargo_tools() {
    if [[ ! -x "$cargo" ]]; then
        log_warning 'Cannot install development Cargo tools: Cargo is unavailable.'
        return
    fi

    while read -r package; do
        [[ -n "$package" && "$package" != \#* ]] || continue

        if command -v "$package" >/dev/null 2>&1 || [[ -x "$HOME/.cargo/bin/$package" ]]; then
            log_info "$package is already installed."
        else
            log_info "Installing $package with Cargo..."
            "$cargo" install --locked "$package"
        fi
    done <<'CARGO_TOOLS'
{{ template "tools.cargo" . }}
CARGO_TOOLS
}
