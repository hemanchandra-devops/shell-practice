#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m" 
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
mkdir -p $LOGS_FOLDER
SCRIPIT_NAME=$(echo $0 | cut -d "." -f1)
LOGS_FILE="$LOGS_FOLDER/$SCRIPIT_NAME.log"

echo "Script started executed at : $(date)" | tee -a $LOGS_FILE

USERID=$(id -u)

if [ $USERID -ne 0 ];then
    echo -e "$R Please run this script with Root Access! $N" | tee -a $LOGS_FILE
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];then
        echo -e "$R Installing $2 ... $N Failure" | tee -a $LOGS_FILE
        exit 1
    else 
        echo -e "$G Installing $2 ... $N Success" | tee -a $LOGS_FILE
    fi
}

for package in $@
do
    dnf list installed $package &>> $LOGS_FILE
    if [ $? -ne 0 ];then
        dnf install $package -y &>> $LOGS_FILE
        VALIDATE $? $package
    else
        echo -e "$Y Already Installed $package ... $N Skipping" | tee -a $LOGS_FILE
    fi
done