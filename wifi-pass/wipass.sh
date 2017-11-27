#!/bin/bash

if [ "$EUID" != 0 ]
then
    echo "[-] Need to run the script as root"
    exit 1
fi

BASE_PATH="/etc/NetworkManager/system-connections/"

usage () {
    echo " *********************** WIPASS **************************"
    echo " [+] -s, --show [wifiname] : Show Password for the wifi"
    echo " [+] -d, --delete [wifiname]" : Delete wifi from NetworkMangager known wifi
    echo " [+] -h, --help : Show help"
}

check_wifi_name () {
    if [ $1 == "" ]; then
        echo "[-] Enter a wifi name to begin with."
        exit
    fi

    filepath=$BASE_PATH$1

    if [ ! -f $filepath ]; then
        echo "[-] Wifi does not exist in NM"
        exit 
    fi

    echo "$filepath"
}

show_wifi_password () {
    filepath=$(check_wifi_name $1)
    password=$(cat $filepath | grep psk=) 
    echo "[*] Passowrd is : ${password:4}"
    exit
}

delete_wifi_password () {
    filepath=$(check_wifi_name $1)
    rm $filepath
    echo "[*] WIFI deleted successfully from Network Manager"
    exit
}

while [ "$1" != "" ]; do
    case $1 in
        -s | --show)
            shift
            show_wifi_password $1
            ;;
        -d | --delete)
            shift
            delete_wifi_password $1
            ;;
        -h | --help)
            usage
            exit
            ;;
        *)
            usage
            exit
            ;;
    esac
    shift
done
