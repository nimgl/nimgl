# Copyright 2018, NimGL contributors.

import nimgl/glfw, os

if os.getEnv("CI") != "":
  quit()

proc main =
  assert glfwInit()

  glfwWindowHint(whContextVersionMajor, 4)
  glfwWindowHint(whContextVersionMinor, 1)
  glfwWindowHint(whOpenglForwardCompat, GLFW_TRUE)
  glfwWindowHint(whOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(whResizable, GLFW_FALSE)

  var w = glfwCreateWindow(800, 600)
  assert w != nil

  w.makeContextCurrent

  while not w.windowShouldClose:
    w.swapBuffers()
    glfwPollEvents()
    w.setWindowShouldClose(true)

  w.destroyWindow
  glfwTerminate()

main()
