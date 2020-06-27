#!/bin/bash

for i in *.mp4 
do 
    outputFile=`basename -s .mp4 "${i}"`.mp3
    ffmpeg -i "${i}" "${outputFile}"
done

