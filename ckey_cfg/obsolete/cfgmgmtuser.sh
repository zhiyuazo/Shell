
function cfgmgmtuser
{
        #--add init user for Jboss manger 
        cat $CKEYHOME/standalone/configuration/mgmt-users.properties |grep -v "^#" >/dev/null 2>&1
        if [[ $? == 0  ]]; then
            echo "--keycloaking : [Jboss mgmt user] already exists,do nothing....."
        else
            echo "--keycloaking : [Jboss mgmt user] creating....."
            $CKEYHOME/bin/add-user.sh -r ManagementRealm -u admin -p admin >/dev/null 2>&1
            echo "--keycloaking : [Jboss mgmt user] Done....."
        fi
}
