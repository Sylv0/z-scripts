#!/bin/bash

printf "This script will install 'z' by 'rupa', from https://github.com/rupa/z\n"

echo "Please enter the location to install z in (leave empty for $HOME/z):"
read installDir

tput setaf 3;

if [[ -z $installDir ]]; then # if input is empty, change to default
  installDir=$HOME/z
fi
if [[ $installDir != /* ]]; then # if input does not start with /, add it
  installDir=/$installDir
fi
if [[ $installDir != */ ]]; then # if input does not end with /, add it
  installDir=$installDir/
fi
if [[ -d $installDir ]]; then # if folder already exists, exit script
  tput setaf 1; echo "This folder already exists."
  return
fi

tput setaf 3;
git clone https://github.com/rupa/z $installDir
if [ $? -ne 0 ] ; then # if no permission for directory
    tput setaf 1; echo "The installation failed, this is most likely caused by insufficient permissions."
    return
fi

if [[ -f $HOME/.bashrc ]]; then # if .bashrc exists
  if grep -Fxq '. '$installDir'z.sh' $HOME/.bashrc # if already in .bashrc
  then
    tput setaf 3; printf "\nPath already in $HOME/.bashrc, skipping\n"
  else
    echo '. '$installDir'z.sh' >>~/.bashrc
  fi
else
  tput setaf 1; echo ".bashrc not found in $HOME."
fi

tput setaf 2; printf "\nSuccessfully installed z!\nRestart your terminal to start using z."
tput setaf 3; printf "\nNote that you need to cd around a bit to build up the database for z to use.\n\n"