## string 数据类型操作

# String 

 `1` SET/GET/APPEND/STRLEN

    127.0.0.1:6379> append mykey "hello"         # 该键并不存在, 因此 append 命令返回当前 Value 的长度
    (integer) 5
    
    127.0.0.1:6379> append mykey " world"        # 该键已经存在, 因此返回追加后 Value 的长度
    (integer) 11
    
    127.0.0.1:6379> get mykey                    # 通过get命令获取该键, 以判断 append 的结果
    "hello world"
    
    127.0.0.1:6379> set mykey "this is a test"   # 通过set命令为键设置新值, 并覆盖原有值
    OK
    
    redis 127.0.0.1:6379> strlen mykey           # 获取指定Key的字符长度,等效于 C 库中 strlen 函数
    (integer) 14
  
  `2` INCR/DECR/INCRBY/DECRBY (value 为整形)

    127.0.0.1:6379> set mykey 1990     # 通过set命令为键设置新值, 并覆盖原有值
    OK
    
    127.0.0.1:6379> incr mykey         # 该Key的值递增1
    (integer) 21
    
    127.0.0.1:6379> decr mykey         # 该Key的值递减1
    (integer) 20
    
    127.0.0.1:6379> del mykey          # 删除已有键。
    (integer) 1
    
    redis 127.0.0.1:6379> decr mykey   # 对空值执行递减操作，其原值被设定为0，递减后的值为-1
    (integer) -1
    
    redis 127.0.0.1:6379> del mykey   
    (integer) 1
    
    redis 127.0.0.1:6379> incr mykey   # 对空值执行递增操作，其原值被设定为0，递增后的值为1
    (integer) 1
    redis 127.0.0.1:6379> set mykey hello # 将该键的Value设置为不能转换为整型的普通字符串
    OK
    redis 127.0.0.1:6379> incr mykey        # 在该键上再次执行递增操作时, Redis将报告错误信息
    (error) ERR value is not an integer or out of range
    redis 127.0.0.1:6379> set mykey 10
    OK
    redis 127.0.0.1:6379> decrby mykey 5 
    (integer) 5
    redis 127.0.0.1:6379> incrby mykey 10
    (integer) 15
    
  `3` GETSET
    
    127.0.0.1:6379> incr mycounter      # 将计数器的值原子性的递增1
    (integer) 1
    
    # 在获取计数器原有值的同时，并将其设置为新值，这两个操作原子性的同时完成。
    127.0.0.1:6379> getset mycounter 0  
    "1"
    
    127.0.0.1:6379> get mycounter       #查看设置后的结果。
    "0"
    
  `4` SETEX (设置过期时间)
  
    127.0.0.1:6379> setex mykey 10 "hello"         # 设置指定Key的过期时间为10秒。


    127.0.0.1:6379> get mykey                      # 在该键的存活期内我们仍然可以获取到它的Value。
    "hello"
    
    
  `5` SETNX
    
    127.0.0.1:6379> setnx mykey "hello"            # 该键并不存在, 因此该命令执行成功
    (integer) 1
    redis 127.0.0.1:6379> setnx mykey "world"      # 该键已经存在，因此本次设置没有产生任何效果。
    (integer) 0
    
    redis 127.0.0.1:6379> get mykey                # 从结果可以看出, 返回的值仍为第一次设置的值。
    "hello"

  `6` SETRANGE/GETRANGE
    
    127.0.0.1:6379> set mykey "hello world"       #设定初始值。
    OK
    
    127.0.0.1:6379> setrange mykey 6 dd          #从第六个字节开始替换2个字节(dd只有2个字节)
    (integer) 11
    
    127.0.0.1:6379> get mykey                         #查看替换后的值。
    "hello ddrld"
    
    127.0.0.1:6379> setrange mykey 20 dd        #offset已经超过该Key原有值的长度了，该命令将会在末尾补0。
    (integer) 22
    
    127.0.0.1:6379> get mykey                           #查看补0后替换的结果。
    "hello ddrld\x00\x00\x00\x00\x00\x00\x00\x00\x00dd"
    
    127.0.0.1:6379> del mykey                         #删除该Key。
    (integer) 1
    
    127.0.0.1:6379> setrange mykey 2 dd         #替换空值。
    (integer) 4
    
    127.0.0.1:6379> get mykey                        #查看替换空值后的结果。
    "\x00\x00dd"
    
    127.0.0.1:6379> set mykey "0123456789"   #设置新值。
    OK
    
    127.0.0.1:6379> getrange mykey 1 2      #截取该键的Value，从第一个字节开始，到第二个字节结束。
    "12"
    
    127.0.0.1:6379> getrange mykey 1 20   #20已经超过Value的总长度，因此将截取第一个字节后面的所有字节。
    "123456789"




  `7` SETBIT/GETBIT:
  
    redis 127.0.0.1:6379> del mykey
    (integer) 1
    
    redis 127.0.0.1:6379> setbit mykey 7 1       #设置从0开始计算的第七位BIT值为1，返回原有BIT值0
    (integer) 0
    
    redis 127.0.0.1:6379> get mykey                #获取设置的结果，二进制的0000 0001的十六进制值为0x01
    "\x01"
    
    redis 127.0.0.1:6379> setbit mykey 6 1       #设置从0开始计算的第六位BIT值为1，返回原有BIT值0
    (integer) 0
    
    redis 127.0.0.1:6379> get mykey                #获取设置的结果，二进制的0000 0011的十六进制值为0x03
    "\x03"
    
    redis 127.0.0.1:6379> getbit mykey 6          #返回了指定Offset的BIT值。
    (integer) 1
    
    redis 127.0.0.1:6379> getbit mykey 10        #Offset已经超出了value的长度，因此返回0。
    (integer) 0
    
  `8` MSET/MGET/MSETNX
  
    redis 127.0.0.1:6379> mset key1 "hello" key2 "world"   #批量设置了key1和key2两个键。
    OK
    redis 127.0.0.1:6379> mget key1 key2                        #批量获取了key1和key2两个键的值。
    1) "hello"
    2) "world"
    #批量设置了key3和key4两个键，因为之前他们并不存在，所以该命令执行成功并返回1。
    redis 127.0.0.1:6379> msetnx key3 "stephen" key4 "liu" 
    (integer) 1
    redis 127.0.0.1:6379> mget key3 key4                   
    1) "stephen"
    2) "liu"
    #批量设置了key3和key5两个键，但是key3已经存在，所以该命令执行失败并返回0。
    redis 127.0.0.1:6379> msetnx key3 "hello" key5 "world" 
    (integer) 0
    #批量获取key3和key5，由于key5没有设置成功，所以返回nil。
    redis 127.0.0.1:6379> mget key3 key5                   
    1) "stephen"
    2) (nil)

    
    
    APPEND key value
    
    O(1)	如果该Key已经存在，APPEND命令将参数Value的数据追加到已存在Value的末尾。如果该Key不存在，APPEND命令将会创建一个新的Key/Value。	追加后Value的长度。
    
    DECR key	O(1) 	将指定Key的Value原子性的递减1。如果该Key不存在，其初始值为0，在decr之后其值为-1。如果Value的值不能转换为整型值，如Hello，该操作将执行失败并返回相应的错误信息。注意：该操作的取值范围是64位有符号整型。	递减后的Value值。
    
    INCR key	O(1) 	将指定Key的Value原子性的递增1。如果该Key不存在，其初始值为0，在incr之后其值为1。如果Value的值不能转换为整型值，如Hello，该操作将执行失败并返回相应的错误信息。注意：该操作的取值范围是64位有符号整型。 	递增后的Value值。 
    
    DECRBY key decrement  	O(1)  	将指定Key的Value原子性的减少decrement。如果该Key不存在，其初始值为0，在decrby之后其值为-decrement。如果Value的值不能转换为整型值，如Hello，该操作将执行失败并返回相应的错误信息。注意：该操作的取值范围是64位有符号整型。 	减少后的Value值。
    
    INCRBY key increment  	O(1) 	将指定Key的Value原子性的增加increment。如果该Key不存在，其初始值为0，在incrby之后其值为increment。如果Value的值不能转换为整型值，如Hello，该操作将执行失败并返回相应的错误信息。注意：该操作的取值范围是64位有符号整型。 	增加后的Value值。
    
    GET key 	O(1) 	获取指定Key的Value。如果与该Key关联的Value不是string类型，Redis将返回错误信息，因为GET命令只能用于获取string Value。 	与该Key相关的Value，如果该Key不存在，返回nil。
    
    SET key value 	O(1) 
    设定该Key持有指定的字符串Value，如果该Key已经存在，则覆盖其原有值。	总是返回"OK"。
    
    GETSET key value	O(1) 	原子性的设置该Key为指定的Value，同时返回该Key的原有值。和GET命令一样，该命令也只能处理string Value，否则Redis将给出相关的错误信息。	返回该Key的原有值，如果该Key之前并不存在，则返回nil。
    
    STRLEN key	O(1)	返回指定Key的字符值长度，如果Value不是string类型，Redis将执行失败并给出相关的错误信息。	返回指定Key的Value字符长度，如果该Key不存在，返回0。
    
    SETEX key seconds value	O(1)	原子性完成两个操作，一是设置该Key的值为指定字符串，同时设置该Key在Redis服务器中的存活时间(秒数)。该命令主要应用于Redis被当做Cache服务器使用时。	 
    
    SETNX key value 	O(1) 	如果指定的Key不存在，则设定该Key持有指定字符串Value，此时其效果等价于SET命令。相反，如果该Key已经存在，该命令将不做任何操作并返回。	1表示设置成功，否则0。
    
    SETRANGE key offset value 	O(1) 	替换指定Key的部分字符串值。从offset开始，替换的长度为该命令第三个参数value的字符串长度，其中如果offset的值大于该Key的原有值Value的字符串长度，Redis将会在Value的后面补齐(offset - strlen(value))数量的0x00，之后再追加新值。如果该键不存在，该命令会将其原值的长度假设为0，并在其后添补offset个0x00后再追加新值。鉴于字符串Value的最大长度为512M，因此offset的最大值为536870911。最后需要注意的是，如果该命令在执行时致使指定Key的原有值长度增加，这将会导致Redis重新分配足够的内存以容纳替换后的全部字符串，因此就会带来一定的性能折损。 	修改后的字符串Value长度。
    
    GETRANGE key start end	O(1) 	如果截取的字符串长度很短，我们可以该命令的时间复杂度视为O(1)，否则就是O(N)，这里N表示截取的子字符串长度。该命令在截取子字符串时，将以闭区间的方式同时包含start(0表示第一个字符)和end所在的字符，如果end值超过Value的字符长度，该命令将只是截取从start开始之后所有的字符数据。	子字符串 
    
    SETBIT key offset value 	O(1) 	设置在指定Offset上BIT的值，该值只能为1或0，在设定后该命令返回该Offset上原有的BIT值。如果指定Key不存在，该命令将创建一个新值，并在指定的Offset上设定参数中的BIT值。如果Offset大于Value的字符长度，Redis将拉长Value值并在指定Offset上设置参数中的BIT值，中间添加的BIT值为0。最后需要说明的是Offset值必须大于0。 	在指定Offset上的BIT原有值。
    
    GETBIT key offset 	O(1) 	返回在指定Offset上BIT的值，0或1。如果Offset超过string value的长度，该命令将返回0，所以对于空字符串始终返回0。	在指定Offset上的BIT值。 
    
    MGET key [key ...] 	O(N) 	N表示获取Key的数量。返回所有指定Keys的Values，如果其中某个Key不存在，或者其值不为string类型，该Key的Value将返回nil。	返回一组指定Keys的Values的列表。
    
    MSET key value [key value ...] 	O(N) 	N表示指定Key的数量。该命令原子性的完成参数中所有key/value的设置操作，其具体行为可以看成是多次迭代执行SET命令。 	该命令不会失败，始终返回OK。  
    
    MSETNX key value [key value ...] 	O(N)	N表示指定Key的数量。该命令原子性的完成参数中所有key/value的设置操作，其具体行为可以看成是多次迭代执行SETNX命令。然而这里需要明确说明的是，如果在这一批Keys中有任意一个Key已经存在了，那么该操作将全部回滚，即所有的修改都不会生效。	1表示所有Keys都设置成功，0则表示没有任何Key被修改。




# 	SET key value
设置指定 key 的值
2	GET key
获取指定 key 的值。
3	GETRANGE key start end
返回 key 中字符串值的子字符
4	GETSET key value
将给定 key 的值设为 value ，并返回 key 的旧值(old value)。
5	GETBIT key offset
对 key 所储存的字符串值，获取指定偏移量上的位(bit)。
6	MGET key1 [key2..]
获取所有(一个或多个)给定 key 的值。
7	SETBIT key offset value
对 key 所储存的字符串值，设置或清除指定偏移量上的位(bit)。
8	SETEX key seconds value
将值 value 关联到 key ，并将 key 的过期时间设为 seconds (以秒为单位)。
9	SETNX key value
只有在 key 不存在时设置 key 的值。
10	SETRANGE key offset value
用 value 参数覆写给定 key 所储存的字符串值，从偏移量 offset 开始。
11	STRLEN key
返回 key 所储存的字符串值的长度。
12	MSET key value [key value ...]
同时设置一个或多个 key-value 对。
13	MSETNX key value [key value ...]
同时设置一个或多个 key-value 对，当且仅当所有给定 key 都不存在。
14	PSETEX key milliseconds value
这个命令和 SETEX 命令相似，但它以毫秒为单位设置 key 的生存时间，而不是像 SETEX 命令那样，以秒为单位。
15	INCR key
将 key 中储存的数字值增一。
16	INCRBY key increment
将 key 所储存的值加上给定的增量值（increment） 。
17	INCRBYFLOAT key increment
将 key 所储存的值加上给定的浮点增量值（increment） 。
18	DECR key
将 key 中储存的数字值减一。
19	DECRBY key decrement
key 所储存的值减去给定的减量值（decrement） 。
20	APPEND key value
如果 key 已经存在并且是一个字符串， APPEND 命令将指定的 value 追加到该 key 原来值（value）的末尾。
