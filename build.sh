#!/bin/bash

# Change to the Source Directry
cd $SYNC_PATH

# Set-up ccache
if [ -z "$CCACHE_SIZE" ]; then
    ccache -M 10G
else
    ccache -M ${CCACHE_SIZE}
fi

# Empty the VTS Makefile
if [ -f frameworks/base/core/xsd/vts/Android.mk ]; then
    rm -rf frameworks/base/core/xsd/vts/Android.mk && touch frameworks/base/core/xsd/vts/Android.mk
fi

# Run the Extra Command
$EXTRA_CMD

# Prepare the Build Environment
source build/envsetup.sh

# export some Basic Vars
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export LC_ALL="C"

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
