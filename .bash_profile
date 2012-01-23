echo

echo "(1/9) Initializing terminal..."

PATH=/usr/local/sbin:$PATH
PATH=/opt/local/bin:/opt/local/sbin:$PATH
PATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.6/bin:$PATH

export MANPATH=/opt/local/share/man:$MANPATH

export SVN_EDITOR="/usr/local/bin/mate -w"

export ANT_HOME=/usr/share/java/ant-1.8.2
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home
export CLASSPATH=/opt/local/share/java:/opt/local/share/java/apache-ant

export LC_CTYPE=en_US.UTF-8

echo "(2/9) Activating bash completion..."

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

echo "(3/9) Setting up Android..."

export ANDROID_HOME=/usr/local/Cellar/android-sdk/r16
PATH=$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH

echo "(4/9) Setting terminal behaviours ..."

source ~/.bash_colors

# User/Host
PS1="${WHITE}[${RESET} ${YELLOW}\u@\h${RESET} "

# Folder
PS1="$PS1${BRIGHT_CYAN}\w${RESET} ${WHITE}]${RESET}"

# Git
PS1="$PS1"'$(__git_ps1 "\n\[\033[1;37m\][ \[\033[0;35m\]Git branch: \[\033[1;35m\]%s\[\033[0;37;00m\] \[\033[1;37m\]]\[\033[0;37;00m\]")'

# Clock
PS1="$PS1\n${WHITE}[${RESET} ${RED}\T${RESET} ${WHITE}]${RESET}"

echo "(5/9) Setting up Git..."

export GIT_EDITOR="/usr/local/bin/mate -w"
export GIT_PS1_SHOWDIRTYSTATE=true

# Prompt
PS1="$PS1${BRIGHT_WHITE} >${RESET} "

export TERM="xterm-color"

if [ "$TERM" != "dumb" ]; then
	LSCOLORS="exfxcxdxbxegedabagacad"
	export LSCOLORS
	alias ls="ls -G"
fi

# Bash completion for git
source ~/.git-flow-completion.sh

# GitHub integration for git
alias git=hub

echo "(6/9) Setting history properties ..."

HISTCONTROL=erasedups
HISTSIZE=10000

shopt -s histappend

echo "(7/9) Providing Bash functions..."

function spotlight { mdfind "kMDItemDisplayName == '$@'wc"; }
function listdsyms { mdfind "com_apple_xcode_dsym_uuids = *"; }
function dsym { /Developer/Platforms/iPhoneOS.platform/Developer/Library/PrivateFrameworks/DTDeviceKit.framework/Versions/A/Resources/symbolicatecrash -A -v $1 | more; }
function resume () { curl -C - -O "file://$*"; }

alias l='ls -1'
alias ll='ls -alh'

alias rsyncsec="rsync -e 'ssh -ax' -aSHAXhvz --delete --progress --stats"

echo "(8/9) Extending bash completion..."

export COMP_WORDBREAKS=${COMP_WORDBREAKS/\:/}

_rakecomplete() {
  COMPREPLY=($(compgen -W "`rake -s -T | awk '{{print $2}}'`" -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -o default -o nospace -F _rakecomplete rake

echo "(9/9) Finalizing initialization..."

export PATH

echo

