export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

export SHELL="${SHELL:-$(command -v zsh)}"
export EDITOR="${EDITOR:-$(command -v hx)}"

if command -v vivid >/dev/null 2>&1 && [[ -f "$XDG_CONFIG_HOME/vivid/catppina_dark.yaml" ]]; then
  export LS_COLORS="$(vivid generate "$XDG_CONFIG_HOME/vivid/catppina_dark.yaml")"
fi
