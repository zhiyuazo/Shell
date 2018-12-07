#!/bin/bash  

function cfgvault
{
    cat $CFGMasterXML |grep  'vault-option' >/dev/null 2>&1
    if [[ $? == 0  ]]; then
        echo "--keycloaking : [VAULT Master] already configured,Do nothing....."
    else 
        echo "--keycloaking : [VAULT Master] for KEYCLOAK configuring....."
        index=`cat $CFGMasterXML |grep -n '</extensions>'|cut -d ":" -f 1`
         sed -i "${index}a  <!-- add vault for keycloak-->\\
        <vault> \\
            <vault-option name=\"KEYSTORE_URL\" value=\"/opt/keycloak/security/vault/vault.jks\"/> \\
            <vault-option name=\"KEYSTORE_PASSWORD\" value=\"MASK-1i9etX7oX375Tzdvf8l//F\"/> \\
            <vault-option name=\"KEYSTORE_ALIAS\" value=\"initseckey\"/> \\
            <vault-option name=\"SALT\" value=\"33550336\"/> \\
            <vault-option name=\"ITERATION_COUNT\" value=\"99\"/> \\
            <vault-option name=\"ENC_FILE_DIR\" value=\"/opt/keycloak/security/vault/\"/> \\
        </vault> " $CFGMasterXML
        echo "--keycloaking : [VAULT Master] for KEYCLOAK Done....."
    fi
#--------------------------------------------------------------------------------------------
    cat $CFGSlaverXML |grep  'vault-option' >/dev/null 2>&1
    if [[ $? == 0  ]]; then
        echo "--keycloaking : [VAULT Slaver] already configured,Do nothing....."
    else 
        echo "--keycloaking : [VAULT Slaver] for KEYCLOAK configuring....."
        index=`cat $CFGSlaverXML |grep -n '</extensions>'|cut -d ":" -f 1`
         sed -i "${index}a  <!-- add vault for keycloak-->\\
        <vault> \\
            <vault-option name=\"KEYSTORE_URL\" value=\"/opt/keycloak/security/vault/vault.jks\"/> \\
            <vault-option name=\"KEYSTORE_PASSWORD\" value=\"MASK-1i9etX7oX375Tzdvf8l//F\"/> \\
            <vault-option name=\"KEYSTORE_ALIAS\" value=\"initseckey\"/> \\
            <vault-option name=\"SALT\" value=\"33550336\"/> \\
            <vault-option name=\"ITERATION_COUNT\" value=\"99\"/> \\
            <vault-option name=\"ENC_FILE_DIR\" value=\"/opt/keycloak/security/vault/\"/> \\
        </vault> " $CFGSlaverXML
        echo "--keycloaking : [VAULT Slaver] for KEYCLOAK Done....."
    fi
}

