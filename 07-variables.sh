#!/bin/bash

start_time=$(date +%s)
sleep 5
end_time=$(date +%s)
total_time=$(($end_time-$start_time))
echo "Scripted executed in $total_time seconds"