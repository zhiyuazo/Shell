#!/bin/bash  

function cfgvault
{
    #Part.2:--init configure standalone.xml
    cat $CFGXML |grep  'vault' >/dev/null 2>&1
    if [[ $? == 0  ]]; then
        echo "--keycloaking : [VAULT] already configured,Do nothing....."
    else 
        echo "--keycloaking : [VAULT] for KEYCLOAK configuring....."
        index=`cat $CFGXML |grep -n '</extensions>'|cut -d ":" -f 1`
         sed -i "${index}a  <!-- add vault for keycloak-->\\
        <vault> \\
            <vault-option name=\"KEYSTORE_URL\" value=\"/opt/keycloak/security/vault/vault.jks\"/> \\
            <vault-option name=\"KEYSTORE_PASSWORD\" value=\"MASK-1i9etX7oX375Tzdvf8l//F\"/> \\
            <vault-option name=\"KEYSTORE_ALIAS\" value=\"initseckey\"/> \\
            <vault-option name=\"SALT\" value=\"33550336\"/> \\
            <vault-option name=\"ITERATION_COUNT\" value=\"99\"/> \\
            <vault-option name=\"ENC_FILE_DIR\" value=\"/opt/keycloak/security/vault/\"/> \\
        </vault> " $CFGXML
        echo "--keycloaking : [VAULT] for KEYCLOAK Done....."
    fi
}

