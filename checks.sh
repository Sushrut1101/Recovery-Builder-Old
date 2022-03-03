#!/bin/bash

CONFIG="vars.sh"

if [ ! -z $(cat $CONFIG 2>&1 | grep "TG") ]; then
    echo "ERROR - You Cannot Set *TG* Vars in your $CONFIG"
    exit 1
fi

# Do not allow curl
curl_check=$(grep 'curl ' $CONFIG | wc -l)
if [[ $curl_check -gt 0 ]]; then
    echo -e "Please dont use \'curl\' in $CONFIG".
    exit 1
fi
