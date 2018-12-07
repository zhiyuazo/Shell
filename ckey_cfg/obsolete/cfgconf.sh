
function cfgconf
{
    #1.4---Support sudo
    test -e /etc/keycloak.conf
    if [[ $? == 0 ]]; then
        echo "--keycloaking : [Keycloak.conf] file exists,do nothing......"
    else 
        echo "--keycloaking : [Keycloak.conf] configuring......"
        cp -p  $CKEYHOME/csf/config/keycloak.conf.example /etc/keycloak.conf
        echo "--keycloaking : [Keycloak.conf] Done......"
    fi


    test -e $CKEYHOME/standalone/configuration/control_keystore
    if [[ $? == 0 ]]; then
        echo "--keycloaking : [control_keystore] file exists,do nothing......"
    else 
        echo "--keycloaking : [control_keystore] configuring......"
        cp -p  $CKEYHOME/csf/config/control_keystore $CKEYHOME/standalone/configuration/
        echo "--keycloaking : [control_keystore] Done......"
    fi

}

