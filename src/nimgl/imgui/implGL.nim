# Copyright (C) CavariuX. All Rights Reserved
# Written by Leonardo Mariscal <lmariscal@pm.me>, 2018

## ImGUI OpenGl 3 Implementation Module
## ====
## `return <../imgui.html>`_.  
## 
## This is an implementation to test and show the usage of this bindings, if you
## are looking to use some simple debug tools feel free to use this implementation
## but if you want to write your own debug system, we highly recommend you to
## remake this implementation to have better control over ImGui.
##
## For more information about the bindings, go to the parent file.

import
  ../glfw, ../math/vector, ../imgui, ../opengl

var
  gFontTexture: uint32 = 0
  glslVersion: cstring
  gWindow: Window
  gCursors: array[cCount.ord, glfw.Cursor]
  gMousePressed: array[3, bool]
  gTime: cdouble
  gAttribLocationTex: int32
  gAttribLocationProjMtx: int32
  gAttribLocationPosition: int32
  gAttribLocationUV: int32
  gAttribLocationColor: int32
  gVboHandle: uint32
  gElementsHandle: uint32
  gShaderHandle: uint32
  gVertHandle: uint32
  gFragHandle: uint32

proc renderData*() =
  echo "render"

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

proc installCallbacks*(window: Window): void =
  window.setKeyCallback(keyProc)
  window.setMouseButtonCallback(mouseProc)
  window.setScrollCallback(scrollProc)
  window.setCharCallback(charProc)

proc init*(window: Window, installCallbacks: bool, glslVersio: int = 150): bool =
  ## Starts glfw integration
  gWindow = window

  glslVersion = "#version " & $glslVersio & "\n"
  
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

proc createFontsTexture*() =
  var
    io = getIO()
    pixels: ptr char = nil
    width: int32
    height: int32

    lastTexture: int32

  # I GIVE UP, (FOR TODAY) THIS IS TRYING TO KILL ME PLEASE HELP
  io.Fonts.getTexDataAsRGBA32(pixels, width.addr, height.addr, nil)

  getIntegerv(GL_TEXTURE_BINDING_2D, lastTexture.addr)
  genTextures(1, gFontTexture.addr)
  bindTexture(GL_TEXTURE_2D, gFontTexture)
  texParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR.ord)
  texParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR.ord)
  pixelStorei(GL_UNPACK_ROW_LENGTH, 0)
  texImage2D(GL_TEXTURE_2D, 0, GL_RGBA.ord, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, pixels)

  io.Fonts.setTexID(gFontTexture.addr)
  bindTexture(GL_TEXTURE_2D, lastTexture.uint32)

proc createDeviceObjects*(): bool =
  var
    lastTexture: int32
    lastArrayBuffer: int32
    lastVertexArray: int32

  getIntegerv(GL_TEXTURE_BINDING_2D, lastTexture.addr)
  getIntegerv(GL_ARRAY_BUFFER_BINDING, lastArrayBuffer.addr)
  getIntegerv(GL_VERTEX_ARRAY_BINDING, lastVertexArray.addr)

  var
    vertexShader: cstring = $glslVersion & """
uniform mat4 ProjMtx;
in vec2 Position;
in vec2 UV;
in vec4 Color;
out vec2 Frag_UV;
out vec4 Frag_Color;
void main() {
	Frag_UV = UV;
	Frag_Color = Color;
	gl_Position = ProjMtx * vec4(Position.xy,0,1);
}
    """
    fragmentShader: cstring = $glslVersion & """
uniform sampler2D Texture;
in vec2 Frag_UV;
in vec4 Frag_Color;
out vec4 Out_Color;
void main() {
	Out_Color = Frag_Color * texture( Texture, Frag_UV.st);
}
    """
  
  gShaderHandle = createProgram()
  gVertHandle   = createShader(GL_VERTEX_SHADER)
  gFragHandle   = createShader(GL_FRAGMENT_SHADER)

  shaderSource(gVertHandle, 1, vertexShader.addr, nil)
  shaderSource(gFragHandle, 1, fragmentShader.addr, nil)
  compileShader(gVertHandle)
  compileShader(gFragHandle)
  attachShader(gShaderHandle, gVertHandle)
  attachShader(gShaderHandle, gFragHandle)
  linkProgram(gShaderHandle)

  gAttribLocationTex = getUniformLocation(gShaderHandle, "Texture")
  gAttribLocationProjMtx = getUniformLocation(gShaderHandle, "ProjMtx")
  gAttribLocationPosition = getUniformLocation(gShaderHandle, "Position")
  gAttribLocationUV = getUniformLocation(gShaderHandle, "UV")
  gAttribLocationColor = getUniformLocation(gShaderHandle, "Color")

  genBuffers(1, gVboHandle.addr)
  genBuffers(1, gElementsHandle.addr)

  createFontsTexture()

  bindTexture(GL_TEXTURE_2D, lastTexture.uint32)
  bindBuffer(GL_ARRAY_BUFFER, lastArrayBuffer.uint32)
  bindVertexArray(lastVertexArray.uint32)

  return true

proc invalidateDeviceObjects*() =
  if gVboHandle > 0'u32: deleteBuffers(1, gVboHandle.addr)
  if gElementsHandle > 0'u32: deleteBuffers(1, gElementsHandle.addr)
  gVboHandle = 0; gElementsHandle = 0

  if gVertHandle > 0'u32:
    detachShader(gShaderHandle, gVertHandle)
    deleteShader(gVertHandle)
  gVertHandle = 0
  if gFragHandle > 0'u32:
    detachShader(gShaderHandle, gFragHandle)
    deleteShader(gFragHandle)
  gFragHandle = 0

  if gShaderHandle > 0'u32: deleteProgram(gShaderHandle)
  gShaderHandle = 0

  if gFontTexture > 0'u32:
    deleteTextures(1, gFontTexture.addr)
    getIO().Fonts.setTexID(nil)
    gFontTexture = 0

proc newFrame*() =
  if gFontTexture == 0:
    discard createDeviceObjects()

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
