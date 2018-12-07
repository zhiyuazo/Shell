#!/bin/bash


function removexmlblock 
{
    # remove standalone profile
    X_standalone=`cat $CFGXML  |grep -n 'profile name=\"auth-server-standalone\"'|cut -d ":" -f 1`
    X_domain=`cat $CFGXML  |grep -n 'profile name=\"auth-server-clustered\"'|cut -d ":" -f 1`
    Y_standalone=$((X_domain - 1))
    sed -i "${X_standalone},${Y_standalone}d"  $CFGXML
    echo "--keycloaking : [RM standalone profile] Done...."
    # remove loadbalancer profile
    X_lb=`cat $CFGXML  |grep -n 'profile name=\"load-balancer\"'|cut -d ":" -f 1`
    X_profiles=`cat $CFGXML  |grep -n '</profiles>'|cut -d ":" -f 1`
    Y_lb=$((X_profiles - 1))
    sed -i "${X_lb},${Y_lb}d"  $CFGXML
    echo "--keycloaking : [RM LB profile] Done...."
    # remove loadbalancer profile

    # remove standalone ports
    X_port_standalone=`cat $CFGXML  |grep -n 'socket-binding-group name=\"standard-sockets\"'|cut -d ":" -f 1`
    X_port_domain=`cat $CFGXML  |grep -n 'socket-binding-group name=\"ha-sockets\"'|cut -d ":" -f 1`
    Y_port_standalone=$((X_port_domain - 1))
    sed -i "${X_port_standalone},${Y_port_standalone}d"  $CFGXML
    echo "--keycloaking : [RM standalone ports] Done...."

    # remove loadbalancer ports
    X_port_lb=`cat $CFGXML  |grep -n 'socket-binding-group name=\"load-balancer-sockets\"'|cut -d ":" -f 1`
    X_socket=`cat $CFGXML  |grep -n '</socket-binding-groups>'|cut -d ":" -f 1`
    Y_port_lb=$((X_socket - 1))
    sed -i "${X_port_lb},${Y_port_lb}d"  $CFGXML
    echo "--keycloaking : [RM LB ports] Done...."

    # remove loadbalancer server
    X_server_lb=`cat $CFGXML  |grep -n 'server-group name=\"load-balancer-group\"'|cut -d ":" -f 1`
    X_server_domain=`cat $CFGXML  |grep -n 'server-group name=\"auth-server-group\"'|cut -d ":" -f 1`
    Y_server_lb=$((X_server_domain - 1))
    sed -i "${X_server_lb},${Y_server_lb}d"  $CFGXML
    echo "--keycloaking : [RM LB server] Done...."


    # clean master
    X_server=`cat $CFGMasterXML  |grep -n '<servers>'|cut -d ":" -f 1`
    X_server=$((X_server + 1))
    Y_server=`cat $CFGMasterXML  |grep -n '</servers>'|cut -d ":" -f 1`
    Y_server=$((Y_server - 1))
    sed -i "${X_server},${Y_server}d"  $CFGMasterXML
    echo "--keycloaking : [RM Master servers] Done...."


    # clean  slaver
    X_server=`cat $CFGSlaverXML  |grep -n '<servers>'|cut -d ":" -f 1`
    X_server=$((X_server + 1))
    Y_server=`cat $CFGSlaverXML  |grep -n '</servers>'|cut -d ":" -f 1`
    Y_server=$((Y_server - 1))
    sed -i "${X_server},${Y_server}d"  $CFGSlaverXML
    echo "--keycloaking : [RM Slave servers] Done...."
}
