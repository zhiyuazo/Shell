#!/bin/bash  
#

function refreshvault
{
    #--Modify the standalone.xml
    echo "--keycloaking : [refresh:VAULT:domain] configuring....."
    VAULT=`cat /etc/keycloak.conf |grep -v ^# |grep VAULT`
    Name=`echo $VAULT |cut -d ":" -f 2`
    Password=`echo $VAULT |cut -d ":" -f 3`
    Alias=`echo $VAULT |cut -d ":" -f 4`
    Salt=`echo $VAULT |cut -d ":" -f 5`
    Itera=`echo $VAULT |cut -d ":" -f 6`

    #---------------------------------------------------------------------------
    #---------------------------------------------------------------------------
    if [[ $1 == 'master' ]]; then
        echo "--keycloaking : [refresh:VAULT:Master] configuring....."
        index=`cat $CFGMasterXML |grep -n 'name="KEYSTORE_URL"'|cut -d ":" -f 1`
        sed -i "${index}c \\
                <vault-option name=\"KEYSTORE_URL\" value=\"/opt/keycloak/security/vault/$Name\"/> " $CFGMasterXML

        index=`cat $CFGMasterXML |grep -n 'name="KEYSTORE_PASSWORD"'|cut -d ":" -f 1`
        sed -i "${index}c \\
                <vault-option name=\"KEYSTORE_PASSWORD\" value=\"$Password\"/> " $CFGMasterXML

        index=`cat $CFGMasterXML |grep -n 'name="KEYSTORE_ALIAS"'|cut -d ":" -f 1`
        sed -i "${index}c \\
                <vault-option name=\"KEYSTORE_ALIAS\" value=\"$Alias\"/> " $CFGMasterXML
        
        index=`cat $CFGMasterXML |grep -n 'name="SALT"'|cut -d ":" -f 1`
        sed -i "${index}c \\
                <vault-option name=\"SALT\" value=\"$Salt\"/> " $CFGMasterXML
        
        index=`cat $CFGMasterXML |grep -n 'name="ITERATION_COUNT"'|cut -d ":" -f 1`
        sed -i "${index}c \\
                <vault-option name=\"ITERATION_COUNT\" value=\"$Itera\"/>" $CFGMasterXML
        
        echo "--keycloaking : [refresh:VAULT:Master] Done....."
    elif [[ $1 == 'slaver' ]]; then
        echo "--keycloaking : [refresh:VAULT:Slaver] configuring....."
        index=`cat $CFGSlaverXML |grep -n 'name="KEYSTORE_URL"'|cut -d ":" -f 1`
        sed -i "${index}c \\
                <vault-option name=\"KEYSTORE_URL\" value=\"/opt/keycloak/security/vault/$Name\"/> " $CFGSlaverXML

        index=`cat $CFGSlaverXML |grep -n 'name="KEYSTORE_PASSWORD"'|cut -d ":" -f 1`
        sed -i "${index}c \\
                <vault-option name=\"KEYSTORE_PASSWORD\" value=\"$Password\"/> " $CFGSlaverXML

        index=`cat $CFGSlaverXML |grep -n 'name="KEYSTORE_ALIAS"'|cut -d ":" -f 1`
        sed -i "${index}c \\
                <vault-option name=\"KEYSTORE_ALIAS\" value=\"$Alias\"/> " $CFGSlaverXML
        
        index=`cat $CFGSlaverXML |grep -n 'name="SALT"'|cut -d ":" -f 1`
        sed -i "${index}c \\
                <vault-option name=\"SALT\" value=\"$Salt\"/> " $CFGSlaverXML
        
        index=`cat $CFGSlaverXML |grep -n 'name="ITERATION_COUNT"'|cut -d ":" -f 1`
        sed -i "${index}c \\
                <vault-option name=\"ITERATION_COUNT\" value=\"$Itera\"/>" $CFGSlaverXML
        
        echo "--keycloaking : [refresh:VAULT:Slaver] Done....."
    else 
        echo "--keycloaking : [FAILED in refreshvault!]....."
        exit 1
    fi
}

