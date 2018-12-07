#!/bin/bash  
#

function refreshsvc
{
    #--Modify the standalone.xml
    M_info=`cat /etc/keycloak.conf |grep -v ^# |grep MASTERInstance`
    S_info=`cat /etc/keycloak.conf |grep -v ^# |grep SLAVERInstance`
    #------------------------------------------------------------------
    M_KCs=`echo $M_info |cut -d ":" -f 2`
    M_Delta=`echo $M_info |cut -d ":" -f 3`
    S_KCs=`echo $S_info |cut -d ":" -f 2`
    S_Delta=`echo $S_info |cut -d ":" -f 3`
    SUM_KCs=$((M_KCs + S_KCs))
    
    #---------------------------------------------------------------------------
    if [[ $1 == 'master' ]]; then
        #---------------------------------------------------------------------------------------------------
        echo "--keycloaking : [refresh:SVC:Master] configuring....."
        C_M_KCs=`cat $CFGMasterXML  |grep "<server name" |wc -l`
        if [[ $C_M_KCs -eq $M_KCs  ]]; then
            :
        elif [[ $C_M_KCs -gt $M_KCs ]]; then
                for (( i = $C_M_KCs; i > $M_KCs; i-- ))
                do
                    index=`cat $CFGMasterXML  |grep -n "server-$i"|cut -d ":" -f 1`
                    indey=$((index + 2))
                    sed -i "${index},${indey}d"  $CFGMasterXML
                done
        else
            for i in `seq 1 $M_KCs`
            do
                Delta=0
                tmp=`cat $CFGMasterXML  |grep "server-$i"`
                if [[ $tmp == "" ]]; then
                    if [[ $i -eq 1 ]]; then
                        Delta=0
                    else
                        diff=$((i - 1))
                        for (( j = 0; j < $diff; j++ ))
                        do
                            Delta=$((Delta + M_Delta))
                        done
                    fi
                    index=`cat $CFGMasterXML |grep -n '</servers>'|cut -d ":" -f 1`
                    sed -i "${index}i \\
                        <server name=\"server-$i\" group=\"auth-server-group\" auto-start=\"true\">\\
                            <socket-bindings port-offset=\"$Delta\"/>\\
                        </server> " $CFGMasterXML
                fi
            done
        fi
        echo "--keycloaking : [refresh:SVC:Master] Done....."
        #---------------------------------------------------------------------------------------------------
    elif [[ $1 == 'slaver' ]]; then
        #---------------------------------------------------------------------------------------------------
        echo "--keycloaking : [refresh:SVC:Slaver] configuring....."
        C_S_KCs=`cat $CFGSlaverXML  |grep "<server name" |wc -l`
        if [[ $C_S_KCs -eq $S_KCs  ]]; then
            :
        elif [[ $C_S_KCs -gt $S_KCs ]]; then
                for (( i = $C_S_KCs; i > $S_KCs; i-- ))
                do
                    index=`cat $CFGSlaverXML  |grep -n "server-$i"|cut -d ":" -f 1`
                    indey=$((index + 2))
                    sed -i "${index},${indey}d"  $CFGSlaverXML
                done
        else
            for i in `seq 1 $S_KCs`
            do
                Delta=0
                tmp=`cat $CFGSlaverXML  |grep "server-$i"`
                if [[ $tmp == "" ]]; then
                    if [[ $i -eq 1 ]]; then
                        Delta=0
                    else
                        diff=$((i - 1))
                        for (( j = 0; j < $diff; j++ ))
                        do
                            Delta=$((Delta + S_Delta))
                        done
                    fi
                    index=`cat $CFGSlaverXML |grep -n '</servers>'|cut -d ":" -f 1`
                    sed -i "${index}i \\
                        <server name=\"server-$i\" group=\"auth-server-group\" auto-start=\"true\">\\
                            <socket-bindings port-offset=\"$Delta\"/>\\
                        </server> " $CFGSlaverXML
                fi
            done
        fi
        echo "--keycloaking : [refresh:SVC:Slaver] Done....."
        #---------------------------------------------------------------------------------------------------
    else 
        echo "--keycloaking : [FAILED in refreshsvc!]....."
        exit 1
    fi
}
