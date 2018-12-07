#!/bin/bash

function reminderNI 
{
    cat <<!EOF 
|-------- Keycloak was installed successfully just now...          
|         +--------------------------------------------------------------------------------------------+
|         | This is a base keycloak package,includes:                                                  |
|         |     Nokia_csf themes                                                                       |
|         |     sudo configuration                                                                     |
|         |     keycloak user flags for DataSource                                                     |
|         |     mariadb-java-client-1.6.1.jar driver                                                   |         |
|         |     systemd support :(include "systemctl daemon-reload")                                   |
|    R    +----------------------------------------------------------------------------                |
|    E    | Chose one keycloak running Mode and install the corresponding RPM:                         |
|    M    |     keycloak-standalone   : Install to run keycloak as standalone mode                     |
|    I    |     keycloak-standalone-ha: Install to run keycloak as standalone-ha mode                  |
|    N    |     keycloak-domain       : Install to run keycloak as domain mode                         |
|    D    +----------------------------------------------------------------------------                |
|    E    | After installl the mode RPM package,you need do the flowing steps:                         |
|    R    |     1. /opt/keycloak/bin/control_keystore gen                                              |
|    !    |                                          \${IP/DSNname}        \                            |
|         |                                           keycloak.server.jks \                            |
|         |                                           keycloak            \                            |
|         |                                           keycloak-server     \                            |
|         |                                           keycloak                                         |
|         |     2. cp keycloak.server.jks /opt/keycloak/standalone/configuration/                      |
|         |     3. chown keycloak:keycloak /opt/keycloak/standalone/configuration/keycloak.server.jks  |
|         |     4. Modify the /etc/keycloak.conf                                                       |
|         |     5. systemctl start keycloak                                                            |
|         | Then you can access the keycloak @ https://\${IP|DSNname}:8666                              |
|         |              Note: "/opt/keycloak/csf/ckey_admin enfire" to open ports in firwalld.        |
|         |              Note: "/opt/keycloak/csf/ckey_admin unfire" to close ports in firwalld.       |
+---------+----------------------------------------------------------------------------++--------------+
|         | Useful Links :                                                                             |
|         |   Please refer to the keycloak user guide                                                  |
|-------- +--------------------------------------------------------------------------------------------+
!EOF
}

function reminderUP 
{
    cat <<!EOF 
|-------- Keycloak was upgraded successfully just now...          
|         +--------------------------------------------------------------------------------------------+
|         | You may found one or more new files in the following list:                                 |                |
|         |     /etc/keycloak.conf.rpmnew                                                              |
|         |     /usr/lib/systemd/system/keycloak.service.rpmnew                                        |
|         |     /etc/sudoers.d/keycloak.sudoers.rpmnew                                                 |
|         |     /opt/keycloak/siganl/H2KCuser_flag.rpmnew                                              |
|         |     /opt/keycloak/siganl/DBKCuser_flag.rpmnew                                              |
|         |     /opt/keycloak/standalone/configuration/*/*.rpmnew                                      |
|         |     /opt/keycloak/modules/system/layers/keycloak/org/mariadb/main/module.xml.rpmnew        |
+         +--------------------------------------------------------------------------------------------+
|         | Take "/etc/keycloak.conf as example:                                                       |
|         | scenario.1:                                                                                |
|         |     If the "/etc/keycloak.conf" in low version is not changed since you install keycloack  |
|         |     If the "/etc/keycloak.conf" in high version is not changed with low version            |
|         |     Then, After Upgrade from low to high version                                           |
|         |     "/etc/keycloak.conf" in high version will be kept                                      |
|         | scenario.2:                                                                                |
|         |     If the "/etc/keycloak.conf" in low version is not changed since you install keycloack  |
|         |     If the "/etc/keycloak.conf" in high version is changed with low version                |
|         |     Then, After Upgrade from low to high version                                           |
|         |         "/etc/keycloak.conf" in high version will be kept                                  |
|         | scenario.3:                                                                                |
|         |     If the "/etc/keycloak.conf" in low version is changed since you install keycloack      |
|         |     If the "/etc/keycloak.conf" in high version is not changed with low version            |
|         |     Then, After Upgrade from low to high version                                           |
|         |         "/etc/keycloak.conf" in low version(changed by you) will be kept                   |
|         | scenario.4:                                                                                |
|         |     If the "/etc/keycloak.conf" in low version is changed since you install keycloack      |
|         |     If the "/etc/keycloak.conf" in high version is changed with low version                |
|         |     Then, After Upgrade from low to high version                                           |
|         |         "/etc/keycloak.conf" in low version(changed by you) will be kept                   |
|         |         "/etc/keycloak.conf" in high version will be kept as "/etc/keycloak.conf.rpmnew".  |
|         +----------------------------------------------------------------------------                |
|         | After Upgrade keycloak,you need do the flowing steps:                                      |
|         |     1. If the *rmpnew files exist, add the changes in *rpmnew files to corresponding files |                                            |
|         |     2. systemctl start keycloak                                                            |
|         | Then you can access the keycloak @ https://\${IP|DSNname}:8666                              |
|         |              Note: "/opt/keycloak/csf/ckey_admin enfire" to open ports in firwalld.        |
|         |              Note: "/opt/keycloak/csf/ckey_admin unfire" to close ports in firwalld.       |
+---------+----------------------------------------------------------------------------++--------------+
|         | Useful Links :                                                                             |
|         |   Keycloak Guide: https://confluence.app.alcatel-lucent.com/display/plateng/CKEY+-+Web+SSO |
|-------- +--------------------------------------------------------------------------------------------+
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
