antidote_home=$XDG_DATA_HOME/antidote

if [ ! -d "$antidote_home" ]; then
  log warn "\`antidot\` is not installed! Installing..."

  mkdir -p "$(dirname $antidote_home)"
  git clone --depth=1 https://github.com/mattmc3/antidote.git $antidote_home
  log success "\`antidot\` is installed succesfully!"
fi

source "$antidote_home/antidote.zsh"
unset antidote_home

plugins_file=$XDG_CACHE_HOME/antidote/zsh_plugins.zsh

if [[ ! "$plugins_file" -nt "${${(%):-%N}:A}" ]]; then
  mkdir -p "${plugins_file:h}"

  antidote bundle <<-plugins >| "$plugins_file"
    mattmc3/ez-compinit

    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-completions kind:fpath path:src
    zsh-users/zsh-autosuggestions
    Aloxaf/fzf-tab
    olets/zsh-abbr

    romkatv/zsh-bench kind:path

    sindresorhus/pure kind:fpath
plugins
fi

source "$plugins_file"
unset plugins_file
