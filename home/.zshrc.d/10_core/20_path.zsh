if [[ "$(uname)" == "Darwin" ]] && [[ -x "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$(uname)" == "Linux" ]] && [[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if [[ ":$PATH:" != *":$XDG_BIN_HOME:"* ]]; then
  export PATH="$XDG_BIN_HOME:$PATH"
fi
