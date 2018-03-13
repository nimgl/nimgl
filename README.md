[![GitHub stars](https://img.shields.io/github/stars/cavariux/nimgl.svg?style=social&logo=github&label=Stars)](https://github.com/cavariux/nimgl)
[![Buy Me a Coffee](https://img.shields.io/badge/buy%20me-coffee-orange.svg?longCache=true&style=flat-square)](https://cav.bz/coffee)
![GitHub last commit](https://img.shields.io/github/last-commit/cavariux/nimgl.svg?style=flat-square)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square)](LICENSE)
[![docs](https://img.shields.io/badge/docs-passing-ff69b4.svg?style=flat-square)](https://nimgl.org)

## Nim Game Library (WIP)

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
| [GLFW](src/nimgl/glfw.nim) | It provides a simple API for creating windows, contexts and surfaces, receiving input and events. |
| [GLEW](src/nimgl/glew.nim) | OpenGL Loading Library. The OpenGL Extension Wrangler Library (GLEW) is a cross-platform open-source C/C++ extension loading library |
| [Math](src/nimgl/math.nim) | A linear algebra library to interact directly with opengl |