#!/bin/bash  
function jdbcdriver
{
        #2.4--.JDBC jar file prepare
        test -f $CKEYHOME/modules/system/layers/keycloak/org/mariadb/main/module.xml
        if [[ $? == 0 ]]; then
            echo "--keycloaking : [JDBC Driver] for MariaDB already exist,do nothing......"
        else 
            echo "--keycloaking : [JDBC Driver] for MariaDB Do not exist,Copying it......"
            mkdir -p $CKEYHOME/modules/system/layers/keycloak/org/mariadb/main
            cp -p $CKEYHOME/csf/config/mariadb-java-client-1.6.1.jar $CKEYHOME/modules/system/layers/keycloak/org/mariadb/main/mariadb-java-client-1.6.1.jar
            cat > $CKEYHOME/modules/system/layers/keycloak/org/mariadb/main/module.xml <<EOF
<?xml version="1.0" ?>
<module xmlns="urn:jboss:module:1.3" name="org.mariadb">
    <resources>
        <resource-root path="mariadb-java-client-1.6.1.jar"/>
    </resources>

    <dependencies>
        <module name="javax.api"/>
        <module name="javax.transaction.api"/>
    </dependencies>
</module>
EOF
        chown -R keycloak:keycloak $CKEYHOME/modules/system/layers/keycloak/org/mariadb/
            echo "--keycloaking : [JDBC Driver] for MariaDB configured Done......"
        fi
}
