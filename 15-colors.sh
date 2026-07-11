#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m" 
N="\e[0m"

USERID=$(id -u)

if [ $USERID -ne 0 ];then
    echo -e "$R Please run this script with Root Access! $N"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];then
        echo -e "$R Installing $2 ... $N Failure"
        exit 1
    else 
        echo -e "$G Installing $2 ... $N Success"
    fi
}

dnf list installed mysql
if [ $? -ne 0 ];then
    dnf install mysql -y
    VALIDATE $? "MySql"
else
    echo "Already Installed Mysql"
fi

dnf list installed nginx
if [ $? -ne 0 ];then
    dnf install nginx -y
    VALIDATE $? "Nginx"
else
    echo "Already Installed Nginx"
fi

dnf list installed redis
if [ $? -ne 0 ];then
    dnf install redis -y
    VALIDATE $? "Redis"
else
    echo "Already Installed Redis"
fi