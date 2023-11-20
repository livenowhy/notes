## Django debug toolbar

  django 开中，用 django-debug-toolbar 来调试可以查看当前请求时间、sql执行时间、页面耗时、配置等信息

### django-debug-toolbar 的配置以及使用

    pip install django-debug-toolbar==3.1.1  (版本过高会导致升级 django 版本)

### 配置

    settings.py 添加以下配置:

    INSTALLED_APPS = [
        ...
        'django.contrib.staticfiles',
        ...
        'debug_toolbar',
        ...
    ]

    MIDDLEWARE = [
        'debug_toolbar.middleware.DebugToolbarMiddleware',  # 第一行
        ... 
    ]
    这个中间件尽可能配置到最前面，但是，必须要要放在处理编码和响应内容的中间件后面，比如要是使用了 GZipMiddleware，就要把 DebugToolbarMiddleware 放在 GZipMiddleware 后面

    ## 面板配置
    DEBUG_TOOLBAR_PANELS = [
        'debug_toolbar.panels.versions.VersionsPanel',
        'debug_toolbar.panels.timer.TimerPanel',
        'debug_toolbar.panels.settings.SettingsPanel',
        'debug_toolbar.panels.headers.HeadersPanel',
        'debug_toolbar.panels.request.RequestPanel',
        'debug_toolbar.panels.sql.SQLPanel',
        'debug_toolbar.panels.staticfiles.StaticFilesPanel',
        'debug_toolbar.panels.templates.TemplatesPanel',
        'debug_toolbar.panels.cache.CachePanel',
        'debug_toolbar.panels.signals.SignalsPanel',
        'debug_toolbar.panels.logging.LoggingPanel',
        'debug_toolbar.panels.redirects.RedirectsPanel',
        'debug_toolbar.panels.profiling.ProfilingPanel',
    ]

    调试工具栏只会允许特定的ip访问
    INTERNAL_IPS = [
        # ...
        '127.0.0.1',
        # ...
    ]
    

### 配置 URL

    urls.py 添加以下配置:

    import debug_toolbar

    urlpatterns = [
        path('__debug__/', include(debug_toolbar.urls)),
        ...
    ]

### 面板功能
    Versions: 代表是哪个django版本
    Timer: 用来计时的，判断加载当前页面总共花的时间
    Settings: 读取django中的配置信息
    Headers: 当前请求头和响应头信息
    Request: 当前请求的相关信息（视图函数，Cookie信息，Session信息等）
    SQL: 查看当前界面执行的SQL语句
    StaticFiles: 当前界面加载的静态文件
    Templates: 当前界面用的模板
    Cache: 缓存信息
    Signals: 信号
    Logging: 当前界面日志信息
    Redirects: 当前界面的重定向信息

### 使用

  配置完成后重启启动服务器，每个页面都会添加一个调试侧边栏显示相关信息