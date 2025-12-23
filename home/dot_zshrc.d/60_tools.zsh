# mise
eval "$(mise activate zsh)"

# bat
export BAT_CONFIG_PATH=$XDG_CONFIG_HOME/bat/bat.conf
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# lazygit
export LG_CONFIG_FILE="$XDG_CONFIG_HOME/lazygit/config.yml,$XDG_CONFIG_HOME/lazygit/theme.yml"

# fzf
zstyle ":fzf-tab:*" use-fzf-default-opts yes
source $HOME/.zshrc.d/themes/fzf.zsh
FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= eval "$(fzf --zsh)"

# ut
eval "$(ut completions zsh)"
