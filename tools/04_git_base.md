## git 命令

### 删除远端分支
    
    git push origin --delete bugFix1


## reference

### Git 中的 Reference 及 Reference Specification 概述

    1. Git Reference 简写为 refs
    1.1 本地分支的 Reference 格式: 
    refs/heads/<local_branch_name>
    如: refs/heads/master, 在保证唯一的情况下可以简写为 master

    1.2 远程追踪分支的 Reference 格式:
    refs/remotes/<remote_repository>/<remote_branch_name>
    如: refs/remotes/origin/master, 在保证唯一的情况下可以简写为 origin/master
    
    1.3 tag 的 Reference 格式: 
    refs/tags/<tag_name>
    如: refs/tags/v1.0.1, 在保证唯一的情况下可以简写为 v1.0.1

    补充: 一些 Git 保留使用的特殊 refs:
    HEAD, 指向当前本地分支的当前commit状态
    FETCH_HEAD, 指向当前本地分支在最近一次fetch操作时得到的commit状态
    ORIG_HEAD, 指向任何merge或rebase之前的刚刚检出时的commit状态

    2. Reference Specification 简称 refspec
    在执行 push 或 fetch 操作时, refspec 用以给出本地 Ref 和远程 Ref 之间的映射关系，通常是本地分支或本地tag与远程库中的分支或tag之间的映射关系。

    refspec格式: +<src_ref>:<dst_refs> 其中的 + 是可选的, 表示强制更新
    典型的 push  refspec 为 HEAD: refs/heads/master
    典型的 fetch refspec 为 refs/heads/*:refs/remotes/origin/*