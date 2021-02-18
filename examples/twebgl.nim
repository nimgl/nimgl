import nimgl/glfw, opengl

proc keyProc(window: GLFWWindow, key: int32, scancode: int32,
             action: int32, mods: int32): void {.cdecl.} =
  if key == GLFWKey.ESCAPE and action == GLFWPress:
    window.setWindowShouldClose(true)

when defined(emscripten):
  proc emscripten_set_main_loop(f: proc() {.cdecl.}, a: cint, b: bool) {.importc.}

var window: GLFWWindow

proc tick() {.cdecl.} =
  glfwPollEvents()
  glClearColor(0.68f, 1f, 0.34f, 1f)
  glClear(GL_COLOR_BUFFER_BIT)
  window.swapBuffers()

proc main() =
  assert glfwInit()

  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE) # Used for Mac
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(GLFWResizable, GLFW_FALSE)

  window = glfwCreateWindow(800, 600, "NimGL")
  if window == nil:
    quit(-1)

  discard window.setKeyCallback(keyProc)
  window.makeContextCurrent()

  assert glInit()

  when defined(emscripten):
    emscripten_set_main_loop(tick, 0, true)
  else:
    while not window.windowShouldClose:
      tick()

  window.destroyWindow()
  glfwTerminate()

main()
