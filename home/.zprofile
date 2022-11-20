#   ███████╗███████╗██╗  ██╗
#   ╚══███╔╝██╔════╝██║  ██║
#     ███╔╝ ███████╗███████║
#    ███╔╝  ╚════██║██╔══██║
#   ███████╗███████║██║  ██║
#   ╚══════╝╚══════╝╚═╝  ╚═╝
#   macOS Configuration

#------------------
#   ZSH PLUGINS
#------------------

eval "$(/opt/homebrew/bin/brew shellenv)"
source /opt/homebrew/opt/spaceship/spaceship.zsh
source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

#------------------
#  ALIASES
#------------------

# •• System Management

alias s='sudo'
alias v='nvim'
alias b='bat'
alias c='cat'
alias t='touch'
alias ls='exa -a --color=always --icons --group-directories-first'
alias lx='exa -lah --color=always --icons --group-directories-first'
alias rem='rm -rfI'
alias grep='grep --color=auto'
# alias egrep='egrep --color=auto'
# alias fgrep='fgrep --color=auto'
# alias copy='rsync -avhe ssh --append-verify --partial --progress'

# •• Configurations

alias shrc='nvim $HOME/.zprofile'
alias kitrc='nvim $HOME/.config/kitty/kitty.conf'
alias vimrc='nvim $HOME/.config/nvim/'
alias relsh='source $HOME/.zprofile'
alias wmrc='nvim $HOME/.config/yabai/yabairc'
alias hkrc='nvim $HOME/.config/skhd/skhdrc'

# •• Apps

# •• Code

alias py='python3'

# •• Git

alias status='git status'
alias stage='git add *'
alias purge='git rm $(git ls-files --deleted)'
alias pull='git pull'
alias push='git push -u'
alias commit='git commit -m'
alias checkout='git checkout'
alias clone='git clone'
alias tokenize='cat $HOME/Documents/token | pbcopy'

# •• Directories

alias apps='cd /Applications'
alias docs='cd $HOME/Documents'
alias down='cd $HOME/Downloads'
alias pics='cd $HOME/Pictures'
alias publ='cd $HOME/Public'
alias conf='cd $HOME/.config'
alias stuf='cd $HOME/Stuff'
alias repo='cd $HOME/Repos'

#------------------
#   VARIABLES
#------------------

export EDITOR=nvim
export VISUAL=nvim
export PATH=$PATH:$HOME/.local/bin
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export SUDO_PROMPT=$(echo -e "\033[31mProvide your password: \033[0m")
HISTSIZE=1000
SAVEHIST=1000

#------------------
#   FEATURES
#------------------

# •• Autocomplete With Case Insenstivity

autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# •• Auto CD

zstyle :compinstall filename "$HOME/.zshrc"
setopt autocd extendedglob nomatch
autoload -Uz compinit
zmodload zsh/complist
compinit
_comp_options+=(globdots)# Include Dotfiles

# Updirs
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# •• VI Mode

bindkey -v
export KEYTIMEOUT=1

# Edit Command Line in Vim Buffer
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# Use Vim Keys in Tab Complete Menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'left' vi-backward-char
bindkey -M menuselect 'down' vi-down-line-or-history
bindkey -M menuselect 'up' vi-up-line-or-history
bindkey -M menuselect 'right' vi-forward-char

# Fix Backspace Bug When Switching Modes
bindkey "^?" backward-delete-char

# Change Cursor Shape For Different VI Modes
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

#------------------
#   PROMPT
#------------------

autoload -U promptinit; promptinit

export SPACESHIP_CONFIG_FILE="$HOME/.config/spaceship/spaceship.zsh"

# vim: ft=bash
