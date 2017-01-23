PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/jamf/bin:/usr/local/jamf/bin:/usr/local/jamf/bin


export EDITOR=vim
export P4DIFF=vimdiff
export CLICOLOR=1
##export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
export LSCOLORS=GxFxCxDxBxegedabagaced

## note \[\e[1;32m\] begins the tag for colour and  \[\e[m\] ends the tag
export PS1="\[\e[0;35m\]\u@\[\e[m\]\[\e[1;34m\]\h\[\e[m\] \[\e[1;32m\][ \[\e[m\] \[\e[1;37m\]\w\[\e[m\] \[\e[1;32m\] ]\[\e[m\]\[\e[1;36m\]\$(git_branch)\[\e[m\] \[\e[1;33m\]\$\[\e[m\] "

##create alias for tmux new session
alias t="tmux new -s 0"

##bring back zombie process
alias f="fg"

##list all dirs, files, and owner
alias ll="ls -al"

##going back x number of dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

#bring up todo list
alias todo="vim /Users/davidb/Documents/todo.txt"

##bring up list to remember stuff
alias cache="vim /Users/davidb/Documents/cache.txt"

##start up the virtual env
alias start="source env/bin/activate"

##stop virtual env
alias stop="deactivate"

git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

##initialize virtual env
function init(){
    $(./bootstrap shellinit)
}

##sub out things in files
function sub(){
    /Users/davidb/scripts/sub_stuff.pl
}

##Run flake8 for formatting on python files
fck() {
    /Users/davidb/scripts/formatting.py
}

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH

source ~/gitScript/git-completion.bash
source ~/.bash_aliases

