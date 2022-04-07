# source ~/builds/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# source ~/builds/zsh-autosuggestions/zsh-autosuggestions.zsh

# autoload -Uz compinit && compinit 
xset r rate 200 50

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh


alias ls='exa --icons'
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias lt='ls --tree'

alias la='ls -a'
alias l='ls -F'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias zathura="devour zathura"
alias zat="devour zathura"
alias vrc='nvim ~/.config/nvim/init.vim'

alias brc='vim ~/.bashrc'
alias lsde='lsblk | grep -v loop'

alias vic='vim ~/.config/i3/config'
alias dd='dd status=progess'

alias fd="sudo find -name "
alias fr="sudo find / -name"

alias kez='setxkbmap de; xset r rate 200 50'
alias ipy='ipython'


################################################################################
#                       pacman aliases                                         #
#                                                                              #
################################################################################
alias pi='sudo pacman -S'
alias pls='sudo pacman -Q'

alias psrc='sudo pacman -Ss'
alias upd='sudo pacman -Syy && sudo pacman -Syu;'

alias vz='nvim ~/.zshrc'
alias vim='nvim'


################################################################################
#                       custom functions                                       #
#                                                                              #
################################################################################
# function to change the background

chwal(){
    if [[ $1 != *.png ]]
    then
        convert $1 /tmp/wall.png
        mv /tmp/wall.png ~/.config/wall.png
    else
    cp $1 ~/.config/wall.png
    fi

    wal -i ~/.config/wall.png 
    feh --bg-scale ~/.config/wall.png
}

prm(){ 
    sudo pacman -Rs $1
    sudo paccache -r 
}

chdips(){
    if [[ $1 == top ]]
    then
        xrandr --output HDMI-2 --above eDP-1
    elif [[ $1 == bottom ]]
    then 
        xrandr --output HDMI-2 --below eDP-1
    elif [[ $1 == right ]]
    then
        xrandr --output HDMI-2 --right-of eDP-1
    elif [[ $1 == left ]]
    then 
        xrandr --output HDMI-2 --left-of eDP-1
    elif [[ $1 == mirror ]]
    then
        xrandr --output HDMI-2 --same-as eDP-1
    fi
}

gcbs (){
    local PROJ=$(gcloud config get-value project)
    local TARGET=gcr.io/$PROJ/$1
    echo "submitting..."
    (gcloud builds submit --tag gcr.io/$PROJ/$1)
    echo "deploying..."
    (gcloud run deploy $1-web --image gcr.io/$PROJ/$1)
}

################################################################################
#                       HISTORY                                                #
#                                                                              #
################################################################################

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt hist_ignore_all_dups
setopt INC_APPEND_HISTORY
setopt HIST_SAVE_NO_DUPS
bindkey '^R' history-incremental-search-backward

################################################################################
#                       EXPORTS                                                #
#                                                                              #
################################################################################
# function to change the background
export PATH="$(du $HOME/.scripts/ | cut -f2 | tr '\n' ':')$PATH"

export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"
export PATH="$PATH:/home/lugges/.local/bin"
export SAVEHIST=$HISTSIZE

################################################################################
#                       AUTOCOMPLETION                                         #
#                                                                              #
################################################################################
# function to change the background
xcape -e 'Super_L=Escape'
xmodmap -e "keycode 66 = ISO_Level3_Shift"
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' special-dirs true
zstyle :compinstall filename '/home/lugges/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
eval "$(starship init zsh)"
