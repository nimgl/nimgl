# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import 
  nimgl/glfw,
  nimgl/opengl,
  nimgl/math,
  os

proc keyProc(window: Window, key: Key, scancode: cint, action: KeyAction, mods: KeyMod): void {.cdecl.} =
  if key == keyESCAPE and action == kaPress:
    window.setWindowShouldClose(true)

proc main =
  assert glfw.init()

  windowHint(whContextVersionMajor, 4);
  windowHint(whContextVersionMinor, 1);
  windowHint(whOpenglForwardCompat, glfwTRUE);
  windowHint(whOpenglProfile      , glfwOpenglCoreProfile);
  windowHint(whResizable          , glfwFalse);
  windowHint(whDecorated          , glfwTrue);
  windowHint(whRefreshRate        , glfwDontCare);

  echo getCurrentDir()

  var w: Window = createWindow(300, 300, "NimGL")
  assert w != nil

  w.setKeyCallback(keyProc)
  w.makeContextCurrent

  while not w.windowShouldClose:
    glClear(glColorBufferBit)
    glClearColor(0.0, 1.0, 0.0, 1.0)

    w.swapBuffers
    glfw.pollEvents()

  w.destroyWindow
  glfw.terminate()

main()