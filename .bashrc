clear
uptime
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
export PS1="\[\033[38;5;8m\]\u@\h:\[$(tput sgr0)\]\[\033[38;5;33m\][\[$(tput sgr0)\]\[\033[38;5;33m\]\w]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZ=2000
export HISTFILESIZE=2000
# ignore duplicates in history
export HISTCONTROL=ignoreboth:erasedups
# append to the history instead of overwriting (good for multiple connections)
shopt -s histappend

#Aliases
alias ls='ls $LS_OPTIONS'
alias ll='ls -la'

#ADE aliases 
alias adebeginfromtrans="ade begintrans -xbranchmerge -fromtrans "
alias aderefreshlatest="ade refreshview -latest"
alias aderefreshtip="ade refreshview -tip"
alias adedesctrans="ade describetrans "
alias merge1="ade beginmerge "
alias merge2="ade mergetrans "
alias merge3="ade endmerge "
alias useview="ade useview "
alias lsviews="ade lsviews"
alias pwv="ade pwv"
alias cde='cd $ADE_VIEW_ROOT/ecs'
alias adedfp='ade diff -user_diff $1 -preb'
alias adedf='ade diff -user_diff $1 -label'
#alias mreq='/usr/dev_infra/generic/mergereq/cli/mergereq -y -r DBCS_ARM_WW_GRP@ORACLE.COM -m DBCS_ARM_WW_GRP@ORACLE.COM'

#alias sqlplus_sys="sqlplus system/welcome1@den01gdd:1621/orcl30091420.us.oracle.com "

### Views/Txns shorcuts ###
#alias mergereq='/usr/dev_infra/generic/mergereq/cli/mergereq -y -m oscar.gueta@oracle.com -r dbcs_arm_ww_grp@oracle.com'
#alias orareview='/usr/dev_infra/generic/bin/orareview  -u -e vim -r '
#alias view_make_app="$ADE_VIEW_ROOT/ecs/ecra/make_app"

#Oracle proxys 
alias proxyup='export http_proxy="www-proxy.us.oracle.com:80" ; export https_proxy="www-proxy.us.oracle.com:80"  ; export ftp_proxy="www-proxy.us.oracle.com:80"'
alias proxydown='unset http_proxy ; unset https_proxy ; unset ftp_proxy'

#Exabox aliases
alias agentStart='bin/exacloud --agent start'
alias agentStartDa='bin/exacloud --agent start -da'
alias agentStop='bin/exacloud --agent stop'
alias agentStatus='bin/exacloud --agent status'

#Useful aliases
alias mkdir='mkdir -pv'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias path='echo -e ${PATH//:/\\n}'
alias du='du -kh'   
alias df='df -kTh'

#Edit files fast
alias vibashrc='vim ~/.bashrc'
alias srbashrc='. ~/.bashrc'
alias viprofile='vim ~/.bash_profile'
alias srprofile='. ~/.bash_profile'
alias virc='vim ~/.vimrc'

#Common typos
alias l='ls'
alias sl='ls'
alias xs='cd'
alias vf='cd'
alias cd..='cd ..'
alias kk='ll'

#Stop after sending count ECHO_REQUEST packets 
alias ping='ping -c 1'
alias ping4='ping -c 4'
#Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'
#Open ports
alias ports='netstat -tulanp'
#Other useful aliases
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
## distro specifc RHEL/CentOS ##
alias update='sudo yum -y update'

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
function os_ver(){  cat /etc/redhat-release ; }

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
