if command -v zmx >/dev/null 2>&1; then
  eval "$(zmx completions zsh)"
fi

if command -v ut >/dev/null 2>&1; then
  eval "$(ut completions zsh)"
fi
