#!/bin/sh
 
#Credit: https://linuxprograms.wordpress.com/2007/06/17/shell-script-to-recursively-list-files/
 
DIR="."
count=1
 
function list_files()
{
  if !(test -d "$1") 
   	then echo $1; return;
	fi
 
	cd "$1"
	echo; echo `pwd`:; #Display Directory name
 
 	for file in * 
 		do
 		if test -d "$file" #if dictionary
 		then 
 			list_files "$file" #recursively list files
			cd ..
 		else
 			echo `pwd`"/$file"; #Display File name
			
			if [ "$count" == "1" ]; then
				cat $file >> /tmp/merged.csv
			else
				tail -n+2 `pwd`"/$file" >> /tmp/merged.csv
			fi
			count=`expr $count + 1`
		fi
 	done
}
 
if [ $# -eq 0 ]
	then list_files .
	exit 0
fi
 
for i in $*
	do
 		DIR="$1"
 		list_files "$DIR"
 		shift 1 #To read next directory/file name
done
