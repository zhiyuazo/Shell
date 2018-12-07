#!/bin/bash  

function cfgslaverrealm
{
#---------------------------------------------------------------------------------------------------------
        echo "--keycloaking : [Slaver:Realm] for KEYCLOAK configuring....."
        index=`cat $CFGSlaverXML  |grep -n "</security-realms>" |cut -d ":" -f 1`
        index=($index)
        sed -i "${index[0]}i <!--add sercurity Realm of Slaver-->\\
            <security-realm name=\"SlaverRealm\">\\
                <server-identities>\\
                    <secret value=\"\${VAULT::slaver::default-password::1}\"/>\\
                </server-identities>\\
            </security-realm> " $CFGSlaverXML
         echo "--keycloaking : [Slaver:Realm] Done....."
}


