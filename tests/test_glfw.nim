# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import 
  nimgl/glfw,
  nimgl/opengl,
  nimgl/math

proc keyProc(window: Window, key: Key, scancode: cint, action: KeyAction, mods: KeyMods): void {.cdecl.} =
  if key == keyESCAPE and action == kaPress:
    window.setWindowShouldClose(true)

proc main =
  assert glfw.init()

  var config = defaultWindowConfig()
  config.size.width  = 1280
  config.size.height = 720

  var w: Window = createWindow(config)
  w.setKeyCallback(keyProc)
  assert w != nil

  w.makeContextCurrent

  while not w.windowShouldClose:
    echo getTime()
    w.swapBuffers
    glfw.pollEvents()

  w.destroyWindow
  glfw.terminate()

main()