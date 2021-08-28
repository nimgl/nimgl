# Copyright 2019, NimGL contributors.

## GLFW Bindings
## ====
## WARNING: This is a generated file. Do not edit
## Any edits will be overwritten by the generator.
##
## The aim is to achieve as much compatibility with C as possible.
## All procedures which have a GLFW object in the arguments won't have the glfw prefix.
## Turning ``glfwMakeContextCurrent(window)`` into ``window.makeContextCurrent()``.
##
## You can check the original documentation `here <http://www.glfw.org/docs/latest/>`_.
##
##  **By using the native access functions you assert that you know what you're
##  doing and how to fix problems caused by using them.  If you don't, you
##  shouldn't be using them.**
##
##  Please assert that you are using the right system for the right procedures.

import ../private/glfw/src/glfw/native
export native
