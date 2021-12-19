#!/bin/bash

# Change to the Home Directory
cd ~

# Clone the Sync Repo
git clone $FOX_SYNC
cd sync

# Sync the Sources
./orangefox_sync.sh --branch $SYNC_BRANCH --path "$SYNC_PATH"

# Change to the Source Directory
cd $SYNC_PATH

# Clone the theme if not already present
if [ ! -d bootable/recovery/gui/theme ]; then
git clone https://gitlab.com/OrangeFox/misc/theme.git bootable/recovery/gui/theme
fi

# Clone Trees
git clone $DT_LINK $DT_PATH

# Exit
exit 0
