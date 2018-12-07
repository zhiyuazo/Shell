function usage
{
    cat << !EOF
    Usage: 
    $0 [options]                                                                                     
      +------------------------------------------------------------------------------------------------+
      | init      RUN after RPM installed .                                                            |
      |           Configurations:HTTPS,Firewall,Nokia-themes,systemd,EncryptDS,SUDO,MariaDB-Driver     |
      +------------------------------------------------------------------------------------------------+
      | master    RUN When you want to treat one node as keycloak-Master node.                         |
      |           Configurations:Read the parameters in /etc/keycloak.conf files                       |
      +------------------------------------------------------------------------------------------------+
      | slaver    RUN When you want to treat one node as keycloak-Slaver node.                         |
      |           Configurations:Read the parameters in /etc/keycloak.conf files                       |
      +------------------------------------------------------------------------------------------------+
      | status    RUN When you want to check the status of keycloak on current node.                   |
      |           Simply as "systemctl status keycloak"                                                |
      +------------------------------------------------------------------------------------------------+
      | stop      RUN When you want to stop keycloak domain processes                                  |
      |           Simply as "systemctl stop keycloak"                                                  |
      +------------------------------------------------------------------------------------------------+
      | reset     RUN When you want to clean all the configuration for keycloak on current node        |
      |           Clean: Recover the configuration file to ORG                                         |
      +------------------------------------------------------------------------------------------------+
      | enfire    RUN when you want to open  keycloak service in firewalld                             |          
      | unfire    RUN when you want to close keycloak service in firewalld                             |           
      +------------------------------------------------------------------------------------------------+
      | vault     RUN when you want to encrypt your password for keystore and datasourc                |
      |           ckeyadm vault genkey \$Alias4key \$Name4keystore                                        --+
      |           ckeyadm vault ckv    \$Name4keystore \$pwd4keystore \$Alias4key \$BlocakNAME \$AttributeNAME |                                    
      |           ckeyadm vault rmv    \$Name4keystore \$pwd4keystore \$Alias4key \$BlocakNAME \$AttributeNAME +-------------------------------------+    
      |           ckeyadm vault addv   \$Name4keystore \$pwd4keystore \$Alias4key \$SALTvault \$Iterovault \$DATA \$BlocakNAME \$AttributeNAME          |      
      +------------------------------------------------------------------------------------------------+----------------------------------------+
      | Author:       ZOU Zhiyuan <Zhiyuan.Zou@alcatel-lucent.com>.                                    |
      | Version:      For CSF-17.9                                                                     |
      +------------------------------------------------------------------------------------------------+
!EOF
}
