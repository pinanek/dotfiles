if [[ -t 1 && "${TERM:-dumb}" != 'dumb' && -z "${NO_COLOR:-}" ]]; then
    log_info_label=$(printf '\033[1;30;46m INFO \033[0m')
    log_warning_label=$(printf '\033[1;30;43m WARN \033[0m')
else
    log_info_label='[INFO]'
    log_warning_label='[WARN]'
fi

log_info() {
    printf '%s %s\n' "$log_info_label" "$1"
}

log_warning() {
    printf '%s %s\n' "$log_warning_label" "$1" >&2
}
