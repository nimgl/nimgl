# Copyright 2019, NimGL contributors.

## GLFW Bindings
## ====
## WARNING: This is a generated file. Do not edit
## Any edits will be overwritten by the generator.
##
## The aim is to achieve as much compatibility with C as possible.
## All procedures which have a GLFW object in the arguments won't have the glfw prefix.
## Turning ``glfwMakeContextCurrent(window)`` into ``window.makeContextCurrent()``.
##
## You can check the original documentation `here <http://www.glfw.org/docs/latest/>`_.

import ./private/logo

when defined(glfwDLL):
  when defined(windows):
    const glfw_dll* = "glfw3.dll"
  elif defined(macosx):
    const glfw_dll* = "libglfw3.dylib"
  else:
    const glfw_dll* = "libglfw.so.3"
else:
  when not defined(emscripten):
    {.compile: "private/glfw/src/vulkan.c".}

  # Thanks to ephja for making this build system
  when defined(emscripten):
    {.passL: "-s USE_GLFW=3".}
  elif defined(windows):
    when defined(vcc):
      {.passL: "opengl32.lib gdi32.lib user32.lib shell32.lib" .}
    else:
      {.passL: "-lopengl32 -lgdi32" .}
    {.passC: "-D_GLFW_WIN32",
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
    {.passL: "-pthread -lGL".}

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

  when not defined(emscripten):
    {.compile: "private/glfw/src/context.c",
      compile: "private/glfw/src/init.c",
      compile: "private/glfw/src/input.c",
      compile: "private/glfw/src/monitor.c",
      compile: "private/glfw/src/window.c".}

when defined(vulkan):
  import ./vulkan

# Constants and Enums
const
  GLFWVersionMajor* = 3
    ## @brief The major version number of the GLFW header.
    ##
    ## The major version number of the GLFW header.  This is incremented when the
    ## API is changed in non-compatible ways.
    ## @ingroup init
const
  GLFWVersionMinor* = 4
    ## @brief The minor version number of the GLFW header.
    ##
    ## The minor version number of the GLFW header.  This is incremented when
    ## features are added to the API but it remains backward-compatible.
    ## @ingroup init
const
  GLFWVersionRevision* = 0
    ## @brief The revision number of the GLFW header.
    ##
    ## The revision number of the GLFW header.  This is incremented when a bug fix
    ## release is made that does not contain any API changes.
    ## @ingroup init
const
  GLFWTrue* = 1
    ## @brief One.
    ##
    ## This is only semantic sugar for the number 1.  You can instead use `1` or
    ## `true` or `_True` or `GL_TRUE` or `VK_TRUE` or anything else that is equal
    ## to one.
    ##
    ## @ingroup init
const
  GLFWFalse* = 0
    ## @brief Zero.
    ##
    ## This is only semantic sugar for the number 0.  You can instead use `0` or
    ## `false` or `_False` or `GL_FALSE` or `VK_FALSE` or anything else that is
    ## equal to zero.
    ##
    ## @ingroup init
const
  GLFWRelease* = 0
    ## @brief The key or mouse button was released.
    ##
    ## The key or mouse button was released.
    ##
    ## @ingroup input
const
  GLFWPress* = 1
    ## @brief The key or mouse button was pressed.
    ##
    ## The key or mouse button was pressed.
    ##
    ## @ingroup input
const
  GLFWRepeat* = 2
    ## @brief The key was held down until it repeated.
    ##
    ## The key was held down until it repeated.
    ##
    ## @ingroup input
type
  GLFWHat* {.pure, size: int32.sizeof.} = enum
    ## @defgroup hat_state Joystick hat states
    ## @brief Joystick hat states.
    ##
    ## See joystick hat input for how these are used.
    ##
    ## @ingroup input
    Centered = 0
    Up = 1
    Right = 2
    Down = 4
    Left = 8
type
  GLFWKey* {.pure, size: int32.sizeof.} = enum
    ## @defgroup keys Keyboard keys
    ## @brief Keyboard key IDs.
    ##
    ## See key input for how these are used.
    ##
    ## These key codes are inspired by the _USB HID Usage Tables v1.12_ (p. 53-60),
    ## but re-arranged to map to 7-bit ASCII for printable keys (function keys are
    ## put in the 256+ range).
    ##
    ## The naming of the key codes follow these rules:
    ##  - The US keyboard layout is used
    ##  - Names of printable alpha-numeric characters are used (e.g. "A", "R",
    ##    "3", etc.)
    ##  - For non-alphanumeric characters, Unicode:ish names are used (e.g.
    ##    "COMMA", "LEFT_SQUARE_BRACKET", etc.). Note that some names do not
    ##    correspond to the Unicode standard (usually for brevity)
    ##  - Keys that lack a clear US mapping are named "WORLD_x"
    ##  - For non-printable keys, custom names are used (e.g. "F4",
    ##    "BACKSPACE", etc.)
    ##
    ## @ingroup input
    Space = 32
    Apostrophe = 39
    Comma = 44
    Minus = 45
    Period = 46
    Slash = 47
    K0 = 48
    K1 = 49
    K2 = 50
    K3 = 51
    K4 = 52
    K5 = 53
    K6 = 54
    K7 = 55
    K8 = 56
    K9 = 57
    Semicolon = 59
    Equal = 61
    A = 65
    B = 66
    C = 67
    D = 68
    E = 69
    F = 70
    G = 71
    H = 72
    I = 73
    J = 74
    K = 75
    L = 76
    M = 77
    N = 78
    O = 79
    P = 80
    Q = 81
    R = 82
    S = 83
    T = 84
    U = 85
    V = 86
    W = 87
    X = 88
    Y = 89
    Z = 90
    LeftBracket = 91
    Backslash = 92
    RightBracket = 93
    GraveAccent = 96
    World1 = 161
    World2 = 162
    Escape = 256
    Enter = 257
    Tab = 258
    Backspace = 259
    Insert = 260
    Delete = 261
    Right = 262
    Left = 263
    Down = 264
    Up = 265
    PageUp = 266
    PageDown = 267
    Home = 268
    End = 269
    CapsLock = 280
    ScrollLock = 281
    NumLock = 282
    PrintScreen = 283
    Pause = 284
    F1 = 290
    F2 = 291
    F3 = 292
    F4 = 293
    F5 = 294
    F6 = 295
    F7 = 296
    F8 = 297
    F9 = 298
    F10 = 299
    F11 = 300
    F12 = 301
    F13 = 302
    F14 = 303
    F15 = 304
    F16 = 305
    F17 = 306
    F18 = 307
    F19 = 308
    F20 = 309
    F21 = 310
    F22 = 311
    F23 = 312
    F24 = 313
    F25 = 314
    Kp0 = 320
    Kp1 = 321
    Kp2 = 322
    Kp3 = 323
    Kp4 = 324
    Kp5 = 325
    Kp6 = 326
    Kp7 = 327
    Kp8 = 328
    Kp9 = 329
    KpDecimal = 330
    KpDivide = 331
    KpMultiply = 332
    KpSubtract = 333
    KpAdd = 334
    KpEnter = 335
    KpEqual = 336
    LeftShift = 340
    LeftControl = 341
    LeftAlt = 342
    LeftSuper = 343
    RightShift = 344
    RightControl = 345
    RightAlt = 346
    RightSuper = 347
    Menu = 348
const
  GLFWModShift* = 0x0001
    ## @brief If this bit is set one or more Shift keys were held down.
    ##
    ## If this bit is set one or more Shift keys were held down.
const
  GLFWModControl* = 0x0002
    ## @brief If this bit is set one or more Control keys were held down.
    ##
    ## If this bit is set one or more Control keys were held down.
const
  GLFWModAlt* = 0x0004
    ## @brief If this bit is set one or more Alt keys were held down.
    ##
    ## If this bit is set one or more Alt keys were held down.
const
  GLFWModSuper* = 0x0008
    ## @brief If this bit is set one or more Super keys were held down.
    ##
    ## If this bit is set one or more Super keys were held down.
const
  GLFWModCapsLock* = 0x0010
    ## @brief If this bit is set the Caps Lock key is enabled.
    ##
    ## If this bit is set the Caps Lock key is enabled and the
    ## GLFW_LOCK_KEY_MODS input mode is set.
const
  GLFWModNumLock* = 0x0020
    ## @brief If this bit is set the Num Lock key is enabled.
    ##
    ## If this bit is set the Num Lock key is enabled and the
    ## GLFW_LOCK_KEY_MODS input mode is set.
type
  GLFWMouseButton* {.pure, size: int32.sizeof.} = enum
    ## @defgroup buttons Mouse buttons
    ## @brief Mouse button IDs.
    ##
    ## See mouse button input for how these are used.
    ##
    ## @ingroup input
    Button1 = 0
    Button2 = 1
    Button3 = 2
    Button4 = 3
    Button5 = 4
    Button6 = 5
    Button7 = 6
    Button8 = 7
type
  GLFWJoystick* {.pure, size: int32.sizeof.} = enum
    ## @defgroup joysticks Joysticks
    ## @brief Joystick IDs.
    ##
    ## See joystick input for how these are used.
    ##
    ## @ingroup input
    K1 = 0
    K2 = 1
    K3 = 2
    K4 = 3
    K5 = 4
    K6 = 5
    K7 = 6
    K8 = 7
    K9 = 8
    K10 = 9
    K11 = 10
    K12 = 11
    K13 = 12
    K14 = 13
    K15 = 14
    K16 = 15
type
  GLFWGamepadButton* {.pure, size: int32.sizeof.} = enum
    ## @defgroup gamepad_buttons Gamepad buttons
    ## @brief Gamepad buttons.
    ##
    ## See  gamepad for how these are used.
    ##
    ## @ingroup input
    A = 0
    B = 1
    X = 2
    Y = 3
    LeftBumper = 4
    RightBumper = 5
    Back = 6
    Start = 7
    Guide = 8
    LeftThumb = 9
    RightThumb = 10
    DpadUp = 11
    DpadRight = 12
    DpadDown = 13
    DpadLeft = 14
type
  GLFWGamepadAxis* {.pure, size: int32.sizeof.} = enum
    ## @defgroup gamepad_axes Gamepad axes
    ## @brief Gamepad axes.
    ##
    ## See  gamepad for how these are used.
    ##
    ## @ingroup input
    LeftX = 0
    LeftY = 1
    RightX = 2
    RightY = 3
    LeftTrigger = 4
    RightTrigger = 5
const
  GLFWNoError* = 0
    ## @brief No error has occurred.
    ##
    ## No error has occurred.
    ##
    ## @analysis Yay.
const
  GLFWNotInitialized* = 0x00010001
    ## @brief GLFW has not been initialized.
    ##
    ## This occurs if a GLFW function was called that must not be called unless the
    ## library is initialized.
    ##
    ## @analysis Application programmer error.  Initialize GLFW before calling any
    ## function that requires initialization.
const
  GLFWNoCurrentContext* = 0x00010002
    ## @brief No context is current for this thread.
    ##
    ## This occurs if a GLFW function was called that needs and operates on the
    ## current OpenGL or OpenGL ES context but no context is current on the calling
    ## thread.  One such function is  glfwSwapInterval.
    ##
    ## @analysis Application programmer error.  Ensure a context is current before
    ## calling functions that require a current context.
const
  GLFWInvalidEnum* = 0x00010003
    ## @brief One of the arguments to the function was an invalid enum value.
    ##
    ## One of the arguments to the function was an invalid enum value, for example
    ## requesting  GLFW_RED_BITS with  glfwGetWindowAttrib.
    ##
    ## @analysis Application programmer error.  Fix the offending call.
const
  GLFWInvalidValue* = 0x00010004
    ## @brief One of the arguments to the function was an invalid value.
    ##
    ## One of the arguments to the function was an invalid value, for example
    ## requesting a non-existent OpenGL or OpenGL ES version like 2.7.
    ##
    ## Requesting a valid but unavailable OpenGL or OpenGL ES version will instead
    ## result in a  GLFW_VERSION_UNAVAILABLE error.
    ##
    ## @analysis Application programmer error.  Fix the offending call.
const
  GLFWOutOfMemory* = 0x00010005
    ## @brief A memory allocation failed.
    ##
    ## A memory allocation failed.
    ##
    ## @analysis A bug in GLFW or the underlying operating system.  Report the bug
    ## to our [issue tracker](https://github.com/glfw/glfw/issues).
const
  GLFWApiUnavailable* = 0x00010006
    ## @brief GLFW could not find support for the requested API on the system.
    ##
    ## GLFW could not find support for the requested API on the system.
    ##
    ## @analysis The installed graphics driver does not support the requested
    ## API, or does not support it via the chosen context creation backend.
    ## Below are a few examples.
    ##
    ## @par
    ## Some pre-installed Windows graphics drivers do not support OpenGL.  AMD only
    ## supports OpenGL ES via EGL, while Nvidia and Intel only support it via
    ## a WGL or GLX extension.  macOS does not provide OpenGL ES at all.  The Mesa
    ## EGL, OpenGL and OpenGL ES libraries do not interface with the Nvidia binary
    ## driver.  Older graphics drivers do not support Vulkan.
const
  GLFWVersionUnavailable* = 0x00010007
    ## @brief The requested OpenGL or OpenGL ES version is not available.
    ##
    ## The requested OpenGL or OpenGL ES version (including any requested context
    ## or framebuffer hints) is not available on this machine.
    ##
    ## @analysis The machine does not support your requirements.  If your
    ## application is sufficiently flexible, downgrade your requirements and try
    ## again.  Otherwise, inform the user that their machine does not match your
    ## requirements.
    ##
    ## @par
    ## Future invalid OpenGL and OpenGL ES versions, for example OpenGL 4.8 if 5.0
    ## comes out before the 4.x series gets that far, also fail with this error and
    ## not  GLFW_INVALID_VALUE, because GLFW cannot know what future versions
    ## will exist.
const
  GLFWPlatformError* = 0x00010008
    ## @brief A platform-specific error occurred that does not match any of the
    ## more specific categories.
    ##
    ## A platform-specific error occurred that does not match any of the more
    ## specific categories.
    ##
    ## @analysis A bug or configuration error in GLFW, the underlying operating
    ## system or its drivers, or a lack of required resources.  Report the issue to
    ## our [issue tracker](https://github.com/glfw/glfw/issues).
const
  GLFWFormatUnavailable* = 0x00010009
    ## @brief The requested format is not supported or available.
    ##
    ## If emitted during window creation, the requested pixel format is not
    ## supported.
    ##
    ## If emitted when querying the clipboard, the contents of the clipboard could
    ## not be converted to the requested format.
    ##
    ## @analysis If emitted during window creation, one or more
    ## hard constraints did not match any of the
    ## available pixel formats.  If your application is sufficiently flexible,
    ## downgrade your requirements and try again.  Otherwise, inform the user that
    ## their machine does not match your requirements.
    ##
    ## @par
    ## If emitted when querying the clipboard, ignore the error or report it to
    ## the user, as appropriate.
const
  GLFWNoWindowContext* = 0x0001000A
    ## @brief The specified window does not have an OpenGL or OpenGL ES context.
    ##
    ## A window that does not have an OpenGL or OpenGL ES context was passed to
    ## a function that requires it to have one.
    ##
    ## @analysis Application programmer error.  Fix the offending call.
const
  GLFWCursorUnavailable* = 0x0001000B
    ## @brief The specified cursor shape is not available.
    ##
    ## The specified standard cursor shape is not available, either because the
    ## current system cursor theme does not provide it or because it is not
    ## available on the platform.
    ##
    ## @analysis Platform or system settings limitation.  Pick another
    ## standard cursor shape or create a
    ## custom cursor.
const
  GLFWFeatureUnavailable* = 0x0001000C
    ## @brief The requested feature is not provided by the platform.
    ##
    ## The requested feature is not provided by the platform, so GLFW is unable to
    ## implement it.  The documentation for each function notes if it could emit
    ## this error.
    ##
    ## @analysis Platform or platform version limitation.  The error can be ignored
    ## unless the feature is critical to the application.
    ##
    ## @par
    ## A function call that emits this error has no effect other than the error and
    ## updating any existing out parameters.
const
  GLFWFeatureUnimplemented* = 0x0001000D
    ## @brief The requested feature is not implemented for the platform.
    ##
    ## The requested feature has not yet been implemented in GLFW for this platform.
    ##
    ## @analysis An incomplete implementation of GLFW for this platform, hopefully
    ## fixed in a future release.  The error can be ignored unless the feature is
    ## critical to the application.
    ##
    ## @par
    ## A function call that emits this error has no effect other than the error and
    ## updating any existing out parameters.
const
  GLFWFocused* = 0x00020001
    ## @brief Input focus window hint and attribute
    ##
    ## Input focus window hint or
    ## window attribute.
const
  GLFWIconified* = 0x00020002
    ## @brief Window iconification window attribute
    ##
    ## Window iconification window attribute.
const
  GLFWResizable* = 0x00020003
    ## @brief Window resize-ability window hint and attribute
    ##
    ## Window resize-ability window hint and
    ## window attribute.
const
  GLFWVisible* = 0x00020004
    ## @brief Window visibility window hint and attribute
    ##
    ## Window visibility window hint and
    ## window attribute.
const
  GLFWDecorated* = 0x00020005
    ## @brief Window decoration window hint and attribute
    ##
    ## Window decoration window hint and
    ## window attribute.
const
  GLFWAutoIconify* = 0x00020006
    ## @brief Window auto-iconification window hint and attribute
    ##
    ## Window auto-iconification window hint and
    ## window attribute.
const
  GLFWFloating* = 0x00020007
    ## @brief Window decoration window hint and attribute
    ##
    ## Window decoration window hint and
    ## window attribute.
const
  GLFWMaximized* = 0x00020008
    ## @brief Window maximization window hint and attribute
    ##
    ## Window maximization window hint and
    ## window attribute.
const
  GLFWCenterCursor* = 0x00020009
    ## @brief Cursor centering window hint
    ##
    ## Cursor centering window hint.
const
  GLFWTransparentFramebuffer* = 0x0002000A
    ## @brief Window framebuffer transparency hint and attribute
    ##
    ## Window framebuffer transparency
    ## window hint and
    ## window attribute.
const
  GLFWHovered* = 0x0002000B
    ## @brief Mouse cursor hover window attribute.
    ##
    ## Mouse cursor hover window attribute.
const
  GLFWFocusOnShow* = 0x0002000C
    ## @brief Input focus on calling show window hint and attribute
    ##
    ## Input focus window hint or
    ## window attribute.
const
  GLFWMouseButtonPassthrough* = 0x0002000D
    ## @brief Mouse input transparency window hint and attribute
    ##
    ## Mouse input transparency window hint or
    ## window attribute.
const
  GLFWRedBits* = 0x00021001
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth hint.
const
  GLFWGreenBits* = 0x00021002
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth hint.
const
  GLFWBlueBits* = 0x00021003
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth hint.
const
  GLFWAlphaBits* = 0x00021004
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth hint.
const
  GLFWDepthBits* = 0x00021005
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth hint.
const
  GLFWStencilBits* = 0x00021006
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth hint.
const
  GLFWAccumRedBits* = 0x00021007
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth hint.
const
  GLFWAccumGreenBits* = 0x00021008
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth hint.
const
  GLFWAccumBlueBits* = 0x00021009
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth hint.
const
  GLFWAccumAlphaBits* = 0x0002100A
    ## @brief Framebuffer bit depth hint.
    ##
    ## Framebuffer bit depth hint.
const
  GLFWAuxBuffers* = 0x0002100B
    ## @brief Framebuffer auxiliary buffer hint.
    ##
    ## Framebuffer auxiliary buffer hint.
const
  GLFWStereo* = 0x0002100C
    ## @brief OpenGL stereoscopic rendering hint.
    ##
    ## OpenGL stereoscopic rendering hint.
const
  GLFWSamples* = 0x0002100D
    ## @brief Framebuffer MSAA samples hint.
    ##
    ## Framebuffer MSAA samples hint.
const
  GLFWSrgbCapable* = 0x0002100E
    ## @brief Framebuffer sRGB hint.
    ##
    ## Framebuffer sRGB hint.
const
  GLFWRefreshRate* = 0x0002100F
    ## @brief Monitor refresh rate hint.
    ##
    ## Monitor refresh rate hint.
const
  GLFWDoublebuffer* = 0x00021010
    ## @brief Framebuffer double buffering hint and attribute.
    ##
    ## Framebuffer double buffering hint and
    ## attribute.
const
  GLFWClientApi* = 0x00022001
    ## @brief Context client API hint and attribute.
    ##
    ## Context client API hint and
    ## attribute.
const
  GLFWContextVersionMajor* = 0x00022002
    ## @brief Context client API major version hint and attribute.
    ##
    ## Context client API major version hint
    ## and attribute.
const
  GLFWContextVersionMinor* = 0x00022003
    ## @brief Context client API minor version hint and attribute.
    ##
    ## Context client API minor version hint
    ## and attribute.
const
  GLFWContextRevision* = 0x00022004
    ## @brief Context client API revision number hint and attribute.
    ##
    ## Context client API revision number
    ## attribute.
const
  GLFWContextRobustness* = 0x00022005
    ## @brief Context robustness hint and attribute.
    ##
    ## Context client API revision number hint
    ## and attribute.
const
  GLFWOpenglForwardCompat* = 0x00022006
    ## @brief OpenGL forward-compatibility hint and attribute.
    ##
    ## OpenGL forward-compatibility hint
    ## and attribute.
const
  GLFWContextDebug* = 0x00022007
    ## @brief Debug mode context hint and attribute.
    ##
    ## Debug mode context hint and
    ## attribute.
const
  GLFWOpenglDebugContext* = GLFW_CONTEXT_DEBUG
    ## @brief Legacy name for compatibility.
    ##
    ## This is an alias for compatibility with earlier versions.
const
  GLFWOpenglProfile* = 0x00022008
    ## @brief OpenGL profile hint and attribute.
    ##
    ## OpenGL profile hint and
    ## attribute.
const
  GLFWContextReleaseBehavior* = 0x00022009
    ## @brief Context flush-on-release hint and attribute.
    ##
    ## Context flush-on-release hint and
    ## attribute.
const
  GLFWContextNoError* = 0x0002200A
    ## @brief Context error suppression hint and attribute.
    ##
    ## Context error suppression hint and
    ## attribute.
const
  GLFWContextCreationApi* = 0x0002200B
    ## @brief Context creation API hint and attribute.
    ##
    ## Context creation API hint and
    ## attribute.
const
  GLFWScaleToMonitor* = 0x0002200C
    ## @brief Window content area scaling window
    ## window hint.
const
  GLFWCocoaRetinaFramebuffer* = 0x00023001
    ## @brief macOS specific
    ## window hint.
const
  GLFWCocoaFrameName* = 0x00023002
    ## @brief macOS specific
    ## window hint.
const
  GLFWCocoaGraphicsSwitching* = 0x00023003
    ## @brief macOS specific
    ## window hint.
const
  GLFWX11ClassName* = 0x00024001
    ## @brief X11 specific
    ## window hint.
const
  GLFWX11InstanceName* = 0x00024002
    ## @brief X11 specific
    ## window hint.
const
  GLFWWin32KeyboardMenu* = 0x00025001
    ## @brief X11 specific
    ## window hint.
const
  GLFWNoApi* = 0
const
  GLFWOpenglApi* = 0x00030001
const
  GLFWOpenglEsApi* = 0x00030002
const
  GLFWNoRobustness* = 0
const
  GLFWNoResetNotification* = 0x00031001
const
  GLFWLoseContextOnReset* = 0x00031002
const
  GLFWOpenglAnyProfile* = 0
const
  GLFWOpenglCoreProfile* = 0x00032001
const
  GLFWOpenglCompatProfile* = 0x00032002
const
  GLFWCursorSpecial* = 0x00033001 ## Originally GLFW_CURSOR but conflicts with GLFWCursor type
const
  GLFWStickyKeys* = 0x00033002
const
  GLFWStickyMouseButtons* = 0x00033003
const
  GLFWLockKeyMods* = 0x00033004
const
  GLFWRawMouseMotion* = 0x00033005
const
  GLFWCursorNormal* = 0x00034001
const
  GLFWCursorHidden* = 0x00034002
const
  GLFWCursorDisabled* = 0x00034003
const
  GLFWAnyReleaseBehavior* = 0
const
  GLFWReleaseBehaviorFlush* = 0x00035001
const
  GLFWReleaseBehaviorNone* = 0x00035002
const
  GLFWNativeContextApi* = 0x00036001
const
  GLFWEglContextApi* = 0x00036002
const
  GLFWOsmesaContextApi* = 0x00036003
const
  GLFWAnglePlatformTypeNone* = 0x00037001
const
  GLFWAnglePlatformTypeOpengl* = 0x00037002
const
  GLFWAnglePlatformTypeOpengles* = 0x00037003
const
  GLFWAnglePlatformTypeD3d9* = 0x00037004
const
  GLFWAnglePlatformTypeD3d11* = 0x00037005
const
  GLFWAnglePlatformTypeVulkan* = 0x00037007
const
  GLFWAnglePlatformTypeMetal* = 0x00037008
const
  GLFWArrowCursor* = 0x00036001
    ## @brief The regular arrow cursor shape.
    ##
    ## The regular arrow cursor shape.
const
  GLFWIbeamCursor* = 0x00036002
    ## @brief The text input I-beam cursor shape.
    ##
    ## The text input I-beam cursor shape.
const
  GLFWCrosshairCursor* = 0x00036003
    ## @brief The crosshair cursor shape.
    ##
    ## The crosshair cursor shape.
const
  GLFWPointingHandCursor* = 0x00036004
    ## @brief The pointing hand cursor shape.
    ##
    ## The pointing hand cursor shape.
const
  GLFWResizeEwCursor* = 0x00036005
    ## @brief The horizontal resize/move arrow shape.
    ##
    ## The horizontal resize/move arrow shape.  This is usually a horizontal
    ## double-headed arrow.
const
  GLFWResizeNsCursor* = 0x00036006
    ## @brief The vertical resize/move arrow shape.
    ##
    ## The vertical resize/move shape.  This is usually a vertical double-headed
    ## arrow.
const
  GLFWResizeNwseCursor* = 0x00036007
    ## @brief The top-left to bottom-right diagonal resize/move arrow shape.
    ##
    ## The top-left to bottom-right diagonal resize/move shape.  This is usually
    ## a diagonal double-headed arrow.
    ##
    ## @note @macos This shape is provided by a private system API and may fail
    ## with  GLFW_CURSOR_UNAVAILABLE in the future.
    ##
    ## @note @x11 This shape is provided by a newer standard not supported by all
    ## cursor themes.
    ##
    ## @note @wayland This shape is provided by a newer standard not supported by
    ## all cursor themes.
const
  GLFWResizeNeswCursor* = 0x00036008
    ## @brief The top-right to bottom-left diagonal resize/move arrow shape.
    ##
    ## The top-right to bottom-left diagonal resize/move shape.  This is usually
    ## a diagonal double-headed arrow.
    ##
    ## @note @macos This shape is provided by a private system API and may fail
    ## with  GLFW_CURSOR_UNAVAILABLE in the future.
    ##
    ## @note @x11 This shape is provided by a newer standard not supported by all
    ## cursor themes.
    ##
    ## @note @wayland This shape is provided by a newer standard not supported by
    ## all cursor themes.
const
  GLFWResizeAllCursor* = 0x00036009
    ## @brief The omni-directional resize/move cursor shape.
    ##
    ## The omni-directional resize cursor/move shape.  This is usually either
    ## a combined horizontal and vertical double-headed arrow or a grabbing hand.
const
  GLFWNotAllowedCursor* = 0x0003600A
    ## @brief The operation-not-allowed shape.
    ##
    ## The operation-not-allowed shape.  This is usually a circle with a diagonal
    ## line through it.
    ##
    ## @note @x11 This shape is provided by a newer standard not supported by all
    ## cursor themes.
    ##
    ## @note @wayland This shape is provided by a newer standard not supported by
    ## all cursor themes.
const
  GLFWHresizeCursor* = GLFW_RESIZE_EW_CURSOR
    ## @brief Legacy name for compatibility.
    ##
    ## This is an alias for compatibility with earlier versions.
const
  GLFWVresizeCursor* = GLFW_RESIZE_NS_CURSOR
    ## @brief Legacy name for compatibility.
    ##
    ## This is an alias for compatibility with earlier versions.
const
  GLFWHandCursor* = GLFW_POINTING_HAND_CURSOR
    ## @brief Legacy name for compatibility.
    ##
    ## This is an alias for compatibility with earlier versions.
const
  GLFWConnected* = 0x00040001
const
  GLFWDisconnected* = 0x00040002
const
  GLFWJoystickHatButtons* = 0x00050001
    ## @brief Joystick hat buttons init hint.
    ##
    ## Joystick hat buttons init hint.
const
  GLFWAnglePlatformType* = 0x00050002
    ## @brief ANGLE rendering backend init hint.
    ##
    ## ANGLE rendering backend init hint.
const
  GLFWCocoaChdirResources* = 0x00051001
    ## @brief macOS specific init hint.
    ##
    ## macOS specific init hint.
const
  GLFWCocoaMenubar* = 0x00051002
    ## @brief macOS specific init hint.
    ##
    ## macOS specific init hint.
const
  GLFWX11XcbVulkanSurface* = 0x00052001
    ## @brief X11 specific init hint.
    ##
    ## X11 specific init hint.
const
  GLFWDontCare* = -1

# Type Definitions
type
  GLFWMonitor* = ptr object
    ## Opaque GLFWmonitor object
  GLFWWindow* = ptr object
    ## Opaque GLFWwindow object
  GLFWCursor* = ptr object
    ## Opaque GLFWcursor object
  GLFWVidMode* = object
    ## This describes a single video mode.
    width*: int32
    height*: int32
    redBits*: int32
    greenBits*: int32
    blueBits*: int32
    refreshRate*: int32
  GLFWGammaRamp* = object
    ## This describes the gamma ramp for a monitor.
    red*: uint16
    green*: uint16
    blue*: uint16
    size*: uint32
  GLFWImage* = object
    ## This describes a single 2D image.
    width*: int32
    height*: int32
    pixels*: ptr cuchar
  GLFWGamepadState* = object
    ## This describes the input state of a gamepad.
    buttons*: array[15, bool]
    axes*: array[6, float32]

type
  GLFWGlProc* = pointer
    ## @brief Client API function pointer type.
    ##
    ## Generic function pointer used for returning client API function pointers
    ## without forcing a cast from a regular pointer.
    ##
    ## @sa  context_glext
    ## @sa  glfwGetProcAddress
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup context
  GLFWVkProc* = pointer
    ## @brief Vulkan API function pointer type.
    ##
    ## Generic function pointer used for returning Vulkan API function pointers
    ## without forcing a cast from a regular pointer.
    ##
    ## @sa  vulkan_proc
    ## @sa  glfwGetInstanceProcAddress
    ##
    ## @since Added in version 3.2.
    ##
    ## @ingroup vulkan
  GLFWErrorFun* = proc(error_code: int32, description: cstring): void {.cdecl.}
    ## @brief The function pointer type for error callbacks.
    ##
    ## This is the function pointer type for error callbacks.  An error callback
    ## function has the following signature:
    ## @code
    ## void callback_name(int error_code, const char* description)
    ## @endcode
    ##
    ## @paramin error_code An error code.  Future releases may add
    ## more error codes.
    ## @param[in] description A UTF-8 encoded string describing the error.
    ##
    ## @pointer_lifetime The error description string is valid until the callback
    ## function returns.
    ##
    ## @sa  error_handling
    ## @sa  glfwSetErrorCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup init
  GLFWWindowposFun* = proc(window: GLFWWindow, xpos: int32, ypos: int32): void {.cdecl.}
    ## @brief The function pointer type for window position callbacks.
    ##
    ## This is the function pointer type for window position callbacks.  A window
    ## position callback function has the following signature:
    ## @code
    ## void callback_name(GLFWwindow* window, int xpos, int ypos)
    ## @endcode
    ##
    ## @param[in] window The window that was moved.
    ## @param[in] xpos The new x-coordinate, in screen coordinates, of the
    ## upper-left corner of the content area of the window.
    ## @param[in] ypos The new y-coordinate, in screen coordinates, of the
    ## upper-left corner of the content area of the window.
    ##
    ## @sa  window_pos
    ## @sa  glfwSetWindowPosCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup window
  GLFWWindowsizeFun* = proc(window: GLFWWindow, width: int32, height: int32): void {.cdecl.}
    ## @brief The function pointer type for window size callbacks.
    ##
    ## This is the function pointer type for window size callbacks.  A window size
    ## callback function has the following signature:
    ## @code
    ## void callback_name(GLFWwindow* window, int width, int height)
    ## @endcode
    ##
    ## @param[in] window The window that was resized.
    ## @param[in] width The new width, in screen coordinates, of the window.
    ## @param[in] height The new height, in screen coordinates, of the window.
    ##
    ## @sa  window_size
    ## @sa  glfwSetWindowSizeCallback
    ##
    ## @since Added in version 1.0.
    ## @glfw3 Added window handle parameter.
    ##
    ## @ingroup window
  GLFWWindowcloseFun* = proc(window: GLFWWindow): void {.cdecl.}
    ## @brief The function pointer type for window close callbacks.
    ##
    ## This is the function pointer type for window close callbacks.  A window
    ## close callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window)
    ## @endcode
    ##
    ## @param[in] window The window that the user attempted to close.
    ##
    ## @sa  window_close
    ## @sa  glfwSetWindowCloseCallback
    ##
    ## @since Added in version 2.5.
    ## @glfw3 Added window handle parameter.
    ##
    ## @ingroup window
  GLFWWindowrefreshFun* = proc(window: GLFWWindow): void {.cdecl.}
    ## @brief The function pointer type for window content refresh callbacks.
    ##
    ## This is the function pointer type for window content refresh callbacks.
    ## A window content refresh callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window);
    ## @endcode
    ##
    ## @param[in] window The window whose content needs to be refreshed.
    ##
    ## @sa  window_refresh
    ## @sa  glfwSetWindowRefreshCallback
    ##
    ## @since Added in version 2.5.
    ## @glfw3 Added window handle parameter.
    ##
    ## @ingroup window
  GLFWWindowfocusFun* = proc(window: GLFWWindow, focused: bool): void {.cdecl.}
    ## @brief The function pointer type for window focus callbacks.
    ##
    ## This is the function pointer type for window focus callbacks.  A window
    ## focus callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, int focused)
    ## @endcode
    ##
    ## @param[in] window The window that gained or lost input focus.
    ## @param[in] focused `GLFW_TRUE` if the window was given input focus, or
    ## `GLFW_FALSE` if it lost it.
    ##
    ## @sa  window_focus
    ## @sa  glfwSetWindowFocusCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup window
  GLFWWindowiconifyFun* = proc(window: GLFWWindow, iconified: bool): void {.cdecl.}
    ## @brief The function pointer type for window iconify callbacks.
    ##
    ## This is the function pointer type for window iconify callbacks.  A window
    ## iconify callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, int iconified)
    ## @endcode
    ##
    ## @param[in] window The window that was iconified or restored.
    ## @param[in] iconified `GLFW_TRUE` if the window was iconified, or
    ## `GLFW_FALSE` if it was restored.
    ##
    ## @sa  window_iconify
    ## @sa  glfwSetWindowIconifyCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup window
  GLFWWindowmaximizeFun* = proc(window: GLFWWindow, maximized: int32): void {.cdecl.}
    ## @brief The function pointer type for window maximize callbacks.
    ##
    ## This is the function pointer type for window maximize callbacks.  A window
    ## maximize callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, int maximized)
    ## @endcode
    ##
    ## @param[in] window The window that was maximized or restored.
    ## @param[in] maximized `GLFW_TRUE` if the window was maximized, or
    ## `GLFW_FALSE` if it was restored.
    ##
    ## @sa  window_maximize
    ## @sa glfwSetWindowMaximizeCallback
    ##
    ## @since Added in version 3.3.
    ##
    ## @ingroup window
  GLFWFramebuffersizeFun* = proc(window: GLFWWindow, width: int32, height: int32): void {.cdecl.}
    ## @brief The function pointer type for framebuffer size callbacks.
    ##
    ## This is the function pointer type for framebuffer size callbacks.
    ## A framebuffer size callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, int width, int height)
    ## @endcode
    ##
    ## @param[in] window The window whose framebuffer was resized.
    ## @param[in] width The new width, in pixels, of the framebuffer.
    ## @param[in] height The new height, in pixels, of the framebuffer.
    ##
    ## @sa  window_fbsize
    ## @sa  glfwSetFramebufferSizeCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup window
  GLFWWindowcontentscaleFun* = proc(window: GLFWWindow, xscale: float32, yscale: float32): void {.cdecl.}
    ## @brief The function pointer type for window content scale callbacks.
    ##
    ## This is the function pointer type for window content scale callbacks.
    ## A window content scale callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, float xscale, float yscale)
    ## @endcode
    ##
    ## @param[in] window The window whose content scale changed.
    ## @param[in] xscale The new x-axis content scale of the window.
    ## @param[in] yscale The new y-axis content scale of the window.
    ##
    ## @sa  window_scale
    ## @sa  glfwSetWindowContentScaleCallback
    ##
    ## @since Added in version 3.3.
    ##
    ## @ingroup window
  GLFWMousebuttonFun* = proc(window: GLFWWindow, button: int32, action: int32, mods: int32): void {.cdecl.}
    ## @brief The function pointer type for mouse button callbacks.
    ##
    ## This is the function pointer type for mouse button callback functions.
    ## A mouse button callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, int button, int action, int mods)
    ## @endcode
    ##
    ## @param[in] window The window that received the event.
    ## @paramin button The mouse button that was pressed or
    ## released.
    ## @param[in] action One of `GLFW_PRESS` or `GLFW_RELEASE`.  Future releases
    ## may add more actions.
    ## @paramin mods Bit field describing which modifier keys were
    ## held down.
    ##
    ## @sa  input_mouse_button
    ## @sa  glfwSetMouseButtonCallback
    ##
    ## @since Added in version 1.0.
    ## @glfw3 Added window handle and modifier mask parameters.
    ##
    ## @ingroup input
  GLFWCursorposFun* = proc(window: GLFWWindow, xpos: float64, ypos: float64): void {.cdecl.}
    ## @brief The function pointer type for cursor position callbacks.
    ##
    ## This is the function pointer type for cursor position callbacks.  A cursor
    ## position callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, double xpos, double ypos);
    ## @endcode
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] xpos The new cursor x-coordinate, relative to the left edge of
    ## the content area.
    ## @param[in] ypos The new cursor y-coordinate, relative to the top edge of the
    ## content area.
    ##
    ## @sa  cursor_pos
    ## @sa  glfwSetCursorPosCallback
    ##
    ## @since Added in version 3.0.  Replaces `GLFWmouseposfun`.
    ##
    ## @ingroup input
  GLFWCursorenterFun* = proc(window: GLFWWindow, entered: bool): void {.cdecl.}
    ## @brief The function pointer type for cursor enter/leave callbacks.
    ##
    ## This is the function pointer type for cursor enter/leave callbacks.
    ## A cursor enter/leave callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, int entered)
    ## @endcode
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] entered `GLFW_TRUE` if the cursor entered the window's content
    ## area, or `GLFW_FALSE` if it left it.
    ##
    ## @sa  cursor_enter
    ## @sa  glfwSetCursorEnterCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup input
  GLFWScrollFun* = proc(window: GLFWWindow, xoffset: float64, yoffset: float64): void {.cdecl.}
    ## @brief The function pointer type for scroll callbacks.
    ##
    ## This is the function pointer type for scroll callbacks.  A scroll callback
    ## function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, double xoffset, double yoffset)
    ## @endcode
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] xoffset The scroll offset along the x-axis.
    ## @param[in] yoffset The scroll offset along the y-axis.
    ##
    ## @sa  scrolling
    ## @sa  glfwSetScrollCallback
    ##
    ## @since Added in version 3.0.  Replaces `GLFWmousewheelfun`.
    ##
    ## @ingroup input
  GLFWKeyFun* = proc(window: GLFWWindow, key: int32, scancode: int32, action: int32, mods: int32): void {.cdecl.}
    ## @brief The function pointer type for keyboard key callbacks.
    ##
    ## This is the function pointer type for keyboard key callbacks.  A keyboard
    ## key callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, int key, int scancode, int action, int mods)
    ## @endcode
    ##
    ## @param[in] window The window that received the event.
    ## @paramin key The keyboard key that was pressed or released.
    ## @param[in] scancode The system-specific scancode of the key.
    ## @param[in] action `GLFW_PRESS`, `GLFW_RELEASE` or `GLFW_REPEAT`.  Future
    ## releases may add more actions.
    ## @paramin mods Bit field describing which modifier keys were
    ## held down.
    ##
    ## @sa  input_key
    ## @sa  glfwSetKeyCallback
    ##
    ## @since Added in version 1.0.
    ## @glfw3 Added window handle, scancode and modifier mask parameters.
    ##
    ## @ingroup input
  GLFWCharFun* = proc(window: GLFWWindow, codepoint: uint32): void {.cdecl.}
    ## @brief The function pointer type for Unicode character callbacks.
    ##
    ## This is the function pointer type for Unicode character callbacks.
    ## A Unicode character callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, unsigned int codepoint)
    ## @endcode
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] codepoint The Unicode code point of the character.
    ##
    ## @sa  input_char
    ## @sa  glfwSetCharCallback
    ##
    ## @since Added in version 2.4.
    ## @glfw3 Added window handle parameter.
    ##
    ## @ingroup input
  GLFWCharmodsFun* = proc(window: GLFWWindow, codepoint: uint32, mods: int32): void {.cdecl.}
    ## @brief The function pointer type for Unicode character with modifiers
    ## callbacks.
    ##
    ## This is the function pointer type for Unicode character with modifiers
    ## callbacks.  It is called for each input character, regardless of what
    ## modifier keys are held down.  A Unicode character with modifiers callback
    ## function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, unsigned int codepoint, int mods)
    ## @endcode
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] codepoint The Unicode code point of the character.
    ## @paramin mods Bit field describing which modifier keys were
    ## held down.
    ##
    ## @sa  input_char
    ## @sa  glfwSetCharModsCallback
    ##
    ## @deprecated Scheduled for removal in version 4.0.
    ##
    ## @since Added in version 3.1.
    ##
    ## @ingroup input
  GLFWDropFun* = proc(window: GLFWWindow, path_count: int32, paths: cstringArray): void {.cdecl.}
    ## @brief The function pointer type for path drop callbacks.
    ##
    ## This is the function pointer type for path drop callbacks.  A path drop
    ## callback function has the following signature:
    ## @code
    ## void function_name(GLFWwindow* window, int path_count, const char* paths[])
    ## @endcode
    ##
    ## @param[in] window The window that received the event.
    ## @param[in] path_count The number of dropped paths.
    ## @param[in] paths The UTF-8 encoded file and/or directory path names.
    ##
    ## @pointer_lifetime The path array and its strings are valid until the
    ## callback function returns.
    ##
    ## @sa  path_drop
    ## @sa  glfwSetDropCallback
    ##
    ## @since Added in version 3.1.
    ##
    ## @ingroup input
  GLFWMonitorFun* = proc(monitor: GLFWMonitor, event: int32): void {.cdecl.}
    ## @brief The function pointer type for monitor configuration callbacks.
    ##
    ## This is the function pointer type for monitor configuration callbacks.
    ## A monitor callback function has the following signature:
    ## @code
    ## void function_name(GLFWmonitor* monitor, int event)
    ## @endcode
    ##
    ## @param[in] monitor The monitor that was connected or disconnected.
    ## @param[in] event One of `GLFW_CONNECTED` or `GLFW_DISCONNECTED`.  Future
    ## releases may add more events.
    ##
    ## @sa  monitor_event
    ## @sa  glfwSetMonitorCallback
    ##
    ## @since Added in version 3.0.
    ##
    ## @ingroup monitor
  GLFWJoystickFun* = proc(jid: int32, event: int32): void {.cdecl.}
    ## @brief The function pointer type for joystick configuration callbacks.
    ##
    ## This is the function pointer type for joystick configuration callbacks.
    ## A joystick configuration callback function has the following signature:
    ## @code
    ## void function_name(int jid, int event)
    ## @endcode
    ##
    ## @param[in] jid The joystick that was connected or disconnected.
    ## @param[in] event One of `GLFW_CONNECTED` or `GLFW_DISCONNECTED`.  Future
    ## releases may add more events.
    ##
    ## @sa  joystick_event
    ## @sa  glfwSetJoystickCallback
    ##
    ## @since Added in version 3.2.
    ##
    ## @ingroup input

converter toGLFWKey*(x: int32): GLFWKey = GLFWKey(x)
converter toint32*(x: GLFWKey): int32 = x.int32
converter toGLFWHat*(x: int32): GLFWHat = GLFWHat(x)
converter toint32*(x: GLFWHat): int32 = x.int32
converter toGLFWMouseButton*(x: int32): GLFWMouseButton = GLFWMouseButton(x)
converter toint32*(x: GLFWMouseButton): int32 = x.int32
converter toGLFWJoystick*(x: int32): GLFWJoystick = GLFWJoystick(x)
converter toint32*(x: GLFWJoystick): int32 = x.int32
converter toGLFWGamepadButton*(x: int32): GLFWGamepadButton = GLFWGamepadButton(x)
converter toint32*(x: GLFWGamepadButton): int32 = x.int32
converter toGLFWGamepadAxis*(x: int32): GLFWGamepadAxis = GLFWGamepadAxis(x)
converter toint32*(x: GLFWGamepadAxis): int32 = x.int32

# Procs
when defined(glfwDLL):
  {.push dynlib: glfw_dll, cdecl.}
else:
  {.push cdecl.}

proc glfwInit*(): bool {.importc: "glfwInit".}
  ## @brief Initializes the GLFW library.
  ##
  ## This function initializes the GLFW library.  Before most GLFW functions can
  ## be used, GLFW must be initialized, and before an application terminates GLFW
  ## should be terminated in order to free any resources allocated during or
  ## after initialization.
  ##
  ## If this function fails, it calls  glfwTerminate before returning.  If it
  ## succeeds, you should call  glfwTerminate before the application exits.
  ##
  ## Additional calls to this function after successful initialization but before
  ## termination will return `GLFW_TRUE` immediately.
  ##
  ## @return `GLFW_TRUE` if successful, or `GLFW_FALSE` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_PLATFORM_ERROR.
  ##
  ## @remark @macos This function will change the current directory of the
  ## application to the `Contents/Resources` subdirectory of the application's
  ## bundle, if present.  This can be disabled with the
  ## GLFW_COCOA_CHDIR_RESOURCES init hint.
  ##
  ## @remark @macos This function will create the main menu and dock icon for the
  ## application.  If GLFW finds a `MainMenu.nib` it is loaded and assumed to
  ## contain a menu bar.  Otherwise a minimal menu bar is created manually with
  ## common commands like Hide, Quit and About.  The About entry opens a minimal
  ## about dialog with information from the application's bundle.  The menu bar
  ## and dock icon can be disabled entirely with the  GLFW_COCOA_MENUBAR init
  ## hint.
  ##
  ## @remark @x11 This function will set the `LC_CTYPE` category of the
  ## application locale according to the current environment if that category is
  ## still "C".  This is because the "C" locale breaks Unicode text input.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  intro_init
  ## @sa  glfwTerminate
  ##
  ## @since Added in version 1.0.
  ##
  ## @ingroup init
proc glfwTerminate*(): void {.importc: "glfwTerminate".}
  ## @brief Terminates the GLFW library.
  ##
  ## This function destroys all remaining windows and cursors, restores any
  ## modified gamma ramps and frees any other allocated resources.  Once this
  ## function is called, you must again call  glfwInit successfully before
  ## you will be able to use most GLFW functions.
  ##
  ## If GLFW has been successfully initialized, this function should be called
  ## before the application exits.  If initialization fails, there is no need to
  ## call this function, as it is called by  glfwInit before it returns
  ## failure.
  ##
  ## This function has no effect if GLFW is not initialized.
  ##
  ## @errors Possible errors include  GLFW_PLATFORM_ERROR.
  ##
  ## @remark This function may be called before  glfwInit.
  ##
  ## @warning The contexts of any remaining windows must not be current on any
  ## other thread when this function is called.
  ##
  ## @reentrancy This function must not be called from a callback.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  intro_init
  ## @sa  glfwInit
  ##
  ## @since Added in version 1.0.
  ##
  ## @ingroup init
proc glfwInitHint*(hint: int32, value: int32): void {.importc: "glfwInitHint".}
  ## @brief Sets the specified init hint to the desired value.
  ##
  ## This function sets hints for the next initialization of GLFW.
  ##
  ## The values you set hints to are never reset by GLFW, but they only take
  ## effect during initialization.  Once GLFW has been initialized, any values
  ## you set will be ignored until the library is terminated and initialized
  ## again.
  ##
  ## Some hints are platform specific.  These may be set on any platform but they
  ## will only affect their specific platform.  Other platforms will ignore them.
  ## Setting these hints requires no platform specific headers or functions.
  ##
  ## @paramin hint The init hint to set.
  ## @param[in] value The new value of the init hint.
  ##
  ## @errors Possible errors include  GLFW_INVALID_ENUM and
  ## GLFW_INVALID_VALUE.
  ##
  ## @remarks This function may be called before  glfwInit.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa init_hints
  ## @sa glfwInit
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup init
proc glfwGetVersion*(major: ptr int32, minor: ptr int32, rev: ptr int32): void {.importc: "glfwGetVersion".}
  ## @brief Retrieves the version of the GLFW library.
  ##
  ## This function retrieves the major, minor and revision numbers of the GLFW
  ## library.  It is intended for when you are using GLFW as a shared library and
  ## want to ensure that you are using the minimum required version.
  ##
  ## Any or all of the version arguments may be `NULL`.
  ##
  ## @param[out] major Where to store the major version number, or `NULL`.
  ## @param[out] minor Where to store the minor version number, or `NULL`.
  ## @param[out] rev Where to store the revision number, or `NULL`.
  ##
  ## @errors None.
  ##
  ## @remark This function may be called before  glfwInit.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  intro_version
  ## @sa  glfwGetVersionString
  ##
  ## @since Added in version 1.0.
  ##
  ## @ingroup init
proc glfwGetVersionString*(): cstring {.importc: "glfwGetVersionString".}
  ## @brief Returns a string describing the compile-time configuration.
  ##
  ## This function returns the compile-time generated
  ## version string of the GLFW library binary.  It
  ## describes the version, platform, compiler and any platform-specific
  ## compile-time options.  It should not be confused with the OpenGL or OpenGL
  ## ES version string, queried with `glGetString`.
  ##
  ## __Do not use the version string__ to parse the GLFW library version.  The
  ##  glfwGetVersion function provides the version of the running library
  ## binary in numerical format.
  ##
  ## @return The ASCII encoded GLFW version string.
  ##
  ## @errors None.
  ##
  ## @remark This function may be called before  glfwInit.
  ##
  ## @pointer_lifetime The returned string is static and compile-time generated.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  intro_version
  ## @sa  glfwGetVersion
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup init
proc glfwGetError*(description: cstringArray): int32 {.importc: "glfwGetError".}
  ## @brief Returns and clears the last error for the calling thread.
  ##
  ## This function returns and clears the error code of the last
  ## error that occurred on the calling thread, and optionally a UTF-8 encoded
  ## human-readable description of it.  If no error has occurred since the last
  ## call, it returns @ref GLFW_NO_ERROR  and the description pointer is
  ## set to `NULL`.
  ##
  ## @param[in] description Where to store the error description pointer, or `NULL`.
  ## @return The last error code for the calling thread, or  GLFW_NO_ERROR
  ## (zero).
  ##
  ## @errors None.
  ##
  ## @pointer_lifetime The returned string is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is guaranteed to be valid only until the
  ## next error occurs or the library is terminated.
  ##
  ## @remark This function may be called before  glfwInit.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  error_handling
  ## @sa  glfwSetErrorCallback
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup init
proc glfwSetErrorCallback*(callback: GLFWErrorfun): GLFWErrorfun {.importc: "glfwSetErrorCallback".}
  ## @brief Sets the error callback.
  ##
  ## This function sets the error callback, which is called with an error code
  ## and a human-readable description each time a GLFW error occurs.
  ##
  ## The error code is set before the callback is called.  Calling
  ## glfwGetError from the error callback will return the same value as the error
  ## code argument.
  ##
  ## The error callback is called on the thread where the error occurred.  If you
  ## are using GLFW from multiple threads, your error callback needs to be
  ## written accordingly.
  ##
  ## Because the description string may have been generated specifically for that
  ## error, it is not guaranteed to be valid after the callback has returned.  If
  ## you wish to use it after the callback returns, you need to make a copy.
  ##
  ## Once set, the error callback remains set even after the library has been
  ## terminated.
  ##
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set.
  ##
  ## @callback_signature
  ## @code
  ## void callback_name(int error_code, const char* description)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## callback pointer type.
  ##
  ## @errors None.
  ##
  ## @remark This function may be called before  glfwInit.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  error_handling
  ## @sa  glfwGetError
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup init
proc glfwGetMonitors*(count: ptr int32): ptr UncheckedArray[GLFWMonitor] {.importc: "glfwGetMonitors".}
  ## @brief Returns the currently connected monitors.
  ##
  ## This function returns an array of handles for all currently connected
  ## monitors.  The primary monitor is always first in the returned array.  If no
  ## monitors were found, this function returns `NULL`.
  ##
  ## @param[out] count Where to store the number of monitors in the returned
  ## array.  This is set to zero if an error occurred.
  ## @return An array of monitor handles, or `NULL` if no monitors were found or
  ## if an error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @pointer_lifetime The returned array is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is guaranteed to be valid only until the
  ## monitor configuration changes or the library is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_monitors
  ## @sa  monitor_event
  ## @sa  glfwGetPrimaryMonitor
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup monitor
proc glfwGetPrimaryMonitor*(): GLFWMonitor {.importc: "glfwGetPrimaryMonitor".}
  ## @brief Returns the primary monitor.
  ##
  ## This function returns the primary monitor.  This is usually the monitor
  ## where elements like the task bar or global menu bar are located.
  ##
  ## @return The primary monitor, or `NULL` if no monitors were found or if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @remark The primary monitor is always first in the array returned by
  ## glfwGetMonitors.
  ##
  ## @sa  monitor_monitors
  ## @sa  glfwGetMonitors
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup monitor
proc getMonitorPos*(monitor: GLFWMonitor, xpos: ptr int32, ypos: ptr int32): void {.importc: "glfwGetMonitorPos".}
  ## @brief Returns the position of the monitor's viewport on the virtual screen.
  ##
  ## This function returns the position, in screen coordinates, of the upper-left
  ## corner of the specified monitor.
  ##
  ## Any or all of the position arguments may be `NULL`.  If an error occurs, all
  ## non-`NULL` position arguments will be set to zero.
  ##
  ## @param[in] monitor The monitor to query.
  ## @param[out] xpos Where to store the monitor x-coordinate, or `NULL`.
  ## @param[out] ypos Where to store the monitor y-coordinate, or `NULL`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_properties
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup monitor
proc getMonitorWorkarea*(monitor: GLFWMonitor, xpos: ptr int32, ypos: ptr int32, width: ptr int32, height: ptr int32): void {.importc: "glfwGetMonitorWorkarea".}
  ## @brief Retrieves the work area of the monitor.
  ##
  ## This function returns the position, in screen coordinates, of the upper-left
  ## corner of the work area of the specified monitor along with the work area
  ## size in screen coordinates. The work area is defined as the area of the
  ## monitor not occluded by the operating system task bar where present. If no
  ## task bar exists then the work area is the monitor resolution in screen
  ## coordinates.
  ##
  ## Any or all of the position and size arguments may be `NULL`.  If an error
  ## occurs, all non-`NULL` position and size arguments will be set to zero.
  ##
  ## @param[in] monitor The monitor to query.
  ## @param[out] xpos Where to store the monitor x-coordinate, or `NULL`.
  ## @param[out] ypos Where to store the monitor y-coordinate, or `NULL`.
  ## @param[out] width Where to store the monitor width, or `NULL`.
  ## @param[out] height Where to store the monitor height, or `NULL`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_workarea
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup monitor
proc getMonitorPhysicalSize*(monitor: GLFWMonitor, widthMM: ptr int32, heightMM: ptr int32): void {.importc: "glfwGetMonitorPhysicalSize".}
  ## @brief Returns the physical size of the monitor.
  ##
  ## This function returns the size, in millimetres, of the display area of the
  ## specified monitor.
  ##
  ## Some systems do not provide accurate monitor size information, either
  ## because the monitor
  ## [EDID](https://en.wikipedia.org/wiki/Extended_display_identification_data)
  ## data is incorrect or because the driver does not report it accurately.
  ##
  ## Any or all of the size arguments may be `NULL`.  If an error occurs, all
  ## non-`NULL` size arguments will be set to zero.
  ##
  ## @param[in] monitor The monitor to query.
  ## @param[out] widthMM Where to store the width, in millimetres, of the
  ## monitor's display area, or `NULL`.
  ## @param[out] heightMM Where to store the height, in millimetres, of the
  ## monitor's display area, or `NULL`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @remark @win32 calculates the returned physical size from the
  ## current resolution and system DPI instead of querying the monitor EDID data.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_properties
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup monitor
proc getMonitorContentScale*(monitor: GLFWMonitor, xscale: ptr float32, yscale: ptr float32): void {.importc: "glfwGetMonitorContentScale".}
  ## @brief Retrieves the content scale for the specified monitor.
  ##
  ## This function retrieves the content scale for the specified monitor.  The
  ## content scale is the ratio between the current DPI and the platform's
  ## default DPI.  This is especially important for text and any UI elements.  If
  ## the pixel dimensions of your UI scaled by this look appropriate on your
  ## machine then it should appear at a reasonable size on other machines
  ## regardless of their DPI and scaling settings.  This relies on the system DPI
  ## and scaling settings being somewhat correct.
  ##
  ## The content scale may depend on both the monitor resolution and pixel
  ## density and on user settings.  It may be very different from the raw DPI
  ## calculated from the physical size and current resolution.
  ##
  ## @param[in] monitor The monitor to query.
  ## @param[out] xscale Where to store the x-axis content scale, or `NULL`.
  ## @param[out] yscale Where to store the y-axis content scale, or `NULL`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_scale
  ## @sa  glfwGetWindowContentScale
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup monitor
proc getMonitorName*(monitor: GLFWMonitor): cstring {.importc: "glfwGetMonitorName".}
  ## @brief Returns the name of the specified monitor.
  ##
  ## This function returns a human-readable name, encoded as UTF-8, of the
  ## specified monitor.  The name typically reflects the make and model of the
  ## monitor and is not guaranteed to be unique among the connected monitors.
  ##
  ## @param[in] monitor The monitor to query.
  ## @return The UTF-8 encoded name of the monitor, or `NULL` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @pointer_lifetime The returned string is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is valid until the specified monitor is
  ## disconnected or the library is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_properties
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup monitor
proc setMonitorUserPointer*(monitor: GLFWMonitor, pointer: pointer): void {.importc: "glfwSetMonitorUserPointer".}
  ## @brief Sets the user pointer of the specified monitor.
  ##
  ## This function sets the user-defined pointer of the specified monitor.  The
  ## current value is retained until the monitor is disconnected.  The initial
  ## value is `NULL`.
  ##
  ## This function may be called from the monitor callback, even for a monitor
  ## that is being disconnected.
  ##
  ## @param[in] monitor The monitor whose pointer to set.
  ## @param[in] pointer The new value.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @sa  monitor_userptr
  ## @sa  glfwGetMonitorUserPointer
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup monitor
proc getMonitorUserPointer*(monitor: GLFWMonitor): pointer {.importc: "glfwGetMonitorUserPointer".}
  ## @brief Returns the user pointer of the specified monitor.
  ##
  ## This function returns the current value of the user-defined pointer of the
  ## specified monitor.  The initial value is `NULL`.
  ##
  ## This function may be called from the monitor callback, even for a monitor
  ## that is being disconnected.
  ##
  ## @param[in] monitor The monitor whose pointer to return.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @sa  monitor_userptr
  ## @sa  glfwSetMonitorUserPointer
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup monitor
proc glfwSetMonitorCallback*(callback: GLFWMonitorfun): GLFWMonitorfun {.importc: "glfwSetMonitorCallback".}
  ## @brief Sets the monitor configuration callback.
  ##
  ## This function sets the monitor configuration callback, or removes the
  ## currently set callback.  This is called when a monitor is connected to or
  ## disconnected from the system.
  ##
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWmonitor* monitor, int event)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_event
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup monitor
proc getVideoModes*(monitor: GLFWMonitor, count: ptr int32): ptr GLFWVidmode {.importc: "glfwGetVideoModes".}
  ## @brief Returns the available video modes for the specified monitor.
  ##
  ## This function returns an array of all video modes supported by the specified
  ## monitor.  The returned array is sorted in ascending order, first by color
  ## bit depth (the sum of all channel depths), then by resolution area (the
  ## product of width and height), then resolution width and finally by refresh
  ## rate.
  ##
  ## @param[in] monitor The monitor to query.
  ## @param[out] count Where to store the number of video modes in the returned
  ## array.  This is set to zero if an error occurred.
  ## @return An array of video modes, or `NULL` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The returned array is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is valid until the specified monitor is
  ## disconnected, this function is called again for that monitor or the library
  ## is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_modes
  ## @sa  glfwGetVideoMode
  ##
  ## @since Added in version 1.0.
  ## @glfw3 Changed to return an array of modes for a specific monitor.
  ##
  ## @ingroup monitor
proc getVideoMode*(monitor: GLFWMonitor): ptr GLFWVidmode {.importc: "glfwGetVideoMode".}
  ## @brief Returns the current mode of the specified monitor.
  ##
  ## This function returns the current video mode of the specified monitor.  If
  ## you have created a full screen window for that monitor, the return value
  ## will depend on whether that window is iconified.
  ##
  ## @param[in] monitor The monitor to query.
  ## @return The current mode of the monitor, or `NULL` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The returned array is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is valid until the specified monitor is
  ## disconnected or the library is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_modes
  ## @sa  glfwGetVideoModes
  ##
  ## @since Added in version 3.0.  Replaces `glfwGetDesktopMode`.
  ##
  ## @ingroup monitor
proc setGamma*(monitor: GLFWMonitor, gamma: float32): void {.importc: "glfwSetGamma".}
  ## @brief Generates a gamma ramp and sets it for the specified monitor.
  ##
  ## This function generates an appropriately sized gamma ramp from the specified
  ## exponent and then calls  glfwSetGammaRamp with it.  The value must be
  ## a finite number greater than zero.
  ##
  ## The software controlled gamma ramp is applied _in addition_ to the hardware
  ## gamma correction, which today is usually an approximation of sRGB gamma.
  ## This means that setting a perfectly linear ramp, or gamma 1.0, will produce
  ## the default (usually sRGB-like) behavior.
  ##
  ## For gamma correct rendering with OpenGL or OpenGL ES, see the
  ## GLFW_SRGB_CAPABLE hint.
  ##
  ## @param[in] monitor The monitor whose gamma ramp to set.
  ## @param[in] gamma The desired exponent.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_VALUE and  GLFW_PLATFORM_ERROR.
  ##
  ## @remark @wayland Gamma handling is a privileged protocol, this function
  ## will thus never be implemented and emits  GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_gamma
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup monitor
proc getGammaRamp*(monitor: GLFWMonitor): ptr GLFWGammaramp {.importc: "glfwGetGammaRamp".}
  ## @brief Returns the current gamma ramp for the specified monitor.
  ##
  ## This function returns the current gamma ramp of the specified monitor.
  ##
  ## @param[in] monitor The monitor to query.
  ## @return The current gamma ramp, or `NULL` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @remark @wayland Gamma handling is a privileged protocol, this function
  ## will thus never be implemented and emits  GLFW_PLATFORM_ERROR while
  ## returning `NULL`.
  ##
  ## @pointer_lifetime The returned structure and its arrays are allocated and
  ## freed by GLFW.  You should not free them yourself.  They are valid until the
  ## specified monitor is disconnected, this function is called again for that
  ## monitor or the library is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_gamma
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup monitor
proc setGammaRamp*(monitor: GLFWMonitor, ramp: ptr GLFWGammaramp): void {.importc: "glfwSetGammaRamp".}
  ## @brief Sets the current gamma ramp for the specified monitor.
  ##
  ## This function sets the current gamma ramp for the specified monitor.  The
  ## original gamma ramp for that monitor is saved by GLFW the first time this
  ## function is called and is restored by  glfwTerminate.
  ##
  ## The software controlled gamma ramp is applied _in addition_ to the hardware
  ## gamma correction, which today is usually an approximation of sRGB gamma.
  ## This means that setting a perfectly linear ramp, or gamma 1.0, will produce
  ## the default (usually sRGB-like) behavior.
  ##
  ## For gamma correct rendering with OpenGL or OpenGL ES, see the
  ## GLFW_SRGB_CAPABLE hint.
  ##
  ## @param[in] monitor The monitor whose gamma ramp to set.
  ## @param[in] ramp The gamma ramp to use.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @remark The size of the specified gamma ramp should match the size of the
  ## current ramp for that monitor.
  ##
  ## @remark @win32 The gamma ramp size must be 256.
  ##
  ## @remark @wayland Gamma handling is a privileged protocol, this function
  ## will thus never be implemented and emits  GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The specified gamma ramp is copied before this function
  ## returns.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  monitor_gamma
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup monitor
proc glfwDefaultWindowHints*(): void {.importc: "glfwDefaultWindowHints".}
  ## @brief Resets all window hints to their default values.
  ##
  ## This function resets all window hints to their
  ## default values.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_hints
  ## @sa  glfwWindowHint
  ## @sa  glfwWindowHintString
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc glfwWindowHint*(hint: int32, value: int32): void {.importc: "glfwWindowHint".}
  ## @brief Sets the specified window hint to the desired value.
  ##
  ## This function sets hints for the next call to  glfwCreateWindow.  The
  ## hints, once set, retain their values until changed by a call to this
  ## function or  glfwDefaultWindowHints, or until the library is terminated.
  ##
  ## Only integer value hints can be set with this function.  String value hints
  ## are set with  glfwWindowHintString.
  ##
  ## This function does not check whether the specified hint values are valid.
  ## If you set hints to invalid values this will instead be reported by the next
  ## call to  glfwCreateWindow.
  ##
  ## Some hints are platform specific.  These may be set on any platform but they
  ## will only affect their specific platform.  Other platforms will ignore them.
  ## Setting these hints requires no platform specific headers or functions.
  ##
  ## @paramin hint The window hint to set.
  ## @param[in] value The new value of the window hint.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_INVALID_ENUM.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_hints
  ## @sa  glfwWindowHintString
  ## @sa  glfwDefaultWindowHints
  ##
  ## @since Added in version 3.0.  Replaces `glfwOpenWindowHint`.
  ##
  ## @ingroup window
proc glfwWindowHintString*(hint: int32, value: cstring): void {.importc: "glfwWindowHintString".}
  ## @brief Sets the specified window hint to the desired value.
  ##
  ## This function sets hints for the next call to  glfwCreateWindow.  The
  ## hints, once set, retain their values until changed by a call to this
  ## function or  glfwDefaultWindowHints, or until the library is terminated.
  ##
  ## Only string type hints can be set with this function.  Integer value hints
  ## are set with  glfwWindowHint.
  ##
  ## This function does not check whether the specified hint values are valid.
  ## If you set hints to invalid values this will instead be reported by the next
  ## call to  glfwCreateWindow.
  ##
  ## Some hints are platform specific.  These may be set on any platform but they
  ## will only affect their specific platform.  Other platforms will ignore them.
  ## Setting these hints requires no platform specific headers or functions.
  ##
  ## @paramin hint The window hint to set.
  ## @param[in] value The new value of the window hint.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_INVALID_ENUM.
  ##
  ## @pointer_lifetime The specified string is copied before this function
  ## returns.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_hints
  ## @sa  glfwWindowHint
  ## @sa  glfwDefaultWindowHints
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup window
proc glfwCreateWindowC*(width: int32, height: int32, title: cstring, monitor: GLFWMonitor, share: GLFWWindow): GLFWWindow {.importc: "glfwCreateWindow".}
  ## @brief Creates a window and its associated context.
  ##
  ## This function creates a window and its associated OpenGL or OpenGL ES
  ## context.  Most of the options controlling how the window and its context
  ## should be created are specified with window hints.
  ##
  ## Successful creation does not change which context is current.  Before you
  ## can use the newly created context, you need to
  ## make it current.  For information about the `share`
  ## parameter, see  context_sharing.
  ##
  ## The created window, framebuffer and context may differ from what you
  ## requested, as not all parameters and hints are
  ## hard constraints.  This includes the size of the
  ## window, especially for full screen windows.  To query the actual attributes
  ## of the created window, framebuffer and context, see
  ## glfwGetWindowAttrib,  glfwGetWindowSize and  glfwGetFramebufferSize.
  ##
  ## To create a full screen window, you need to specify the monitor the window
  ## will cover.  If no monitor is specified, the window will be windowed mode.
  ## Unless you have a way for the user to choose a specific monitor, it is
  ## recommended that you pick the primary monitor.  For more information on how
  ## to query connected monitors, see  monitor_monitors.
  ##
  ## For full screen windows, the specified size becomes the resolution of the
  ## window's _desired video mode_.  As long as a full screen window is not
  ## iconified, the supported video mode most closely matching the desired video
  ## mode is set for the specified monitor.  For more information about full
  ## screen windows, including the creation of so called _windowed full screen_
  ## or _borderless full screen_ windows, see  window_windowed_full_screen.
  ##
  ## Once you have created the window, you can switch it between windowed and
  ## full screen mode with  glfwSetWindowMonitor.  This will not affect its
  ## OpenGL or OpenGL ES context.
  ##
  ## By default, newly created windows use the placement recommended by the
  ## window system.  To create the window at a specific position, make it
  ## initially invisible using the GLFW_VISIBLE window
  ## hint, set its position and then show(@ref window_hide
  ## it.
  ##
  ## As long as at least one full screen window is not iconified, the screensaver
  ## is prohibited from starting.
  ##
  ## Window systems put limits on window sizes.  Very large or very small window
  ## dimensions may be overridden by the window system on creation.  Check the
  ## actual size after creation.
  ##
  ## The swap interval is not set during window creation and
  ## the initial value may vary depending on driver settings and defaults.
  ##
  ## @param[in] width The desired width, in screen coordinates, of the window.
  ## This must be greater than zero.
  ## @param[in] height The desired height, in screen coordinates, of the window.
  ## This must be greater than zero.
  ## @param[in] title The initial, UTF-8 encoded window title.
  ## @param[in] monitor The monitor to use for full screen mode, or `NULL` for
  ## windowed mode.
  ## @param[in] share The window whose context to share resources with, or `NULL`
  ## to not share resources.
  ## @return The handle of the created window, or `NULL` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM,  GLFW_INVALID_VALUE,  GLFW_API_UNAVAILABLE,
  ## GLFW_VERSION_UNAVAILABLE,  GLFW_FORMAT_UNAVAILABLE and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @remark @win32 Window creation will fail if the Microsoft GDI software
  ## OpenGL implementation is the only one available.
  ##
  ## @remark @win32 If the executable has an icon resource named `GLFW_ICON,` it
  ## will be set as the initial icon for the window.  If no such icon is present,
  ## the `IDI_APPLICATION` icon will be used instead.  To set a different icon,
  ## see  glfwSetWindowIcon.
  ##
  ## @remark @win32 The context to share resources with must not be current on
  ## any other thread.
  ##
  ## @remark @macos The OS only supports core profile contexts for OpenGL
  ## versions 3.2 and later.  Before creating an OpenGL context of version 3.2 or
  ## later you must set the GLFW_OPENGL_PROFILE
  ## hint accordingly.  OpenGL 3.0 and 3.1 contexts are not supported at all
  ## on macOS.
  ##
  ## @remark @macos The GLFW window has no icon, as it is not a document
  ## window, but the dock icon will be the same as the application bundle's icon.
  ## For more information on bundles, see the
  ## [Bundle Programming Guide](https://developer.apple.com/library/mac/documentation/CoreFoundation/Conceptual/CFBundles/)
  ## in the Mac Developer Library.
  ##
  ## @remark @macos On OS X 10.10 and later the window frame will not be rendered
  ## at full resolution on Retina displays unless the
  ## GLFW_COCOA_RETINA_FRAMEBUFFER
  ## hint is `GLFW_TRUE` and the `NSHighResolutionCapable` key is enabled in the
  ## application bundle's `Info.plist`.  For more information, see
  ## [High Resolution Guidelines for OS X](https://developer.apple.com/library/mac/documentation/GraphicsAnimation/Conceptual/HighResolutionOSX/Explained/Explained.html)
  ## in the Mac Developer Library.  The GLFW test and example programs use
  ## a custom `Info.plist` template for this, which can be found as
  ## `CMake/Info.plist.in` in the source tree.
  ##
  ## @remark @macos When activating frame autosaving with
  ## GLFW_COCOA_FRAME_NAME, the specified
  ## window size and position may be overridden by previously saved values.
  ##
  ## @remark @x11 Some window managers will not respect the placement of
  ## initially hidden windows.
  ##
  ## @remark @x11 Due to the asynchronous nature of X11, it may take a moment for
  ## a window to reach its requested state.  This means you may not be able to
  ## query the final size, position or other attributes directly after window
  ## creation.
  ##
  ## @remark @x11 The class part of the `WM_CLASS` window property will by
  ## default be set to the window title passed to this function.  The instance
  ## part will use the contents of the `RESOURCE_NAME` environment variable, if
  ## present and not empty, or fall back to the window title.  Set the
  ## GLFW_X11_CLASS_NAME and
  ## GLFW_X11_INSTANCE_NAME window hints to
  ## override this.
  ##
  ## @remark @wayland Compositors should implement the xdg-decoration protocol
  ## for GLFW to decorate the window properly.  If this protocol isn't
  ## supported, or if the compositor prefers client-side decorations, a very
  ## simple fallback frame will be drawn using the wp_viewporter protocol.  A
  ## compositor can still emit close, maximize or fullscreen events, using for
  ## instance a keybind mechanism.  If neither of these protocols is supported,
  ## the window won't be decorated.
  ##
  ## @remark @wayland A full screen window will not attempt to change the mode,
  ## no matter what the requested size or refresh rate.
  ##
  ## @remark @wayland Screensaver inhibition requires the idle-inhibit protocol
  ## to be implemented in the user's compositor.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_creation
  ## @sa  glfwDestroyWindow
  ##
  ## @since Added in version 3.0.  Replaces `glfwOpenWindow`.
  ##
  ## @ingroup window
proc destroyWindow*(window: GLFWWindow): void {.importc: "glfwDestroyWindow".}
  ## @brief Destroys the specified window and its context.
  ##
  ## This function destroys the specified window and its context.  On calling
  ## this function, no further callbacks will be called for that window.
  ##
  ## If the context of the specified window is current on the main thread, it is
  ## detached before being destroyed.
  ##
  ## @param[in] window The window to destroy.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @note The context of the specified window must not be current on any other
  ## thread when this function is called.
  ##
  ## @reentrancy This function must not be called from a callback.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_creation
  ## @sa  glfwCreateWindow
  ##
  ## @since Added in version 3.0.  Replaces `glfwCloseWindow`.
  ##
  ## @ingroup window
proc windowShouldClose*(window: GLFWWindow): bool {.importc: "glfwWindowShouldClose".}
  ## @brief Checks the close flag of the specified window.
  ##
  ## This function returns the value of the close flag of the specified window.
  ##
  ## @param[in] window The window to query.
  ## @return The value of the close flag.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @sa  window_close
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc setWindowShouldClose*(window: GLFWWindow, value: bool): void {.importc: "glfwSetWindowShouldClose".}
  ## @brief Sets the close flag of the specified window.
  ##
  ## This function sets the value of the close flag of the specified window.
  ## This can be used to override the user's attempt to close the window, or
  ## to signal that it should be closed.
  ##
  ## @param[in] window The window whose flag to change.
  ## @param[in] value The new value.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @sa  window_close
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc setWindowTitle*(window: GLFWWindow, title: cstring): void {.importc: "glfwSetWindowTitle".}
  ## @brief Sets the title of the specified window.
  ##
  ## This function sets the window title, encoded as UTF-8, of the specified
  ## window.
  ##
  ## @param[in] window The window whose title to change.
  ## @param[in] title The UTF-8 encoded window title.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @remark @macos The window title will not be updated until the next time you
  ## process events.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_title
  ##
  ## @since Added in version 1.0.
  ## @glfw3 Added window handle parameter.
  ##
  ## @ingroup window
proc setWindowIcon*(window: GLFWWindow, count: int32, images: ptr GLFWImage): void {.importc: "glfwSetWindowIcon".}
  ## @brief Sets the icon for the specified window.
  ##
  ## This function sets the icon of the specified window.  If passed an array of
  ## candidate images, those of or closest to the sizes desired by the system are
  ## selected.  If no images are specified, the window reverts to its default
  ## icon.
  ##
  ## The pixels are 32-bit, little-endian, non-premultiplied RGBA, i.e. eight
  ## bits per channel with the red channel first.  They are arranged canonically
  ## as packed sequential rows, starting from the top-left corner.
  ##
  ## The desired image sizes varies depending on platform and system settings.
  ## The selected images will be rescaled as needed.  Good sizes include 16x16,
  ## 32x32 and 48x48.
  ##
  ## @param[in] window The window whose icon to set.
  ## @param[in] count The number of images in the specified array, or zero to
  ## revert to the default window icon.
  ## @param[in] images The images to create the icon from.  This is ignored if
  ## count is zero.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_PLATFORM_ERROR and @ref GLFW_FEATURE_UNAVAILABLE .
  ##
  ## @pointer_lifetime The specified image data is copied before this function
  ## returns.
  ##
  ## @remark @macos Regular windows do not have icons on macOS.  This function
  ## will emit  GLFW_FEATURE_UNAVAILABLE.  The dock icon will be the same as
  ## the application bundle's icon.  For more information on bundles, see the
  ## [Bundle Programming Guide](https://developer.apple.com/library/mac/documentation/CoreFoundation/Conceptual/CFBundles/)
  ## in the Mac Developer Library.
  ##
  ## @remark @wayland There is no existing protocol to change an icon, the
  ## window will thus inherit the one defined in the application's desktop file.
  ## This function will emit  GLFW_FEATURE_UNAVAILABLE.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_icon
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup window
proc getWindowPos*(window: GLFWWindow, xpos: ptr int32, ypos: ptr int32): void {.importc: "glfwGetWindowPos".}
  ## @brief Retrieves the position of the content area of the specified window.
  ##
  ## This function retrieves the position, in screen coordinates, of the
  ## upper-left corner of the content area of the specified window.
  ##
  ## Any or all of the position arguments may be `NULL`.  If an error occurs, all
  ## non-`NULL` position arguments will be set to zero.
  ##
  ## @param[in] window The window to query.
  ## @param[out] xpos Where to store the x-coordinate of the upper-left corner of
  ## the content area, or `NULL`.
  ## @param[out] ypos Where to store the y-coordinate of the upper-left corner of
  ## the content area, or `NULL`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_PLATFORM_ERROR and @ref GLFW_FEATURE_UNAVAILABLE .
  ##
  ## @remark @wayland There is no way for an application to retrieve the global
  ## position of its windows.  This function will emit
  ## GLFW_FEATURE_UNAVAILABLE.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_pos
  ## @sa  glfwSetWindowPos
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc setWindowPos*(window: GLFWWindow, xpos: int32, ypos: int32): void {.importc: "glfwSetWindowPos".}
  ## @brief Sets the position of the content area of the specified window.
  ##
  ## This function sets the position, in screen coordinates, of the upper-left
  ## corner of the content area of the specified windowed mode window.  If the
  ## window is a full screen window, this function does nothing.
  ##
  ## __Do not use this function__ to move an already visible window unless you
  ## have very good reasons for doing so, as it will confuse and annoy the user.
  ##
  ## The window manager may put limits on what positions are allowed.  GLFW
  ## cannot and should not override these limits.
  ##
  ## @param[in] window The window to query.
  ## @param[in] xpos The x-coordinate of the upper-left corner of the content area.
  ## @param[in] ypos The y-coordinate of the upper-left corner of the content area.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_PLATFORM_ERROR and @ref GLFW_FEATURE_UNAVAILABLE .
  ##
  ## @remark @wayland There is no way for an application to set the global
  ## position of its windows.  This function will emit
  ## GLFW_FEATURE_UNAVAILABLE.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_pos
  ## @sa  glfwGetWindowPos
  ##
  ## @since Added in version 1.0.
  ## @glfw3 Added window handle parameter.
  ##
  ## @ingroup window
proc getWindowSize*(window: GLFWWindow, width: ptr int32, height: ptr int32): void {.importc: "glfwGetWindowSize".}
  ## @brief Retrieves the size of the content area of the specified window.
  ##
  ## This function retrieves the size, in screen coordinates, of the content area
  ## of the specified window.  If you wish to retrieve the size of the
  ## framebuffer of the window in pixels, see  glfwGetFramebufferSize.
  ##
  ## Any or all of the size arguments may be `NULL`.  If an error occurs, all
  ## non-`NULL` size arguments will be set to zero.
  ##
  ## @param[in] window The window whose size to retrieve.
  ## @param[out] width Where to store the width, in screen coordinates, of the
  ## content area, or `NULL`.
  ## @param[out] height Where to store the height, in screen coordinates, of the
  ## content area, or `NULL`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_size
  ## @sa  glfwSetWindowSize
  ##
  ## @since Added in version 1.0.
  ## @glfw3 Added window handle parameter.
  ##
  ## @ingroup window
proc setWindowSizeLimits*(window: GLFWWindow, minwidth: int32, minheight: int32, maxwidth: int32, maxheight: int32): void {.importc: "glfwSetWindowSizeLimits".}
  ## @brief Sets the size limits of the specified window.
  ##
  ## This function sets the size limits of the content area of the specified
  ## window.  If the window is full screen, the size limits only take effect
  ## once it is made windowed.  If the window is not resizable, this function
  ## does nothing.
  ##
  ## The size limits are applied immediately to a windowed mode window and may
  ## cause it to be resized.
  ##
  ## The maximum dimensions must be greater than or equal to the minimum
  ## dimensions and all must be greater than or equal to zero.
  ##
  ## @param[in] window The window to set limits for.
  ## @param[in] minwidth The minimum width, in screen coordinates, of the content
  ## area, or `GLFW_DONT_CARE`.
  ## @param[in] minheight The minimum height, in screen coordinates, of the
  ## content area, or `GLFW_DONT_CARE`.
  ## @param[in] maxwidth The maximum width, in screen coordinates, of the content
  ## area, or `GLFW_DONT_CARE`.
  ## @param[in] maxheight The maximum height, in screen coordinates, of the
  ## content area, or `GLFW_DONT_CARE`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_VALUE and  GLFW_PLATFORM_ERROR.
  ##
  ## @remark If you set size limits and an aspect ratio that conflict, the
  ## results are undefined.
  ##
  ## @remark @wayland The size limits will not be applied until the window is
  ## actually resized, either by the user or by the compositor.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_sizelimits
  ## @sa  glfwSetWindowAspectRatio
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup window
proc setWindowAspectRatio*(window: GLFWWindow, numer: int32, denom: int32): void {.importc: "glfwSetWindowAspectRatio".}
  ## @brief Sets the aspect ratio of the specified window.
  ##
  ## This function sets the required aspect ratio of the content area of the
  ## specified window.  If the window is full screen, the aspect ratio only takes
  ## effect once it is made windowed.  If the window is not resizable, this
  ## function does nothing.
  ##
  ## The aspect ratio is specified as a numerator and a denominator and both
  ## values must be greater than zero.  For example, the common 16:9 aspect ratio
  ## is specified as 16 and 9, respectively.
  ##
  ## If the numerator and denominator is set to `GLFW_DONT_CARE` then the aspect
  ## ratio limit is disabled.
  ##
  ## The aspect ratio is applied immediately to a windowed mode window and may
  ## cause it to be resized.
  ##
  ## @param[in] window The window to set limits for.
  ## @param[in] numer The numerator of the desired aspect ratio, or
  ## `GLFW_DONT_CARE`.
  ## @param[in] denom The denominator of the desired aspect ratio, or
  ## `GLFW_DONT_CARE`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_VALUE and  GLFW_PLATFORM_ERROR.
  ##
  ## @remark If you set size limits and an aspect ratio that conflict, the
  ## results are undefined.
  ##
  ## @remark @wayland The aspect ratio will not be applied until the window is
  ## actually resized, either by the user or by the compositor.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_sizelimits
  ## @sa  glfwSetWindowSizeLimits
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup window
proc setWindowSize*(window: GLFWWindow, width: int32, height: int32): void {.importc: "glfwSetWindowSize".}
  ## @brief Sets the size of the content area of the specified window.
  ##
  ## This function sets the size, in screen coordinates, of the content area of
  ## the specified window.
  ##
  ## For full screen windows, this function updates the resolution of its desired
  ## video mode and switches to the video mode closest to it, without affecting
  ## the window's context.  As the context is unaffected, the bit depths of the
  ## framebuffer remain unchanged.
  ##
  ## If you wish to update the refresh rate of the desired video mode in addition
  ## to its resolution, see  glfwSetWindowMonitor.
  ##
  ## The window manager may put limits on what sizes are allowed.  GLFW cannot
  ## and should not override these limits.
  ##
  ## @param[in] window The window to resize.
  ## @param[in] width The desired width, in screen coordinates, of the window
  ## content area.
  ## @param[in] height The desired height, in screen coordinates, of the window
  ## content area.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @remark @wayland A full screen window will not attempt to change the mode,
  ## no matter what the requested size.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_size
  ## @sa  glfwGetWindowSize
  ## @sa  glfwSetWindowMonitor
  ##
  ## @since Added in version 1.0.
  ## @glfw3 Added window handle parameter.
  ##
  ## @ingroup window
proc getFramebufferSize*(window: GLFWWindow, width: ptr int32, height: ptr int32): void {.importc: "glfwGetFramebufferSize".}
  ## @brief Retrieves the size of the framebuffer of the specified window.
  ##
  ## This function retrieves the size, in pixels, of the framebuffer of the
  ## specified window.  If you wish to retrieve the size of the window in screen
  ## coordinates, see  glfwGetWindowSize.
  ##
  ## Any or all of the size arguments may be `NULL`.  If an error occurs, all
  ## non-`NULL` size arguments will be set to zero.
  ##
  ## @param[in] window The window whose framebuffer to query.
  ## @param[out] width Where to store the width, in pixels, of the framebuffer,
  ## or `NULL`.
  ## @param[out] height Where to store the height, in pixels, of the framebuffer,
  ## or `NULL`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_fbsize
  ## @sa  glfwSetFramebufferSizeCallback
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc getWindowFrameSize*(window: GLFWWindow, left: ptr int32, top: ptr int32, right: ptr int32, bottom: ptr int32): void {.importc: "glfwGetWindowFrameSize".}
  ## @brief Retrieves the size of the frame of the window.
  ##
  ## This function retrieves the size, in screen coordinates, of each edge of the
  ## frame of the specified window.  This size includes the title bar, if the
  ## window has one.  The size of the frame may vary depending on the
  ## window-related hints used to create it.
  ##
  ## Because this function retrieves the size of each window frame edge and not
  ## the offset along a particular coordinate axis, the retrieved values will
  ## always be zero or positive.
  ##
  ## Any or all of the size arguments may be `NULL`.  If an error occurs, all
  ## non-`NULL` size arguments will be set to zero.
  ##
  ## @param[in] window The window whose frame size to query.
  ## @param[out] left Where to store the size, in screen coordinates, of the left
  ## edge of the window frame, or `NULL`.
  ## @param[out] top Where to store the size, in screen coordinates, of the top
  ## edge of the window frame, or `NULL`.
  ## @param[out] right Where to store the size, in screen coordinates, of the
  ## right edge of the window frame, or `NULL`.
  ## @param[out] bottom Where to store the size, in screen coordinates, of the
  ## bottom edge of the window frame, or `NULL`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_size
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup window
proc getWindowContentScale*(window: GLFWWindow, xscale: ptr float32, yscale: ptr float32): void {.importc: "glfwGetWindowContentScale".}
  ## @brief Retrieves the content scale for the specified window.
  ##
  ## This function retrieves the content scale for the specified window.  The
  ## content scale is the ratio between the current DPI and the platform's
  ## default DPI.  This is especially important for text and any UI elements.  If
  ## the pixel dimensions of your UI scaled by this look appropriate on your
  ## machine then it should appear at a reasonable size on other machines
  ## regardless of their DPI and scaling settings.  This relies on the system DPI
  ## and scaling settings being somewhat correct.
  ##
  ## On systems where each monitors can have its own content scale, the window
  ## content scale will depend on which monitor the system considers the window
  ## to be on.
  ##
  ## @param[in] window The window to query.
  ## @param[out] xscale Where to store the x-axis content scale, or `NULL`.
  ## @param[out] yscale Where to store the y-axis content scale, or `NULL`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_scale
  ## @sa  glfwSetWindowContentScaleCallback
  ## @sa  glfwGetMonitorContentScale
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup window
proc getWindowOpacity*(window: GLFWWindow): float32 {.importc: "glfwGetWindowOpacity".}
  ## @brief Returns the opacity of the whole window.
  ##
  ## This function returns the opacity of the window, including any decorations.
  ##
  ## The opacity (or alpha) value is a positive finite number between zero and
  ## one, where zero is fully transparent and one is fully opaque.  If the system
  ## does not support whole window transparency, this function always returns one.
  ##
  ## The initial opacity value for newly created windows is one.
  ##
  ## @param[in] window The window to query.
  ## @return The opacity value of the specified window.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_transparency
  ## @sa  glfwSetWindowOpacity
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup window
proc setWindowOpacity*(window: GLFWWindow, opacity: float32): void {.importc: "glfwSetWindowOpacity".}
  ## @brief Sets the opacity of the whole window.
  ##
  ## This function sets the opacity of the window, including any decorations.
  ##
  ## The opacity (or alpha) value is a positive finite number between zero and
  ## one, where zero is fully transparent and one is fully opaque.
  ##
  ## The initial opacity value for newly created windows is one.
  ##
  ## A window created with framebuffer transparency may not use whole window
  ## transparency.  The results of doing this are undefined.
  ##
  ## @param[in] window The window to set the opacity for.
  ## @param[in] opacity The desired opacity of the specified window.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_PLATFORM_ERROR and @ref GLFW_FEATURE_UNAVAILABLE .
  ##
  ## @remark @wayland There is no way to set an opacity factor for a window.
  ## This function will emit  GLFW_FEATURE_UNAVAILABLE.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_transparency
  ## @sa  glfwGetWindowOpacity
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup window
proc iconifyWindow*(window: GLFWWindow): void {.importc: "glfwIconifyWindow".}
  ## @brief Iconifies the specified window.
  ##
  ## This function iconifies (minimizes) the specified window if it was
  ## previously restored.  If the window is already iconified, this function does
  ## nothing.
  ##
  ## If the specified window is a full screen window, the original monitor
  ## resolution is restored until the window is restored.
  ##
  ## @param[in] window The window to iconify.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @remark @wayland Once a window is iconified,  glfwRestoreWindow won’t
  ## be able to restore it.  This is a design decision of the xdg-shell
  ## protocol.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_iconify
  ## @sa  glfwRestoreWindow
  ## @sa  glfwMaximizeWindow
  ##
  ## @since Added in version 2.1.
  ## @glfw3 Added window handle parameter.
  ##
  ## @ingroup window
proc restoreWindow*(window: GLFWWindow): void {.importc: "glfwRestoreWindow".}
  ## @brief Restores the specified window.
  ##
  ## This function restores the specified window if it was previously iconified
  ## (minimized) or maximized.  If the window is already restored, this function
  ## does nothing.
  ##
  ## If the specified window is a full screen window, the resolution chosen for
  ## the window is restored on the selected monitor.
  ##
  ## @param[in] window The window to restore.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_iconify
  ## @sa  glfwIconifyWindow
  ## @sa  glfwMaximizeWindow
  ##
  ## @since Added in version 2.1.
  ## @glfw3 Added window handle parameter.
  ##
  ## @ingroup window
proc maximizeWindow*(window: GLFWWindow): void {.importc: "glfwMaximizeWindow".}
  ## @brief Maximizes the specified window.
  ##
  ## This function maximizes the specified window if it was previously not
  ## maximized.  If the window is already maximized, this function does nothing.
  ##
  ## If the specified window is a full screen window, this function does nothing.
  ##
  ## @param[in] window The window to maximize.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @par Thread Safety
  ## This function may only be called from the main thread.
  ##
  ## @sa  window_iconify
  ## @sa  glfwIconifyWindow
  ## @sa  glfwRestoreWindow
  ##
  ## @since Added in GLFW 3.2.
  ##
  ## @ingroup window
proc showWindow*(window: GLFWWindow): void {.importc: "glfwShowWindow".}
  ## @brief Makes the specified window visible.
  ##
  ## This function makes the specified window visible if it was previously
  ## hidden.  If the window is already visible or is in full screen mode, this
  ## function does nothing.
  ##
  ## By default, windowed mode windows are focused when shown
  ## Set the GLFW_FOCUS_ON_SHOW window hint
  ## to change this behavior for all newly created windows, or change the
  ## behavior for an existing window with  glfwSetWindowAttrib.
  ##
  ## @param[in] window The window to make visible.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_hide
  ## @sa  glfwHideWindow
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc hideWindow*(window: GLFWWindow): void {.importc: "glfwHideWindow".}
  ## @brief Hides the specified window.
  ##
  ## This function hides the specified window if it was previously visible.  If
  ## the window is already hidden or is in full screen mode, this function does
  ## nothing.
  ##
  ## @param[in] window The window to hide.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_hide
  ## @sa  glfwShowWindow
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc focusWindow*(window: GLFWWindow): void {.importc: "glfwFocusWindow".}
  ## @brief Brings the specified window to front and sets input focus.
  ##
  ## This function brings the specified window to front and sets input focus.
  ## The window should already be visible and not iconified.
  ##
  ## By default, both windowed and full screen mode windows are focused when
  ## initially created.  Set the GLFW_FOCUSED to
  ## disable this behavior.
  ##
  ## Also by default, windowed mode windows are focused when shown
  ## with  glfwShowWindow. Set the
  ## GLFW_FOCUS_ON_SHOW to disable this behavior.
  ##
  ## __Do not use this function__ to steal focus from other applications unless
  ## you are certain that is what the user wants.  Focus stealing can be
  ## extremely disruptive.
  ##
  ## For a less disruptive way of getting the user's attention, see
  ## attention requests.
  ##
  ## @param[in] window The window to give input focus.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_PLATFORM_ERROR and @ref GLFW_FEATURE_UNAVAILABLE .
  ##
  ## @remark @wayland It is not possible for an application to set the input
  ## focus.  This function will emit  GLFW_FEATURE_UNAVAILABLE.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_focus
  ## @sa  window_attention
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup window
proc requestWindowAttention*(window: GLFWWindow): void {.importc: "glfwRequestWindowAttention".}
  ## @brief Requests user attention to the specified window.
  ##
  ## This function requests user attention to the specified window.  On
  ## platforms where this is not supported, attention is requested to the
  ## application as a whole.
  ##
  ## Once the user has given attention, usually by focusing the window or
  ## application, the system will end the request automatically.
  ##
  ## @param[in] window The window to request attention to.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @remark @macos Attention is requested to the application as a whole, not the
  ## specific window.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_attention
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup window
proc getWindowMonitor*(window: GLFWWindow): GLFWMonitor {.importc: "glfwGetWindowMonitor".}
  ## @brief Returns the monitor that the window uses for full screen mode.
  ##
  ## This function returns the handle of the monitor that the specified window is
  ## in full screen on.
  ##
  ## @param[in] window The window to query.
  ## @return The monitor, or `NULL` if the window is in windowed mode or an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_monitor
  ## @sa  glfwSetWindowMonitor
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc setWindowMonitor*(window: GLFWWindow, monitor: GLFWMonitor, xpos: int32, ypos: int32, width: int32, height: int32, refreshRate: int32): void {.importc: "glfwSetWindowMonitor".}
  ## @brief Sets the mode, monitor, video mode and placement of a window.
  ##
  ## This function sets the monitor that the window uses for full screen mode or,
  ## if the monitor is `NULL`, makes it windowed mode.
  ##
  ## When setting a monitor, this function updates the width, height and refresh
  ## rate of the desired video mode and switches to the video mode closest to it.
  ## The window position is ignored when setting a monitor.
  ##
  ## When the monitor is `NULL`, the position, width and height are used to
  ## place the window content area.  The refresh rate is ignored when no monitor
  ## is specified.
  ##
  ## If you only wish to update the resolution of a full screen window or the
  ## size of a windowed mode window, see  glfwSetWindowSize.
  ##
  ## When a window transitions from full screen to windowed mode, this function
  ## restores any previous window settings such as whether it is decorated,
  ## floating, resizable, has size or aspect ratio limits, etc.
  ##
  ## @param[in] window The window whose monitor, size or video mode to set.
  ## @param[in] monitor The desired monitor, or `NULL` to set windowed mode.
  ## @param[in] xpos The desired x-coordinate of the upper-left corner of the
  ## content area.
  ## @param[in] ypos The desired y-coordinate of the upper-left corner of the
  ## content area.
  ## @param[in] width The desired with, in screen coordinates, of the content
  ## area or video mode.
  ## @param[in] height The desired height, in screen coordinates, of the content
  ## area or video mode.
  ## @param[in] refreshRate The desired refresh rate, in Hz, of the video mode,
  ## or `GLFW_DONT_CARE`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @remark The OpenGL or OpenGL ES context will not be destroyed or otherwise
  ## affected by any resizing or mode switching, although you may need to update
  ## your viewport if the framebuffer size has changed.
  ##
  ## @remark @wayland The desired window position is ignored, as there is no way
  ## for an application to set this property.
  ##
  ## @remark @wayland Setting the window to full screen will not attempt to
  ## change the mode, no matter what the requested size or refresh rate.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_monitor
  ## @sa  window_full_screen
  ## @sa  glfwGetWindowMonitor
  ## @sa  glfwSetWindowSize
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup window
proc getWindowAttrib*(window: GLFWWindow, attrib: int32): int32 {.importc: "glfwGetWindowAttrib".}
  ## @brief Returns an attribute of the specified window.
  ##
  ## This function returns the value of an attribute of the specified window or
  ## its OpenGL or OpenGL ES context.
  ##
  ## @param[in] window The window to query.
  ## @paramin attrib The window attribute whose value to
  ## return.
  ## @return The value of the attribute, or zero if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM and  GLFW_PLATFORM_ERROR.
  ##
  ## @remark Framebuffer related hints are not window attributes.  See
  ## window_attribs_fb for more information.
  ##
  ## @remark Zero is a valid value for many window and context related
  ## attributes so you cannot use a return value of zero as an indication of
  ## errors.  However, this function should not fail as long as it is passed
  ## valid arguments and the library has been initialized.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_attribs
  ## @sa  glfwSetWindowAttrib
  ##
  ## @since Added in version 3.0.  Replaces `glfwGetWindowParam` and
  ## `glfwGetGLVersion`.
  ##
  ## @ingroup window
proc setWindowAttrib*(window: GLFWWindow, attrib: int32, value: int32): void {.importc: "glfwSetWindowAttrib".}
  ## @brief Sets an attribute of the specified window.
  ##
  ## This function sets the value of an attribute of the specified window.
  ##
  ## The supported attributes are GLFW_DECORATED,
  ## GLFW_RESIZABLE,
  ## GLFW_FLOATING,
  ## GLFW_AUTO_ICONIFY and
  ## GLFW_FOCUS_ON_SHOW.
  ## GLFW_MOUSE_PASSTHROUGH
  ##
  ## Some of these attributes are ignored for full screen windows.  The new
  ## value will take effect if the window is later made windowed.
  ##
  ## Some of these attributes are ignored for windowed mode windows.  The new
  ## value will take effect if the window is later made full screen.
  ##
  ## @param[in] window The window to set the attribute for.
  ## @param[in] attrib A supported window attribute.
  ## @param[in] value `GLFW_TRUE` or `GLFW_FALSE`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM,  GLFW_INVALID_VALUE and  GLFW_PLATFORM_ERROR.
  ##
  ## @remark Calling  glfwGetWindowAttrib will always return the latest
  ## value, even if that value is ignored by the current mode of the window.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_attribs
  ## @sa  glfwGetWindowAttrib
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup window
proc setWindowUserPointer*(window: GLFWWindow, pointer: pointer): void {.importc: "glfwSetWindowUserPointer".}
  ## @brief Sets the user pointer of the specified window.
  ##
  ## This function sets the user-defined pointer of the specified window.  The
  ## current value is retained until the window is destroyed.  The initial value
  ## is `NULL`.
  ##
  ## @param[in] window The window whose pointer to set.
  ## @param[in] pointer The new value.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @sa  window_userptr
  ## @sa  glfwGetWindowUserPointer
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc getWindowUserPointer*(window: GLFWWindow): pointer {.importc: "glfwGetWindowUserPointer".}
  ## @brief Returns the user pointer of the specified window.
  ##
  ## This function returns the current value of the user-defined pointer of the
  ## specified window.  The initial value is `NULL`.
  ##
  ## @param[in] window The window whose pointer to return.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @sa  window_userptr
  ## @sa  glfwSetWindowUserPointer
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc setWindowPosCallback*(window: GLFWWindow, callback: GLFWWindowposfun): GLFWWindowposfun {.importc: "glfwSetWindowPosCallback".}
  ## @brief Sets the position callback for the specified window.
  ##
  ## This function sets the position callback of the specified window, which is
  ## called when the window is moved.  The callback is provided with the
  ## position, in screen coordinates, of the upper-left corner of the content
  ## area of the window.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, int xpos, int ypos)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @remark @wayland This callback will never be called, as there is no way for
  ## an application to know its global position.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_pos
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc setWindowSizeCallback*(window: GLFWWindow, callback: GLFWWindowsizefun): GLFWWindowsizefun {.importc: "glfwSetWindowSizeCallback".}
  ## @brief Sets the size callback for the specified window.
  ##
  ## This function sets the size callback of the specified window, which is
  ## called when the window is resized.  The callback is provided with the size,
  ## in screen coordinates, of the content area of the window.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, int width, int height)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_size
  ##
  ## @since Added in version 1.0.
  ## @glfw3 Added window handle parameter and return value.
  ##
  ## @ingroup window
proc setWindowCloseCallback*(window: GLFWWindow, callback: GLFWWindowclosefun): GLFWWindowclosefun {.importc: "glfwSetWindowCloseCallback".}
  ## @brief Sets the close callback for the specified window.
  ##
  ## This function sets the close callback of the specified window, which is
  ## called when the user attempts to close the window, for example by clicking
  ## the close widget in the title bar.
  ##
  ## The close flag is set before this callback is called, but you can modify it
  ## at any time with  glfwSetWindowShouldClose.
  ##
  ## The close callback is not triggered by  glfwDestroyWindow.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @remark @macos Selecting Quit from the application menu will trigger the
  ## close callback for all windows.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_close
  ##
  ## @since Added in version 2.5.
  ## @glfw3 Added window handle parameter and return value.
  ##
  ## @ingroup window
proc setWindowRefreshCallback*(window: GLFWWindow, callback: GLFWWindowrefreshfun): GLFWWindowrefreshfun {.importc: "glfwSetWindowRefreshCallback".}
  ## @brief Sets the refresh callback for the specified window.
  ##
  ## This function sets the refresh callback of the specified window, which is
  ## called when the content area of the window needs to be redrawn, for example
  ## if the window has been exposed after having been covered by another window.
  ##
  ## On compositing window systems such as Aero, Compiz, Aqua or Wayland, where
  ## the window contents are saved off-screen, this callback may be called only
  ## very infrequently or never at all.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window);
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_refresh
  ##
  ## @since Added in version 2.5.
  ## @glfw3 Added window handle parameter and return value.
  ##
  ## @ingroup window
proc setWindowFocusCallback*(window: GLFWWindow, callback: GLFWWindowfocusfun): GLFWWindowfocusfun {.importc: "glfwSetWindowFocusCallback".}
  ## @brief Sets the focus callback for the specified window.
  ##
  ## This function sets the focus callback of the specified window, which is
  ## called when the window gains or loses input focus.
  ##
  ## After the focus callback is called for a window that lost input focus,
  ## synthetic key and mouse button release events will be generated for all such
  ## that had been pressed.  For more information, see  glfwSetKeyCallback
  ## and  glfwSetMouseButtonCallback.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, int focused)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_focus
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc setWindowIconifyCallback*(window: GLFWWindow, callback: GLFWWindowiconifyfun): GLFWWindowiconifyfun {.importc: "glfwSetWindowIconifyCallback".}
  ## @brief Sets the iconify callback for the specified window.
  ##
  ## This function sets the iconification callback of the specified window, which
  ## is called when the window is iconified or restored.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, int iconified)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_iconify
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc setWindowMaximizeCallback*(window: GLFWWindow, callback: GLFWWindowmaximizefun): GLFWWindowmaximizefun {.importc: "glfwSetWindowMaximizeCallback".}
  ## @brief Sets the maximize callback for the specified window.
  ##
  ## This function sets the maximization callback of the specified window, which
  ## is called when the window is maximized or restored.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, int maximized)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_maximize
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup window
proc setFramebufferSizeCallback*(window: GLFWWindow, callback: GLFWFramebuffersizefun): GLFWFramebuffersizefun {.importc: "glfwSetFramebufferSizeCallback".}
  ## @brief Sets the framebuffer resize callback for the specified window.
  ##
  ## This function sets the framebuffer resize callback of the specified window,
  ## which is called when the framebuffer of the specified window is resized.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, int width, int height)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_fbsize
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup window
proc setWindowContentScaleCallback*(window: GLFWWindow, callback: GLFWWindowcontentscalefun): GLFWWindowcontentscalefun {.importc: "glfwSetWindowContentScaleCallback".}
  ## @brief Sets the window content scale callback for the specified window.
  ##
  ## This function sets the window content scale callback of the specified window,
  ## which is called when the content scale of the specified window changes.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, float xscale, float yscale)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  window_scale
  ## @sa  glfwGetWindowContentScale
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup window
proc glfwPollEvents*(): void {.importc: "glfwPollEvents".}
  ## @brief Processes all pending events.
  ##
  ## This function processes only those events that are already in the event
  ## queue and then returns immediately.  Processing events will cause the window
  ## and input callbacks associated with those events to be called.
  ##
  ## On some platforms, a window move, resize or menu operation will cause event
  ## processing to block.  This is due to how event processing is designed on
  ## those platforms.  You can use the
  ## window refresh callback to redraw the contents of
  ## your window when necessary during such operations.
  ##
  ## Do not assume that callbacks you set will _only_ be called in response to
  ## event processing functions like this one.  While it is necessary to poll for
  ## events, window systems that require GLFW to register callbacks of its own
  ## can pass events to GLFW in response to many window system function calls.
  ## GLFW will pass those events on to the application callbacks before
  ## returning.
  ##
  ## Event processing is not required for joystick input to work.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @reentrancy This function must not be called from a callback.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  events
  ## @sa  glfwWaitEvents
  ## @sa  glfwWaitEventsTimeout
  ##
  ## @since Added in version 1.0.
  ##
  ## @ingroup window
proc glfwWaitEvents*(): void {.importc: "glfwWaitEvents".}
  ## @brief Waits until events are queued and processes them.
  ##
  ## This function puts the calling thread to sleep until at least one event is
  ## available in the event queue.  Once one or more events are available,
  ## it behaves exactly like  glfwPollEvents, i.e. the events in the queue
  ## are processed and the function then returns immediately.  Processing events
  ## will cause the window and input callbacks associated with those events to be
  ## called.
  ##
  ## Since not all events are associated with callbacks, this function may return
  ## without a callback having been called even if you are monitoring all
  ## callbacks.
  ##
  ## On some platforms, a window move, resize or menu operation will cause event
  ## processing to block.  This is due to how event processing is designed on
  ## those platforms.  You can use the
  ## window refresh callback to redraw the contents of
  ## your window when necessary during such operations.
  ##
  ## Do not assume that callbacks you set will _only_ be called in response to
  ## event processing functions like this one.  While it is necessary to poll for
  ## events, window systems that require GLFW to register callbacks of its own
  ## can pass events to GLFW in response to many window system function calls.
  ## GLFW will pass those events on to the application callbacks before
  ## returning.
  ##
  ## Event processing is not required for joystick input to work.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @reentrancy This function must not be called from a callback.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  events
  ## @sa  glfwPollEvents
  ## @sa  glfwWaitEventsTimeout
  ##
  ## @since Added in version 2.5.
  ##
  ## @ingroup window
proc glfwWaitEventsTimeout*(timeout: float64): void {.importc: "glfwWaitEventsTimeout".}
  ## @brief Waits with timeout until events are queued and processes them.
  ##
  ## This function puts the calling thread to sleep until at least one event is
  ## available in the event queue, or until the specified timeout is reached.  If
  ## one or more events are available, it behaves exactly like
  ## glfwPollEvents, i.e. the events in the queue are processed and the function
  ## then returns immediately.  Processing events will cause the window and input
  ## callbacks associated with those events to be called.
  ##
  ## The timeout value must be a positive finite number.
  ##
  ## Since not all events are associated with callbacks, this function may return
  ## without a callback having been called even if you are monitoring all
  ## callbacks.
  ##
  ## On some platforms, a window move, resize or menu operation will cause event
  ## processing to block.  This is due to how event processing is designed on
  ## those platforms.  You can use the
  ## window refresh callback to redraw the contents of
  ## your window when necessary during such operations.
  ##
  ## Do not assume that callbacks you set will _only_ be called in response to
  ## event processing functions like this one.  While it is necessary to poll for
  ## events, window systems that require GLFW to register callbacks of its own
  ## can pass events to GLFW in response to many window system function calls.
  ## GLFW will pass those events on to the application callbacks before
  ## returning.
  ##
  ## Event processing is not required for joystick input to work.
  ##
  ## @param[in] timeout The maximum amount of time, in seconds, to wait.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_VALUE and  GLFW_PLATFORM_ERROR.
  ##
  ## @reentrancy This function must not be called from a callback.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  events
  ## @sa  glfwPollEvents
  ## @sa  glfwWaitEvents
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup window
proc glfwPostEmptyEvent*(): void {.importc: "glfwPostEmptyEvent".}
  ## @brief Posts an empty event to the event queue.
  ##
  ## This function posts an empty event from the current thread to the event
  ## queue, causing  glfwWaitEvents or  glfwWaitEventsTimeout to return.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  events
  ## @sa  glfwWaitEvents
  ## @sa  glfwWaitEventsTimeout
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup window
proc getInputMode*(window: GLFWWindow, mode: int32): int32 {.importc: "glfwGetInputMode".}
  ## @brief Returns the value of an input option for the specified window.
  ##
  ## This function returns the value of an input option for the specified window.
  ## The mode must be one of  GLFW_CURSOR,  GLFW_STICKY_KEYS,
  ##  GLFW_STICKY_MOUSE_BUTTONS,  GLFW_LOCK_KEY_MODS or
  ##  GLFW_RAW_MOUSE_MOTION.
  ##
  ## @param[in] window The window to query.
  ## @param[in] mode One of `GLFW_CURSOR`, `GLFW_STICKY_KEYS`,
  ## `GLFW_STICKY_MOUSE_BUTTONS`, `GLFW_LOCK_KEY_MODS` or
  ## `GLFW_RAW_MOUSE_MOTION`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_INVALID_ENUM.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  glfwSetInputMode
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup input
proc setInputMode*(window: GLFWWindow, mode: int32, value: int32): void {.importc: "glfwSetInputMode".}
  ## @brief Sets an input option for the specified window.
  ##
  ## This function sets an input mode option for the specified window.  The mode
  ## must be one of  GLFW_CURSOR,  GLFW_STICKY_KEYS,
  ##  GLFW_STICKY_MOUSE_BUTTONS,  GLFW_LOCK_KEY_MODS or
  ##  GLFW_RAW_MOUSE_MOTION.
  ##
  ## If the mode is `GLFW_CURSOR`, the value must be one of the following cursor
  ## modes:
  ## - `GLFW_CURSOR_NORMAL` makes the cursor visible and behaving normally.
  ## - `GLFW_CURSOR_HIDDEN` makes the cursor invisible when it is over the
  ##   content area of the window but does not restrict the cursor from leaving.
  ## - `GLFW_CURSOR_DISABLED` hides and grabs the cursor, providing virtual
  ##   and unlimited cursor movement.  This is useful for implementing for
  ##   example 3D camera controls.
  ##
  ## If the mode is `GLFW_STICKY_KEYS`, the value must be either `GLFW_TRUE` to
  ## enable sticky keys, or `GLFW_FALSE` to disable it.  If sticky keys are
  ## enabled, a key press will ensure that  glfwGetKey returns `GLFW_PRESS`
  ## the next time it is called even if the key had been released before the
  ## call.  This is useful when you are only interested in whether keys have been
  ## pressed but not when or in which order.
  ##
  ## If the mode is `GLFW_STICKY_MOUSE_BUTTONS`, the value must be either
  ## `GLFW_TRUE` to enable sticky mouse buttons, or `GLFW_FALSE` to disable it.
  ## If sticky mouse buttons are enabled, a mouse button press will ensure that
  ##  glfwGetMouseButton returns `GLFW_PRESS` the next time it is called even
  ## if the mouse button had been released before the call.  This is useful when
  ## you are only interested in whether mouse buttons have been pressed but not
  ## when or in which order.
  ##
  ## If the mode is `GLFW_LOCK_KEY_MODS`, the value must be either `GLFW_TRUE` to
  ## enable lock key modifier bits, or `GLFW_FALSE` to disable them.  If enabled,
  ## callbacks that receive modifier bits will also have the
  ## GLFW_MOD_CAPS_LOCK bit set when the event was generated with Caps Lock on,
  ## and the  GLFW_MOD_NUM_LOCK bit when Num Lock was on.
  ##
  ## If the mode is `GLFW_RAW_MOUSE_MOTION`, the value must be either `GLFW_TRUE`
  ## to enable raw (unscaled and unaccelerated) mouse motion when the cursor is
  ## disabled, or `GLFW_FALSE` to disable it.  If raw motion is not supported,
  ## attempting to set this will emit  GLFW_FEATURE_UNAVAILABLE.  Call
  ## glfwRawMouseMotionSupported to check for support.
  ##
  ## @param[in] window The window whose input mode to set.
  ## @param[in] mode One of `GLFW_CURSOR`, `GLFW_STICKY_KEYS`,
  ## `GLFW_STICKY_MOUSE_BUTTONS`, `GLFW_LOCK_KEY_MODS` or
  ## `GLFW_RAW_MOUSE_MOTION`.
  ## @param[in] value The new value of the specified input mode.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM,  GLFW_PLATFORM_ERROR and
  ## GLFW_FEATURE_UNAVAILABLE (see above).
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  glfwGetInputMode
  ##
  ## @since Added in version 3.0.  Replaces `glfwEnable` and `glfwDisable`.
  ##
  ## @ingroup input
proc glfwRawMouseMotionSupported*(): int32 {.importc: "glfwRawMouseMotionSupported".}
  ## @brief Returns whether raw mouse motion is supported.
  ##
  ## This function returns whether raw mouse motion is supported on the current
  ## system.  This status does not change after GLFW has been initialized so you
  ## only need to check this once.  If you attempt to enable raw motion on
  ## a system that does not support it,  GLFW_PLATFORM_ERROR will be emitted.
  ##
  ## Raw mouse motion is closer to the actual motion of the mouse across
  ## a surface.  It is not affected by the scaling and acceleration applied to
  ## the motion of the desktop cursor.  That processing is suitable for a cursor
  ## while raw motion is better for controlling for example a 3D camera.  Because
  ## of this, raw mouse motion is only provided when the cursor is disabled.
  ##
  ## @return `GLFW_TRUE` if raw mouse motion is supported on the current machine,
  ## or `GLFW_FALSE` otherwise.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  raw_mouse_motion
  ## @sa  glfwSetInputMode
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup input
proc glfwGetKeyName*(key: int32, scancode: int32): cstring {.importc: "glfwGetKeyName".}
  ## @brief Returns the layout-specific name of the specified printable key.
  ##
  ## This function returns the name of the specified printable key, encoded as
  ## UTF-8.  This is typically the character that key would produce without any
  ## modifier keys, intended for displaying key bindings to the user.  For dead
  ## keys, it is typically the diacritic it would add to a character.
  ##
  ## __Do not use this function__ for text input.  You will
  ## break text input for many languages even if it happens to work for yours.
  ##
  ## If the key is `GLFW_KEY_UNKNOWN`, the scancode is used to identify the key,
  ## otherwise the scancode is ignored.  If you specify a non-printable key, or
  ## `GLFW_KEY_UNKNOWN` and a scancode that maps to a non-printable key, this
  ## function returns `NULL` but does not emit an error.
  ##
  ## This behavior allows you to always pass in the arguments in the
  ## key callback without modification.
  ##
  ## The printable keys are:
  ## - `GLFW_KEY_APOSTROPHE`
  ## - `GLFW_KEY_COMMA`
  ## - `GLFW_KEY_MINUS`
  ## - `GLFW_KEY_PERIOD`
  ## - `GLFW_KEY_SLASH`
  ## - `GLFW_KEY_SEMICOLON`
  ## - `GLFW_KEY_EQUAL`
  ## - `GLFW_KEY_LEFT_BRACKET`
  ## - `GLFW_KEY_RIGHT_BRACKET`
  ## - `GLFW_KEY_BACKSLASH`
  ## - `GLFW_KEY_WORLD_1`
  ## - `GLFW_KEY_WORLD_2`
  ## - `GLFW_KEY_0` to `GLFW_KEY_9`
  ## - `GLFW_KEY_A` to `GLFW_KEY_Z`
  ## - `GLFW_KEY_KP_0` to `GLFW_KEY_KP_9`
  ## - `GLFW_KEY_KP_DECIMAL`
  ## - `GLFW_KEY_KP_DIVIDE`
  ## - `GLFW_KEY_KP_MULTIPLY`
  ## - `GLFW_KEY_KP_SUBTRACT`
  ## - `GLFW_KEY_KP_ADD`
  ## - `GLFW_KEY_KP_EQUAL`
  ##
  ## Names for printable keys depend on keyboard layout, while names for
  ## non-printable keys are the same across layouts but depend on the application
  ## language and should be localized along with other user interface text.
  ##
  ## @param[in] key The key to query, or `GLFW_KEY_UNKNOWN`.
  ## @param[in] scancode The scancode of the key to query.
  ## @return The UTF-8 encoded, layout-specific name of the key, or `NULL`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @remark The contents of the returned string may change when a keyboard
  ## layout change event is received.
  ##
  ## @pointer_lifetime The returned string is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is valid until the library is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  input_key_name
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup input
proc glfwGetKeyScancode*(key: int32): int32 {.importc: "glfwGetKeyScancode".}
  ## @brief Returns the platform-specific scancode of the specified key.
  ##
  ## This function returns the platform-specific scancode of the specified key.
  ##
  ## If the key is `GLFW_KEY_UNKNOWN` or does not exist on the keyboard this
  ## method will return `-1`.
  ##
  ## @paramin key Any named key.
  ## @return The platform-specific scancode for the key, or `-1` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM and  GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  input_key
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup input
proc getKey*(window: GLFWWindow, key: int32): int32 {.importc: "glfwGetKey".}
  ## @brief Returns the last reported state of a keyboard key for the specified
  ## window.
  ##
  ## This function returns the last state reported for the specified key to the
  ## specified window.  The returned state is one of `GLFW_PRESS` or
  ## `GLFW_RELEASE`.  The higher-level action `GLFW_REPEAT` is only reported to
  ## the key callback.
  ##
  ## If the  GLFW_STICKY_KEYS input mode is enabled, this function returns
  ## `GLFW_PRESS` the first time you call it for a key that was pressed, even if
  ## that key has already been released.
  ##
  ## The key functions deal with physical keys, with key tokens
  ## named after their use on the standard US keyboard layout.  If you want to
  ## input text, use the Unicode character callback instead.
  ##
  ## The modifier key bit masks are not key tokens and cannot be
  ## used with this function.
  ##
  ## __Do not use this function__ to implement text input.
  ##
  ## @param[in] window The desired window.
  ## @paramin key The desired keyboard key.  `GLFW_KEY_UNKNOWN` is
  ## not a valid key for this function.
  ## @return One of `GLFW_PRESS` or `GLFW_RELEASE`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_INVALID_ENUM.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  input_key
  ##
  ## @since Added in version 1.0.
  ## @glfw3 Added window handle parameter.
  ##
  ## @ingroup input
proc getMouseButton*(window: GLFWWindow, button: int32): int32 {.importc: "glfwGetMouseButton".}
  ## @brief Returns the last reported state of a mouse button for the specified
  ## window.
  ##
  ## This function returns the last state reported for the specified mouse button
  ## to the specified window.  The returned state is one of `GLFW_PRESS` or
  ## `GLFW_RELEASE`.
  ##
  ## If the  GLFW_STICKY_MOUSE_BUTTONS input mode is enabled, this function
  ## returns `GLFW_PRESS` the first time you call it for a mouse button that was
  ## pressed, even if that mouse button has already been released.
  ##
  ## @param[in] window The desired window.
  ## @paramin button The desired mouse button.
  ## @return One of `GLFW_PRESS` or `GLFW_RELEASE`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_INVALID_ENUM.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  input_mouse_button
  ##
  ## @since Added in version 1.0.
  ## @glfw3 Added window handle parameter.
  ##
  ## @ingroup input
proc getCursorPos*(window: GLFWWindow, xpos: ptr float64, ypos: ptr float64): void {.importc: "glfwGetCursorPos".}
  ## @brief Retrieves the position of the cursor relative to the content area of
  ## the window.
  ##
  ## This function returns the position of the cursor, in screen coordinates,
  ## relative to the upper-left corner of the content area of the specified
  ## window.
  ##
  ## If the cursor is disabled (with `GLFW_CURSOR_DISABLED`) then the cursor
  ## position is unbounded and limited only by the minimum and maximum values of
  ## a `double`.
  ##
  ## The coordinate can be converted to their integer equivalents with the
  ## `floor` function.  Casting directly to an integer type works for positive
  ## coordinates, but fails for negative ones.
  ##
  ## Any or all of the position arguments may be `NULL`.  If an error occurs, all
  ## non-`NULL` position arguments will be set to zero.
  ##
  ## @param[in] window The desired window.
  ## @param[out] xpos Where to store the cursor x-coordinate, relative to the
  ## left edge of the content area, or `NULL`.
  ## @param[out] ypos Where to store the cursor y-coordinate, relative to the to
  ## top edge of the content area, or `NULL`.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  cursor_pos
  ## @sa  glfwSetCursorPos
  ##
  ## @since Added in version 3.0.  Replaces `glfwGetMousePos`.
  ##
  ## @ingroup input
proc setCursorPos*(window: GLFWWindow, xpos: float64, ypos: float64): void {.importc: "glfwSetCursorPos".}
  ## @brief Sets the position of the cursor, relative to the content area of the
  ## window.
  ##
  ## This function sets the position, in screen coordinates, of the cursor
  ## relative to the upper-left corner of the content area of the specified
  ## window.  The window must have input focus.  If the window does not have
  ## input focus when this function is called, it fails silently.
  ##
  ## __Do not use this function__ to implement things like camera controls.  GLFW
  ## already provides the `GLFW_CURSOR_DISABLED` cursor mode that hides the
  ## cursor, transparently re-centers it and provides unconstrained cursor
  ## motion.  See  glfwSetInputMode for more information.
  ##
  ## If the cursor mode is `GLFW_CURSOR_DISABLED` then the cursor position is
  ## unconstrained and limited only by the minimum and maximum values of
  ## a `double`.
  ##
  ## @param[in] window The desired window.
  ## @param[in] xpos The desired x-coordinate, relative to the left edge of the
  ## content area.
  ## @param[in] ypos The desired y-coordinate, relative to the top edge of the
  ## content area.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @remark @wayland This function will only work when the cursor mode is
  ## `GLFW_CURSOR_DISABLED`, otherwise it will do nothing.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  cursor_pos
  ## @sa  glfwGetCursorPos
  ##
  ## @since Added in version 3.0.  Replaces `glfwSetMousePos`.
  ##
  ## @ingroup input
proc createCursor*(image: ptr GLFWImage, xhot: int32, yhot: int32): GLFWCursor {.importc: "glfwCreateCursor".}
  ## @brief Creates a custom cursor.
  ##
  ## Creates a new custom cursor image that can be set for a window with
  ## glfwSetCursor.  The cursor can be destroyed with  glfwDestroyCursor.
  ## Any remaining cursors are destroyed by  glfwTerminate.
  ##
  ## The pixels are 32-bit, little-endian, non-premultiplied RGBA, i.e. eight
  ## bits per channel with the red channel first.  They are arranged canonically
  ## as packed sequential rows, starting from the top-left corner.
  ##
  ## The cursor hotspot is specified in pixels, relative to the upper-left corner
  ## of the cursor image.  Like all other coordinate systems in GLFW, the X-axis
  ## points to the right and the Y-axis points down.
  ##
  ## @param[in] image The desired cursor image.
  ## @param[in] xhot The desired x-coordinate, in pixels, of the cursor hotspot.
  ## @param[in] yhot The desired y-coordinate, in pixels, of the cursor hotspot.
  ## @return The handle of the created cursor, or `NULL` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The specified image data is copied before this function
  ## returns.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  cursor_object
  ## @sa  glfwDestroyCursor
  ## @sa  glfwCreateStandardCursor
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup input
proc glfwCreateStandardCursor*(shape: int32): GLFWCursor {.importc: "glfwCreateStandardCursor".}
  ## @brief Creates a cursor with a standard shape.
  ##
  ## Returns a cursor with a standard shape, that can be set for a window with
  ##  glfwSetCursor.  The images for these cursors come from the system
  ## cursor theme and their exact appearance will vary between platforms.
  ##
  ## Most of these shapes are guaranteed to exist on every supported platform but
  ## a few may not be present.  See the table below for details.
  ##
  ## Cursor shape                    Windows  macOS  X11     Wayland
  ## ------------------------------  -------  -----  ------  -------
  ##  GLFW_ARROW_CURSOR          Yes      Yes    Yes     Yes
  ##  GLFW_IBEAM_CURSOR          Yes      Yes    Yes     Yes
  ##  GLFW_CROSSHAIR_CURSOR      Yes      Yes    Yes     Yes
  ##  GLFW_POINTING_HAND_CURSOR  Yes      Yes    Yes     Yes
  ##  GLFW_RESIZE_EW_CURSOR      Yes      Yes    Yes     Yes
  ##  GLFW_RESIZE_NS_CURSOR      Yes      Yes    Yes     Yes
  ##  GLFW_RESIZE_NWSE_CURSOR    Yes      Yes<sup>1</sup>  Maybe<sup>2</sup>  Maybe<sup>2</sup>
  ##  GLFW_RESIZE_NESW_CURSOR    Yes      Yes<sup>1</sup>  Maybe<sup>2</sup>  Maybe<sup>2</sup>
  ##  GLFW_RESIZE_ALL_CURSOR     Yes      Yes    Yes     Yes
  ##  GLFW_NOT_ALLOWED_CURSOR    Yes      Yes    Maybe<sup>2</sup>  Maybe<sup>2</sup>
  ##
  ## 1) This uses a private system API and may fail in the future.
  ##
  ## 2) This uses a newer standard that not all cursor themes support.
  ##
  ## If the requested shape is not available, this function emits a
  ## GLFW_CURSOR_UNAVAILABLE error and returns `NULL`.
  ##
  ## @paramin shape One of the standard shapes.
  ## @return A new cursor ready to use or `NULL` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM,  GLFW_CURSOR_UNAVAILABLE and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  cursor_standard
  ## @sa  glfwCreateCursor
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup input
proc destroyCursor*(cursor: GLFWCursor): void {.importc: "glfwDestroyCursor".}
  ## @brief Destroys a cursor.
  ##
  ## This function destroys a cursor previously created with
  ## glfwCreateCursor.  Any remaining cursors will be destroyed by
  ## glfwTerminate.
  ##
  ## If the specified cursor is current for any window, that window will be
  ## reverted to the default cursor.  This does not affect the cursor mode.
  ##
  ## @param[in] cursor The cursor object to destroy.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @reentrancy This function must not be called from a callback.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  cursor_object
  ## @sa  glfwCreateCursor
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup input
proc setCursor*(window: GLFWWindow, cursor: GLFWCursor): void {.importc: "glfwSetCursor".}
  ## @brief Sets the cursor for the window.
  ##
  ## This function sets the cursor image to be used when the cursor is over the
  ## content area of the specified window.  The set cursor will only be visible
  ## when the cursor mode of the window is
  ## `GLFW_CURSOR_NORMAL`.
  ##
  ## On some platforms, the set cursor may not be visible unless the window also
  ## has input focus.
  ##
  ## @param[in] window The window to set the cursor for.
  ## @param[in] cursor The cursor to set, or `NULL` to switch back to the default
  ## arrow cursor.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  cursor_object
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup input
proc setKeyCallback*(window: GLFWWindow, callback: GLFWKeyfun): GLFWKeyfun {.importc: "glfwSetKeyCallback".}
  ## @brief Sets the key callback.
  ##
  ## This function sets the key callback of the specified window, which is called
  ## when a key is pressed, repeated or released.
  ##
  ## The key functions deal with physical keys, with layout independent
  ## key tokens named after their values in the standard US keyboard
  ## layout.  If you want to input text, use the
  ## character callback instead.
  ##
  ## When a window loses input focus, it will generate synthetic key release
  ## events for all pressed keys.  You can tell these events from user-generated
  ## events by the fact that the synthetic ones are generated after the focus
  ## loss event has been processed, i.e. after the
  ## window focus callback has been called.
  ##
  ## The scancode of a key is specific to that platform or sometimes even to that
  ## machine.  Scancodes are intended to allow users to bind keys that don't have
  ## a GLFW key token.  Such keys have `key` set to `GLFW_KEY_UNKNOWN`, their
  ## state is not saved and so it cannot be queried with  glfwGetKey.
  ##
  ## Sometimes GLFW needs to generate synthetic key events, in which case the
  ## scancode may be zero.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new key callback, or `NULL` to remove the currently
  ## set callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, int key, int scancode, int action, int mods)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  input_key
  ##
  ## @since Added in version 1.0.
  ## @glfw3 Added window handle parameter and return value.
  ##
  ## @ingroup input
proc setCharCallback*(window: GLFWWindow, callback: GLFWCharfun): GLFWCharfun {.importc: "glfwSetCharCallback".}
  ## @brief Sets the Unicode character callback.
  ##
  ## This function sets the character callback of the specified window, which is
  ## called when a Unicode character is input.
  ##
  ## The character callback is intended for Unicode text input.  As it deals with
  ## characters, it is keyboard layout dependent, whereas the
  ## key callback is not.  Characters do not map 1:1
  ## to physical keys, as a key may produce zero, one or more characters.  If you
  ## want to know whether a specific physical key was pressed or released, see
  ## the key callback instead.
  ##
  ## The character callback behaves as system text input normally does and will
  ## not be called if modifier keys are held down that would prevent normal text
  ## input on that platform, for example a Super (Command) key on macOS or Alt key
  ## on Windows.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, unsigned int codepoint)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  input_char
  ##
  ## @since Added in version 2.4.
  ## @glfw3 Added window handle parameter and return value.
  ##
  ## @ingroup input
proc setCharModsCallback*(window: GLFWWindow, callback: GLFWCharmodsfun): GLFWCharmodsfun {.importc: "glfwSetCharModsCallback".}
  ## @brief Sets the Unicode character with modifiers callback.
  ##
  ## This function sets the character with modifiers callback of the specified
  ## window, which is called when a Unicode character is input regardless of what
  ## modifier keys are used.
  ##
  ## The character with modifiers callback is intended for implementing custom
  ## Unicode character input.  For regular Unicode text input, see the
  ## character callback.  Like the character
  ## callback, the character with modifiers callback deals with characters and is
  ## keyboard layout dependent.  Characters do not map 1:1 to physical keys, as
  ## a key may produce zero, one or more characters.  If you want to know whether
  ## a specific physical key was pressed or released, see the
  ## key callback instead.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or an
  ## error occurred.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, unsigned int codepoint, int mods)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @deprecated Scheduled for removal in version 4.0.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  input_char
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup input
proc setMouseButtonCallback*(window: GLFWWindow, callback: GLFWMousebuttonfun): GLFWMousebuttonfun {.importc: "glfwSetMouseButtonCallback".}
  ## @brief Sets the mouse button callback.
  ##
  ## This function sets the mouse button callback of the specified window, which
  ## is called when a mouse button is pressed or released.
  ##
  ## When a window loses input focus, it will generate synthetic mouse button
  ## release events for all pressed mouse buttons.  You can tell these events
  ## from user-generated events by the fact that the synthetic ones are generated
  ## after the focus loss event has been processed, i.e. after the
  ## window focus callback has been called.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, int button, int action, int mods)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  input_mouse_button
  ##
  ## @since Added in version 1.0.
  ## @glfw3 Added window handle parameter and return value.
  ##
  ## @ingroup input
proc setCursorPosCallback*(window: GLFWWindow, callback: GLFWCursorposfun): GLFWCursorposfun {.importc: "glfwSetCursorPosCallback".}
  ## @brief Sets the cursor position callback.
  ##
  ## This function sets the cursor position callback of the specified window,
  ## which is called when the cursor is moved.  The callback is provided with the
  ## position, in screen coordinates, relative to the upper-left corner of the
  ## content area of the window.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, double xpos, double ypos);
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  cursor_pos
  ##
  ## @since Added in version 3.0.  Replaces `glfwSetMousePosCallback`.
  ##
  ## @ingroup input
proc setCursorEnterCallback*(window: GLFWWindow, callback: GLFWCursorenterfun): GLFWCursorenterfun {.importc: "glfwSetCursorEnterCallback".}
  ## @brief Sets the cursor enter/leave callback.
  ##
  ## This function sets the cursor boundary crossing callback of the specified
  ## window, which is called when the cursor enters or leaves the content area of
  ## the window.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, int entered)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  cursor_enter
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup input
proc setScrollCallback*(window: GLFWWindow, callback: GLFWScrollfun): GLFWScrollfun {.importc: "glfwSetScrollCallback".}
  ## @brief Sets the scroll callback.
  ##
  ## This function sets the scroll callback of the specified window, which is
  ## called when a scrolling device is used, such as a mouse wheel or scrolling
  ## area of a touchpad.
  ##
  ## The scroll callback receives all scrolling input, like that from a mouse
  ## wheel or a touchpad scrolling area.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new scroll callback, or `NULL` to remove the
  ## currently set callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, double xoffset, double yoffset)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  scrolling
  ##
  ## @since Added in version 3.0.  Replaces `glfwSetMouseWheelCallback`.
  ##
  ## @ingroup input
proc setDropCallback*(window: GLFWWindow, callback: GLFWDropfun): GLFWDropfun {.importc: "glfwSetDropCallback".}
  ## @brief Sets the path drop callback.
  ##
  ## This function sets the path drop callback of the specified window, which is
  ## called when one or more dragged paths are dropped on the window.
  ##
  ## Because the path array and its strings may have been generated specifically
  ## for that event, they are not guaranteed to be valid after the callback has
  ## returned.  If you wish to use them after the callback returns, you need to
  ## make a deep copy.
  ##
  ## @param[in] window The window whose callback to set.
  ## @param[in] callback The new file drop callback, or `NULL` to remove the
  ## currently set callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(GLFWwindow* window, int path_count, const char* paths[])
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @remark @wayland File drop is currently unimplemented.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  path_drop
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup input
proc glfwJoystickPresent*(jid: int32): int32 {.importc: "glfwJoystickPresent".}
  ## @brief Returns whether the specified joystick is present.
  ##
  ## This function returns whether the specified joystick is present.
  ##
  ## There is no need to call this function before other functions that accept
  ## a joystick ID, as they all check for presence before performing any other
  ## work.
  ##
  ## @paramin jid The joystick to query.
  ## @return `GLFW_TRUE` if the joystick is present, or `GLFW_FALSE` otherwise.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM and  GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  joystick
  ##
  ## @since Added in version 3.0.  Replaces `glfwGetJoystickParam`.
  ##
  ## @ingroup input
proc glfwGetJoystickAxes*(jid: int32, count: ptr int32): ptr float32 {.importc: "glfwGetJoystickAxes".}
  ## @brief Returns the values of all axes of the specified joystick.
  ##
  ## This function returns the values of all axes of the specified joystick.
  ## Each element in the array is a value between -1.0 and 1.0.
  ##
  ## If the specified joystick is not present this function will return `NULL`
  ## but will not generate an error.  This can be used instead of first calling
  ##  glfwJoystickPresent.
  ##
  ## @paramin jid The joystick to query.
  ## @param[out] count Where to store the number of axis values in the returned
  ## array.  This is set to zero if the joystick is not present or an error
  ## occurred.
  ## @return An array of axis values, or `NULL` if the joystick is not present or
  ## an error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM and  GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The returned array is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is valid until the specified joystick is
  ## disconnected or the library is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  joystick_axis
  ##
  ## @since Added in version 3.0.  Replaces `glfwGetJoystickPos`.
  ##
  ## @ingroup input
proc glfwGetJoystickButtons*(jid: int32, count: ptr int32): ptr cuchar {.importc: "glfwGetJoystickButtons".}
  ## @brief Returns the state of all buttons of the specified joystick.
  ##
  ## This function returns the state of all buttons of the specified joystick.
  ## Each element in the array is either `GLFW_PRESS` or `GLFW_RELEASE`.
  ##
  ## For backward compatibility with earlier versions that did not have
  ## glfwGetJoystickHats, the button array also includes all hats, each
  ## represented as four buttons.  The hats are in the same order as returned by
  ## __glfwGetJoystickHats__ and are in the order _up_, _right_, _down_ and
  ## _left_.  To disable these extra buttons, set the
  ## GLFW_JOYSTICK_HAT_BUTTONS init hint before initialization.
  ##
  ## If the specified joystick is not present this function will return `NULL`
  ## but will not generate an error.  This can be used instead of first calling
  ##  glfwJoystickPresent.
  ##
  ## @paramin jid The joystick to query.
  ## @param[out] count Where to store the number of button states in the returned
  ## array.  This is set to zero if the joystick is not present or an error
  ## occurred.
  ## @return An array of button states, or `NULL` if the joystick is not present
  ## or an error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM and  GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The returned array is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is valid until the specified joystick is
  ## disconnected or the library is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  joystick_button
  ##
  ## @since Added in version 2.2.
  ## @glfw3 Changed to return a dynamic array.
  ##
  ## @ingroup input
proc glfwGetJoystickHats*(jid: int32, count: ptr int32): ptr cuchar {.importc: "glfwGetJoystickHats".}
  ## @brief Returns the state of all hats of the specified joystick.
  ##
  ## This function returns the state of all hats of the specified joystick.
  ## Each element in the array is one of the following values:
  ##
  ## Name                   Value
  ## ----                   -----
  ## `GLFW_HAT_CENTERED`    0
  ## `GLFW_HAT_UP`          1
  ## `GLFW_HAT_RIGHT`       2
  ## `GLFW_HAT_DOWN`        4
  ## `GLFW_HAT_LEFT`        8
  ## `GLFW_HAT_RIGHT_UP`    `GLFW_HAT_RIGHT` \ `GLFW_HAT_UP`
  ## `GLFW_HAT_RIGHT_DOWN`  `GLFW_HAT_RIGHT` \ `GLFW_HAT_DOWN`
  ## `GLFW_HAT_LEFT_UP`     `GLFW_HAT_LEFT` \ `GLFW_HAT_UP`
  ## `GLFW_HAT_LEFT_DOWN`   `GLFW_HAT_LEFT` \ `GLFW_HAT_DOWN`
  ##
  ## The diagonal directions are bitwise combinations of the primary (up, right,
  ## down and left) directions and you can test for these individually by ANDing
  ## it with the corresponding direction.
  ##
  ## @code
  ## if (hats[2] & GLFW_HAT_RIGHT)
  ## {
  ##     // State of hat 2 could be right-up, right or right-down
  ## }
  ## @endcode
  ##
  ## If the specified joystick is not present this function will return `NULL`
  ## but will not generate an error.  This can be used instead of first calling
  ##  glfwJoystickPresent.
  ##
  ## @paramin jid The joystick to query.
  ## @param[out] count Where to store the number of hat states in the returned
  ## array.  This is set to zero if the joystick is not present or an error
  ## occurred.
  ## @return An array of hat states, or `NULL` if the joystick is not present
  ## or an error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM and  GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The returned array is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is valid until the specified joystick is
  ## disconnected, this function is called again for that joystick or the library
  ## is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  joystick_hat
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup input
proc glfwGetJoystickName*(jid: int32): cstring {.importc: "glfwGetJoystickName".}
  ## @brief Returns the name of the specified joystick.
  ##
  ## This function returns the name, encoded as UTF-8, of the specified joystick.
  ## The returned string is allocated and freed by GLFW.  You should not free it
  ## yourself.
  ##
  ## If the specified joystick is not present this function will return `NULL`
  ## but will not generate an error.  This can be used instead of first calling
  ##  glfwJoystickPresent.
  ##
  ## @paramin jid The joystick to query.
  ## @return The UTF-8 encoded name of the joystick, or `NULL` if the joystick
  ## is not present or an error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM and  GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The returned string is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is valid until the specified joystick is
  ## disconnected or the library is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  joystick_name
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup input
proc glfwGetJoystickGUID*(jid: int32): cstring {.importc: "glfwGetJoystickGUID".}
  ## @brief Returns the SDL compatible GUID of the specified joystick.
  ##
  ## This function returns the SDL compatible GUID, as a UTF-8 encoded
  ## hexadecimal string, of the specified joystick.  The returned string is
  ## allocated and freed by GLFW.  You should not free it yourself.
  ##
  ## The GUID is what connects a joystick to a gamepad mapping.  A connected
  ## joystick will always have a GUID even if there is no gamepad mapping
  ## assigned to it.
  ##
  ## If the specified joystick is not present this function will return `NULL`
  ## but will not generate an error.  This can be used instead of first calling
  ##  glfwJoystickPresent.
  ##
  ## The GUID uses the format introduced in SDL 2.0.5.  This GUID tries to
  ## uniquely identify the make and model of a joystick but does not identify
  ## a specific unit, e.g. all wired Xbox 360 controllers will have the same
  ## GUID on that platform.  The GUID for a unit may vary between platforms
  ## depending on what hardware information the platform specific APIs provide.
  ##
  ## @paramin jid The joystick to query.
  ## @return The UTF-8 encoded GUID of the joystick, or `NULL` if the joystick
  ## is not present or an error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_INVALID_ENUM and  GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The returned string is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is valid until the specified joystick is
  ## disconnected or the library is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  gamepad
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup input
proc glfwSetJoystickUserPointer*(jid: int32, pointer: pointer): void {.importc: "glfwSetJoystickUserPointer".}
  ## @brief Sets the user pointer of the specified joystick.
  ##
  ## This function sets the user-defined pointer of the specified joystick.  The
  ## current value is retained until the joystick is disconnected.  The initial
  ## value is `NULL`.
  ##
  ## This function may be called from the joystick callback, even for a joystick
  ## that is being disconnected.
  ##
  ## @param[in] jid The joystick whose pointer to set.
  ## @param[in] pointer The new value.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @sa  joystick_userptr
  ## @sa  glfwGetJoystickUserPointer
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup input
proc glfwGetJoystickUserPointer*(jid: int32): pointer {.importc: "glfwGetJoystickUserPointer".}
  ## @brief Returns the user pointer of the specified joystick.
  ##
  ## This function returns the current value of the user-defined pointer of the
  ## specified joystick.  The initial value is `NULL`.
  ##
  ## This function may be called from the joystick callback, even for a joystick
  ## that is being disconnected.
  ##
  ## @param[in] jid The joystick whose pointer to return.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @sa  joystick_userptr
  ## @sa  glfwSetJoystickUserPointer
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup input
proc glfwJoystickIsGamepad*(jid: int32): int32 {.importc: "glfwJoystickIsGamepad".}
  ## @brief Returns whether the specified joystick has a gamepad mapping.
  ##
  ## This function returns whether the specified joystick is both present and has
  ## a gamepad mapping.
  ##
  ## If the specified joystick is present but does not have a gamepad mapping
  ## this function will return `GLFW_FALSE` but will not generate an error.  Call
  ##  glfwJoystickPresent to check if a joystick is present regardless of
  ## whether it has a mapping.
  ##
  ## @paramin jid The joystick to query.
  ## @return `GLFW_TRUE` if a joystick is both present and has a gamepad mapping,
  ## or `GLFW_FALSE` otherwise.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_INVALID_ENUM.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  gamepad
  ## @sa  glfwGetGamepadState
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup input
proc glfwSetJoystickCallback*(callback: GLFWJoystickfun): GLFWJoystickfun {.importc: "glfwSetJoystickCallback".}
  ## @brief Sets the joystick configuration callback.
  ##
  ## This function sets the joystick configuration callback, or removes the
  ## currently set callback.  This is called when a joystick is connected to or
  ## disconnected from the system.
  ##
  ## For joystick connection and disconnection events to be delivered on all
  ## platforms, you need to call one of the event processing
  ## functions.  Joystick disconnection may also be detected and the callback
  ## called by joystick functions.  The function will then return whatever it
  ## returns if the joystick is not present.
  ##
  ## @param[in] callback The new callback, or `NULL` to remove the currently set
  ## callback.
  ## @return The previously set callback, or `NULL` if no callback was set or the
  ## library had not been initialized.
  ##
  ## @callback_signature
  ## @code
  ## void function_name(int jid, int event)
  ## @endcode
  ## For more information about the callback parameters, see the
  ## function pointer type.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  joystick_event
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup input
proc glfwUpdateGamepadMappings*(string: cstring): int32 {.importc: "glfwUpdateGamepadMappings".}
  ## @brief Adds the specified SDL_GameControllerDB gamepad mappings.
  ##
  ## This function parses the specified ASCII encoded string and updates the
  ## internal list with any gamepad mappings it finds.  This string may
  ## contain either a single gamepad mapping or many mappings separated by
  ## newlines.  The parser supports the full format of the `gamecontrollerdb.txt`
  ## source file including empty lines and comments.
  ##
  ## See  gamepad_mapping for a description of the format.
  ##
  ## If there is already a gamepad mapping for a given GUID in the internal list,
  ## it will be replaced by the one passed to this function.  If the library is
  ## terminated and re-initialized the internal list will revert to the built-in
  ## default.
  ##
  ## @param[in] string The string containing the gamepad mappings.
  ## @return `GLFW_TRUE` if successful, or `GLFW_FALSE` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_INVALID_VALUE.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  gamepad
  ## @sa  glfwJoystickIsGamepad
  ## @sa  glfwGetGamepadName
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup input
proc glfwGetGamepadName*(jid: int32): cstring {.importc: "glfwGetGamepadName".}
  ## @brief Returns the human-readable gamepad name for the specified joystick.
  ##
  ## This function returns the human-readable name of the gamepad from the
  ## gamepad mapping assigned to the specified joystick.
  ##
  ## If the specified joystick is not present or does not have a gamepad mapping
  ## this function will return `NULL` but will not generate an error.  Call
  ##  glfwJoystickPresent to check whether it is present regardless of
  ## whether it has a mapping.
  ##
  ## @paramin jid The joystick to query.
  ## @return The UTF-8 encoded name of the gamepad, or `NULL` if the
  ## joystick is not present, does not have a mapping or an
  ## error occurred.
  ##
  ## @pointer_lifetime The returned string is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is valid until the specified joystick is
  ## disconnected, the gamepad mappings are updated or the library is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  gamepad
  ## @sa  glfwJoystickIsGamepad
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup input
proc glfwGetGamepadState*(jid: int32, state: ptr GLFWGamepadstate): int32 {.importc: "glfwGetGamepadState".}
  ## @brief Retrieves the state of the specified joystick remapped as a gamepad.
  ##
  ## This function retrieves the state of the specified joystick remapped to
  ## an Xbox-like gamepad.
  ##
  ## If the specified joystick is not present or does not have a gamepad mapping
  ## this function will return `GLFW_FALSE` but will not generate an error.  Call
  ##  glfwJoystickPresent to check whether it is present regardless of
  ## whether it has a mapping.
  ##
  ## The Guide button may not be available for input as it is often hooked by the
  ## system or the Steam client.
  ##
  ## Not all devices have all the buttons or axes provided by
  ## GLFWgamepadstate.  Unavailable buttons and axes will always report
  ## `GLFW_RELEASE` and 0.0 respectively.
  ##
  ## @paramin jid The joystick to query.
  ## @param[out] state The gamepad input state of the joystick.
  ## @return `GLFW_TRUE` if successful, or `GLFW_FALSE` if no joystick is
  ## connected, it has no gamepad mapping or an error
  ## occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_INVALID_ENUM.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  gamepad
  ## @sa  glfwUpdateGamepadMappings
  ## @sa  glfwJoystickIsGamepad
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup input
proc setClipboardString*(window: GLFWWindow, string: cstring): void {.importc: "glfwSetClipboardString".}
  ## @brief Sets the clipboard to the specified string.
  ##
  ## This function sets the system clipboard to the specified, UTF-8 encoded
  ## string.
  ##
  ## @param[in] window Deprecated.  Any valid window or `NULL`.
  ## @param[in] string A UTF-8 encoded string.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The specified string is copied before this function
  ## returns.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  clipboard
  ## @sa  glfwGetClipboardString
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup input
proc getClipboardString*(window: GLFWWindow): cstring {.importc: "glfwGetClipboardString".}
  ## @brief Returns the contents of the clipboard as a string.
  ##
  ## This function returns the contents of the system clipboard, if it contains
  ## or is convertible to a UTF-8 encoded string.  If the clipboard is empty or
  ## if its contents cannot be converted, `NULL` is returned and a
  ## GLFW_FORMAT_UNAVAILABLE error is generated.
  ##
  ## @param[in] window Deprecated.  Any valid window or `NULL`.
  ## @return The contents of the clipboard as a UTF-8 encoded string, or `NULL`
  ## if an error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The returned string is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is valid until the next call to
  ## glfwGetClipboardString or  glfwSetClipboardString, or until the library
  ## is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  clipboard
  ## @sa  glfwSetClipboardString
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup input
proc glfwGetTime*(): float64 {.importc: "glfwGetTime".}
  ## @brief Returns the GLFW time.
  ##
  ## This function returns the current GLFW time, in seconds.  Unless the time
  ## has been set using  glfwSetTime it measures time elapsed since GLFW was
  ## initialized.
  ##
  ## This function and  glfwSetTime are helper functions on top of
  ## glfwGetTimerFrequency and  glfwGetTimerValue.
  ##
  ## The resolution of the timer is system dependent, but is usually on the order
  ## of a few micro- or nanoseconds.  It uses the highest-resolution monotonic
  ## time source on each supported platform.
  ##
  ## @return The current time, in seconds, or zero if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.  Reading and
  ## writing of the internal base time is not atomic, so it needs to be
  ## externally synchronized with calls to  glfwSetTime.
  ##
  ## @sa  time
  ##
  ## @since Added in version 1.0.
  ##
  ## @ingroup input
proc glfwSetTime*(time: float64): void {.importc: "glfwSetTime".}
  ## @brief Sets the GLFW time.
  ##
  ## This function sets the current GLFW time, in seconds.  The value must be
  ## a positive finite number less than or equal to 18446744073.0, which is
  ## approximately 584.5 years.
  ##
  ## This function and  glfwGetTime are helper functions on top of
  ## glfwGetTimerFrequency and  glfwGetTimerValue.
  ##
  ## @param[in] time The new value, in seconds.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_INVALID_VALUE.
  ##
  ## @remark The upper limit of GLFW time is calculated as
  ## floor((2<sup>64</sup> - 1) / 10<sup>9</sup>) and is due to implementations
  ## storing nanoseconds in 64 bits.  The limit may be increased in the future.
  ##
  ## @thread_safety This function may be called from any thread.  Reading and
  ## writing of the internal base time is not atomic, so it needs to be
  ## externally synchronized with calls to  glfwGetTime.
  ##
  ## @sa  time
  ##
  ## @since Added in version 2.2.
  ##
  ## @ingroup input
proc glfwGetTimerValue*(): uint64 {.importc: "glfwGetTimerValue".}
  ## @brief Returns the current value of the raw timer.
  ##
  ## This function returns the current value of the raw timer, measured in
  ## 1&nbsp;/&nbsp;frequency seconds.  To get the frequency, call
  ## glfwGetTimerFrequency.
  ##
  ## @return The value of the timer, or zero if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  time
  ## @sa  glfwGetTimerFrequency
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup input
proc glfwGetTimerFrequency*(): uint64 {.importc: "glfwGetTimerFrequency".}
  ## @brief Returns the frequency, in Hz, of the raw timer.
  ##
  ## This function returns the frequency, in Hz, of the raw timer.
  ##
  ## @return The frequency of the timer, in Hz, or zero if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  time
  ## @sa  glfwGetTimerValue
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup input
proc makeContextCurrent*(window: GLFWWindow): void {.importc: "glfwMakeContextCurrent".}
  ## @brief Makes the context of the specified window current for the calling
  ## thread.
  ##
  ## This function makes the OpenGL or OpenGL ES context of the specified window
  ## current on the calling thread.  A context must only be made current on
  ## a single thread at a time and each thread can have only a single current
  ## context at a time.
  ##
  ## When moving a context between threads, you must make it non-current on the
  ## old thread before making it current on the new one.
  ##
  ## By default, making a context non-current implicitly forces a pipeline flush.
  ## On machines that support `GL_KHR_context_flush_control`, you can control
  ## whether a context performs this flush by setting the
  ## GLFW_CONTEXT_RELEASE_BEHAVIOR
  ## hint.
  ##
  ## The specified window must have an OpenGL or OpenGL ES context.  Specifying
  ## a window without a context will generate a  GLFW_NO_WINDOW_CONTEXT
  ## error.
  ##
  ## @param[in] window The window whose context to make current, or `NULL` to
  ## detach the current context.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_NO_WINDOW_CONTEXT and  GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  context_current
  ## @sa  glfwGetCurrentContext
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup context
proc glfwGetCurrentContext*(): GLFWWindow {.importc: "glfwGetCurrentContext".}
  ## @brief Returns the window whose context is current on the calling thread.
  ##
  ## This function returns the window whose OpenGL or OpenGL ES context is
  ## current on the calling thread.
  ##
  ## @return The window whose context is current, or `NULL` if no window's
  ## context is current.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  context_current
  ## @sa  glfwMakeContextCurrent
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup context
proc swapBuffers*(window: GLFWWindow): void {.importc: "glfwSwapBuffers".}
  ## @brief Swaps the front and back buffers of the specified window.
  ##
  ## This function swaps the front and back buffers of the specified window when
  ## rendering with OpenGL or OpenGL ES.  If the swap interval is greater than
  ## zero, the GPU driver waits the specified number of screen updates before
  ## swapping the buffers.
  ##
  ## The specified window must have an OpenGL or OpenGL ES context.  Specifying
  ## a window without a context will generate a  GLFW_NO_WINDOW_CONTEXT
  ## error.
  ##
  ## This function does not apply to Vulkan.  If you are rendering with Vulkan,
  ## see `vkQueuePresentKHR` instead.
  ##
  ## @param[in] window The window whose buffers to swap.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_NO_WINDOW_CONTEXT and  GLFW_PLATFORM_ERROR.
  ##
  ## @remark __EGL:__ The context of the specified window must be current on the
  ## calling thread.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  buffer_swap
  ## @sa  glfwSwapInterval
  ##
  ## @since Added in version 1.0.
  ## @glfw3 Added window handle parameter.
  ##
  ## @ingroup window
proc glfwSwapInterval*(interval: int32): void {.importc: "glfwSwapInterval".}
  ## @brief Sets the swap interval for the current context.
  ##
  ## This function sets the swap interval for the current OpenGL or OpenGL ES
  ## context, i.e. the number of screen updates to wait from the time
  ## glfwSwapBuffers was called before swapping the buffers and returning.  This
  ## is sometimes called _vertical synchronization_, _vertical retrace
  ## synchronization_ or just _vsync_.
  ##
  ## A context that supports either of the `WGL_EXT_swap_control_tear` and
  ## `GLX_EXT_swap_control_tear` extensions also accepts _negative_ swap
  ## intervals, which allows the driver to swap immediately even if a frame
  ## arrives a little bit late.  You can check for these extensions with
  ## glfwExtensionSupported.
  ##
  ## A context must be current on the calling thread.  Calling this function
  ## without a current context will cause a  GLFW_NO_CURRENT_CONTEXT error.
  ##
  ## This function does not apply to Vulkan.  If you are rendering with Vulkan,
  ## see the present mode of your swapchain instead.
  ##
  ## @param[in] interval The minimum number of screen updates to wait for
  ## until the buffers are swapped by  glfwSwapBuffers.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_NO_CURRENT_CONTEXT and  GLFW_PLATFORM_ERROR.
  ##
  ## @remark This function is not called during context creation, leaving the
  ## swap interval set to whatever is the default on that platform.  This is done
  ## because some swap interval extensions used by GLFW do not allow the swap
  ## interval to be reset to zero once it has been set to a non-zero value.
  ##
  ## @remark Some GPU drivers do not honor the requested swap interval, either
  ## because of a user setting that overrides the application's request or due to
  ## bugs in the driver.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  buffer_swap
  ## @sa  glfwSwapBuffers
  ##
  ## @since Added in version 1.0.
  ##
  ## @ingroup context
proc glfwExtensionSupported*(extension: cstring): int32 {.importc: "glfwExtensionSupported".}
  ## @brief Returns whether the specified extension is available.
  ##
  ## This function returns whether the specified
  ## API extension is supported by the current OpenGL or
  ## OpenGL ES context.  It searches both for client API extension and context
  ## creation API extensions.
  ##
  ## A context must be current on the calling thread.  Calling this function
  ## without a current context will cause a  GLFW_NO_CURRENT_CONTEXT error.
  ##
  ## As this functions retrieves and searches one or more extension strings each
  ## call, it is recommended that you cache its results if it is going to be used
  ## frequently.  The extension strings will not change during the lifetime of
  ## a context, so there is no danger in doing this.
  ##
  ## This function does not apply to Vulkan.  If you are using Vulkan, see
  ## glfwGetRequiredInstanceExtensions, `vkEnumerateInstanceExtensionProperties`
  ## and `vkEnumerateDeviceExtensionProperties` instead.
  ##
  ## @param[in] extension The ASCII encoded name of the extension.
  ## @return `GLFW_TRUE` if the extension is available, or `GLFW_FALSE`
  ## otherwise.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_NO_CURRENT_CONTEXT,  GLFW_INVALID_VALUE and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  context_glext
  ## @sa  glfwGetProcAddress
  ##
  ## @since Added in version 1.0.
  ##
  ## @ingroup context
proc glfwGetProcAddress*(procname: cstring): GLFWGlproc {.importc: "glfwGetProcAddress".}
  ## @brief Returns the address of the specified function for the current
  ## context.
  ##
  ## This function returns the address of the specified OpenGL or OpenGL ES
  ## core or extension function, if it is supported
  ## by the current context.
  ##
  ## A context must be current on the calling thread.  Calling this function
  ## without a current context will cause a  GLFW_NO_CURRENT_CONTEXT error.
  ##
  ## This function does not apply to Vulkan.  If you are rendering with Vulkan,
  ## see  glfwGetInstanceProcAddress, `vkGetInstanceProcAddr` and
  ## `vkGetDeviceProcAddr` instead.
  ##
  ## @param[in] procname The ASCII encoded name of the function.
  ## @return The address of the function, or `NULL` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
  ## GLFW_NO_CURRENT_CONTEXT and  GLFW_PLATFORM_ERROR.
  ##
  ## @remark The address of a given function is not guaranteed to be the same
  ## between contexts.
  ##
  ## @remark This function may return a non-`NULL` address despite the
  ## associated version or extension not being available.  Always check the
  ## context version or extension string first.
  ##
  ## @pointer_lifetime The returned function pointer is valid until the context
  ## is destroyed or the library is terminated.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  context_glext
  ## @sa  glfwExtensionSupported
  ##
  ## @since Added in version 1.0.
  ##
  ## @ingroup context
proc glfwVulkanSupported*(): bool {.importc: "glfwVulkanSupported".}
  ## @brief Returns whether the Vulkan loader and an ICD have been found.
  ##
  ## This function returns whether the Vulkan loader and any minimally functional
  ## ICD have been found.
  ##
  ## The availability of a Vulkan loader and even an ICD does not by itself
  ## guarantee that surface creation or even instance creation is possible.
  ## For example, on Fermi systems Nvidia will install an ICD that provides no
  ## actual Vulkan support.  Call  glfwGetRequiredInstanceExtensions to check
  ## whether the extensions necessary for Vulkan surface creation are available
  ## and  glfwGetPhysicalDevicePresentationSupport to check whether a queue
  ## family of a physical device supports image presentation.
  ##
  ## @return `GLFW_TRUE` if Vulkan is minimally available, or `GLFW_FALSE`
  ## otherwise.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  vulkan_support
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup vulkan
proc glfwGetRequiredInstanceExtensions*(count: ptr uint32): cstringArray {.importc: "glfwGetRequiredInstanceExtensions".}
  ## @brief Returns the Vulkan instance extensions required by GLFW.
  ##
  ## This function returns an array of names of Vulkan instance extensions required
  ## by GLFW for creating Vulkan surfaces for GLFW windows.  If successful, the
  ## list will always contain `VK_KHR_surface`, so if you don't require any
  ## additional extensions you can pass this list directly to the
  ## `VkInstanceCreateInfo` struct.
  ##
  ## If Vulkan is not available on the machine, this function returns `NULL` and
  ## generates a  GLFW_API_UNAVAILABLE error.  Call  glfwVulkanSupported
  ## to check whether Vulkan is at least minimally available.
  ##
  ## If Vulkan is available but no set of extensions allowing window surface
  ## creation was found, this function returns `NULL`.  You may still use Vulkan
  ## for off-screen rendering and compute work.
  ##
  ## @param[out] count Where to store the number of extensions in the returned
  ## array.  This is set to zero if an error occurred.
  ## @return An array of ASCII encoded extension names, or `NULL` if an
  ## error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_API_UNAVAILABLE.
  ##
  ## @remark Additional extensions may be required by future versions of GLFW.
  ## You should check if any extensions you wish to enable are already in the
  ## returned array, as it is an error to specify an extension more than once in
  ## the `VkInstanceCreateInfo` struct.
  ##
  ## @remark @macos GLFW currently supports both the `VK_MVK_macos_surface` and
  ## the newer `VK_EXT_metal_surface` extensions.
  ##
  ## @pointer_lifetime The returned array is allocated and freed by GLFW.  You
  ## should not free it yourself.  It is guaranteed to be valid only until the
  ## library is terminated.
  ##
  ## @thread_safety This function may be called from any thread.
  ##
  ## @sa  vulkan_ext
  ## @sa  glfwCreateWindowSurface
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup vulkan
when defined(vulkan):
  proc glfwGetInstanceProcAddress*(instance: VkInstance, procname: cstring): GLFWVkproc {.importc: "glfwGetInstanceProcAddress".}
    ## @brief Returns the address of the specified Vulkan instance function.
    ##
    ## This function returns the address of the specified Vulkan core or extension
    ## function for the specified instance.  If instance is set to `NULL` it can
    ## return any function exported from the Vulkan loader, including at least the
    ## following functions:
    ##
    ## - `vkEnumerateInstanceExtensionProperties`
    ## - `vkEnumerateInstanceLayerProperties`
    ## - `vkCreateInstance`
    ## - `vkGetInstanceProcAddr`
    ##
    ## If Vulkan is not available on the machine, this function returns `NULL` and
    ## generates a  GLFW_API_UNAVAILABLE error.  Call  glfwVulkanSupported
    ## to check whether Vulkan is at least minimally available.
    ##
    ## This function is equivalent to calling `vkGetInstanceProcAddr` with
    ## a platform-specific query of the Vulkan loader as a fallback.
    ##
    ## @param[in] instance The Vulkan instance to query, or `NULL` to retrieve
    ## functions related to instance creation.
    ## @param[in] procname The ASCII encoded name of the function.
    ## @return The address of the function, or `NULL` if an
    ## error occurred.
    ##
    ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
    ## GLFW_API_UNAVAILABLE.
    ##
    ## @pointer_lifetime The returned function pointer is valid until the library
    ## is terminated.
    ##
    ## @thread_safety This function may be called from any thread.
    ##
    ## @sa  vulkan_proc
    ##
    ## @since Added in version 3.2.
    ##
    ## @ingroup vulkan

when defined(vulkan):
  proc glfwGetPhysicalDevicePresentationSupport*(instance: VkInstance, device: VkPhysicalDevice, queuefamily: uint32): int32 {.importc: "glfwGetPhysicalDevicePresentationSupport".}
    ## @brief Returns whether the specified queue family can present images.
    ##
    ## This function returns whether the specified queue family of the specified
    ## physical device supports presentation to the platform GLFW was built for.
    ##
    ## If Vulkan or the required window surface creation instance extensions are
    ## not available on the machine, or if the specified instance was not created
    ## with the required extensions, this function returns `GLFW_FALSE` and
    ## generates a  GLFW_API_UNAVAILABLE error.  Call  glfwVulkanSupported
    ## to check whether Vulkan is at least minimally available and
    ## glfwGetRequiredInstanceExtensions to check what instance extensions are
    ## required.
    ##
    ## @param[in] instance The instance that the physical device belongs to.
    ## @param[in] device The physical device that the queue family belongs to.
    ## @param[in] queuefamily The index of the queue family to query.
    ## @return `GLFW_TRUE` if the queue family supports presentation, or
    ## `GLFW_FALSE` otherwise.
    ##
    ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
    ## GLFW_API_UNAVAILABLE and  GLFW_PLATFORM_ERROR.
    ##
    ## @remark @macos This function currently always returns `GLFW_TRUE`, as the
    ## `VK_MVK_macos_surface` and `VK_EXT_metal_surface` extensions do not provide
    ## a `vkGetPhysicalDevice*PresentationSupport` type function.
    ##
    ## @thread_safety This function may be called from any thread.  For
    ## synchronization details of Vulkan objects, see the Vulkan specification.
    ##
    ## @sa  vulkan_present
    ##
    ## @since Added in version 3.2.
    ##
    ## @ingroup vulkan

when defined(vulkan):
  proc glfwCreateWindowSurface*(instance: VkInstance, window: GLFWWindow, allocator: ptr VkAllocationCallbacks, surface: ptr VkSurfaceKHR): VkResult {.importc: "glfwCreateWindowSurface".}
    ## @brief Creates a Vulkan surface for the specified window.
    ##
    ## This function creates a Vulkan surface for the specified window.
    ##
    ## If the Vulkan loader or at least one minimally functional ICD were not found,
    ## this function returns `VK_ERROR_INITIALIZATION_FAILED` and generates a
    ## GLFW_API_UNAVAILABLE error.  Call  glfwVulkanSupported to check whether
    ## Vulkan is at least minimally available.
    ##
    ## If the required window surface creation instance extensions are not
    ## available or if the specified instance was not created with these extensions
    ## enabled, this function returns `VK_ERROR_EXTENSION_NOT_PRESENT` and
    ## generates a  GLFW_API_UNAVAILABLE error.  Call
    ## glfwGetRequiredInstanceExtensions to check what instance extensions are
    ## required.
    ##
    ## The window surface cannot be shared with another API so the window must
    ## have been created with the client api hint
    ## set to `GLFW_NO_API` otherwise it generates a  GLFW_INVALID_VALUE error
    ## and returns `VK_ERROR_NATIVE_WINDOW_IN_USE_KHR`.
    ##
    ## The window surface must be destroyed before the specified Vulkan instance.
    ## It is the responsibility of the caller to destroy the window surface.  GLFW
    ## does not destroy it for you.  Call `vkDestroySurfaceKHR` to destroy the
    ## surface.
    ##
    ## @param[in] instance The Vulkan instance to create the surface in.
    ## @param[in] window The window to create the surface for.
    ## @param[in] allocator The allocator to use, or `NULL` to use the default
    ## allocator.
    ## @param[out] surface Where to store the handle of the surface.  This is set
    ## to `VK_NULL_HANDLE` if an error occurred.
    ## @return `VK_SUCCESS` if successful, or a Vulkan error code if an
    ## error occurred.
    ##
    ## @errors Possible errors include  GLFW_NOT_INITIALIZED,
    ## GLFW_API_UNAVAILABLE,  GLFW_PLATFORM_ERROR and  GLFW_INVALID_VALUE
    ##
    ## @remark If an error occurs before the creation call is made, GLFW returns
    ## the Vulkan error code most appropriate for the error.  Appropriate use of
    ##  glfwVulkanSupported and  glfwGetRequiredInstanceExtensions should
    ## eliminate almost all occurrences of these errors.
    ##
    ## @remark @macos This function currently only supports the
    ## `VK_MVK_macos_surface` extension from MoltenVK.
    ##
    ## @remark @macos This function creates and sets a `CAMetalLayer` instance for
    ## the window content view, which is required for MoltenVK to function.
    ##
    ## @remark @x11 GLFW by default attempts to use the `VK_KHR_xcb_surface`
    ## extension, if available.  You can make it prefer the `VK_KHR_xlib_surface`
    ## extension by setting the
    ## GLFW_X11_XCB_VULKAN_SURFACE init
    ## hint.
    ##
    ## @thread_safety This function may be called from any thread.  For
    ## synchronization details of Vulkan objects, see the Vulkan specification.
    ##
    ## @sa  vulkan_surface
    ## @sa  glfwGetRequiredInstanceExtensions
    ##
    ## @since Added in version 3.2.
    ##
    ## @ingroup vulkan


{.pop.}

proc glfwCreateWindow*(width: int32, height: int32, title: cstring = "NimGL", monitor: GLFWMonitor = nil, share: GLFWWindow = nil, icon: bool = true): GLFWWindow =
  ## Creates a window and its associated OpenGL or OpenGL ES
  ## Utility to create the window with a proper icon.
  result = glfwCreateWindowC(width, height, title, monitor, share)
  if not icon: return result
  var image = GLFWImage(pixels: cast[ptr cuchar](nimglLogo[0].addr), width: nimglLogoWidth, height: nimglLogoHeight)
  result.setWindowIcon(1, image.addr)
