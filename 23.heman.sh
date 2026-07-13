#!/bin/bash

SOUR_DIR=$1
DEST_DIR=$2

if [ $# -lt 2 ];then
    echo "sudo sh heman.sh SOUR_DIR DEST_DIR pass the dir"
    exit 1
fi

if [ ! -d $SOUR_DIR ];then
    echo "$SOUR_DIR doesn't exist"
    exit 1
fi

if [ ! -d $DEST_DIR ];then
    echo "$DEST_DIR doesn't exist"
    exit 1
fi

LOGS_FILES=$(find $SOUR_DIR -name "*.log" -type f -mtime +14)

if [ ! -z "$LOGS_FILES" ];then
    echo "Log files found: $LOGS_FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE="$DEST_DIR/app-logs:$TIMESTAMP.zip"
    echo "Zip file is: $ZIP_FILE"
    find $SOUR_DIR -name "*.log" -type f -mtime +14 | zip -@ -j $ZIP_FILE

    if [ -f $ZIP_FILE ];then
        echo "Zip file found: $ZIP_FILE"
        while IFS= read -r file
        do
            rm -rf $file
            echo "Deleted log files are: $file"
        done <<< $LOGS_FILES
    else
        echo "Zip file not found"
        exit 1
    fi
else
    echo "Log files not found"
    exit 1
fi
