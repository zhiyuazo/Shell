
function clsfirewall
{
    #1.7---Firewalld support
    systemctl status firewalld >/dev/null 2>&1
    if [[ $? == 0 ]]; then
        for i in `cat /etc/keycloak.conf |grep -v ^# |grep port`
        do
            port=`echo $i |cut -d ":" -f 2`
            firewall-cmd --query-port  $port/tcp >/dev/null 2>&1
            if [[ $? == 0 ]]; then
                echo "--keycloaking : [RM :$port] exist,rming....."
                firewall-cmd --remove-port=$port/tcp --permanent >/dev/null 2>&1 
                fire_flag=1
            else
                echo "--keycloaking : [RM :$port] not exist,do nothing....."
            fi
        done
        if [[ $fire_flag == 1 ]]; then
            systemctl restart firewalld
            unset fire_flag
        fi
    else 
        if [[ -f /usr/bin/firewall-offline-cmd ]]; then
            for i in `cat /etc/keycloak.conf |grep -v ^# |grep port`
            do
                port=`echo $i |cut -d ":" -f 2`
                firewall-offline-cmd --query-port  $port/tcp >/dev/null 2>&1
                if [[ $? == 0 ]]; then
                    echo "--keycloaking : [RM :$port] exist,rming....."
                    firewall-offline-cmd --remove-port=$port/tcp  >/dev/null 2>&1  
                else
                    echo "--keycloaking : [RM :$port] not exist,do nothing....."
                fi
            done
        else 
            echo "--keycloaking : [RM :Firewall] no OFFLINE CMD,do nothing......"
        fi

    fi
} 
