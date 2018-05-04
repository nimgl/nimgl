# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## ImGUI Module
## ====
## `return <../nimgl.html>`_.  
## 
## This bindings follow most of the original library
## You can check the original documentation `here <https://github.com/ocornut/imgui/blob/master/imgui.cpp>`_.
## 
## Do to this library most of the binding libraries are written in C, we want
## to continue supporting only C libraries so you can alwyas use the backend of
## your choice. We are binding `cimgui <https://github.com/Extrawurst/cimgui.git>`_
## which is a thin c wrapper of the c++ version. It is up to date and has great
## support.
## 
## NOTE: Unless you want to compile witch cpp please provide a dll of the library,
## made with cimgui.
## 
## Even tho we try to keep this bindings the closes to the source, this one specially
## needs some extra work to fully function with glfw, so there are some helper functions
## to help with the proccess
## 
## HACK: If you are on windows be sure to compile the cimgui dll with visual studio and
## not with mingw.

# WIP

import
  glfw, math/vector

when not defined(imguiSrc):
  when defined(windows):
    const imgui_dll* = "cimgui.dll"
  elif defined(macosx):
    const imgui_dll* = "cimgui.dylib"
  else:
    const imgui_dll* = "cimgui.so"
  {.pragma: imgui_lib, dynlib: imgui_dll, cdecl.}
else:
  {.compile: "private/imgui/imgui/imgui.cpp",
    compile: "private/imgui/imgui/imgui_draw.cpp",
    compile: "private/imgui/imgui/imgui_demo.cpp",
    compile: "private/imgui/cimgui/cimgui.cpp",
    compile: "private/imgui/cimgui/drawList.cpp",
    compile: "private/imgui/cimgui/fontAtlas.cpp",
    compile: "private/imgui/cimgui/listClipper.cpp" .}
  {.pragma: imgui_lib, cdecl.}

type
  IGKey* {.size: cint.sizeof.} = enum
    ## This are bounded to the GLFW Keybinds after the init so please keep using
    ## the glfw keys.
    ikTab = "tab"
    ikLeftArrow = "left_arrow"
    ikRightArrow = "right_arrow"
    ikUpArrow = "up_arrow"
    ikDownArrow = "down_arrow"
    ikPageUp = "page_up"
    ikPageDown = "page_down"
    ikHome = "home"
    ikEnd = "end"
    ikDelete = "delete"
    ikBackspace = "backspace"
    ikEnter = "enter"
    ikEscape = "escape"
    ikA = "a"
    ikC = "c"
    ikV = "v"
    ikX = "x"
    ikY = "y"
    ikZ = "z"
    ikCOUNT = "count"

  IGCursors* {.size: cint.sizeof.} = enum
    cNone = (-1, "none")
    cArrow = (0, "arrow")
    cTextInput = "text_input"
    cMove = "move"
    cResizeNS = "resize_ns"
    cResizeEW = "resize_ew"
    cResizeNESW = "resize_nesw"
    cResizeNWSE = "resize_nwse"
    cCount = "count"

  Context* = ptr object
    ## ImGUI context object

  GetCBProc = proc (window: Window): cstring {.cdecl.}
  SetCPProc = proc (window: Window, text: cstring): void {.cdecl.}

  ImVec2* = tuple
    x: float32
    y: float32
  ImVec4* = tuple
    x: float32
    y: float32
    z: float32
    w: float32

  IO* {.importc: "struct ImGuiIO".} = ptr object
    ## This is where your app communicate with ImGui. Access via getIO().
    KeyMap: array[512, int32]
    KeysDown: array[512, bool]
    GetClipboardTextFn: GetCBProc
    SetClipboardTextFn: SetCPProc
    ClipboardUserData: pointer
    ImeWindowHandle: pointer
    MouseWheel: float32
    MouseWheelH: float32
    KeyCtrl: bool
    KeyAlt : bool
    KeyShift: bool
    KeySuper: bool
    DisplaySize: ImVec2
    DisplayFramebufferScale: ImVec2
    DeltaTime: float32
    MousePos: ImVec2
    MouseDown: array[5, bool]

var
  gWindow: Window
    ## Wingow of glfw to bind the process to
  gCursors: array[cCount.ord, glfw.Cursor]
    ## Glfw Window Cursors
  gMousePressed: array[3, bool]
  glslVer: cstring
    ## Version of glsl to use
  gFontTexture: uint32 = 0
    ## Texture id of opengl
  gTime: cdouble
  
proc getIO*(): IO {.imgui_lib, importc: "igGetIO".}
proc newFrame*() {.imgui_lib, importc: "igNewFrame".}
proc render*() {.imgui_lib, importc: "igRender".}

# proc text*(format: cstring, args: varargs[untyped]) {.imgui_lib, importc: "igText".}
# unstable https://github.com/nim-lang/Nim/issues/1154
proc text*(format: cstring) {.imgui_lib, importc: "igText".}

proc createContext*(malloc: pointer = nil, free: pointer = nil): Context {.imgui_lib, importc: "igCreateContext".}

proc destroyContext*(ctx: Context): void {.imgui_lib, importc: "igDestroyContext".}
proc addInputCharacter*(c: cushort): void {.imgui_lib, importc: "ImGuiIO_AddInputCharacter".}

proc styleColorsClassic*(dst: pointer = nil): void {.imgui_lib, importc: "igStyleColorsClassic".}
proc styleColorsDark*(dst: pointer = nil): void {.imgui_lib, importc: "igStyleColorsDark".}
proc styleColorsLight*(dst: pointer = nil): void {.imgui_lib, importc: "igStyleColorsLight".}

# GLFW Integration | Example
# Please redo this integration if you plan on having more control over imgui.
# You can refer to this one to make your own.

proc getClipboardText*(window: Window): cstring {.cdecl.} =
  ## Get the clipboard Text data
  window.getClipboardString()

proc setClipboardText*(window: Window, text: cstring) {.cdecl.} =
  ## Set the clipboard Text data
  window.setClipboardString(text)

proc keyProc(window: Window, key: glfw.Key, scancode: cint, action: KeyAction, mods: KeyMod){.cdecl.} =
  var io = getIO()
  io.KeysDown[key.ord] = action != kaRelease

  io.KeyCtrl  = io.KeysDown[keyLeftControl.ord] or io.KeysDown[keyRightControl.ord]
  io.KeyShift = io.KeysDown[keyLeftShift.ord]   or io.KeysDown[keyRightShift.ord]
  io.KeyAlt   = io.KeysDown[keyLeftAlt.ord]     or io.KeysDown[keyRightAlt.ord]
  io.KeySuper = io.KeysDown[keyLeftSuper.ord]   or io.KeysDown[keyRightSuper.ord]

proc mouseProc(window: Window, button: MouseButton, action: MouseAction, mods: KeyMod): void {.cdecl.} =
  if action == maPress and button.ord >= 0 and button.ord < 3:
    gMousePressed[button.ord] = true

proc scrollProc(window: Window, xoff, yoff: cdouble): void {.cdecl.} =
  var io = getIO()
  io.MouseWheelH += float32(xoff)
  io.MouseWheel  += float32(yoff)

proc charProc(window: Window, c: cuint): void {.cdecl.} =
  if c > cuint(0) and c < cuint(0x10000):
    addInputCharacter(cushort(c))

proc installCallbacks(window: Window): void =
  window.setKeyCallback(keyProc)
  window.setMouseButtonCallback(mouseProc)
  window.setScrollCallback(scrollProc)
  window.setCharCallback(charProc)

proc init*(window: Window, installCallbacks: bool, glslVersion: int = 150): bool =
  ## Starts glfw integration
  gWindow = window

  glslVer = "#version " & $glslVersion & "\n"
  
  var io = getIO()
  io.KeyMap[ikTab.ord]        = keyTab.ord
  io.KeyMap[ikLeftArrow.ord]  = keyLeft.ord
  io.KeyMap[ikRightArrow.ord] = keyRight.ord
  io.KeyMap[ikUpArrow.ord]    = keyUp.ord
  io.KeyMap[ikDownArrow.ord]  = keyDown.ord
  io.KeyMap[ikPageUp.ord]     = keyPage_up.ord
  io.KeyMap[ikPageDown.ord]   = keyPage_down.ord
  io.KeyMap[ikHome.ord]       = keyHome.ord
  io.KeyMap[ikEnd.ord]        = keyEnd.ord
  io.KeyMap[ikDelete.ord]     = keyDelete.ord
  io.KeyMap[ikBackspace.ord]  = keyBackspace.ord
  io.KeyMap[ikEnter.ord]      = keyEnter.ord
  io.KeyMap[ikEscape.ord]     = keyEscape.ord
  io.KeyMap[ikA.ord]          = keyA.ord
  io.KeyMap[ikC.ord]          = keyC.ord
  io.KeyMap[ikV.ord]          = keyV.ord
  io.KeyMap[ikX.ord]          = keyX.ord
  io.KeyMap[ikY.ord]          = keyY.ord
  io.KeyMap[ikZ.ord]          = keyZ.ord

  io.GetClipboardTextFn = getClipboardText
  io.SetClipboardTextFn = setClipboardText
  io.ClipboardUserData  = window

  when defined(windows):
    io.ImeWindowHandle = window.getWin32Window

  gCursors[cArrow.ord]      = createStandardCursor(csArrow)
  gCursors[cTextInput.ord]  = createStandardCursor(csIbeam);
  gCursors[cMove.ord]       = createStandardCursor(csHand);
  gCursors[cResizeNS.ord]   = createStandardCursor(csVresize);
  gCursors[cResizeEW.ord]   = createStandardCursor(csHresize);
  gCursors[cResizeNESW.ord] = createStandardCursor(csArrow);
  gCursors[cResizeNWSE.ord] = createStandardCursor(csArrow);

  if installCallbacks: installCallbacks(window)
  return true

proc createDeviceObjects() =
  echo 'a'

proc implNewFrame*() =
  if gFontTexture == 0:
    createDeviceObjects()

  var
    io: IO = getIO()
    wSize: Vec2[int32]
    dSize: Vec2[int32]

  gWindow.getWindowSize(wSize.x, wSize.y)
  gWindow.getFrameBufferSize(dSize.x, dSize.y)

  io.DisplaySize = (wSize.x.float32, wSize.y.float32)
  io.DisplayFramebufferScale = (
    (if wSize.x > 0: dSize.x.float32 / wSize.x.float32 else: 0'f32),
    (if wSize.y > 0: dSize.y.float32 / wSize.y.float32 else: 0'f32),
  )

  let currentTime = getTime()
  io.DeltaTime = if gTime > 0: currentTime.float32 - gTime.float32 else: 1'f32 / 60'f32
  gTime = currentTime

  if gWindow.getWindowAttrib(whFocused) > 0:
    var mousePos: Vec2[cdouble]
    gWindow.getCursorPos(mousePos.x, mousePos.y)
    io.MousePos = (mousePos.x.float32, mousePos.y.float32)
  else:
    io.MousePos = (-float32.high, -float32.high)

  for i in 0..<3:
    io.MouseDown[i] = gMousePressed[i] or gWindow.getMouseButton(i.int32) != 0
    gMousePressed[i] = false

  newFrame()

proc shutdown*(): void =
  ## Destroy the glfw integration
  for n in 0 ..< gCursors.len:
    destroyCursor(gCursors[n])
