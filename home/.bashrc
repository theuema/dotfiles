# ----------------------------------- Automatic
# Fzf autocompletion and keybindings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
    # Normally added using the fzf install script `$(brew --prefix)/opt/fzf/install`

# pipx
export PATH="$PATH:$HOME/.local/bin"
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
