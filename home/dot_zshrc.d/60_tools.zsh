# mise
eval "$(mise activate zsh)"

# fzf
zstyle ":fzf-tab:*" use-fzf-default-opts yes

export FZF_DEFAULT_OPTS="\
  --color=bg+:#212122,bg:#19191A,spinner:#FFCDC7,hl:#F88D8E \
  --color=fg:#C3C3C4,header:#F88D8E,info:#B5CCFF,pointer:#FFCDC7 \
  --color=marker:#C1D0F2,fg+:#C3C3C4,prompt:#B5CCFF,hl+:#F88D8E \
  --color=selected-bg:#323233 \
  --color=border:#212122,label:#C3C3C4"

FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= eval "$(fzf --zsh)"

# bat
export BAT_CONFIG_PATH=$XDG_CONFIG_HOME/bat/bat.conf
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
