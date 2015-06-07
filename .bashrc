#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \w]\n\$ '



# (somewhat crude) os detection
# http://stackoverflow.com/a/17072017
kernel="$(uname -s)"
if [[ $kernel == "Darwin" ]]; then
	osx=
elif [[ ${kernel:0:5} == "Linux" ]]; then
	linux=
fi

function commandInPath {
	which $1 > /dev/null
}

function homebrewInstalled {
	[[ -v osx ]] && commandInPath brew
}



if homebrewInstalled && [[ -f $(brew --prefix)/etc/profile.d/bash_completion.sh ]]; then
	source $(brew --prefix)/etc/profile.d/bash_completion.sh
fi



# aliases and functions

if [[ -v osx ]]; then
	export CLICOLOR=
else # assume GNU/Linux or compatible
	alias ls='ls --color=auto'
fi

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
#if [[ -f /usr/share/bash-completion/completions/git ]]; then
	#source /usr/share/bash-completion/completions/git
#elif [[ -f /usr/local/etc/bash_completion.d/git-completion.bash ]]; then
	#source /usr/local/etc/bash_completion.d/git-completion.bash
#fi
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

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/msl/.gvm/bin/gvm-init.sh" ]] && source "/Users/msl/.gvm/bin/gvm-init.sh"
