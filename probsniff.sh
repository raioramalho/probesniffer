#!/usr/bin/env bash
# encoding utf-8
# Created by: Acr4n1us
# Contact & Changelog: https://github.com/RamalhoSec
# Bitcoin: 3DppKRbA9Um3z4wnmVtkqnETnvwsip7WkC

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
VERSION="1.b"
DATA=$(/bin/date +%d-%m-%Y)
OUTPUT="sniff-$DATA.cap"
CHANNEL_HOP="${CHANNEL_HOP:-0}"
IFACE="$1"
DIR=$(pwd)
#:::::::::::::::::::::::::::::


#::check updates
rm -rf /tmp/p*
wget -q -O /tmp/pbsniff.check https://raw.githubusercontent.com/RamalhoSec/Probsniff/master/probsniff.sh
MIRROR=$(cat /tmp/pbsniff.check | grep "VERSION=" | head -1 | sed 's/VERSION=//' | sed 's/"//g')
if [ $VERSION == $MIRROR ] ; then
	printf "${RED}You're using realese version: ${BLUE}v:$VERSION${RESET}\n"
else
	printf "${BLUE}Wait, updating this tool..${RESET}\n"
	cp /tmp/pbsniff.check probsnifff.sh
	printf "${RED}Ok, restart this tool!${RESET}\n"
	exit 1 ; 
fi
printf "\n"
#::::::::::::::::::::::::::::

#set global functions
channel_hop() {

	IEEE80211bg="1 2 3 4 5 6 7 8 9 10 11"
	IEEE80211bg_intl="$IEEE80211b 12 13 14"
	IEEE80211a="36 40 44 48 52 56 60 64 149 153 157 161"
	IEEE80211bga="$IEEE80211bg $IEEE80211a"
	IEEE80211bga_intl="$IEEE80211bg_intl $IEEE80211a"

	while true ; do
		for CHAN in $IEEE80211bg ; do
			# echo "switching $IFACE to channel $CHAN"
			sudo iwconfig $IFACE channel $CHAN
			sleep 2
		done
	done
}

if ! [ -x "$(command -v gawk)" ]; then
  echo 'gawk (GNU awk) is not installed. Please install gawk.' >&2
  exit 1
fi

if [ -z "$IFACE" ] ; then
	echo "IFACE env variable must be set. Type \"ifconfig\" to view network interaces."
	exit 1
fi

if [ "$CHANNEL_HOP" -eq 1 ] ; then
	# channel hop in the background
	channel_hop &
fi
#:::::::::::::::::::::::::::::::::

#::start prob sniff
tcpdump -U -v -l -I -i "$IFACE" -e -s 256 type mgt subtype probe-req | awk -f .pbs.conf.awk | tee -a "$OUTPUT" 
#:::::::::::::::::::::::::::::::::
