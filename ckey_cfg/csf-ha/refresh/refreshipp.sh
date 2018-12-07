#!/bin/bash  
#


function refreshipp
{
    #--Modify the standalone.xml
        echo "--keycloaking : [refresh:Master:ip and ports] configuring....."

        for i in `cat /etc/keycloak.conf |grep -v ^# |grep jboss.*port`
        do
            find=`echo $i |cut -d ":" -f 1`
            sed -i "s/${find}:[0-9]\+/$i/g" $CFGXML
        done

        for i in `cat /etc/keycloak.conf |grep -v ^# |grep jboss.*address`
        do
            find=`echo $i |cut -d ":" -f 1`
            sed -i "s/${find}:\([0-9]\+\.\)\+[0-9]\+/$i/g" $CFGXML
        done

        echo "--keycloaking : [refresh:Master:ip and ports] Done....."
}

