# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import
  nimgl/glfw

proc main =
  assert init()

  windowHint whContextVersionMajor, 4
  windowHint whContextVersionMinor, 1
  windowHint whOpenglForwardCompat, glfwTRUE
  windowHint whOpenglProfile      , glfwOpenglCoreProfile
  windowHint whResizable          , glfwFalse
  windowHint whDecorated          , glfwTrue
  windowHint whRefreshRate        , glfwDontCare

  var w = createWindow(800, 600, "tglfw")
  assert w != nil
  
  w.makeContextCurrent

  while not w.windowShouldClose:
    w.swapBuffers
    pollEvents()
    w.setWindowShouldClose true

  w.destroyWindow
  terminate()

main()
