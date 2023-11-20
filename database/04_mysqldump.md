### mysqldump选项：

    命令行 描述
    –add-drop-database 在CREATE DATABASE前DROP DATABASE。
    –add-drop-table 在CREATE TABLE前DROP TABLE。
    –add-drop-trigger 在CREATE TRIGGER 前DROP TRIGGER。
    –add-locks 在INSERT前后分别加LOCK TABLES和UNLOCK TABLES。
    –all-databases 备份所有库中所有表。
    –allow-keywords 允许列名包含关键字。
    –apply-slave-statements 在CHANGE MASTER前加 STOP SLAVE在最后添加 START SLAVE。
    –bind-address=ip_address 对于有多个网络接口的机器选择使用指定的接口连接MySQL。
    –comments 为备份文件添加注释。
    –compact 禁用结构化注释及首尾结构体。开启–skip-add-drop-table、–skip-add-locks、–skip-comments、–skip-disable-keys、–skip-set-charset以产生更紧促的输出。
    –compatible=name[,name,…] 产生与其他数据库或者老版MySQL兼容的备份文件，可用的值有ansi, mysql323, mysql40, postgresql, Oracle, mssql, db2, maxdb, no_key_options, no_table_options, no_field_options。可同时使用多个以逗号分隔的值。
    –complete-insert 使用带有列名的完整INSERT。
    –create-options 在CREATE TABLE中使用MySQL特定的表选项。
    –databases 备份多个数据库，选项后跟多个库名。备份文件中会包含USE db_name。
    –debug[=debug_options] 写debug日志。
    –debug-check 程序退出时打印一些调试信息
    –debug-info 程序退出时打印一些有关cpu和memory的统计信息。
    –default-auth=plugin 指明要使用的客户端认证插件
    –default-character-set=charset_name 设置默认字符集
    –delayed-insert 使用INSERT DELAYED 而非INSERT。MySQL5.6.6中INSERT DELAYED已不被推荐使用，相应的该选项也将来未来的mysqldump中移除。
    –delete-master-logs 在master上备份后删除其二进制日志。该选项会自动激活—master-data选项。
    –disable-keys 对每个表在INSERT前后分别加/*!40000 ALTER TABLE articles DISABLE KEYS /和/!40000 ALTER TABLE articles ENABLE KEYS */。可使从备份文件恢复数据更快，因为索引在所有行插入后创建。仅对于MyISAM表的非唯一索引。
    –dump-date 若使用了—comments选项则会在末尾显示-- Dump completed on xxxxxx，以标记时间。
    –dump-slave[=value] 会在输出结果添加包含master二进制文件和位置信息的CHANGE MASTER语句。与—master-data选项类似，但用于复制slave以建立另外的与其同master的slave。会开启—lock-all-tables除非使用了—single-transaction。会在dump前停止slave的SQL thread在dump后开始该线程。可与–apply-slave-statements、–include-master-host-port结合使用。
    –events 为备份的数据库备份事件。
    –extended-insert 使用包含多个值列表的多行INSERT。
    –fields-enclosed-by=string 与—tab选项结合使用。指明输出文件中的filed以何种字符串enclosed，与 LOAD DATA INFILE对应的选项意义相同。
    –fields-escaped-by 同上
    –fields-optionally-enclosed-by=string 同上
    –fields-terminated-by=string 同上
    –flush-logs 在备份前刷新MySQL日志。需RELOAD权限。若同时备份多个数据库,如使用—all-database或—database，则对于每个备份的数据库都会刷新一次日志，除非使用了—master-data或—lock-all-tables，此时日志仅在锁定表时刷新一次。若想让备份和刷新日志同时进行需结合使用—lock-all-tables或—master-data。
    –flush-privileges 在备份了mysql这个数据库后发出FLUSH PRIVILEGES语句。本分mysql库或依赖mysql库中数据的库时需使用。
    –help 显示帮助信息
    –hex-blob 将二进制列，如，BINARY,VARBINARY,BLOB,BIT备份为十六进制形式。
    –host 要连接的主机
    –ignore-table=db_name.tbl_name 指明不备份的表
    –include-master-host-port 使用了–dump-slave时在CHANGE MASTER语句中加入MASTER_HOST和MASTER_PORT。
    –insert-ignore 用INSERT IGNORE 而非INSERT ，以忽略重复的数据。
    –lines-terminated-by=string 与—tab选项结合使用。与LOAD DATA INFILE的LINE意义相同。指明行由何种字符串terminated。
    –lock-all-tables 通过在备份期前加read lock锁定所有库的所有表。会自动关闭—single-transaction和—lock-tables。
    –lock-tables 对于备份的库在备份前锁定将被备份的属于该库的表。使用READ LOCAL锁定以允许MyIASM表的并发插入。对于事务型的表请使用—single-transaction而非—lock-tables。另外该选项不能保证备份文件上各数据库间的表在逻辑上是一致的，因为市委每个库单独锁定表。一些选项如—opt会自动开启—locak-tables，可通过使用在其后使用–skip-lock-tables规避。
    –log-error=file_name 在给定文件中附加警告和错误信息。
    –login-path=name 从.mylogin.cnf登录文件读取登录参数。可通过mysql_config_editor创建登录文件。
    –master-data[=value] 在输出中添加二进制日志名和位置。会开启—lock-all-tables除非也是用了—single-transaction。会自动关闭—lock-tables。
    –max_allowed_packet=value 可发送或接收的最大包分组长度。
    –net_buffer_length=value TCP/IP及socket通讯的buffer大小。
    –no-autocommit 在INSERT前后添加set autocommit=0和commit。
    –no-create-db 若使用了—all-databases或—databases，不在输出中添加CREATE DATABASE。
    –no-create-info 不使用CREATE TABLE 重建备份的表。
    –no-data 只备份结构不备份数据。
    –no-set-names 同–skip-set-charset不设置charset。
    –no-tablespaces 不在输出中使用CREATE LOG FILE和CREATE TABLESPACE。
    –opt --add-drop-table, --add-locks, --create-options, --quick, --extended-insert, --lock-tables, --set-charset,和–disable-keys几个选项合起来的简写形式。
    –order-by-primary 将备份的表中的行按主键排序或者第一个唯一键排序。当备份MyISAM表且将被载入到InnoDB表时很有用，打包备份本身的时间会较长。
    –password[=password] 连接主机的密码
    –pipe 在Windows上通过命名管道连接server。
    –plugin-dir=path 插件存放目录。
    –port=port_num 通过主机所使用的端口。
    –protocol=type 连接主机所使用的协议。
    –quick 备份时逐行读取表而非一次全部行后缓冲在内存中。在备份大表时有用。
    –quote-names 使用“`”包围数据库名、表名、列名等标识符。若使用了ANSI_QUOTES则用“””包围。特别的，可能需要在—compatible后开启该选项。
    –replace 使用REPLACE而非INSERT。
    –result-file=file 将结果输出带指定的文件。
    –routines 备份routines（存储过程和函数）。
    –set-charset 添加SET NAMES default_character_set。默认开启。
    –set-gtid-purged=value 确定是否在结果中添加SET @@GLOBAL.GTID_PURGED。若为ON但在server中没有开启GTID则发生错误。若OFF则什么都不做。若AUTO则server中开启GTID那么添加上述语句，反之不加。
    –single-transaction 在备份前设置事务隔离级别为REPEATABLE READ并向server发送START TRANSACTION语句。仅对事务型表如InnoDB有用。与–ock-tables互斥。对于大文件备份–single-transaction与–quick结合使用。
    –skip-add-drop-table 禁用–add-drop-table。
    –skip-add-locks 禁用–add-locks。
    –skip-comments 禁用—comments。
    –skip-compact 禁用—compact。
    –skip-disable-keys 禁用—disable-keys。
    –skip-extended-insert 禁用–extended-insert。
    –skip-opt 禁用–skip-opt。
    –skip-quick 禁用–quick。
    –skip-quote-names 禁用–quote-names。
    –skip-set-charset 禁用—set-charset。
    –skip-triggers 不备份triggers
    –skip-tz-utc 禁用-- tz-utc
    –socket=path 连接本机server所使用的socket。
    –ssl-ca=file_name 包含信任的SSL CAs列表的文件名。
    –ssl-capath=dir_name 包含PEM格式的可信任SSL CA证书的目录。
    –ssl-cert=file_name 用于建立安全连接的SSL证书文件的名字。
    –ssl-cipher=cipher_list 一系列用于SSL加密的所允许的密码。
    –ssl-crl=file_name 包含证书废止列表的文件名。
    –ssl-crlpath=dir_name 包含证书废止列表的文件的目录。
    –ssl-key=file_name 用于建立安全连接的SSL key文件名。
    –ssl-verify-server-cert The server’s Common Name value in its certificate is verified against the host name used when connecting to the server
    –tab=path 对于每个备份的表mysqldump创建一个包含CREATE TABLE语句的tbl_name.sql，而被连接的server会创建一个由tab键分隔的包含相应数据的tbl_name.txt。选项值为将被写入的目录。当mysqldump与mysqld处于同一主机时使用。否则tbl_name.txt文件会被写入远程主机相应的目录。当使用了—databases或—all-databases时该选项不适用。
    –tables 覆盖–databases 或 -B 选项。该选项后的名称参数均被认为是表名。
    –triggers 为每个备份的表备份trigger。
    –tz-utc 在备份文件中添加SET TIME_ZONE=’+00:00’。
    –user=user_name 连接server所使用的用户名
    –verbose 详细模式。
    –version 显示版本信息并退出。t
    –where=‘where_condition’ 仅备份与where条件中匹配的行。
    –xml 产生XML格式的输出。


    上述选项可大致分为以下几个方面（有些选项有简写形式）便于记忆：
    Ø 连接选项
    l --bind-address=ip_address
    l --compress,-C
    l --default-auth=plugin
    l --password[=password],-p[password]
    l --pipe,-W
    l --plugin-dir=path
    l --port=port_num,-P port_num
    l --protocol={TCP|SOCKET|PIPE|MEMORY}
    l --socket=path,-S path
    l --ssl*
    l --user=user_name,-u user_name
    l max_allowed_packet
    l net_buffer_length

    Ø DDL选项
    l --add-drop-database
    l --add-drop-table
    l --add-drop-trigger
    l --all-tablespaces,-Y
    l --no-create-db,-n
    l --no-create-info,-t
    l --no-tablespaces,-y
    l --replace
    Ø Debug选项
    l --allow-keywords
    l --comments,-i
    l --debug[=debug_options],-# [debug_options]
    l --debug-check
    l --debug-info
    l --dump-date
    l --force,-f
    l --log-error=file_name
    l --skip-comments
    l --verbose,-v

    Ø 帮助选项
    l --help,-?
    l --version,-V

    Ø 国际化选项
    l --character-sets-dir=path
    l --default-character-set=charset_name
    l --no-set-names,-N
    l --set-charset

    Ø 复制选项
    l --apply-slave-statements
    l --delete-master-logs
    l --dump-slave[=value]
    l --include-master-host-port
    l --master-data[=value]
    l --set-gtid-purged=value

    Ø 格式选项
    l --compact
    l --compatible=name
    l --complete-insert,-c
    l --create-options
    l --fields-terminated-by=…,–fields-enclosed-by=…, --fields-optionally-enclosed-by=…,–fields-escaped-by=…
    l --hex-blob
    l --lines-terminated-by=…
    l --quote-names,-Q
    l --result-file=file_name,-r file_name
    l --tab=path,-T path
    l --tz-utc
    l --xml,-X

    Ø 过滤选项
    l --all-databases,-A
    l --databases,-B
    l --events,-E
    l --ignore-table=db_name.tbl_name
    l --no-data,-d
    l --routines,-R
    l --tables
    l --triggers
    l --skip-triggers
    l --where=‘where_condition’,-w ‘where_condition’

    Ø 性能选项
    l --delayed-insert
    l --disable-keys,-K
    l --extended-insert,-e
    l --insert-ignore
    l --opt
    l --quick,-q
    l --skip-opt

    Ø 事务选项
    l --add-locks
    l --flush-logs,-F
    l --flush-privileges
    l --lock-all-tables,-x
    l --lock-tables,-l
    l --no-autocommit
    l --order-by-primary
    l --single-transaction

    Ø 选项组
    l --compact
    l --opt