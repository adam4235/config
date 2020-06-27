#!/bin/bash

#might be better:
# -vcodec libx265 -crf 30

cat VTS_0*_*VOB | ffmpeg -i - -vcodec h264 -crf 28 -acodec aac rip.mp4

