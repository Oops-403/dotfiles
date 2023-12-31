#!/bin/bash

#  system vimrc file: "$VIM/vimrc"
#     user vimrc file: "$HOME/.vimrc"
# 2nd user vimrc file: "~/.vim/vimrc"
#      user exrc file: "$HOME/.exrc"
#       defaults file: "$VIMRUNTIME/defaults.vim"
#  fall-back for $VIM: "/usr/local/share/vim"
set +e

dir=$(cd `dirname $0`; pwd)

# printf "%s\n" $dir

target_vimrc_path=$HOME/.vimrc

source_vimrc_path=$dir/vimrc

if [ -e $source_vimrc_path ];then
  # printf "source config file checked %s\n" $source_vimrc_path
  printf "config start ...\n"
else
  printf "%s\n" "source config file not found"
  exit 1
fi

cat $source_vimrc_path > $target_vimrc_path

if [ -e $HOME/.vim/plugged ];then
  cp -r $HOME/.vim/plugged  ./dotvim
fi

rm -rf $HOME/.vim

cp -r $dir/dotvim $HOME/.vim

chmod gu+rwx $HOME/.vimrc
chmod -R gu+rwx $HOME/.vim

git config --global --add safe.directory /Users/shp/.vim/plugged/vim-lsp 

printf "config completed.\n"
