#!/bin/bash

sudo kbdrate -r 1 -d 10000 # set keyboard repeat rate very high, so cant have multiple presses on pedal

amixer -c $DEVICE_NUMBER set Speaker 50% > /dev/null # set speaker output volume to 50%

cvlc --quiet --no-osd -L -f --audio-visual visual --effect-list dummy /tmp/music.wav 2> /dev/null & # starts playing background music

# clear

while true; do
perl -e 'use POSIX; tcflush(0, TCIFLUSH);' # flushes keyboard inputs from previous loops

read -rsn1 input # reads keyboard input

if [ "$input" = "b" ]; then
    # echo "stop bgm"
        for i in {50..0}; do sleep 0.06; amixer -c $DEVICE_NUMBER set Speaker $(($i * 1))% > /dev/null ; done # fade out background music
        killall -9 vlc 2> /dev/null # stop bgm playback

        amixer -c $DEVICE_NUMBER set Speaker 50% > /dev/null # set speakers back to 50%

        # echo "play narration"
        cvlc --quiet --no-osd -f /tmp/video.m4v vlc://quit 2> /dev/null # play voice over file

        # clear

        # echo "bgm"
        cvlc --quiet --no-osd -L -f --audio-visual visual --effect-list dummy /tmp/music.wav 2> /dev/null & # start bgm again

        # clear

fi

done
