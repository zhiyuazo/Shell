<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "title">
        ${msg("loginTitle",(realm.displayName!''))}
    <#elseif section = "header">
    <div id="parent">
        <div id="pro-fam-name">
            ${msg("loginTitleHtml",(realm.displayNameHtml!''))} 
        </div>
        <div id="pro-des"> ${client.name!''} </div> 
        <div id="version"> ${client.description!''} </div>
    </div>
    <#elseif section = "side-div">
        <div id="kc-container">
            
        </div>
    <#elseif section = "form">
            <#if realm.password>
                <form id="kc-form-login" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
                    <div class="${properties.kcFormGroupClass!}">

                        <div  id ="user-placeholder" class="${properties.kcInputWrapperClass!}">
                            <#if usernameEditDisabled??> 
                                <input id="target1" id="username" id="lgn" class="${properties.kcInputClass!}" name="username" placeholder="Username" type="text" autofocus />
                            <#else>
                                <input id="target2" id="username" id="lgn" class="${properties.kcInputClass!}" name="username" placeholder="Username"  type="text" autofocus autocomplete="off" />
                            </#if>
                        </div>
                    </div>

                    <div class="${properties.kcFormGroupClass!}">
                        
                        <div class="${properties.kcInputWrapperClass!}">
                            <input id="login-password" class="${properties.kcInputClass!}" name="password" placeholder="Password" type="password" autocomplete="off" />
                        </div>
                    </div>

                    <div class="${properties.kcFormGroupClass!}">
                        
                        <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                            <#if realm.rememberMe && !usernameEditDisabled??> 
                                <div class="checkbox">
                                    <label>
                                        <#if login.rememberMe??>
                                            <input id="rememberMe" name="rememberMe" type="checkbox" tabindex="3" class="rememberMe" checked> 
                                            <div class="size">${msg("rememberMe")}</div>
                                        <#else>
                                            <input id="rememberMe" name="rememberMe" type="checkbox" tabindex="3" class="rememberMe" > <div class="size">${msg("rememberMe")}</div>
                                        </#if>
                                    </label>
                                </div>
                            </#if>

                            <div style="margin-right: 0px"class="${properties.kcFormOptionsWrapperClass!}">
                                <#if realm.resetPasswordAllowed>
                                    <span><a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                                </#if>
                            </div>
                        </div>

                        <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                            
                            <div class="${properties.kcFormButtonsWrapperClass!}">
                                <input id="sbtbtn" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                            </div>
                         </div>
                    </div>
                </form>
            </#if>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !usernameEditDisabled??>
            <div id="kc-registration" >
                <span id="new-register">${msg("noAccount")} <a href="${url.registrationUrl}">${msg("doRegister")}</a></span>
            </div>
        </#if>

        <#if realm.password && social.providers??>
            <div id="kc-social-providers">
                <ul>
                    <#list social.providers as p>
                        <li><a href="${p.loginUrl}" id="zocial-${p.alias}" class="zocial ${p.providerId}"> <span class="text">${p.displayName}</span></a></li>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
