#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0];then
    echo "Please run this script with Root Access!"
    exit 1
fi

dnf install mysql -y
if [ $? -ne 0 ];then
    echo "Installing Mysql Failure"
    exit 1
else 
    echo "Installing Mysql Success"
fi