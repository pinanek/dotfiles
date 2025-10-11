function log() {
  local level="$1"
  shift
  local title="$1"
  shift

  local log_color std

  case $level in
  debug) log_color=0 ;;
  info) log_color=4 ;;
  success) log_color=2 ;;
  warn) log_color=3 ;;
  error) log_color=1 ;;
  fatal) log_color=5 ;;
  *) log_color=0 ;;
  esac

  case $level in
  warn | error | fatal) std="&2" ;;
  *) std="&1" ;;
  esac

  local color_code="\033[0;3${log_color}m"
  local no_color='\033[0m'

  local uppercase_level="$(printf '%-7s' $level | tr [:lower:] [:upper:])"
  local formatted_message="$(date +%H:%M:%S) ${color_code}${uppercase_level}${no_color} $title $*"

  if [[ "$std" == "&2" ]]; then
    echo -e "$formatted_message" >&2
  else
    echo -e "$formatted_message"
  fi
}
