#!/bin/bash  
#

function refreshslavername
{
    #---------------------------------------------------------------------------
        if [[ $1 == "" ]]; then
            echo "Need a unique slave name specified....."
            exit 1
        fi
        echo "--keycloaking : [refresh:slaver:name] configuring....."
        index=`cat $CFGSlaverXML |grep -n '<host'|cut -d ":" -f 1`
        sed -i "${index}c \\
    <host xmlns=\"urn:jboss:domain:4.0\" name=\"$1\">" $CFGSlaverXML
        echo "--keycloaking : [refresh:slaver:name] Done....."
}

