# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

when defined(glfwDLL):
  when defined(windows):
    const
      glfw_dll* = "glfw3.dll"
  elif defined(windows):
    const
      glfw_dll* = "libglfw3.dylib"
  else:
    const
      glfw_dll* = "libglfw.so.3"
  {.pragma: glfw_lib, dynlib: glfw_dll, cdecl.}
else:
  {.compile: "private/glfw/src/vulkan.c".}
  # Thanks to ephja for making this build system, my intention is not to copy
  #   just that he did a wonderful job and saved me what could be hours.
  # The rest of the implementention is mine.

  when defined(windows):
    {.passC: "-D_GLFW_WIN32",
      passL: "-lopengl32 -lgdi32",
      compile: "private/glfw/src/win32_init.c",
      compile: "private/glfw/src/win32_monitor.c",
      compile: "private/glfw/src/win32_time.c",
      compile: "private/glfw/src/win32_tls.c",
      compile: "private/glfw/src/win32_window.c",
      compile: "private/glfw/src/win32_joystick.c",
      compile: "private/glfw/src/wgl_context.c",
      compile: "private/glfw/src/egl_context.c".}
  elif defined(macosx):
    {.passC: "-D_GLFW_COCOA -D_GLFW_USE_CHDIR -D_GLFW_USE_MENUBAR -D_GLFW_USE_RETINA",
      passL: "-framework Cocoa -framework OpenGL -framework IOKit -framework CoreVideo",
      compile: "private/glfw/src/cocoa_init.m",
      compile: "private/glfw/src/cocoa_monitor.m",
      compile: "private/glfw/src/cocoa_time.c",
      compile: "private/glfw/src/posix_tls.c",
      compile: "private/glfw/src/cocoa_window.m",
      compile: "private/glfw/src/cocoa_joystick.m",
      compile: "private/glfw/src/nsgl_context.m".}
  else:
    {.passL: "-pthread -lGL -lX11 -lXrandr -lXxf86vm -lXi -lXcursor -lm -lXinerama".}

    when defined(mir):
      {.passC: "-D_GLFW_WAYLAND",
        compile: "private/glfw/src/wl_init.c",
        compile: "private/glfw/src/wl_monitor.c",
        compile: "private/glfw/src/wl_window.c",
        compile: "private/glfw/src/egl_context.c".}
    elif defined(wayland):
      {.passC: "-D_GLFW_MIR",
        compile: "private/glfw/src/mir_init.c",
        compile: "private/glfw/src/mir_monitor.c",
        compile: "private/glfw/src/mir_window.c",
        compile: "private/glfw/src/egl_context.c".}
    else:
      {.passC: "-D_GLFW_X11",
        compile: "private/glfw/src/x11_init.c",
        compile: "private/glfw/src/x11_monitor.c",
        compile: "private/glfw/src/x11_window.c",
        compile: "private/glfw/src/glx_context.c",
        compile: "private/glfw/src/egl_context.c".}

    {.compile: "private/glfw/src/xkb_unicode.c",
      compile: "private/glfw/src/linux_joystick.c",
      compile: "private/glfw/src/posix_time.c",
      compile: "private/glfw/src/posix_tls.c".}

  {.compile: "private/glfw/src/context.c",
    compile: "private/glfw/src/init.c",
    compile: "private/glfw/src/input.c",
    compile: "private/glfw/src/monitor.c",
    compile: "private/glfw/src/window.c".}

  {.pragma: glfw_lib, cdecl.}

## GLFW Bindings
## ====
## `return <../>`_.  
##
## This bindings follow most of the original library
## You can check the original documentation `here <http://www.glfw.org/docs/latest/>`_.
## Or continue reading to get the documentation shown here.

type
  Window* = ptr object
    ## Pointer reference for a GLFW Window
  Monitor* = ptr object
    ## Pointer reference for a GLFW Monitor
  WindowConfig* = object
    ## Essential Config to create a Window
    title*  : cstring
    size*   : tuple[width, height: cint]
    monitor*: Monitor
    share*  : Window

type
  GLFWConstants* {.size: cint.sizeof.} = enum
    ## Semantic Sugar
    glfwFalse = 0
    glfwTrue  = 1
  GLFWErrorCodes* {.size: cint.sizeof.} = enum
    ## Error Codes documented on the original documentation
    glfwNOT_INITIALIZED     = 0x00010001
      ## GLFW has not been initialized.
    glfwNO_CURRENT_CONTEXT  = 0x00010002
      ## No context is current for this thread.
    glfwINVALID_ENUM        = 0x00010003
      ## One of the arguments to the function was an invalid enum value.
    glfwINVALID_VALUE       = 0x00010004
      ## One of the arguments to the function was an invalid value.
    glfwOUT_OF_MEMORY       = 0x00010005
      ## A memory allocation failed.
    glfwAPI_UNAVAILABLE     = 0x00010006
      ## GLFW could not find support for the requested API on the system.
    glfwVERSION_UNAVAILABLE = 0x00010007
      ## The requested OpenGL or OpenGL ES version is not available.
    glfwPLATFORM_ERROR      = 0x00010008
      ## A platform-specific error occurred that does not match any of the
    glfwFORMAT_UNAVAILABLE  = 0x00010009
      ## The requested format is not supported or available.
    glfwNO_WINDOW_CONTEXT   = 0x0001000A
      ## The specified window does not have an OpenGL or OpenGL ES context.
  MouseButton* {.size: cint.sizeof.} = enum
    ## Mouse Buttons
    mbLeft   = 0
    mbRight  = 1
    mbMiddle = 2
    mb4      = 3
    mb5      = 4
    mb6      = 5
    mb7      = 6
    mb8      = 7
  JoyStick* {.size: cint.sizeof.} = enum
    ## Joystick references
    js1  = 0
    js2  = 1
    js3  = 2
    js4  = 3
    js5  = 4
    js6  = 5
    js7  = 6
    js8  = 7
    js9  = 8
    js10 = 9
    js11 = 10
    js12 = 11
    js13 = 12
    js14 = 13
    js15 = 14
  KeyAction* {.size: cint.sizeof.} = enum
    ## Action released on the key event
    kaRelease = (0, "release")
    kaPress   = (1, "press")
    kaRepeat  = (2, "repeat")
  KeyMods* {.size: cint.sizeof.} = enum
    ## Key Modifiers, to modify actions
    kmSHIFT   = 0x0001
    kmCONTROL = 0x0002
    kmALT     = 0x0004
    kmSUPER   = 0x0008
  Key* {.size: cint.sizeof.} = enum
    ## KeyCodes, a lot of them
    keyUNKNOWN       = (-1, "unkown")
    keySPACE         = (32, "space")
    keyAPOSTROPHE    = (39, "apostrophe")
    keyCOMMA         = (44, "comma")
    keyMINUS         = (45, "minus")
    keyPERIOD        = (46, "period")
    keySLASH         = (47, "slash")
    key0             = (48, "0")
    key1             = (49, "1")
    key2             = (50, "2")
    key3             = (51, "3")
    key4             = (52, "4")
    key5             = (53, "5")
    key6             = (54, "6")
    key7             = (55, "7")
    key8             = (56, "8")
    key9             = (57, "9")
    keySEMICOLON     = (59, "semicolon")
    keyEQUAL         = (61, "equal")
    keyA             = (65, "a")
    keyB             = (66, "b")
    keyC             = (67, "c")
    keyD             = (68, "d")
    keyE             = (69, "e")
    keyF             = (70, "f")
    keyG             = (71, "g")
    keyH             = (72, "h")
    keyI             = (73, "i")
    keyJ             = (74, "j")
    keyK             = (75, "k")
    keyL             = (76, "l")
    keyM             = (77, "m")
    keyN             = (78, "n")
    keyO             = (79, "o")
    keyP             = (80, "p")
    keyQ             = (81, "q")
    keyR             = (82, "r")
    keyS             = (83, "s")
    keyT             = (84, "t")
    keyU             = (85, "u")
    keyV             = (86, "v")
    keyW             = (87, "w")
    keyX             = (88, "x")
    keyY             = (89, "y")
    keyZ             = (90, "z")
    keyLEFT_BRACKET  = (91, "left_bracket")
    keyBACKSLASH     = (92, "back_slash")
    keyRIGHT_BRACKET = (93, "right_bracket")
    keyGRAVE_ACCENT  = (96, "grave_accent")
    keyWORLD_1       = (161, "world_1")
    keyWORLD_2       = (162, "world_2")
    keyESCAPE        = (256, "escape")
    keyENTER         = (257, "enter")
    keyTAB           = (258, "tab")
    keyBACKSPACE     = (259, "backspace")
    keyINSERT        = (260, "insert")
    keyDELETE        = (261, "delete")
    keyRIGHT         = (262, "right")
    keyLEFT          = (263, "left")
    keyDOWN          = (264, "down")
    keyUP            = (265, "up")
    keyPAGE_UP       = (266, "page up")
    keyPAGE_DOWN     = (267, "page down")
    keyHOME          = (268, "home")
    keyEND           = (269, "end")
    keyCAPS_LOCK     = (280, "caps lock")
    keySCROLL_LOCK   = (281, "scroll lock")
    keyNUM_LOCK      = (282, "num lock")
    keyPRINT_SCREEN  = (283, "print screen")
    keyPAUSE         = (284, "pause")
    keyF1            = (290, "f1")
    keyF2            = (291, "f2")
    keyF3            = (292, "f3")
    keyF4            = (293, "f4")
    keyF5            = (294, "f5")
    keyF6            = (295, "f6")
    keyF7            = (296, "f7")
    keyF8            = (297, "f8")
    keyF9            = (298, "f9")
    keyF10           = (299, "f10")
    keyF11           = (300, "f11")
    keyF12           = (301, "f12")
    keyF13           = (302, "f13")
    keyF14           = (303, "f14")
    keyF15           = (304, "f15")
    keyF16           = (305, "f16")
    keyF17           = (306, "f17")
    keyF18           = (307, "f18")
    keyF19           = (308, "f19")
    keyF20           = (309, "f20")
    keyF21           = (310, "f21")
    keyF22           = (311, "f22")
    keyF23           = (312, "f23")
    keyF24           = (313, "f24")
    keyF25           = (314, "f25")
    keyKP_0          = (320, "kp0")
    keyKP_1          = (321, "kp1")
    keyKP_2          = (322, "kp2")
    keyKP_3          = (323, "kp3")
    keyKP_4          = (324, "kp4")
    keyKP_5          = (325, "kp5")
    keyKP_6          = (326, "kp6")
    keyKP_7          = (327, "kp7")
    keyKP_8          = (328, "kp8")
    keyKP_9          = (329, "kp9")
    keyKP_DECIMAL    = (330, "decial")
    keyKP_DIVIDE     = (331, "divide")
    keyKP_MULTIPLY   = (332, "multiply")
    keyKP_SUBTRACT   = (333, "substract")
    keyKP_ADD        = (334, "add")
    keyKP_ENTER      = (335, "enter")
    keyKP_EQUAL      = (336, "equal")
    keyLEFT_SHIFT    = (340, "left_shift")
    keyLEFT_CONTROL  = (341, "left_control")
    keyLEFT_ALT      = (342, "left_alt")
    keyLEFT_SUPER    = (343, "left_super")
    keyRIGHT_SHIFT   = (344, "right_shift")
    keyRIGHT_CONTROL = (345, "right_control")
    keyRIGHT_ALT     = (346, "right_alt")
    keyRIGHT_SUPER   = (347, "right_super")
    keyMENU          = (348, "menu")
    keyLAST          = "last"

type
  keyProc* = proc(window: Window, key: Key, scancode: cint, action: KeyAction, mods: KeyMods): void {.cdecl.}
    ## This is the function signature for keyboard key callback functions.
    ##
    ## ``window`` The ``Window`` that received the event.
    ##
    ## ``key`` The ``Key`` that was pressed or released.
    ##
    ## ``scancode`` The system-specific scancode of the key.
    ##
    ## ``action`` ``kaPress``, ``kaRelease`` or ``kaRepeat``.
    ##
    ## ``mods`` Bit field describing which ``KeyMods`` were
    ## held down.

proc defaultWindowConfig*(): WindowConfig =
  ## Returns a copy of a valid ``WindowConfig`` for you to modify
  ## and pass as an argument to ``createWindow``
  WindowConfig(
    title  : "NimGL",
    size   : ((cint)800, (cint)600),
    monitor: nil,
    share  : nil
  )

proc createWindow*(width: cint, height: cint, title: cstring, monitor: Monitor, share: Window): Window {.glfw_lib, importc: "glfwCreateWindow".}
  ## Creates a window and its associated OpenGL or OpenGL ES
  ## context. Most of the options controlling how the window and its context
  ## should be created are specified with ``window_hints``.
  ## We recommend you to generate a config and modify it instead but this is
  ## the official way to create a window

proc createWindow*(config: WindowConfig): Window =
  ## Creates a window and its associated OpenGL or OpenGL ES
  ## context. Most of the options controlling how the window and its context
  ## should be created are specified with ``window_hints``.
  ## Overloading
  createWindow(config.size.width, config.size.height, config.title, config.monitor, config.share)

proc init*(): bool {.glfw_lib, importc: "glfwInit".}
  ## Initializes the GLFW library. Before most GLFW functions can
  ## be used, GLFW must be initialized, and before an application terminates GLFW
  ## should be terminated in order to free any resources allocated during or
  ## after initialization.
  ##
  ## Returns ``GLFW_TRUE`` if successful, or ``GLFW_FALSE`` if an error ocurred.

proc terminate*(): void {.glfw_lib, importc: "glfwTerminate".}
  ## Destroys all remaining windows and cursors, restores any
  ## modified gamma ramps and frees any other allocated resources.  Once this
  ## function is called, you must again call ``glfwInit`` successfully before
  ## you will be able to use most GLFW functions.

proc destroyWindow*(window: Window): void {.glfw_lib, importc: "glfwDestroyWindow".}
  ## Destroys the specified window and its context.  On calling
  ## this function, no further callbacks will be called for that window.

proc makeContextCurrent*(window: Window): void {.glfw_lib, importc: "glfwMakeContextCurrent".}
  ## Makes the OpenGL or OpenGL ES context of the specified window
  ## current on the calling thread.  A context can only be made current on
  ## a single thread at a time and each thread can have only a single current

proc setWindowShouldClose*(window: Window, value: bool) {.glfw_lib, importc: "glfwSetWindowShouldClose".}
  ## This function sets the value of the close flag of the specified window.
  ## This can be used to override the user's attempt to close the window, or
  ## to signal that it should be closed.

proc windowShouldClose*(window: Window): bool {.glfw_lib, importc: "glfwWindowShouldClose".}
  ## Returns the value of the close flag of the specified window.

proc swapBuffers*(window: Window): void {.glfw_lib, importc: "glfwSwapBuffers".}
  ## Swaps the front and back buffers of the specified window when
  ## rendering with OpenGL or OpenGL ES.  If the swap interval is greater than
  ## zero, the GPU driver waits the specified number of screen updates before
  ## swapping the buffers.

proc pollEvents*(): void {.glfw_lib, importc: "glfwPollEvents".}
  ## Processes only those events that are already in the event
  ## queue and then returns immediately.  Processing events will cause the window
  ## and input callbacks associated with those events to be called.

proc setKeyCallback*(window: Window, callback: keyProc): void {.glfw_lib, importc: "glfwSetKeyCallback".}
  ## This function sets the key callback of the specified window, which is called
  ## when a key is pressed, repeated or released.

proc getTime*(): cdouble {.glfw_lib, importc: "glfwGetTime".}
  ## This function returns the value of the GLFW timer. Unless the timer has
  ## been set using ``setTime``, the timer measures time elapsed since GLFW
  ## was initialized.

proc setTime*(time: cdouble): void {.glfw_lib, importc: "glfwSetTime".}
  ## This function sets the value of the GLFW timer.  It then continues to count
  ## up from that value.  The value must be a positive finite number less than
  ## or equal to 18446744073.0, which is approximately 584.5 years.

proc getCurrentContext*(): Window {.glfw_lib, importc: "glfwGetCurrentContext".}
  ## This function returns the window whose OpenGL or OpenGL ES context is
  ## current on the calling thread.

proc getKey*(window: Window, key: Key): KeyAction {.glfw_lib, importc: "glfwGetKey".}
  ## This function returns the last state reported for the specified key to the
  ## specified window.  The returned state is one of ``kaPress`` or
  ## ``kaRelease``.  The higher-level action ``kaRepeat`` is only reported to
  ## the key callback.

proc setWindowTitle*(window: Window, title: cstring) {.glfw_lib, importc: "glfwSetWindowTitle".}
  ## This function sets the window title, encoded as UTF-8, of the specified
  ## window.