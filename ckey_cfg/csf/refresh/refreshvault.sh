#!/bin/bash  
#

function refreshvault
{
    #--Modify the standalone.xml
    echo "--keycloaking : [refresh:VAULT] configuring....."
    VAULT=`cat /etc/keycloak.conf |grep -v ^# |grep VAULT`
    Name=`echo $VAULT |cut -d ":" -f 2`
    Password=`echo $VAULT |cut -d ":" -f 3`
    Alias=`echo $VAULT |cut -d ":" -f 4`
    Salt=`echo $VAULT |cut -d ":" -f 5`
    Itera=`echo $VAULT |cut -d ":" -f 6`

    index=`cat $CFGXML |grep -n 'name="KEYSTORE_URL"'|cut -d ":" -f 1`
    sed -i "${index}c \\
            <vault-option name=\"KEYSTORE_URL\" value=\"/opt/keycloak/security/vault/$Name\"/> " $CFGXML

    index=`cat $CFGXML |grep -n 'name="KEYSTORE_PASSWORD"'|cut -d ":" -f 1`
    sed -i "${index}c \\
            <vault-option name=\"KEYSTORE_PASSWORD\" value=\"$Password\"/> " $CFGXML

    index=`cat $CFGXML |grep -n 'name="KEYSTORE_ALIAS"'|cut -d ":" -f 1`
    sed -i "${index}c \\
            <vault-option name=\"KEYSTORE_ALIAS\" value=\"$Alias\"/> " $CFGXML
    
    index=`cat $CFGXML |grep -n 'name="SALT"'|cut -d ":" -f 1`
    sed -i "${index}c \\
            <vault-option name=\"SALT\" value=\"$Salt\"/> " $CFGXML
    
    index=`cat $CFGXML |grep -n 'name="ITERATION_COUNT"'|cut -d ":" -f 1`
    sed -i "${index}c \\
            <vault-option name=\"ITERATION_COUNT\" value=\"$Itera\"/>" $CFGXML
    
    echo "--keycloaking : [refresh:VAULT] Done....."

}

