#!/bin/bash  
#

function cfgtheme
{
    #1.6---Deploy Nokia themes
    test -d $CKEYHOME/themes/nokia_csf
    if [[ $? == 0 ]]; then
        echo "--keycloaking : [Nokia themes] is exist,do nothing....."
    else
        echo "--keycloaking : [Nokia themes] does not exist,copying Nokia theme files....."
        # cp -rp  $CKEYHOME/csf/config/NOKIA_CSF.tar  $CKEYHOME/themes/
        # tar -xvf $CKEYHOME/csf/config/NOKIA_CSF.tar  -C $CKEYHOME/themes/ >/dev/null 2>&1 
        # chown -R keycloak:keycloak  $CKEYHOME/themes/NOKIA_CSF
        # rm -rf $CKEYHOME/themes/NOKIA_CSF.tar 
        echo "--keycloaking : [Nokia themes] configure done!....."
    fi
}
