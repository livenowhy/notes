## django的orm指定字段名 表名

1.指定字段名: 在定义字段的时候, 增加参数db_column=’real_field’;
2.指定表名: 在model的class中, 添加Meta类, 在Meta类中指定表名 db_table

例如在某个models.py文件中，有一个类叫Info:

    class Info(models.Model):  
        '''
        信息统计 
        '''  
        app_id = models.ForeignKey(App)  
        app_name = models.CharField(verbose_name='应用名',  max_length=32, db_column='app_name2')  

        class Meta:  
            db_table = 'info'  
            verbose_name = '信息统计'  
            verbose_name_plural = '信息统计'  


    其中 db_column 指定了对应的字段名, db_table 指定了对应的表明;

    如果不这样指定, 字段名默认为 app_name, 而表名默认为app名+类名: [app_name]_info
    
    verbose_name 指定在 admin 管理界面中显示中文, verbose_name 表示单数形式的显示;
    verbose_name_plural 表示复数形式的显示, 中文的单数和复数一般不作区别。
