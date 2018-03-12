# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## OpenGL Bindings
## ====
## `return <../>`_.  
##
## This bindings follow most of the original library
## You can check the original documentation `here <http://www.glfw.org/docs/latest/>`_.

const
  wingdi_h  = "<wingdi.h>"
  winbase_h = "<Winbase.h>"

type
  ProcGL*  = ptr object
  #PFNGLCLEARCOLORXOESPROC = ptr object {.importc: ""
  HInstance* = ptr object {.importc: "HINSTANCE", header: winbase_h.}
  procGlClearColor = ptr proc(r, g, b, a: cfloat): void {.cdecl.}

proc wglGetProcAddress(procgl: cstring): ProcGL {.importc, header: wingdi_h.}

proc LoadLibrary(procgl: cstring): HInstance {.importc, header: winbase_h.}

proc GetProcAddress(module: HInstance, procgl: cstring): ProcGL {.importc, header: winbase_h.}

proc getProcGL*(procgl: cstring): ProcGL =
  result = wglGetProcAddress(procgl)
  if result == nil:
    var ogl32: HInstance = LoadLibrary("opengl32.dll")
    result = GetProcAddress(ogl32, procgl)

proc init*() =
  echo getProcGL("glClearColor") == nil
  echo getProcGL("glClear") == nil