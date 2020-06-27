#!/bin/bash

mkdir shrunk
for i in *.mp4
do
    if ! [ -f "shrunk/$i" ]
    then
        ffmpeg -i "$i" -vcodec libx264 -crf 28 "shrunk/$i"
    fi
done

