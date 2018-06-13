#!/bin/bash

# Script for installing vim on REHL where you don't have root access.
# this will compile with +python 2 & 3 supourt
# vim will be installed under $HOME/opt/vim81

# ====================================================================
# << Update >>
# Running the following is not enough for +python3, add this rpm 
# wget https://forensics.cert.org/cert-forensics-tools-release-el7.rpm
# sudo rpm -Uvh cert-forensics-tools-release*rpm
# sudo yum --enablerepo=forensics install python3-devel
# sudo yum list installed --disablerepo=forensics | grep python3
# =======================================-============================

# Remove previous installations
#sudo yum remove --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common
 
# Install dev dependencies, remove the ones that won't be used  
#sudo yum install -y python-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev
#if [ "$?" != "0" ] ; then echo "Error trying to install vim dependencies" ; exit ; fi
# exit on error
set -e

# Optional: so vim can be uninstalled again via `dpkg -r vim`
#sudo apt-get install checkinstall

# Remove from local share
#sudo rm -rf /usr/local/share/vim /usr/bin/vim

# Get the sauce
mkdir -p ~/opt/vim81/src
cd ~/opt/vim81/src
#git clone https://github.com/vim/vim
cd vim
#git pull && git fetch

# In case Vim was already build
cd src
make distclean
make clean
#cd ..

# Configure with +python feature
./configure \
--with-features=huge \
--enable-multibyte \
--enable-pythoninterp=yes \
--enable-python3interp=yes \
--enable-cscope \
--enable-largefile \
--with-compiledby="agarrido" \
--prefix=$HOME/opt/vim81/ \
--enable-fail-if-missing

#--with-python-config-dir=/usr/lib4/python2.7/config \
#--with-python3-config-dir=/usr/lib64/python3.3/config-3.3m/ \

# Build with 4 cores
make -j4 && make install
