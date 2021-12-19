#!/bin/bash

# Change to the Source Directory
cd $SYNC_PATH

# Color
ORANGE='\033[0;33m'

# Display a message
echo "============================"
echo "Uploading the Build..."
echo "============================"

# Change to the Output Directory
cd out/target/product/${DEVICE}

# Set FILENAME var
FILENAME=$(echo $OUTPUT)

# Upload to oshi.at
if [ -z "$TIMEOUT" ];then
    TIMEOUT=20160
fi

curl -T $FILENAME https://oshi.at/${FILENAME}/${TIMEOUT} | tee link.txt > /dev/null

# Show the Download Link
echo "=============================================="
echo "${ORANGE}$(cat link.txt)"
echo "=============================================="

# Exit
exit 0
