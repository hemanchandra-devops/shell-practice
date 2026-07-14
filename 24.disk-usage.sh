#!/bin/bash

Disk=$(df -hT | grep -v Filesystem)
Disk_Threshold=25
while IFS= read -r line
do
    Disk_Usage=$( echo $line | awk '{print $6}' | cut -d "%" -f1 )
    Parition=$( echo $line | awk '{print $7}' )
    if [ $Disk_Usage -ge $Disk_Threshold ];then
        echo "High Usage $Disk_Usage on $Parition"
    fi

done <<<$Disk