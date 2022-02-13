#!/bin/bash

if [ ! -z $(cat vars.sh 2>&1 | grep "TG") ]; then
    echo "ERROR - You Cannot Set *TG* Vars in your vars.sh"
    exit 1
fi
