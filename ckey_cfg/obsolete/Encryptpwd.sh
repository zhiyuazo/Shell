
function Encryptpwd
{
    psswd=`java -cp $CKEYHOME/modules/system/layers/base/org/picketbox/main/picketbox-4.9.4.Final.jar  org.picketbox.datasource.security.SecureIdentityLoginModule $1`
    echo $psswd
}

