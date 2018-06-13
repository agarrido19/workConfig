#The .bashrc file is a script that is executed whenever a new terminal session is started in interactive mode (i.e. terminal windows started by window manager) 
#By contrast a terminal session in login mode will ask you for user name and password and execute the ~/.bash_profile script. (i.e. when you log on to a remote system through SSH, or run a script)

### Environment Variables  ###
export EDITOR=~/opt/vim81/bin/vim
export DISPLAY=localhost:13
### PS1 ###
export PS1="\[\033[38;5;8m\]\u@\h:\[\]\[\033[38;5;33m\][\[\]\[\033[38;5;33m\]\W]\$\[\]\[\033[38;5;15m\] \[\033[00m\]"
#export PS1="\[\e[1;30m\][$$:$PPID - \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY:-o} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n\$ "
#git aware prompt
#export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[33m\w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\033[0m\]\$  \[\033[00m\]"
#export PS2="\[\033[38;5;8m\]\u@\h:\[\]\[\033[38;5;33m\][\[\]\[\033[38;5;33m\]\W]\\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

### ADE ###
export ADE_MERGE_TOOL=~/opt/vim8/bin/vimdiff

### Oracle Home ###
#export ORACLE_HOME=/scratch/agarrido/ecra_installs/mainDB/db_home/orcl30091420/oracle/product/11.2.0/dbhome_1
#export LD_LIBRARY_PATH=$ORACLE_HOME/lib
#export ORACLE_SID=orcl30091420
#export OH=$ORACLE_HOME

# If PS1 is set (interactive), set CDPATH 
if test “${PS1+set}”; then CDPATH=.:~:/scratch/agarrido:./mw_home/user_projects/domains/; fi
# Change bash prompt only if it is set to default (i.e. when entering a view) TODO ade_dirty
[ "$PS1" = "\\s-\\v\\\$ " ] && PS1="\[\033[38;5;8m\]\u@\h:\[\]\[\033[38;5;33m\][\[\]\[\033[38;5;33m\]\W]\\[\033[0;36m\]\$VIEW_NAME\[\033[1;31m\]\$ADE_DIRTY\[\033[38;5;15m\]\$\[\033[00m\] "

### PATH ###
# Taken from /etc/profile
PATH=/bin:/usr/bin:/sbin:/usr/sbin:/usr/dev_infra/platform/bin:/usr/dev_infra/generic/bin:/usr/local/bin

pathmunge () {
    case ":${PATH}:" in
        *:"$1":*)
            ;;
        *)
            [ ! -d "$1" ] && return
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}

# Path manipulation
if [ `id -u` != 0 ]; then
        pathmunge ~/scripts/bin before   
        pathmunge ~/opt/xclip/bin before   
        pathmunge ~/opt/python2/bin before   
        pathmunge ~/opt/python3/bin before   
        pathmunge ~/opt/htop2/bin before   
        pathmunge ~/opt/rlwrap/bin before   
        pathmunge ~/opt/tmux2/bin before   
        pathmunge ~/opt/vim81/bin before
fi
unset pathmunge
export PATH

# If exist, source bashrc
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
# In this host use system vim
if [ `hostname` = "slc12hsc" ]; then
    export EDITOR=/usr/bin/vim
    export ADE_MERGE_TOOL=/usr/bin/vimdiff
    export PATH=${PATH/#"/home/agarrido/opt/vim81/bin:"/}   
    unset LD_LIBRARY_PATH
fi

# If tmux is running attach to the session otherwise search for a saved session
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
   tmux has-session -t DEV 2> /dev/null && tmux attach-session
   # If no sessions running search for tmux-resurrect last saved (temporal session required)
   if [ $? != 0 ] && [ -L  ~/.tmux/resurrect/last ] && [ -e ~/.tmux/resurrect/last ]; then
      sessionDate=`readlink ~/.tmux/resurrect/last | cut -c16-33`
      read -p "Tmux session of ${sessionDate} found, do you want to restore it? (y/n): " answ
      echo   
      if [[ $answ =~ ^[Yy]$ ]]; then
         tmux new-session -d -s TEMP
         tmux run-shell "~/.tmux/plugins/tmux-resurrect/scripts/restore.sh > /dev/null"
         tmux kill-session -t TEMP
         tmux attach-session 
      # If no sessions saved ask to create a new one
      else 
         read -p "Create a new session? (y/n): " answ
         echo   
         if [[ $answ =~ ^[Yy]$ ]]; then
            read -p "Session Name: "  sess
            tmux new-session -s $sess #tmux display-message "DEV session created"
         fi
      fi
   fi
fi
     
