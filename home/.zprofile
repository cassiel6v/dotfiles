# --- - --- - ---
#  ZSH_PROFILE
# --- - --- - ---
# --- macos ---


# --- [variables] ---

# .environment

eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR=nvim
export VISUAL=nvim
export PATH=$PATH:$HOME/.local/bin
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export SUDO_PROMPT=$(echo -e "\033[31mPassword: \033[0m")

HISTSIZE=1000
SAVEHIST=1000

# --- [aliases] ---

# .system_management

alias s='sudo'
alias v='nvim'
alias b='bat'
alias c='cat'
alias t='touch'
alias ls='ls -a --color=always'
alias lx='eza -lah --color=always --icons --group-directories-first'
alias rem='rm -rfI'
alias grep='grep --color=auto'

# .configurations

alias shrc='nvim $HOME/.zprofile'
alias kitrc='nvim $HOME/.config/kitty/kitty.conf'
alias vimrc='nvim $HOME/.config/nvim/init.lua'
alias relsh='source $HOME/.zprofile'

# .utilities

alias py='python3'
alias sha='shasum -a 256'

# .git

alias status='git status'
alias stage='git add *'
alias purge='git rm $(git ls-files --deleted)'
alias pull='git pull'
alias push='git push -u'
alias commit='git commit -m'
alias checkout='git checkout'
alias clone='git clone'
alias clog='git log --graph --decorate --oneline'

# .directories

alias apps='cd /Applications'
alias docs='cd $HOME/Documents'
alias down='cd $HOME/Downloads'
alias pics='cd $HOME/Pictures'
alias publ='cd $HOME/Public'
alias conf='cd $HOME/.config'
alias stuf='cd $HOME/Stuff'
alias repo='cd $HOME/Repos'
alias dots='cd $HOME/Repos/dotfiles'

# .updirs

alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# --- [features] ---

# .autocomplete

autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# .auto_cd

zstyle :compinstall filename "$HOME/.zshrc"
setopt autocd extendedglob nomatch
autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)# Include Dotfiles

# .vi_mode

bindkey -v
export KEYTIMEOUT=1

autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char

bindkey "^?" backward-delete-char

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

# .universal_extractor

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

# --- [plugins] ---

source /opt/homebrew/opt/spaceship/spaceship.zsh
source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# .prompt

autoload -U promptinit; promptinit

export SPACESHIP_CONFIG_FILE="$HOME/.config/spaceship/spaceship.zsh"


# --- [end] ---
# vim: ft=bash
