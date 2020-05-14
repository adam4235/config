#!/bin/bash

#Phones create videos that are sideways in some video players if you hold the phone in portrait when taking the video.
#This script fixes those files to be right side up in all video players.

#Requires exiftool and ffmpeg

mkdir converted
mkdir original
for f in "$@"
do
    #If the video has rotation metadata of 90 degrees
    if exiftool -Rotation "$f" | grep ": 90" > /dev/null 2>&1
    then
        #Rotate it then rotate it back in one pass, but clear the rotation metadata
        ffmpeg -i "$f" -vf "transpose=1,transpose=2" "converted/$f"
        mv "$f" original
    fi
done

