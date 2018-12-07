#!/bin/bash


function USAGE {
    echo "USAGE:-----------------------------------------------"
    echo "$0 -s cacert  : -s is optional, if HTTPs enabled,must follow below sequence.. "
    echo -e "\t\t\t\t   -s ca.crt : this must be the first -s option "
    echo -e "\t\t\t\t   -s ca.crt -s client.crt :this will report error "
    echo -e "\t\t\t\t   -s ca.crt -s client.crt -s client-private-key :this used when dual-SSL.. "
    echo "$0 -a options : options in [start,stop,status,reload,regenerate].. "
    echo -e "\t\t\t\t   -a start "
    echo -e "\t\t\t\t   -a stop "
    echo -e "\t\t\t\t   -a reload "
    echo -e "\t\t\t\t   -a status "
    echo -e "\t\t\t\t   -a regenerate 30m 2018-11-19T12:00:00.000Z" 
    echo "$0 -o        : -o Request token from CKEY,then access 3gppxml with TOKEN.."
    echo -e "\t\t\t\t   -o nossl : Request Token with HTTP from CKEY "
    echo -e "\t\t\t\t   -o ckey.crt :Request Token with HTTPS from CKEY,via CKEY certificate" 
    echo "$0 -h        : Invoke this HELP doc.. "
    echo "END:-----------------------------------------------"
    exit
}


#Below parameters is for connect to 3gppxml-RESTful 
gpp_addr="135.1.237.194"
certs="null"
action="null"
TKN="null"
while  getopts "o:,s:a:t:h" opts ;do
    case $opts in
        s)
            if [[ $certs == "null" ]]; then
                certs=""
                certs=$certs$OPTARG
            else
                certs=$certs" "$OPTARG
            fi
            ;;
        a)
            action=$OPTARG
            ;;
        o)
            #Below parameter is for CKEY authentication
            if [[ $OPTARG == "nossl" ]]; then
                ckey_addr="http://135.1.237.202:8665"
                ckey_cert=""
            else
                ckey_addr="https://135.1.237.202:8666"
                ckey_cert="--cacert $OPTARG" 
            fi
            realm="3gppxml"
            client="3gppxml"
            user="zhiyuan"
            password="zhiyuan"
            echo "option [-o] provided, request token from CKEY--->[$ckey_addr/auth/realms/$realm/protocol/openid-connect/token]"
            TKN=$(curl $ckey_cert -d "client_id=$client" -d "username=$user" -d "password=$password" -d "grant_type=password" $ckey_addr/auth/realms/$realm/protocol/openid-connect/token | sed 's/.*access_token":"//g' | sed 's/".*//g')
            ;;
        h)
            USAGE
            ;;
        \?)
            USAGE
            ;;
    esac
done

shift $(( $OPTIND-1))


if [[ $certs == "null" ]]; then
    ca_opt=""
    gpp_addr=http://$gpp_addr:8080
else
    ca_data=($certs)
    if [[ ${#ca_data[@]} == 1 ]]; then
        ca_opt="--cacert ${ca_data[0]}"
    elif [[ ${#ca_data[@]} == 2 ]]; then
        USAGE
    elif [[ ${#ca_data[@]} == 3 ]]; then
        ca_opt="--cacert ${ca_data[0]} --cert ${ca_data[1]} --key ${ca_data[2]}"
    fi
    gpp_addr=https://$gpp_addr:8081
fi

if [[ $TKN == "null" ]]; then
    header_opt=""
else
    header_opt="-H \"Authorization: $TKN\""
fi
echo "--------Connect to RESTful for gen3gppxml tool at $gpp_addr"

case $action in
    status)
            cmd="curl  -X GET --header 'Accept: application/json' $ca_opt $header_opt  $gpp_addr/v1/measurement/status"
            echo "Execute: $cmd" 
            echo "-------------------------------------------------------------------------------------------------------------------------------------------------------------" 
            eval $cmd
        ;;
    start)
            cmd="curl  -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' $ca_opt $header_opt  $gpp_addr/v1/measurement/start"    
            echo "Execute: $cmd" 
            echo "-------------------------------------------------------------------------------------------------------------------------------------------------------------" 
            eval $cmd
        ;;
    stop)
            cmd="curl  -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' $ca_opt $header_opt  $gpp_addr/v1/measurement/stop"    
            echo "Execute: $cmd" 
            echo "-------------------------------------------------------------------------------------------------------------------------------------------------------------" 
            eval $cmd
        ;;
    reload)
            cmd="curl  -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' $ca_opt $header_opt  $gpp_addr/v1/configuration/reload"
            echo "Execute: $cmd" 
            echo "-------------------------------------------------------------------------------------------------------------------------------------------------------------" 
            eval $cmd
        ;;
    regenerate)
        data=($*)
        range=${data[0]}
        end=${data[1]}
        cmd="curl  -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' $ca_opt $header_opt  $gpp_addr/v1/measurement/regenerate?range=$range\&end=$end"
        echo "Execute: $cmd" 
        echo "-------------------------------------------------------------------------------------------------------------------------------------------------------------" 
        eval $cmd
        ;;
    *)
        USAGE
        ;;
esac

exit 0




