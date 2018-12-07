#!/bin/bash

function reminderNI 
{
    cat <<!EOF 
!EOF
}

function reminderUP 
{
    cat <<!EOF 
!EOF
}
systemctl daemon-reload

if [[ $1 == "NI" ]]; then
    reminderNI
elif [[ $1 == "UP" ]]; then
    reminderUP
else 
    exit 1
fi
exit 0
