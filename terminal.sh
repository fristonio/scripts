#!/bin/bash

NC='\033[m'
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'

if [ -z `which xdotool` ]; then
    echo "${RED}[-]${NC} ${CYAN}xdtool${NC} is not installed. Install it [Y/N]"
    read choice
    if [[ $choice == "Y" || $choice == "y" || $choice == "" ]]; then
        sudo apt-get install xdotool
    else
        echo "${CYAN}[*]${NC} Exitting - NO xdtool ...."
        exit 1
    fi
fi

activate_window () {
    window_id=$(xdotool search --pid $1 --name "terminator" | tail -1)
    xdotool windowactivate $window_id 
}

app="teminator"
process_name=`which terminator`

if [ -e ${process_name} ]; then
    pid=$(pgrep -f terminator)
    # Terminator isnt launched
    if [ -z $pid ]; then
        $process_name
    else
        # Terminal is launched
        echo "[+] Terminator window PID ${pid}"
        # Check current focused app
        focused_app=$(xdotool getactivewindow getwindowpid)
        echo "[+] Focused window PID ${focused_app}"
        if [ $pid == $focused_app ]; then
            xdotool getactivewindow windowminimize
            exit 0
        else
            echo "[+] Focusing on terminator window"
            activate_window $pid
        fi
    fi
else
    echo "${CYAN}[*]${NC} Exitting - No application ${app}...."
    exit 1
fi

exit 0

