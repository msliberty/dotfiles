#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bashrc.local-before ]] && . ~/.bashrc.local-before

function parse_git_branch {
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

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

function nixInstalled {
	[[ -v osx ]] && commandInPath nix-env
}



if homebrewInstalled && [[ -f $(brew --prefix)/etc/profile.d/bash_completion.sh ]]; then
	source $(brew --prefix)/etc/profile.d/bash_completion.sh
elif nixInstalled && [[ -f ~/.nix-profile/etc/profile.d/bash_completion.sh ]]; then
	export XDG_DATA_DIRS="$HOME/.nix-profile/share/:$XDG_DATA_DIRS"
	export BASH_COMPLETION_COMPAT_DIR=~/.nix-profile/etc/bash_completion.d
	source ~/.nix-profile/etc/profile.d/bash_completion.sh
fi



# aliases and functions

alias sudoku='sudo su'

if [[ -v osx ]]; then
	export CLICOLOR=
else # assume GNU/Linux or compatible
	alias ls='ls --color=auto'
fi

alias l=ls
alias la='ls -A'
alias ll='ls -Al'

alias ia='ip addr'
alias pingtest='ping 8.8.8.8'

# watch with specified frequency
alias wn='watch -n'
# watch with half-second frequency
alias w.5='watch -n .5'
# watch ip address
alias wia='watch -n .5 ip addr'

# git aliases
alias g='git'
alias gp='git pull'
alias gl='git log --decorate --abbrev-commit --relative-date --pretty=msl'
alias gst='git status -sb'
alias gg='git log -n1 --decorate --abbrev-commit --pretty=oneline; git status -sb'
#if [[ -f /usr/share/bash-completion/completions/git ]]; then
	#source /usr/share/bash-completion/completions/git
#elif [[ -f /usr/local/etc/bash_completion.d/git-completion.bash ]]; then
	#source /usr/local/etc/bash_completion.d/git-completion.bash
#fi
__git_complete g __git_main

alias gpni='git pull && npm install'

# make alias for previous command
function aebb {
	if [[ -z $1 ]]; then
		alias r="$(history -p !!)"
	else
		alias $1="$(history -p !!)"
	fi
}

# npm aliases

alias showlinks='(cd node_modules/; find . -type l -maxdepth 1; find @integrity -type l -maxdepth 1)'
alias ni='npm install'



# environment variables

export EDITOR=$(which vim)



[[ -f ~/.bashrc.local-after ]] && . ~/.bashrc.local-after

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/msl/.sdkman"
[[ -s "/Users/msl/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/msl/.sdkman/bin/sdkman-init.sh"
