## 在django中使用memcached

### 配置
  1.在 settings.py 文件中 DATABASES 变量下面配置 CACHES 缓存相关配置信息，只允许本机连接 memcached 就可以设置LOCATION 为: 127.0.0.1:11211。示例如下:

    CACHES = {
        'default': {
            'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
            'LOCATION': '127.0.0.1:11211'
        }
    }

  2. 如果想让多台机器都可以使用 memcached，就可以设置LOCATION为一个列表，包含多台机器的IP地址和端口号。

    'LOCATION': [
        '127.0.0.1:11211',
        '192.168.1.133:11211',
    ]

  3.在视图 views.py 中使用 cache 存储我们的数据，示例如下:

    from django.http import HttpResponse
    <!--导入模块-->
    from django.core.cache import cache

    def index(request):
        <!--设置数据-->
        cache.set('username','guyan', 120)
        <!--获取数据-->
        username = cache.get('username')
        print(username)
        return HttpResponse('memcached index')

  4.在 cmd 窗口查看 cache 中的items，执行命令:stats items,会显示出当前的 items_id,如果想要获取具体 items_id下的所有 key，就可以执行命令 stats cachedump 1 0，其中，这里的0代表的是获取所有的key。
  获取的结果如下:

    stats cachedump 1 0
    ITEM :1:username [5 b; 341429408 s]
    ITEM age [2 b; 1581842070 s]
    END
  
  这里获取的key值是已经经过处理的，为:1:username
  之后我们就可以通过get :1:username就可以获取我们当前的key的值value，结果如下:

    get :1:username
    VALUE :1:username 16 5
    guyan
    END
  
### 可是为什么key会在存储在memcached中的时候，会经过这种处理的方式呢？

  1. 因为我们在 views.py 文件中是直接在 cache 上调用了set()方法，所以即可来到 cache 中，查看 cache 中是否定义了 set()方法，结果我们发现:

    <!--此时的cache只是一个空壳类，并没有定义set()方法-->
    cache = DefaultCacheProxy()

  2. 之后，我们查看一下DefaultCacheProxy类中是否定义了set()方法，同样这个类中也没有定义set()方法，但是这个类中的所有方法都使用到了DEFAULT_CACHE_ALIAS，ctrl+b进行查看一下：
    
    DEFAULT_CACHE_ALIAS = 'default'

  3. 这里的default就是我们在settings.py文件中设置的CACHES中的default，因此如果我们想要了解set()方法的定义就可以查看
  
    django.core.cache.backends.memcached.MemcachedCache，
    CACHES = {
        'default': {
            'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
            'LOCATION': [
                '127.0.0.1:11211',
                '192.168.1.133:11211',
            ],
        }
    }

  4. 进入MemcachedCache中查看，
    
    class MemcachedCache(BaseMemcachedCache):

  5. 没有定义set()方法，但是继承了父类BaseMemcachedCache，在进入父类进行查看:

    def set(self, key, value, timeout=DEFAULT_TIMEOUT, version=None):
        key = self.make_key(key, version=version)
        if not self._cache.set(key, value, self.get_backend_timeout(timeout)):
            # make sure the key doesn't keep its old value in case of failure to set (memcached's 1MB limit)
            self._cache.delete(key)

  其中set()方法中涉及到的make_key()方法的定义如下:

    def make_key(self, key, version=None):
        if version is None:
            version = self.version

        return self.key_func(key, self.key_prefix, version)

  make_key()方法中涉及到的self.key_func为:

    self.key_func = get_key_func(params.get('KEY_FUNCTION'))

  这里面的params就可以认为是我们在settings.py文件中配置的CACHES

  set()方法中涉及到的version为

    self.version = params.get('VERSION', 1)

  在没有传入任何参数的时候，默认为1
  因此如果我们想要定义自己的set()方法对key进行一些特定的处理，就可以定义CACHES中的'KEY_FUNCTION'。示例代码如下:

    'KEY_FUNCTION': lambda key, key_prefix, version: 'Django:' + key,

这样的话，再次查看items的所有key，如下:

    <!--查看所有的key-->
    stats cachedump 1 0
    ITEM Django:username [5 b; 341431876 s]
    ITEM age [2 b; 1581842070 s]
    END

    <!--查看键所对应的值-->
    get Django:username
    VALUE Django:username 16 5
    guyan
    END
这样的话，以后就可以在Django中使用memcache了。并且，可以根据memcached自身的算法将获取的键值对信息存储到settings.py文件中配置的多个IP地址的服务器上，就可以实现高可用式分布存储，提高访问的效率。

## 2. 参考信息

    133.在django中使用memcached
    https://www.cnblogs.com/guyan-2020/p/12354637.html