autoload -Uz promptinit && promptinit

zstyle ':prompt:pure:git:stash' show yes

prompt pure
PROMPT="%F{7}${ZMX_SESSION:+[$ZMX_SESSION] }%f$PROMPT"
