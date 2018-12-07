function clsflag
{
    echo "--keycloaking : [RM Flag] rming...."  
    echo 0 > $CKEYHOME/csf/signal/DBKCuser_flag
    echo 0 > $CKEYHOME/csf/signal/H2KCuser_flag
    echo "--keycloaking : [RM Flag] Done...."  
}

