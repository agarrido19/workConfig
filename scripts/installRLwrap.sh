#!/bin/bash

#===============================================================================
# Script for installing rlwrap locally on REHL where you don't have root access.
# rlwrap will be installed under $HOME/opt/rlwrap
#===============================================================================

# exit on error
set -e

# create tmp directories
mkdir -p  $HOME/rlwrap_tmp
cd $HOME/rlwrap_tmp

# download source files (make sure proxy is set)
git clone https://github.com/hanslub42/rlwrap
cd rlwrap
autoreconf --install
./configure --prefix=$HOME/opt/rlwrap/
make
make check
make install
# add man pages
#make install.man

# cleanup
#make distclean
cd ../..
rm -rf $HOME/rlwrap_tmp
set +e

# check up
echo -ne "rlwrap version: " ; $HOME/opt/rlwrap/bin/rlwrap -version
echo "rlwrap is now available. You can optionally add $HOME/opt/rlwrap/bin to your PATH."
