# Copyright 2018, NimGL contributors.

## ImGUI GLFW Implementation
## ====
## Implementation based on the imgui examples implementations.
## Feel free to use and modify this implementation.
## This needs to be used along with a Renderer.

import ../imgui, ../glfw

type
  GlfwClientApi = enum
    igGlfwClientApi_Unkown
    igGlfwClientApi_OpenGl
    igGlfwClientApi_Vulkan

var
  gWindow: GLFWwindow
  gClientApi = igGlfwClientApi_Unkown
  gTime: float64 = 0.0f
  gMouseJustPressed: array[5, bool]
  gMouseCursors: array[ImGuiMouseCursor_COUNT, GLFWCursor]

  # Store previous callbacks so they can be chained
  gPrevMouseButtonCallback: glfwMouseButtonProc = nil
  gPrevScrollCallback: glfwScrollProc = nil
  gPrevKeyCallback: glfwKeyProc = nil
  gPrevCharCallback: glfwCharProc = nil

proc igGlfwGetClipboardText(user_data: pointer): cstring {.cdecl.} =
  cast[GLFWwindow](user_data).getClipboardString()

proc igGlfwSetClipboardText(user_data: pointer, text: cstring): void {.cdecl.} =
  cast[GLFWwindow](user_data).setClipboardString(text)

proc igGlfwMouseCallback*(window: GLFWWindow, button: GLFWMouseButton, action: GLFWMouseAction, mods: GLFWKeyMod): void {.cdecl.} =
  if gPrevMouseButtonCallback != nil:
    gPrevMouseButtonCallback(window, button, action, mods)

  if action == maPress and button.ord >= 0 and button.ord < gMouseJustPressed.len:
    gMouseJustPressed[button.ord] = true

proc igGlfwScrollCallback*(window: GLFWWindow, xoff: float64, yoff: float64): void {.cdecl.} =
  if gPrevScrollCallback != nil:
    gPrevScrollCallback(window, xoff, yoff)

  let io = igGetIO()
  io.mouseWheelH += xoff.float32
  io.mouseWheel += yoff.float32

proc igGlfwKeyCallback*(window: GLFWWindow, key: GLFWKey, scancode: int32, action: GLFWKeyAction, mods: GLFWKeyMod): void {.cdecl.} =
  if gPrevKeyCallback != nil:
    gPrevKeyCallback(window, key, scancode, action, mods)

  let io = igGetIO()
  if key.ord < 511 and key.ord >= 0:
    if action == kaPress:
      io.keysDown[key.ord] = true
    elif action == kaRelease:
      io.keysDown[key.ord] = false

  io.keyCtrl = io.keysDown[keyLeftControl.ord] or io.keysDown[keyRightControl.ord]
  io.keyShift = io.keysDown[keyLeftShift.ord] or io.keysDown[keyRightShift.ord]
  io.keyAlt = io.keysDown[keyLeftAlt.ord] or io.keysDown[keyRightAlt.ord]
  io.keySuper = io.keysDown[keyLeftSuper.ord] or io.keysDown[keyRightSuper.ord]

proc igGlfwCharCallback*(window: GLFWWindow, code: uint32): void {.cdecl.} =
  if gPrevCharCallback != nil:
    gPrevCharCallback(window, code)

  let io = igGetIO()
  if code > 0'u32 and code < 0x10000'u32:
    io.addInputCharacter(cast[ImWchar](code))

proc igGlfwInstallCallbacks(window: GLFWwindow) =
  # The already set callback proc should be returned. Store these and and chain callbacks.
  gPrevMouseButtonCallback = gWindow.setMouseButtonCallback(igGlfwMouseCallback)
  gPrevScrollCallback = gWindow.setScrollCallback(igGlfwScrollCallback)
  gPrevKeyCallback = gWindow.setKeyCallback(igGlfwKeyCallback)
  gPrevCharCallback = gWindow.setCharCallback(igGlfwCharCallback)

proc igGlfwInit(window: GLFWwindow, install_callbacks: bool, client_api: GlfwClientApi): bool =
  gWindow = window
  gTime = 0.0f

  let io = igGetIO()
  io.backendFlags = io.backendFlags or ImGuiBackendFlags_HasMouseCursors
  io.backendFlags = io.backendFlags or ImGuiBackendFlags_HasSetMousePos

  io.keyMap[ImGuiKey_Tab] = keyTab.ord
  io.keyMap[ImGuiKey_LeftArrow] = keyLeft.ord
  io.keyMap[ImGuiKey_RightArrow] = keyRight.ord
  io.keyMap[ImGuiKey_UpArrow] = keyUp.ord
  io.keyMap[ImGuiKey_DownArrow] = keyDown.ord
  io.keyMap[ImGuiKey_PageUp] = keyPage_up.ord
  io.keyMap[ImGuiKey_PageDown] = keyPage_down.ord
  io.keyMap[ImGuiKey_Home] = keyHome.ord
  io.keyMap[ImGuiKey_End] = keyEnd.ord
  io.keyMap[ImGuiKey_Insert] = keyInsert.ord
  io.keyMap[ImGuiKey_Delete] = keyDelete.ord
  io.keyMap[ImGuiKey_Backspace] = keyBackspace.ord
  io.keyMap[ImGuiKey_Space] = keySpace.ord
  io.keyMap[ImGuiKey_Enter] = keyEnter.ord
  io.keyMap[ImGuiKey_Escape] = keyEscape.ord
  io.keyMap[ImGuiKey_A] = keyA.ord
  io.keyMap[ImGuiKey_C] = keyC.ord
  io.keyMap[ImGuiKey_V] = keyV.ord
  io.keyMap[ImGuiKey_X] = keyX.ord
  io.keyMap[ImGuiKey_Y] = keyY.ord
  io.keyMap[ImGuiKey_Z] = keyZ.ord

  # HELP: If you know how to convert char * to const char * through Nim pragmas
  # and types, I would love to know.
  when not defined(cpp):
    io.setClipboardTextFn = igGlfwSetClipboardText
    io.getClipboardTextFn = igGlfwGetClipboardText
  io.clipboardUserData = gWindow
  when defined windows:
    io.imeWindowHandle = gWindow.getWin32Window()

  gMouseCursors[ImGuiMouseCursor_Arrow] = glfwCreateStandardCursor(csArrow)
  gMouseCursors[ImGuiMouseCursor_TextInput] = glfwCreateStandardCursor(csIbeam)
  gMouseCursors[ImGuiMouseCursor_ResizeAll] = glfwCreateStandardCursor(csArrow)
  gMouseCursors[ImGuiMouseCursor_ResizeNS] = glfwCreateStandardCursor(csVresize)
  gMouseCursors[ImGuiMouseCursor_ResizeEW] = glfwCreateStandardCursor(csHresize)
  gMouseCursors[ImGuiMouseCursor_ResizeNESW] = glfwCreateStandardCursor(csArrow)
  gMouseCursors[ImGuiMouseCursor_ResizeNWSE] = glfwCreateStandardCursor(csArrow)
  gMouseCursors[ImGuiMouseCursor_Hand] = glfwCreateStandardCursor(csHand)

  if install_callbacks:
    igGlfwInstallCallbacks(window)

  gClientApi = client_api
  return true

proc igGlfwInitForOpenGL*(window: GLFWwindow, install_callbacks: bool): bool =
  igGlfwInit(window, install_callbacks, igGlfwClientApi_OpenGL)

# @TODO: Vulkan support

proc igGlfwUpdateMousePosAndButtons() =
  let io = igGetIO()
  for i in 0 ..< io.mouseDown.len:
    io.mouseDown[i] = gMouseJustPressed[i] or gWindow.getMouseButton(i.int32) != 0
    gMouseJustPressed[i] = false

  let mousePosBackup = io.mousePos
  io.mousePos = ImVec2(x: -high(float32), y: -high(float32))

  when defined(emscripten): # TODO: actually add support for all the library with emscripten
    let focused = true
  else:
    let focused = gWindow.getWindowAttrib(whFocused) != 0

  if focused:
    if io.wantSetMousePos:
      gWindow.setCursorPos(mousePosBackup.x, mousePosBackup.y)
    else:
      var mouseX: float64
      var mouseY: float64
      gWindow.getCursorPos(mouseX.addr, mouseY.addr)
      io.mousePos = ImVec2(x: mouseX.float32, y: mouseY.float32)

proc igGlfwUpdateMouseCursor() =
  let io = igGetIO()
  if (io.configFlags and ImGuiConfigFlags_NoMouseCursorChange) or (gWindow.getInputMode(EGLFW_CURSOR) == GLFW_CURSOR_DISABLED):
    return

  var igCursor: ImGuiMouseCursor = igGetMouseCursor()
  if igCursor == ImGuiMouseCursor_None or io.mouseDrawCursor:
    gWindow.setInputMode(EGLFW_CURSOR, GLFW_CURSOR_HIDDEN)
  else:
    gWindow.setInputMode(EGLFW_CURSOR, GLFW_CURSOR_NORMAL)

proc igGlfwNewFrame*() =
  let io = igGetIO()
  assert io.fonts.isBuilt()

  var w: int32
  var h: int32
  var displayW: int32
  var displayH: int32

  gWindow.getWindowSize(w.addr, h.addr)
  gWindow.getFramebufferSize(displayW.addr, displayH.addr)
  io.displaySize = ImVec2(x: w.float32, y: h.float32)
  io.displayFramebufferScale = ImVec2(x: if w > 0: displayW.float32 / w.float32 else: 0.0f, y: if h > 0: displayH.float32 / h.float32 else: 0.0f)

  let currentTime = glfwGetTime()
  io.deltaTime = if gTime > 0.0f: (currentTime - gTime).float32 else: (1.0f / 60.0f).float32
  gTime = currentTime

  igGlfwUpdateMousePosAndButtons()
  igGlfwUpdateMouseCursor()

  # @TODO: gamepad mapping

proc igGlfwShutdown*() =
  for i in 0 ..< ImGuiMouseCursor_COUNT:
    glfwDestroyCursor(gMouseCursors[i])
    gMouseCursors[i] = nil
  gClientApi = igGlfwClientApi_Unkown
