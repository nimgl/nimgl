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
## to continue supporting only C libraries so you can always use the backend of
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

import glfw

when not defined(imguiSrc):
  when defined(windows):
    const imgui_dll* = "cimgui.dll"
  elif defined(macosx):
    const imgui_dll* = "cimgui.dylib"
  else:
    const imgui_dll* = "cimgui.so"
  {.pragma: imgui_lib, dynlib: imgui_dll, cdecl.}
else:
  {.compile: "private/cimgui/imgui/imgui.cpp",
    compile: "private/cimgui/imgui/imgui_draw.cpp",
    compile: "private/cimgui/imgui/imgui_demo.cpp",
    compile: "private/cimgui/cimgui/cimgui.cpp",
    compile: "private/cimgui/cimgui/drawList.cpp",
    compile: "private/cimgui/cimgui/fontAtlas.cpp",
    compile: "private/cimgui/cimgui/listClipper.cpp" .}
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

  FontAtlas* = pointer
    ## Pointer referencing to a point atlas

  IO* {.importc: "struct ImGuiIO".} = ptr object
    ## This is where your app communicate with ImGui. Access via getIO().
    KeyMap*: array[512, int32]
    KeysDown*: array[512, bool]
    GetClipboardTextFn*: GetCBProc
    SetClipboardTextFn*: SetCPProc
    ClipboardUserData*: pointer
    ImeWindowHandle*: pointer
    MouseWheel*: float32
    MouseWheelH*: float32
    KeyCtrl*: bool
    KeyAlt *: bool
    KeyShift*: bool
    KeySuper*: bool
    DisplaySize*: ImVec2
    DisplayFramebufferScale*: ImVec2
    DeltaTime*: float32
    MousePos*: ImVec2
    MouseDown*: array[5, bool]
    Fonts*: FontAtlas

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

proc getTexDataAsRGBA32*(atlas: FontAtlas, pixels: pointer, width: ptr int32, height: ptr int32, bytes_per_pixel: ptr int32 = nil): void {.imgui_lib, importc: "ImFontAtlas_GetTexDataAsRGBA32".}
proc getTexDataAsAlpha8*(atlas: FontAtlas, pixels: pointer, width: ptr int32, height: ptr int32, bytes_per_pixel: ptr int32 = nil): void {.imgui_lib, importc: "ImFontAtlas_GetTexDataAsAlpha8".}
proc setTexID*(atlas: FontAtlas, id: pointer) {.imgui_lib, importc: "ImFontAtlas_SetTexID".}
