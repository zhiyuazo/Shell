
function clstheme
{
    test -d $CKEYHOME/themes/NOKIA_CSF
    if [[ $? == 0  ]]; then
        echo "--keycloaking : [RM Theme] rming...."
        rm -rf $CKEYHOME/themes/NOKIA_CSF
        echo "--keycloaking : [RM Theme] Done...."
    else 
        echo "--keycloaking : [RM Theme] no file, do nothing...."
    fi
}

