#!/bin/bash

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" -d chat_id="${TG_CHAT_ID}" \
	-d "parse_mode=Markdown" \
	-d text="$1"
}

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

curl -T $FILENAME https://oshi.at/${FILENAME}/${TIMEOUT} | tee link.txt > /dev/null || { echo "ERROR: Failed to Upload the Build!" && exit 1; }

DL_LINK = $(cat link.txt | grep Download | cut -d\  -f1)

# Show the Download Link
echo "=============================================="
echo ${DL_LINK} || { echo "ERROR: Failed to Upload the Build!" && exit 1; }
echo "=============================================="

# Send the Message on Telegram
telegram_message \
"
🦊 OrangeFox Recovery CI

✅ Build Completed Successfully!

📱 Device: \"${DEVICE}\"
🌲 Device Tree: \"${DT_LINK}\"
🖥 Build System: \"${FOX_BRANCH}\"
⬇️ Download Link: \"${DL_LINK}\"
📅 Date: \"$(date +'%d %B %Y')\"
⏱ Time: \"$(date +"%T")\"
"

# Exit
exit 0
