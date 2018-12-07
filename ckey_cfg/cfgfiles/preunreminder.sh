#!/bin/bash

function reminderErase 
{
    cat <<!EOF 
!EOF
}

function reminderUP 
{
    cat <<!EOF 
!EOF
}

if [[ $1 == "ERASE" ]]; then
    reminderErase
elif [[ $1 == "UP" ]]; then
    reminderUP
else 
    exit 1
fi
exit 0
