## Nim Game Library

NimGL (Nim Game Library) is a collection of bindings for popular APIs, mostly used in computer graphics. With the power of Nim you can compile to C making it a perfect choice to combine with computer graphics.

This collection of bindings is heavily inspired by LWJGL3, it enables low level access and it is not a framework, so we highly encourage you to use other game engines in case of you not knowing low level graphic development.  
Even tho this is a low level access, we do have some usefull toolkits or some variations on functions to help with the development.

NimGL is open source and under the MIT License, we highly encourage every developer that uses it to make improvements and fork them here.

###### NimGL is under heavy development so expect drastic changes and improvements

#### Install
You will need nimble to install this library.  
```
nimble install https://github.com/cavariux/nimgl
```

After that you can access all the bindings by importing them like.  
```
import nimgl/<binding>
```

It is currently being developed and tested on

* Windows 10
* Mac High Sierra

#### Bindings Currently Supported

| Library | Description |
|:-------:|:------------|
| GLFW    | It provides a simple API for creating windows, contexts and surfaces, receiving input and events. |
