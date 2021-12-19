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

# Clone Trees
git clone $DT_LINK $DT_PATH

# ccache
if [ -z "$CCACHE_SIZE" ]; then
    ccache -M 10G
else
    ccache -M ${CCACHE_SIZE}
fi

# Run the Extra Command
$EXTRA_CMD

# Prepare the Build Environment
source build/envsetup.sh

# lunch the target
if [ "$FOX_BRANCH" = "fox_11.0" ]; then
    lunch twrp_${DEVICE}-eng
else
    lunch omni_${DEVICE}-eng
fi

# Build the Code
if [ -z "$J_VAL" ]; then
    mka -j$(nproc --all) $TARGET
elif [ "$J_VAL"="0" ]; then
    mka $TARGET
else
    mka -j${J_VAL} $TARGET
fi

# Exit
exit 0
