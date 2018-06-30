#!/bin/bash
# pod2player.sh : Move podget podcasts to a mobile player
# Copyright 2017, Bruce Ingalls. See COPYING for GPL 3.0 license
# WARNING! You can lose files, if you do not read, understand & edit this script!
#
# This script effectively does `mv ~/pod/* dest/`, while dealing with similar
# subdirectory names shared between source & destination directories
#
# For this to work, you must first mount the filesystem of your media player device 
# (e.g. Android). Finally, you should have the same directory structure in the podcast
# destination directory, as the ~/pod/ source podcatcher directory on your laptop
# Currently, this script handles 2 levels of nesting: podcast directories in category
# directories, with a default prefix of AUDIO_

#echo "Read instructions, and disable this line, before running this script"; exit

# The removable media mount point
#DEVICE=/Volumes/MyPlayerDevice/Podcasts     # Mac uses /Volumes, Linux uses /media or /mnt

#DEVICE="/Volumes/BLU\\ 1/Podcasts"
DEVICE="/Volumes/BLU/Podcasts"
#DEVICE="/Volumes/BLU\\ 2/Podcasts"

# Default Podget Library storage directory
DIR_LIBRARY=~/POD
CATEGORY_PREFIX='AUDIO_'	# Prefix for all your podcast categories, to filter, say, videos

# End of user edited section. You should not need to modify below

pushd "${DIR_LIBRARY}"                  # default podget storage directory
for CAT in ${CATEGORY_PREFIX}*; do
  pushd "${DIR_LIBRARY}/${CAT}"
  for CHAN in *; do
      DEST="${DEVICE}/${CAT}/${CHAN}/"
#  j=$(echo ${i} | sed 's/\([ ()]\)/\\\1/g')   # escape spaces, parens. Other weird podcast chars?
    eval mkdir -p "${DEST}"
    eval mv "${CHAN}/*" ${DEST}
    rmdir ${CHAN}				# clean up podcast directory (channel)
    echo "moved directory ${CHAN} to ${DEST}"
  done
  popd
  eval rmdir "${DIR_LIBRARY}/${CAT}"		# clean up category name
done
