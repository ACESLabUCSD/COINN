#/bin/bash

if [ $1 == "ON" ]; then
    #Setup the rate control and delay
    echo "setting up rate control"
    sudo tc qdisc add dev lo root handle 1: htb default 12 
    sudo tc class add dev lo parent 1:1 classid 1:12 htb rate $2 ceil $3
    sudo tc qdisc add dev lo parent 1:12 netem delay $4
elif [ $1 == "OFF" ]; then
    #Remove the rate control/delay
    echo "removing rate control"
    sudo tc qdisc del dev lo root
fi

qperf& qperf -v localhost tcp_bw tcp_lat