
function clssudo
{
    ##SUDO UNconfig 
    test -e /etc/sudoers.d/keycloak.sudoers
    if [[ $? == 0 ]]; then
        echo "--keycloaking : [RM SUDO] rming...."
        rm -rf /etc/sudoers.d/keycloak.sudoers
        echo "--keycloaking : [RM SUDO] Done...."
    else 
        echo "--keycloaking : [RM SUDO] no file...."
    fi
    
}

