
function cfgsudo
{
    #1.4---Support sudo
    test -e /etc/sudoers.d/keycloak.sudoers
    if [[ $? == 0 ]]; then
        echo "--keycloaking : [SUDO] file exists,do nothing......"
    else 
        echo "--keycloaking : [SUDO] configuring......"
        cp -p  $CKEYHOME/csf/config/keycloak.sudoers /etc/sudoers.d/keycloak.sudoers
        echo "--keycloaking : [SUDO] Done......"
    fi
}

