# Copyright 2019, NimGL contributors.

## ImGUI Bindings
## ====
## WARNING: This is a generated file. Do not edit
## Any edits will be overwritten by the genearator.
##
## The aim is to achieve as much compatibility with C as possible.
## Optional helper functions have been created as a submodule
## ``imgui/imgui_helpers`` to better bind this library to Nim.
##
## You can check the original documentation `here <https://github.com/ocornut/imgui/blob/master/imgui.cpp>`_.
##
## Source language of ImGui is C++, since Nim is able to compile both to C
## and C++ you can select which compile target you wish to use. Note that to use
## the C backend you must supply a `cimgui <https://github.com/cimgui/cimgui>`_
## dynamic library file.
##
## HACK: If you are targeting Windows, be sure to compile the cimgui dll with
## visual studio and not with mingw.

# import strutils

# proc currentSourceDir(): string {.compileTime.} =
#   result = currentSourcePath().replace("\\", "/")
#   result = result[0 ..< result.rfind("/")]

# {.passc: "-I" & currentSourceDir() & "/private/imgui/src/imgui/private" & " -DIMGUI_DISABLE_OBSOLETE_FUNCTIONS=1".}

import ./private/imgui/src/imgui
export imgui
