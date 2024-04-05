# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----------------------------------- Oh-my-zsh default stuff
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# ----------------------------------- Oh-my-zsh-plugins & source
# Which plugins would you like to load?
    # Standard plugins can be found in $ZSH/plugins/
    # Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# THEUEMA: Have a look at vagrant-prompt, brew, macos, archlinux, dnf, yum, jsontools
plugins=(sudo ripgrep copyfile extract docker docker-compose pip pyenv vagrant colored-man-pages colorize vscode web-search)

# Configuring brew completions in Zsh
    # Must be before `source "$ZSH/oh-my-zsh.sh"`
    # https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
    # e.g., bat, ripgrep: "zsh completions have been installed to: /opt/homebrew/share/zsh/site-functions"
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Additional completion definitions for Zsh installed for oh-my-zsh
    # Must be before `source "$ZSH/oh-my-zsh.sh"`
    # https://github.com/zsh-users/zsh-completions#oh-my-zsh
    # See `brew info zsh-completions`
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# ----------------------------------- User configuration
## Store gitconfig in ~/.config/git/config
export XDG_CONFIG_HOME=$HOME/.config
## Python Env exports
### Pipx
export PIPX_HOME=$HOME/.venvs/pipx
export PATH="$PATH:$HOME/.local/bin"
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ---------------- Autoload utils

# Set autoload FPATH.
fpath=(~/.zshutils "${fpath[@]}")

# autoload custom utils (only load when Fzf is installed)
# if there is a problem with autoloaded functions, after edit, one needs to e.g.: "unfunction utils" before autoload
# freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }
# unfunction utils cheatmux cheatnvim ...
autoload -Uz compinit bashcompinit kp bi bu ci cu utils gitutils dockerutils cheatnvim cheatmux cheatfzf cheatbash workutils # create symlink to external workutils (e.g., onedrive) containing current-job-specific utils
compinit

# ----------------------------------- Bindkeys (utils) 
# -s option is used to translate the input string to output string.
# ^M or \n newline to run the output string, that is a command.
bindkey -s '^u' 'utils\n'

# ----------------------------------- Pipx completions
# bashcompinit for pipx completions, installed via packagemanager
bashcompinit
eval "$(register-python-argcomplete pipx)"

# Ditch duplicate PATH entries when loading .zshrc.
typeset -U PATH fpath

# ---------------- Fzf
# fzf does not use ripgrep by default, so we need to tell fzf to use ripgrep with FZF_DEFAULT_COMMAND variable.
# Pay attention to -m in FZF_DEFAULT_OPTS. This option allows us to make multiple selections (with Tab or Shift-Tab).
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND="rg --files"
  export FZF_DEFAULT_OPTS="
  --multi
  --border
  --height=60%
  --layout=reverse
  --info inline
  --prompt='∼ '
  --ansi
  --color='pointer:032,marker:010,bg+:237,gutter:008'
  --bind 'ctrl-a:select-all'
  --preview-window=:hidden
  --bind '?:toggle-preview'
  --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
  --bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
  "
fi

# ---------------- Source ohmyzsh
source $ZSH/oh-my-zsh.sh

# ----------------------------------- ALIASES
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

[ -f ~/.aliases.zsh ] && source ~/.aliases.zsh
[ -f ~/.mac.zsh ] && source ~/.mac.zsh
[ -f ~/.linux.zsh ] && source ~/.linux.zsh
[ -f ~/.work.zsh ] && source ~/.work.zsh # create a symlink to an external work.zsh containing current-job-specific functions, aliases ...

# ----------------------------------- macOS brew-zsh-plugins (should be sourced at the end of this file)
# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-you-should-use
source $(brew --prefix)/share/zsh-you-should-use/you-should-use.plugin.zsh

# ----------------------------------- Automatic
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Fzf autocompletion and keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    # Normally added using the install script `$(brew --prefix)/opt/fzf/install`
