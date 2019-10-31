# Copyright 2019, NimGL contributors.

## ImGUI GLFW Implementation
## ====
## Implementation based on the imgui examples implementations.
## Feel free to use and modify this implementation.
## This needs to be used along with a Renderer.

import ../imgui, ../glfw, ../glfw/native

type
  GlfwClientApi = enum
    igGlfwClientApiUnkown
    igGlfwClientApiOpenGl
    igGlfwClientApiVulkan

var
  gWindow: GLFWwindow
  gClientApi = igGlfwClientApiUnkown
  gTime: float64 = 0.0f
  gMouseJustPressed: array[5, bool]
  gMouseCursors: array[ImGuiMouseCursor.high.int32 + 1, GLFWCursor]

  # Store previous callbacks so they can be chained
  gPrevMouseButtonCallback: GLFWMousebuttonFun = nil
  gPrevScrollCallback: GLFWScrollFun = nil
  gPrevKeyCallback: GLFWKeyFun = nil
  gPrevCharCallback: GLFWCharFun = nil

proc igGlfwGetClipboardText(userData: pointer): cstring {.cdecl.} =
  cast[GLFWwindow](userData).getClipboardString()

proc igGlfwSetClipboardText(userData: pointer, text: cstring): void {.cdecl.} =
  cast[GLFWwindow](userData).setClipboardString(text)

proc igGlfwMouseCallback*(window: GLFWWindow, button: int32, action: int32, mods: int32): void {.cdecl.} =
  if gPrevMouseButtonCallback != nil:
    gPrevMouseButtonCallback(window, button, action, mods)

  if action == GLFWPress and button.ord >= 0 and button.ord < gMouseJustPressed.len:
    gMouseJustPressed[button.ord] = true

proc igGlfwScrollCallback*(window: GLFWWindow, xoff: float64, yoff: float64): void {.cdecl.} =
  if gPrevScrollCallback != nil:
    gPrevScrollCallback(window, xoff, yoff)

  let io = igGetIO()
  io.mouseWheelH += xoff.float32
  io.mouseWheel += yoff.float32

proc igGlfwKeyCallback*(window: GLFWWindow, key: int32, scancode: int32, action: int32, mods: int32): void {.cdecl.} =
  if gPrevKeyCallback != nil:
    gPrevKeyCallback(window, key, scancode, action, mods)

  let io = igGetIO()
  if key.ord < 511 and key.ord >= 0:
    if action == GLFWPress:
      io.keysDown[key.ord] = true
    elif action == GLFWRelease:
      io.keysDown[key.ord] = false

  io.keyCtrl = io.keysDown[GLFWKey.LeftControl.ord] or io.keysDown[GLFWKey.RightControl.ord]
  io.keyShift = io.keysDown[GLFWKey.LeftShift.ord] or io.keysDown[GLFWKey.RightShift.ord]
  io.keyAlt = io.keysDown[GLFWKey.LeftAlt.ord] or io.keysDown[GLFWKey.RightAlt.ord]
  io.keySuper = io.keysDown[GLFWKey.LeftSuper.ord] or io.keysDown[GLFWKey.RightSuper.ord]

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

proc igGlfwInit(window: GLFWwindow, installCallbacks: bool, clientApi: GlfwClientApi): bool =
  gWindow = window
  gTime = 0.0f

  let io = igGetIO()
  io.backendFlags = (io.backendFlags.int32 or ImGuiBackendFlags.HasMouseCursors.int32).ImGuiBackendFlags
  io.backendFlags = (io.backendFlags.int32 or ImGuiBackendFlags.HasSetMousePos.int32).ImGuiBackendFlags

  io.keyMap[ImGuiKey.Tab.int32] = GLFWKey.Tab
  io.keyMap[ImGuiKey.LeftArrow.int32] = GLFWKey.Left
  io.keyMap[ImGuiKey.RightArrow.int32] = GLFWKey.Right
  io.keyMap[ImGuiKey.UpArrow.int32] = GLFWKey.Up
  io.keyMap[ImGuiKey.DownArrow.int32] = GLFWKey.Down
  io.keyMap[ImGuiKey.PageUp.int32] = GLFWKey.PageUp
  io.keyMap[ImGuiKey.PageDown.int32] = GLFWKey.PageDown
  io.keyMap[ImGuiKey.Home.int32] = GLFWKey.Home
  io.keyMap[ImGuiKey.End.int32] = GLFWKey.End
  io.keyMap[ImGuiKey.Insert.int32] = GLFWKey.Insert
  io.keyMap[ImGuiKey.Delete.int32] = GLFWKey.Delete
  io.keyMap[ImGuiKey.Backspace.int32] = GLFWKey.Backspace
  io.keyMap[ImGuiKey.Space.int32] = GLFWKey.Space
  io.keyMap[ImGuiKey.Enter.int32] = GLFWKey.Enter
  io.keyMap[ImGuiKey.Escape.int32] = GLFWKey.Escape
  io.keyMap[ImGuiKey.A.int32] = GLFWKey.A
  io.keyMap[ImGuiKey.C.int32] = GLFWKey.C
  io.keyMap[ImGuiKey.V.int32] = GLFWKey.V
  io.keyMap[ImGuiKey.X.int32] = GLFWKey.X
  io.keyMap[ImGuiKey.Y.int32] = GLFWKey.Y
  io.keyMap[ImGuiKey.Z.int32] = GLFWKey.Z

  # HELP: If you know how to convert char * to const char * through Nim pragmas
  # and types, I would love to know.
  when not defined(cpp):
    io.setClipboardTextFn = igGlfwSetClipboardText
    io.getClipboardTextFn = igGlfwGetClipboardText
  io.clipboardUserData = gWindow
  when defined windows:
    io.imeWindowHandle = gWindow.getWin32Window()

  gMouseCursors[ImGuiMouseCursor.Arrow.int32] = glfwCreateStandardCursor(GLFWArrowCursor)
  gMouseCursors[ImGuiMouseCursor.TextInput.int32] = glfwCreateStandardCursor(GLFWIbeamCursor)
  gMouseCursors[ImGuiMouseCursor.ResizeAll.int32] = glfwCreateStandardCursor(GLFWArrowCursor)
  gMouseCursors[ImGuiMouseCursor.ResizeNS.int32] = glfwCreateStandardCursor(GLFWVresizeCursor)
  gMouseCursors[ImGuiMouseCursor.ResizeEW.int32] = glfwCreateStandardCursor(GLFWHresizeCursor)
  gMouseCursors[ImGuiMouseCursor.ResizeNESW.int32] = glfwCreateStandardCursor(GLFWArrowCursor)
  gMouseCursors[ImGuiMouseCursor.ResizeNWSE.int32] = glfwCreateStandardCursor(GLFWArrowCursor)
  gMouseCursors[ImGuiMouseCursor.Hand.int32] = glfwCreateStandardCursor(GLFWHandCursor)

  if installCallbacks:
    igGlfwInstallCallbacks(window)

  gClientApi = clientApi
  return true

proc igGlfwInitForOpenGL*(window: GLFWwindow, installCallbacks: bool): bool =
  igGlfwInit(window, installCallbacks, igGlfwClientApiOpenGL)

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
    let focused = gWindow.getWindowAttrib(GLFWFocused) != 0

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
  if ((io.configFlags.int32 and ImGuiConfigFlags.NoMouseCursorChange.int32) == 1) or (gWindow.getInputMode(GLFWCursorSpecial) == GLFWCursorDisabled):
    return

  var igCursor: ImGuiMouseCursor = igGetMouseCursor()
  if igCursor == ImGuiMouseCursor.None or io.mouseDrawCursor:
    gWindow.setInputMode(GLFWCursorSpecial, GLFWCursorHidden)
  else:
    gWindow.setCursor(gMouseCursors[igCursor.int32])
    gWindow.setInputMode(GLFWCursorSpecial, GLFWCursorNormal)

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
  for i in 0 ..< ImGuiMouseCursor.high.int32 + 1:
    gMouseCursors[i].destroyCursor()
    gMouseCursors[i] = nil
  gClientApi = igGlfwClientApiUnkown
