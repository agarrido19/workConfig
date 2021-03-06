eval "`dircolors`"
# If not running interactively, don't do anything
#[[ "$-" != *i* ]] && return
if [ -n "$PS1" ]; then
        # Configure this only if shell is interactive
	# jump more efficiently into the history
	bind '"\e[A":history-search-backward'
	bind '"\e[A":history-search-backward'
	# disable (XON/XOFF flow control) enable Ctrl-s and Ctrl-q
	bind -r '/C-s'
	stty -ixon
fi
# append to the history instead of overwriting (good for multiple connections)
shopt -s histappend
# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# PS1
# export PS1="\[\033[38;5;8m\]\u@\h:\[\]\[\033[38;5;33m\][\[\]\[\033[38;5;33m\]\W]\$\[\]\[\033[38;5;15m\] \[\033[00m\]"
# Get view name without _user if variable is set
[ -z "${ADE_VIEW_NAME+x}" ] || export VIEW_NAME="(${ADE_VIEW_NAME#*_})"; export ADE_MERGE_TOOL=~/scripts/bin/usermerge.sh
# Change bash prompt only if it is set to default (i.e. when entering a view) TODO ade_dirty
[ "$PS1" = "\\s-\\v\\\$ " ] && PS1="\[\033[38;5;8m\]\u@\h:\[\]\[\033[38;5;33m\][\[\]\[\033[38;5;33m\]\W]\\[\033[0;36m\]\$VIEW_NAME\[\033[1;31m\]\$ADE_DIRTY\[\033[38;5;15m\]\$\[\033[00m\] "
# LD_LIBRARY_PATH
[ -z "${LD_LIBRARY_PATH+x}" ] || export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/.local/lib

# In this host use system vim
#if [ `hostname` = "slc12hsc" ]; then
#    export EDITOR=/usr/bin/vim
#    export ADE_MERGE_TOOL=/usr/bin/vimdiff
#    export PATH=${PATH/#"/home/agarrido/opt/vim81/bin:"/}
#    unset  LD_LIBRARY_PATH
#fi




#if [ -f ~/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
#    source ~/.local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
#fi
#Functions
#-------------------------------------------------------------
# File & strings related functions:
#-------------------------------------------------------------

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' \
-exec ${2:-file} {} \;  ; }

# Find a command trough history:
function fh() { history | grep  $1  ; }

#  Find a pattern in a set of files and highlight them:
#+ (needs a recent version of egrep).
function fstr()
{
    OPTIND=1

    local mycase=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
           i) mycase="-i " ;;
           *) echo "$usage"; return ;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more

}


function swap()
{ # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}


#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------


function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }
function os_ver(){  cat /etc/oracle-release ; }

function killps()   # kill by process name
{
    local pid pname sig="-TERM"   # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} )
    do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
    for fs ; do

        if [ ! -d $fs ]
        then
          echo -e $fs" :No such file or directory" ; continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}


function my_ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}

#-------------------------------------------------------------
# Misc utilities:
#-------------------------------------------------------------

function repeat()       # Repeat n times command.
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}


function ask()          # See 'killps' for example of use.
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

function forecast()              # get forecast
{
   while true; do
    case $1 in
        -t | --today)
            curl -s wttr.in/zapopan?m | head -n 17; return 0 ;;
         \?)
            echo "Invalid option: -$1" >&2; return 1 ;;
    esac
   done 
   # change to your default location
   curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Zapopan}?m"
}

function top10()
{
    history | awk '{print $2}' | sort | uniq -c | sort -rn | head -10
}

function yumpy()
{
   python -c 'import yum, pprint; yb = yum.YumBase(); pprint.pprint(yb.conf.yumvar, width=1)'
}
