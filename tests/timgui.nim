import nimgl/[glfw, opengl, imgui]

proc keyProc(window: GLFWWindow, key: GLFWKey, scancode: int32, action: GLFWKeyAction, mods: GLFWKeyMod): void {.cdecl.} =
  if key == keyESCAPE and action == kaPress:
    window.setWindowShouldClose(true)

proc main() =
  assert glfwInit()

  glfwWindowHint(whContextVersionMajor, 4)
  glfwWindowHint(whContextVersionMinor, 1)
  glfwWindowHint(whOpenglForwardCompat, GLFW_TRUE)
  glfwWindowHint(whOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(whResizable, GLFW_FALSE)

  var w: GLFWWindow = glfwCreateWindow(800, 600, "NimGL", nil, nil)
  if w == nil:
    quit(-1)

  discard w.setKeyCallback(keyProc)
  w.makeContextCurrent()

  assert glInit()

  echo "ImGui v" & $igGetVersion()
  let context = igCreateContext(nil)
  let io = igGetIO()

  var tex_pixels: ptr char
  var tex_w: int32
  var tex_h: int32
  imFontAtlas_GetTexDataAsRGBA32(tex_pixels.addr, tex_w.addr, tex_h.addr, nil)

  while not w.windowShouldClose:
    glfwPollEvents()

    glClearColor(0.68f, 1f, 0.34f, 1f)
    glClear(GL_COLOR_BUFFER_BIT)

    w.swapBuffers()

  context.igDestroyContext()
  w.destroyWindow()
  glfwTerminate()

main()
