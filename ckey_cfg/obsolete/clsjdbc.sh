
function clsjdbc
{
    test -d $CKEYHOME/modules/system/layers/keycloak/org/mariadb
    if [[ $? == 0  ]]; then
        echo "--keycloaking : [RM JDBC] rming...."
        rm -rf $CKEYHOME/modules/system/layers/keycloak/org/mariadb
        echo "--keycloaking : [RM JDBC] Done...."
    else 
        echo "--keycloaking : [RM JDBC] no fils,do nothing...."
    fi
}

