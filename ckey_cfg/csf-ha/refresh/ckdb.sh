
# function ckdb
# {
        # if [[ `which mysql 2>/dev/null` == "" ]]; then
            # echo "--keycloaking : there is no mysql on current machine,skip the MariaDB check phase..."
         # else
            # echo "show databases"|mysql -u $DBuser -p$DBpass  -P 3306 -h $DBaddr   |grep db4keycloak  >/dev/null 2>&1
            # if [[ $? == 0 ]]; then
                # echo "--keycloaking : MariDB on $DBaddr is OK and with database db4keycloak......"
            # else 
                # echo "--keycloaking : MariDB on $DBaddr is not OK!"
                # echo "--keycloaking :           Or                "
                # echo "--keycloaking : db4keycloak does not exist on MariDB....."
                # echo "--keycloaking : Please check the status of MariaDB or Create database named:\"db4keycloak\"....."
                # exit 1
            # fi
         # fi
# }
