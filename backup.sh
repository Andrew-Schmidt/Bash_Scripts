#!/bin/bash
source=~/Documents/Bash_Scripts/source
dest=~/Documents/Bash_Scripts/destination
for file in $(find $source -printf "%P\n"); do
	if [ -a $dest/$file ] ; then
		if [ $source/$file -nt $dest/$file ]; then
			echo "newer file detected, copying..."
			cp -r $source/$file $dest/$file
		else
			echo "file $file exists, skipping"
		fi
	else
		echo "$file is being copied to $dest"
		cp -r $source/$file $dest/$file
	fi
done