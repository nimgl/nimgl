# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

#[
  We highly discourage to directly import this file due to all the bindings
  you are importing at once. Please import each binding independently, only use
  this import for test cases and not for production.
]#

## Nim Game Library
## ====
##

import
  nimgl/glfw,
  nimgl/opengl

export
  glfw,
  opengl