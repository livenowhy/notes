## Groovy 基础语法

### 简介

### 安装

### 数据类型

#### 字符串 string

    字符串表示: 单引号、双引号、三引号
    contains(): 是否包含特定内容; 返回 true/false
    size()    : 字符串数量大小
    length()  : 字符串数量长度
    toString(): 转换成string类型
    indexOf() : 元素的索引
    endsWith(): 是否指定字符结尾
    minus()   : 去掉字符串
    plus()    : 增加字符串
    reverse() : 反向排序
    substring(1,2) : 字符串的指定索引开始的子字符串
    toUpperCase()  : 
    toLowerCase()  : 字符串大小写转换
    split()        : 字符串分割 默认空格分割; 返回列表

#### 列表 list

    列表的表示: [] [1,2,3,4]

    + - += -= 元素增加减少
    isEmpty() 判断是否为空
    add()  <<   : 添加元素
    intersect([2,3]) disjoint([1])  取交集、判断是否有交集
    flatten()   : 合并嵌套的列表
    unique()    : 去重
    reverse()   : 反转 
    sort()      : 升序
    count()     : 元素个数
    join()      : 将元素按照参数链接
    sum()       : 求和 
    min()       : 最小值 
    max()       : 最大值
    contains()  : 包含特定元素
    remove(2) removeAll()
    each{}      : 遍历

#### 映射 map
    
    types = ["maven": "mvn"]

    size()            : map大小
    [’key’].key get() : 获取value
    isEmpty()         : 是否为空
    containKey()      : 是否包含key
    containValue()    : 是否包含指定的value
    keySet()          : 生成key的列表
    each{}            : 遍历map
    remove(‘a‘)       : 删除元素（k-v）

#### 条件语句

    if语句: 在 Jenkinsfile 中可用于条件判断。
    if (表达式) {
        //xxxx
    } else if(表达式2) {
        //xxxxx
    } else {
        //
    }

    switch语句: 
    switch("${buildType}"){
        case "maven":
            // xxxx
            break;
        case "ant":
            // xxxx
            break;
        default:
            // xxxx
    }

#### 循环语句

    1. for 循环语句:
    test = [1,2,3]
    for ( i in test){
        ///xxxxxx
        break;
    }

    2. while 循环语句
    while(true){
        //xxxx
    }

#### 函数(在共享库中每个类中的方法)

    def PrintMes(info){
        println(info)
        return info
    }
    
    response = PrintMes("DevOps")
    println(response)