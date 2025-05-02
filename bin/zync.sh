#!/usr/bin/env bash

# Install inotifywait on ubuntu/debian with:
# apt install inotify-tools

# Based on the example at:
# https://github.com/inotify-tools/inotify-tools/wiki#inotifywait

###############################################################################
# Parameters                                                                  #
###############################################################################
TARGET=${ZYNC_TARGET:-$1}
TARGET=${TARGET%/}

echo "Checking initial Sync..."
rsync \
  --exclude '.envrc' \
  --exclude '.git' \
  --delete \
  -arvz . "$TARGET/" \
  --dry-run \
  | tspin --highlight red:deleting;

read -p "Press enter to continue"
rsync \
  --progress \
  --exclude '.envrc' \
  --exclude '.git' \
  --delete \
  -arvz . "$TARGET/" \
  | tspin --highlight red:deleting;

# ###############################################################################
# # Watch for changes & sync                                                    #
# ###############################################################################
# inotifywait -mr \
#   --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' \
#   --exclude '\.git' \
#   -e close_write . |
# while read -r date time dir file; do
#   CHANGED_ABS="${dir}${file}"
#   CHANGED_REL="${CHANGED_ABS#"$CURRENT_DIRECTORY"/}"
#   echo "$CHANGED_ABS"
#   echo "$CHANGED_REL"
#   rsync \
#     --progress \
#     --relative \
#     -arvz \
#     "${CHANGED_REL}" \
#     "${TARGET}/" && \
#       echo "At ${time} on ${date}, file $CHANGED_ABS was backed up via rsync" >&2
# done

