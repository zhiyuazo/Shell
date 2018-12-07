#!/bin/bash  
#

function refreshlink2controller
{
    #---------------------------------------------------------------------------
        echo "--keycloaking : [refresh:slaver:linkuser] configuring....."
        info=`cat /etc/keycloak.conf |grep -v ^# |grep CONTROLLER`
            # address=`echo $info |cut -d ":" -f 2`
            name=`echo $info |cut -d ":" -f 2`
            password=`echo $info |cut -d ":" -f 3`
        index=`cat $CFGSlaverXML |grep -n '<remote'|cut -d ":" -f 1`
        sed -i "${index}c \\
        <remote  security-realm=\"SlaverRealm\" username=\"$name\">" $CFGSlaverXML
        echo "--keycloaking : [refresh:slaver:linkuser] Done....."
        #----------------------------------------------------------------
        echo "--keycloaking : [refresh:slaver:secret] configuring....."
        index=`cat $CFGSlaverXML |grep -n '<secret.*slaver'|cut -d ":" -f 1`
        sed -i "${index}c \\
                    <secret value=\"\${VAULT::slaver::$password::1}\"/>" $CFGSlaverXML
        echo "--keycloaking : [refresh:slaver:secret] Done....."
        #----------------------------------------------------------------
        # echo "--keycloaking : [refresh:slaver:CONTROLLER IP] configuring....."
        # index=`cat $CFGSlaverXML |grep -n '<static-discovery name=\"primary\"'|cut -d ":" -f 1`
        # sed -i "${index}c \\
                # <static-discovery name=\"primary\" protocol=\"\${jboss.domain.master.protocol:remote}\" host=\"\${jboss.domain.master.address:$address}\" port=\"\${jboss.domain.master.port:9999}\"/>" $CFGSlaverXML
        echo "--keycloaking : [refresh:slaver:CONTROLLER IP] Done....."
}

