#!/bin/bash

#This is a script called from fix_broken_usb.sh (I couldn't figure out how to call it from withi that script)

if file $1 | grep "data" > /dev/null
then
    echo $1 >> $HOME/Desktop/broken_files.txt
    #cp /home/adam/backup/rsync/adam/$1 $1
fi

