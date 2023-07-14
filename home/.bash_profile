export PATH="/opt/homebrew/bin:$PATH"

# pipx
export PATH="$PATH:$HOME/.local/bin"
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# @EOF
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi