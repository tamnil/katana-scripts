#!/bin/bash
# CLI options:  `a2dp': Audio Profile
#               `hsp':  Telephony Profile
#               <Index> Default Sink (try `0' or `1')



SINK=$( pacmd list-cards | grep -B 1 bluez )
# echo $SINK
INDEX=${SINK:10:3}
# echo $INDEX
SINK=$( pacmd list-cards | grep bluez )
# echo $SINK
MAC=${SINK:19:17}
# echo $MAC
BT_SINK="bluez_sink.$MAC"
# echo $BT_SINK
BT_SOURCE="bluez_source.$MAC"
# echo $BT_SOURCE

if [ $1 = stereo ]; then

    echo Setting A2DP audio sink $BT_SINK
    BT_SINK="$BT_SINK.a2dp_sink"

    # echo $BT_SINK
    pacmd set-card-profile $INDEX a2dp_sink
    pacmd set-default-sink $BT_SINK

    notify-send 'stereo'

elif [ $1 = mono ]; then
    echo Setting HSP headset sink $BT_SOURCE
    BT_SOURCE="$BT_SOURCE.headset_head_unit"
    BT_SINK="$BT_SINK.headset_head_unit"
    pacmd set-card-profile $INDEX headset_head_unit
    pacmd set-default-sink $BT_SINK
    pacmd set-default-source $BT_SOURCE

    notify-send 'mono'
else
    echo Resetting to internal audio-disabled in script
    # pacmd set-default-sink $1
    # pacmd set-default-source $1
fi
