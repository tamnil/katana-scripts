#!/bin/bash 

# set de sink (output)
#


# get sinksd, note a2dp is not HSP
# pactl list sinks|grep

# set inputs
# pactl list sink-inputs short |cut -f1   



echo "Setting default sink to: $1";
# where new pa should output sound for new programs
pacmd set-default-sink $1
# get "active" programs and with while read
pactl list sink-inputs short |cut -f1 | while read line    
do
echo "Moving input: ";
echo $line
#| cut -f2 -d' ';
echo "to sink: $1";
#  move audio to the newly assigned output.
pacmd move-sink-input `echo $line | cut -f2 -d' '` $1

done
