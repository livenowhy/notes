## mysql 常用命令

    进程管理
    show processlist ;
    kill id

    drop table 命令用于删除数据表。
    trancate url_histories;

    查看建表语句:
    show create table 表名称
    show create table umonitor_alert
    
    3.添加index(普通索引)
    alter  table  表名  add  index  索引名(index_name)  (列名);


    show create table umonitor_interrupt

    alter table umonitor_interrupt add index `umonitor_interrupt_index_url_id` (`url_id`);


    umonitor_alert.deleted = false AND umonitor_alert.url_id = ? AND umonitor_alert.created_at >= ? AND umonitor_alert.created_at <= ? AND umonitor_alert.is_notice = false 

    select count(id) from umonitor_url_history ;

    alter table umonitor_alert add index `umonitor_alert_index` (`deleted`, `url_id`, `created_at`, `is_notice`);
    delete from umonitor_alert where created_at <= "2022-08-01 01:00:11" \G;


