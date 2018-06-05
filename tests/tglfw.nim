# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import
  nimgl/glfw, os

if os.getEnv("CI") != "":
  quit()

proc main =
  assert init()

  windowHint whContextVersionMajor, 4
  windowHint whContextVersionMinor, 1
  windowHint whOpenglForwardCompat, GLFW_TRUE
  windowHint whOpenglProfile      , GLFW_OPENGL_CORE_PROFILE
  windowHint whResizable          , GLFW_FALSE

  var w = createWindow(800, 600)
  assert w != nil

  w.makeContextCurrent

  while not w.windowShouldClose:
    w.swapBuffers
    pollEvents()
    w.setWindowShouldClose true

  w.destroyWindow
  terminate()

main()
