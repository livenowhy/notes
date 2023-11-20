## cas 配置

`CAS_SERVER_URL [必须]`

    This is the only setting you must explicitly define. 
    Set it to the base URL of your CAS source (e.g. https://account.example.com/cas/).
    将其设置为 CAS 源的基本 URL

`CAS_ADMIN_PREFIX [可选的]`
    
    The URL prefix of the Django administration site. If undefined, the CAS middleware will check the view being rendered to see if it lives in django.contrib.admin.views.
    The default is None.

`CAS_CREATE_USER [可选的]`
    
    Create a user when the CAS authentication is successful.
    The default is True.

`CAS_CREATE_USER_WITH_ID [可选的]`
    
    Create a user using the id field provided by the attributes returned by the CAS provider. 
    Raises ImproperlyConfigured exception if attributes are not provided or do not contain the field id.
    The default is False.

`CAS_LOGIN_MSG [可选的]`
  
    Welcome message send via the messages framework upon successful authentication. Take the user login as formatting argument.

    You can disable it by setting this parameter to None
    The default is "Login succeeded. Welcome, %s." or some translation of it if you have enabled django internationalization (USE_I18N = True)

`CAS_LOGGED_MSG [可选的]`

    Welcome message send via the messages framework upon authentication attempt if the user is already authenticated. Take the user login as formatting argument.

    You can disable it by setting this parameter to None

    The default is "You are logged in as %s." or some translation of it if you have enabled django internationalization (USE_I18N = True)

`CAS_LOGIN_URL_NAME [可选的]`

    Name of the login url.

    This is only necessary if you use the middleware and want to use some other name for the login url (e.g. 'my_app:cas_login').

    The default is 'cas_ng_login'.

`CAS_LOGOUT_URL_NAME [可选的]`

    Name of the logout url.

    This is only necessary if you use the middleware and want to use some other name for the logout url (e.g. 'my_app:cas_logout').

    The default is 'cas_ng_logout'.

`CAS_EXTRA_LOGIN_PARAMS [可选的]`

    Extra URL parameters to add to the login URL when redirecting the user. Example:

`CAS_EXTRA_LOGIN_PARAMS = {'renew': true}`

    If you need these parameters to be dynamic, then we recommend to implement a wrapper for our default login view (the same can be done in case of the logout view). See an example in the section below.

    The default is None.

`CAS_RENEW [可选的]`

    Whether pass renew parameter on login and verification of ticket to enforce that the login is made with a fresh username and password verification in the CAS server.

    The default is False.

`CAS_IGNORE_REFERER [可选的]`

    If True, logging out of the application will always send the user to the URL specified by CAS_REDIRECT_URL.

    The default is False.

`CAS_LOGOUT_COMPLETELY [可选的]`

    If False, logging out of the application won’t log the user out of CAS as well.

    The default is True.

`CAS_REDIRECT_URL [可选的]`

    Where to send a user after logging in or out if there is no referrer and no next page set. This setting also accepts named URL patterns.

    The default is /.

`CAS_RETRY_LOGIN [可选的]`
    If True and an unknown or invalid ticket is received, the user is redirected back to the login page.

    The default is False.

`CAS_STORE_NEXT [可选的]`

    If True, the page to redirect to following login will be stored as a session variable, which can avoid encoding errors depending on the CAS implementation.

    The default is False.

`CAS_VERSION [可选的]`
    The CAS protocol version to use. The following version are supported:

    '1'

    '2'

    '3'

    'CAS_2_SAML_1_0'

    The default is '2'.

`CAS_USERNAME_ATTRIBUTE [可选的]`

    The CAS user name attribute from response. The default behaviour is to map the cas:user value to the django username. This attribute allows one to override this behaviour and map a different attribute to the username e.g. mail, cn or uid. This feature is not available when CAS_VERSION is 'CAS_2_SAML_1_0'. Note that the attribute is checked before CAS_RENAME_ATTRIBUTES is applied.

    The default is cas:user.

`CAS_PROXY_CALLBACK [可选的]`

    The full URL to the callback view if you want to retrieve a Proxy Granting Ticket.

    The defaults is None.

`CAS_ROOT_PROXIED_AS [可选的]`

    Useful if behind a proxy server. If host is listening on http://foo.bar:8080 but request is https://foo.bar:8443. Add CAS_ROOT_PROXIED_AS = ‘https://foo.bar:8443’ to your settings.

`CAS_FORCE_CHANGE_USERNAME_CASE [可选的]`

    If lower, usernames returned from CAS are lowercased before we check whether their account already exists. Allows user Joe to log in to CAS either as joe or JOE without duplicate accounts being created by Django (since Django allows case-sensitive duplicates). If upper, the submitted username will be uppercased.

    The default is False.

`CAS_APPLY_ATTRIBUTES_TO_USER [可选的]`

    If True any attributes returned by the CAS provider included in the ticket will be applied to the User model returned by authentication. This is useful if your provider is including details about the User which should be reflected in your model.

    The default is False.

`CAS_RENAME_ATTRIBUTES [可选的]`

    A dict used to rename the (key of the) attributes that the CAS server may retrun. For example, if CAS_RENAME_ATTRIBUTES = {'ln':'last_name'} the ln attribute returned by the cas server will be renamed as last_name. Used with CAS_APPLY_ATTRIBUTES_TO_USER = True, this provides an easy way to fill in Django Users’ info independently from the attributes’ keys returned by the CAS server.

`CAS_VERIFY_SSL_CERTIFICATE [可选的]`

    If False CAS server certificate won’t be verified. This is useful when using a CAS test server with a self-signed certificate in a development environment.

    Warning

    If CAS_VERIFY_SSL_CERTIFICATE is disabled (False), meaning that SSL certificates are not being verified by a certificate authority. This can expose your system to various attacks and should never be disabled in a production environment.

    The default is True.

`CAS_LOCAL_NAME_FIELD [可选的]`

    If set, will make user lookup against this field and not model’s natural key. This allows you to authenticate arbitrary users.

`CAS_FORCE_SSL_SERVICE_URL [可选的]`

    Available in 4.1.0.

    Force the service url to always target HTTPS by setting CAS_FORCE_SSL_SERVICE_URL to True.

    The default is False.

`CAS_CHECK_NEXT [可选的]`

    Available in 4.1.2.

    The URL provided by ?next is validated so that only local URLs are allowed. This check can be disabled by turning this setting to False (e.g. for local development).

    The default is True.

`CAS_SESSION_FACTORY [可选的]`

    Available in 4.2.2.

    Can be a callable that returns a requests.Session instance. This can be used to to change behaviors when doing HTTP requests via the underlying requests library, such as HTTP headers, proxies, hooks and more. See requests library documentation for more details.

    The default is None.

    Example usage:

    from requests import Session

    def cas_get_session():
        session = Session()
        session.proxies["https"] = "http://proxy.example.org:3128"
        return session

`CAS_SESSION_FACTORY = cas_get_session`

    URL dispatcher
    Make sure your project knows how to log users in and out by adding these to your URL mappings, noting the simplified URL routing syntax in Django 2.0 and later:
