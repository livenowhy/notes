## Groovy 数字

    数字方法:
    xxxValue: 此方法接受 Number 作为参数，并基于调用的方法返回基本类型。
    compareTo: 方法是使用比较一个数字与另一个数字。如果要比较数字的值，这是有用的。
    equals: 该方法确定调用方法的 Number 对象是否等于作为参数传递的对象。
    valueOf: 方法返回保存所传递的参数的值的相关 Number 对象。
    toString: 该方法用于获取表示 Number 对象的值的 String 对象。
    parseInt: 此方法用于获取某个 String 的原始数据类型。 parseXxx（）是一个静态方法，可以有一个参数或两个参数。
    abs: 该方法给出了参数的绝对值。参数可以是 int，float，long，double，short，byte。
    ceil: 方法 ceil 给出大于或等于参数的最小整数。
    floor: 方法 floor 给出小于或等于参数的最大整数。
    rint: 方法 rint 返回值最接近参数的整数。
    round: 方法 round 返回最接近的 long 或 int，由方法返回类型给出。
    min: 该方法给出两个参数中较小的一个。参数可以是 int，float，long，double。
    max: 该方法给出了两个参数的最大值。参数可以是 int，float，long，double。
    exp: 该方法返回自然对数e的底数为参数的幂。
    log: 该方法返回参数的自然对数。
    pow: 该方法返回第一个参数的值增加到第二个参数的幂。
    sqrt: 该方法返回参数的平方根。
    sin: 该方法返回指定 double 值的正弦值。
    cos: 该方法返回指定 double 值的余弦值。
    tan: 该方法返回指定 double 值的正切值。
    asin: 该方法返回指定 double 值的反正弦值。
    acos: 该方法返回指定 double 值的反余弦值。
    atan: 该方法返回指定 double 值的反正切。
    atan2: 该方法将直角坐标（x，y）转换为极坐标（r，theta），并返回theta。
    toDegrees: 该方法将参数值转换为度。
    toRadians: 该方法将参数值转换为弧度。
    random: 该方法用于生成介于0.0和1.0之间的随机数。范围是：0.0 = <Math.random <1.0。通过使用算术可以实现不同的范围。


## Groovy 字符串

    center: 返回一个新的长度为numberOfChars的字符串，该字符串由左侧和右侧用空格字符填充的收件人组成。
    compareToIgnoreCase: 按字母顺序比较两个字符串，忽略大小写差异。
    concat: 将指定的String连接到此String的结尾。
    eachMatch: 处理每个正则表达式组（参见下一节）匹配的给定String的子字符串。
    endsWith: 测试此字符串是否以指定的后缀结尾。
    equalsIgnoreCase: 将此字符串与另一个字符串进行比较，忽略大小写注意事项。
    getAt: 它在索引位置返回字符串值
    indexOf: 返回此字符串中指定子字符串第一次出现的索引。
    matches: 它输出字符串是否匹配给定的正则表达式。
    minus: 删除字符串的值部分。
    next: 此方法由++运算符为String类调用。它增加给定字符串中的最后一个字符。
    padLeft: 填充字符串，并在左边附加空格。
    padRight: 填充字符串，并在右边附加空格。
    plus: 追加字符串
    previous: 此方法由CharSequence的 - 运算符调用。
    replaceAll: 通过对该文本的关闭结果替换捕获的组的所有出现。
    reverse: 创建一个与此String相反的新字符串。
    split: 将此String拆分为给定正则表达式的匹配项。
    subString: 返回一个新的String，它是此String的子字符串。
    toUpperCase: 将此字符串中的所有字符转换为大写。
    toLowerCase: 将此字符串中的所有字符转换为小写。

## Groovy 范围

    1..10 : 包含范围的示例
    1 .. <10 : 独占范围的示例
    'a'..'x' : 范围也可以由字符组成
    10..1 : 范围也可以按降序排列
    'x'..'a' : 范围也可以由字符组成并按降序排列

    范围的各种方法:
    contains: 检查范围是否包含特定值
    get: 返回此范围中指定位置处的元素。
    getFrom: 获得此范围的下限值。
    getTo: 获得此范围的上限值。
    isReverse: 这是一个反向的范围，反向迭代
    size: 返回此范围的元素数。
    subList: 返回此指定的fromIndex（包括）和toIndex（排除）之间的此范围部分的视图

## Groovy 列表

    add: 将新值附加到此列表的末尾。
    contains: 如果此列表包含指定的值，则返回 true。
    get: 返回此列表中指定位置的元素。
    isEmpty: 如果此列表不包含元素，则返回 true
    minus: 创建一个由原始元素组成的新列表，而不是集合中指定的元素。
    plus: 创建由原始元素和集合中指定的元素组成的新列表。
    pop: 从此列表中删除最后一个项目。
    remove: 删除此列表中指定位置的元素。
    reverse: 创建与原始列表的元素相反的新列表。
    size: 获取此列表中的元素数。
    sort: 返回原始列表的排序副本。

## Groovy 映射(也称为关联数组，字典，表和散列)

    containsKey: 此映射是否包含此键
    get: 查找此Map中的键并返回相应的值。如果此映射中没有键的条目，则返回null。
    keySet: 获取此映射中的一组键。
    put: 将指定的值与此映射中的指定键相关联。如果此映射先前包含此键的映射，则旧值将替换为指定的值。
    size: 返回此映射中的键值映射的数量。
    values: 返回此映射中包含的值的集合视图。


## Groovy 日期和时间
    
    类Date表示特定的时刻，具有毫秒精度。
    after: 测试此日期是否在指定日期之后。
    equals: 比较两个日期的相等性。当且仅当参数不为null时，结果为true，并且是表示与该对象时间相同的时间点（毫秒）的Date对象。
    
    compareTo: 比较两个日期的顺序。
    toString: 将此Date对象转换为字符串。
    before: 测试此日期是否在指定日期之前。
    getTime: 返回自此Date对象表示的1970年1月1日，00:00:00 GMT以来的毫秒数。
    setTime: 设置此Date对象以表示一个时间点，即1970年1月1日00:00:00 GMT之后的时间毫秒。



