#!/bin/bash  

function cfgxmlhttps
{
    #Part.2:--init configure standalone.xml
    cat $CFGMasterXML |grep  '<server-identities>' >/dev/null 2>&1
    if [[ $? == 0  ]]; then
        echo "--keycloaking : [HTTPS] already configured,Do nothing....."
    else 
        echo "--keycloaking : [HTTPS:Master] for KEYCLOAK configuring....."
        index=`cat $CFGMasterXML  |grep -n "</security-realms>" |cut -d ":" -f 1`
        index=($index)
        sed -i "${index[0]}i <!--add https of keycloak-->\\
            <security-realm name=\"KChttpsRealm\">\\
                <server-identities>\\
                    <ssl>\\
                        <keystore >\\
                    </ssl>\\
                </server-identities>\\
            </security-realm> " $CFGMasterXML
#---------------------------------------------------------------------------------------------------------
        echo "--keycloaking : [HTTPS:Slave] for KEYCLOAK configuring....."
        index=`cat $CFGSlaverXML  |grep -n "</security-realms>" |cut -d ":" -f 1`
        index=($index)
        sed -i "${index[0]}i <!--add https of keycloak-->\\
            <security-realm name=\"KChttpsRealm\">\\
                <server-identities>\\
                    <ssl>\\
                        <keystore >\\
                    </ssl>\\
                </server-identities>\\
            </security-realm> " $CFGSlaverXML
         
         echo "--keycloaking : [HTTPS:Domain] for KEYCLOAK configuring....."
         index=`cat $CFGXML |grep -n 'name="default-host"' |cut -d ":" -f 1`
         sed -i "${index}i \\
                <https-listener name=\"https\" socket-binding=\"https\" security-realm=\"KChttpsRealm\"/>" $CFGXML
        echo "--keycloaking : [HTTPS] Done....."
    fi
}


