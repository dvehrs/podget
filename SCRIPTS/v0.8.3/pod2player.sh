#!/bin/zsh
# pod2droid.sh : Move podget podcasts to a mobile player
# Copyright 2017, Bruce Ingalls. See COPYING for GPL 3.0 license
# Mac mounts removable media at /Volumes; Linux typically mounts at /media or /mnt
# WARNING! You can lose files, if you do not read, understand & edit this script!
# Note that Z Shell is required
# I have the same subdirectory structure on my Android player, as my laptop podcatcher.

echo "Read instructions, and disable this line, before running this script"
exit 
# Where your player mounts, when connected to your laptop
DEST=/Volumes/MyPlayerDevice/Podcasts

# End of user edited section. You should not need to modify below

cd ~/POD                  # default podget storage directory
for i in AUDIO_**/*; do
  j=$(echo ${i} | sed 's/\([ ()]\)/\\\1/g')   # escape spaces, parens. Other weird podcast chars?
  eval dest=$DEST/${j}
  if [ -d ${dest} ] 
  then
    eval pushd ${j}
    eval mv * ${DEST}/${j}
    popd
    eval rmdir ${j}
  else
    mv ${j} ${dest}
  fi
done
