function reminderbk 
{
#add Some important reminder......
    DBrequire=`cat /etc/keycloak.conf |grep -v ^# | grep  externalDB`
    DBused=`echo $DBrequire |cut -d ":" -f 2`
    if [[ $DBused == 0  ]]; then
        DB="embeded H2 DB."
    else
        DB="MariaDB."
    fi
    BindAddr=`cat /etc/keycloak.conf |grep -v ^# | grep  jboss.bind.address|cut -d ":" -f 2`
    cat <<!EOF 
|-------- Keycloak service's current configuration:
|         +--------------------------------------------------------------------------------------------+
|         | IPaddress :$BindAddr                                                                       |
|         | DataSource:$DB                                                                             |
|         +--------------------------------------------------------------------------------------------+
|         | Now,you need do the flowing steps:                                                         |
|         |     1. /opt/keycloak/bin/control_keystore gen                                              | 
          |                                          \${IP|DSNname}        \                            |
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
+         +--------------------------------------------------------------------------------------------+
|         For step 2, please change parameters in /etc/keycloak.conf:                                  |
|         +--------------------------------------------------------------------------------------------+
|         | IPaddress   : If you want to make KEYCLOAK servic on different IP                          |
|         | DataSource  : If you want to change the DataSource for KEYCLOAK                            |
|         | ServicePorts: IF you want to change the service ports for KEYCLOAK                         |
|         +----------------------------------------------------------------------------+---------------+
|         Useful Links :                                                                               |
|         +--------------------------------------------------------------------------------------------+
|         |Keycloak Guide: https://confluence.app.alcatel-lucent.com/display/plateng/CKEY+-+Web+SSO    |
+---------+--------------------------------------------------------------------------------------------+
!EOF
    unset DBused BindAddr
}


