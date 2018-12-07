#!/bin/bash  

function cfgfirewalld
{
    #1.7---Firewalld support
    systemctl status firewalld >/dev/null 2>&1
    if [[ $? == 0 ]]; then
        echo "--keycloaking : [Firewalld] running....."
        for i in `cat /etc/keycloak.conf  |grep -v ^# |grep port`
        do
            port=`echo $i |cut -d ":" -f 2`
            firewall-cmd --query-port  $port/tcp >/dev/null 2>&1
            if [[ $? == 0 ]]; then
                echo "--keycloaking : [Firewalld:$port] exist,do nothing....."
            else
                echo "--keycloaking : [Firewalld:$port] does not exist,Add it....."
                firewall-cmd --add-port=$port/tcp --permanent >/dev/null 2>&1 
                fire_flag=1
            fi
        done
        if [[ $fire_flag == 1 ]]; then
            systemctl restart firewalld
            unset fire_flag
        fi
    else 
        echo "--keycloaking : [Firewalld] inactive......"
        if [[ -f /usr/bin/firewall-offline-cmd ]]; then
            for i in `cat /etc/keycloak.conf |grep -v ^# |grep port`
            do
                port=`echo $i |cut -d ":" -f 2`
                firewall-offline-cmd --query-port  $port/tcp >/dev/null 2>&1
                if [[ $? == 0 ]]; then
                    echo "--keycloaking : [Firewalld:$port] exist,do nothing....."
                else
                    echo "--keycloaking : [Firewalld:$port] does not exist,Add it....."
                    firewall-offline-cmd --add-port=$port/tcp >/dev/null 2>&1 
                fi
            done
        else 
            echo "--keycloaking : [Firewalld] no OFFLINE CMD,do nothing......"
        fi

    fi
    echo "--keycloaking : [Firewalld] Done......"
} 
