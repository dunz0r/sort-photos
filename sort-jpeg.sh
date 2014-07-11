#!/bin/bash

# Goes through all jpeg files in source directory, grabs date from each
# and sorts them into subdirectories according to the date
# Creates subdirectories corresponding to the dates as necessary.

if [ -z $1 ]; then
	echo "You need to provide a source directory";
	exit 1
fi
if [ -z $2 ]; then
	echo "You need to provide a target directory";
	exit 1
fi

for i in $(find "$1" -type f -iregex '.+je?pg' -printf "\"%h/%p\"\n")
do
    datepath=$(identify -verbose "$i" | grep DateTimeOri | awk '{print $2 }' | sed s%:%/%g)
    if ! test -e "$2/$datepath"; then
        mkdir -pv "$2/$datepath"
    fi

    mv -v "$i" "$2/$datepath"
done
