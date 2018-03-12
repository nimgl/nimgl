# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## OpenGL Bindings
## ====
## `return <../>`_.  
##
## This bindings follow most of the original library
## You can check the original documentation `here <http://www.glfw.org/docs/latest/>`_.

#[
type
  ProcGL*  = ptr object
  HModule* = object {.importc.}

proc wglGetProcAddress(procgl: cstring): ProcGL {.importc.}

proc LoadLibraryA(procgl: cstring): HModule {.importc.}

proc GetProcAddress(module: HModule, procgl: cstring): ProcGL {.importc.}

proc getProcGL*(procgl: cstring): ProcGL =
  result = wglGetProcAddress(procgl)
  if result == nil:
    var ogl32: HModule = LoadLibraryA("opengl32.dll")
    result = GetProcAddress(ogl32, procgl)
]#

const
  glColorBufferBit* = 0x00004000

proc glClearColor*(red, green, blue, alpha: cfloat): void {.importc, dynlib: "opengl32.dll".}

proc glClear*(bit: cuint): void {.importc, dynlib: "opengl32.dll".}