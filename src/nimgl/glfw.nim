# Copyright 2018, NimGL contributors.

## GLFW Module
## ====
## This bindings follow most of the original library
## You can check the original documentation `here <http://www.glfw.org/docs/latest/>`_.
## Or continue reading to get the documentation shown here.

import private/logo
import stb_image

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
      compile: "private/glfw/src/win32_joystick.c",
      compile: "private/glfw/src/win32_monitor.c",
      compile: "private/glfw/src/win32_time.c",
      compile: "private/glfw/src/win32_thread.c",
      compile: "private/glfw/src/win32_window.c",
      compile: "private/glfw/src/wgl_context.c",
      compile: "private/glfw/src/egl_context.c",
      compile: "private/glfw/src/osmesa_context.c".}
  elif defined(macosx):
    {.passC: "-D_GLFW_COCOA -D_GLFW_USE_CHDIR -D_GLFW_USE_MENUBAR -D_GLFW_USE_RETINA",
      passL: "-framework Cocoa -framework OpenGL -framework IOKit -framework CoreVideo",
      compile: "private/glfw/src/cocoa_init.m",
      compile: "private/glfw/src/cocoa_joystick.m",
      compile: "private/glfw/src/cocoa_monitor.m",
      compile: "private/glfw/src/cocoa_window.m",
      compile: "private/glfw/src/cocoa_time.c",
      compile: "private/glfw/src/posix_thread.c",
      compile: "private/glfw/src/nsgl_context.m",
      compile: "private/glfw/src/egl_context.c",
      compile: "private/glfw/src/osmesa_context.c".}
  else:
    {.passL: "-pthread -lGL -lX11 -lXrandr -lXxf86vm -lXi -lXcursor -lm -lXinerama".}

    when defined(mir):
      {.passC: "-D_GLFW_MIR",
        compile: "private/glfw/src/mir_init.c",
        compile: "private/glfw/src/mir_monitor.c",
        compile: "private/glfw/src/mir_window.c".}
    elif defined(wayland):
      {.passC: "-D_GLFW_WAYLAND",
        compile: "private/glfw/src/wl_init.c",
        compile: "private/glfw/src/wl_monitor.c",
        compile: "private/glfw/src/wl_window.c".}
    else:
      {.passC: "-D_GLFW_X11",
        compile: "private/glfw/src/x11_init.c",
        compile: "private/glfw/src/x11_monitor.c",
        compile: "private/glfw/src/x11_window.c",
        compile: "private/glfw/src/glx_context.c".}

    {.compile: "private/glfw/src/xkb_unicode.c",
      compile: "private/glfw/src/linux_joystick.c",
      compile: "private/glfw/src/posix_time.c",
      compile: "private/glfw/src/egl_context.c",
      compile: "private/glfw/src/osmesa_context.c",
      compile: "private/glfw/src/posix_thread.c".}

  {.compile: "private/glfw/src/context.c",
    compile: "private/glfw/src/init.c",
    compile: "private/glfw/src/input.c",
    compile: "private/glfw/src/monitor.c",
    compile: "private/glfw/src/window.c".}

  {.pragma: glfw_lib, cdecl.}

type
  GLFWWindow* = ptr object
    ## Pointer reference for a GLFW Window
  GLFWMonitor* = ptr object
    ## Pointer reference for a GLFW Monitor
  GLFWCursor* = ptr object
    ## Opaque cursor object.
  GLFWGamepadState* = object
    ## This describes the input state of a gamepad.
    buttons*: array[15, bool]
    axes*: array[6, float]
  GLFWImage* = object
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

  EGLFW_CURSOR*                 = 0X00033001
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
  GLFWCursorShape* {.size: int32.sizeof.} = enum
    csArrow = 0x00036001
    csIbeam = 0x00036002
    csCrosshair = 0x00036003
    csHand = 0x00036004
    csHresize = 0x00036005
    csVresize = 0x00036006

  GLFWWindowHint* {.size: int32.sizeof.} = enum
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
  GLFWMouseButton* {.size: int32.sizeof.} = enum
    ## Mouse Buttons
    mbLeft   = 0
    mbRight  = 1
    mbMiddle = 2
    mb4      = 3
    mb5      = 4
    mb6      = 5
    mb7      = 6
    mb8      = 7
    mbLast
  GLFWJoystickState* {.size: int32.sizeof.} = enum
    ## State of the Joystick
    jsConnected    = 0x00040001
    jsDisconnected = 0x00040002
  GLFWJoystick* {.size: int32.sizeof.} = enum
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
    jsLast
  GLFWKeyAction* {.size: int32.sizeof.} = enum
    ## Action released on the key event
    kaRelease = (0, "release")
    kaPress   = (1, "press")
    kaRepeat  = (2, "repeat")
    kaLast    = "Last"
  GLFWMouseAction* {.size: int32.sizeof.} = enum
    ## Actions of the mouse
    maRelease = (0, "release")
    maPress   = (1, "press")
    maRepeat  = (2, "repeat")
    maLast    = "Last"
  GLFWKeyMod* {.size: int32.sizeof.} = enum
    ## Key Modifiers, to modify actions
    kmShift   = 0x0001
    kmControl = 0x0002
    kmAlt     = 0x0004
    kmSuper   = 0x0008
    kmLast
  GLFWGamepad* {.size: int32.sizeof.} = enum
    ## Gamepad buttons
    gpA           = 0,
    gpB           = 1,
    gpX           = 2,
    gpY           = 3,
    gpLeftBumper  = 4,
    gpRighTBumper = 5,
    gpBack        = 6,
    gpStart       = 7,
    gpGuide       = 8,
    gpLeftThumb   = 9,
    gpRightThumb  = 10,
    gpDpadUp      = 11,
    gpDpadRight   = 12,
    gpDpadDown    = 13,
    gpDpadLeft    = 14,
    gpLast
  GLFWKey* {.size: int32.sizeof.} = enum
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
  glfwJoystickProc* = proc(joystick: GLFWJoystick, state: GLFWJoystickState): void {.cdecl.}
    ## This is the function signature for joystick configuration callback functions.
    ##
    ## ``joy`` The joystick that was connected or disconnected.
    ##
    ## ``event`` One of GLFWJoystickState
  glfwCharProc* = proc(window: GLFWWindow, code: cuint): void {.cdecl.}
    ## This is the function signature for Unicode character callback functions.
    ##
    ## ``window`` The window that received the event.
    ##
    ## ``codepoint`` The Unicode code point of the character.
  glfwMouseButtonProc* = proc(window: GLFWWindow, button: GLFWMouseButton, action: GLFWMouseAction, mods: GLFWKeyMod): void {.cdecl.}
    ## This is the function signature for mouse button callback functions.
    ##
    ## ``window`` window that received the event.
    ##
    ## ``button`` ``MouseButton`` that was pressed or released.
    ##
    ## ``action`` One of ``kaPress` or ``kaRelease``.
    ##
    ## ``mods`` Bit field describing which ``KeyMods`` were
    ## held down.
  glfwKeyProc* = proc(window: GLFWWindow, key: GLFWKey, scancode: int32, action: GLFWKeyAction, mods: GLFWKeyMod): void {.cdecl.}
    ## This is the function signature for keyboard key callback functions.
    ##
    ## ``window`` ``Window`` that received the event.
    ##
    ## ``key`` ``Key`` that was pressed or released.
    ##
    ## ``scancode`` system-specific scancode of the key.
    ##
    ## ``action`` ``kaPress``, ``kaRelease`` or ``kaRepeat``.
    ##
    ## ``mods`` Bit field describing which ``KeyMods`` were held down.
  glfwScrollProc* = proc(window: GLFWWindow, xoff, yoff: cdouble): void {.cdecl.}
    ## This is the functions signature for scroll callback functions.
    ##
    ## ``window`` window that received the event.
    ##
    ## ``xoff`` scroll offset along the x-axis.
    ##
    ## ``yoff`` scroll offset along the y-axis.
  glfwErrorProc* = proc(error: GLFWErrorCode, description: cstring): void {.cdecl.}
    ## This is the function signature for error callback functions.
    ##
    ## ``error`` An error code.
    ##
    ## ``description`` A UTF-8 encoded string describing the error.
  glfwCursorPosProc* = proc(window: GLFWWindow, xpos: float64, ypos: float64): void {.cdecl.}
    ## This is the function signature for cursor position callback functions.
    ##
    ## ``window`` The window that received the event.
    ##
    ## ``xpos`` The new cursor x-coordinate, relative to the left edge of the client area.
    ##
    ## ``ypos`` The new cursor y-coordinate, relative to the top edge of the client area.
  glfwCursorEnterProc* = proc(window: GLFWWindow, entered: bool): void {.cdecl.}
    ## This is the function signature for cursor enter/leave callback functions.
    ##
    ## ``window`` The window that received the event.
    ##
    ## ``entered`` GLFW_TRUE if the cursor entered the window's client area, or GLFW_FALSE if it left it.
  glfwCharModProc* = proc(window: GLFWWindow, codepoint: uint32, mods: GLFWKeyMod): void {.cdecl.}
    ## This is the function signature for Unicode character with modifiers callback functions. It is called for each input character, regardless of what modifier keys are held down.
    ##
    ## ``window`` The window that received the event.
    ##
    ## ``codepoint`` The Unicode code point of the character.
    ##
    ## ``mods	Bit`` field describing which modifier keys were held down.
  glfwDropProc* = proc(window: GLFWWindow, count: int32, paths: cstringArray): void {.cdecl.}
    ## This is the function signature for file drop callbacks.
    ##
    ## ``window`` The window that received the event.
    ##
    ## ``count`` The number of dropped files.
    ##
    ## ``paths`` The UTF-8 encoded file and/or directory path names.
  glfwWindowPosProc* = proc(window: GLFWWindow, xpos: int32, ypos: int32): void {.cdecl.}
    ## This is the function signature for window position callback functions.
    ##
    ## ``window`` The window that was moved.
    ##
    ## ``xpos`` The new x-coordinate, in screen coordinates, of the upper-left corner of the client area of the window.
    ##
    ## ``ypos`` The new y-coordinate, in screen coordinates, of the upper-left corner of the client area of the window.
  glfwWindowSizeProc* = proc(window: GLFWWindow, widht: int32, height: int32): void {.cdecl.}
    ## This is the function signature for window size callback functions.
    ##
    ## ``window`` The window that was resized.
    ## ``width`` The new width, in screen coordinates, of the window.
    ## ``height`` The new height, in screen coordinates, of the window.
  glfwWindowCloseProc* = proc(window: GLFWWindow): void {.cdecl.}
    ## This is the function signature for window close callback functions.
    ##
    ## ``window`` The window that the user attempted to close.
  glfwWindowRefreshProc* = proc(window: GLFWWindow): void {.cdecl.}
    ## This is the function signature for window refresh callback functions.
    ##
    ## ``window`` The window whose content needs to be refreshed.
  glfwWindowFocusProc* = proc(window: GLFWWindow, focused: bool): void {.cdecl.}
    ## This is the function signature for window focus callback functions.
    ##
    ## ``window`` The window that gained or lost input focus.
    ##
    ## ``focused`` GLFW_TRUE if the window was given input focus, or GLFW_FALSE if it lost it.
  glfwWindowIconifyProc* = proc(window: GLFWWindow, iconified: bool): void {.cdecl.}
    ## This is the function signature for window iconify/restore callback functions.
    ##
    ## ``window`` The window that was iconified or restored.
    ##
    ## ``iconified`` GLFW_TRUE if the window was iconified, or GLFW_FALSE if it was restored.
  glfwFramebufferSizeProc* = proc(window: GLFWWindow, widht: int32, height: int32): void {.cdecl.}
    ## This is the function signature for framebuffer resize callback functions.
    ##
    ## ``window`` The window whose framebuffer was resized.
    ## ``width`` The new width, in pixels, of the framebuffer.
    ## ``height`` The new height, in pixels, of the framebuffer.

converter toBool*(x: int32): bool = x != 0

## All functions that start with a window won't have glfw prefix to be able to use them as member funcs in oop

proc setWindowIcon*(window: GLFWWindow, count: int32, images: ptr GLFWImage): void {.glfw_lib, importc: "glfwSetWindowIcon".}
  ## This function sets the icon of the specified window.  If passed an array of
  ## candidate images, those of or closest to the sizes desired by the system are
  ## selected.  If no images are specified, the window reverts to its default
  ## icon.

proc glfwCreateWindowC(width: int32, height: int32, title: cstring = "NimGL", monitor: GLFWMonitor = nil, share: GLFWWindow = nil): GLFWWindow {.glfw_lib, importc: "glfwCreateWindow".}
  ## Creates a window and its associated OpenGL or OpenGL ES
  ## context. Most of the options controlling how the window and its context
  ## should be created are specified with ``window_hints``.
  ## We recommend you to generate a config and modify it instead but this is
  ## the official way to create a window

proc glfwCreateWindow*(width: int32, height: int32, title: cstring = "NimGL", monitor: GLFWMonitor = nil, share: GLFWWindow = nil, icon: bool = true): GLFWWindow =
  ## Creates a window and its associated OpenGL or OpenGL ES
  ## Utility to create the window with a proper icon.
  result = glfwCreateWindowC(width, height, title, monitor, share)
  if not icon: return result
  let data: ImageData = stbi_load_from_memory(cast[ptr char](nimgl_logo[0].addr), nimgl_logo.len.int32)
  var image: GLFWImage = GLFWImage(pixels: data.data, width: data.width, height: data.height)
  result.setWindowIcon(1, image.addr)
  image.pixels.stbi_image_free()

proc glfwInit*(): bool {.glfw_lib, importc: "glfwInit".}
  ## Initializes the GLFW library. Before most GLFW functions can
  ## be used, GLFW must be initialized, and before an application terminates GLFW
  ## should be terminated in order to free any resources allocated during or
  ## after initialization.
  ##
  ## Returns ``glfwTRUE`` if successful, or ``glfwFALSE`` if an error ocurred.

proc glfwTerminate*(): void {.glfw_lib, importc: "glfwTerminate".}
  ## Destroys all remaining windows and cursors, restores any
  ## modified gamma ramps and frees any other allocated resources.  Once this
  ## function is called, you must again call ``glfwInit`` successfully before
  ## you will be able to use most GLFW functions.

proc destroyWindow*(window: GLFWWindow): void {.glfw_lib, importc: "glfwDestroyWindow".}
  ## Destroys the specified window and its context.  On calling
  ## this function, no further callbacks will be called for that window.

proc makeContextCurrent*(window: GLFWWindow): void {.glfw_lib, importc: "glfwMakeContextCurrent".}
  ## Makes the OpenGL or OpenGL ES context of the specified window
  ## current on the calling thread.  A context can only be made current on
  ## a single thread at a time and each thread can have only a single current

proc setWindowShouldClose*(window: GLFWWindow, value: bool): void {.glfw_lib, importc: "glfwSetWindowShouldClose".}
  ## This function sets the value of the close flag of the specified window.
  ## This can be used to override the user's attempt to close the window, or
  ## to signal that it should be closed.

proc windowShouldClose*(window: GLFWWindow): bool {.glfw_lib, importc: "glfwWindowShouldClose".}
  ## Returns the value of the close flag of the specified window.

proc swapBuffers*(window: GLFWWindow): void {.glfw_lib, importc: "glfwSwapBuffers".}
  ## Swaps the front and back buffers of the specified window when
  ## rendering with OpenGL or OpenGL ES.  If the swap interval is greater than
  ## zero, the GPU driver waits the specified number of screen updates before
  ## swapping the buffers.

proc glfwPollEvents*(): void {.glfw_lib, importc: "glfwPollEvents".}
  ## Processes only those events that are already in the event
  ## queue and then returns immediately.  Processing events will cause the window
  ## and input callbacks associated with those events to be called.

proc glfwGetTime*(): cdouble {.glfw_lib, importc: "glfwGetTime".}
  ## This function returns the value of the GLFW timer. Unless the timer has
  ## been set using ``setTime``, the timer measures time elapsed since GLFW
  ## was initialized.

proc glfwSetTime*(time: cdouble): void {.glfw_lib, importc: "glfwSetTime".}
  ## This function sets the value of the GLFW timer.  It then continues to count
  ## up from that value.  The value must be a positive finite number less than
  ## or equal to 18446744073.0, which is approximately 584.5 years.

proc glfwGetCurrentContext*(): GLFWWindow {.glfw_lib, importc: "glfwGetCurrentContext".}
  ## This function returns the window whose OpenGL or OpenGL ES context is
  ## current on the calling thread.

proc getKey*(window: GLFWWindow, key: GLFWKey): GLFWKeyAction {.glfw_lib, importc: "glfwGetKey".}
  ## This function returns the last state reported for the specified key to the
  ## specified window.  The returned state is one of ``kaPress`` or
  ## ``kaRelease``.  The higher-level action ``kaRepeat`` is only reported to
  ## the key callback.

proc setWindowTitle*(window: GLFWWindow, title: cstring): void {.glfw_lib, importc: "glfwSetWindowTitle".}
  ## This function sets the window title, encoded as UTF-8, of the specified
  ## window.

proc glfwWindowHint*(hint: GLFWWindowHint, value: int32): void {.glfw_lib, importc: "glfwWindowHint".}
  ## This function sets hints for the next call to ``createWindow``  The
  ## hints, once set, retain their values until changed by a call to.
  ## ``windowHint`` or ``defaultWindowHints``, or until the library is
  ## terminated.
  ##
  ## To read more visit `here <http://www.glfw.org/docs/latest/window_guide.html#window_hints_values>`_.

proc glfwDefaultWindowHints*(): void {.glfw_lib, importc: "glfwDefaultWindowHints".}
  ## Resets all window hints to their default values.

proc glfwGetProcAddress*(procname: cstring): pointer {.glfw_lib, importc: "glfwGetProcAddress".}
  ## This function returns the address of the specified OpenGL or OpenGL ES
  ## core or extension function, if it is supported
  ## by the current context.
  ##
  ## A context must be current on the calling thread.  Calling this function
  ## without a current context will cause a GLFW_NO_CURRENT_CONTEXT error.

proc getCursorPos*(window: GLFWWindow, xpos, ypos: var cdouble): void {.glfw_lib, importc: "glfwGetCursorPos".}
  ## This function returns the position of the cursor, in screen coordinates,
  ## relative to the upper-left corner of the client area of the specified
  ## window.

proc getClipboardString*(window: GLFWWindow): cstring {.glfw_lib, importc: "glfwGetClipboardString".}
  ## This function returns the contents of the system clipboard, if it contains
  ## or is convertible to a UTF-8 encoded string.  If the clipboard is empty or
  ## if its contents cannot be converted, `NULL` is returned and a
  ## GLFW_FORMAT_UNAVAILABLE error is generated.

proc setClipboardString*(window: GLFWWindow, clip: cstring): void {.glfw_lib, importc: "glfwSetClipboardString".}
  ## This function sets the system clipboard to the specified, UTF-8 encoded
  ## string.

proc setKeyCallback*(window: GLFWWindow, `proc`: glfwKeyProc): glfwKeyProc {.glfw_lib, importc: "glfwSetKeyCallback".}
  ## This function sets the key callback of the specified window, which is called
  ## when a key is pressed, repeated or released.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setMouseButtonCallback*(window: GLFWWindow, `proc`: glfwMouseButtonProc): glfwMouseButtonProc {.glfw_lib, importc: "glfwSetMouseButtonCallback".}
  ## This function sets the mouse button callback of the specified window, which
  ## is called when a mouse button is pressed or released.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setCharCallback*(window: GLFWWindow, `proc`: glfwCharProc): glfwCharProc {.glfw_lib, importc: "glfwSetCharCallback".}
  ## This function sets the character callback of the specified window, which is
  ## called when a Unicode character is input.
  ##
  ## The character callback is intended for Unicode text input.  As it deals with
  ## characters, it is keyboard layout dependent, whereas the
  ## ``setKeyCallback`` is not. Characters do not map 1:1
  ## to physical keys, as a key may produce zero, one or more characters.  If you
  ## want to know whether a specific physical key was pressed or released, see
  ## the key callback instead.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setScrollCallback*(window: GLFWWindow, callback: glfwScrollProc): glfwScrollProc {.glfw_lib, importc: "glfwSetScrollCallback".}
  ## This function sets the scroll callback of the specified window, which is
  ## called when a scrolling device is used, such as a mouse wheel or scrolling
  ## area of a touchpad.
  ##
  ## The scroll callback receives all scrolling input, like that from a mouse
  ## wheel or a touchpad scrolling area.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc glfwCreateStandardCursor*(shape: GLFWCursorShape): GLFWCursor {.glfw_lib, importc: "glfwCreateStandardCursor".}
  ## Returns a cursor with a ``CursorShape``, that can be set for
  ## a window with ``setCursor``.

proc glfwDestroyCursor*(cursor: GLFWCursor): void {.glfw_lib, importc: "glfwDestroyCursor".}
  ## This function destroys a cursor previously created with
  ## ``createCursor``. Any remaining cursors will be destroyed by
  ## ``terminate``.

proc glfwGetPrimaryMonitor*(): GLFWMonitor {.glfw_lib, importc: "glfwGetPrimaryMonitor".}
  ## This function returns the primary monitor.  This is usually the monitor
  ## where elements like the task bar or global menu bar are located.

proc getWindowSize*(window: GLFWWindow, width, height: var int32) {.glfw_lib, importc: "glfwGetWindowSize".}
  ## This function retrieves the size, in screen coordinates, of the client area
  ## of the specified window.  If you wish to retrieve the size of the
  ## framebuffer of the window in pixels, see ``getFramebufferSize``.

proc getFramebufferSize*(window: GLFWWindow, width, height: var int32) {.glfw_lib, importc: "glfwGetFramebufferSize".}
  ## This function retrieves the size, in screen coordinates, of the client area
  ## of the specified window.  If you wish to retrieve the size of the
  ## framebuffer of the window in pixels, see ``getFramebufferSize``.

proc getWindowAttrib*(window: GLFWWindow, attrib: GLFWWindowHint): int32 {.glfw_lib, importc: "glfwGetWindowAttrib".}
  ## This function returns the value of an attribute of the specified window or
  ## its OpenGL or OpenGL ES context.
  # To be honest I don't know if it returns a boolean int or if it can have different
  # values so, I return int

proc getMouseButton*(window: GLFWWindow, button: int32): int32 {.glfw_lib, importc: "glfwGetMouseButton".}
  ## This function returns the last state reported for the specified mouse button
  ## to the specified window.  The returned state is one of ``maPress`` or
  ## ``maRelease``.

proc glfwJoystickPresent*(joystick: GLFWJoystick): bool {.glfw_lib, importc: "glfwJoystickPresent".}
  ## This function returns whether the specified joystick is present.
  ## Returns GLFW_TRUE if the joystick is present, or GLFW_FALSE otherwise.

proc glfwGetJoystickName*(joystick: GLFWJoystick): cstring {.glfw_lib, importc: "glfwGetJoystickName".}
  ## This function returns the name, encoded as UTF-8, of the specified joystick. The returned string is allocated and
  ## freed by GLFW. You should not free it yourself.
  ## Querying a joystick slot with no device present is not an error, but will cause this function to return NULL.
  ## Call glfwJoystickPresent to check device presence.

proc glfwGetGamepadName*(joystick: GLFWJoystick): cstring {.glfw_lib, importc: "glfwGetGamepadName".}
  ## This function returns the human-readable name of the gamepad from the gamepad mapping assigned to the specified joystick.
  ## If the specified joystick is not present or does not have a gamepad mapping this function will return NULL but will
  ## not generate an error. Call glfwJoystickPresent to check whether it is present regardless of whether it has a mapping.

proc glfwGetGamepadState*(joystick: GLFWJoystick, state: ptr GLFWGamepadState): bool {.glfw_lib, importc: "glfwGetGamepadState".}
  ## This function retrives the state of the specified joystick remapped to an Xbox-like gamepad.
  ## If the specified joystick is not present or does not have a gamepad mapping this function will return GLFW_FALSE but
  ## will not generate an error. Call glfwJoystickPresent to check whether it is present regardless of whether it has a mapping.
  ## The Guide button may not be available for input as it is often hooked by the system or the Steam client.
  ## Not all devices have all the buttons or axes provided by GLFWgamepadstate. Unavailable buttons and axes will always
  ## report GLFW_RELEASE and 0.0 respectively.

proc glfwSetJoystickCallback*(`proc`: glfwJoystickProc): glfwJoystickProc {.glfw_lib, importc: "glfwSetJoystickCallback".}
  ## This function sets the joystick configuration callback, or removes the currently set callback. This is called when a
  ## joystick is connected to or disconnected from the system.
  ## Returns The previously set callback, or nil if no callback was set or the library had not been initialized.

proc glfwSetErrorCallback*(`proc`: glfwErrorProc): glfwErrorProc {.glfw_lib, importc: "glfwSetErrorCallback".}
  ## This function sets the error callback, which is called with an error code and a human-readable description each time a GLFW error occurs.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setCursorPosCallback*(window: GLFWWindow, `proc`: glfwCursorPosProc): glfwCursorPosProc {.glfw_lib, importc: "glfwSetCursorPosCallback".}
  ## This function sets the cursor position callback of the specified window, which is called when the cursor is moved.
  ## The callback is provided with the position, in screen coordinates, relative to the upper-left corner of the client
  ## area of the window.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setCursorEnterCallback*(window: GLFWWindow, `proc`: glfwCursorEnterProc): glfwCursorEnterProc {.glfw_lib, importc: "glfwSetCursorEnterCallback".}
  ## This function sets the cursor boundary crossing callback of the specified window, which is called when the cursor
  ## enters or leaves the client area of the window.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setCharModsCallback*(window: GLFWWindow, `proc`: glfwCharModProc): glfwCharModProc {.glfw_lib, importc: "glfwSetCharModsCallback".}
  ## This function sets the character with modifiers callback of the specified window, which is called when a Unicode
  ## character is input regardless of what modifier keys are used.
  ## The character with modifiers callback is intended for implementing custom Unicode character input. For regular
  ## Unicode text input, see the character callback. Like the character callback, the character with modifiers callback
  ## deals with characters and is keyboard layout dependent. Characters do not map 1:1 to physical keys, as a key may produce
  ## zero, one or more characters. If you want to know whether a specific physical key was pressed or released, see the
  ## key callback instead.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setDropCallback*(window: GLFWWindow, `proc`: glfwDropProc): glfwDropProc {.glfw_lib, importc: "glfwSetDropCallback".}
  ## This function sets the file drop callback of the specified window, which is called when one or more dragged files are
  ## dropped on the window.
  ## Because the path array and its strings may have been generated specifically for that event, they are not guaranteed
  ## to be valid after the callback has returned. If you wish to use them after the callback returns, you need to make a deep copy.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setWindowPosCallback*(window: GLFWWindow, `proc`: glfwWindowPosProc): glfwWindowPosProc {.glfw_lib, importc: "glfwSetWindowPosCallback".}
  ## This function sets the position callback of the specified window, which is called when the window is moved.
  ## The callback is provided with the screen position of the upper-left corner of the client area of the window.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setWindowSizeCallback*(window: GLFWWindow, `proc`: glfwWindowSizeProc): glfwWindowSizeProc {.glfw_lib, importc: "glfwSetWindowSizeCallback".}
  ## This function sets the size callback of the specified window, which is called when the window is resized.
  ## The callback is provided with the size, in screen coordinates, of the client area of the window.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setWindowCloseCallback*(window: GLFWWindow, `proc`: glfwWindowCloseProc): glfwWindowCloseProc {.glfw_lib, importc: "glfwSetWindowCloseCallback".}
  ## This function sets the close callback of the specified window, which is called when the user attempts to close the
  ## window, for example by clicking the close widget in the title bar.
  ## The close flag is set before this callback is called, but you can modify it at any time with glfwSetWindowShouldClose.
  ## The close callback is not triggered by glfwDestroyWindow.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setWindowRefreshCallback*(window: GLFWWindow, `proc`: glfwWindowRefreshProc): glfwWindowRefreshProc {.glfw_lib, importc: "glfwSetWindowRefreshCallback".}
  ## This function sets the refresh callback of the specified window, which is called when the client area of the window
  ## needs to be redrawn, for example if the window has been exposed after having been covered by another window.
  ## On compositing window systems such as Aero, Compiz or Aqua, where the window contents are saved off-screen, this
  ## callback may be called only very infrequently or never at all.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setWindowFocusCallback*(window: GLFWWindow, `proc`: glfwWindowFocusProc): glfwWindowFocusProc {.glfw_lib, importc: "glfwSetWindowFocusCallback".}
  ## This function sets the focus callback of the specified window, which is called when the window gains or loses input focus.
  ## After the focus callback is called for a window that lost input focus, synthetic key and mouse button release events
  ## will be generated for all such that had been pressed. For more information, see glfwSetKeyCallback and glfwSetMouseButtonCallback.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setWindowIconifyCallback*(window: GLFWWindow, `proc`: glfwWindowIconifyProc): glfwWindowIconifyProc {.glfw_lib, importc: "glfwSetWindowIconifyCallback".}
  ## This function sets the iconification callback of the specified window, which is called when the window is iconified or restored.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

proc setFramebufferSizeCallback*(window: GLFWWindow, `proc`: glfwFramebufferSizeProc): glfwFramebufferSizeProc {.glfw_lib, importc: "glfwSetFramebufferSizeCallback".}
  ## This function sets the framebuffer resize callback of the specified window, which is called when the framebuffer
  ## of the specified window is resized.
  ## Returns The previously set callback, or nil if no callback was set or an error occurred.

when defined(windows):
  proc getWin32Window*(window: GLFWWindow): pointer {.glfw_lib, importc: "glfwGetWin32Window".}
    ## returns The ``HWND`` of the specified window, or ``nil`` if an error occurred.
else:
  proc getWin32Window*(window: GLFWWindow): pointer = nil
    ## if you are not working in windows this returns a nil so you can still use it
