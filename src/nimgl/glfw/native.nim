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
##
##  **By using the native access functions you assert that you know what you're
##  doing and how to fix problems caused by using them.  If you don't, you
##  shouldn't be using them.**
##
##  Please assert that you are using the right system for the right procedures.

import ../glfw

when defined(glfwDLL):
  when defined(windows):
    const glfw_dll* = "glfw3.dll"
  elif defined(macosx):
    const glfw_dll* = "libglfw3.dylib"
  else:
    const glfw_dll* = "libglfw.so.3"

when defined(windows):
  {.passC: "-DGLFW_EXPOSE_NATIVE_WIN32".}
  if not defined(vulkan):
    {.passC: "-DGLFW_EXPOSE_NATIVE_WGL".}
elif defined(macosx):
  {.passC: "-DGLFW_EXPOSE_NATIVE_COCOA".}
  if not defined(vulkan):
    {.passC: "-DGLFW_EXPOSE_NATIVE_NSGL".}
else:
  if defined(wayland):
    {.passC: "-DGLFW_EXPOSE_NATIVE_WAYLAND".}
  else:
    {.passC: "-DGLFW_EXPOSE_NATIVE_X11".}

  if defined(mesa):
    {.passC: "-DGLFW_EXPOSE_NATIVE_OSMESA".}
  elif defined(egl):
    {.passC: "-DGLFW_EXPOSE_NATIVE_EGL".}
  elif not defined(vulkan):
    {.passC: "-DGLFW_EXPOSE_NATIVE_GLX".}

# Procs
when defined(glfwDLL):
  {.push dynlib: glfw_dll, cdecl.}
else:
  {.push cdecl.}

proc getWin32Adapter*(monitor: GLFWMonitor): cstring {.importc: "glfwGetWin32Adapter".}
  ## @brief Returns the adapter device name of the specified monitor.
  ##
  ## @return The UTF-8 encoded adapter device name (for example `\\.\DISPLAY1`)
  ## of the specified monitor, or `NULL` if an error
  ## occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup native
proc getWin32Monitor*(monitor: GLFWMonitor): cstring {.importc: "glfwGetWin32Monitor".}
  ## @brief Returns the display device name of the specified monitor.
  ##
  ## @return The UTF-8 encoded display device name (for example
  ## `\\.\DISPLAY1\Monitor0`) of the specified monitor, or `NULL` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup native
proc getWin32Window*(window: GLFWWindow): pointer #[HWND]# {.importc: "glfwGetWin32Window".}
  ## @brief Returns the `HWND` of the specified window.
  ##
  ## @return The `HWND` of the specified window, or `NULL` if an
  ## error occurred.
  ##
  ## @remark The `HDC` associated with the window can be queried with the
  ## [GetDC](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getdc)
  ## function.
  ## @code
  ## HDC dc = GetDC(glfwGetWin32Window(window));
  ## @endcode
  ## This DC is private and does not need to be released.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup native
proc getWGLContext*(window: GLFWWindow): pointer #[HGLRC]# {.importc: "glfwGetWGLContext".}
  ## @brief Returns the `HGLRC` of the specified window.
  ##
  ## @return The `HGLRC` of the specified window, or `NULL` if an
  ## error occurred.
  ##
  ## @remark The `HDC` associated with the window can be queried with the
  ## [GetDC](https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getdc)
  ## function.
  ## @code
  ## HDC dc = GetDC(glfwGetWin32Window(window));
  ## @endcode
  ## This DC is private and does not need to be released.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup native
proc getCocoaMonitor*(monitor: GLFWMonitor): pointer #[CGDirectDisplayID]# {.importc: "glfwGetCocoaMonitor".}
  ## @brief Returns the `CGDirectDisplayID` of the specified monitor.
  ##
  ## @return The `CGDirectDisplayID` of the specified monitor, or
  ## `kCGNullDirectDisplay` if an error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup native
proc getCocoaWindow*(window: GLFWWindow): pointer #[id]# {.importc: "glfwGetCocoaWindow".}
  ## @brief Returns the `NSWindow` of the specified window.
  ##
  ## @return The `NSWindow` of the specified window, or `nil` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup native
proc getNSGLContext*(window: GLFWWindow): pointer #[id]# {.importc: "glfwGetNSGLContext".}
  ## @brief Returns the `NSOpenGLContext` of the specified window.
  ##
  ## @return The `NSOpenGLContext` of the specified window, or `nil` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup native
proc glfwGetX11Display*(): pointer #[Display]# {.importc: "glfwGetX11Display".}
  ## @brief Returns the `Display` used by GLFW.
  ##
  ## @return The `Display` used by GLFW, or `NULL` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup native
proc getX11Adapter*(monitor: GLFWMonitor): pointer #[RRCrtc]# {.importc: "glfwGetX11Adapter".}
  ## @brief Returns the `RRCrtc` of the specified monitor.
  ##
  ## @return The `RRCrtc` of the specified monitor, or `None` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup native
proc getX11Monitor*(monitor: GLFWMonitor): pointer #[RROutput]# {.importc: "glfwGetX11Monitor".}
  ## @brief Returns the `RROutput` of the specified monitor.
  ##
  ## @return The `RROutput` of the specified monitor, or `None` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.1.
  ##
  ## @ingroup native
proc getX11Window*(window: GLFWWindow): pointer #[Window]# {.importc: "glfwGetX11Window".}
  ## @brief Returns the `Window` of the specified window.
  ##
  ## @return The `Window` of the specified window, or `None` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup native
proc glfwSetX11SelectionString*(string: cstring): void {.importc: "glfwSetX11SelectionString".}
  ## @brief Sets the current primary selection to the specified string.
  ##
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
  ## @sa glfwGetX11SelectionString
  ## @sa glfwSetClipboardString
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup native
proc glfwGetX11SelectionString*(): cstring {.importc: "glfwGetX11SelectionString".}
  ## @brief Returns the contents of the current primary selection as a string.
  ##
  ## If the selection is empty or if its contents cannot be converted, `NULL`
  ## is returned and a  GLFW_FORMAT_UNAVAILABLE error is generated.
  ##
  ## @return The contents of the selection as a UTF-8 encoded string, or `NULL`
  ## if an error occurred.
  ##
  ## @errors Possible errors include  GLFW_NOT_INITIALIZED and
  ## GLFW_PLATFORM_ERROR.
  ##
  ## @pointer_lifetime The returned string is allocated and freed by GLFW. You
  ## should not free it yourself. It is valid until the next call to
  ## glfwGetX11SelectionString or  glfwSetX11SelectionString, or until the
  ## library is terminated.
  ##
  ## @thread_safety This function must only be called from the main thread.
  ##
  ## @sa  clipboard
  ## @sa glfwSetX11SelectionString
  ## @sa glfwGetClipboardString
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup native
proc getGLXContext*(window: GLFWWindow): pointer #[GLXContext]# {.importc: "glfwGetGLXContext".}
  ## @brief Returns the `GLXContext` of the specified window.
  ##
  ## @return The `GLXContext` of the specified window, or `NULL` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup native
proc getGLXWindow*(window: GLFWWindow): pointer #[GLXWindow]# {.importc: "glfwGetGLXWindow".}
  ## @brief Returns the `GLXWindow` of the specified window.
  ##
  ## @return The `GLXWindow` of the specified window, or `None` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup native
proc getWaylandDisplay*(): pointer #[struct]# {.importc: "glfwGetWaylandDisplay".}
  ## @brief Returns the `struct wl_display*` used by GLFW.
  ##
  ## @return The `struct wl_display*` used by GLFW, or `NULL` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup native
proc getWaylandMonitor*(monitor: GLFWMonitor): pointer #[struct]# {.importc: "glfwGetWaylandMonitor".}
  ## @brief Returns the `struct wl_output*` of the specified monitor.
  ##
  ## @return The `struct wl_output*` of the specified monitor, or `NULL` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup native
proc getWaylandWindow*(window: GLFWWindow): pointer #[struct]# {.importc: "glfwGetWaylandWindow".}
  ## @brief Returns the main `struct wl_surface*` of the specified window.
  ##
  ## @return The main `struct wl_surface*` of the specified window, or `NULL` if
  ## an error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.2.
  ##
  ## @ingroup native
proc glfwGetEGLDisplay*(): pointer #[EGLDisplay]# {.importc: "glfwGetEGLDisplay".}
  ## @brief Returns the `EGLDisplay` used by GLFW.
  ##
  ## @return The `EGLDisplay` used by GLFW, or `EGL_NO_DISPLAY` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup native
proc getEGLContext*(window: GLFWWindow): pointer #[EGLContext]# {.importc: "glfwGetEGLContext".}
  ## @brief Returns the `EGLContext` of the specified window.
  ##
  ## @return The `EGLContext` of the specified window, or `EGL_NO_CONTEXT` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup native
proc getEGLSurface*(window: GLFWWindow): pointer #[EGLSurface]# {.importc: "glfwGetEGLSurface".}
  ## @brief Returns the `EGLSurface` of the specified window.
  ##
  ## @return The `EGLSurface` of the specified window, or `EGL_NO_SURFACE` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.0.
  ##
  ## @ingroup native
proc getOSMesaColorBuffer*(window: GLFWWindow, width: ptr int32, height: ptr int32, format: ptr int32, buffer: ptr pointer): int32 {.importc: "glfwGetOSMesaColorBuffer".}
  ## @brief Retrieves the color buffer associated with the specified window.
  ##
  ## @param[in] window The window whose color buffer to retrieve.
  ## @param[out] width Where to store the width of the color buffer, or `NULL`.
  ## @param[out] height Where to store the height of the color buffer, or `NULL`.
  ## @param[out] format Where to store the OSMesa pixel format of the color
  ## buffer, or `NULL`.
  ## @param[out] buffer Where to store the address of the color buffer, or
  ## `NULL`.
  ## @return `GLFW_TRUE` if successful, or `GLFW_FALSE` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup native
proc getOSMesaDepthBuffer*(window: GLFWWindow, width: ptr int32, height: ptr int32, bytesPerValue: ptr int32, buffer: ptr pointer): int32 {.importc: "glfwGetOSMesaDepthBuffer".}
  ## @brief Retrieves the depth buffer associated with the specified window.
  ##
  ## @param[in] window The window whose depth buffer to retrieve.
  ## @param[out] width Where to store the width of the depth buffer, or `NULL`.
  ## @param[out] height Where to store the height of the depth buffer, or `NULL`.
  ## @param[out] bytesPerValue Where to store the number of bytes per depth
  ## buffer element, or `NULL`.
  ## @param[out] buffer Where to store the address of the depth buffer, or
  ## `NULL`.
  ## @return `GLFW_TRUE` if successful, or `GLFW_FALSE` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup native
proc getOSMesaContext*(window: GLFWWindow): pointer #[OSMesaContext]# {.importc: "glfwGetOSMesaContext".}
  ## @brief Returns the `OSMesaContext` of the specified window.
  ##
  ## @return The `OSMesaContext` of the specified window, or `NULL` if an
  ## error occurred.
  ##
  ## @thread_safety This function may be called from any thread.  Access is not
  ## synchronized.
  ##
  ## @since Added in version 3.3.
  ##
  ## @ingroup native

{.pop.}
