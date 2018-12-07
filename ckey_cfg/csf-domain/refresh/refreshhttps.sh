#!/bin/bash  
#
function refreshhttps
{
    #--Modify the standalone.xml
    HTTPS=`cat /etc/keycloak.conf |grep -v ^# |grep HTTPS`
    JKS=`echo $HTTPS |cut -d ":" -f 2`
    JKSpassAttr=`echo $HTTPS |cut -d ":" -f 3`
    KEY=`echo $HTTPS |cut -d ":" -f 4`
    KEYpassAttr=`echo $HTTPS |cut -d ":" -f 5`

    if [[ $1 == 'master' ]]; then
        echo "--keycloaking : [refresh:master:HTTPS] configuring....."
        inde0=`cat $CFGMasterXML | grep -n "<security.*KChttpsRealm" |cut -d ":" -f 1`
        index=`cat $CFGMasterXML | grep -n "<keystore" |cut -d ":" -f 1`
        index=($index)
        if [[ ${#index[@]} == 0  ]]; then
            echo "--keycloaking : No Keystore item. Please ckeyadm init...."
            exit 1
        elif [[ ${#index[@]} == 1  ]]; then
            line=${index[0]}
        else
            len=`expr  ${#index[@]} - 1`
            tmp=100
            for i in `seq 0 $len`
            do
                if [[ ${index[$i]} -gt $inde0   ]]; then
                    diff=`expr ${index[$i]} - $inde0`
                    if [[ $diff -le $tmp  ]]; then
                        tmp=$diff
                    fi
                fi
                line=`expr $inde0 + $tmp` 
            done
        fi
        sed -i "${line}c \\
                        <keystore path=\"security/ssl/$JKS\" relative-to=\"jboss.home.dir\" keystore-password=\"\${VAULT::keystore::$JKSpassAttr::1}\" alias=\"$KEY\" key-password=\"\${VAULT::keystore::$KEYpassAttr::1}\"/>" $CFGMasterXML
        echo "--keycloaking : [refresh:master:HTTPS] done....."

    elif [[ $1 == 'slaver' ]]; then
        echo "--keycloaking : [refresh:slaver:HTTPS] configuring....."
        inde0=`cat $CFGSlaverXML | grep -n "<security.*KChttpsRealm" |cut -d ":" -f 1`
        index=`cat $CFGSlaverXML | grep -n "<keystore" |cut -d ":" -f 1`
        index=($index)
        if [[ ${#index[@]} == 0  ]]; then
            echo "--keycloaking : No Keystore item. Please ckeyadm init...."
            exit 1
        elif [[ ${#index[@]} == 1  ]]; then
            line=${index[0]}
        else
            len=`expr  ${#index[@]} - 1`
            tmp=100
            for i in `seq 0 $len`
            do
                if [[ ${index[$i]} -gt $inde0   ]]; then
                    diff=`expr ${index[$i]} - $inde0`
                    if [[ $diff -le $tmp  ]]; then
                        tmp=$diff
                    fi
                fi
                line=`expr $inde0 + $tmp` 
            done
        fi
        sed -i "${line}c \\
                        <keystore path=\"security/ssl/$JKS\" relative-to=\"jboss.home.dir\" keystore-password=\"\${VAULT::keystore::$JKSpassAttr::1}\" alias=\"$KEY\" key-password=\"\${VAULT::keystore::$KEYpassAttr::1}\"/>" $CFGSlaverXML
        echo "--keycloaking : [refresh:slaver:HTTPS] done....."
    else 
        echo "--keycloaking : [FAILED in refreshhttps]...."
        exit 1

    fi    
    
}

