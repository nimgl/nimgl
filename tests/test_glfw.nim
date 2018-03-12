# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import 
  nimgl/glfw,
  nimgl/opengl,
  nimgl/math

proc keyProc(window: Window, key: Key, scancode: cint, action: KeyAction, mods: KeyMod): void {.cdecl.} =
  if key == keyESCAPE and action == kaPress:
    window.setWindowShouldClose(true)

proc main =
  assert glfw.init()

  var config = defaultWindowConfig()
  config.size.width  = 1280
  config.size.height = 720

  windowHint(whCONTEXT_VERSION_MAJOR, 4);
  windowHint(whCONTEXT_VERSION_MINOR, 1);
  windowHint(whOPENGL_FORWARD_COMPAT, glfwTRUE);
  windowHint(whOPENGL_PROFILE, glfwOPENGL_CORE_PROFILE);
  windowHint(whRESIZABLE, glfwFalse);
  windowHint(whDECORATED, glfwTrue);
  windowHint(whREFRESH_RATE, glfwDontCare);

  var w: Window = createWindow(config)
  w.setKeyCallback(keyProc)
  assert w != nil

  w.makeContextCurrent

  while not w.windowShouldClose:
    w.swapBuffers
    glfw.pollEvents()

  w.destroyWindow
  glfw.terminate()

main()