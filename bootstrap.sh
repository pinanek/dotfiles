#!/usr/bin/env bash

set -eufo pipefail

available_hosts=('PinaMac' 'PinaServer')
available_oses=('Ubuntu')

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

function setup_env() {
  echo
  log debug 'Setting up enviroment variables...'

  export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

  if [[ ":$PATH:" != *":$XDG_BIN_HOME:"* ]]; then
    export PATH="$XDG_BIN_HOME:$PATH"
  fi

  log success 'Environment variables is set up.'
}

function detect_machine() {
  local machine=""

  local hostname=$(hostname)
  if [[ " ${available_hosts[*]} " =~ " $hostname " ]]; then
    machine="$hostname"
  else
    local os_type=$(uname -s)
    if [[ "$os_type" == 'Linux' ]] && [[ -f /etc/os-release ]]; then
      source /etc/os-release
      machine="${ID^}"
    elif [[ "$os_type" == 'Darwin' ]]; then
      machine='MacOS'
    fi
  fi

  # Validate machine
  if [[ ! " ${available_hosts[*]} ${available_oses[*]} " =~ " $machine " ]]; then
    machine="Unknown"
  fi

  echo "$machine"
}

function install_chezmoi() {
  echo
  log debug 'Installing `chezmoi`...'

  if command -v chezmoi >/dev/null 2>&1; then
    log info '`chezmoi` is alreay installed.'
    return
  fi

  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $XDG_BIN_HOME

  log success "\`chezmoi\` is installed to \"$XDG_BIN_HOME\"."
}

function main() {
  log debug 'Detecting the current machine...'
  local machine=$(detect_machine)
  if [[ "$machine" == "Unknown" ]]; then
    log error "Unsupported machine. Supported hosts: ${available_hosts[*]} and OSes: ${available_oses[*]}"
    exit 1
  fi
  log info "Machine: $machine"

  setup_env
  install_chezmoi

  echo
  log debug 'Installing dotfiles...'
  chezmoi init --apply https://github.com/pinanek/dotfiles --promptString machine=$machine
  log sucess "dotfiles for $machine is installed."
}

main
