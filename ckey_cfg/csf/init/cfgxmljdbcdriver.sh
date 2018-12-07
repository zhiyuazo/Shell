#!/bin/bash  
function cfgxmljdbcdriver
{
        #2.5--.DB Driver in standalone.xml
        cat $CFGXML |grep  '<driver name=\"mariadb\"' >/dev/null 2>&1
        if [[ $? == 0 ]]; then
            echo "--keycloaking : [MaridDB Driver] already in standalone.xml,Do nothing....." 
        else
            echo "--keycloaking : [MaridDB Driver] in XML....."
            index=`cat $CFGXML |grep -n '<drivers>'|cut -d ":" -f 1`
             sed -i "${index}a  <!--csf:add declaration of mariadb driver-->\\
                    <driver name=\"mariadb\" module=\"org.mariadb\"> \\
                        <xa-datasource-class>org.mariadb.Driver</xa-datasource-class>\\
                    </driver> " $CFGXML
            echo "--keycloaking : [MaridDB Driver] in XML Done....."
        fi
}
