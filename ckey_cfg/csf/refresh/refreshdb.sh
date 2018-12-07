
function refreshdb
{
    #external DB
    DBrequire=`cat /etc/keycloak.conf |grep -v ^# | grep  externalDB`
        DBtype=`echo $DBrequire |cut -d ":" -f 2`
    DBinfo=`cat /etc/keycloak.conf |grep -v ^# | grep  DBlink`
        DBdriver=`echo $DBinfo |cut -d ":" -f 2`
        DBname=`echo $DBinfo |cut -d ":" -f 3`
        DBaddr=`echo $DBinfo |cut -d ":" -f 4`
        DBport=`echo $DBinfo |cut -d ":" -f 5`
        DBuser=`echo $DBinfo |cut -d ":" -f 6`
        DBpassAttr=`echo $DBinfo |cut -d ":" -f 7`
        #DB DataSource in standalone.xml
    index=`cat $CFGXML |grep -n 'pool-name=\"KeycloakDS\"'|cut -d ":" -f 1`
    indey=$((index + 7))
    if [[ $DBtype  == 0 ]]; then
         echo "--keycloaking : [refresh:Use $DBdriver] configuring....."
         sed -i "${index},${indey}c \\
                <datasource jndi-name=\"java:jboss/datasources/KeycloakDS\" pool-name=\"KeycloakDS\" enabled=\"true\" use-java-context=\"true\"> \\
                    <connection-url>jdbc:$DBdriver:\${jboss.server.data.dir}/keycloak;AUTO_SERVER=TRUE</connection-url>\\
                        <driver>$DBdriver</driver> \\
                        <security> \\
                            <user-name>$DBuser</user-name> \\
                            <password>\${VAULT::datasource::$DBpassAttr::1}</password>\\
                        </security> \\
                </datasource> " $CFGXML
         echo "--keycloaking : [refresh:Use $DBdriver] Done....."
    else
         echo "--keycloaking : [refresh:Use $DBdriver] configuring....."
         sed -i "${index},${indey}c \\
                <datasource jndi-name=\"java:jboss/datasources/KeycloakDS\" pool-name=\"KeycloakDS\" enabled=\"true\" use-java-context=\"true\"> \\
                    <connection-url>jdbc:$DBdriver://$DBaddr:$DBport/$DBname</connection-url>\\
                        <driver>$DBdriver</driver> \\
                        <security> \\
                            <user-name>$DBuser</user-name> \\
                            <password>\${VAULT::datasource::$DBpassAttr::1}</password>\\
                        </security> \\
                </datasource> " $CFGXML
         echo "--keycloaking : [refresh:Use $DBdriver] Done....."
    fi
}
