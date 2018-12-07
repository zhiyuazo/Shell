<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title><#nested "title"></title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <script type="text/javascript" src="${url.resourcesPath}/js/jquery.min.js" ></script>

    <script type="text/javascript">
       $(document).ready(function() {
            
            $(function() {
                var empty = false;
                
                function check_inputs() {
                    $('#sbtbtn').attr('disabled', 'disabled');

                    if ($('#target1').val() !==''&&
                    $('#target2').val() !== '') {
                        $('#sbtbtn').removeAttr('disabled');
                        empty = true;
                    } else {
                        $('#sbtbtn').attr('disabled', 'disabled');
                        empty = false;
                    }

                    if (empty === false) {
                     
                        $('form input[type=submit]').css({
                                                        'height': '36px',
                                                        'width': '378px',
                                                        'border-radius': '2px',
                                                        'background-color': 'rgba(79,79,79,0.26)',
                                                        'color':'rgba(0,0,0,0.26)'
                                                    });
                    } else {
                        $('form input[type=submit]').css({
                                                        'border': 'none',
                                                        'color': '#FFFFFF',
                                                        'font-size': '14px',
                                                        'font-weight': '500',
                                                        'margin-top': '20px',
                                                        'height': '36px',
                                                        'width': '378px',
                                                        'border-radius': '2px',
                                                        'background-color': '#124191'
                                                    });
                    }
                }

                $('form input[type=text], form input[type=password]').keyup(function() {
                    check_inputs();
                });
            });
        });
    </script>

</head>

<body id="bck-img" class="${properties.kcBodyClass!}">
    <div id="kc-logo"><a href="${properties.kcLogoLink!'#'}"><div id="kc-logo-wrapper"></div></a></div>

    <div id="kc-container" class="${properties.kcContainerClass!}">
        <div id="kc-container-wrapper" class="${properties.kcContainerWrapperClass!}">

            <div id="kc-header" class="${properties.kcHeaderClass!}">
            <div id="parent">
                <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!}"><#nested "header"></div>
            </div>
            </div>

            

            <div id="kc-content" class="parent-form" class="${properties.kcContentClass!}">
                <div class="child-form">
                    <div id="kc-content-wrapper" class="${properties.kcContentWrapperClass!}">

                        <#if displayMessage && message?has_content>
                            <div class="${properties.kcFeedbackAreaClass!}">
                                <div class="alert alert-${message.type}">
                                    <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                                    <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                                    <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                                    <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                                    <span class="kc-feedback-text"><img class="img-icon" src="${url.resourcesPath}/img/ic_error_red_24px.svg"/>${message.summary}</span>
                                </div>
                            </div>
                        </#if>
                        <div id="kc-form" class="${properties.kcFormAreaClass!}">
                            <div id="kc-form-wrapper" class="${properties.kcFormAreaWrapperClass!}">
                                <#nested "form">
                            </div>
                        </div>
                        <div id="lang">
                            <#if realm.internationalizationEnabled>
                                <div id="kc-locale" class="${properties.kcLocaleClass!}">
                                        <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                                   
                                            <div class="kc-dropdown" id="kc-locale-dropdown">
                                                <span class="drpdwn">Language:</span>
                                                <select id="kc-select-drpdwn">
                                                    <#list locale.supported as l>
                                                        <option class="kc-dropdown-item" value="${l.label}" <#if (l.label == locale.current)>
                                                        selected
                                                        </#if>>
                                                        <a href="${l.url}">${l.label}</a></option>
                                                    </#list>
                                                </select>
                                            </div>
                                        </div>
                                </div>
                            </#if>
                        </div>
                    </div>
                    <#if displayInfo>
                        <div id="kc-info" id="forget-password-text" class="${properties.kcInfoAreaClass!}">
                            <div id="kc-info-wrapper" id="forget-password-text" class="${properties.kcInfoAreaWrapperClass!}">
                                <#nested "info">
                            </div>
                        </div>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
</#macro>
