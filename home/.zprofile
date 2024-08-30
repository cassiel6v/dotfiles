#   ███████╗███████╗██╗  ██╗
#   ╚══███╔╝██╔════╝██║  ██║
#     ███╔╝ ███████╗███████║
#    ███╔╝  ╚════██║██╔══██║
#   ███████╗███████║██║  ██║
#   ╚══════╝╚══════╝╚═╝  ╚═╝
#   macOS/personal configuration

#------------------
#  CONTENTS
#------------------

# VARIABLES :: 00-environment; 01-custom
# ALIASES :: 02-system management; 03-configurations; 04-utils; 05-git; 06-directories
# FEATURES :: 07-autocomplete; 08-auto cd; 09-updirs; 10-vi mode; 11-universal extractor
# PLUGINS
# PROMPT

#------------------
#  VARIABLES
#------------------

# 00 • environment

eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_GITHUB_API_TOKEN=$(cat $HOME/Documents/token)

export EDITOR=nvim
export VISUAL=nvim
export PATH=$PATH:$HOME/.local/bin
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export SUDO_PROMPT=$(echo -e "\033[31mPassword: \033[0m")

HISTSIZE=1000
SAVEHIST=1000

# 01 • custom

VAULTS=/Users/$USER/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/

#------------------
#  ALIASES
#------------------

# 02 • system management

alias s='sudo'
alias v='nvim'
alias b='bat'
alias c='cat'
alias t='touch'
alias ls='exa -a --color=always --icons --group-directories-first'
alias lx='exa -lah --color=always --icons --group-directories-first'
alias rem='rm -rfI'
alias grep='grep --color=auto'

# 03 • configurations

alias shrc='nvim $HOME/.zprofile'
alias kitrc='nvim $HOME/.config/kitty/kitty.conf'
alias vimrc='nvim $HOME/.config/nvim/init.lua'
alias relsh='source $HOME/.zprofile'

# 04 • utils

alias py='python3'
alias sha='shasum -a 256'

# 05 • git

alias status='git status'
alias stage='git add *'
alias purge='git rm $(git ls-files --deleted)'
alias pull='git pull'
alias push='git push -u'
alias commit='git commit -m'
alias checkout='git checkout'
alias clone='git clone'

# 06 • directories

alias apps='cd /Applications'
alias docs='cd $HOME/Documents'
alias down='cd $HOME/Downloads'
alias pics='cd $HOME/Pictures'
alias publ='cd $HOME/Public'
alias conf='cd $HOME/.config'
alias stuf='cd $HOME/Stuff'
alias repo='cd $HOME/Repos'
alias dots='cd $HOME/Repos/dotfiles'

#------------------
#  FEATURES
#------------------

# 07 • autocomplete
# --- with case insenstivity

autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# 08 • auto cd

zstyle :compinstall filename "$HOME/.zshrc"
setopt autocd extendedglob nomatch
autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)# Include Dotfiles

# 09 • updirs

alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# 10 • vi mode

bindkey -v
export KEYTIMEOUT=1

# --- edit command line in vim buffer
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# --- use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char

# --- fix backspace bug when switching modes
bindkey "^?" backward-delete-char

# --- change cursor shape for different vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' 
preexec() { echo -ne '\e[5 q' ;} 

# 11 • universal extractor

function extract {
  if [ -z "$1" ]; then
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f $1 ]; then
      case $1 in
        *.tar.bz2)   tar xvjf $1    ;;
        *.tar.gz)    tar xvzf $1    ;;
        *.tar.xz)    tar xvJf $1    ;;
        *.lzma)      unlzma $1      ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unar $1        ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xvf $1     ;;
        *.tbz2)      tar xvjf $1    ;;
        *.tgz)       tar xvzf $1    ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *.xz)        unxz $1        ;;
        *.exe)       cabextract $1  ;;
        *)           echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}

#------------------
#  PLUGINS
#------------------

source /opt/homebrew/opt/spaceship/spaceship.zsh
source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

#------------------
#  PROMPT
#------------------

autoload -U promptinit; promptinit

export SPACESHIP_CONFIG_FILE="$HOME/.config/spaceship/spaceship.zsh"


# vim: ft=bash
