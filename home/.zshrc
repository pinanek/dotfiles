if [[ -r "$HOME/.local/vendor/zsh-logging/logging.sh" ]]; then
  source "$HOME/.local/vendor/zsh-logging/logging.sh"
fi

for dir in \
  "$HOME/.zshrc.d/10_core" \
  "$HOME/.zshrc.d/20_completion" \
  "$HOME/.zshrc.d/30_plugins" \
  "$HOME/.zshrc.d/40_ui" \
  "$HOME/.zshrc.d/50_tools" \
  "$HOME/.zshrc.d/60_shell"; do
  if [[ -d "$dir" ]]; then
    for file in "$dir"/*.zsh(.N); do
      source "$file"
    done
  fi
done

if [[ -d "$HOME/.zshrc.d.local" ]]; then
  for file in "$HOME/.zshrc.d.local"/**/*.zsh(.N); do
    source "$file"
  done
fi

unset dir
unset file
