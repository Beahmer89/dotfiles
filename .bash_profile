PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/jamf/bin:/usr/local/jamf/bin:/usr/local/jamf/bin


export EDITOR=vim
export CLICOLOR=1
##export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
export LSCOLORS=GxFxCxDxBxegedabagaced

## note \[\e[1;32m\] begins the tag for colour and  \[\e[m\] ends the tag
export PS1="\[\e[0;35m\]\u@\[\e[m\]\[\e[1;34m\]\h\[\e[m\] \[\e[1;32m\][ \[\e[m\] \[\e[1;37m\]\w\[\e[m\] \[\e[1;32m\] ]\[\e[m\]\[\e[1;36m\]\$(git_branch)\[\e[m\] \[\e[1;33m\]\$\[\e[m\] "

##create alias for putting mac to sleep
alias slp="pmset sleepnow"

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

##fzf config
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

##initialize virtual env
function init(){
    $(./bootstrap shellinit)
}

##initialize virtual env
function ptpython(){
    ptpython="$(which ptpython)"
    eval "${ptpython}" --vi
}

function takedown(){
    eval docker-compose -p $1 down --remove-orphans --volumes
}

function cleanup() {
    eval docker system prune --volumes
}

##sub out things in files
function sub(){
    #can be done in shell command
}

##Run flake8 for formatting on python files
fck() {
    /Users/davidb/scripts/formatting.py
}

# Find servers
svrsearch() {
    for domainname in some.end.of.domain another.domain.ending; do
        dig -t AXFR $domainname | grep -v ";"
    done
}

# find mapping for aweber ids
lookup() {
    if [ $# -lt 3 ]
    then
        echo "Usage: lookup (list|account|subscriber|broadcast) (id_to_look_up) (test|stage|prod)"
        return
    fi

    actions=( 'list' 'account' 'subscriber', 'broadcast')
    locations=( 'test' 'stage' 'prod')
    re='^[0-9]+$'

    for action in "${actions[@]}"
    do
        if [ $1 == $action ]
        then
            if [[ $2 =~ $re ]]
            then
                for location in "${locations[@]}"
                do
                    if [ $3 == $location ]
                    then
                        echo /usr/local/bin/http "https://some.servce.$3.com/$1/$2"
                        eval /usr/local/bin/http "https://some.service$3.com/$1/$2"
                    fi
                done
            else
                echo "$2 is not an int"
                return
            fi
        fi
    done

}

lgrep() {
    if [ -n "$1" ]
    then
        eval grep -r --color --exclude-dir={env,.git,.tox} --exclude={*.pyc,*.cfg} $1 .
    else
        echo "Please provide an argument: lgrep arg1 | 'arg1 arg1'"
    fi
}

sshs() {
    servers=($(svrsearch | awk '{print substr($1, 1, length($1)-1)}' | fzf --reverse -m))
    # Adding the ability to specify a user if need be
    # otherwise we'll use the current user
    if [[ "$1" ]]; then
        usr="$1@"
    else
        usr=""
    fi
    if [[ ${#servers[@]} -eq 1 ]]; then
        ssh $usr${servers[@]}
    elif [[ ${#servers[@]} > 1 ]]; then
        for i in "${servers[@]}";
        do
            tmux split-window -v ssh $usr$i
            tmux resizep -U $((100/${#servers[@]}))
        done
        #could also use csshX
    else
        echo "Nothing Chosen..."
    fi
}

# kill vim instances that are terminated/zombie processes
klv() {
    files=($(jobs | awk '{ print $4 }' | fzf --reverse -m))
    if [[ ${#files[@]} -eq 1 ]]; then
        pid=($(ps axo pid=,stat=,command= | awk '$2~/^T/' | awk -v file=${files[@]} '$4 ~ file {print $1}'))
        kill -9 $pid
    else
        for file in "${files[@]}";
        do
            pid=($(ps axo pid=,stat=,command= | awk '$2~/^T/' | awk -v file=$file '$4 ~ file {print $1}'))
            eval kill -9 $pid
        done
    fi

}

source ~/gitScript/git-completion.bash
source ~/.bash_aliases


# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
