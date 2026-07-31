source "$HOME/.zshrc.d/50_tools/fzf_catppina.sh"

zstyle ':fzf-tab:*' use-fzf-default-opts yes

if command -v fzf >/dev/null 2>&1; then
  FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= eval "$(fzf --zsh)"
fi
