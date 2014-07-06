#
# ~/.bashrc
#

[[ -f ~/.bashrc.local-before ]] && . ~/.bashrc.local-before



# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \w]\n\$ '



# aliases and functions

alias ls='ls --color=auto'
alias l=ls
alias la='ls -A'
alias ll='ls -Al'

alias ia='ip addr'

# watch with specified frequency
alias wn='watch -n'
# watch with half-second frequency
alias w.5='watch -n .5'
# watch ip address
alias wia='watch -n .5 ip addr'

# git aliases
alias g='git'
alias gl='git log --decorate --abbrev-commit --relative-date'
alias gst='git status -sb'
. /usr/share/bash-completion/completions/git
__git_complete g __git_main

# make alias for previous command
function aebb {
	if [[ -z $1 ]]; then
		alias r="$(history -p !!)"
	else
		alias $1="$(history -p !!)"
	fi
}



# environment variables

export EDITOR=$(which vim)



[[ -f ~/.bashrc.local-after ]] && . ~/.bashrc.local-after
