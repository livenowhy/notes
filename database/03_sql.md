## sql 语句

  `1` 查询不包含

    select * from table_name where field_name not like '%some%;

  `2` 更新

    update table_name set fileld_name1=1 where field_name2 = 1;

  `3` 删除MySQL数据表:

    DROP TABLE table_name ;

  `4` 重命名:

    RENAME TABLE old_table_name TO new_table_name;
    update landleveldata a, gdqlpj b set a.gqdltks= b.gqdltks, a.bztks= b.bztks where a.GEO_Code=b.lxqdm

  `5` 查询重复记录

    select document_id, collect_id, tags_id, count(id) as count from bt_tags_document group by document_id, collect_id, tags_id having count>1

  `6` 表结构

    desc tabl_name;

  `7` 删除两个字段

    mysql> alter table id_name drop column age,drop column address;

  `8` 用指定字符集创建数据库:

    mysql> create database rcedb CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

  `9` 从表中删除数据

    mysql> DELETE FROM table_name WHERE condition;

  `10` 导入数据库

    source 命令
    进入mysql数据库控制台,如
    # mysql -u root -p
    mysql> use dbname
    mysql> source d:/dbname.sql   然后使用source命令，后面参数为脚本文件(如这里用到的.sql)

  `11` insert

    INSERT INTO table_name ( field1, field2,...fieldN ) VALUES ( value1, value2,...valueN );

  `12` 数据库备份

    mysqldump -u root -h host -P 3306 -pPassword dbname tablename > tablename.sql

  `13` 查询建表语句
     
     SHOW CREATE TABLE <表名>


## Mysql查看某个表大小

  `1` 进入 information_schema 数据库

    mysql> use information_schema;
    
  `2` 查询所有数据的大小

    mysql> select concat(round(sum(data_length/1024/1024),2),'MB') as data from tables;

  `3` 查看指定表的大小

    mysql> select concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') as data from TABLES where table_schema='库名' and table_name='表名';
    

  `4` 查看指定数据库的大小

    mysql> select concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') as data from TABLES where table_schema='库名';

  `5` 查看所有表大小并排序

    mysql> SELECT CONCAT(table_schema,'.',table_name) AS 'Table Name', CONCAT(ROUND(table_rows/1000000,4),'M') AS 'Number of Rows', CONCAT(ROUND(data_length/(1024*1024*1024),4),'G') AS 'Data Size',CONCAT(ROUND(index_length/(1024*1024*1024),4),'G') AS 'Index Size', CONCAT(ROUND((data_length+index_length)/(1024*1024*1024),4),'G') AS'Total'FROM information_schema.TABLES  ORDER BY --total DESC;
    
