#!/bin/bash

Number=$1

if [ $Number -lt 10 ];then
    echo "Given $Number is less than 10"
elif [ $Number -eq 10 ];then
    echo "Given $Number is euql to 10"
else
    echo "Given $Number is greater than 10"
fi