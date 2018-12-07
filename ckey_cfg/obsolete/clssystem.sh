
function clssystem
{
    ##systemd UNconfig 
    test -e /usr/lib/systemd/system/keycloak.service
    if [[ $? == 0 ]]; then
        echo "--keycloaking : [RM systemd] rming......"
        rm -rf /usr/lib/systemd/system/keycloak.service
        systemctl daemon-reload
        echo "--keycloaking : [RM systemd] Done......"
    else 
        echo "--keycloaking : [RM systemd] No file......"
    fi
}

