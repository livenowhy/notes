# Session

## session 和 cookie 的区别
  session 的底层是基于 cookie 技术来实现的，当用户打开浏览器，去访问服务器的时候，服务器会为每个用户的浏览器创建一个会话对象(session对象)，并且为每个session对象创建一个Jsessionid号。
  当session对象创建成功后，会以 cookie 的方式将这个 Jsessionid 号回写给浏览器，当用户再次进行访问服务器时，及带了具有 Jsessionid 号的 cookie 数据来一起访问服务器，服务器通过不同 session 的 Jsessionid 号来找出与其相关联的 session 对象，通过不同的 session 对象来为不同的用户服务.

  ![session](../imgaes/session.png)


## Django Session 使用及配置

    Django 中默认支持 Session，其内部提供了5种类型的 Session 供开发者使用:
    ·数据库(默认)
    ·缓存
    ·文件
    ·缓存 + 数据库
    ·加密cookie

### 数据库中的 Session

    Django 默认支持 Session，并且默认是将 Session 数据存储在数据库中,即: django_session 表中。
 
#### 配置 settings.py

    # 引擎（默认）
    SESSION_ENGINE = 'django.contrib.sessions.backends.db'   

    SESSION_COOKIE_NAME ＝ "sessionid"    # Session 的 cookie 保存在浏览器上时的key，即：sessionid＝随机字符串（默认）

    SESSION_COOKIE_PATH ＝ "/"            # Session 的 cookie 保存的路径(默认)
    SESSION_COOKIE_DOMAIN = None          # Session 的 cookie 保存的域名(默认)
    SESSION_COOKIE_SECURE = False         # 是否 Https 传输 cookie(默认)
    SESSION_COOKIE_HTTPONLY = True        # 是否 Session 的 cookie 只支持 http 传输(默认)

    SESSION_COOKIE_AGE = 1209600            # Session 的 cookie 失效日期(默认2周)
    SESSION_EXPIRE_AT_BROWSER_CLOSE = False # 是否关闭浏览器使得Session过期(默认)
    SESSION_SAVE_EVERY_REQUEST = False      # 是否每次请求都保存 Session，默认修改之后才保存(默认)
 
#### 使用

    def index(request):
        # 获取、设置、删除 Session 中数据
        request.session['k1']
        request.session.get('k1',None)
        request.session['k1'] = 123
        request.session.setdefault('k1',123) # 存在则不设置

        del request.session['k1']

        # 所有 键、值、键值对
        request.session.keys()
        request.session.values()
        request.session.items()
        request.session.iterkeys()
        request.session.itervalues()
        request.session.iteritems()


        # 用户 session 的随机字符串
        request.session.session_key

        # 将所有 Session 失效日期小于当前日期的数据删除
        request.session.clear_expired()

        # 检查用户 session 的随机字符串在数据库中是否
        request.session.exists("session_key")

        # 删除当前用户的所有 Session 数据
        request.session.delete("session_key")
        request.session.clear()

        request.session.set_expiry(value)
        * 如果 value 是个整数，session会在些秒数后失效。
        * 如果 value 是个datatime或timedelta，session就会在这个时间后失效。
        * 如果 value 是0,用户关闭浏览器session就会失效。
        * 如果 value 是None,session会依赖全局session失效策略。

### 缓存 Session

#### settings.py

    SESSION_ENGINE = 'django.contrib.sessions.backends.cache'    # 引擎
    
    # 使用的缓存别名（默认内存缓存，也可以是memcache），此处别名依赖缓存的设置
    SESSION_CACHE_ALIAS = 'default'

    # Session的cookie保存在浏览器上时的key，即：sessionid＝随机字符串
    SESSION_COOKIE_NAME ＝ "sessionid"

    SESSION_COOKIE_PATH ＝ "/"                # Session的cookie保存的路径
    SESSION_COOKIE_DOMAIN = None              # Session的cookie保存的域名
    SESSION_COOKIE_SECURE = False             # 是否Https传输cookie
    SESSION_COOKIE_HTTPONLY = True            # 是否Session的cookie只支持http传输
    SESSION_COOKIE_AGE = 1209600              #  Session的cookie失效日期（2周）
    SESSION_EXPIRE_AT_BROWSER_CLOSE = False   # 是否关闭浏览器使得Session过期
    SESSION_SAVE_EVERY_REQUEST = False        # 是否每次请求都保存Session，默认修改之后才保存


### 文件 Session 忽略

### 缓存 + 数据库 Session

  数据库用于做持久化，缓存用于提高效率
 
#### 配置 settings.py
 
    SESSION_ENGINE = 'django.contrib.sessions.backends.cached_db'    # 引擎


### 加密 Session

#### 配置 settings.py
    
    SESSION_ENGINE = 'django.contrib.sessions.backends.signed_cookies'   # 引擎
 

### cookie、session的工作机制
  cookie和session
  1、cookie:在网站中，http请求时无状态的，也就是说即使第一次和服务器连接后并且登录成功后，第二次请求服务器依然不能知道当前请求的是哪个用户（在中国我们因为IP地址不足就会在同一个局域网下使用同一个公网ip地址，如果在同一个时间段有多位用户访问同一个网站的话，该网站就不能识别到底是哪个用户发起的请求了）。而cookie就是为了解决这个问题出现的，第一次登录服务器之后返回一些数据（cookie）给浏览器，然后浏览器保存到本地，当用户再次发起请求的时候，就会自动携带上次请求存储的cookie信息给服务器，服务器通过浏览器携带的数据就能判断当前是哪个用户。cookie存储的数据有限，不同的浏览器有不同的存储大小，但一般不能超过4kb，因此，使用cookie只能存储一些小量的数据。
  2、session:session和cookie的作用相似，都是为了存储用户相关的信息。不同的是，cookie是存储在本地浏览器，session是一个思路，一个概念，一个服务器存储授权信息的解决方案，不同的服务器，不同的框架，不同的语言有不同的实现。虽然实现不一样，但是他们的目的都是服务器为了方便存储数据的。
  
  session的出现，是为了解决cookie存储数据不安全的问题的。

  3、cookie和session结合使用：web开发至今，cookie和session的使用
  已经出现了一些非常成熟的方式：一般有两种存储方式:
  1. 存储在服务端：通过cookie存储一个sessionid，然后具体的数据保存在session中，如果用户已经登录了，则服务器会在cookie中保存一个sessionid，下次再次请求服务器的时候，会把该sessionid携带上来，服务器根据sessionid在session库中获取用户的session数据，就能知道该用户到底是谁了，以及之前保存过的一些状态信息，这种专业术语叫做server side session。Django把session信息默认存储到数据库中，当然也可以存储到其他地方，比如缓存中，文件系统中等。存储在服务器中的数据会更加安全，不容易被窃取，但存储在服务器中也有一定的弊端，就是会占用服务器的资源，但现在服务器已经发展至今，一些session信息还是绰绰有余的。
  2. 将session数据加密，然后存储在cookie中，这种专业术语叫做client side session。flask 框架默认采用的就是这种方式，但是也可以替换成其他的形式。

## 2. 参考信息

    134.cookie、session的工作机制
    https://www.cnblogs.com/guyan-2020/p/12354646.html


### 操作cookie
#### 设置cookie
  设置 cookie 是设置值给浏览器的，因此我们可以通过 response 的对象来设置，可以通过 HttpResponse 的对象或者是 HttpResponseBase 的子类对象来设置，设置 cookie 可以通过 response.set_cookie 来设置，这个方法的相关参数如下:

    1. key：这个cookie的key。
    2. value:这个cookie的value。
    3. max_age:最长的生命期。单位是秒。

    #设置过期时间为两分钟过后
    response.set_cookie('username', 'guyan', max_age=120)

    4. expires:过期时间。
    跟max_age是类似的，只不过这个参数需要传递一个具体的日期，比如datetime 或者是符合日期格式的字符串，如果同时设置了expires和max_age，那么符合使用expires的值作为过期时间。
    
    from datetime import datetime
    from django.utils.timezone import make_aware

    # 设置过期时间 expires,datetime 类型或日期格式的字符串
    # date = datetime(year=2020,month=2, day=20, hour=0, minute=0, second=0)
    # 此时在浏览器中获取的时间为navie时间，可以使用make_aware转变为本时区的时间
    date = make_aware(datetime(year=2020,month=2, day=20, hour=0, minute=0, second=0))

    5. path: 对域名下哪个路径有效。
    默认是针对域名下的所有路径都有效。
    response.set_cookie('password', 'guyan', max_age=120, path='cms/')

    6. domain: 对哪个域名有效，默认情况下针对主域名下都有效，如果只要针对某个子域名才有效，那么可以设置这个属性。

    7. secure：是否是安全的，如果设置为True，那么只能在https协议下才能使用。
    response.set_cookie('password', 'guyan', max_age=120, path='cms/', secure=True)

    8. httponly：默认是False，如果为True，那么在客户端不能通过Javascript进行操作。

### 删除cookie
  通过 delete_cookie 即可删除 cookie，实际上删除 cookie 就是将指定的 cookie 的值设置为空的字符串，然后使用将他的过期时间设置为0，也就是浏览器关闭之后就过期。

    def delete_cookie(request):
        response = HttpResponse('delete cookie view')
        depwd = response.delete_cookie('password')
        print(depwd)   
        <!--打印出的结果为None-->
        return response
  
  在浏览器中查看cookie信息，可以看到名称为password的内容为空的字符串，并且创建时间和到期时间是相同的，也就是立即过期，这样就达到了删除cookie的效果。

### 获取cookie
  获取cookie可以通过request.COOKIES来获取，示例代码如下:

    def my_list(request):
        cookies = request.COOKIES
        cookie = cookies.get('username')
        print(cookie)
        return HttpResponse('mylist')

## 2. 参考信息

    135.在 django 中操作 cookie
    https://www.cnblogs.com/guyan-2020/p/12354646.html

## 在 Django 中操作 session

  在 django 中 session 默认情况下是存储在服务器的数据库中的，在表中会根据 sessionid 来提取指定的 session 数据，然后再把这个sessionid 放到 cookie 中发送给浏览器存储，浏览器下次在服务器发送请求的时候会自动的把所有的 cookie 信息发送给服务器，服务器再从 cookie 中获取 sessionid ，然后再从数据库中获取 session 数据。但是我们在操作 session 的时候，这写细节是不用纠结的，可以直接通过 request.session 即可操作。
  在views.py文件中示例代码如下:

    from django.http import HttpResponse

    def index(request):
        request.session['username'] = 'guyan'
        session = request.session.get('username')
        print(session)
        return HttpResponse('Success')

  在数据库中的 django_session 表中存储了 session_key (随机生成的标识 session 中存储的数据的唯一性 id，即主键), session_data (经过加密之后的数据), expire_date (过期时间)，这三项数据。
  在浏览器中查看cookie中是否有session_id，并且内容与数据库中的sessions_key的内容一样。
  session常用的方法如下:

    1. get: 用来从 session 中获取指定值。
    2. pop: 从 session 中删除一个值,并且将删除的值进行返回
    username = request.session.pop('username')
    3. keys: 从 session 中获取所有的键。
    4. items: 从 session 中获取所有的值。
    5. clear: 清除当前这个用户的 session 数据。
    request.session.clear()

    6. flush: 删除 session 并且删除在浏览器中存储的 session_id ,一般会在注销的时候用的比较多。
    request.session.flush()

    7. set_expiry(value): 设置过期时间。
    整形:代表的是秒数，设置多少秒之后过期。
    0:代表的是只要浏览器关闭session就过期。
    None:会使用全局的 session 配置。
    在 settings.py 中可以设置 SESSION_COOKIE_AGE 来配置全局的过期时间。默认是1209600秒，也就是2周的时间。
    request.session.set_expiry(None)

    8. clear_expired:清除过期的session。
    django 并不会清除过期的 session，需要定期的清理，或者是在终端，使用命令行 python manage.py clearsession 来清除过期的session。
    <!--首先设置一个过期的时间-->
    request.session.set_expiry(-1)

## 2. 参考信息

    137.在Django中操作session
    https://www.cnblogs.com/guyan-2020/p/12354662.html

## 修改session的存储机制
  
  默认情况下，session 数据时存储到数据库中，当然也可以将 session 数据存储到其他地方。可以通过设置 SESSION_ENGINE 来更改 session 的存储位置，这个可配置为以下几种方案:

    1.django.contrib.session.backends.db
    使用数据库，默认就是这种方案。
  
    2.django.contrib.sessions.backends.file
    使用文件来存储session

    3.django.contribsessions.backends.cache
    使用缓存来存储 session。想要将数据存储到缓存中，前提是你必须要在settings.py中已经配置好了CACHES,并且是需要使用Memcached，而不能使用纯内存作为缓存。
    
    4.django.contribsessions.backends.cached_db
    在存储数据的时候，会将数据先存到缓存中，再存到数据库中，这样就可以保证万一缓存系统出现问题，session数据也不会丢失，在获取数据的时候，会向从缓存中获取，如果缓存中没有，那么就会从数据库中获取。需要注意的是，这种情况下要配置memcached缓存和SESSION_ENGINE,示例代码如下

    # memcached settings
    CACHES = {
        'default': {
            'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
            'LOCATION': [
                '127.0.0.1:11211',
                '192.168.1.133:11211',
            ],
            'KEY_FUNCTION': lambda key, key_prefix, version: 'Django:' + key,
        }
    }

    # Location of Session_id, Session_data
    SESSION_ENGINE = 'django.contrib.sessions.backends.cached_db'

  这种情况下在cmd窗口通过 telnet 操作 memcached，查看是否存储到了缓存中，使用命令: stats items, 返回的结果:

    STAT items:1:number 1

  之后，查看缓存中items:1的具体信息，执行命令:
    
    stats cachedump 1 0

  返回的结果为:

    ITEM age [2 b; 1581842070 s]
    END 

  获得 age 的具体信息，执行命令：get age。
    get age
    VALUE age 16 2
    20
    END

    5.django.contrib.sessions.backends.signed_cookies
    将 session 信息加密后存储到浏览器的 cooki e中，这种方式要注意安全，建议设置 SESSION_COOKIE_HTTPONLY=True，那么在浏览器中不能通过js来操作session数据，并且还需要对 settings.py中的SECRET_KEY进行解密，因为一旦别人知道这个 SECRET_KEY,那么久可以进行解密，另外还有即使在cookie中，存储的数据不能超过4kb。

    # 将session信息加密后存储到浏览器的cookie中
    # SESSION_ENGINE = 'django.contrib.sessions.backends.signed_cookies'
    在这种情况下，只会将session信息加密后存储到浏览器中cookie中，而不会存储到数据库中。
    
## 2. 参考信息

    138.更改session的存储机制
    https://www.cnblogs.com/guyan-2020/p/12354667.html