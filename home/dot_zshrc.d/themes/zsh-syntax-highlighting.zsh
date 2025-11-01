# Catppuccin Mocha Theme (for zsh-syntax-highlighting)
#
# Paste this files contents inside your ~/.zshrc before you activate zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES

# Main highlighter styling: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
#
## General
### Diffs
### Markup
## Classes
## Comments
ZSH_HIGHLIGHT_STYLES[comment]='fg=#434344'
## Constants
## Entitites
## Functions/methods
ZSH_HIGHLIGHT_STYLES[alias]='fg=#7fc7a4'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#7fc7a4'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#7fc7a4'
ZSH_HIGHLIGHT_STYLES[function]='fg=#7fc7a4'
ZSH_HIGHLIGHT_STYLES[command]='fg=#7fc7a4'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#7fc7a4,italic'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#fbc19d,italic'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#fbc19d'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#fbc19d'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#b5ccff'
## Keywords
## Built ins
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7fc7a4'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#7fc7a4'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#7fc7a4'
## Punctuation
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#f88d8e'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#c3c3c4'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#c3c3c4'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#c3c3c4'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#f88d8e'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#f88d8e'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#f88d8e'
## Serializable / Configuration Languages
## Storage
## Strings
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#e9cc9c'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#e9cc9c'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#e9cc9c'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#f1a290'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#e9cc9c'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#f1a290'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#e9cc9c'
## Variables
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#c3c3c4'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#f1a290'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#c3c3c4'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#c3c3c4'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#c3c3c4'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#c3c3c4'
## No category relevant in spec
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f1a290'
ZSH_HIGHLIGHT_STYLES[path]='fg=#c3c3c4,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#f88d8e,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#c3c3c4,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#f88d8e,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#c3c3c4'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#b5ccff'
#ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=?'
#ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=?'
#ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=?'
#ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=?'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#f1a290'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#c3c3c4'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#c3c3c4'
ZSH_HIGHLIGHT_STYLES[default]='fg=#c3c3c4'
ZSH_HIGHLIGHT_STYLES[cursor]='fg=#c3c3c4'
