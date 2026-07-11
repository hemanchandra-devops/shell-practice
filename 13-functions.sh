#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ];then
    echo "Please run this script with Root Access!"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];then
        echo "Installing $2 Failure"
        exit 1
    else 
        echo "Installing $2 Success"
    fi
}

dnf install mysql -y
VALIDATE $? "MySql"

dnf install nginx -y
VALIDATE $? "Nginx"

dnf install redis -y
VALIDATE $? "Redis"