[![GitHub stars](https://img.shields.io/github/stars/cavariux/nimgl.svg?style=social&logo=github&label=Stars)](https://github.com/cavariux/nimgl)
[![Buy Me a Coffee](https://img.shields.io/badge/buy%20me-coffee-orange.svg?longCache=true&style=flat-square)](https://cav.bz/coffee)
![GitHub last commit](https://img.shields.io/github/last-commit/cavariux/nimgl.svg?style=flat-square)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square)](LICENSE)
[![docs](https://img.shields.io/badge/docs-passing-ff69b4.svg?style=flat-square)](https://nimgl.org)

## Nim Game Library (WIP) [![nimble](https://raw.githubusercontent.com/yglukhov/nimble-tag/master/nimble.png)](https://github.com/nim-lang/nimble)

NimGL (Nim Game Library) is a collection of bindings for popular APIs, mostly used in computer graphics.

This collection of bindings is heavily inspired by LWJGL3, it enables low level access and it is not a framework, so we highly encourage you to use other game engines if you don't have experience working with low level graphic developments.
We try to keep this bindings as similar to the originals but we do have some usefull toolkits or some variations on functions to help with the development.

NimGL is open source and is under the MIT License, we highly encourage every developer that uses it to make improvements and fork them here.

###### NimGL is under heavy development so expect drastic changes and improvements

#### Install
You will need nimble to install this library.  
```
nimble install nimgl
```

After that you can access all the bindings by importing them like.  
```
import nimgl/<binding>
```

It is currently being developed and tested on

* Windows 10
* Mac High Sierra

#### Contribute

I'm only one person and I use this library almost daily for school and personal
projects. If you are missing some extension, procedures or bindings or anything
related, feel free to pull request any feature or open an issue with the specification and
if you can some links to the docs so I can have an idea on how to implement it.  
Thank you so much :D

#### Bindings Currently Supported

| Library | Description |
|:-------:|:------------|
| [GLFW](src/nimgl/glfw.nim) | It provides a simple API for creating windows, contexts and surfaces, receiving input and events. |
| [OpenGL](src/nimgl/opengl.nim) | Bindings to GLEW. GLEW is a cross-platform open-source C/C++ extension loading library |
| [Math](src/nimgl/math.nim) | A linear algebra library to interact directly with opengl |