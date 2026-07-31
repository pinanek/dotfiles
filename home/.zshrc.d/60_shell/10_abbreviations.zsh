if command -v abbr >/dev/null 2>&1; then
  abbr --quieter -f cat="bat" --quiet
  abbr --quieter -f ls="eza --hyperlink"
  abbr --quieter -f ash="autossh -M 0 -q"
fi
