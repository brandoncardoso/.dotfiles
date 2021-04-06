#!/bin/bash

# script must be run from dotfiles repo
source_dir=$PWD
backup_dir=~/.dotfiles_backup
excludes=('.gitignore' '.gitmodules' 'makesymlinks.sh')

echo -n "Creating $backup_dir for backup of any existing dotfiles in ~ ..."
mkdir -p $backup_dir
echo "done"

echo $excludes
for file in $(git ls-files); do
	if [[ " ${excludes[*]} " != *"$file"* ]]; then
		if [[ -f ~/$file ]]; then
			echo "Backing up ~/$file to $backup_dir..."
			mv ~/$file $backup_dir
		fi
		echo "Linking ~/$file to $source_dir/$file..."
		ln -s $source_dir/$file ~/$file
	fi
done
echo "Done"
