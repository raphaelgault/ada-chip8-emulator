Requirements
============

Toolchain
---------

download http://mirrors.cdn.adacore.com/art/5b0c1227a3f5d7097625478d
and install it somewhere (as shown below, you'll need to add it to your PATH)

Ada Drivers Library
-------------------

clone somewhere https://github.com/AdaCore/Ada_Drivers_Library

Environment
-----------

Add the following to your `.bashrc` or source it each time you want to compile

```
export PATH=/path/to/GNAT/toolchain/install/path/bin:$PATH
export GPR_PROJECT_PATH=/path/to/Ada_Drivers_Library
```
