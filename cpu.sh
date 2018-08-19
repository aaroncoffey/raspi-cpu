#!/bin/bash

# Written by Aaron Coffey on 10/27/2012
# Written for the Raspberry Pi

# raw output temp=49.8'C
raw=`/opt/vc/bin/vcgencmd measure_temp`
f1=${raw:5}
celc=${f1%\'C}
fah=`echo "scale=1;($celc*(9/5))+32" | bc`
echo "Cur CPU Temp:  $celc'C"
echo "              $fah'F"

# Are you root?
if [[ $EUID -ne 0 ]]; then
   echo "You must be root to check the CPU Frequency." 1>&2
   exit 1
fi

cur=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq`
max=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq`
min=`cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq`

cur=$(expr $cur / 1000)
max=$(expr $max / 1000)
min=$(expr $min / 1000)

echo "Cur CPU Freq: $cur MHz"
echo "Max CPU Freq: $max MHz"
echo "Min CPU Freq: $min MHz"

exit 0
