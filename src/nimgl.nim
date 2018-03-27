# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

#[
  We highly discourage to directly import this module due to all the modules
  you are importing at once. Please import each module independently, only use
  this module for test cases and not for production.
]#

## Nim Game Library
## ====
##
## Supported Libraries
## - `GLFW  <./nimgl/glfw.html>`_     Window Library
## - `OpenGL  <./nimgl/opengl.html>`_ Glew Loading Library
## - `Math  <./nimgl/math.html>`_     Linear Algebra for graphics programming
## - `ImGUI  <./nimgl/imgui.html>`_   Fast UI Development tool for debug and testing

import
  nimgl/[
    glfw,
    opengl,
    math,
    imgui
  ]
export
  glfw,
  opengl,
  math,
  imgui
