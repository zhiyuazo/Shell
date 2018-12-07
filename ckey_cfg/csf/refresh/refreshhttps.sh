#!/bin/bash  
#
function refreshhttps
{
    #--Modify the standalone.xml
    echo "--keycloaking : [refresh:HTTPS,JKS password] configuring....."
    HTTPS=`cat /etc/keycloak.conf |grep -v ^# |grep HTTPS`
    JKS=`echo $HTTPS |cut -d ":" -f 2`
    JKSpassAttr=`echo $HTTPS |cut -d ":" -f 3`
    KEY=`echo $HTTPS |cut -d ":" -f 4`
    KEYpassAttr=`echo $HTTPS |cut -d ":" -f 5`
   
    inde0=`cat $CFGXML |grep -n "<security.*KChttpsRealm" |cut -d ":" -f 1`
    index=`cat $CFGXML |grep -n "<keystore"|cut -d ":" -f 1`
    index=($index)
    if [[ ${#index[@]} == 0 ]]; then
        echo "--keycloaking : No Keystore item. Please ckeyadm init...."
        exit 1
    elif [[ ${#index[@]} == 1 ]]; then
        line=${index[0]}
    else
        len=`expr  ${#index[@]} - 1`
        tmp=100
        for i in `seq 0 $len`
        do
            if [[ ${index[$i]} -gt $inde0  ]]; then
                diff=`expr ${index[$i]} - $inde0`
                if [[ $diff -le $tmp ]]; then
                    tmp=$diff
                fi
            fi
            line=`expr $inde0 + $tmp` 
        done
    fi

    sed -i "${line}c \\
                        <keystore path=\"security/ssl/$JKS\" relative-to=\"jboss.home.dir\" keystore-password=\"\${VAULT::keystore::$JKSpassAttr::1}\" alias=\"$KEY\" key-password=\"\${VAULT::keystore::$KEYpassAttr::1}\"/>" $CFGXML
    
    echo "--keycloaking : [refresh:HTTPS,JKS password] Done....."
}

