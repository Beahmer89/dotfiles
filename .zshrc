# If you come from bash you might have to change your $PATH.
#PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/jamf/bin:/usr/local/jamf/bin:/usr/local/jamf/bin
export PATH=$HOME/.poetry/bin:/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/dbeahm/.oh-my-zsh"
#export ASDF_DIR=/usr/local/Cellar/asdf/0.9.0/libexec
export ASDF_DIR=/usr/local/opt/asdf/libexec

# Turn off warnigs about share dir not having correct permissions
ZSH_DISABLE_COMPFIX=true

# Turn off all beeps
unsetopt BEEP

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="pygmalion-virtualenv"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(virtualenv git aws)

export EDITOR=vim

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# alias to always print timestamp for history
#alias history="history -E"
##create alias for putting mac to sleep
alias slp="pmset sleepnow"

##create alias for tmux new session
alias t="tmux new -s 0"

##bring back zombie process
alias f="fg"

##list all dirs, files, and owner
alias ll="ls -alh"

##use macvim instead of vim
alias vim="mvim -v"

##going back x number of dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."

##start up the virtual env
alias start="source env/bin/activate"

##stop virtual env
alias stop="deactivate"

# Functions
function ptp(){
    ptpython --vi
}

function takedown(){
    docker-compose -p $1 down --remove-orphans --volumes
}

function cleanup() {
    docker system prune --volumes
}

#sub out things in files
function sub(){
    #can be done in shell command
    python $HOME/scripts/replace $1 $2
}

##Run flake8 for formatting on python files
function f8() {
    python $HOME/scripts/format
}

# Find servers
svrsearch() {
    for domainname in some.end.of.domain another.domain.ending ; do
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
                        /usr/local/bin/http "https://some.service$3.com/$1/$2"
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
        grep -r --color --exclude-dir={env,.git,.tox,.eggs,.local} --exclude={'*.pyc','*.cfg'} $1 .
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
ko() {
    files=($(jobs | awk '{ if (NF == 5) {print $5} else{ print $6 }}' | fzf --reverse -m))
    if [[ ${#files[@]} -eq 1 ]]; then
        pid=($(ps axo pid=,stat=,command= | awk '$2~/^T/' | awk -v file=${files[@]} '$6 ~ file {print $1}'))
        kill -9 $pid
    else
        for file in "${files[@]}";
        do
            pid=($(ps axo pid=,stat=,command= | awk '$2~/^T/' | awk -v file=$file '$6 ~ file {print $1}'))
            kill -9 $pid
        done
    fi

}

#. /usr/local/opt/asdf/asdf.sh
. /usr/local/opt/asdf/libexec/asdf.sh

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"


export PATH="$HOME/.poetry/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
