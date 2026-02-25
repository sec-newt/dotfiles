# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# # Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"
# starship
eval "$(starship init bash)"

# Aliases
alias vim='nvim'
alias ls='ls --color'

# Variables
export EDITOR='nvim'
export OLLAMA_API_KEY="ollama-local"
# Machine-local secrets (tokens, API keys) — sourced from untracked file
[ -f ~/.config/secrets/env.sh ] && source ~/.config/secrets/env.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "$HOME/.cargo/env"
# GI_TYPELIB_PATH removed - was Debian/Ubuntu specific (x86_64-linux-gnu path)

# Set GPU for Ollama
export HIP_VISIBLE_DEVICES=1

# Setting up zoxide to be used as cd command (must be at the end)
eval "$(zoxide init --cmd cd bash)"

# Git repository management functions for Scripts, Hypr, and Obsidian
if [ -f ~/.config/shell/git-repo-functions.sh ]; then
    source ~/.config/shell/git-repo-functions.sh
fi
export OLLAMA_HOST=http://localhost:11434
# Wiki management aliases
source ~/.wiki-aliases
export PATH="$HOME/Scripts/bin:$HOME/.local/bin:$PATH"

# TTS Configuration (Piper/OpenAI)
export TTS_BACKEND=local
export PIPER_MODEL=$HOME/.local/share/piper/voices/en_US/en_US-amy-medium.onnx
export PIPER_CONFIG=$HOME/.local/share/piper/voices/en_US/en_US-amy-medium.onnx.json
export TTS_MPV_ARGS="--audio-channels=stereo --speed=1.3"
export OLLAMA_HOST=127.0.0.1:11434
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
