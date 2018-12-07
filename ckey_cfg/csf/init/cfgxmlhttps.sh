#!/bin/bash  

function cfgxmlhttps
{
    #Part.2:--init configure standalone.xml
    cat $CFGXML |grep  'KChttpsRealm' >/dev/null 2>&1
    if [[ $? == 0  ]]; then
        echo "--keycloaking : [HTTPS] already configured,Do nothing....."
    else 
        # echo "--keycloaking : [HTTPS] for JBOSS configuring....."
        # index=`cat $CFGXML |grep -n 'name="ManagementRealm"'|cut -d ":" -f 1`
         # sed -i "${index}a  <!-- add https for jbossManagement-->\\
                # <server-identities>\\
                    # <ssl> \\
                        # <keystore path=\"keycloak.server.jks\" relative-to=\"jboss.server.config.dir\" keystore-password=\"keycloak\"/>\\
                    # </ssl>\\
                # </server-identities> " $CFGXML
         
         # index=`cat $CFGXML  |grep -n 'http="management-http"'|cut -d ":" -f 1`
         # sed -i "${index}c  <socket-binding https=\"management-https\"/>" $CFGXML
        # echo "--keycloaking : [HTTPS] for JBOSS Done....."
#---------------------------------------------------------------------------------------------------------
        HTTPS=`cat /etc/keycloak.conf |grep -v ^# |grep HTTPS`
        JKS=`echo $HTTPS |cut -d ":" -f 2`
        JKSpassAttr=`echo $HTTPS |cut -d ":" -f 3`
        KEY=`echo $HTTPS |cut -d ":" -f 4`
        KEYpassAttr=`echo $HTTPS |cut -d ":" -f 5`

        echo "--keycloaking : [HTTPS] for KEYCLOAK configuring....."
        index=`cat $CFGXML  |grep -n "</security-realms>" |cut -d ":" -f 1`
        index=($index)
        sed -i "${index[0]}i <!--add https of keycloak-->\\
            <security-realm name=\"KChttpsRealm\">\\
                <server-identities>\\
                    <ssl>\\
                        <keystore path=\"security/ssl/$JKS\" relative-to=\"jboss.home.dir\" keystore-password=\"\${VAULT::keystore::$JKSpassAttr::1}\" alias=\"$KEY\" key-password=\"\${VAULT::keystore::$KEYpassAttr::1}\"/>\\
                    </ssl>\\
                </server-identities>\\
            </security-realm> " $CFGXML
         
         index=`cat $CFGXML |grep -n 'name="default-host"' |cut -d ":" -f 1`
         sed -i "${index}i \\
                <https-listener name=\"https\" socket-binding=\"https\" security-realm=\"KChttpsRealm\"/>" $CFGXML
        echo "--keycloaking : [HTTPS] for KEYCLOAK Done....."
    fi
}


