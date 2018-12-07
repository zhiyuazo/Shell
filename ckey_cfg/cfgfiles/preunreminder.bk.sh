#!/bin/bash

function reminderErase 
{
    cat <<!EOF 
|-------- Keycloak will be removed on this server,Please pay your attentions...          
|         +----------------------------------------------------------------------------+---------------+
|         | 1. All new-files in /opt/keycloak will be kept in original locations                       |
|         | 2. The flowing items will be kept in the original locations with suffix .rpmsave           |
+    R    |    (Note: if changed!)                                                                     |
|    E    |          /etc/keycloak.conf.rpmsave                                                        |
|    M    |          /usr/lib/systemd/system/keycloak.service.rpmsave                                  |
|    I    |          /etc/sudoers.d/keycloak.sudoers.rpmsave                                           |
|    N    |          /opt/keycloak/siganl/H2KCuser_flag.rpmsave                                        |
|    D    |          /opt/keycloak/siganl/DBKCuser_flag.rpmsave                                        |
|    E    |          /opt/keycloak/standalone/configuration/*/*.rpmsave                                |
|    R    |          /opt/keycloak/modules/system/layers/keycloak/org/mariadb/main/module.xml.rpmsave  |                             
|         +----------------------------------------------------------------------------+---------------+
|         | Useful Links :                                                                             |
|         |   Keycloak Guide: https://confluence.app.alcatel-lucent.com/display/plateng/CKEY+-+Web+SSO |
+---------+--------------------------------------------------------------------------------------------+
!EOF
}

function reminderUP 
{
    cat <<!EOF 
|-------- Old Keycloak files will be removed.......           
|         +----------------------------------------------------------------------------+---------------+
|         | 1. All new-files in /opt/keycloak will be kept in original locations                       |
|         | 2. The flowing items will be kept in the original locations with suffix .rpmsave           |
+    R    |    (Note: if changed!)                                                                     |
|    E    |          /etc/keycloak.conf.rpmsave                                                        |
|    M    |          /usr/lib/systemd/system/keycloak.service.rpmsave                                  |
|    I    |          /etc/sudoers.d/keycloak.sudoers.rpmsave                                           |
|    N    |          /opt/keycloak/siganl/H2KCuser_flag.rpmsave                                        |
|    D    |          /opt/keycloak/siganl/DBKCuser_flag.rpmsave                                        |
|    E    |          /opt/keycloak/standalone/configuration/*/*.rpmsave                                |
|    R    |          /opt/keycloak/modules/system/layers/keycloak/org/mariadb/main/module.xml.rpmsave  |                             
|         +----------------------------------------------------------------------------+---------------+
|         | Useful Links :                                                                             |
|         |   Keycloak Guide: https://confluence.app.alcatel-lucent.com/display/plateng/CKEY+-+Web+SSO |
+---------+--------------------------------------------------------------------------------------------+
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
