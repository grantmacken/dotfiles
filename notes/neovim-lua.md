# neovim lua

 Latest neovim now supports lua 

```
$XDG_DATA_HOME/nvim/site/lua
```
 
 the lua dir will be searched for as part of neovims runtime path

 ``` 
 :lua print(package.path)
 ```

 luarock to install lua modules

 ```
 luarocks install --local xxxx
 ```



out of the box neovim appears to have the following libs

 - lpeg
 - luv       libuv bindings for luajit https://github.com/luvit/luv
 - mpack  
 - coxpcall

 neovim also has curl

