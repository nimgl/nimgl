# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import 
  nimgl/glfw

proc main =
  if glfwInit() != 1:
    echo "GLFW FAILED TO START"
    return

  var window = glfwCreateWindow(1280, 720, "NimGL", nil, nil)
  window.glfwMakeContextCurrent

  while window.glfwWindowShouldClose == 0:
    window.glfwSwapBuffers
    glfwPollEvents()

  window.glfwDestroyWindow
  glfwTerminate()

main()