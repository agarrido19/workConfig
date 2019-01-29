#Aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias lrt='ls -lrta'
alias grep='grep --color=auto'

# Source other aliases
if [ -f ~/.work_aliases ]; then
   source ~/.work_aliases
fi
#Readline wrapper utility that provides a command history and editing of keyboard input for SQL*Plus and RMAN
alias rlsqlplus='rlwrap sqlplus'
alias rlrman='rlwrap rman'

#Useful aliases
alias mkdir='mkdir -pv'
alias quota='quota -usQ'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias du='du -kh'   
alias df='df -kTh'
alias cd3='cd ../../..'
alias cd4='cd ../../../..'
alias ducks='du -cksh * | sort -hr | head -n 15'

#Edit files fast
alias vibashrc='vim ~/.bashrc'
alias srbashrc='. ~/.bashrc'
alias viprofile='vim ~/.bash_profile'
alias srprofile='. ~/.bash_profile'
alias vialias='vim ~/.bash_aliases'
alias viwalias='vim ~/.work_aliases'
alias vitmux='vim ~/.tmux.conf'
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

#Vnc spawn
alias vncstart='vncserver :13 -geometry 1920x1080'

#Open ports
alias ports='netstat -tulanp'

#Other useful aliases
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

# distro specifc RHEL/CentOS ##
alias update='sudo yum -y update'
