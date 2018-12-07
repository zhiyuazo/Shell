function usage
{
    cat << !EOF
    Usage: 
    $0 [options]                                                                                     
      +------------------------------------------------------------------------------------------------+
      | init      RUN after RPM installed .                                                            |
      |           Configurations:HTTPS,Firewall,Nokia-themes,systemd,EncryptDS,SUDO,MariaDB-Driver     |
      +------------------------------------------------------------------------------------------------+
      | refresh   RUN after exec "systemctl start keycloak" .                                          |
      |           Configurations:Read the parameters in /etc/keycloak.conf files                       |
      +------------------------------------------------------------------------------------------------+
      | reset     RUN when you want to clean all configurations                                        |
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
