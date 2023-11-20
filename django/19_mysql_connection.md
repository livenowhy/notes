## too many connections错误

    在数据库中有一个参数 CONN_MAX_AGE， 它用来配置 Django 跟数据库的持久化连接。这一项的默认值是0，Django 中数据库连接的逻辑是，每一个请求结束都会关闭当前的数据库连接。这意味着每来一个新的请求， Django 都会创建一个新的数据库连接。
    
    当配置此项的值时，需要根据参考数据库的 wait_timeout 配置，建议不要大于 wait_timeout。
    此外此项还有 None。如果配置为 None，就意味着不限制连接时长。

    如果没有配置 CONN_MAX_AGE 就会出现数据库连接数太多，抛出 too many connections 错误的问题，原因就是上面所说的，所以当并发访问量过大来不及关闭连接时，会导致连接数不断增多。
    
    但是需要注意的是，如果你采用多线程的方式部署项目，最好不要配置 CONN_MAX_AGE。因为如果每一个请求都会使用一个新的线程来处理的，那么每个持久化的连接就达不到复用的目的。另外一个经验就是，如果使用gevent 作为worker来运行项目的话，那么也建议不配置 CONN_MAX_AGE。因为 gevent 会给 Python 的 thread（线程模块）动态打补丁（patch），这回导致数据库连接无法复用。


## 第三方程序调用django的models遇到的问题

    用python写了个守护进程调用django的models定时去查询数据库信息
    后来发现进程运行之后内存持续增长，怀疑是内存泄漏，于是google一下，发现了两个有用的库 gc 和 objgraph

    import gc
    import objgraph
    
    gc.collect()   # 强制进行垃圾回收

    # 打印出对象数目最多的 5 个类型信息
    objgraph.show_most_common_types(limit=5)


    调用django的orm查询部分，查库的游标没被释放引起的
    在每次定时查询完成后调用 reset_queries()释放连接
    from django.db import reset_queries
    reset_queries()
    close_old_connections()

## 查询执行SQL代码

    from django.db import connection 
    import gc
    print(connection.queries)
