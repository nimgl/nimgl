# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## GLFW Module
## ====
## `return <../nimgl.html>`_.  
## 
## This bindings follow most of the original library
## You can check the original documentation `here <http://www.glfw.org/docs/latest/>`_.
## Or continue reading to get the documentation shown here.

when defined(glfwDLL):
  when defined(windows):
    const glfw_dll* = "glfw3.dll"
  elif defined(macosx):
    const glfw_dll* = "libglfw3.dylib"
  else:
    const glfw_dll* = "libglfw.so.3"
  {.pragma: glfw_lib, dynlib: glfw_dll, cdecl.}
else:
  {.compile: "private/glfw/src/vulkan.c".}

  # Thanks to ephja for making this build system

  when defined(windows):
    {.passC: "-D_GLFW_WIN32 -DGLFW_EXPOSE_NATIVE_WIN32",
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

type
  Window* = ptr object
    ## Pointer reference for a GLFW Window
  Monitor* = ptr object
    ## Pointer reference for a GLFW Monitor
  Cursor*  = ptr object
    ## Opaque cursor object.
  Image* = object
    ## GlfwImage data
    width*: int32
    height*: int32
    pixels*: ptr char

# Constants
const 
  GLFW_DONT_CARE*              = -1
  GLFW_FALSE*                  = 0
  GLFW_TRUE*                   = 1

  GLFW_NO_API*                 = 0
  GLFW_OPENGL_API*             = 0X00030001
  GLFW_OPENGL_ES_API*          = 0X00030002

  GLFW_NO_ROBUSTNESS*          = 0
  GLFW_NO_RESET_NOTIFICATION*  = 0X00031001
  GLFW_LOSE_CONTEXT_ON_RESET*  = 0X00031002

  GLFW_OPENGL_ANY_PROFILE*     = 0
  GLFW_OPENGL_CORE_PROFILE*    = 0X00032001
  GLFW_OPENGL_COMPAT_PROFILE*  = 0X00032002

  GLFW_CURSOR*                 = 0X00033001
  GLFW_STICKY_KEYS*            = 0X00033002
  GLFW_STICKY_MOUSE_BUTTONS*   = 0X00033003

  GLFW_CURSOR_NORMAL*          = 0X00034001
  GLFW_CURSOR_HIDDEN*          = 0X00034002
  GLFW_CURSOR_DISABLED*        = 0X00034003

  GLFW_ANY_RELEASE_BEHAVIOR*   = 0
  GLFW_RELEASE_BEHAVIOR_FLUSH* = 0X00035001
  GLFW_RELEASE_BEHAVIOR_NONE*  = 0X00035002

  GLFW_NATIVE_CONTEXT_API*     = 0X00036001
  GLFW_EGL_CONTEXT_API*        = 0X00036002

type
  CursorShape* {.size: int32.sizeof.} = enum
    csArrow = 0x00036001
    csIbeam = 0x00036002
    csCrosshair = 0x00036003
    csHand = 0x00036004
    csHresize = 0x00036005
    csVresize = 0x00036006

  WindowHint* {.size: int32.sizeof.} = enum
    whFocused = 0x00020001
      ## specifies whether the windowed mode window will be given input focus
      ## when created.
      ## This hint is ignored for full screen and initially hidden windows
    whResizable = 0x00020003
      ## specifies whether the windowed mode window will be resizable by the user.
      ## The window will still be resizable using the glfwSetWindowSize function.
      ## This hint is ignored for full screen windows.
    whVisible = 0x00020004
      ## specifies whether the windowed mode window will be initially visible.
      ## This hint is ignored for full screen windows
    whDecorated = 0x00020005
      ## specifies whether the windowed mode window will have window decorations
      ## such as a border, a close widget, etc. An undecorated window may still
      ## allow the user to generate close events on some platforms.
      ## This hint is ignored for full screen windows.
    whAutoIconify = 0x00020006
      ## specifies whether the full screen window will automatically iconify and
      ## restore the previous video mode on input focus loss.
      ## This hint is ignored for windowed mode windows.
    whFloating = 0x00020007
      ## specifies whether the windowed mode window will be floating above other
      ## regular windows, also called topmost or always-on-top. This is intended
      ## primarily for debugging purposes and cannot be used to implement
      ## proper full screen windows.
      ## This hint is ignored for full screen windows.
    whMaximized = 0x00020008
      ## specifies whether the windowed mode window will be maximized when created.
      ## This hint is ignored for full screen windows
    whRedBits = 0x00021001
      ## specify the desired bit depths of the various components of the default
      ## framebuffer. glfwDontCare means the application has no preference.
    whGreenBits = 0x00021002
      ## specify the desired bit depths of the various components of the default
      ## framebuffer. glfwDontCare means the application has no preference.
    whBlueBits = 0x00021003
      ## specify the desired bit depths of the various components of the default
      ## framebuffer. glfwDontCare means the application has no preference.
    whAlphaBits = 0x00021004
      ## specify the desired bit depths of the various components of the default
      ## framebuffer. glfwDontCare means the application has no preference.
    whDepthBits = 0x00021005
      ## specify the desired bit depths of the various components of the default
      ## framebuffer. glfwDontCare means the application has no preference.
    whStencilBits = 0x00021006
      ## specify the desired bit depths of the various components of the default
      ## framebuffer. glfwDontCare means the application has no preference.
    whAccumRedBits = 0x00021007
      ## specify the desired bit depths of the various components of the
      ## accumulation buffer. glfwDontCare means the application has no preference.
    whAccumGreenBits = 0x00021008
      ## specify the desired bit depths of the various components of the
      ## accumulation buffer. glfwDontCare means the application has no preference.
    whAccumBlueBits = 0x00021009
      ## specify the desired bit depths of the various components of the
      ## accumulation buffer. glfwDontCare means the application has no preference.
    whAccumAlphaBits = 0x0002100A
      ## specify the desired bit depths of the various components of the
      ## accumulation buffer. glfwDontCare means the application has no preference.
    whAuxBuffers = 0x0002100B
      ## specifies the desired number of auxiliary buffers. glfwDontCare means the application has no preference.
    whStereo = 0x0002100C
      ## specifies whether to use stereoscopic rendering. This is a hard constraint
    whSamples = 0x0002100D
      ## specifies the desired number of samples to use for multisampling. Zero
      ## disables multisampling. glfwDontCare means the application has no preference
    whSrgbCapable = 0x0002100E
      ## specifies whether the framebuffer should be sRGB capable.
      ## If supported, a created OpenGL context will support the
    whRefreshRate = 0x0002100F
      ## specifies the desired refresh rate for full screen windows.
      ## If set to glfwDontCare, the highest available refresh rate will be used.
      ## This hint is ignored for windowed mode windows
    whDoubleBuffer = 0x00021010
      ## specifies whether the framebuffer should be double buffered.
      ## You nearly always want to use double buffering. This is a hard constraint.
    whClientApi = 0x00022001
      ## specifies which client API to create the context for.
      ## Possible values are glfwOpenglAPI, glfwOpenglEsAPI and 
    whContextVersionMajor = 0x00022002
      ## specify the client API version that the created context must be compatible
      ## with. The exact behavior of these hints depend on the requested client API.
    whContextVersionMinor = 0x00022003
      ## specify the client API version that the created context must be compatible
      ## with. The exact behavior of these hints depend on the requested client API.
    whContextRevision = 0x00022004
      ## indicate the client API version of the window's context.
    whContextRobustness = 0x00022005
      ## specifies the robustness strategy to be used by the context.
      ## This can be one of glfwNoResetNotification or glfwLoseContextOnReset,
      ## or glfwNoRobustness to not request a robustness strategy.
    whOpenglForwardCompat = 0x00022006
      ## specifies whether the OpenGL context should be forward-compatible, i.e.
      ## one where all functionality deprecated in the requested version of OpenGL
      ## is removed. This must only be used if the requested OpenGL version is 3.0
      ## or above.
      ## If OpenGL ES is requested, this hint is ignored.
    whOpenglDebugContext = 0x00022007
      ## ecifies whether to create a debug OpenGL context, which may have additional
      ## error and performance issue reporting functionality.
      ## If OpenGL ES is requested, this hint is ignored.
    whOpenglProfile = 0x00022008
      ## specifies which OpenGL profile to create the context for. Possible values
      ## are one of glfwOpenglCoreProfile or glfwOpenglCompatProfile, or
      ## glfwOpenglAnyProfile to not request a specific profile. If requesting
      ## an OpenGL version below 3.2, glfwOpenglAnyProfile must be used.
      ## If OpenGL ES is requested, this hint is ignored.
    whContextReleaseBehavior = 0x00022009
      ## specifies the release behavior to be used by the context. Possible values
      ## are one of glfwAnyReleaseBehavior, glfwReleaseBehaviorFlush or
      ## glfwReleaseBehaviorNone. If the behavior is glfwAnyReleaseBehavior,
      ## the default behavior of the context creation API will be used. If the
      ## behavior is glfwReleaseBehaviorFlush, the pipeline will be flushed
      ## whenever the context is released from being the current one. If the
      ## behavior is glfwReleaseBehaviorNone, the pipeline will not be flushed on release.
    whContextNoError = 0x0002200A
      ## specifies whether errors should be generated by the context. If enabled,
      ## situations that would have generated errors instead cause undefined behavior
    whContextCreationAPI = 0x0002200B
      ## indicates the context creation API used to create the window's context;
      ## either glfwNativeContextAPI or glfwEGLContextAPI.
  GLFWErrorCode* {.size: int32.sizeof.} = enum
    ## Error Codes documented on the original documentation
    glfwNotInitialized = 0x00010001
      ## GLFW has not been initialized.
    glfwNoCurrentContext  = 0x00010002
      ## No context is current for this thread.
    glfwInvalidEnum = 0x00010003
      ## One of the arguments to the function was an invalid enum value.
    glfwInvalidValue = 0x00010004
      ## One of the arguments to the function was an invalid value.
    glfwOutOfMemory = 0x00010005
      ## A memory allocation failed.
    glfwAPIUnavailable = 0x00010006
      ## GLFW could not find support for the requested API on the system.
    glfwVersionUnavailable = 0x00010007
      ## The requested OpenGL or OpenGL ES version is not available.
    glfwPlatformError = 0x00010008
      ## A platform-specific error occurred that does not match any of the
    glfwFormatUnavailable = 0x00010009
      ## The requested format is not supported or available.
    glfwNoWindowContext= 0x0001000A
      ## The specified window does not have an OpenGL or OpenGL ES context.
  MouseButton* {.size: int32.sizeof.} = enum
    ## Mouse Buttons
    mbLeft   = 0
    mbRight  = 1
    mbMiddle = 2
    mb4      = 3
    mb5      = 4
    mb6      = 5
    mb7      = 6
    mb8      = 7
  JoyStick* {.size: int32.sizeof.} = enum
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
  KeyAction* {.size: int32.sizeof.} = enum
    ## Action released on the key event
    kaRelease = (0, "release")
    kaPress   = (1, "press")
    kaRepeat  = (2, "repeat")
  MouseAction* {.size: int32.sizeof.} = enum
    ## Actions of the mouse
    maRelease = (0, "release")
    maPress   = (1, "press")
    maRepeat  = (2, "repeat")
  KeyMod* {.size: int32.sizeof.} = enum
    ## Key Modifiers, to modify actions
    kmShift   = 0x0001
    kmControl = 0x0002
    kmAlt     = 0x0004
    kmSuper   = 0x0008
  Key* {.size: int32.sizeof.} = enum
    ## KeyCodes, a lot of them
    keyUnknown      = (-1, "unkown")
    keySpace        = (32, "space")
    keyApostrophe   = (39, "apostrophe")
    keyComma        = (44, "comma")
    keyMinus        = (45, "minus")
    keyPeriod       = (46, "period")
    keySlash        = (47, "slash")
    key0            = (48, "0")
    key1            = (49, "1")
    key2            = (50, "2")
    key3            = (51, "3")
    key4            = (52, "4")
    key5            = (53, "5")
    key6            = (54, "6")
    key7            = (55, "7")
    key8            = (56, "8")
    key9            = (57, "9")
    keySemicolon    = (59, "semicolon")
    keyEqual        = (61, "equal")
    keyA            = (65, "a")
    keyB            = (66, "b")
    keyC            = (67, "c")
    keyD            = (68, "d")
    keyE            = (69, "e")
    keyF            = (70, "f")
    keyG            = (71, "g")
    keyH            = (72, "h")
    keyI            = (73, "i")
    keyJ            = (74, "j")
    keyK            = (75, "k")
    keyL            = (76, "l")
    keyM            = (77, "m")
    keyN            = (78, "n")
    keyO            = (79, "o")
    keyP            = (80, "p")
    keyQ            = (81, "q")
    keyR            = (82, "r")
    keyS            = (83, "s")
    keyT            = (84, "t")
    keyU            = (85, "u")
    keyV            = (86, "v")
    keyW            = (87, "w")
    keyX            = (88, "x")
    keyY            = (89, "y")
    keyZ            = (90, "z")
    keyLeftBracket  = (91, "left_bracket")
    keyBackslash    = (92, "back_slash")
    keyRightBracket = (93, "right_bracket")
    keyGraveAccent  = (96, "grave_accent")
    keyWorld1       = (161, "world_1")
    keyWorld2       = (162, "world_2")
    keyEscape       = (256, "escape")
    keyEnter        = (257, "enter")
    keyTab          = (258, "tab")
    keyBackspace    = (259, "backspace")
    keyInsert       = (260, "insert")
    keyDelete       = (261, "delete")
    keyRight        = (262, "right")
    keyLeft         = (263, "left")
    keyDown         = (264, "down")
    keyUp           = (265, "up")
    keyPage_up      = (266, "page up")
    keyPage_down    = (267, "page down")
    keyHome         = (268, "home")
    keyEnd          = (269, "end")
    keyCapsLock     = (280, "caps lock")
    keyScrollLock   = (281, "scroll lock")
    keyNumLock      = (282, "num lock")
    keyPrintScreen  = (283, "print screen")
    keyPause        = (284, "pause")
    keyF1           = (290, "f1")
    keyF2           = (291, "f2")
    keyF3           = (292, "f3")
    keyF4           = (293, "f4")
    keyF5           = (294, "f5")
    keyF6           = (295, "f6")
    keyF7           = (296, "f7")
    keyF8           = (297, "f8")
    keyF9           = (298, "f9")
    keyF10          = (299, "f10")
    keyF11          = (300, "f11")
    keyF12          = (301, "f12")
    keyF13          = (302, "f13")
    keyF14          = (303, "f14")
    keyF15          = (304, "f15")
    keyF16          = (305, "f16")
    keyF17          = (306, "f17")
    keyF18          = (307, "f18")
    keyF19          = (308, "f19")
    keyF20          = (309, "f20")
    keyF21          = (310, "f21")
    keyF22          = (311, "f22")
    keyF23          = (312, "f23")
    keyF24          = (313, "f24")
    keyF25          = (314, "f25")
    keyKP_0         = (320, "kp0")
    keyKP_1         = (321, "kp1")
    keyKP_2         = (322, "kp2")
    keyKP_3         = (323, "kp3")
    keyKP_4         = (324, "kp4")
    keyKP_5         = (325, "kp5")
    keyKP_6         = (326, "kp6")
    keyKP_7         = (327, "kp7")
    keyKP_8         = (328, "kp8")
    keyKP_9         = (329, "kp9")
    keyKP_Decimal   = (330, "decial")
    keyKP_Divide    = (331, "divide")
    keyKP_Multiply  = (332, "multiply")
    keyKP_Subtract  = (333, "substract")
    keyKP_Add       = (334, "add")
    keyKP_Enter     = (335, "enter")
    keyKP_Equal     = (336, "equal")
    keyLeftShift    = (340, "left_shift")
    keyLeftControl  = (341, "left_control")
    keyLeftAlt      = (342, "left_alt")
    keyLeftSuper    = (343, "left_super")
    keyRightShift   = (344, "right_shift")
    keyRightControl = (345, "right_control")
    keyRightAlt     = (346, "right_alt")
    keyRightSuper   = (347, "right_super")
    keyMenu         = (348, "menu")
    keyLast         = "last"

type
  charProc*   = proc(window: Window, code: cuint): void {.cdecl.}
    ## This is the function signature for Unicode character callback functions.
    ##
    ## ``window`` The window that received the event.
    ##
    ## ``codepoint`` The Unicode code point of the character.
  mouseProc*  = proc(window: Window, button: MouseButton, action: MouseAction, mods: KeyMod): void {.cdecl.}
    ## This is the function signature for mouse button callback functions.
    ##
    ## ``window`` The window that received the event.
    ##
    ## ``button`` The [mouse button](@ref buttons) that was pressed or
    ## released.
    ##
    ## ``action`` One of `GLFW_PRESS` or `GLFW_RELEASE`.
    ##
    ## ``mods`` Bit field describing which [modifier keys](@ref mods) were
    ## held down.
  keyProc*    = proc(window: Window, key: Key, scancode: int32, action: KeyAction, mods: KeyMod): void {.cdecl.}
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
  scrollProc* = proc(window: Window, xoff, yoff: cdouble): void {.cdecl.}
    ## This is the functions signature for scroll callback functions.
    ##
    ## ``window`` The window that received the event.
    ##
    ## ``xoff`` The scroll offset along the x-axis.
    ##
    ## ``yoff`` The scroll offset along the y-axis.

converter toBool*(x: int32): bool = x != 0

proc setWindowIcon*(window: Window, count: int32, images: ptr Image): void {.glfw_lib, importc: "glfwSetWindowIcon".}
  ## This function sets the icon of the specified window.  If passed an array of
  ## candidate images, those of or closest to the sizes desired by the system are
  ## selected.  If no images are specified, the window reverts to its default
  ## icon.

proc createWindow*(width: int32, height: int32, title: cstring = "NimGL", monitor: Monitor = nil, share: Window = nil): Window {.glfw_lib, importc: "glfwCreateWindow".}
  ## Creates a window and its associated OpenGL or OpenGL ES
  ## context. Most of the options controlling how the window and its context
  ## should be created are specified with ``window_hints``.
  ## We recommend you to generate a config and modify it instead but this is
  ## the official way to create a window

proc init*(): bool {.glfw_lib, importc: "glfwInit".}
  ## Initializes the GLFW library. Before most GLFW functions can
  ## be used, GLFW must be initialized, and before an application terminates GLFW
  ## should be terminated in order to free any resources allocated during or
  ## after initialization.
  ##
  ## Returns ``glfwTRUE`` if successful, or ``glfwFALSE`` if an error ocurred.

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

proc setWindowShouldClose*(window: Window, value: bool): void {.glfw_lib, importc: "glfwSetWindowShouldClose".}
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

proc setWindowTitle*(window: Window, title: cstring): void {.glfw_lib, importc: "glfwSetWindowTitle".}
  ## This function sets the window title, encoded as UTF-8, of the specified
  ## window.

proc windowHint*(hint: WindowHint, value: int32): void {.glfw_lib, importc: "glfwWindowHint".}
  ## This function sets hints for the next call to ``createWindow``  The
  ## hints, once set, retain their values until changed by a call to.
  ## ``windowHint`` or ``defaultWindowHints``, or until the library is
  ## terminated.
  ##
  ## To read more visit `here <http://www.glfw.org/docs/latest/window_guide.html#window_hints_values>`_.

proc defaultWindowHints*(): void {.glfw_lib, importc: "glfwDefaultWindowHints".}
  ## Resets all window hints to their default values.

proc getProcAddress*(procname: cstring): pointer {.glfw_lib, importc: "glfwGetProcAddress".}
  ## This function returns the address of the specified OpenGL or OpenGL ES
  ## [core or extension function](@ref context_glext), if it is supported
  ## by the current context.
  ##
  ## A context must be current on the calling thread.  Calling this function
  ## without a current context will cause a @ref GLFW_NO_CURRENT_CONTEXT error.

proc getCursorPos*(window: Window, xpos: ptr cdouble, ypos: ptr cdouble): void {.glfw_lib, importc: "glfwGetCursorPos".}
  ## This function returns the position of the cursor, in screen coordinates,
  ## relative to the upper-left corner of the client area of the specified
  ## window.

proc getClipboardString*(window: Window): cstring {.glfw_lib, importc: "glfwGetClipboardString".}
  ## This function returns the contents of the system clipboard, if it contains
  ## or is convertible to a UTF-8 encoded string.  If the clipboard is empty or
  ## if its contents cannot be converted, `NULL` is returned and a @ref
  ## GLFW_FORMAT_UNAVAILABLE error is generated.

proc setClipboardString*(window: Window, clip: cstring): void {.glfw_lib, importc: "glfwSetClipboardString".}
  ## This function sets the system clipboard to the specified, UTF-8 encoded
  ## string.

proc setKeyCallback*(window: Window, callback: keyProc): void {.glfw_lib, importc: "glfwSetKeyCallback".}
  ## This function sets the key callback of the specified window, which is called
  ## when a key is pressed, repeated or released.

proc setMouseButtonCallback*(window: Window, cbfun: mouseProc): void {.glfw_lib, importc: "glfwSetMouseButtonCallback".}
  ## This function sets the mouse button callback of the specified window, which
  ## is called when a mouse button is pressed or released.

proc setCharCallback*(window: Window, callback: charProc): void {.glfw_lib, importc: "glfwSetCharCallback".}
  ## This function sets the character callback of the specified window, which is
  ## called when a Unicode character is input.
  ##
  ## The character callback is intended for Unicode text input.  As it deals with
  ## characters, it is keyboard layout dependent, whereas the
  ## [key callback](@ref glfwSetKeyCallback) is not.  Characters do not map 1:1
  ## to physical keys, as a key may produce zero, one or more characters.  If you
  ## want to know whether a specific physical key was pressed or released, see
  ## the key callback instead.

proc setScrollCallback*(window: Window, callback: scrollProc): void {.glfw_lib, importc: "glfwSetScrollCallback".}
  ## This function sets the scroll callback of the specified window, which is
  ## called when a scrolling device is used, such as a mouse wheel or scrolling
  ## area of a touchpad.
  ##
  ## The scroll callback receives all scrolling input, like that from a mouse
  ## wheel or a touchpad scrolling area.

proc createStandardCursor*(shape: CursorShape): Cursor {.glfw_lib, importc: "glfwCreateStandardCursor".}
  ## Returns a cursor with a [standard shape](@ref shapes), that can be set for
  ## a window with @ref glfwSetCursor.

proc destroyCursor*(cursor: Cursor): void {.glfw_lib, importc: "glfwDestroyCursor".}
  ## This function destroys a cursor previously created with @ref
  ## glfwCreateCursor. Any remaining cursors will be destroyed by @ref
  ## glfwTerminate.

proc getPrimaryMonitor*(): Monitor {.glfw_lib, importc: "glfwGetPrimaryMonitor".}
  ## This function returns the primary monitor.  This is usually the monitor
  ## where elements like the task bar or global menu bar are located.

when defined(windows):
  proc getWin32Window*(window: Window): pointer {.glfw_lib, importc: "glfwGetWin32Window".}
    ## @return The `HWND` of the specified window, or `NULL` if an
    ## [error](@ref error_handling) occurred.
