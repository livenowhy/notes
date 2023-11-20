# Django中authenticate和login模块
  
  Django 提供内置的视图(view)函数用于处理登录和退出,Django提供两个函数来执行 django.contrib.auth中的动作: authenticate() 和 login()

  认证给出的用户名和密码,使用 authenticate() 函数。
  它接受两个参数, 用户名 username 和 密码 password, 并在密码对给出的用户名合法的情况下返回一个 User 对象。 
  如果密码不合法，authenticate()返回None。

    from django.contrib import auth
    user = auth.authenticate(username='john', password='secret')
    if user is not None:
        print "Correct!"
    else:
        print "Invalid password."

## 登录和验证

  authenticate() 只是验证一个用户的证书而已。
  而要登录一个用户使用 login()。该函数接受一个 HttpRequest 对象和一个 User 对象作为参数并使用Django的会话（ session ）框架把用户的ID保存在该会话中。

  下面的例子演示了如何在一个视图中同时使用 authenticate() 和 login() 函数：

    from django.contrib import auth

    def login_view(request):
        username = request.POST.get('username', '')
        password = request.POST.get('password', '')
        user = auth.authenticate(username=username, password=password)
        if user is not None and user.is_active:
            # Correct password, and the user is marked "active"
            auth.login(request, user)
            # Redirect to a success page.
            return HttpResponseRedirect("/account/loggedin/")
        else:
            # Show an error page
        return HttpResponseRedirect("/account/invalid/")
  
  在这里，有个有意思的是user.is_active,用来判断用户名密码是否有效。

## 注销用户

  注销一个用户，在你的视图中使用 django.contrib.auth.logout()。 
  它接受一个 HttpRequest 对象并且没有返回值,所以 因为没有返回值，需要返回一个页面。

    from django.contrib import auth

    def logout_view(request):
        auth.logout(request)
        # Redirect to a success page.
        return HttpResponseRedirect("/account/loggedout/")

  需要注意的是: 即使用户没有登录, logout() 也不会抛出任何异常。

## Django中常规登录和退出函数用法
  
  在实际中，你一般不需要自己写登录/登出的函数；认证系统提供了一系例视图用来处理登录和登出。 使用认证视图的第一步是把它们写在你的URLconf中。 你需要这样写：

    from django.contrib.auth.views import login, logout

    urlpatterns = patterns('',
        # existing patterns here...
        (r'^accounts/login/$', login),
        (r'^accounts/logout/$', logout),
    )
    /accounts/login/ 和 /accounts/logout/ 是Django提供的视图的默认URL。

## 登录页面的写法
    缺省情况下, login 视图渲染 registragiton/login.html 模板(可以通过视图的额外参数 template_name 修改这个模板名称)。这个表单必须包含 username 和 password 域。如下示例： 一个简单的 template 看起来是这样的

    {% extends "base.html" %}
    {% block content %}

    {% if form.errors %}
        <p class="error">Sorry, that's not a valid username or password</p>
    {% endif %}

        <form action="" method="post">
        <label for="username">User name:</label>
        <input type="text" name="username" value="" id="username">
        <label for="password">Password:</label>
        <input type="password" name="password" value="" id="password">

        <input type="submit" value="login" />
        <input type="hidden" name="next" value="{{ next|escape }}" />
        </form>

    {% endblock %}

   如果用户登录成功，缺省会重定向到 /accounts/profile. 你可以提供一个保存登录后重定向URL的next隐藏域来重载它的行为. 
   也可以把值以GET参数的形式发送给视图函数，它会以变量next的形式保存在上下文中，这样你就可以把它用在隐藏域上了。

  logout视图有一些不同。默认情况下它渲染 registration/logged_out.html 模板（这个视图一般包含你已经成功退出的信息）。视图中还可以包含一个参数 next_page 用于退出后重定向。