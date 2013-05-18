export PATH=~/bin:/usr/local/bin:${PATH}

source ~/.git-completion.bash

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

export PS1="\n\[\e[36m\]\u@\H: \w\[\e[m\] \[\e[35m\]\$(__git_ps1 '(%s) ')\[\e[m\]\\n$ "
alias ls="ls -G"
alias less='less -r'
export LSCOLORS=gxfxcxdxbxegedabagacad

alias l="ls"
alias ll="ls -l"
alias la="ls -al"

HISTFILESIZE=9999

alias gitcon="git log --shortstat --pretty=oneline --author=slottermoser"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
