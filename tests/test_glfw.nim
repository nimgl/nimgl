# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import 
  nimgl/glfw,
  nimgl/math,
  nimgl/glew

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

  var w: Window = createWindow(1280, 720, "NimGL")
  assert w != nil

  w.setKeyCallback(keyProc)
  w.makeContextCurrent

  assert glew.init() == GLEW_OK

  glEnable(GL_BLEND)
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

  while not w.windowShouldClose:
    glClearColor(0.13, 0.13, 0.13, 1)
    glClear(GL_COLOR_BUFFER_BIT)
    w.swapBuffers
    glfw.pollEvents()

  w.destroyWindow
  glfw.terminate()

main()