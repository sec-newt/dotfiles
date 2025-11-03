# Setup fzf
# ---------
if [[ ! "$PATH" == */home/nk/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/nk/.fzf/bin"
fi

eval "$(fzf --bash)"
