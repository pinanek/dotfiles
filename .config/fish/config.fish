# Environment variables
set -gx SHELL (which fish)
set -gx EDITOR (which hx)

set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_STATE_HOME $HOME/.local/state
set -gx XDG_BIN_HOME $HOME/.local/bin

# PATH
fish_add_path -ga $XDG_BIN_HOME

# Mise
mise activate fish | source

if status is-interactive
    # Disable greeting message
    set fish_greeting

    # Color stuff
    fish_config theme choose catppina
    set -gx LS_COLORS (vivid generate $XDG_CONFIG_HOME/vivid/catppina.yaml)

    # Prompt
    set -gx hydro_color_pwd 9ccfe9
    set -gx hydro_color_who e9cc9c
    set -gx hydro_color_error f88d8e
    set -gx hydro_color_prompt e99cba
    set -gx hydro_color_git 7fc7a4
    set -gx hydro_color_duration f1a290
    set -gx hydro_always_show_user true
    set -gx hydro_pwd_dir_length 999

    # Tools
    ## Bat
    if command -q -v batcat &>/dev/null
        function bat
            batcat $argv
        end
    end

    set -gx BAT_CONFIG_PATH $XDG_CONFIG_HOME/bat/bat.conf
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

    ## Fzf
    set -gx FZF_DEFAULT_OPTS "\
        --color=bg+:#212122,bg:#19191A,spinner:#FFCDC7,hl:#F88D8E \
        --color=fg:#C3C3C4,header:#F88D8E,info:#B5CCFF,pointer:#FFCDC7 \
        --color=marker:#C1D0F2,fg+:#C3C3C4,prompt:#B5CCFF,hl+:#F88D8E \
        --color=selected-bg:#323233 \
        --color=border:#212122,label:#C3C3C4"
    fzf --fish | FZF_ALT_C_COMMAND= FZF_CTRL_T_COMMAND= source

    # Abbrs
    abbr -a cat bat
    abbr -a ls eza --hyperlink
end
