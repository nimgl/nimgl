# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## ImGUI Bindings
## ====
## `return <../nimgl.html>`_.  
##
## This bindings follow most of the original library
## You can check the original documentation `here <https://github.com/ocornut/imgui/blob/master/imgui.cpp>`_.
##
## Do to this library most of the binding libraries are written in C, we want
## to continue supporting only C libraries so you can alwyas use the backend of
## your choice. We are binding `cimgui <https://github.com/Extrawurst/cimgui.git>`_
## which is a thin c wrapper of the c++ version. It is up to date and has great
## support.

# WIP

when defined(imguiDLL):
  when defined(windows):
    const
      imgui_dll* = "imgui.dll"
  elif defined(macosx):
    const
      imgui_dll* = "libimgui.dylib"
  else:
    const
      imgui_dll* = "libimgui.so"
  {.pragma: imgui_lib, dynlib: imgui_dll, cdecl.}
else:
  {.compile: "private/imgui/imgui/imgui.cpp",
    compile: "private/imgui/imgui/imgui_draw.cpp",
    compile: "private/imgui/imgui/imgui_demo.cpp",
    compile: "private/imgui/src/cimgui.cpp",
    compile: "private/imgui/src/drawList.cpp",
    compile: "private/imgui/src/fontAtlas.cpp",
    compile: "private/imgui/src/listClipper.cpp".}
  {.pragma: imgui_lib, cdecl.}

proc test* =
  echo "it worked?"