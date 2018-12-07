
function clsconf
{
    echo "--keycloaking : [RM CONF],rming....."
    rm -fr /etc/keycloak.conf 
    echo "--keycloaking : [RM CONF,Done....."

    echo "--keycloaking : [RM CONF],rming....."
    rm -rf $CKEYHOME/standalone/configuration/control_keystore
    echo "--keycloaking : [RM CONF,Done....."
}

