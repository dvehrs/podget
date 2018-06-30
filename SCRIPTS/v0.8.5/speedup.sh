#!/bin/zsh
# faster mp3 playback https://superuser.com/questions/519649/tool-to-bulk-speed-up-convert-an-audio-file
for i in $*;do
  ffmpeg -i $i -filter:a "atempo=1.6" -c:a libmp3lame -q:a 4 -vsync 2 ~/speedup/$i
done

