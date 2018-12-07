#!/bin/bash  
#
function xmlencryptDS
{
         #2.2--.Encrypt password of DataSource
         cat $CFGXML |grep  'EncryptedPassword' >/dev/null 2>&1
         if [[ $? == 0 ]]; then
             echo "--keycloaking : [Security-Domain for DS] already in standalone.xml,Do nothing....."
         else 
             echo "--keycloaking : [Security-Domain for DS] configuring....."
             index=`cat $CFGXML  |grep -n "</security-domains>" |cut -d ":" -f 1`
             sed -i "${index}i <!--Encrypt password of keycloakDS -->\\
                    <security-domain name=\"EncryptedPassword\">\\
                        <authentication>\\
                            <login-module code=\"org.picketbox.datasource.security.SecureIdentityLoginModule\" flag=\"required\">\\
                                <module-option name=\"username\" value=\"sa\"/> \\
                                <module-option name=\"password\" value=\"9fdd42c2a7390d3\"/>\\
                                <module-option name=\"managedConnectionFactoryName\" value=\"jboss.jca:service=LocalTxCM,name=h2\"/>\\
                            </login-module> \\
                        </authentication> \\
                    </security-domain> " $CFGXML
             echo "--keycloaking : [Security-Domain for DS] configured Done....."
         fi
         
         #2.3--.Make default DS use Encrypt domain
        cat $CFGXML |grep  '<security-domain>EncryptedPassword</security-domain>' >/dev/null 2>&1
        if [[ $? == 0 ]]; then
             echo "--keycloaking : [DS Encrypted] already in standalone.xml,Do nothing....."
        else 
             echo "--keycloaking : [DS Encrypted] configuring....."
            index=`cat $CFGXML |grep -n 'pool-name=\"KeycloakDS\"'|cut -d ":" -f 1`
            indey=$((index + 7))
             sed -i "${index},${indey}c  <!-- Make default DS use Encrypt domain--> \\
                <datasource jndi-name=\"java:jboss/datasources/KeycloakDS\" pool-name=\"KeycloakDS\" enabled=\"true\" use-java-context=\"true\"> \\
                        <connection-url>jdbc:h2:\${jboss.server.data.dir}/keycloak;AUTO_SERVER=TRUE</connection-url>\\
                            <driver>h2</driver> \\
                            <security> \\
                                <security-domain>EncryptedPassword</security-domain> \\
                                <!-- Padding-->\\
                            </security> \\
                    </datasource> " $CFGXML
             echo "--keycloaking : [DS Encrypted] Done with H2 as default DS....."
        fi
} 
        
