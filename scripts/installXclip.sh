#!/bin/bash

# Script for installing xclip on REHL where you don't have root access.
# xclip will be installed under $HOME/opt/xclip

# =====================================================================
# << Update >>
# Running the following is enough, no need to build yourself
# sudo yum install epel-release.noarch
# sudo yum install xclip
# =====================================================================
# simply run the following in your terminal
# curl -L https://git.io/XClipYum | sh
# WARNING: a directory name 'xclip' will be created in your current directory

# http://superuser.com/a/410740/135952
# THIS SCRIPT ASUMES THIS DEPENDENCIES INSTALLED
# yum install -y automake autoconf git libXmu libXmu-devel libtool

# exit on error
set -e

# create tmp directories
mkdir -p  $HOME/xclip_tmp
cd $HOME/xclip_tmp

# download source files (make sure proxy is set)
git clone https://github.com/astrand/xclip.git
cd xclip
autoreconf
./configure --prefix=$HOME/opt/xclip/
make
make install
# add man pages
make install.man

# cleanup
#make distclean
cd ../..
rm -rf $HOME/xclip_tmp
set +e

# check up
echo -ne "xclip version: " ; $HOME/opt/xclip/bin/xclip -version
echo "xclip is now available. You can optionally add $HOME/opt/xclip/bin to your PATH."
