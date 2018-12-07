function reminder 
{
#add Some important reminder......
    DBinfo=`cat /etc/keycloak.conf |grep -v ^# | grep  DBlink`
    DBdriver=`echo $DBinfo |cut -d ":" -f 2`
    BindAddrK=`cat /etc/keycloak.conf |grep -v ^# | grep  jboss.bind.address:|cut -d ":" -f 2`
    BindAddrM=`cat /etc/keycloak.conf |grep -v ^# | grep  jboss.bind.address.management:|cut -d ":" -f 2`
    BindAddrP=`cat /etc/keycloak.conf |grep -v ^# | grep  jboss.bind.address.private:|cut -d ":" -f 2`
    cat <<!EOF 
|-------- Keycloak service's current configuration:
|         +--------------------------------------------------------------------------------------------+
|         | IPaddress for keycloak :   $BindAddrK                                                       |
|         | IPaddress for Management : $BindAddrM                                                       |
|         | IPaddress for Private :    $BindAddrP                                                       |
|         | DataSource:$DBdriver                                                                  |
+         +--------------------------------------------------------------------------------------------+
|         Please change parameters in /etc/keycloak.conf:                                              |
|         +--------------------------------------------------------------------------------------------+
|         | IPaddress   : If you want to make KEYCLOAK servic on different IP                          |
|         | DataSource  : If you want to change the DataSource for KEYCLOAK                            |
|         | ServicePorts: IF you want to change the service ports for KEYCLOAK                         |
+---------+----------------------------------------------------------------------------+---------------+
!EOF
    unset DBinfo DBdriver
}


