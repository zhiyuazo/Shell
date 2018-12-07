#!/bin/bash  
#


function addprivate
{
    echo "--keycloaking : [Master:Private Interface] configuring....."
    index=`cat $CFGMasterXML  |grep -n "</interfaces>" |cut -d ":" -f 1`
    sed -i "${index}i \\
        <interface name=\"private\">\\
            <inet-address value=\"\${jboss.bind.address.private:127.0.0.1}\"/>\\
        </interface> " $CFGMasterXML
    echo "--keycloaking : [Master:Private Interface] Done....."
   #--------------------------------------------------------------------- 
   #--------------------------------------------------------------------- 
    echo "--keycloaking : [Slave:Private Interface] configuring....."
    index=`cat $CFGSlaverXML  |grep -n "</interfaces>" |cut -d ":" -f 1`
    sed -i "${index}i \\
        <interface name=\"private\">\\
            <inet-address value=\"\${jboss.bind.address.private:127.0.0.1}\"/>\\
        </interface> " $CFGSlaverXML
    echo "--keycloaking : [Slave:Private Interface] Done....."
}

