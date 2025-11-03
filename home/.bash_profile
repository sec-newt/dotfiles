# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH
OLLAMA_HOST=0.0.0.0:11444
export OLLAMA_HOST
. "$HOME/.cargo/env"
