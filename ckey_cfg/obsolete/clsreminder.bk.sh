function clsreminderbk 
{
#add Some important reminder......
    cat <<!EOF 
|-------- Keycloak back to ORG:
|         +----------------------------------------------------------------------------+
|         | Make the XML configuration back to original                                | 
|    R    |      includes: HTTPS,Encrypt domain,Encrypt password,Datasource            |
|    E    +----------------------------------------------------------------------------+
|    M    | Please close the ports in firewalld manually                               |
|    I    |      Notes: "./ckey_admin unfire" will close the ports configured in       |
|    N    |                 /etc/keycloak.conf                                         |
|    D    +----------------------------------------------------------------------------+
|    E    Useful Links :
|    R    +--------------------------------------------------------------------------------------------+
|         | Keycloak Guide: https://confluence.app.alcatel-lucent.com/display/plateng/CKEY+-+Web+SSO   |
|-------- +--------------------------------------------------------------------------------------------+
!EOF
}


