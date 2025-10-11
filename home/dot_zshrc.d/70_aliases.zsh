alias ls="eza --hyperlink"
alias autossh="autossh -M 0"

if command -v bat >/dev/null 2>&1; then
  alias cat="bat"
elif command -v batcat >/dev/null 2>&1; then
  alias cat="batcat"
fi

abbr import-aliases --force --quieter
