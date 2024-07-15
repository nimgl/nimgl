<p align="center">
  <a href="https://nimgl.dev/">
    <img width="120" height="120" src="https://nimgl.github.io/media/logo.png">
  </a>
</p>

<h3 align="center">Nim Game Library</h3>


<p align="center">
  A collection of bindings for popular libraries<br/>
  Mostly used in computer graphics
  <br/>
  <a href="https://nimgl.dev/docs/"><strong>Explore the docs »</strong></a>
  <br/>
  <br/>
  <a href="https://choosealicense.com/licenses/mit">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square">
  </a>
  <a href="https://github.com/nimgl/nimgl/graphs/contributors">
   <img src="https://img.shields.io/github/contributors/nimgl/nimgl.svg?color=orange&style=flat-square">
  </a>
</p>

## Table of Contents

- [About](#about)
- [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Green Window Example](#green-window-example)
- [Contribute](#contribute)
- [Supported Bindings](#supported-bindings)
- [Roadmap](#roadmap)
- [Gallery](#gallery)
- [Contact](#contact)
- [Credits](#credits)
- [License](#license)

## About

NimGL (Nim Game Library) is a collection of bindings for popular libraries,
mostly used in computer graphics. *A library of libraries.*

This collection of bindings is heavily inspired by LWJGL3. It enables low level
access and it is not a framework, so we highly encourage you to use a game
engine if you do not have experience in working with low level graphics
development. These bindings contain several optional helper procedures to help
with development and to better suit it to the language.

## Getting Started

We highly recommend using a Nimble project to easily add requirements such as
NimGL.

### Installation

#### With Nimble file (recommended)

1. Install Nimble, it comes preinstalled with Nim.
2. Add it to your .nimble file.
```nim
requires "nimgl >= 1.0.0"
```
3. Build with nimble.
```sh
nimble build
```

#### With Nimble install

1. Install Nimble, it comes preinstalled with Nim.
2. Install NimGL with Nimble.
```sh
nimble install nimgl
```
3. Build with Nim.
```sh
nim c -r main.nim
```

#### Develop with Nimble

1. Install Nimble, it comes preinstalled with Nim.
2. Clone and link with Nimble in another directory.
```sh
nimble develop nimgl
```
3. Build with either Nim or Nimble.


It is currently being developed and tested on

- Windows 10
- MacOS Catalina
- Linux Ubuntu 18.10

### Usage

Please refer to each binding documentation to further understand its usage.

### Green Window Example
```nim
import nimgl/[glfw, opengl]

proc keyProc(window: GLFWWindow, key: int32, scancode: int32,
             action: int32, mods: int32): void {.cdecl.} =
  if key == GLFWKey.ESCAPE and action == GLFWPress:
    window.setWindowShouldClose(true)

proc main() =
  assert glfwInit()

  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE) # Used for Mac
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(GLFWResizable, GLFW_FALSE)

  let w: GLFWWindow = glfwCreateWindow(800, 600, "NimGL")
  if w == nil:
    quit(-1)

  discard w.setKeyCallback(keyProc)
  w.makeContextCurrent()

  assert glInit()

  while not w.windowShouldClose:
    glfwPollEvents()
    glClearColor(0.68f, 1f, 0.34f, 1f)
    glClear(GL_COLOR_BUFFER_BIT)
    w.swapBuffers()

  w.destroyWindow()
  glfwTerminate()

main()
```

## Contribute

Your contributions truly mean the world to this project. If you are missing some
procedures, bindings or functionality feel free to open an Issue with the
specification and some example on how to properly implement it. For the
adventurous also feel free to open a Pull Request which will be greatly
appreciated.  
Thank you so much :tada:

Read the [Contribution Guide](https://github.com/nimgl/.github/blob/master/CONTRIBUTING.md) for more information.

## Supported Bindings

| Library              | Description                                                                                                                                                                                                    |
|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [GLFW][glfw-url]     | Create multiple windows, handle user input (keyboard, mouse, gaming peripherals) and manage contexts. Also features multi-monitor support, clipboard access, file drag-n-drop, and much more.                  |
| [Vulkan][vulkan-url] | A new generation graphics and compute API that provides high-efficiency, cross-platform access to modern GPUs used in a wide variety of devices from PCs and consoles to mobile phones and embedded platforms. |
| [OpenGL][opengl-url] | Open Graphics Library is a cross-language, cross-platform application programming interface for rendering 2D and 3D vector graphics. NimGL only supports modern OpenGL.                                        |
| [ImGUI][imgui-url]   | Dear ImGui is a bloat-free graphical user interface library for C++. It outputs optimized vertex buffers that you can render anytime in your 3D-pipeline enabled application.                                  |

## Gallery

Please let me know if you want to be showcased or removed from here.

chip-8 emulator by [@kraptor](https://github.com/kraptor)
<img src="https://user-images.githubusercontent.com/7249728/60570947-e6787f80-9d72-11e9-8b26-d189f44b1256.gif">


## Credits

Developed by [Leonardo Mariscal](https://lmariscal.com/) and all the amazing
contributors in GitHub.

Heavily inspired by [LWJGL3](https://github.com/LWJGL/lwjgl3) and
[GLAD](https://github.com/Dav1dde/glad).

Each binding contains a small credits comment at the top of the file, but in
general thank you to every contributor of each individual library used in this
project :rose:.

## License

[MIT License](https://choosealicense.com/licenses/mit).

NimGL is open source and is under the MIT License, we highly encourage every
developer that uses it to make improvements and fork them here.

<!-- MARKDOWN LINKS -->
[glfw-url]: https://glfw.org/
[opengl-url]: https://www.khronos.org/opengl/
[imgui-url]: https://github.com/ocornut/imgui
[vulkan-url]: https://www.khronos.org/vulkan/
