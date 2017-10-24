if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
export PATH=$PATH:/sbin:~/opt/tmux2/bin:~/.local/bin
export LD_LIBRARY_PATH=~/.local/lib:$LD_LIBRARY_PATH

if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
     tmux attach-session || tmux new-session -s DEV
fi

#export PATH=~/bin:~/mypython/bin:$PATH
#export PATH=~/bin:~/py13/bin:$PATH
#export LD_LIBRARY_PATH=~/bin:~/py13/lib
#export ADE_MERGE_TOOL=/usr/bin/vimdiff
export DISPLAY=localhost:1


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

### Local Paths ###
export DOCS=/home/agarrido/Documents
#export EMAILS="/home/agarrido/Documents/emails"

# ecsMain #
# export ECSMAIN=/scratch/agarrido/ecra_installs/ecsMain
# export ECSMAINV=/scratch/agarrido/view_storage/agarrido_ecsMain/ecs

# ExaCM #
# export EXACM=/scratch/agarrido/ecra_installs/exacm/ecra_home
# export EXACMV=/scratch/agarrido/view_storage/agarrido_exacm/ecs

# Others #
export APPECRA=app/src/main/java/oracle/exadata/ecra
export ECRA_INSTALLS=/scratch/agarrido/ecra_installs/
export VIEWS=/scratch/agarrido/view_storage/
#export ECSRELEASE=/scratch/agarrido/ecra_installs/ecs17351
export EXACLOUD=mw_home/user_projects/domains/exacloud/
