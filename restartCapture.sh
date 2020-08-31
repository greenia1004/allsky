#!/bin/bash
source ~/allsky/config.sh

echo "Restarting Capture with new settings"
cd ~/allsky

# Building the arguments to pass to the capture binary
ARGUMENTS=""
KEYS=( $(jq -r 'keys[]' $CAMERA_SETTINGS) )
for KEY in ${KEYS[@]}
do
	ARGUMENTS="$ARGUMENTS -$KEY `jq -r '.'$KEY $CAMERA_SETTINGS` "
done
echo "Restarting with new arguments $ARGUMENTS">>~/allsky/log.txt

# We kill the capture process and restart it with new arguments
killall -9 capture ; ~/allsky/capture $ARGUMENTS
