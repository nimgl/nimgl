# Copyright 2018, NimGL contributors.

import nimgl/imgui, nimgl/imgui/[impl_opengl, impl_glfw]
import nimgl/[opengl, glfw]

proc main() =
  assert glfwInit()

  glfwWindowHint(whContextVersionMajor, 4)
  glfwWindowHint(whContextVersionMinor, 1)
  glfwWindowHint(whOpenglForwardCompat, GLFW_TRUE)
  glfwWindowHint(whOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(whResizable, GLFW_FALSE)

  var w: GLFWWindow = glfwCreateWindow(1280, 720)
  if w == nil:
    quit(-1)

  w.makeContextCurrent()

  assert glInit()

  let context = igCreateContext()
  #let io = igGetIO()

  assert igGlfwInitForOpenGL(w, true)
  assert igOpenGL3Init()

  igStyleColorsDark()

  var show_demo: bool = true
  var somefloat: float32 = 0.0f
  var counter: int32 = 0

  while not w.windowShouldClose:
    glfwPollEvents()

    igOpenGL3NewFrame()
    igGlfwNewFrame()
    igNewFrame()

    if show_demo:
      igShowDemoWindow(show_demo.addr)

    # Simple window
    igBegin("Hello, world!")

    igText("This is some useful text.")
    igCheckbox("Demo Window", show_demo.addr)

    igSliderFloat("float", somefloat.addr, 0.0f, 1.0f)

    if igButton("Button", ImVec2(x: 0, y: 0)):
      counter.inc
    igSameLine()
    igText("counter = %d", counter)

    igText("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / igGetIO().framerate, igGetIO().framerate)
    igEnd()
    # End simple window

    igRender()

    glClearColor(0.45f, 0.55f, 0.60f, 1.00f)
    glClear(GL_COLOR_BUFFER_BIT)

    igOpenGL3RenderDrawData(igGetDrawData())

    w.swapBuffers()

  igOpenGL3Shutdown()
  igGlfwShutdown()
  context.igDestroyContext()

  w.destroyWindow()
  glfwTerminate()

main()
