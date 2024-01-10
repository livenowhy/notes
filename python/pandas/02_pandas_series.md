## Pandas Series
  
  Series是一个一维的带标签的数组，可以容纳任何类型的数据(整数、字符串、浮点数、Python对象等)。轴标签统称为索引。
  
  可以使用以下构造函数创建 Pandas Series
    
    pandas.Series( data, index, dtype, copy)
    
  构造函数的参数如下:
    
    data: 数据可以是ndarray、列表、常量等形式
    index: 索引值必须唯一且可哈希，长度与数据相同。如果没有传递索引，则默认为 np.arrange(n)
    dtype: 数据类型。如果为None，则会推断数据类型
    copy: 复制数据。默认为False

### 创建
### 1、空系列
  
  可以创建一个基本系列，即一个空系列。

    import pandas as pd
    s = pd.Series()
    print(s)

    输出:
    Series([], dtype: object)

### 2、从 ndarray 创建 Series
  如果数据是 ndarray，则传入的索引必须具有相同的长度。如果没有传入索引，则默认索引会是 range(n)，其中 n 是数组的长度，即[0,1,2,3... range(len(array))-1]
    
    1、实例1
    import pandas as pd
    import numpy as np
    data = np.array(['a','b','c','d'])
    s = pd.Series(data)
    print(s)

    输出如下:
    0    a
    1    b
    2    c
    3    d
    dtype: object

    2、示例2
    import pandas as pd
    import numpy as np
    data = np.array(['a','b','c','d'])
    s = pd.Series(data,index=[100,101,102,103])
    print(s)

    它的输出如下所示：
    100    a
    101    b
    102    c
    103    d
    dtype: object
    我们在这里传递了索引值。现在我们可以在输出中看到自定义的索引值。

### 3、从字典创建一个系列
  字典可以作为输入传递，如果没有指定索引，则按字典键的排序顺序构建索引。如果传递了索引，则会提取与索引标签对应的数据值。


  1、示例 1

    import pandas as pd
    import numpy as np
    data = {'a' : 0., 'b' : 1., 'c' : 2.}
    s = pd.Series(data)
    print(s)

    输出 如下:
    a    0.0
    b    1.0
    c    2.0
    dtype: float64
    观察: 字典键用于构建索引。

  2、示例 2
    import pandas as pd
    import numpy as np
    data = {'a' : 0., 'b' : 1., 'c' : 2.}
    s = pd.Series(data, index=['b','c','d','a'])
    print(s)

    输出 如下：
    b    1.0
    c    2.0
    d    NaN
    a    0.0
    dtype: float64
    注意: 索引顺序被保留，缺失的元素以NaN（不是一个数字）填充。

### 4、从标量创建 Series

  如果数据是一个标量值，必须提供一个索引。该值将被重复以匹配索引的长度。

    import pandas as pd
    import numpy as np
    s = pd.Series(5, index=[0, 1, 2, 3])
    print(s)

    输出如下:
    0    5
    1    5
    2    5
    3    5
    dtype: int64


### 从Series中按位置访问数据

  Series中的数据可以通过类似于 ndarray 的方式进行访问。

  1、示例1 - 获取第一个元素。
  正如我们已经知道的，数组的计数从零开始，这意味着第一个元素存储在位置为零的位置，依此类推。

    import pandas as pd
    s = pd.Series([1,2,3,4,5], index = ['a','b','c','d','e'])
    print(s.iloc[0])
    输出 如下:
    1

  2、示例2 - 检索 Series 中的前三个元素。
  如果在其前面插入冒号(:)，则将提取从该索引开始的所有项。如果使用两个参数（中间用冒号(:)分隔），则提取两个索引之间的项（不包括停止索引）。

    import pandas as pd
    s = pd.Series([1,2,3,4,5], index = ['a','b','c','d','e'])
    print(s.iloc[:3])

    输出 如下:
    a    1
    b    2
    c    3
    dtype: int64

  3、示例3 - 检索最后三个元素。

    import pandas as pd
    s = pd.Series([1,2,3,4,5], index = ['a','b','c','d','e'])
    print(s.iloc[-3:])

    输出 如下:
    c    3
    d    4
    e    5
    dtype: int64

### 使用标签 (索引) 检索数据
  
  Series 类似于一个固定大小的字典, 您可以通过索引标签来获取和设置值。

  1、示例1 - 使用索引标签值检索单个元素

    import pandas as pd
    s = pd.Series([1,2,3,4,5], index = ['a','b','c','d','e'])
    print(s['a'])

    输出 如下:
    1

  2、示例2 - 使用索引标签值列表检索多个元素

    import pandas as pd
    s = pd.Series([1,2,3,4,5], index = ['a','b','c','d','e'])
    print(s[['a','c','d']])

    输出 如下:
    a    1
    c    3
    d    4
    dtype: int64
    
  以上，如果标签未被包含，则会引发异常。
