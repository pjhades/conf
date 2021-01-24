. ~/.git-completion.bash
. ~/.git-prompt.sh

PS1='\[\e[1;33m\]\h\[\e[0m\] \[\e[1;32m\]\W\[\e[0m\]\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0m\]\[\e[1;77m\] \$\[\e[0m\] '
PS2='\[\e[1;77m\]>\[\e[0m\] '

PROMPT_COMMAND=echo

[ -z "$PS1" ] && return

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias vi='vim'

set -o vi

export HISTCONTROL=ignoredups
export TERM=xterm-256color

# color settings for less, man
export LESS_TERMCAP_mb=$'\E[01;38;5;12m'
export LESS_TERMCAP_md=$'\E[01;38;5;80m' # section titles
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;48;5;52m' # command line
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;38;5;68m' # option argument

if [ ${SSH_AGENT_PID:-null} != null ]; then
    ssh-add -l &>/dev/null
    if [ $? -eq 1 ]; then
        ssh-add
    fi
fi
