#!/bin/bash  


function cfgsystemd 
{
    test -e /usr/lib/systemd/system/keycloak.service
    if [[ $? == 0 ]]; then
        echo "--keycloaking : [Systemd] unit exists,do nothing......"
    else 
        echo "--keycloaking : [Systemd] configuring......"
        cp -p  $CKEYHOME/csf/config/keycloak.service  /usr/lib/systemd/system/keycloak.service
        systemctl daemon-reload
        sleep 2
        systemctl enable keycloak
        echo "--keycloaking : [Systemd] Done......"
    fi
}


