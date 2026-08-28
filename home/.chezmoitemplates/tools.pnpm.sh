install_pnpm_tools() {
    if ! command -v pnpm >/dev/null 2>&1; then
        log_warning 'Cannot install development npm tools: pnpm is unavailable.'
        return
    fi

    while read -r package; do
        [[ -n "$package" && "$package" != \#* ]] || continue
        log_info "Installing $package with pnpm..."
        pnpm add --global "$package@latest"
    done <<'PNPM_TOOLS'
{{ template "tools.pnpm" . }}
PNPM_TOOLS
}
