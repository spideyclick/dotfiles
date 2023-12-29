#!/bin/bash

# Install inotifywait on ubuntu/debian with:
# apt install inotify-tools

# Based on the example at:
# https://github.com/inotify-tools/inotify-tools/wiki#inotifywait

###############################################################################
# Parameters                                                                  #
###############################################################################
# Don't use trailing slashes in directory paths!
SOURCE_DIR=project_name
TARGET_HOST=my_server
TARGET_DIR=~/projects/project_name

###############################################################################
# Directory Setup/Initial Download                                            #
###############################################################################
CURRENT_DIRECTORY=$(dirname "$0")
cd "$CURRENT_DIRECTORY"
if [ ! -d "./${SOURCE_DIR}" ]; then
  echo "Downloading remote directory into ${SOURCE_DIR}"
  rsync -azP "${TARGET_HOST}:${TARGET_DIR}/" "./${SOURCE_DIR}/"
fi
cd "$SOURCE_DIR"

###############################################################################
# Watch for changes & sync                                                    #
###############################################################################
inotifywait -mr \
  --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' \
  --exclude '\.git' \
  -e close_write . |
while read -r date time dir file; do
  CHANGED_ABS="${dir}${file}"
  CHANGED_REL="${CHANGED_ABS#"$CURRENT_DIRECTORY"/}"
  rsync \
    --progress \
    --relative \
    -vraze \
    'ssh -p 22' \
    "${CHANGED_REL}" \
    "${TARGET_HOST}:${TARGET_DIR}/" && \
      echo "At ${time} on ${date}, file $CHANGED_ABS was backed up via rsync" >&2
done
