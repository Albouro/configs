#!/bin/bash

set -e

this_file=$BASH_SOURCE
this_dir=`dirname $this_file`
real_dir=`realpath $this_dir`
link_dir=`readlink -f $real_dir`
while [ $link_dir != $real_dir ]
do
    echo 'Looking at link'
    real_dir=$link_dir
    link_dir=`readlink -f $real_dir`
done
echo $real_dir

# Vim
echo '***** VIM *****'
vimconfig="$real_dir/vim_repo"
echo "set runtimepath+=$vimconfig

source $vimconfig/vimrcs/basic.vim
source $vimconfig/vimrcs/filetypes.vim
source $vimconfig/vimrcs/plugins_config.vim
source $vimconfig/vimrcs/extended.vim
" > $real_dir/.vimrc.added
ln -s -f $real_dir/.vimrc.added ~/.vimrc.added
echo 'Created .vimrc.added in your home.
Use :source ~/.vimrc.added to test it.
Add "source .vimrc.added" in your .vimrc to use it.'

# Bash
echo '***** BASH *****'
ln -s -f $real_dir/.bashrc.added ~/.bashrc.added
echo 'Created .bashrc.added in your home.
Use source ~/.bashrc.added to test it.
Add "source ~/.bashrc.added" in your .bashrc to use it.'

# Tmux
echo '***** TMUX *****'
ln -s -f $real_dir/tmux_repo/.tmux.conf ~/.tmux.conf.added
ln -s -f $real_dir/tmux_repo/.tmux.conf.local ~/.tmux.conf.local
echo 'Created .tmux.conf.added in your home.
Use :source ~/.tmux.conf.added to test it.
Add "source-file ~/.tmux.conf.added" in your .tmux.conf to use it.'

# Git
echo '***** GIT *****'
ln -s -f $real_dir/.gitconfig ~/my_gitconfig
echo 'Created my_gitconfig in your home. Add
[include]
    path = ~/my_gitconfig
in your ~/.gitconfig to use it.'
