# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## Math Module
## ====
## `return <../nimgl.html>`_.  
## 
## A Math library that helps with linear algebra. It is built on the idea
## to directly interact with opengl.
## 
## This module exposes the std math's module and is packed together with
## useful functions to help interface with opengl. We use the std math's module
## to avoid rewriting what has already been writen.
## 
## NOTE: All of this library is using int32, uint32 and float32 to be able to interact
## with C. please don't forget to put 'i32, 'ui32 and 'f32 we have some converters
## but don't rely on them.
## 
## NOTE: Also everything in here is in Radians so use the radToDeg and degToRad to
## convert back and forth
## 
## NOTE: This library is made for graphics engines so if you want to do more advanced
## linear algebra stuff please use `Neo <https://github.com/unicredit/neo>`_.
## 
## Math Stuff
## - `vectors  <./math/vector.html>`_ Window Library
## - `matrices  <./math/matrix.html>`_ Glew Loading Library

import
  pure/math,
  math/vector,
  math/matrix

export
  math,
  vector,
  matrix
