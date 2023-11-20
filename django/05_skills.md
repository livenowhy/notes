## Django 获取 Header 中的信息

    request.META.get("header key") 用于获取header的信息

    注意的是header key必须增加前缀HTTP,同时大写,例如你的key为username,那么应该写成:
    request.META.get("HTTP_USERNAME")

    另外就是当你的header key中带有中横线,那么自动会被转成下划线,例如my-user的写成:
    request.META.get("HTTP_MY_USER")

    # 前端传入时 AccessToken 大写开头不能有下划线
    head_token = request.META.get("HTTP_ACCESSTOKEN")
    