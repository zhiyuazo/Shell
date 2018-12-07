#!/bin/bash  
#

function cfgdbuser
{
    echo "--keycloaking : [DB user] updating....."
    DBrequire=`cat /etc/keycloak.conf |grep -v ^# | grep  externalDB`
    DBuser=`echo $DBrequire |cut -d ":" -f 5`
    DBpass=`echo $DBrequire |cut -d ":" -f 6`

    index=`cat $CFGXML |grep -n 'module-option name="username"'|cut -d ":" -f 1`
    sed -i "${index}c                       <module-option name=\"username\" value=\"$DBuser\"/>" $CFGXML
    index=`cat $CFGXML |grep -n 'module-option name="password"'|cut -d ":" -f 1`
    sed -i "${index}c                       <module-option name=\"password\" value=\"$DBpass\"/>" $CFGXML
    echo "--keycloaking : [DB user] Done....."
}

