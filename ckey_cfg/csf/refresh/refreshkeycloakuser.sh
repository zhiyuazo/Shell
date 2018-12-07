function refreshkeycloakuser
{
        #--add init user of keycloak and wildfly manager to H2
        DBrequire=`cat /etc/keycloak.conf |grep -v ^# | grep  externalDB`
            DBtype=`echo $DBrequire |cut -d ":" -f 2`
        DBinfo=`cat /etc/keycloak.conf |grep -v ^# | grep  DBlink`
            DBdriver=`echo $DBinfo |cut -d ":" -f 2`
        if [[ $DBtype == 0 ]]; then
            H2KCuser_flag=`cat $CKEYHOME/signal/H2KCuser_flag`
            if [[ $H2KCuser_flag == 0  ]]; then
                echo "--keycloaking : [refresh:USER for $DBdriver] adding....."
                $CKEYHOME/bin/add-user-keycloak.sh -r master -u admin -p admin >/dev/null 2>&1
                chown keycloak:keycloak $CKEYHOME/standalone/configuration/keycloak-add-user.json 
                echo 1 >  $CKEYHOME/signal/H2KCuser_flag
                echo "--keycloaking : [refresh:USER for $DBdriver] Done....."
            else 
                echo "--keycloaking : [refresh:USER for $DBdriver] exists,do nothing....."
            fi
        else
            DBKCuser_flag=`cat $CKEYHOME/signal/DBKCuser_flag`
            if [[ $DBKCuser_flag == 0  ]]; then
                echo "--keycloaking : [refresh:USER for $DBdriver] adding....."
                $CKEYHOME/bin/add-user-keycloak.sh -r master -u admin -p admin >/dev/null 2>&1
                chown keycloak:keycloak $CKEYHOME/standalone/configuration/keycloak-add-user.json 
                echo 1 >  $CKEYHOME/signal/DBKCuser_flag
                echo "--keycloaking : [refresh:USER for $DBdriver] Done...."
            else 
                echo "--keycloaking : [refresh:USER for $DBdriver] exists,do nothing....."
            fi
        fi
}
