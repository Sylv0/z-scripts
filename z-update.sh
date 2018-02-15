#!/bin/bash

oldInstallDir=

printf "This script will update 'z' by 'rupa', from https://github.com/rupa/z\n"

if [[ -e $HOME/.bashrc && "$(grep '/z.sh$' $HOME/.bashrc)" ]]; then
  oldInstallDir="$(grep '/z.sh$' $HOME/.bashrc)"
fi
if [[ -e $HOME/.bash_profile && "$(grep '/z.sh$' $HOME/.bash_profile)" ]]; then
  oldInstallDir="$(grep '/z.sh$' $HOME/.bash_profile)"
fi


oldFile=${oldInstallDir#. }
oldInstallDir=${oldFile::-4}

tput setaf 3; printf "Found z installed in directory $oldInstallDir.\nDo you want to owerwrite this directory with the latest version from GitHub? ([y]es/[n]o)\n"
read confirm

if [[ ${confirm^^} == 'N' ]]; then
  return
fi

# clone to tmp
tmpDir=`mktemp -d`
git clone https://github.com/rupa/z $tmpDir

rm $oldFile
mv "${tmpDir}/z.sh" $oldFile

rm -rf $tmpDir

printf "\nSuccessfully updated z!\n"
