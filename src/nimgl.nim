# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

#[
  We highly discourage to directly import this module due to all the modules
  you are importing at once. Please import each module independently, only use
  this module for test cases and not for production.
]#

## Nim Game Library
## ====
##

import
  nimgl/glfw,
  nimgl/glew,
  nimgl/math

export
  glfw,
  glew,
  math