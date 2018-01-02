#!/bin/bash

# Script for installing tmux on systems where you don't have root access.
# dependencies will be installed in $HOME/.local/bin.
# It's assumed that wget and a C/C++ compiler are installed.
# tmux will be installed under $HOME/opt/tmux2

# exit on error
set -e

# find out lastest version
TMUX_VERSION=2.5

# create our directories
mkdir -p $HOME/.local $HOME/tmux_tmp
cd $HOME/tmux_tmp

# download source files for tmux, libevent, and ncurses
wget -O tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz  --no-check-certificate
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz  --no-check-certificate
wget http://invisible-island.net/datafiles/release/ncurses.tar.gz --no-check-certificate


# extract files, configure, and compile

############
# libevent #
############
tar xvzf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
./configure --prefix=$HOME/.local --disable-shared
make
make install
cd ..

############
# ncurses  #
############
tar xvzf ncurses.tar.gz
cd ncurses-5.9
./configure --prefix=$HOME/.local
make
make install
cd ..

############
# tmux     #
############
tar xvzf tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
./configure CFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-L$HOME/.local/lib -L$HOME/.local/include/ncurses -L$HOME/.local/include" CPPFLAGS="-I$HOME/.local/include -I$HOME/.local/include/ncurses" LDFLAGS="-static -L$HOME/.local/include -L$HOME/.local/include/ncurses -L$HOME/.local/lib"  --prefix=$HOME/opt/tmux2/
make
make install

# check up
pkill tmux
echo -ne "tmux version: " ; tmux -V

# add tmux to man (requires root) 
# sudo cp $HOME/opt/tmux2/share/man/man1/tmux.1 /usr/local/share/man/man1/

# cleanup
rm -rf $HOME/tmux_tmp

echo "$HOME/opt/tmux2/bin/tmux is now available. You can optionally add $HOME/opt/tmux2/bin to your PATH."
