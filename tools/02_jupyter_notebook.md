## 如何设置 jupyter notebook 的代码自动补全
  
  `1` 打开命令行，切换到需要安装的环境，输入以下命令:
     
    $ pip3 install jupyter_contrib_nbextensions
  
  `2` 下载成功后，再输入:
    
    $ jupyter contrib nbextension install --user

    $ pip3 install jupyter_nbextensions_configurator
    $ jupyter nbextensions_configurator enable --user
  
  `3` 然后启动 jupyter，就可以看见 Nbextensions，勾选 Hinterland: 
  
  `4` 重启 jupyter notebook
