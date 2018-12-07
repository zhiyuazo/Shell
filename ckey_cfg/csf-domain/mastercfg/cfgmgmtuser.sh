
function cfgmgmtuser
{
        #--add init user for Jboss manger 
        cat $CKEYHOME/domain/configuration/mgmt-users.properties |grep -v "^#" >/dev/null 2>&1
        if [[ $? == 0  ]]; then
            echo "--keycloaking : [extcfg:USER for MGMT] already exists,do nothing....."
        else
            echo "--keycloaking : [extcfg:USER for MGMT] creating....."
            $CKEYHOME/bin/add-user.sh -r ManagementRealm -u slaver -p slaver >/dev/null 2>&1
            echo "--keycloaking : [extcfg:USER for MGMT] Done....."
        fi
}


#user is slaver 
#password is slaver 
#add the secured password to XMl  
#<secret value="YWJjZGVmZw==" />
