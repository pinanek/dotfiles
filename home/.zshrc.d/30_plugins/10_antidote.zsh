antidote_dir="${XDG_DATA_HOME:-$HOME/.local/share}/antidote"
antidote_sh="$antidote_dir/antidote.zsh"

plugins_txt="${ZDOTDIR:-$HOME}/.zshrc.d/30_plugins/plugins.txt"
plugins_zsh="${XDG_CACHE_HOME:-$HOME/.cache}/antidote/plugins.zsh"

syntax_highlighting="${ZDOTDIR:-$HOME}/.zshrc.d/40_ui/20_zsh_syntax_highlighting.zsh"

# Install Antidote from Git when it is not available.
if [[ ! -r "$antidote_sh" ]]; then
  mkdir -p "${antidote_dir:h}"

  command git clone \
    --depth=1 \
    https://github.com/mattmc3/antidote.git \
    "$antidote_dir"
fi

if [[ -r "$antidote_sh" ]]; then
  if [[ 
    ! -f "$plugins_zsh" ||
    "$plugins_zsh" -ot "$plugins_txt" ||
    "$plugins_zsh" -ot "$syntax_highlighting" ]] \
    ; then
    mkdir -p "${plugins_zsh:h}"

    (
      source "$syntax_highlighting"
      source "$antidote_sh"
      antidote bundle <"$plugins_txt" >|"$plugins_zsh"
    )
  fi

  source "$plugins_zsh"
fi

unset antidote_dir
unset antidote_sh
unset plugins_txt
unset plugins_zsh
unset syntax_highlighting
