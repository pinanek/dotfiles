#!/usr/bin/env bash

set -eufo pipefail

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

function prepare_env() {
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
  export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
  export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
  export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
  export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

  # Add Homebrew bin to PATH if on macOS
  if [[ "$(uname -s)" == "Darwin" ]]; then
    brew_bin_path="/opt/homebrew/bin"
    if [[ ":$PATH:" != *":$brew_bin_path:"* ]]; then
      export PATH="$brew_bin_path:$PATH"
    fi
  fi

  if [[ ":$PATH:" != *":$XDG_BIN_HOME:"* ]]; then
    export PATH="$XDG_BIN_HOME:$PATH"
  fi
}

function main() {
  machines=("pina-mac" "ubuntu")

  machine_list=$(printf '`%s`,' "${machines[@]}")
  machine_list="Available machines: [${machine_list%,}]"

  input_machine="$1"

  if [[ -z "$input_machine" ]]; then
    log error "No argument provided.\nUsage: $0 \`machine_name\`\n$machine_list"
    exit 1
  fi

  if [[ ! " ${machines[*]} " =~ " ${input_machine} " ]]; then
    log error "Invalid machine: \"$input_machine\"\n$machine_list"
    exit 1
  fi

  log info "Machine: $input_machine"
  log info "Installing \`lnk\`..."
  # curl -sSL https://raw.githubusercontent.com/yarlson/lnk/main/install.sh | bash

  machine=$input_machine lnk bootstrap
}

main "$@"
