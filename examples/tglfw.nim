# Copyright 2018, NimGL contributors.

import nimgl/glfw, os

if os.getEnv("CI") != "":
  quit()

proc main =
  assert glfwInit()

  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE)
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(GLFWResizable, GLFW_FALSE)

  var monitor = glfwGetPrimaryMonitor()

  var videoMode = monitor.getVideoMode()
  echo videoMode.width
  echo videoMode.height

  let w = glfwCreateWindow(800, 600, "NimGL", nil, nil)
  assert w != nil

  w.makeContextCurrent()

  while not w.windowShouldClose():
    w.swapBuffers()
    glfwPollEvents()
    w.setWindowShouldClose(true)

  w.destroyWindow
  glfwTerminate()

main()
