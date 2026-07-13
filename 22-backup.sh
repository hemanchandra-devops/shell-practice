#!/bin/bash


R="\e[31m"
G="\e[32m"
Y="\e[33m" 
N="\e[0m"

LOGS_FOLDER="/var/log/shell-roboshop"
mkdir -p $LOGS_FOLDER
SCRIPIT_NAME=$(echo $0 | cut -d "." -f1)
LOGS_FILE="$LOGS_FOLDER/$SCRIPIT_NAME.log"
MONGODB_HOST=mongodb.heman.icu
SCRIPT_DIR=$PWD

echo "Script started executed at : $(date)" | tee -a $LOGS_FILE

USERID=$(id -u)

if [ $USERID -ne 0 ];then
    echo -e "$R Please run this script with Root Access! $N" | tee -a $LOGS_FILE
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];then
        echo -e "$R $2 ... $N Failure" | tee -a $LOGS_FILE
        exit 1
    else 
        echo -e "$G $2 ... $N Success" | tee -a $LOGS_FILE
    fi
}

SOUR_DIR=$1
DEST_DIR=$2

if [ $# -lt 2 ];then
    echo "sudo sh backup.sh <SOUR_DIR> <DEST_DIR>"
    exit 1
fi

if [ ! -d $SOUR_DIR ];then
    echo "SOUR_DIR:$SOUR_DIR doesn't exist!"
    exit 1
fi

if [ ! -d $DEST_DIR ];then
    echo "SOUR_DIR:$DEST_DIR doesn't exist!"
    exit 1
fi

LOGS_FILES=$(find $SOUR_DIR -name "*.log" -type f -mtime +14)

if [ ! -z $LOGS_FILES ];then
    echo "Log files found: $LOGS_FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE="$DEST_DIR/app-logs:$TIMESTAMP.zip"
    echo "Zip file is: $ZIP_FILE"
    find $SOUR_DIR -name "*.log" -type f -mtime +14 | zip -@ -j $ZIP_FILE

    if [ -f $ZIP_FILE ];then
         echo "Archive created: $ZIP_FILE"
        while IFS= read -r filepath
        do
            rm -rf $filepath
            echo "Deleted: $filepath"
        done <<<$LOGS_FILES
    else
        echo "Zip file not found"
    fi

else
    echo "No Log files to archieve"
fi