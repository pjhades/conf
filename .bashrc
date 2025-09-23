#export PATH="/Users/pjhades/.cargo/bin:/Users/pjhades/bin:/usr/local/opt/llvm/bin:/usr/local/opt/make/libexec/gnubin:/usr/local/opt/bison/bin:$PATH"
export PATH="/Users/pjhades/.cargo/bin:/Users/pjhades/bin:/usr/local/Cellar/llvm@18/18.1.8/bin:/usr/local/opt/make/libexec/gnubin:/usr/local/opt/bison/bin:$PATH"

. ~/.git-completion.bash
. ~/.git-prompt.sh

PS1='\[\e[1;33m\]\t\[\e[0m\]:\[\e[1;36m\]\h\[\e[0m\]:\[\e[1;32m\]\W\[\e[0m\]\[\e[1;35m\]$(__git_ps1 " (%s)")\[\e[0m\]\[\e[1;34m\] \$\[\e[0m\] '
PS2='\[\e[1;33m\]>\[\e[0m\] '

[ -z "$PS1" ] && return

alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias vi='vim'

set -o vi

export HISTCONTROL=ignoredups
export TERM=xterm-256color

export LC_ALL=en_US.UTF-8

# color settings for less, man
export LESS_TERMCAP_mb=$'\E[01;38;5;12m'
export LESS_TERMCAP_md=$'\E[01;38;5;80m' # section titles
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;48;5;52m' # command line
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;38;5;68m' # option argument

source "$HOME/.cargo/env"

if ! ssh-add -T ~/.ssh/id_rsa.pub &>/dev/null; then
    ssh-add -K ~/.ssh/id_rsa
fi

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
