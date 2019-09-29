# Copyright 2019, NimGL contributors.

## ImGUI Bindings
## ====
## WARNING: This is a generated file. Do not edit
## Any edits will be overwritten by the genearator.
##
## The aim is to achieve as much compatibility with C as possible.
## Optional helper functions have been created as a submodule
## ``imgui/imgui_helpers`` to better bind this library to Nim.
##
## You can check the original documentation `here <https://github.com/ocornut/imgui/blob/master/imgui.cpp>`_.
##
## Source language of ImGui is C++, since Nim is able to compile both to C
## and C++ you can select which compile target you wish to use. Note that to use
## the C backend you must supply a `cimgui <https://github.com/cimgui/cimgui>`_
## dynamic library file.
##
## HACK: If you are targeting Windows, be sure to compile the cimgui dll with
## visual studio and not with mingw.

import strutils

proc currentSourceDir(): string {.compileTime.} =
  result = currentSourcePath().replace("\\", "/")
  result = result[0 ..< result.rfind("/")]

{.passc: "-I" & currentSourceDir() & "/private/cimgui" & " -DIMGUI_DISABLE_OBSOLETE_FUNCTIONS=1".}

when not defined(cpp) or defined(cimguiDll):
  when defined(windows):
    const imguiDll* = "cimgui.dll"
  elif defined(macosx):
    const imguiDll* = "cimgui.dylib"
  else:
    const imguiDll* = "cimgui.so"
  {.passc: "-DCIMGUI_DEFINE_ENUMS_AND_STRUCTS".}
  {.pragma: imgui_header, header: "cimgui.h".}
else:
  {.compile: "private/cimgui/cimgui.cpp",
    compile: "private/cimgui/imgui/imgui.cpp",
    compile: "private/cimgui/imgui/imgui_draw.cpp",
    compile: "private/cimgui/imgui/imgui_demo.cpp",
    compile: "private/cimgui/imgui/imgui_widgets.cpp".}
  {.pragma: imgui_header, header: "../ncimgui.h".}

# Enums
type
  ImDrawCornerFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    TopLeft = 1
    TopRight = 2
    Top = 3
    BotLeft = 4
    Left = 5
    BotRight = 8
    Right = 10
    Bot = 12
    All = 15
  ImDrawListFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    AntiAliasedLines = 1
    AntiAliasedFill = 2
    AllowVtxOffset = 4
  ImFontAtlasFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoPowerOfTwoHeight = 1
    NoMouseCursors = 2
  ImGuiBackendFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    HasGamepad = 1
    HasMouseCursors = 2
    HasSetMousePos = 4
    RendererHasVtxOffset = 8
  ImGuiCol* {.pure, size: int32.sizeof.} = enum
    Text = 0
    TextDisabled = 1
    WindowBg = 2
    ChildBg = 3
    PopupBg = 4
    Border = 5
    BorderShadow = 6
    FrameBg = 7
    FrameBgHovered = 8
    FrameBgActive = 9
    TitleBg = 10
    TitleBgActive = 11
    TitleBgCollapsed = 12
    MenuBarBg = 13
    ScrollbarBg = 14
    ScrollbarGrab = 15
    ScrollbarGrabHovered = 16
    ScrollbarGrabActive = 17
    CheckMark = 18
    SliderGrab = 19
    SliderGrabActive = 20
    Button = 21
    ButtonHovered = 22
    ButtonActive = 23
    Header = 24
    HeaderHovered = 25
    HeaderActive = 26
    Separator = 27
    SeparatorHovered = 28
    SeparatorActive = 29
    ResizeGrip = 30
    ResizeGripHovered = 31
    ResizeGripActive = 32
    Tab = 33
    TabHovered = 34
    TabActive = 35
    TabUnfocused = 36
    TabUnfocusedActive = 37
    PlotLines = 38
    PlotLinesHovered = 39
    PlotHistogram = 40
    PlotHistogramHovered = 41
    TextSelectedBg = 42
    DragDropTarget = 43
    NavHighlight = 44
    NavWindowingHighlight = 45
    NavWindowingDimBg = 46
    ModalWindowDimBg = 47
  ImGuiColorEditFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoAlpha = 2
    NoPicker = 4
    NoOptions = 8
    NoSmallPreview = 16
    NoInputs = 32
    NoTooltip = 64
    NoLabel = 128
    NoSidePreview = 256
    NoDragDrop = 512
    AlphaBar = 65536
    AlphaPreview = 131072
    AlphaPreviewHalf = 262144
    HDR = 524288
    DisplayRGB = 1048576
    DisplayHSV = 2097152
    DisplayHex = 4194304
    DisplayMask = 7340032
    Uint8 = 8388608
    Float = 16777216
    DataTypeMask = 25165824
    PickerHueBar = 33554432
    PickerHueWheel = 67108864
    PickerMask = 100663296
    InputRGB = 134217728
    OptionsDefault = 177209344
    InputHSV = 268435456
    InputMask = 402653184
  ImGuiComboFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    PopupAlignLeft = 1
    HeightSmall = 2
    HeightRegular = 4
    HeightLarge = 8
    HeightLargest = 16
    HeightMask = 30
    NoArrowButton = 32
    NoPreview = 64
  ImGuiCond* {.pure, size: int32.sizeof.} = enum
    Always = 1
    Once = 2
    FirstUseEver = 4
    Appearing = 8
  ImGuiConfigFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NavEnableKeyboard = 1
    NavEnableGamepad = 2
    NavEnableSetMousePos = 4
    NavNoCaptureKeyboard = 8
    NoMouse = 16
    NoMouseCursorChange = 32
    IsSRGB = 1048576
    IsTouchScreen = 2097152
  ImGuiDataType* {.pure, size: int32.sizeof.} = enum
    S8 = 0
    U8 = 1
    S16 = 2
    U16 = 3
    S32 = 4
    U32 = 5
    S64 = 6
    U64 = 7
    Float = 8
    Double = 9
  ImGuiDir* {.pure, size: int32.sizeof.} = enum
    None = -1
    Left = 0
    Right = 1
    Up = 2
    Down = 3
  ImGuiDragDropFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    SourceNoPreviewTooltip = 1
    SourceNoDisableHover = 2
    SourceNoHoldToOpenOthers = 4
    SourceAllowNullID = 8
    SourceExtern = 16
    SourceAutoExpirePayload = 32
    AcceptBeforeDelivery = 1024
    AcceptNoDrawDefaultRect = 2048
    AcceptPeekOnly = 3072
    AcceptNoPreviewTooltip = 4096
  ImGuiFocusedFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    ChildWindows = 1
    RootWindow = 2
    RootAndChildWindows = 3
    AnyWindow = 4
  ImGuiHoveredFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    ChildWindows = 1
    RootWindow = 2
    RootAndChildWindows = 3
    AnyWindow = 4
    AllowWhenBlockedByPopup = 8
    AllowWhenBlockedByActiveItem = 32
    AllowWhenOverlapped = 64
    RectOnly = 104
    AllowWhenDisabled = 128
  ImGuiInputTextFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    CharsDecimal = 1
    CharsHexadecimal = 2
    CharsUppercase = 4
    CharsNoBlank = 8
    AutoSelectAll = 16
    EnterReturnsTrue = 32
    CallbackCompletion = 64
    CallbackHistory = 128
    CallbackAlways = 256
    CallbackCharFilter = 512
    AllowTabInput = 1024
    CtrlEnterForNewLine = 2048
    NoHorizontalScroll = 4096
    AlwaysInsertMode = 8192
    ReadOnly = 16384
    Password = 32768
    NoUndoRedo = 65536
    CharsScientific = 131072
    CallbackResize = 262144
    Multiline = 1048576
    NoMarkEdited = 2097152
  ImGuiKey* {.pure, size: int32.sizeof.} = enum
    Tab = 0
    LeftArrow = 1
    RightArrow = 2
    UpArrow = 3
    DownArrow = 4
    PageUp = 5
    PageDown = 6
    Home = 7
    End = 8
    Insert = 9
    Delete = 10
    Backspace = 11
    Space = 12
    Enter = 13
    Escape = 14
    KeyPadEnter = 15
    A = 16
    C = 17
    V = 18
    X = 19
    Y = 20
    Z = 21
  ImGuiMouseCursor* {.pure, size: int32.sizeof.} = enum
    None = -1
    Arrow = 0
    TextInput = 1
    ResizeAll = 2
    ResizeNS = 3
    ResizeEW = 4
    ResizeNESW = 5
    ResizeNWSE = 6
    Hand = 7
  ImGuiNavInput* {.pure, size: int32.sizeof.} = enum
    Activate = 0
    Cancel = 1
    Input = 2
    Menu = 3
    DpadLeft = 4
    DpadRight = 5
    DpadUp = 6
    DpadDown = 7
    LStickLeft = 8
    LStickRight = 9
    LStickUp = 10
    LStickDown = 11
    FocusPrev = 12
    FocusNext = 13
    TweakSlow = 14
    TweakFast = 15
    KeyMenu = 16
    KeyTab = 17
    KeyLeft = 18
    KeyRight = 19
    KeyUp = 20
    KeyDown = 21
  ImGuiSelectableFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    DontClosePopups = 1
    SpanAllColumns = 2
    AllowDoubleClick = 4
    Disabled = 8
    AllowItemOverlap = 16
  ImGuiStyleVar* {.pure, size: int32.sizeof.} = enum
    Alpha = 0
    WindowPadding = 1
    WindowRounding = 2
    WindowBorderSize = 3
    WindowMinSize = 4
    WindowTitleAlign = 5
    ChildRounding = 6
    ChildBorderSize = 7
    PopupRounding = 8
    PopupBorderSize = 9
    FramePadding = 10
    FrameRounding = 11
    FrameBorderSize = 12
    ItemSpacing = 13
    ItemInnerSpacing = 14
    IndentSpacing = 15
    ScrollbarSize = 16
    ScrollbarRounding = 17
    GrabMinSize = 18
    GrabRounding = 19
    TabRounding = 20
    ButtonTextAlign = 21
    SelectableTextAlign = 22
  ImGuiTabBarFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Reorderable = 1
    AutoSelectNewTabs = 2
    TabListPopupButton = 4
    NoCloseWithMiddleMouseButton = 8
    NoTabListScrollingButtons = 16
    NoTooltip = 32
    FittingPolicyResizeDown = 64
    FittingPolicyScroll = 128
    FittingPolicyMask = 192
  ImGuiTabItemFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    UnsavedDocument = 1
    SetSelected = 2
    NoCloseWithMiddleMouseButton = 4
    NoPushId = 8
  ImGuiTreeNodeFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Selected = 1
    Framed = 2
    AllowItemOverlap = 4
    NoTreePushOnOpen = 8
    NoAutoOpenOnLog = 16
    CollapsingHeader = 26
    DefaultOpen = 32
    OpenOnDoubleClick = 64
    OpenOnArrow = 128
    Leaf = 256
    Bullet = 512
    FramePadding = 1024
    SpanAvailWidth = 2048
    SpanFullWidth = 4096
    NavLeftJumpsBackHere = 8192
  ImGuiWindowFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoTitleBar = 1
    NoResize = 2
    NoMove = 4
    NoScrollbar = 8
    NoScrollWithMouse = 16
    NoCollapse = 32
    NoDecoration = 43
    AlwaysAutoResize = 64
    NoBackground = 128
    NoSavedSettings = 256
    NoMouseInputs = 512
    MenuBar = 1024
    HorizontalScrollbar = 2048
    NoFocusOnAppearing = 4096
    NoBringToFrontOnFocus = 8192
    AlwaysVerticalScrollbar = 16384
    AlwaysHorizontalScrollbar = 32768
    AlwaysUseWindowPadding = 65536
    NoNavInputs = 262144
    NoNavFocus = 524288
    NoNav = 786432
    NoInputs = 786944
    UnsavedDocument = 1048576
    NavFlattened = 8388608
    ChildWindow = 16777216
    Tooltip = 33554432
    Popup = 67108864
    Modal = 134217728
    ChildMenu = 268435456

# TypeDefs
type
  ImDrawCallback* = proc(parent_list: ptr ImDrawList, cmd: ptr ImDrawCmd): void {.cdecl.}
  ImDrawIdx* = uint16
  ImGuiID* = uint32
  ImGuiInputTextCallback* = proc(data: ptr ImGuiInputTextCallbackData): int32 {.cdecl.}
  ImGuiSizeCallback* = proc(data: ptr ImGuiSizeCallbackData): void {.cdecl.}
  ImTextureID* = pointer
  ImWchar* = uint16

  ImVector*[T] = object # Should I importc a generic?
    size* {.importc: "Size".}: int32
    capacity* {.importc: "Capacity".}: int32
    data* {.importc: "Data".}: UncheckedArray[T]
  ImGuiStoragePairData* {.union.} = object
    val_i* {.importc: "val_i".}: int32 # Breaking naming convetion to denote "low level"
    val_f* {.importc: "val_f".}: float32
    val_p* {.importc: "val_p".}: pointer
  ImGuiStoragePair* {.importc: "ImGuiStoragePair", imgui_header.} = object
    key* {.importc: "key".}: ImGuiID
    data*: ImGuiStoragePairData
  ImPairData* {.union.} = object
    val_i* {.importc: "val_i".}: int32 # Breaking naming convetion to denote "low level"
    val_f* {.importc: "val_f".}: float32
    val_p* {.importc: "val_p".}: pointer
  ImPair* {.importc: "Pair", imgui_header.} = object
    key* {.importc: "key".}: ImGuiID
    data*: ImPairData
  ImDrawListSharedData* {.importc: "ImDrawListSharedData", imgui_header.} = object
  ImGuiContext* {.importc: "ImGuiContext", imgui_header.} = object
  ImColor* {.importc: "ImColor", imgui_header.} = object
    value* {.importc: "Value".}: ImVec4
  ImDrawChannel* {.importc: "ImDrawChannel", imgui_header.} = object
    cmdBuffer* {.importc: "_CmdBuffer".}: ImVector[ImDrawCmd]
    idxBuffer* {.importc: "_IdxBuffer".}: ImVector[ImDrawIdx]
  ImDrawCmd* {.importc: "ImDrawCmd", imgui_header.} = object
    elemCount* {.importc: "ElemCount".}: uint32
    clipRect* {.importc: "ClipRect".}: ImVec4
    textureId* {.importc: "TextureId".}: ImTextureID
    vtxOffset* {.importc: "VtxOffset".}: uint32
    idxOffset* {.importc: "IdxOffset".}: uint32
    userCallback* {.importc: "UserCallback".}: ImDrawCallback
    userCallbackData* {.importc: "UserCallbackData".}: pointer
  ImDrawData* {.importc: "ImDrawData", imgui_header.} = object
    valid* {.importc: "Valid".}: bool
    cmdLists* {.importc: "CmdLists".}: UncheckedArray[ptr ImDrawList]
    cmdListsCount* {.importc: "CmdListsCount".}: int32
    totalIdxCount* {.importc: "TotalIdxCount".}: int32
    totalVtxCount* {.importc: "TotalVtxCount".}: int32
    displayPos* {.importc: "DisplayPos".}: ImVec2
    displaySize* {.importc: "DisplaySize".}: ImVec2
    framebufferScale* {.importc: "FramebufferScale".}: ImVec2
  ImDrawList* {.importc: "ImDrawList", imgui_header.} = object
    cmdBuffer* {.importc: "CmdBuffer".}: ImVector[ImDrawCmd]
    idxBuffer* {.importc: "IdxBuffer".}: ImVector[ImDrawIdx]
    vtxBuffer* {.importc: "VtxBuffer".}: ImVector[ImDrawVert]
    flags* {.importc: "Flags".}: ImDrawListFlags
    data* {.importc: "_Data".}: ptr ImDrawListSharedData
    ownerName* {.importc: "_OwnerName".}: cstring
    vtxCurrentOffset* {.importc: "_VtxCurrentOffset".}: uint32
    vtxCurrentIdx* {.importc: "_VtxCurrentIdx".}: uint32
    vtxWritePtr* {.importc: "_VtxWritePtr".}: ptr ImDrawVert
    idxWritePtr* {.importc: "_IdxWritePtr".}: ptr ImDrawIdx
    clipRectStack* {.importc: "_ClipRectStack".}: ImVector[ImVec4]
    textureIdStack* {.importc: "_TextureIdStack".}: ImVector[ImTextureID]
    path* {.importc: "_Path".}: ImVector[ImVec2]
    splitter* {.importc: "_Splitter".}: ImDrawListSplitter
  ImDrawListSplitter* {.importc: "ImDrawListSplitter", imgui_header.} = object
    current* {.importc: "_Current".}: int32
    count* {.importc: "_Count".}: int32
    channels* {.importc: "_Channels".}: ImVector[ImDrawChannel]
  ImDrawVert* {.importc: "ImDrawVert", imgui_header.} = object
    pos* {.importc: "pos".}: ImVec2
    uv* {.importc: "uv".}: ImVec2
    col* {.importc: "col".}: uint32
  ImFont* {.importc: "ImFont", imgui_header.} = object
    indexAdvanceX* {.importc: "IndexAdvanceX".}: ImVector[float32]
    fallbackAdvanceX* {.importc: "FallbackAdvanceX".}: float32
    fontSize* {.importc: "FontSize".}: float32
    indexLookup* {.importc: "IndexLookup".}: ImVector[ImWchar]
    glyphs* {.importc: "Glyphs".}: ImVector[ImFontGlyph]
    fallbackGlyph* {.importc: "FallbackGlyph".}: ptr ImFontGlyph
    displayOffset* {.importc: "DisplayOffset".}: ImVec2
    containerAtlas* {.importc: "ContainerAtlas".}: ptr ImFontAtlas
    configData* {.importc: "ConfigData".}: ptr ImFontConfig
    configDataCount* {.importc: "ConfigDataCount".}: int16
    fallbackChar* {.importc: "FallbackChar".}: ImWchar
    ellipsisChar* {.importc: "EllipsisChar".}: ImWchar
    scale* {.importc: "Scale".}: float32
    ascent* {.importc: "Ascent".}: float32
    descent* {.importc: "Descent".}: float32
    metricsTotalSurface* {.importc: "MetricsTotalSurface".}: int32
    dirtyLookupTables* {.importc: "DirtyLookupTables".}: bool
  ImFontAtlas* {.importc: "ImFontAtlas", imgui_header.} = object
    locked* {.importc: "Locked".}: bool
    flags* {.importc: "Flags".}: ImFontAtlasFlags
    texID* {.importc: "TexID".}: ImTextureID
    texDesiredWidth* {.importc: "TexDesiredWidth".}: int32
    texGlyphPadding* {.importc: "TexGlyphPadding".}: int32
    texPixelsAlpha8* {.importc: "TexPixelsAlpha8".}: ptr cuchar
    texPixelsRGBA32* {.importc: "TexPixelsRGBA32".}: ptr uint32
    texWidth* {.importc: "TexWidth".}: int32
    texHeight* {.importc: "TexHeight".}: int32
    texUvScale* {.importc: "TexUvScale".}: ImVec2
    texUvWhitePixel* {.importc: "TexUvWhitePixel".}: ImVec2
    fonts* {.importc: "Fonts".}: ImVector[ptr ImFont]
    customRects* {.importc: "CustomRects".}: ImVector[ImFontAtlasCustomRect]
    configData* {.importc: "ConfigData".}: ImVector[ImFontConfig]
    customRectIds* {.importc: "CustomRectIds".}: array[1, int32]
  ImFontAtlasCustomRect* {.importc: "ImFontAtlasCustomRect", imgui_header.} = object
    id* {.importc: "ID".}: uint32
    width* {.importc: "Width".}: uint16
    height* {.importc: "Height".}: uint16
    x* {.importc: "X".}: uint16
    y* {.importc: "Y".}: uint16
    glyphAdvanceX* {.importc: "GlyphAdvanceX".}: float32
    glyphOffset* {.importc: "GlyphOffset".}: ImVec2
    font* {.importc: "Font".}: ptr ImFont
  ImFontConfig* {.importc: "ImFontConfig", imgui_header.} = object
    fontData* {.importc: "FontData".}: pointer
    fontDataSize* {.importc: "FontDataSize".}: int32
    fontDataOwnedByAtlas* {.importc: "FontDataOwnedByAtlas".}: bool
    fontNo* {.importc: "FontNo".}: int32
    sizePixels* {.importc: "SizePixels".}: float32
    oversampleH* {.importc: "OversampleH".}: int32
    oversampleV* {.importc: "OversampleV".}: int32
    pixelSnapH* {.importc: "PixelSnapH".}: bool
    glyphExtraSpacing* {.importc: "GlyphExtraSpacing".}: ImVec2
    glyphOffset* {.importc: "GlyphOffset".}: ImVec2
    glyphRanges* {.importc: "GlyphRanges".}: ptr ImWchar
    glyphMinAdvanceX* {.importc: "GlyphMinAdvanceX".}: float32
    glyphMaxAdvanceX* {.importc: "GlyphMaxAdvanceX".}: float32
    mergeMode* {.importc: "MergeMode".}: bool
    rasterizerFlags* {.importc: "RasterizerFlags".}: uint32
    rasterizerMultiply* {.importc: "RasterizerMultiply".}: float32
    ellipsisChar* {.importc: "EllipsisChar".}: ImWchar
    name* {.importc: "Name".}: array[40, int8]
    dstFont* {.importc: "DstFont".}: ptr ImFont
  ImFontGlyph* {.importc: "ImFontGlyph", imgui_header.} = object
    codepoint* {.importc: "Codepoint".}: ImWchar
    advanceX* {.importc: "AdvanceX".}: float32
    x0* {.importc: "X0".}: float32
    y0* {.importc: "Y0".}: float32
    x1* {.importc: "X1".}: float32
    y1* {.importc: "Y1".}: float32
    u0* {.importc: "U0".}: float32
    v0* {.importc: "V0".}: float32
    u1* {.importc: "U1".}: float32
    v1* {.importc: "V1".}: float32
  ImFontGlyphRangesBuilder* {.importc: "ImFontGlyphRangesBuilder", imgui_header.} = object
    usedChars* {.importc: "UsedChars".}: ImVector[uint32]
  ImGuiIO* {.importc: "ImGuiIO", imgui_header.} = object
    configFlags* {.importc: "ConfigFlags".}: ImGuiConfigFlags
    backendFlags* {.importc: "BackendFlags".}: ImGuiBackendFlags
    displaySize* {.importc: "DisplaySize".}: ImVec2
    deltaTime* {.importc: "DeltaTime".}: float32
    iniSavingRate* {.importc: "IniSavingRate".}: float32
    iniFilename* {.importc: "IniFilename".}: cstring
    logFilename* {.importc: "LogFilename".}: cstring
    mouseDoubleClickTime* {.importc: "MouseDoubleClickTime".}: float32
    mouseDoubleClickMaxDist* {.importc: "MouseDoubleClickMaxDist".}: float32
    mouseDragThreshold* {.importc: "MouseDragThreshold".}: float32
    keyMap* {.importc: "KeyMap".}: array[22, int32]
    keyRepeatDelay* {.importc: "KeyRepeatDelay".}: float32
    keyRepeatRate* {.importc: "KeyRepeatRate".}: float32
    userData* {.importc: "UserData".}: pointer
    fonts* {.importc: "Fonts".}: ptr ImFontAtlas
    fontGlobalScale* {.importc: "FontGlobalScale".}: float32
    fontAllowUserScaling* {.importc: "FontAllowUserScaling".}: bool
    fontDefault* {.importc: "FontDefault".}: ptr ImFont
    displayFramebufferScale* {.importc: "DisplayFramebufferScale".}: ImVec2
    mouseDrawCursor* {.importc: "MouseDrawCursor".}: bool
    configMacOSXBehaviors* {.importc: "ConfigMacOSXBehaviors".}: bool
    configInputTextCursorBlink* {.importc: "ConfigInputTextCursorBlink".}: bool
    configWindowsResizeFromEdges* {.importc: "ConfigWindowsResizeFromEdges".}: bool
    configWindowsMoveFromTitleBarOnly* {.importc: "ConfigWindowsMoveFromTitleBarOnly".}: bool
    configWindowsMemoryCompactTimer* {.importc: "ConfigWindowsMemoryCompactTimer".}: float32
    backendPlatformName* {.importc: "BackendPlatformName".}: cstring
    backendRendererName* {.importc: "BackendRendererName".}: cstring
    backendPlatformUserData* {.importc: "BackendPlatformUserData".}: pointer
    backendRendererUserData* {.importc: "BackendRendererUserData".}: pointer
    backendLanguageUserData* {.importc: "BackendLanguageUserData".}: pointer
    getClipboardTextFn* {.importc: "GetClipboardTextFn".}: proc(user_data: pointer): cstring {.cdecl.}
    setClipboardTextFn* {.importc: "SetClipboardTextFn".}: proc(user_data: pointer, text: cstring): void {.cdecl.}
    clipboardUserData* {.importc: "ClipboardUserData".}: pointer
    imeSetInputScreenPosFn* {.importc: "ImeSetInputScreenPosFn".}: proc(x: int32, y: int32): void {.cdecl.}
    imeWindowHandle* {.importc: "ImeWindowHandle".}: pointer
    renderDrawListsFnUnused* {.importc: "RenderDrawListsFnUnused".}: pointer
    mousePos* {.importc: "MousePos".}: ImVec2
    mouseDown* {.importc: "MouseDown".}: array[5, bool]
    mouseWheel* {.importc: "MouseWheel".}: float32
    mouseWheelH* {.importc: "MouseWheelH".}: float32
    keyCtrl* {.importc: "KeyCtrl".}: bool
    keyShift* {.importc: "KeyShift".}: bool
    keyAlt* {.importc: "KeyAlt".}: bool
    keySuper* {.importc: "KeySuper".}: bool
    keysDown* {.importc: "KeysDown".}: array[512, bool]
    navInputs* {.importc: "NavInputs".}: array[22, float32]
    wantCaptureMouse* {.importc: "WantCaptureMouse".}: bool
    wantCaptureKeyboard* {.importc: "WantCaptureKeyboard".}: bool
    wantTextInput* {.importc: "WantTextInput".}: bool
    wantSetMousePos* {.importc: "WantSetMousePos".}: bool
    wantSaveIniSettings* {.importc: "WantSaveIniSettings".}: bool
    navActive* {.importc: "NavActive".}: bool
    navVisible* {.importc: "NavVisible".}: bool
    framerate* {.importc: "Framerate".}: float32
    metricsRenderVertices* {.importc: "MetricsRenderVertices".}: int32
    metricsRenderIndices* {.importc: "MetricsRenderIndices".}: int32
    metricsRenderWindows* {.importc: "MetricsRenderWindows".}: int32
    metricsActiveWindows* {.importc: "MetricsActiveWindows".}: int32
    metricsActiveAllocations* {.importc: "MetricsActiveAllocations".}: int32
    mouseDelta* {.importc: "MouseDelta".}: ImVec2
    mousePosPrev* {.importc: "MousePosPrev".}: ImVec2
    mouseClickedPos* {.importc: "MouseClickedPos".}: array[5, ImVec2]
    mouseClickedTime* {.importc: "MouseClickedTime".}: array[5, float64]
    mouseClicked* {.importc: "MouseClicked".}: array[5, bool]
    mouseDoubleClicked* {.importc: "MouseDoubleClicked".}: array[5, bool]
    mouseReleased* {.importc: "MouseReleased".}: array[5, bool]
    mouseDownOwned* {.importc: "MouseDownOwned".}: array[5, bool]
    mouseDownWasDoubleClick* {.importc: "MouseDownWasDoubleClick".}: array[5, bool]
    mouseDownDuration* {.importc: "MouseDownDuration".}: array[5, float32]
    mouseDownDurationPrev* {.importc: "MouseDownDurationPrev".}: array[5, float32]
    mouseDragMaxDistanceAbs* {.importc: "MouseDragMaxDistanceAbs".}: array[5, ImVec2]
    mouseDragMaxDistanceSqr* {.importc: "MouseDragMaxDistanceSqr".}: array[5, float32]
    keysDownDuration* {.importc: "KeysDownDuration".}: array[512, float32]
    keysDownDurationPrev* {.importc: "KeysDownDurationPrev".}: array[512, float32]
    navInputsDownDuration* {.importc: "NavInputsDownDuration".}: array[22, float32]
    navInputsDownDurationPrev* {.importc: "NavInputsDownDurationPrev".}: array[22, float32]
    inputQueueCharacters* {.importc: "InputQueueCharacters".}: ImVector[ImWchar]
  ImGuiInputTextCallbackData* {.importc: "ImGuiInputTextCallbackData", imgui_header.} = object
    eventFlag* {.importc: "EventFlag".}: ImGuiInputTextFlags
    flags* {.importc: "Flags".}: ImGuiInputTextFlags
    userData* {.importc: "UserData".}: pointer
    eventChar* {.importc: "EventChar".}: ImWchar
    eventKey* {.importc: "EventKey".}: ImGuiKey
    buf* {.importc: "Buf".}: cstring
    bufTextLen* {.importc: "BufTextLen".}: int32
    bufSize* {.importc: "BufSize".}: int32
    bufDirty* {.importc: "BufDirty".}: bool
    cursorPos* {.importc: "CursorPos".}: int32
    selectionStart* {.importc: "SelectionStart".}: int32
    selectionEnd* {.importc: "SelectionEnd".}: int32
  ImGuiListClipper* {.importc: "ImGuiListClipper", imgui_header.} = object
    startPosY* {.importc: "StartPosY".}: float32
    itemsHeight* {.importc: "ItemsHeight".}: float32
    itemsCount* {.importc: "ItemsCount".}: int32
    stepNo* {.importc: "StepNo".}: int32
    displayStart* {.importc: "DisplayStart".}: int32
    displayEnd* {.importc: "DisplayEnd".}: int32
  ImGuiOnceUponAFrame* {.importc: "ImGuiOnceUponAFrame", imgui_header.} = object
    refFrame* {.importc: "RefFrame".}: int32
  ImGuiPayload* {.importc: "ImGuiPayload", imgui_header.} = object
    data* {.importc: "Data".}: pointer
    dataSize* {.importc: "DataSize".}: int32
    sourceId* {.importc: "SourceId".}: ImGuiID
    sourceParentId* {.importc: "SourceParentId".}: ImGuiID
    dataFrameCount* {.importc: "DataFrameCount".}: int32
    dataType* {.importc: "DataType".}: array[32+1, int8]
    preview* {.importc: "Preview".}: bool
    delivery* {.importc: "Delivery".}: bool
  ImGuiSizeCallbackData* {.importc: "ImGuiSizeCallbackData", imgui_header.} = object
    userData* {.importc: "UserData".}: pointer
    pos* {.importc: "Pos".}: ImVec2
    currentSize* {.importc: "CurrentSize".}: ImVec2
    desiredSize* {.importc: "DesiredSize".}: ImVec2
  ImGuiStorage* {.importc: "ImGuiStorage", imgui_header.} = object
    data* {.importc: "Data".}: ImVector[ImGuiStoragePair]
  ImGuiStyle* {.importc: "ImGuiStyle", imgui_header.} = object
    alpha* {.importc: "Alpha".}: float32
    windowPadding* {.importc: "WindowPadding".}: ImVec2
    windowRounding* {.importc: "WindowRounding".}: float32
    windowBorderSize* {.importc: "WindowBorderSize".}: float32
    windowMinSize* {.importc: "WindowMinSize".}: ImVec2
    windowTitleAlign* {.importc: "WindowTitleAlign".}: ImVec2
    windowMenuButtonPosition* {.importc: "WindowMenuButtonPosition".}: ImGuiDir
    childRounding* {.importc: "ChildRounding".}: float32
    childBorderSize* {.importc: "ChildBorderSize".}: float32
    popupRounding* {.importc: "PopupRounding".}: float32
    popupBorderSize* {.importc: "PopupBorderSize".}: float32
    framePadding* {.importc: "FramePadding".}: ImVec2
    frameRounding* {.importc: "FrameRounding".}: float32
    frameBorderSize* {.importc: "FrameBorderSize".}: float32
    itemSpacing* {.importc: "ItemSpacing".}: ImVec2
    itemInnerSpacing* {.importc: "ItemInnerSpacing".}: ImVec2
    touchExtraPadding* {.importc: "TouchExtraPadding".}: ImVec2
    indentSpacing* {.importc: "IndentSpacing".}: float32
    columnsMinSpacing* {.importc: "ColumnsMinSpacing".}: float32
    scrollbarSize* {.importc: "ScrollbarSize".}: float32
    scrollbarRounding* {.importc: "ScrollbarRounding".}: float32
    grabMinSize* {.importc: "GrabMinSize".}: float32
    grabRounding* {.importc: "GrabRounding".}: float32
    tabRounding* {.importc: "TabRounding".}: float32
    tabBorderSize* {.importc: "TabBorderSize".}: float32
    colorButtonPosition* {.importc: "ColorButtonPosition".}: ImGuiDir
    buttonTextAlign* {.importc: "ButtonTextAlign".}: ImVec2
    selectableTextAlign* {.importc: "SelectableTextAlign".}: ImVec2
    displayWindowPadding* {.importc: "DisplayWindowPadding".}: ImVec2
    displaySafeAreaPadding* {.importc: "DisplaySafeAreaPadding".}: ImVec2
    mouseCursorScale* {.importc: "MouseCursorScale".}: float32
    antiAliasedLines* {.importc: "AntiAliasedLines".}: bool
    antiAliasedFill* {.importc: "AntiAliasedFill".}: bool
    curveTessellationTol* {.importc: "CurveTessellationTol".}: float32
    colors* {.importc: "Colors".}: array[48, ImVec4]
  ImGuiTextBuffer* {.importc: "ImGuiTextBuffer", imgui_header.} = object
    buf* {.importc: "Buf".}: ImVector[int8]
  ImGuiTextFilter* {.importc: "ImGuiTextFilter", imgui_header.} = object
    inputBuf* {.importc: "InputBuf".}: array[256, int8]
    filters* {.importc: "Filters".}: ImVector[ImGuiTextRange]
    countGrep* {.importc: "CountGrep".}: int32
  ImGuiTextRange* {.importc: "ImGuiTextRange", imgui_header.} = object
    b* {.importc: "b".}: cstring
    e* {.importc: "e".}: cstring
  ImVec2* {.importc: "ImVec2", imgui_header.} = object
    x* {.importc: "x".}: float32
    y* {.importc: "y".}: float32
  ImVec4* {.importc: "ImVec4", imgui_header.} = object
    x* {.importc: "x".}: float32
    y* {.importc: "y".}: float32
    z* {.importc: "z".}: float32
    w* {.importc: "w".}: float32

# Procs
when not defined(cpp) or defined(cimguiDll):
  {.push dynlib: imgui_dll, cdecl, discardable.}
else:
  {.push nodecl, discardable.}

proc hsv*(self: ptr ImColor, h: float32, s: float32, v: float32, a: float32 = 1.0f): ImColor {.importc: "ImColor_HSV".}
proc newImColor*(): void {.importc: "ImColor_ImColor".}
proc newImColor*(r: int32, g: int32, b: int32, a: int32 = 255): void {.importc: "ImColor_ImColorInt".}
proc newImColor*(rgba: uint32): void {.importc: "ImColor_ImColorU32".}
proc newImColor*(r: float32, g: float32, b: float32, a: float32 = 1.0f): void {.importc: "ImColor_ImColorFloat".}
proc newImColor*(col: ImVec4): void {.importc: "ImColor_ImColorVec4".}
proc setHSV*(self: ptr ImColor, h: float32, s: float32, v: float32, a: float32 = 1.0f): void {.importc: "ImColor_SetHSV".}
proc destroy*(self: ptr ImColor): void {.importc: "ImColor_destroy".}
proc newImDrawCmd*(): void {.importc: "ImDrawCmd_ImDrawCmd".}
proc destroy*(self: ptr ImDrawCmd): void {.importc: "ImDrawCmd_destroy".}
proc clear*(self: ptr ImDrawData): void {.importc: "ImDrawData_Clear".}
proc deIndexAllBuffers*(self: ptr ImDrawData): void {.importc: "ImDrawData_DeIndexAllBuffers".}
proc newImDrawData*(): void {.importc: "ImDrawData_ImDrawData".}
proc scaleClipRects*(self: ptr ImDrawData, fb_scale: ImVec2): void {.importc: "ImDrawData_ScaleClipRects".}
proc destroy*(self: ptr ImDrawData): void {.importc: "ImDrawData_destroy".}
proc clear*(self: ptr ImDrawListSplitter): void {.importc: "ImDrawListSplitter_Clear".}
proc clearFreeMemory*(self: ptr ImDrawListSplitter): void {.importc: "ImDrawListSplitter_ClearFreeMemory".}
proc newImDrawListSplitter*(): void {.importc: "ImDrawListSplitter_ImDrawListSplitter".}
proc merge*(self: ptr ImDrawListSplitter, draw_list: ptr ImDrawList): void {.importc: "ImDrawListSplitter_Merge".}
proc setCurrentChannel*(self: ptr ImDrawListSplitter, draw_list: ptr ImDrawList, channel_idx: int32): void {.importc: "ImDrawListSplitter_SetCurrentChannel".}
proc split*(self: ptr ImDrawListSplitter, draw_list: ptr ImDrawList, count: int32): void {.importc: "ImDrawListSplitter_Split".}
proc destroy*(self: ptr ImDrawListSplitter): void {.importc: "ImDrawListSplitter_destroy".}
proc addBezierCurve*(self: ptr ImDrawList, pos0: ImVec2, cp0: ImVec2, cp1: ImVec2, pos1: ImVec2, col: uint32, thickness: float32, num_segments: int32 = 0): void {.importc: "ImDrawList_AddBezierCurve".}
proc addCallback*(self: ptr ImDrawList, callback: ImDrawCallback, callback_data: pointer): void {.importc: "ImDrawList_AddCallback".}
proc addCircle*(self: ptr ImDrawList, center: ImVec2, radius: float32, col: uint32, num_segments: int32 = 12, thickness: float32 = 1.0f): void {.importc: "ImDrawList_AddCircle".}
proc addCircleFilled*(self: ptr ImDrawList, center: ImVec2, radius: float32, col: uint32, num_segments: int32 = 12): void {.importc: "ImDrawList_AddCircleFilled".}
proc addConvexPolyFilled*(self: ptr ImDrawList, points: ptr ImVec2, num_points: int32, col: uint32): void {.importc: "ImDrawList_AddConvexPolyFilled".}
proc addDrawCmd*(self: ptr ImDrawList): void {.importc: "ImDrawList_AddDrawCmd".}
proc addImage*(self: ptr ImDrawList, user_texture_id: ImTextureID, p_min: ImVec2, p_max: ImVec2, uv_min: ImVec2 = ImVec2(x: 0, y: 0), uv_max: ImVec2 = ImVec2(x: 1, y: 1), col: uint32 = high(uint32)): void {.importc: "ImDrawList_AddImage".}
proc addImageQuad*(self: ptr ImDrawList, user_texture_id: ImTextureID, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, uv1: ImVec2 = ImVec2(x: 0, y: 0), uv2: ImVec2 = ImVec2(x: 1, y: 0), uv3: ImVec2 = ImVec2(x: 1, y: 1), uv4: ImVec2 = ImVec2(x: 0, y: 1), col: uint32 = high(uint32)): void {.importc: "ImDrawList_AddImageQuad".}
proc addImageRounded*(self: ptr ImDrawList, user_texture_id: ImTextureID, p_min: ImVec2, p_max: ImVec2, uv_min: ImVec2, uv_max: ImVec2, col: uint32, rounding: float32, rounding_corners: ImDrawCornerFlags = ImDrawCornerFlags.All): void {.importc: "ImDrawList_AddImageRounded".}
proc addLine*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, col: uint32, thickness: float32 = 1.0f): void {.importc: "ImDrawList_AddLine".}
proc addPolyline*(self: ptr ImDrawList, points: ptr ImVec2, num_points: int32, col: uint32, closed: bool, thickness: float32): void {.importc: "ImDrawList_AddPolyline".}
proc addQuad*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: uint32, thickness: float32 = 1.0f): void {.importc: "ImDrawList_AddQuad".}
proc addQuadFilled*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: uint32): void {.importc: "ImDrawList_AddQuadFilled".}
proc addRect*(self: ptr ImDrawList, p_min: ImVec2, p_max: ImVec2, col: uint32, rounding: float32 = 0.0f, rounding_corners: ImDrawCornerFlags = ImDrawCornerFlags.All, thickness: float32 = 1.0f): void {.importc: "ImDrawList_AddRect".}
proc addRectFilled*(self: ptr ImDrawList, p_min: ImVec2, p_max: ImVec2, col: uint32, rounding: float32 = 0.0f, rounding_corners: ImDrawCornerFlags = ImDrawCornerFlags.All): void {.importc: "ImDrawList_AddRectFilled".}
proc addRectFilledMultiColor*(self: ptr ImDrawList, p_min: ImVec2, p_max: ImVec2, col_upr_left: uint32, col_upr_right: uint32, col_bot_right: uint32, col_bot_left: uint32): void {.importc: "ImDrawList_AddRectFilledMultiColor".}
proc addText*(self: ptr ImDrawList, pos: ImVec2, col: uint32, text_begin: cstring, text_end: cstring = nil): void {.importc: "ImDrawList_AddText".}
proc addText*(self: ptr ImDrawList, font: ptr ImFont, font_size: float32, pos: ImVec2, col: uint32, text_begin: cstring, text_end: cstring = nil, wrap_width: float32 = 0.0f, cpu_fine_clip_rect: ptr ImVec4 = nil): void {.importc: "ImDrawList_AddTextFontPtr".}
proc addTriangle*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: uint32, thickness: float32 = 1.0f): void {.importc: "ImDrawList_AddTriangle".}
proc addTriangleFilled*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: uint32): void {.importc: "ImDrawList_AddTriangleFilled".}
proc channelsMerge*(self: ptr ImDrawList): void {.importc: "ImDrawList_ChannelsMerge".}
proc channelsSetCurrent*(self: ptr ImDrawList, n: int32): void {.importc: "ImDrawList_ChannelsSetCurrent".}
proc channelsSplit*(self: ptr ImDrawList, count: int32): void {.importc: "ImDrawList_ChannelsSplit".}
proc clear*(self: ptr ImDrawList): void {.importc: "ImDrawList_Clear".}
proc clearFreeMemory*(self: ptr ImDrawList): void {.importc: "ImDrawList_ClearFreeMemory".}
proc cloneOutput*(self: ptr ImDrawList): ptr ImDrawList {.importc: "ImDrawList_CloneOutput".}
proc getClipRectMax*(self: ptr ImDrawList): ImVec2 {.importc: "ImDrawList_GetClipRectMax".}
proc getClipRectMin*(self: ptr ImDrawList): ImVec2 {.importc: "ImDrawList_GetClipRectMin".}
proc newImDrawList*(shared_data: ptr ImDrawListSharedData): void {.importc: "ImDrawList_ImDrawList".}
proc pathArcTo*(self: ptr ImDrawList, center: ImVec2, radius: float32, a_min: float32, a_max: float32, num_segments: int32 = 10): void {.importc: "ImDrawList_PathArcTo".}
proc pathArcToFast*(self: ptr ImDrawList, center: ImVec2, radius: float32, a_min_of_12: int32, a_max_of_12: int32): void {.importc: "ImDrawList_PathArcToFast".}
proc pathBezierCurveTo*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, num_segments: int32 = 0): void {.importc: "ImDrawList_PathBezierCurveTo".}
proc pathClear*(self: ptr ImDrawList): void {.importc: "ImDrawList_PathClear".}
proc pathFillConvex*(self: ptr ImDrawList, col: uint32): void {.importc: "ImDrawList_PathFillConvex".}
proc pathLineTo*(self: ptr ImDrawList, pos: ImVec2): void {.importc: "ImDrawList_PathLineTo".}
proc pathLineToMergeDuplicate*(self: ptr ImDrawList, pos: ImVec2): void {.importc: "ImDrawList_PathLineToMergeDuplicate".}
proc pathRect*(self: ptr ImDrawList, rect_min: ImVec2, rect_max: ImVec2, rounding: float32 = 0.0f, rounding_corners: ImDrawCornerFlags = ImDrawCornerFlags.All): void {.importc: "ImDrawList_PathRect".}
proc pathStroke*(self: ptr ImDrawList, col: uint32, closed: bool, thickness: float32 = 1.0f): void {.importc: "ImDrawList_PathStroke".}
proc popClipRect*(self: ptr ImDrawList): void {.importc: "ImDrawList_PopClipRect".}
proc popTextureID*(self: ptr ImDrawList): void {.importc: "ImDrawList_PopTextureID".}
proc primQuadUV*(self: ptr ImDrawList, a: ImVec2, b: ImVec2, c: ImVec2, d: ImVec2, uv_a: ImVec2, uv_b: ImVec2, uv_c: ImVec2, uv_d: ImVec2, col: uint32): void {.importc: "ImDrawList_PrimQuadUV".}
proc primRect*(self: ptr ImDrawList, a: ImVec2, b: ImVec2, col: uint32): void {.importc: "ImDrawList_PrimRect".}
proc primRectUV*(self: ptr ImDrawList, a: ImVec2, b: ImVec2, uv_a: ImVec2, uv_b: ImVec2, col: uint32): void {.importc: "ImDrawList_PrimRectUV".}
proc primReserve*(self: ptr ImDrawList, idx_count: int32, vtx_count: int32): void {.importc: "ImDrawList_PrimReserve".}
proc primVtx*(self: ptr ImDrawList, pos: ImVec2, uv: ImVec2, col: uint32): void {.importc: "ImDrawList_PrimVtx".}
proc primWriteIdx*(self: ptr ImDrawList, idx: ImDrawIdx): void {.importc: "ImDrawList_PrimWriteIdx".}
proc primWriteVtx*(self: ptr ImDrawList, pos: ImVec2, uv: ImVec2, col: uint32): void {.importc: "ImDrawList_PrimWriteVtx".}
proc pushClipRect*(self: ptr ImDrawList, clip_rect_min: ImVec2, clip_rect_max: ImVec2, intersect_with_current_clip_rect: bool = false): void {.importc: "ImDrawList_PushClipRect".}
proc pushClipRectFullScreen*(self: ptr ImDrawList): void {.importc: "ImDrawList_PushClipRectFullScreen".}
proc pushTextureID*(self: ptr ImDrawList, texture_id: ImTextureID): void {.importc: "ImDrawList_PushTextureID".}
proc updateClipRect*(self: ptr ImDrawList): void {.importc: "ImDrawList_UpdateClipRect".}
proc updateTextureID*(self: ptr ImDrawList): void {.importc: "ImDrawList_UpdateTextureID".}
proc destroy*(self: ptr ImDrawList): void {.importc: "ImDrawList_destroy".}
proc newImFontAtlasCustomRect*(): void {.importc: "ImFontAtlasCustomRect_ImFontAtlasCustomRect".}
proc isPacked*(self: ptr ImFontAtlasCustomRect): bool {.importc: "ImFontAtlasCustomRect_IsPacked".}
proc destroy*(self: ptr ImFontAtlasCustomRect): void {.importc: "ImFontAtlasCustomRect_destroy".}
proc addCustomRectFontGlyph*(self: ptr ImFontAtlas, font: ptr ImFont, id: ImWchar, width: int32, height: int32, advance_x: float32, offset: ImVec2 = ImVec2(x: 0, y: 0)): int32 {.importc: "ImFontAtlas_AddCustomRectFontGlyph".}
proc addCustomRectRegular*(self: ptr ImFontAtlas, id: uint32, width: int32, height: int32): int32 {.importc: "ImFontAtlas_AddCustomRectRegular".}
proc addFont*(self: ptr ImFontAtlas, font_cfg: ptr ImFontConfig): ptr ImFont {.importc: "ImFontAtlas_AddFont".}
proc addFontDefault*(self: ptr ImFontAtlas, font_cfg: ptr ImFontConfig = nil): ptr ImFont {.importc: "ImFontAtlas_AddFontDefault".}
proc addFontFromFileTTF*(self: ptr ImFontAtlas, filename: cstring, size_pixels: float32, font_cfg: ptr ImFontConfig = nil, glyph_ranges: ptr ImWchar = nil): ptr ImFont {.importc: "ImFontAtlas_AddFontFromFileTTF".}
proc addFontFromMemoryCompressedBase85TTF*(self: ptr ImFontAtlas, compressed_font_data_base85: cstring, size_pixels: float32, font_cfg: ptr ImFontConfig = nil, glyph_ranges: ptr ImWchar = nil): ptr ImFont {.importc: "ImFontAtlas_AddFontFromMemoryCompressedBase85TTF".}
proc addFontFromMemoryCompressedTTF*(self: ptr ImFontAtlas, compressed_font_data: pointer, compressed_font_size: int32, size_pixels: float32, font_cfg: ptr ImFontConfig = nil, glyph_ranges: ptr ImWchar = nil): ptr ImFont {.importc: "ImFontAtlas_AddFontFromMemoryCompressedTTF".}
proc addFontFromMemoryTTF*(self: ptr ImFontAtlas, font_data: pointer, font_size: int32, size_pixels: float32, font_cfg: ptr ImFontConfig = nil, glyph_ranges: ptr ImWchar = nil): ptr ImFont {.importc: "ImFontAtlas_AddFontFromMemoryTTF".}
proc build*(self: ptr ImFontAtlas): bool {.importc: "ImFontAtlas_Build".}
proc calcCustomRectUV*(self: ptr ImFontAtlas, rect: ptr ImFontAtlasCustomRect, out_uv_min: ptr ImVec2, out_uv_max: ptr ImVec2): void {.importc: "ImFontAtlas_CalcCustomRectUV".}
proc clear*(self: ptr ImFontAtlas): void {.importc: "ImFontAtlas_Clear".}
proc clearFonts*(self: ptr ImFontAtlas): void {.importc: "ImFontAtlas_ClearFonts".}
proc clearInputData*(self: ptr ImFontAtlas): void {.importc: "ImFontAtlas_ClearInputData".}
proc clearTexData*(self: ptr ImFontAtlas): void {.importc: "ImFontAtlas_ClearTexData".}
proc getCustomRectByIndex*(self: ptr ImFontAtlas, index: int32): ptr ImFontAtlasCustomRect {.importc: "ImFontAtlas_GetCustomRectByIndex".}
proc getGlyphRangesChineseFull*(self: ptr ImFontAtlas): ptr ImWchar {.importc: "ImFontAtlas_GetGlyphRangesChineseFull".}
proc getGlyphRangesChineseSimplifiedCommon*(self: ptr ImFontAtlas): ptr ImWchar {.importc: "ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon".}
proc getGlyphRangesCyrillic*(self: ptr ImFontAtlas): ptr ImWchar {.importc: "ImFontAtlas_GetGlyphRangesCyrillic".}
proc getGlyphRangesDefault*(self: ptr ImFontAtlas): ptr ImWchar {.importc: "ImFontAtlas_GetGlyphRangesDefault".}
proc getGlyphRangesJapanese*(self: ptr ImFontAtlas): ptr ImWchar {.importc: "ImFontAtlas_GetGlyphRangesJapanese".}
proc getGlyphRangesKorean*(self: ptr ImFontAtlas): ptr ImWchar {.importc: "ImFontAtlas_GetGlyphRangesKorean".}
proc getGlyphRangesThai*(self: ptr ImFontAtlas): ptr ImWchar {.importc: "ImFontAtlas_GetGlyphRangesThai".}
proc getGlyphRangesVietnamese*(self: ptr ImFontAtlas): ptr ImWchar {.importc: "ImFontAtlas_GetGlyphRangesVietnamese".}
proc getMouseCursorTexData*(self: ptr ImFontAtlas, cursor: ImGuiMouseCursor, out_offset: ptr ImVec2, out_size: ptr ImVec2, out_uv_border: var array[2, ImVec2], out_uv_fill: var array[2, ImVec2]): bool {.importc: "ImFontAtlas_GetMouseCursorTexData".}
proc getTexDataAsAlpha8*(self: ptr ImFontAtlas, out_pixels: ptr ptr cuchar, out_width: ptr int32, out_height: ptr int32, out_bytes_per_pixel: ptr int32 = nil): void {.importc: "ImFontAtlas_GetTexDataAsAlpha8".}
proc getTexDataAsRGBA32*(self: ptr ImFontAtlas, out_pixels: ptr ptr cuchar, out_width: ptr int32, out_height: ptr int32, out_bytes_per_pixel: ptr int32 = nil): void {.importc: "ImFontAtlas_GetTexDataAsRGBA32".}
proc newImFontAtlas*(): void {.importc: "ImFontAtlas_ImFontAtlas".}
proc isBuilt*(self: ptr ImFontAtlas): bool {.importc: "ImFontAtlas_IsBuilt".}
proc setTexID*(self: ptr ImFontAtlas, id: ImTextureID): void {.importc: "ImFontAtlas_SetTexID".}
proc destroy*(self: ptr ImFontAtlas): void {.importc: "ImFontAtlas_destroy".}
proc newImFontConfig*(): void {.importc: "ImFontConfig_ImFontConfig".}
proc destroy*(self: ptr ImFontConfig): void {.importc: "ImFontConfig_destroy".}
proc addChar*(self: ptr ImFontGlyphRangesBuilder, c: ImWchar): void {.importc: "ImFontGlyphRangesBuilder_AddChar".}
proc addRanges*(self: ptr ImFontGlyphRangesBuilder, ranges: ptr ImWchar): void {.importc: "ImFontGlyphRangesBuilder_AddRanges".}
proc addText*(self: ptr ImFontGlyphRangesBuilder, text: cstring, text_end: cstring = nil): void {.importc: "ImFontGlyphRangesBuilder_AddText".}
proc buildRanges*(self: ptr ImFontGlyphRangesBuilder, out_ranges: ptr ImVector[ImWchar]): void {.importc: "ImFontGlyphRangesBuilder_BuildRanges".}
proc clear*(self: ptr ImFontGlyphRangesBuilder): void {.importc: "ImFontGlyphRangesBuilder_Clear".}
proc getBit*(self: ptr ImFontGlyphRangesBuilder, n: int32): bool {.importc: "ImFontGlyphRangesBuilder_GetBit".}
proc newImFontGlyphRangesBuilder*(): void {.importc: "ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder".}
proc setBit*(self: ptr ImFontGlyphRangesBuilder, n: int32): void {.importc: "ImFontGlyphRangesBuilder_SetBit".}
proc destroy*(self: ptr ImFontGlyphRangesBuilder): void {.importc: "ImFontGlyphRangesBuilder_destroy".}
proc addGlyph*(self: ptr ImFont, c: ImWchar, x0: float32, y0: float32, x1: float32, y1: float32, u0: float32, v0: float32, u1: float32, v1: float32, advance_x: float32): void {.importc: "ImFont_AddGlyph".}
proc addRemapChar*(self: ptr ImFont, dst: ImWchar, src: ImWchar, overwrite_dst: bool = true): void {.importc: "ImFont_AddRemapChar".}
proc buildLookupTable*(self: ptr ImFont): void {.importc: "ImFont_BuildLookupTable".}
proc calcTextSizeA*(self: ptr ImFont, size: float32, max_width: float32, wrap_width: float32, text_begin: cstring, text_end: cstring = nil, remaining: ptr cstring = nil): ImVec2 {.importc: "ImFont_CalcTextSizeA".}
proc calcWordWrapPositionA*(self: ptr ImFont, scale: float32, text: cstring, text_end: cstring, wrap_width: float32): cstring {.importc: "ImFont_CalcWordWrapPositionA".}
proc clearOutputData*(self: ptr ImFont): void {.importc: "ImFont_ClearOutputData".}
proc findGlyph*(self: ptr ImFont, c: ImWchar): ptr ImFontGlyph {.importc: "ImFont_FindGlyph".}
proc findGlyphNoFallback*(self: ptr ImFont, c: ImWchar): ptr ImFontGlyph {.importc: "ImFont_FindGlyphNoFallback".}
proc getCharAdvance*(self: ptr ImFont, c: ImWchar): float32 {.importc: "ImFont_GetCharAdvance".}
proc getDebugName*(self: ptr ImFont): cstring {.importc: "ImFont_GetDebugName".}
proc growIndex*(self: ptr ImFont, new_size: int32): void {.importc: "ImFont_GrowIndex".}
proc newImFont*(): void {.importc: "ImFont_ImFont".}
proc isLoaded*(self: ptr ImFont): bool {.importc: "ImFont_IsLoaded".}
proc renderChar*(self: ptr ImFont, draw_list: ptr ImDrawList, size: float32, pos: ImVec2, col: uint32, c: ImWchar): void {.importc: "ImFont_RenderChar".}
proc renderText*(self: ptr ImFont, draw_list: ptr ImDrawList, size: float32, pos: ImVec2, col: uint32, clip_rect: ImVec4, text_begin: cstring, text_end: cstring, wrap_width: float32 = 0.0f, cpu_fine_clip: bool = false): void {.importc: "ImFont_RenderText".}
proc setFallbackChar*(self: ptr ImFont, c: ImWchar): void {.importc: "ImFont_SetFallbackChar".}
proc destroy*(self: ptr ImFont): void {.importc: "ImFont_destroy".}
proc addInputCharacter*(self: ptr ImGuiIO, c: uint32): void {.importc: "ImGuiIO_AddInputCharacter".}
proc addInputCharactersUTF8*(self: ptr ImGuiIO, str: cstring): void {.importc: "ImGuiIO_AddInputCharactersUTF8".}
proc clearInputCharacters*(self: ptr ImGuiIO): void {.importc: "ImGuiIO_ClearInputCharacters".}
proc newImGuiIO*(): void {.importc: "ImGuiIO_ImGuiIO".}
proc destroy*(self: ptr ImGuiIO): void {.importc: "ImGuiIO_destroy".}
proc deleteChars*(self: ptr ImGuiInputTextCallbackData, pos: int32, bytes_count: int32): void {.importc: "ImGuiInputTextCallbackData_DeleteChars".}
proc hasSelection*(self: ptr ImGuiInputTextCallbackData): bool {.importc: "ImGuiInputTextCallbackData_HasSelection".}
proc newImGuiInputTextCallbackData*(): void {.importc: "ImGuiInputTextCallbackData_ImGuiInputTextCallbackData".}
proc insertChars*(self: ptr ImGuiInputTextCallbackData, pos: int32, text: cstring, text_end: cstring = nil): void {.importc: "ImGuiInputTextCallbackData_InsertChars".}
proc destroy*(self: ptr ImGuiInputTextCallbackData): void {.importc: "ImGuiInputTextCallbackData_destroy".}
proc begin*(self: ptr ImGuiListClipper, items_count: int32, items_height: float32 = -1.0f): void {.importc: "ImGuiListClipper_Begin".}
proc `end`*(self: ptr ImGuiListClipper): void {.importc: "ImGuiListClipper_End".}
proc newImGuiListClipper*(items_count: int32 = -1, items_height: float32 = -1.0f): void {.importc: "ImGuiListClipper_ImGuiListClipper".}
proc step*(self: ptr ImGuiListClipper): bool {.importc: "ImGuiListClipper_Step".}
proc destroy*(self: ptr ImGuiListClipper): void {.importc: "ImGuiListClipper_destroy".}
proc newImGuiOnceUponAFrame*(): void {.importc: "ImGuiOnceUponAFrame_ImGuiOnceUponAFrame".}
proc destroy*(self: ptr ImGuiOnceUponAFrame): void {.importc: "ImGuiOnceUponAFrame_destroy".}
proc clear*(self: ptr ImGuiPayload): void {.importc: "ImGuiPayload_Clear".}
proc newImGuiPayload*(): void {.importc: "ImGuiPayload_ImGuiPayload".}
proc isDataType*(self: ptr ImGuiPayload, `type`: cstring): bool {.importc: "ImGuiPayload_IsDataType".}
proc isDelivery*(self: ptr ImGuiPayload): bool {.importc: "ImGuiPayload_IsDelivery".}
proc isPreview*(self: ptr ImGuiPayload): bool {.importc: "ImGuiPayload_IsPreview".}
proc destroy*(self: ptr ImGuiPayload): void {.importc: "ImGuiPayload_destroy".}
proc newImGuiStoragePair*(key: ImGuiID, val_i: int32): void {.importc: "ImGuiStoragePair_ImGuiStoragePairInt".}
proc newImGuiStoragePair*(key: ImGuiID, val_f: float32): void {.importc: "ImGuiStoragePair_ImGuiStoragePairFloat".}
proc newImGuiStoragePair*(key: ImGuiID, val_p: pointer): void {.importc: "ImGuiStoragePair_ImGuiStoragePairPtr".}
proc destroy*(self: ptr ImGuiStoragePair): void {.importc: "ImGuiStoragePair_destroy".}
proc buildSortByKey*(self: ptr ImGuiStorage): void {.importc: "ImGuiStorage_BuildSortByKey".}
proc clear*(self: ptr ImGuiStorage): void {.importc: "ImGuiStorage_Clear".}
proc getBool*(self: ptr ImGuiStorage, key: ImGuiID, default_val: bool = false): bool {.importc: "ImGuiStorage_GetBool".}
proc getBoolRef*(self: ptr ImGuiStorage, key: ImGuiID, default_val: bool = false): ptr bool {.importc: "ImGuiStorage_GetBoolRef".}
proc getFloat*(self: ptr ImGuiStorage, key: ImGuiID, default_val: float32 = 0.0f): float32 {.importc: "ImGuiStorage_GetFloat".}
proc getFloatRef*(self: ptr ImGuiStorage, key: ImGuiID, default_val: float32 = 0.0f): ptr float32 {.importc: "ImGuiStorage_GetFloatRef".}
proc getInt*(self: ptr ImGuiStorage, key: ImGuiID, default_val: int32 = 0): int32 {.importc: "ImGuiStorage_GetInt".}
proc getIntRef*(self: ptr ImGuiStorage, key: ImGuiID, default_val: int32 = 0): ptr int32 {.importc: "ImGuiStorage_GetIntRef".}
proc getVoidPtr*(self: ptr ImGuiStorage, key: ImGuiID): pointer {.importc: "ImGuiStorage_GetVoidPtr".}
proc getVoidPtrRef*(self: ptr ImGuiStorage, key: ImGuiID, default_val: pointer = nil): ptr pointer {.importc: "ImGuiStorage_GetVoidPtrRef".}
proc setAllInt*(self: ptr ImGuiStorage, val: int32): void {.importc: "ImGuiStorage_SetAllInt".}
proc setBool*(self: ptr ImGuiStorage, key: ImGuiID, val: bool): void {.importc: "ImGuiStorage_SetBool".}
proc setFloat*(self: ptr ImGuiStorage, key: ImGuiID, val: float32): void {.importc: "ImGuiStorage_SetFloat".}
proc setInt*(self: ptr ImGuiStorage, key: ImGuiID, val: int32): void {.importc: "ImGuiStorage_SetInt".}
proc setVoidPtr*(self: ptr ImGuiStorage, key: ImGuiID, val: pointer): void {.importc: "ImGuiStorage_SetVoidPtr".}
proc newImGuiStyle*(): void {.importc: "ImGuiStyle_ImGuiStyle".}
proc scaleAllSizes*(self: ptr ImGuiStyle, scale_factor: float32): void {.importc: "ImGuiStyle_ScaleAllSizes".}
proc destroy*(self: ptr ImGuiStyle): void {.importc: "ImGuiStyle_destroy".}
proc newImGuiTextBuffer*(): void {.importc: "ImGuiTextBuffer_ImGuiTextBuffer".}
proc append*(self: ptr ImGuiTextBuffer, str: cstring, str_end: cstring = nil): void {.importc: "ImGuiTextBuffer_append".}
proc appendf*(self: ptr ImGuiTextBuffer, fmt: cstring): void {.importc: "ImGuiTextBuffer_appendf", varargs.}
proc appendfv*(self: ptr ImGuiTextBuffer, fmt: cstring): void {.importc: "ImGuiTextBuffer_appendfv", varargs.}
proc begin*(self: ptr ImGuiTextBuffer): cstring {.importc: "ImGuiTextBuffer_begin".}
proc c_str*(self: ptr ImGuiTextBuffer): cstring {.importc: "ImGuiTextBuffer_c_str".}
proc clear*(self: ptr ImGuiTextBuffer): void {.importc: "ImGuiTextBuffer_clear".}
proc destroy*(self: ptr ImGuiTextBuffer): void {.importc: "ImGuiTextBuffer_destroy".}
proc empty*(self: ptr ImGuiTextBuffer): bool {.importc: "ImGuiTextBuffer_empty".}
proc `end`*(self: ptr ImGuiTextBuffer): cstring {.importc: "ImGuiTextBuffer_end".}
proc reserve*(self: ptr ImGuiTextBuffer, capacity: int32): void {.importc: "ImGuiTextBuffer_reserve".}
proc size*(self: ptr ImGuiTextBuffer): int32 {.importc: "ImGuiTextBuffer_size".}
proc build*(self: ptr ImGuiTextFilter): void {.importc: "ImGuiTextFilter_Build".}
proc clear*(self: ptr ImGuiTextFilter): void {.importc: "ImGuiTextFilter_Clear".}
proc draw*(self: ptr ImGuiTextFilter, label: cstring = "Filter(inc,-exc)", width: float32 = 0.0f): bool {.importc: "ImGuiTextFilter_Draw".}
proc newImGuiTextFilter*(default_filter: cstring = ""): void {.importc: "ImGuiTextFilter_ImGuiTextFilter".}
proc isActive*(self: ptr ImGuiTextFilter): bool {.importc: "ImGuiTextFilter_IsActive".}
proc passFilter*(self: ptr ImGuiTextFilter, text: cstring, text_end: cstring = nil): bool {.importc: "ImGuiTextFilter_PassFilter".}
proc destroy*(self: ptr ImGuiTextFilter): void {.importc: "ImGuiTextFilter_destroy".}
proc newImGuiTextRange*(): void {.importc: "ImGuiTextRange_ImGuiTextRange".}
proc newImGuiTextRange*(b: cstring, e: cstring): void {.importc: "ImGuiTextRange_ImGuiTextRangeStr".}
proc destroy*(self: ptr ImGuiTextRange): void {.importc: "ImGuiTextRange_destroy".}
proc empty*(self: ptr ImGuiTextRange): bool {.importc: "ImGuiTextRange_empty".}
proc split*(self: ptr ImGuiTextRange, separator: int8, `out`: ptr ImVector[ImGuiTextRange]): void {.importc: "ImGuiTextRange_split".}
proc newImVec2*(): void {.importc: "ImVec2_ImVec2".}
proc newImVec2*(x: float32, y: float32): void {.importc: "ImVec2_ImVec2Float".}
proc destroy*(self: ptr ImVec2): void {.importc: "ImVec2_destroy".}
proc newImVec4*(): void {.importc: "ImVec4_ImVec4".}
proc newImVec4*(x: float32, y: float32, z: float32, w: float32): void {.importc: "ImVec4_ImVec4Float".}
proc destroy*(self: ptr ImVec4): void {.importc: "ImVec4_destroy".}
proc grow_capacity*(self: ptr ImVector, sz: int32): int32 {.importc: "ImVector__grow_capacity".}
proc back*[T](self: ptr ImVector): ptr T {.importc: "ImVector_back".}
proc begin*[T](self: ptr ImVector): ptr T {.importc: "ImVector_begin".}
proc capacity*(self: ptr ImVector): int32 {.importc: "ImVector_capacity".}
proc clear*(self: ptr ImVector): void {.importc: "ImVector_clear".}
proc contains*[T](self: ptr ImVector, v: T): bool {.importc: "ImVector_contains".}
proc destroy*(self: ptr ImVector): void {.importc: "ImVector_destroy".}
proc empty*(self: ptr ImVector): bool {.importc: "ImVector_empty".}
proc `end`*[T](self: ptr ImVector): ptr T {.importc: "ImVector_end".}
proc erase*[T](self: ptr ImVector, it: ptr T): ptr T {.importc: "ImVector_erase".}
proc erase*[T](self: ptr ImVector, it: ptr T, it_last: ptr T): ptr T {.importc: "ImVector_eraseTPtr".}
proc erase_unsorted*[T](self: ptr ImVector, it: ptr T): ptr T {.importc: "ImVector_erase_unsorted".}
proc find*[T](self: ptr ImVector, v: T): ptr T {.importc: "ImVector_find".}
proc find_erase*[T](self: ptr ImVector, v: T): bool {.importc: "ImVector_find_erase".}
proc find_erase_unsorted*[T](self: ptr ImVector, v: T): bool {.importc: "ImVector_find_erase_unsorted".}
proc front*[T](self: ptr ImVector): ptr T {.importc: "ImVector_front".}
proc index_from_ptr*[T](self: ptr ImVector, it: ptr T): int32 {.importc: "ImVector_index_from_ptr".}
proc insert*[T](self: ptr ImVector, it: ptr T, v: T): ptr T {.importc: "ImVector_insert".}
proc pop_back*(self: ptr ImVector): void {.importc: "ImVector_pop_back".}
proc push_back*[T](self: ptr ImVector, v: T): void {.importc: "ImVector_push_back".}
proc push_front*[T](self: ptr ImVector, v: T): void {.importc: "ImVector_push_front".}
proc reserve*(self: ptr ImVector, new_capacity: int32): void {.importc: "ImVector_reserve".}
proc resize*(self: ptr ImVector, new_size: int32): void {.importc: "ImVector_resize".}
proc resize*[T](self: ptr ImVector, new_size: int32, v: T): void {.importc: "ImVector_resizeT".}
proc size*(self: ptr ImVector): int32 {.importc: "ImVector_size".}
proc size_in_bytes*(self: ptr ImVector): int32 {.importc: "ImVector_size_in_bytes".}
proc swap*(self: ptr ImVector, rhs: ImVector): void {.importc: "ImVector_swap".}
proc igAcceptDragDropPayload*(`type`: cstring, flags: ImGuiDragDropFlags = 0.ImGuiDragDropFlags): ptr ImGuiPayload {.importc: "igAcceptDragDropPayload".}
proc igAlignTextToFramePadding*(): void {.importc: "igAlignTextToFramePadding".}
proc igArrowButton*(str_id: cstring, dir: ImGuiDir): bool {.importc: "igArrowButton".}
proc igBegin*(name: cstring, p_open: ptr bool = nil, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBegin".}
proc igBeginChild*(str_id: cstring, size: ImVec2 = ImVec2(x: 0, y: 0), border: bool = false, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBeginChild".}
proc igBeginChild*(id: ImGuiID, size: ImVec2 = ImVec2(x: 0, y: 0), border: bool = false, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBeginChildID".}
proc igBeginChildFrame*(id: ImGuiID, size: ImVec2, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBeginChildFrame".}
proc igBeginCombo*(label: cstring, preview_value: cstring, flags: ImGuiComboFlags = 0.ImGuiComboFlags): bool {.importc: "igBeginCombo".}
proc igBeginDragDropSource*(flags: ImGuiDragDropFlags = 0.ImGuiDragDropFlags): bool {.importc: "igBeginDragDropSource".}
proc igBeginDragDropTarget*(): bool {.importc: "igBeginDragDropTarget".}
proc igBeginGroup*(): void {.importc: "igBeginGroup".}
proc igBeginMainMenuBar*(): bool {.importc: "igBeginMainMenuBar".}
proc igBeginMenu*(label: cstring, enabled: bool = true): bool {.importc: "igBeginMenu".}
proc igBeginMenuBar*(): bool {.importc: "igBeginMenuBar".}
proc igBeginPopup*(str_id: cstring, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBeginPopup".}
proc igBeginPopupContextItem*(str_id: cstring = nil, mouse_button: int32 = 1): bool {.importc: "igBeginPopupContextItem".}
proc igBeginPopupContextVoid*(str_id: cstring = nil, mouse_button: int32 = 1): bool {.importc: "igBeginPopupContextVoid".}
proc igBeginPopupContextWindow*(str_id: cstring = nil, mouse_button: int32 = 1, also_over_items: bool = true): bool {.importc: "igBeginPopupContextWindow".}
proc igBeginPopupModal*(name: cstring, p_open: ptr bool = nil, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBeginPopupModal".}
proc igBeginTabBar*(str_id: cstring, flags: ImGuiTabBarFlags = 0.ImGuiTabBarFlags): bool {.importc: "igBeginTabBar".}
proc igBeginTabItem*(label: cstring, p_open: ptr bool = nil, flags: ImGuiTabItemFlags = 0.ImGuiTabItemFlags): bool {.importc: "igBeginTabItem".}
proc igBeginTooltip*(): void {.importc: "igBeginTooltip".}
proc igBullet*(): void {.importc: "igBullet".}
proc igBulletText*(fmt: cstring): void {.importc: "igBulletText", varargs.}
proc igBulletTextV*(fmt: cstring): void {.importc: "igBulletTextV", varargs.}
proc igButton*(label: cstring, size: ImVec2 = ImVec2(x: 0, y: 0)): bool {.importc: "igButton".}
proc igCalcItemWidth*(): float32 {.importc: "igCalcItemWidth".}
proc igCalcListClipping*(items_count: int32, items_height: float32, out_items_display_start: ptr int32, out_items_display_end: ptr int32): void {.importc: "igCalcListClipping".}
proc igCalcTextSize*(text: cstring, text_end: cstring = nil, hide_text_after_double_hash: bool = false, wrap_width: float32 = -1.0f): ImVec2 {.importc: "igCalcTextSize".}
proc igCaptureKeyboardFromApp*(want_capture_keyboard_value: bool = true): void {.importc: "igCaptureKeyboardFromApp".}
proc igCaptureMouseFromApp*(want_capture_mouse_value: bool = true): void {.importc: "igCaptureMouseFromApp".}
proc igCheckbox*(label: cstring, v: ptr bool): bool {.importc: "igCheckbox".}
proc igCheckboxFlags*(label: cstring, flags: ptr uint32, flags_value: uint32): bool {.importc: "igCheckboxFlags".}
proc igCloseCurrentPopup*(): void {.importc: "igCloseCurrentPopup".}
proc igCollapsingHeader*(label: cstring, flags: ImGuiTreeNodeFlags = 0.ImGuiTreeNodeFlags): bool {.importc: "igCollapsingHeader".}
proc igCollapsingHeader*(label: cstring, p_open: ptr bool, flags: ImGuiTreeNodeFlags = 0.ImGuiTreeNodeFlags): bool {.importc: "igCollapsingHeaderBoolPtr".}
proc igColorButton*(desc_id: cstring, col: ImVec4, flags: ImGuiColorEditFlags = 0.ImGuiColorEditFlags, size: ImVec2 = ImVec2(x: 0, y: 0)): bool {.importc: "igColorButton".}
proc igColorConvertFloat4ToU32*(`in`: ImVec4): uint32 {.importc: "igColorConvertFloat4ToU32".}
proc igColorConvertHSVtoRGB*(h: float32, s: float32, v: float32, out_r: float32, out_g: float32, out_b: float32): void {.importc: "igColorConvertHSVtoRGB".}
proc igColorConvertRGBtoHSV*(r: float32, g: float32, b: float32, out_h: float32, out_s: float32, out_v: float32): void {.importc: "igColorConvertRGBtoHSV".}
proc igColorConvertU32ToFloat4*(`in`: uint32): ImVec4 {.importc: "igColorConvertU32ToFloat4".}
proc igColorEdit3*(label: cstring, col: var array[3, float32], flags: ImGuiColorEditFlags = 0.ImGuiColorEditFlags): bool {.importc: "igColorEdit3".}
proc igColorEdit4*(label: cstring, col: var array[4, float32], flags: ImGuiColorEditFlags = 0.ImGuiColorEditFlags): bool {.importc: "igColorEdit4".}
proc igColorPicker3*(label: cstring, col: var array[3, float32], flags: ImGuiColorEditFlags = 0.ImGuiColorEditFlags): bool {.importc: "igColorPicker3".}
proc igColorPicker4*(label: cstring, col: var array[4, float32], flags: ImGuiColorEditFlags = 0.ImGuiColorEditFlags, ref_col: ptr float32 = nil): bool {.importc: "igColorPicker4".}
proc igColumns*(count: int32 = 1, id: cstring = nil, border: bool = true): void {.importc: "igColumns".}
proc igCombo*(label: cstring, current_item: ptr int32, items: ptr cstring, items_count: int32, popup_max_height_in_items: int32 = -1): bool {.importc: "igCombo".}
proc igCombo*(label: cstring, current_item: ptr int32, items_separated_by_zeros: cstring, popup_max_height_in_items: int32 = -1): bool {.importc: "igComboStr".}
proc igCombo*(label: cstring, current_item: ptr int32, items_getter: proc(data: pointer, idx: int32, out_text: ptr cstring): bool, data: pointer, items_count: int32, popup_max_height_in_items: int32 = -1): bool {.importc: "igComboFnPtr".}
proc igCreateContext*(shared_font_atlas: ptr ImFontAtlas = nil): ptr ImGuiContext {.importc: "igCreateContext".}
proc igDebugCheckVersionAndDataLayout*(version_str: cstring, sz_io: uint, sz_style: uint, sz_vec2: uint, sz_vec4: uint, sz_drawvert: uint, sz_drawidx: uint): bool {.importc: "igDebugCheckVersionAndDataLayout".}
proc igDestroyContext*(ctx: ptr ImGuiContext = nil): void {.importc: "igDestroyContext".}
proc igDragFloat*(label: cstring, v: ptr float32, v_speed: float32 = 1.0f, v_min: float32 = 0.0f, v_max: float32 = 0.0f, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igDragFloat".}
proc igDragFloat2*(label: cstring, v: var array[2, float32], v_speed: float32 = 1.0f, v_min: float32 = 0.0f, v_max: float32 = 0.0f, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igDragFloat2".}
proc igDragFloat3*(label: cstring, v: var array[3, float32], v_speed: float32 = 1.0f, v_min: float32 = 0.0f, v_max: float32 = 0.0f, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igDragFloat3".}
proc igDragFloat4*(label: cstring, v: var array[4, float32], v_speed: float32 = 1.0f, v_min: float32 = 0.0f, v_max: float32 = 0.0f, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igDragFloat4".}
proc igDragFloatRange2*(label: cstring, v_current_min: ptr float32, v_current_max: ptr float32, v_speed: float32 = 1.0f, v_min: float32 = 0.0f, v_max: float32 = 0.0f, format: cstring = "%.3f", format_max: cstring = nil, power: float32 = 1.0f): bool {.importc: "igDragFloatRange2".}
proc igDragInt*(label: cstring, v: ptr int32, v_speed: float32 = 1.0f, v_min: int32 = 0, v_max: int32 = 0, format: cstring = "%d"): bool {.importc: "igDragInt".}
proc igDragInt2*(label: cstring, v: var array[2, int32], v_speed: float32 = 1.0f, v_min: int32 = 0, v_max: int32 = 0, format: cstring = "%d"): bool {.importc: "igDragInt2".}
proc igDragInt3*(label: cstring, v: var array[3, int32], v_speed: float32 = 1.0f, v_min: int32 = 0, v_max: int32 = 0, format: cstring = "%d"): bool {.importc: "igDragInt3".}
proc igDragInt4*(label: cstring, v: var array[4, int32], v_speed: float32 = 1.0f, v_min: int32 = 0, v_max: int32 = 0, format: cstring = "%d"): bool {.importc: "igDragInt4".}
proc igDragIntRange2*(label: cstring, v_current_min: ptr int32, v_current_max: ptr int32, v_speed: float32 = 1.0f, v_min: int32 = 0, v_max: int32 = 0, format: cstring = "%d", format_max: cstring = nil): bool {.importc: "igDragIntRange2".}
proc igDragScalar*(label: cstring, data_type: ImGuiDataType, v: pointer, v_speed: float32, v_min: pointer = nil, v_max: pointer = nil, format: cstring = nil, power: float32 = 1.0f): bool {.importc: "igDragScalar".}
proc igDragScalarN*(label: cstring, data_type: ImGuiDataType, v: pointer, components: int32, v_speed: float32, v_min: pointer = nil, v_max: pointer = nil, format: cstring = nil, power: float32 = 1.0f): bool {.importc: "igDragScalarN".}
proc igDummy*(size: ImVec2): void {.importc: "igDummy".}
proc igEnd*(): void {.importc: "igEnd".}
proc igEndChild*(): void {.importc: "igEndChild".}
proc igEndChildFrame*(): void {.importc: "igEndChildFrame".}
proc igEndCombo*(): void {.importc: "igEndCombo".}
proc igEndDragDropSource*(): void {.importc: "igEndDragDropSource".}
proc igEndDragDropTarget*(): void {.importc: "igEndDragDropTarget".}
proc igEndFrame*(): void {.importc: "igEndFrame".}
proc igEndGroup*(): void {.importc: "igEndGroup".}
proc igEndMainMenuBar*(): void {.importc: "igEndMainMenuBar".}
proc igEndMenu*(): void {.importc: "igEndMenu".}
proc igEndMenuBar*(): void {.importc: "igEndMenuBar".}
proc igEndPopup*(): void {.importc: "igEndPopup".}
proc igEndTabBar*(): void {.importc: "igEndTabBar".}
proc igEndTabItem*(): void {.importc: "igEndTabItem".}
proc igEndTooltip*(): void {.importc: "igEndTooltip".}
proc igGetBackgroundDrawList*(): ptr ImDrawList {.importc: "igGetBackgroundDrawList".}
proc igGetClipboardText*(): cstring {.importc: "igGetClipboardText".}
proc igGetColorU32*(idx: ImGuiCol, alpha_mul: float32 = 1.0f): uint32 {.importc: "igGetColorU32".}
proc igGetColorU32*(col: ImVec4): uint32 {.importc: "igGetColorU32Vec4".}
proc igGetColorU32*(col: uint32): uint32 {.importc: "igGetColorU32U32".}
proc igGetColumnIndex*(): int32 {.importc: "igGetColumnIndex".}
proc igGetColumnOffset*(column_index: int32 = -1): float32 {.importc: "igGetColumnOffset".}
proc igGetColumnWidth*(column_index: int32 = -1): float32 {.importc: "igGetColumnWidth".}
proc igGetColumnsCount*(): int32 {.importc: "igGetColumnsCount".}
proc igGetContentRegionAvail*(): ImVec2 {.importc: "igGetContentRegionAvail".}
proc igGetContentRegionMax*(): ImVec2 {.importc: "igGetContentRegionMax".}
proc igGetCurrentContext*(): ptr ImGuiContext {.importc: "igGetCurrentContext".}
proc igGetCursorPos*(): ImVec2 {.importc: "igGetCursorPos".}
proc igGetCursorPosX*(): float32 {.importc: "igGetCursorPosX".}
proc igGetCursorPosY*(): float32 {.importc: "igGetCursorPosY".}
proc igGetCursorScreenPos*(): ImVec2 {.importc: "igGetCursorScreenPos".}
proc igGetCursorStartPos*(): ImVec2 {.importc: "igGetCursorStartPos".}
proc igGetDragDropPayload*(): ptr ImGuiPayload {.importc: "igGetDragDropPayload".}
proc igGetDrawData*(): ptr ImDrawData {.importc: "igGetDrawData".}
proc igGetDrawListSharedData*(): ptr ImDrawListSharedData {.importc: "igGetDrawListSharedData".}
proc igGetFont*(): ptr ImFont {.importc: "igGetFont".}
proc igGetFontSize*(): float32 {.importc: "igGetFontSize".}
proc igGetFontTexUvWhitePixel*(): ImVec2 {.importc: "igGetFontTexUvWhitePixel".}
proc igGetForegroundDrawList*(): ptr ImDrawList {.importc: "igGetForegroundDrawList".}
proc igGetFrameCount*(): int32 {.importc: "igGetFrameCount".}
proc igGetFrameHeight*(): float32 {.importc: "igGetFrameHeight".}
proc igGetFrameHeightWithSpacing*(): float32 {.importc: "igGetFrameHeightWithSpacing".}
proc igGetID*(str_id: cstring): ImGuiID {.importc: "igGetIDStr".}
proc igGetID*(str_id_begin: cstring, str_id_end: cstring): ImGuiID {.importc: "igGetIDRange".}
proc igGetID*(ptr_id: pointer): ImGuiID {.importc: "igGetIDPtr".}
proc igGetIO*(): ptr ImGuiIO {.importc: "igGetIO".}
proc igGetItemRectMax*(): ImVec2 {.importc: "igGetItemRectMax".}
proc igGetItemRectMin*(): ImVec2 {.importc: "igGetItemRectMin".}
proc igGetItemRectSize*(): ImVec2 {.importc: "igGetItemRectSize".}
proc igGetKeyIndex*(imgui_key: ImGuiKey): int32 {.importc: "igGetKeyIndex".}
proc igGetKeyPressedAmount*(key_index: int32, repeat_delay: float32, rate: float32): int32 {.importc: "igGetKeyPressedAmount".}
proc igGetMouseCursor*(): ImGuiMouseCursor {.importc: "igGetMouseCursor".}
proc igGetMouseDragDelta*(button: int32 = 0, lock_threshold: float32 = -1.0f): ImVec2 {.importc: "igGetMouseDragDelta".}
proc igGetMousePos*(): ImVec2 {.importc: "igGetMousePos".}
proc igGetMousePosOnOpeningCurrentPopup*(): ImVec2 {.importc: "igGetMousePosOnOpeningCurrentPopup".}
proc igGetScrollMaxX*(): float32 {.importc: "igGetScrollMaxX".}
proc igGetScrollMaxY*(): float32 {.importc: "igGetScrollMaxY".}
proc igGetScrollX*(): float32 {.importc: "igGetScrollX".}
proc igGetScrollY*(): float32 {.importc: "igGetScrollY".}
proc igGetStateStorage*(): ptr ImGuiStorage {.importc: "igGetStateStorage".}
proc igGetStyle*(): ptr ImGuiStyle {.importc: "igGetStyle".}
proc igGetStyleColorName*(idx: ImGuiCol): cstring {.importc: "igGetStyleColorName".}
proc igGetStyleColorVec4*(idx: ImGuiCol): ptr ImVec4 {.importc: "igGetStyleColorVec4".}
proc igGetTextLineHeight*(): float32 {.importc: "igGetTextLineHeight".}
proc igGetTextLineHeightWithSpacing*(): float32 {.importc: "igGetTextLineHeightWithSpacing".}
proc igGetTime*(): float64 {.importc: "igGetTime".}
proc igGetTreeNodeToLabelSpacing*(): float32 {.importc: "igGetTreeNodeToLabelSpacing".}
proc igGetVersion*(): cstring {.importc: "igGetVersion".}
proc igGetWindowContentRegionMax*(): ImVec2 {.importc: "igGetWindowContentRegionMax".}
proc igGetWindowContentRegionMin*(): ImVec2 {.importc: "igGetWindowContentRegionMin".}
proc igGetWindowContentRegionWidth*(): float32 {.importc: "igGetWindowContentRegionWidth".}
proc igGetWindowDrawList*(): ptr ImDrawList {.importc: "igGetWindowDrawList".}
proc igGetWindowHeight*(): float32 {.importc: "igGetWindowHeight".}
proc igGetWindowPos*(): ImVec2 {.importc: "igGetWindowPos".}
proc igGetWindowSize*(): ImVec2 {.importc: "igGetWindowSize".}
proc igGetWindowWidth*(): float32 {.importc: "igGetWindowWidth".}
proc igImage*(user_texture_id: ImTextureID, size: ImVec2, uv0: ImVec2 = ImVec2(x: 0, y: 0), uv1: ImVec2 = ImVec2(x: 1, y: 1), tint_col: ImVec4 = ImVec4(x: 1, y: 1, z: 1, w: 1), border_col: ImVec4 = ImVec4(x: 0, y: 0, z: 0, w: 0)): void {.importc: "igImage".}
proc igImageButton*(user_texture_id: ImTextureID, size: ImVec2, uv0: ImVec2 = ImVec2(x: 0, y: 0), uv1: ImVec2 = ImVec2(x: 1, y: 1), frame_padding: int32 = -1, bg_col: ImVec4 = ImVec4(x: 0, y: 0, z: 0, w: 0), tint_col: ImVec4 = ImVec4(x: 1, y: 1, z: 1, w: 1)): bool {.importc: "igImageButton".}
proc igIndent*(indent_w: float32 = 0.0f): void {.importc: "igIndent".}
proc igInputDouble*(label: cstring, v: ptr float64, step: float64 = 0.0, step_fast: float64 = 0.0, format: cstring = "%.6f", flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputDouble".}
proc igInputFloat*(label: cstring, v: ptr float32, step: float32 = 0.0f, step_fast: float32 = 0.0f, format: cstring = "%.3f", flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputFloat".}
proc igInputFloat2*(label: cstring, v: var array[2, float32], format: cstring = "%.3f", flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputFloat2".}
proc igInputFloat3*(label: cstring, v: var array[3, float32], format: cstring = "%.3f", flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputFloat3".}
proc igInputFloat4*(label: cstring, v: var array[4, float32], format: cstring = "%.3f", flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputFloat4".}
proc igInputInt*(label: cstring, v: ptr int32, step: int32 = 1, step_fast: int32 = 100, flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputInt".}
proc igInputInt2*(label: cstring, v: var array[2, int32], flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputInt2".}
proc igInputInt3*(label: cstring, v: var array[3, int32], flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputInt3".}
proc igInputInt4*(label: cstring, v: var array[4, int32], flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputInt4".}
proc igInputScalar*(label: cstring, data_type: ImGuiDataType, v: pointer, step: pointer = nil, step_fast: pointer = nil, format: cstring = nil, flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputScalar".}
proc igInputScalarN*(label: cstring, data_type: ImGuiDataType, v: pointer, components: int32, step: pointer = nil, step_fast: pointer = nil, format: cstring = nil, flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputScalarN".}
proc igInputText*(label: cstring, buf: cstring, buf_size: uint, flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags, callback: ImGuiInputTextCallback = nil, user_data: pointer = nil): bool {.importc: "igInputText".}
proc igInputTextMultiline*(label: cstring, buf: cstring, buf_size: uint, size: ImVec2 = ImVec2(x: 0, y: 0), flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags, callback: ImGuiInputTextCallback = nil, user_data: pointer = nil): bool {.importc: "igInputTextMultiline".}
proc igInputTextWithHint*(label: cstring, hint: cstring, buf: cstring, buf_size: uint, flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags, callback: ImGuiInputTextCallback = nil, user_data: pointer = nil): bool {.importc: "igInputTextWithHint".}
proc igInvisibleButton*(str_id: cstring, size: ImVec2): bool {.importc: "igInvisibleButton".}
proc igIsAnyItemActive*(): bool {.importc: "igIsAnyItemActive".}
proc igIsAnyItemFocused*(): bool {.importc: "igIsAnyItemFocused".}
proc igIsAnyItemHovered*(): bool {.importc: "igIsAnyItemHovered".}
proc igIsAnyMouseDown*(): bool {.importc: "igIsAnyMouseDown".}
proc igIsItemActivated*(): bool {.importc: "igIsItemActivated".}
proc igIsItemActive*(): bool {.importc: "igIsItemActive".}
proc igIsItemClicked*(mouse_button: int32 = 0): bool {.importc: "igIsItemClicked".}
proc igIsItemDeactivated*(): bool {.importc: "igIsItemDeactivated".}
proc igIsItemDeactivatedAfterEdit*(): bool {.importc: "igIsItemDeactivatedAfterEdit".}
proc igIsItemEdited*(): bool {.importc: "igIsItemEdited".}
proc igIsItemFocused*(): bool {.importc: "igIsItemFocused".}
proc igIsItemHovered*(flags: ImGuiHoveredFlags = 0.ImGuiHoveredFlags): bool {.importc: "igIsItemHovered".}
proc igIsItemVisible*(): bool {.importc: "igIsItemVisible".}
proc igIsKeyDown*(user_key_index: int32): bool {.importc: "igIsKeyDown".}
proc igIsKeyPressed*(user_key_index: int32, repeat: bool = true): bool {.importc: "igIsKeyPressed".}
proc igIsKeyReleased*(user_key_index: int32): bool {.importc: "igIsKeyReleased".}
proc igIsMouseClicked*(button: int32, repeat: bool = false): bool {.importc: "igIsMouseClicked".}
proc igIsMouseDoubleClicked*(button: int32): bool {.importc: "igIsMouseDoubleClicked".}
proc igIsMouseDown*(button: int32): bool {.importc: "igIsMouseDown".}
proc igIsMouseDragging*(button: int32 = 0, lock_threshold: float32 = -1.0f): bool {.importc: "igIsMouseDragging".}
proc igIsMouseHoveringRect*(r_min: ImVec2, r_max: ImVec2, clip: bool = true): bool {.importc: "igIsMouseHoveringRect".}
proc igIsMousePosValid*(mouse_pos: ptr ImVec2 = nil): bool {.importc: "igIsMousePosValid".}
proc igIsMouseReleased*(button: int32): bool {.importc: "igIsMouseReleased".}
proc igIsPopupOpen*(str_id: cstring): bool {.importc: "igIsPopupOpen".}
proc igIsRectVisible*(size: ImVec2): bool {.importc: "igIsRectVisible".}
proc igIsRectVisible*(rect_min: ImVec2, rect_max: ImVec2): bool {.importc: "igIsRectVisibleVec2".}
proc igIsWindowAppearing*(): bool {.importc: "igIsWindowAppearing".}
proc igIsWindowCollapsed*(): bool {.importc: "igIsWindowCollapsed".}
proc igIsWindowFocused*(flags: ImGuiFocusedFlags = 0.ImGuiFocusedFlags): bool {.importc: "igIsWindowFocused".}
proc igIsWindowHovered*(flags: ImGuiHoveredFlags = 0.ImGuiHoveredFlags): bool {.importc: "igIsWindowHovered".}
proc igLabelText*(label: cstring, fmt: cstring): void {.importc: "igLabelText", varargs.}
proc igLabelTextV*(label: cstring, fmt: cstring): void {.importc: "igLabelTextV", varargs.}
proc igListBox*(label: cstring, current_item: ptr int32, items: ptr cstring, items_count: int32, height_in_items: int32 = -1): bool {.importc: "igListBoxStr_arr".}
proc igListBox*(label: cstring, current_item: ptr int32, items_getter: proc(data: pointer, idx: int32, out_text: ptr cstring): bool, data: pointer, items_count: int32, height_in_items: int32 = -1): bool {.importc: "igListBoxFnPtr".}
proc igListBoxFooter*(): void {.importc: "igListBoxFooter".}
proc igListBoxHeader*(label: cstring, size: ImVec2 = ImVec2(x: 0, y: 0)): bool {.importc: "igListBoxHeaderVec2".}
proc igListBoxHeader*(label: cstring, items_count: int32, height_in_items: int32 = -1): bool {.importc: "igListBoxHeaderInt".}
proc igLoadIniSettingsFromDisk*(ini_filename: cstring): void {.importc: "igLoadIniSettingsFromDisk".}
proc igLoadIniSettingsFromMemory*(ini_data: cstring, ini_size: uint = 0): void {.importc: "igLoadIniSettingsFromMemory".}
proc igLogButtons*(): void {.importc: "igLogButtons".}
proc igLogFinish*(): void {.importc: "igLogFinish".}
proc igLogText*(fmt: cstring): void {.importc: "igLogText", varargs.}
proc igLogToClipboard*(auto_open_depth: int32 = -1): void {.importc: "igLogToClipboard".}
proc igLogToFile*(auto_open_depth: int32 = -1, filename: cstring = nil): void {.importc: "igLogToFile".}
proc igLogToTTY*(auto_open_depth: int32 = -1): void {.importc: "igLogToTTY".}
proc igMemAlloc*(size: uint): pointer {.importc: "igMemAlloc".}
proc igMemFree*(`ptr`: pointer): void {.importc: "igMemFree".}
proc igMenuItem*(label: cstring, shortcut: cstring = nil, selected: bool = false, enabled: bool = true): bool {.importc: "igMenuItemBool".}
proc igMenuItem*(label: cstring, shortcut: cstring, p_selected: ptr bool, enabled: bool = true): bool {.importc: "igMenuItemBoolPtr".}
proc igNewFrame*(): void {.importc: "igNewFrame".}
proc igNewLine*(): void {.importc: "igNewLine".}
proc igNextColumn*(): void {.importc: "igNextColumn".}
proc igOpenPopup*(str_id: cstring): void {.importc: "igOpenPopup".}
proc igOpenPopupOnItemClick*(str_id: cstring = nil, mouse_button: int32 = 1): bool {.importc: "igOpenPopupOnItemClick".}
proc igPlotHistogram*(label: cstring, values: ptr float32, values_count: int32, values_offset: int32 = 0, overlay_text: cstring = nil, scale_min: float32 = high(float32), scale_max: float32 = high(float32), graph_size: ImVec2 = ImVec2(x: 0, y: 0), stride: int32 = sizeof(float32).int32): void {.importc: "igPlotHistogramFloatPtr".}
proc igPlotHistogram*(label: cstring, values_getter: proc(data: pointer, idx: int32): float32, data: pointer, values_count: int32, values_offset: int32 = 0, overlay_text: cstring = nil, scale_min: float32 = high(float32), scale_max: float32 = high(float32), graph_size: ImVec2 = ImVec2(x: 0, y: 0)): void {.importc: "igPlotHistogramFnPtr".}
proc igPlotLines*(label: cstring, values: ptr float32, values_count: int32, values_offset: int32 = 0, overlay_text: cstring = nil, scale_min: float32 = high(float32), scale_max: float32 = high(float32), graph_size: ImVec2 = ImVec2(x: 0, y: 0), stride: int32 = sizeof(float32).int32): void {.importc: "igPlotLines".}
proc igPlotLines*(label: cstring, values_getter: proc(data: pointer, idx: int32): float32, data: pointer, values_count: int32, values_offset: int32 = 0, overlay_text: cstring = nil, scale_min: float32 = high(float32), scale_max: float32 = high(float32), graph_size: ImVec2 = ImVec2(x: 0, y: 0)): void {.importc: "igPlotLinesFnPtr".}
proc igPopAllowKeyboardFocus*(): void {.importc: "igPopAllowKeyboardFocus".}
proc igPopButtonRepeat*(): void {.importc: "igPopButtonRepeat".}
proc igPopClipRect*(): void {.importc: "igPopClipRect".}
proc igPopFont*(): void {.importc: "igPopFont".}
proc igPopID*(): void {.importc: "igPopID".}
proc igPopItemWidth*(): void {.importc: "igPopItemWidth".}
proc igPopStyleColor*(count: int32 = 1): void {.importc: "igPopStyleColor".}
proc igPopStyleVar*(count: int32 = 1): void {.importc: "igPopStyleVar".}
proc igPopTextWrapPos*(): void {.importc: "igPopTextWrapPos".}
proc igProgressBar*(fraction: float32, size_arg: ImVec2 = ImVec2(x: -1, y: 0), overlay: cstring = nil): void {.importc: "igProgressBar".}
proc igPushAllowKeyboardFocus*(allow_keyboard_focus: bool): void {.importc: "igPushAllowKeyboardFocus".}
proc igPushButtonRepeat*(repeat: bool): void {.importc: "igPushButtonRepeat".}
proc igPushClipRect*(clip_rect_min: ImVec2, clip_rect_max: ImVec2, intersect_with_current_clip_rect: bool): void {.importc: "igPushClipRect".}
proc igPushFont*(font: ptr ImFont): void {.importc: "igPushFont".}
proc igPushID*(str_id: cstring): void {.importc: "igPushIDStr".}
proc igPushID*(str_id_begin: cstring, str_id_end: cstring): void {.importc: "igPushIDRange".}
proc igPushID*(ptr_id: pointer): void {.importc: "igPushIDPtr".}
proc igPushID*(int_id: int32): void {.importc: "igPushIDInt".}
proc igPushItemWidth*(item_width: float32): void {.importc: "igPushItemWidth".}
proc igPushStyleColor*(idx: ImGuiCol, col: uint32): void {.importc: "igPushStyleColorU32".}
proc igPushStyleColor*(idx: ImGuiCol, col: ImVec4): void {.importc: "igPushStyleColor".}
proc igPushStyleVar*(idx: ImGuiStyleVar, val: float32): void {.importc: "igPushStyleVarFloat".}
proc igPushStyleVar*(idx: ImGuiStyleVar, val: ImVec2): void {.importc: "igPushStyleVarVec2".}
proc igPushTextWrapPos*(wrap_local_pos_x: float32 = 0.0f): void {.importc: "igPushTextWrapPos".}
proc igRadioButton*(label: cstring, active: bool): bool {.importc: "igRadioButtonBool".}
proc igRadioButton*(label: cstring, v: ptr int32, v_button: int32): bool {.importc: "igRadioButtonIntPtr".}
proc igRender*(): void {.importc: "igRender".}
proc igResetMouseDragDelta*(button: int32 = 0): void {.importc: "igResetMouseDragDelta".}
proc igSameLine*(offset_from_start_x: float32 = 0.0f, spacing: float32 = -1.0f): void {.importc: "igSameLine".}
proc igSaveIniSettingsToDisk*(ini_filename: cstring): void {.importc: "igSaveIniSettingsToDisk".}
proc igSaveIniSettingsToMemory*(out_ini_size: ptr uint = nil): cstring {.importc: "igSaveIniSettingsToMemory".}
proc igSelectable*(label: cstring, selected: bool = false, flags: ImGuiSelectableFlags = 0.ImGuiSelectableFlags, size: ImVec2 = ImVec2(x: 0, y: 0)): bool {.importc: "igSelectable".}
proc igSelectable*(label: cstring, p_selected: ptr bool, flags: ImGuiSelectableFlags = 0.ImGuiSelectableFlags, size: ImVec2 = ImVec2(x: 0, y: 0)): bool {.importc: "igSelectableBoolPtr".}
proc igSeparator*(): void {.importc: "igSeparator".}
proc igSetAllocatorFunctions*(alloc_func: proc(sz: uint, user_data: pointer): pointer, free_func: proc(`ptr`: pointer, user_data: pointer): void, user_data: pointer = nil): void {.importc: "igSetAllocatorFunctions".}
proc igSetClipboardText*(text: cstring): void {.importc: "igSetClipboardText".}
proc igSetColorEditOptions*(flags: ImGuiColorEditFlags): void {.importc: "igSetColorEditOptions".}
proc igSetColumnOffset*(column_index: int32, offset_x: float32): void {.importc: "igSetColumnOffset".}
proc igSetColumnWidth*(column_index: int32, width: float32): void {.importc: "igSetColumnWidth".}
proc igSetCurrentContext*(ctx: ptr ImGuiContext): void {.importc: "igSetCurrentContext".}
proc igSetCursorPos*(local_pos: ImVec2): void {.importc: "igSetCursorPos".}
proc igSetCursorPosX*(local_x: float32): void {.importc: "igSetCursorPosX".}
proc igSetCursorPosY*(local_y: float32): void {.importc: "igSetCursorPosY".}
proc igSetCursorScreenPos*(pos: ImVec2): void {.importc: "igSetCursorScreenPos".}
proc igSetDragDropPayload*(`type`: cstring, data: pointer, sz: uint, cond: ImGuiCond = 0.ImGuiCond): bool {.importc: "igSetDragDropPayload".}
proc igSetItemAllowOverlap*(): void {.importc: "igSetItemAllowOverlap".}
proc igSetItemDefaultFocus*(): void {.importc: "igSetItemDefaultFocus".}
proc igSetKeyboardFocusHere*(offset: int32 = 0): void {.importc: "igSetKeyboardFocusHere".}
proc igSetMouseCursor*(`type`: ImGuiMouseCursor): void {.importc: "igSetMouseCursor".}
proc igSetNextItemOpen*(is_open: bool, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetNextItemOpen".}
proc igSetNextItemWidth*(item_width: float32): void {.importc: "igSetNextItemWidth".}
proc igSetNextWindowBgAlpha*(alpha: float32): void {.importc: "igSetNextWindowBgAlpha".}
proc igSetNextWindowCollapsed*(collapsed: bool, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetNextWindowCollapsed".}
proc igSetNextWindowContentSize*(size: ImVec2): void {.importc: "igSetNextWindowContentSize".}
proc igSetNextWindowFocus*(): void {.importc: "igSetNextWindowFocus".}
proc igSetNextWindowPos*(pos: ImVec2, cond: ImGuiCond = 0.ImGuiCond, pivot: ImVec2 = ImVec2(x: 0, y: 0)): void {.importc: "igSetNextWindowPos".}
proc igSetNextWindowSize*(size: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetNextWindowSize".}
proc igSetNextWindowSizeConstraints*(size_min: ImVec2, size_max: ImVec2, custom_callback: ImGuiSizeCallback = nil, custom_callback_data: pointer = nil): void {.importc: "igSetNextWindowSizeConstraints".}
proc igSetScrollFromPosX*(local_x: float32, center_x_ratio: float32 = 0.5f): void {.importc: "igSetScrollFromPosX".}
proc igSetScrollFromPosY*(local_y: float32, center_y_ratio: float32 = 0.5f): void {.importc: "igSetScrollFromPosY".}
proc igSetScrollHereX*(center_x_ratio: float32 = 0.5f): void {.importc: "igSetScrollHereX".}
proc igSetScrollHereY*(center_y_ratio: float32 = 0.5f): void {.importc: "igSetScrollHereY".}
proc igSetScrollX*(scroll_x: float32): void {.importc: "igSetScrollX".}
proc igSetScrollY*(scroll_y: float32): void {.importc: "igSetScrollY".}
proc igSetStateStorage*(storage: ptr ImGuiStorage): void {.importc: "igSetStateStorage".}
proc igSetTabItemClosed*(tab_or_docked_window_label: cstring): void {.importc: "igSetTabItemClosed".}
proc igSetTooltip*(fmt: cstring): void {.importc: "igSetTooltip", varargs.}
proc igSetTooltipV*(fmt: cstring): void {.importc: "igSetTooltipV", varargs.}
proc igSetWindowCollapsed*(collapsed: bool, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowCollapsedBool".}
proc igSetWindowCollapsed*(name: cstring, collapsed: bool, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowCollapsedStr".}
proc igSetWindowFocus*(): void {.importc: "igSetWindowFocus".}
proc igSetWindowFocus*(name: cstring): void {.importc: "igSetWindowFocusStr".}
proc igSetWindowFontScale*(scale: float32): void {.importc: "igSetWindowFontScale".}
proc igSetWindowPos*(pos: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowPosVec2".}
proc igSetWindowPos*(name: cstring, pos: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowPosStr".}
proc igSetWindowSize*(size: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowSizeVec2".}
proc igSetWindowSize*(name: cstring, size: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowSizeStr".}
proc igShowAboutWindow*(p_open: ptr bool = nil): void {.importc: "igShowAboutWindow".}
proc igShowDemoWindow*(p_open: ptr bool = nil): void {.importc: "igShowDemoWindow".}
proc igShowFontSelector*(label: cstring): void {.importc: "igShowFontSelector".}
proc igShowMetricsWindow*(p_open: ptr bool = nil): void {.importc: "igShowMetricsWindow".}
proc igShowStyleEditor*(`ref`: ptr ImGuiStyle = nil): void {.importc: "igShowStyleEditor".}
proc igShowStyleSelector*(label: cstring): bool {.importc: "igShowStyleSelector".}
proc igShowUserGuide*(): void {.importc: "igShowUserGuide".}
proc igSliderAngle*(label: cstring, v_rad: ptr float32, v_degrees_min: float32 = -360.0f, v_degrees_max: float32 = +360.0f, format: cstring = "%.0f deg"): bool {.importc: "igSliderAngle".}
proc igSliderFloat*(label: cstring, v: ptr float32, v_min: float32, v_max: float32, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igSliderFloat".}
proc igSliderFloat2*(label: cstring, v: var array[2, float32], v_min: float32, v_max: float32, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igSliderFloat2".}
proc igSliderFloat3*(label: cstring, v: var array[3, float32], v_min: float32, v_max: float32, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igSliderFloat3".}
proc igSliderFloat4*(label: cstring, v: var array[4, float32], v_min: float32, v_max: float32, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igSliderFloat4".}
proc igSliderInt*(label: cstring, v: ptr int32, v_min: int32, v_max: int32, format: cstring = "%d"): bool {.importc: "igSliderInt".}
proc igSliderInt2*(label: cstring, v: var array[2, int32], v_min: int32, v_max: int32, format: cstring = "%d"): bool {.importc: "igSliderInt2".}
proc igSliderInt3*(label: cstring, v: var array[3, int32], v_min: int32, v_max: int32, format: cstring = "%d"): bool {.importc: "igSliderInt3".}
proc igSliderInt4*(label: cstring, v: var array[4, int32], v_min: int32, v_max: int32, format: cstring = "%d"): bool {.importc: "igSliderInt4".}
proc igSliderScalar*(label: cstring, data_type: ImGuiDataType, v: pointer, v_min: pointer, v_max: pointer, format: cstring = nil, power: float32 = 1.0f): bool {.importc: "igSliderScalar".}
proc igSliderScalarN*(label: cstring, data_type: ImGuiDataType, v: pointer, components: int32, v_min: pointer, v_max: pointer, format: cstring = nil, power: float32 = 1.0f): bool {.importc: "igSliderScalarN".}
proc igSmallButton*(label: cstring): bool {.importc: "igSmallButton".}
proc igSpacing*(): void {.importc: "igSpacing".}
proc igStyleColorsClassic*(dst: ptr ImGuiStyle = nil): void {.importc: "igStyleColorsClassic".}
proc igStyleColorsDark*(dst: ptr ImGuiStyle = nil): void {.importc: "igStyleColorsDark".}
proc igStyleColorsLight*(dst: ptr ImGuiStyle = nil): void {.importc: "igStyleColorsLight".}
proc igText*(fmt: cstring): void {.importc: "igText", varargs.}
proc igTextColored*(col: ImVec4, fmt: cstring): void {.importc: "igTextColored", varargs.}
proc igTextColoredV*(col: ImVec4, fmt: cstring): void {.importc: "igTextColoredV", varargs.}
proc igTextDisabled*(fmt: cstring): void {.importc: "igTextDisabled", varargs.}
proc igTextDisabledV*(fmt: cstring): void {.importc: "igTextDisabledV", varargs.}
proc igTextUnformatted*(text: cstring, text_end: cstring = nil): void {.importc: "igTextUnformatted".}
proc igTextV*(fmt: cstring): void {.importc: "igTextV", varargs.}
proc igTextWrapped*(fmt: cstring): void {.importc: "igTextWrapped", varargs.}
proc igTextWrappedV*(fmt: cstring): void {.importc: "igTextWrappedV", varargs.}
proc igTreeNode*(label: cstring): bool {.importc: "igTreeNodeStr".}
proc igTreeNode*(str_id: cstring, fmt: cstring): bool {.importc: "igTreeNodeStrStr", varargs.}
proc igTreeNode*(ptr_id: pointer, fmt: cstring): bool {.importc: "igTreeNodePtr", varargs.}
proc igTreeNodeEx*(label: cstring, flags: ImGuiTreeNodeFlags = 0.ImGuiTreeNodeFlags): bool {.importc: "igTreeNodeExStr".}
proc igTreeNodeEx*(str_id: cstring, flags: ImGuiTreeNodeFlags, fmt: cstring): bool {.importc: "igTreeNodeExStrStr", varargs.}
proc igTreeNodeEx*(ptr_id: pointer, flags: ImGuiTreeNodeFlags, fmt: cstring): bool {.importc: "igTreeNodeExPtr", varargs.}
proc igTreeNodeExV*(str_id: cstring, flags: ImGuiTreeNodeFlags, fmt: cstring): bool {.importc: "igTreeNodeExVStr", varargs.}
proc igTreeNodeExV*(ptr_id: pointer, flags: ImGuiTreeNodeFlags, fmt: cstring): bool {.importc: "igTreeNodeExVPtr", varargs.}
proc igTreeNodeV*(str_id: cstring, fmt: cstring): bool {.importc: "igTreeNodeVStr", varargs.}
proc igTreeNodeV*(ptr_id: pointer, fmt: cstring): bool {.importc: "igTreeNodeVPtr", varargs.}
proc igTreePop*(): void {.importc: "igTreePop".}
proc igTreePush*(str_id: cstring): void {.importc: "igTreePushStr".}
proc igTreePush*(ptr_id: pointer = nil): void {.importc: "igTreePushPtr".}
proc igUnindent*(indent_w: float32 = 0.0f): void {.importc: "igUnindent".}
proc igVSliderFloat*(label: cstring, size: ImVec2, v: ptr float32, v_min: float32, v_max: float32, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igVSliderFloat".}
proc igVSliderInt*(label: cstring, size: ImVec2, v: ptr int32, v_min: int32, v_max: int32, format: cstring = "%d"): bool {.importc: "igVSliderInt".}
proc igVSliderScalar*(label: cstring, size: ImVec2, data_type: ImGuiDataType, v: pointer, v_min: pointer, v_max: pointer, format: cstring = nil, power: float32 = 1.0f): bool {.importc: "igVSliderScalar".}
proc igValue*(prefix: cstring, b: bool): void {.importc: "igValueBool".}
proc igValue*(prefix: cstring, v: int32): void {.importc: "igValueInt".}
proc igValue*(prefix: cstring, v: uint32): void {.importc: "igValueUint".}
proc igValue*(prefix: cstring, v: float32, float_format: cstring = nil): void {.importc: "igValueFloat".}

{.pop.}

proc igStyleColorsCherry*(dst: ptr ImGuiStyle = nil): void =
  ## To conmemorate this bindings this style is included as a default.
  ## Style created originally by r-lyeh
  var style = igGetStyle()
  if dst != nil:
    style = dst

  const ImVec4 = proc(x: float32, y: float32, z: float32, w: float32): ImVec4 = ImVec4(x: x, y: y, z: z, w: w)
  const igHI = proc(v: float32): ImVec4 = ImVec4(0.502f, 0.075f, 0.256f, v)
  const igMED = proc(v: float32): ImVec4 = ImVec4(0.455f, 0.198f, 0.301f, v)
  const igLOW = proc(v: float32): ImVec4 = ImVec4(0.232f, 0.201f, 0.271f, v)
  const igBG = proc(v: float32): ImVec4 = ImVec4(0.200f, 0.220f, 0.270f, v)
  const igTEXT = proc(v: float32): ImVec4 = ImVec4(0.860f, 0.930f, 0.890f, v)

  style.colors[ImGuiCol.Text.int32]                 = igTEXT(0.88f)
  style.colors[ImGuiCol.TextDisabled.int32]         = igTEXT(0.28f)
  style.colors[ImGuiCol.WindowBg.int32]             = ImVec4(0.13f, 0.14f, 0.17f, 1.00f)
  style.colors[ImGuiCol.PopupBg.int32]              = igBG(0.9f)
  style.colors[ImGuiCol.Border.int32]               = ImVec4(0.31f, 0.31f, 1.00f, 0.00f)
  style.colors[ImGuiCol.BorderShadow.int32]         = ImVec4(0.00f, 0.00f, 0.00f, 0.00f)
  style.colors[ImGuiCol.FrameBg.int32]              = igBG(1.00f)
  style.colors[ImGuiCol.FrameBgHovered.int32]       = igMED(0.78f)
  style.colors[ImGuiCol.FrameBgActive.int32]        = igMED(1.00f)
  style.colors[ImGuiCol.TitleBg.int32]              = igLOW(1.00f)
  style.colors[ImGuiCol.TitleBgActive.int32]        = igHI(1.00f)
  style.colors[ImGuiCol.TitleBgCollapsed.int32]     = igBG(0.75f)
  style.colors[ImGuiCol.MenuBarBg.int32]            = igBG(0.47f)
  style.colors[ImGuiCol.ScrollbarBg.int32]          = igBG(1.00f)
  style.colors[ImGuiCol.ScrollbarGrab.int32]        = ImVec4(0.09f, 0.15f, 0.16f, 1.00f)
  style.colors[ImGuiCol.ScrollbarGrabHovered.int32] = igMED(0.78f)
  style.colors[ImGuiCol.ScrollbarGrabActive.int32]  = igMED(1.00f)
  style.colors[ImGuiCol.CheckMark.int32]            = ImVec4(0.71f, 0.22f, 0.27f, 1.00f)
  style.colors[ImGuiCol.SliderGrab.int32]           = ImVec4(0.47f, 0.77f, 0.83f, 0.14f)
  style.colors[ImGuiCol.SliderGrabActive.int32]     = ImVec4(0.71f, 0.22f, 0.27f, 1.00f)
  style.colors[ImGuiCol.Button.int32]               = ImVec4(0.47f, 0.77f, 0.83f, 0.14f)
  style.colors[ImGuiCol.ButtonHovered.int32]        = igMED(0.86f)
  style.colors[ImGuiCol.ButtonActive.int32]         = igMED(1.00f)
  style.colors[ImGuiCol.Header.int32]               = igMED(0.76f)
  style.colors[ImGuiCol.HeaderHovered.int32]        = igMED(0.86f)
  style.colors[ImGuiCol.HeaderActive.int32]         = igHI(1.00f)
  style.colors[ImGuiCol.ResizeGrip.int32]           = ImVec4(0.47f, 0.77f, 0.83f, 0.04f)
  style.colors[ImGuiCol.ResizeGripHovered.int32]    = igMED(0.78f)
  style.colors[ImGuiCol.ResizeGripActive.int32]     = igMED(1.00f)
  style.colors[ImGuiCol.PlotLines.int32]            = igTEXT(0.63f)
  style.colors[ImGuiCol.PlotLinesHovered.int32]     = igMED(1.00f)
  style.colors[ImGuiCol.PlotHistogram.int32]        = igTEXT(0.63f)
  style.colors[ImGuiCol.PlotHistogramHovered.int32] = igMED(1.00f)
  style.colors[ImGuiCol.TextSelectedBg.int32]       = igMED(0.43f)

  style.windowPadding     = ImVec2(x: 6f, y: 4f)
  style.windowRounding    = 0.0f
  style.framePadding      = ImVec2(x: 5f, y: 2f)
  style.frameRounding     = 3.0f
  style.itemSpacing       = ImVec2(x: 7f, y: 1f)
  style.itemInnerSpacing  = ImVec2(x: 1f, y: 1f)
  style.touchExtraPadding = ImVec2(x: 0f, y: 0f)
  style.indentSpacing     = 6.0f
  style.scrollbarSize     = 12.0f
  style.scrollbarRounding = 16.0f
  style.grabMinSize       = 20.0f
  style.grabRounding      = 2.0f

  style.windowTitleAlign.x = 0.50f

  style.colors[ImGuiCol.Border.int32] = ImVec4(0.539f, 0.479f, 0.255f, 0.162f)
  style.frameBorderSize  = 0.0f
  style.windowBorderSize = 1.0f

  style.displaySafeAreaPadding.y = 0
  style.framePadding.y = 1
  style.itemSpacing.y = 1
  style.windowPadding.y = 3
  style.scrollbarSize = 13
  style.frameBorderSize = 1
  style.tabBorderSize = 1
