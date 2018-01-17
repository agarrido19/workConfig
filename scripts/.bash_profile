if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

export EDITOR=~/opt/vim8/bin/vim
export DISPLAY=localhost:1
export PATH=$PATH:/sbin:~/opt/rlwrap/bin:~/opt/vim8/bin:~/opt/tmux2/bin:~/opt/xclip/bin:~/opt/python3/bin:~/.local/bin
export LD_LIBRARY_PATH=~/.local/lib:$LD_LIBRARY_PATH

# If tmux is running attach to the session otherwise create DEV session
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
     tmux attach-session || tmux new-session -s DEV
fi

### Oracle Home ###
#export ORACLE_HOME=/scratch/agarrido/ecra_installs/mainDB/db_home/orcl30091420/oracle/product/11.2.0/dbhome_1
#export LD_LIBRARY_PATH=$ORACLE_HOME/lib
#export ORACLE_SID=orcl30091420
#export OH=$ORACLE_HOME

### PATH ###
#export PATH=$ORACLE_HOME/bin:$PATH
#export PATH=$PATH:/sbin:/usr/sbin
#export PATH=/opt/exacmdpy/python/bin:$PATH
#export PATH=/home/agarrido/bin:$PATH
#export LD_LIBRARY_PATH=~/bin:~/py13/lib
#export ADE_MERGE_TOOL=/usr/bin/vimdiff

### Local Paths ###
export DOCS=/home/agarrido/Documents

# ecsMain #
export ECSMAIN=/scratch/agarrido/ecra_installs/ecsMain171113/

# Others #
export APPECRA=app/src/main/java/oracle/exadata/ecra/
export ECRA_INSTALLS=/scratch/agarrido/ecra_installs/
export VIEWS=/scratch/agarrido/view_storage/
export EXACLOUD=mw_home/user_projects/domains/exacloud/
