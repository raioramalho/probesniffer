#!/bin/sh
# encoding utf-8
# Created by: Acr4n1us
# Contact & Changelog: https://github.com/RamalhoSec
# Bitcoin: 3DppKRbA9Um3z4wnmVtkqnETnvwsip7WkC
# Version 0.1


#::set color palet
RESET='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
WHITE='\033[01;37m'
#:::::::::::::::::::::::::::::


#::set global variables
DATA=$(/bin/date +%d-%m-%Y)
OUTFILE="sniff:$DATA.cap"
CHANNEL_HOP="${CHANNEL_HOP:-0}"
IFACE="$1"


#::verifications for start
#[ "$UID" != "0" ] && { echo $red"Please runt this tool at root!"; exit 1 ;}
#:::::::::::::::::::::::::::::

#::debug
printf "${RED}Hello!\n${RESET}"
