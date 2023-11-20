## error in setup command: use_2to3 is invalid.

    安装anyjson==0.3.3这个库，其他库也有可能发生
    error in anyjson setup command: use_2to3 is invalid.
    解决: pip install setuptools==57.5.0
    原因: 因为在setuptools 58之后的版本已经废弃了use_2to3

