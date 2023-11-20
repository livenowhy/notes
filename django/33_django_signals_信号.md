## django Signals - 信号


### Signals 类的子类 (Django内置的常用信号)

    django.db.models.signals.pre_init    模型实例初始化前
    django.db.models.signals.post_init   模型实例初始化后
    django.db.models.signals.pre_save    模型保存前
    django.db.models.signals.post_save   模型保存后
    django.db.models.signals.pre_delete  模型删除前
    django.db.models.signals.post_delete 模型删除后
    django.db.models.signals.m2m_changed 多对多字段被修改
    django.core.signals.request_started  接收到 HTTP 请求
    django.core.signals.request_finished      HTTP 请求处理完毕
    所有的 Signals 都是 django.dispatch.Signal  的实例/子类

### 