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
when defined(linux):
  {.passL: "-Xlinker -rpath .".}

when not defined(cpp) or defined(cimguiDLL):
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
  ImGuiAxis* {.pure, size: int32.sizeof.} = enum
    None = -1
    X = 0
    Y = 1
  ImGuiBackendFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    HasGamepad = 1
    HasMouseCursors = 2
    HasSetMousePos = 4
    RendererHasVtxOffset = 8
  ImGuiButtonFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Repeat = 1
    PressedOnClick = 2
    PressedOnClickRelease = 4
    PressedOnClickReleaseAnywhere = 8
    PressedOnRelease = 16
    PressedOnDoubleClick = 32
    PressedOnDragDropHold = 64
    PressedOnMask = 126
    FlattenChildren = 128
    AllowItemOverlap = 256
    DontClosePopups = 512
    Disabled = 1024
    AlignTextBaseLine = 2048
    NoKeyModifiers = 4096
    NoHoldingActiveId = 8192
    NoNavFocus = 16384
    NoHoveredOnFocus = 32768
    MouseButtonLeft = 65536
    MouseButtonRight = 131072
    MouseButtonMiddle = 262144
    MouseButtonMask = 458752
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
    NoBorder = 1024
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
  ImGuiColumnsFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoBorder = 1
    NoResize = 2
    NoPreserveWidths = 4
    NoForceWithinWindow = 8
    GrowParentContentsSize = 16
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
  ImGuiDragFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Vertical = 1
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
  ImGuiInputReadMode* {.pure, size: int32.sizeof.} = enum
    Down = 0
    Pressed = 1
    Released = 2
    Repeat = 3
    RepeatSlow = 4
    RepeatFast = 5
  ImGuiInputSource* {.pure, size: int32.sizeof.} = enum
    None = 0
    Mouse = 1
    Nav = 2
    NavKeyboard = 3
    NavGamepad = 4
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
  ImGuiItemFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoTabStop = 1
    ButtonRepeat = 2
    Disabled = 4
    NoNav = 8
    NoNavDefaultFocus = 16
    SelectableDontClosePopup = 32
    MixedValue = 64
  ImGuiItemStatusFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    HoveredRect = 1
    HasDisplayRect = 2
    Edited = 4
    ToggledSelection = 8
    ToggledOpen = 16
    HasDeactivated = 32
    Deactivated = 64
  ImGuiKeyModFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Ctrl = 1
    Shift = 2
    Alt = 4
    Super = 8
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
  ImGuiLayoutType* {.pure, size: int32.sizeof.} = enum
    Horizontal = 0
    Vertical = 1
  ImGuiLogType* {.pure, size: int32.sizeof.} = enum
    None = 0
    TTY = 1
    File = 2
    Buffer = 3
    Clipboard = 4
  ImGuiMouseButton* {.pure, size: int32.sizeof.} = enum
    Left = 0
    Right = 1
    Middle = 2
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
    NotAllowed = 8
  ImGuiNavDirSourceFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Keyboard = 1
    PadDPad = 2
    PadLStick = 4
  ImGuiNavForward* {.pure, size: int32.sizeof.} = enum
    None = 0
    ForwardQueued = 1
    ForwardActive = 2
  ImGuiNavHighlightFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    TypeDefault = 1
    TypeThin = 2
    AlwaysDraw = 4
    NoRounding = 8
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
    KeyLeft = 17
    KeyRight = 18
    KeyUp = 19
    KeyDown = 20
  ImGuiNavLayer* {.pure, size: int32.sizeof.} = enum
    Main = 0
    Menu = 1
  ImGuiNavMoveFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    LoopX = 1
    LoopY = 2
    WrapX = 4
    WrapY = 8
    AllowCurrentNavId = 16
    AlsoScoreVisibleSet = 32
    ScrollToEdge = 64
  ImGuiNextItemDataFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    HasWidth = 1
    HasOpen = 2
  ImGuiNextWindowDataFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    HasPos = 1
    HasSize = 2
    HasContentSize = 4
    HasCollapsed = 8
    HasSizeConstraint = 16
    HasFocus = 32
    HasBgAlpha = 64
  ImGuiPlotType* {.pure, size: int32.sizeof.} = enum
    Lines = 0
    Histogram = 1
  ImGuiPopupPositionPolicy* {.pure, size: int32.sizeof.} = enum
    Default = 0
    ComboBox = 1
  ImGuiSelectableFlagsPrivate* {.pure, size: int32.sizeof.} = enum
    NoHoldingActiveID = 1048576
    SelectOnClick = 2097152
    SelectOnRelease = 4194304
    SpanAvailWidth = 8388608
    DrawHoveredWhenHeld = 16777216
    SetNavIdOnHover = 33554432
  ImGuiSelectableFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    DontClosePopups = 1
    SpanAllColumns = 2
    AllowDoubleClick = 4
    Disabled = 8
    AllowItemOverlap = 16
  ImGuiSeparatorFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Horizontal = 1
    Vertical = 2
    SpanAllColumns = 4
  ImGuiSliderFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    Vertical = 1
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
  ImGuiTabBarFlagsPrivate* {.pure, size: int32.sizeof.} = enum
    DockNode = 1048576
    IsFocused = 2097152
    SaveSettings = 4194304
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
  ImGuiTabItemFlagsPrivate* {.pure, size: int32.sizeof.} = enum
    NoCloseButton = 1048576
  ImGuiTabItemFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    UnsavedDocument = 1
    SetSelected = 2
    NoCloseWithMiddleMouseButton = 4
    NoPushId = 8
  ImGuiTextFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    NoWidthForLargeClippedText = 1
  ImGuiTooltipFlags* {.pure, size: int32.sizeof.} = enum
    None = 0
    OverridePreviousTooltip = 1
  ImGuiTreeNodeFlagsPrivate* {.pure, size: int32.sizeof.} = enum
    ClipLabelForTrailingButton = 1048576
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
  ImFileHandle* = ptr FILE
  ImGuiID* = uint32
  ImGuiInputTextCallback* = proc(data: ptr ImGuiInputTextCallbackData): int32 {.cdecl.}
  ImGuiSizeCallback* = proc(data: ptr ImGuiSizeCallbackData): void {.cdecl.}
  ImPoolIdx* = int32
  ImTextureID* = pointer
  ImWchar* = ImWchar16
  ImWchar16* = uint16
  ImWchar32* = uint32

  ImVector*[T] = object # Should I importc a generic?
    size* {.importc: "Size".}: int32
    capacity* {.importc: "Capacity".}: int32
    data* {.importc: "Data".}: UncheckedArray[T]
  ImGuiStyleModBackup* {.union.} = object
    backup_int* {.importc: "BackupInt".}: int32 # Breaking naming convetion to denote "low level"
    backup_float* {.importc: "BackupFloat".}: float32
  ImGuiStyleMod* {.importc: "ImGuiStyleMod", imgui_header.} = object
    varIdx* {.importc: "VarIdx".}: ImGuiStyleVar
    backup*: ImGuiStyleModBackup
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

  # Undefined data types in cimgui

  ImDrawListPtr* = object
  ImChunkStream* = ptr object
  STB_TexteditState* {.importc: "STB_TexteditState", imgui_header.} = object
  ImPool* = object

  #

  ImBitVector* {.importc: "ImBitVector", imgui_header.} = object
    storage* {.importc: "Storage".}: ImVector[uint32]
  ImColor* {.importc: "ImColor", imgui_header.} = object
    value* {.importc: "Value".}: ImVec4
  ImDrawChannel* {.importc: "ImDrawChannel", imgui_header.} = ptr object
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
  ImDrawDataBuilder* {.importc: "ImDrawDataBuilder", imgui_header.} = object
    layers* {.importc: "Layers".}: array[2, ImVector[ImDrawListPtr]]
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
  ImDrawListSharedData* {.importc: "ImDrawListSharedData", imgui_header.} = object
    texUvWhitePixel* {.importc: "TexUvWhitePixel".}: ImVec2
    font* {.importc: "Font".}: ptr ImFont
    fontSize* {.importc: "FontSize".}: float32
    curveTessellationTol* {.importc: "CurveTessellationTol".}: float32
    circleSegmentMaxError* {.importc: "CircleSegmentMaxError".}: float32
    clipRectFullscreen* {.importc: "ClipRectFullscreen".}: ImVec4
    initialFlags* {.importc: "InitialFlags".}: ImDrawListFlags
    arcFastVtx* {.importc: "ArcFastVtx".}: array[12*1, ImVec2]
    circleSegmentCounts* {.importc: "CircleSegmentCounts".}: array[64, uint8]
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
    dirtyLookupTables* {.importc: "DirtyLookupTables".}: bool
    scale* {.importc: "Scale".}: float32
    ascent* {.importc: "Ascent".}: float32
    descent* {.importc: "Descent".}: float32
    metricsTotalSurface* {.importc: "MetricsTotalSurface".}: int32
    used4kPagesMap* {.importc: "Used4kPagesMap".}: array[2, uint8]
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
    codepoint* {.importc: "Codepoint".}: uint32
    visible* {.importc: "Visible".}: uint32
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
  ImGuiColorMod* {.importc: "ImGuiColorMod", imgui_header.} = object
    col* {.importc: "Col".}: ImGuiCol
    backupValue* {.importc: "BackupValue".}: ImVec4
  ImGuiColumnData* {.importc: "ImGuiColumnData", imgui_header.} = object
    offsetNorm* {.importc: "OffsetNorm".}: float32
    offsetNormBeforeResize* {.importc: "OffsetNormBeforeResize".}: float32
    flags* {.importc: "Flags".}: ImGuiColumnsFlags
    clipRect* {.importc: "ClipRect".}: ImRect
  ImGuiColumns* {.importc: "ImGuiColumns", imgui_header.} = object
    id* {.importc: "ID".}: ImGuiID
    flags* {.importc: "Flags".}: ImGuiColumnsFlags
    isFirstFrame* {.importc: "IsFirstFrame".}: bool
    isBeingResized* {.importc: "IsBeingResized".}: bool
    current* {.importc: "Current".}: int32
    count* {.importc: "Count".}: int32
    offMinX* {.importc: "OffMinX".}: float32
    offMaxX* {.importc: "OffMaxX".}: float32
    lineMinY* {.importc: "LineMinY".}: float32
    lineMaxY* {.importc: "LineMaxY".}: float32
    hostCursorPosY* {.importc: "HostCursorPosY".}: float32
    hostCursorMaxPosX* {.importc: "HostCursorMaxPosX".}: float32
    hostClipRect* {.importc: "HostClipRect".}: ImRect
    hostWorkRect* {.importc: "HostWorkRect".}: ImRect
    columns* {.importc: "Columns".}: ImVector[ImGuiColumnData]
    splitter* {.importc: "Splitter".}: ImDrawListSplitter
  ImGuiContext* {.importc: "ImGuiContext", imgui_header.} = object
    initialized* {.importc: "Initialized".}: bool
    fontAtlasOwnedByContext* {.importc: "FontAtlasOwnedByContext".}: bool
    io* {.importc: "IO".}: ImGuiIO
    style* {.importc: "Style".}: ImGuiStyle
    font* {.importc: "Font".}: ptr ImFont
    fontSize* {.importc: "FontSize".}: float32
    fontBaseSize* {.importc: "FontBaseSize".}: float32
    drawListSharedData* {.importc: "DrawListSharedData".}: ImDrawListSharedData
    time* {.importc: "Time".}: float64
    frameCount* {.importc: "FrameCount".}: int32
    frameCountEnded* {.importc: "FrameCountEnded".}: int32
    frameCountRendered* {.importc: "FrameCountRendered".}: int32
    withinFrameScope* {.importc: "WithinFrameScope".}: bool
    withinFrameScopeWithImplicitWindow* {.importc: "WithinFrameScopeWithImplicitWindow".}: bool
    withinEndChild* {.importc: "WithinEndChild".}: bool
    windows* {.importc: "Windows".}: ImVector[ptr ImGuiWindow]
    windowsFocusOrder* {.importc: "WindowsFocusOrder".}: ImVector[ptr ImGuiWindow]
    windowsTempSortBuffer* {.importc: "WindowsTempSortBuffer".}: ImVector[ptr ImGuiWindow]
    currentWindowStack* {.importc: "CurrentWindowStack".}: ImVector[ptr ImGuiWindow]
    windowsById* {.importc: "WindowsById".}: ImGuiStorage
    windowsActiveCount* {.importc: "WindowsActiveCount".}: int32
    currentWindow* {.importc: "CurrentWindow".}: ptr ImGuiWindow
    hoveredWindow* {.importc: "HoveredWindow".}: ptr ImGuiWindow
    hoveredRootWindow* {.importc: "HoveredRootWindow".}: ptr ImGuiWindow
    movingWindow* {.importc: "MovingWindow".}: ptr ImGuiWindow
    wheelingWindow* {.importc: "WheelingWindow".}: ptr ImGuiWindow
    wheelingWindowRefMousePos* {.importc: "WheelingWindowRefMousePos".}: ImVec2
    wheelingWindowTimer* {.importc: "WheelingWindowTimer".}: float32
    hoveredId* {.importc: "HoveredId".}: ImGuiID
    hoveredIdAllowOverlap* {.importc: "HoveredIdAllowOverlap".}: bool
    hoveredIdPreviousFrame* {.importc: "HoveredIdPreviousFrame".}: ImGuiID
    hoveredIdTimer* {.importc: "HoveredIdTimer".}: float32
    hoveredIdNotActiveTimer* {.importc: "HoveredIdNotActiveTimer".}: float32
    activeId* {.importc: "ActiveId".}: ImGuiID
    activeIdIsAlive* {.importc: "ActiveIdIsAlive".}: ImGuiID
    activeIdTimer* {.importc: "ActiveIdTimer".}: float32
    activeIdIsJustActivated* {.importc: "ActiveIdIsJustActivated".}: bool
    activeIdAllowOverlap* {.importc: "ActiveIdAllowOverlap".}: bool
    activeIdHasBeenPressedBefore* {.importc: "ActiveIdHasBeenPressedBefore".}: bool
    activeIdHasBeenEditedBefore* {.importc: "ActiveIdHasBeenEditedBefore".}: bool
    activeIdHasBeenEditedThisFrame* {.importc: "ActiveIdHasBeenEditedThisFrame".}: bool
    activeIdUsingNavDirMask* {.importc: "ActiveIdUsingNavDirMask".}: uint32
    activeIdUsingNavInputMask* {.importc: "ActiveIdUsingNavInputMask".}: uint32
    activeIdUsingKeyInputMask* {.importc: "ActiveIdUsingKeyInputMask".}: uint64
    activeIdClickOffset* {.importc: "ActiveIdClickOffset".}: ImVec2
    activeIdWindow* {.importc: "ActiveIdWindow".}: ptr ImGuiWindow
    activeIdSource* {.importc: "ActiveIdSource".}: ImGuiInputSource
    activeIdMouseButton* {.importc: "ActiveIdMouseButton".}: int32
    activeIdPreviousFrame* {.importc: "ActiveIdPreviousFrame".}: ImGuiID
    activeIdPreviousFrameIsAlive* {.importc: "ActiveIdPreviousFrameIsAlive".}: bool
    activeIdPreviousFrameHasBeenEditedBefore* {.importc: "ActiveIdPreviousFrameHasBeenEditedBefore".}: bool
    activeIdPreviousFrameWindow* {.importc: "ActiveIdPreviousFrameWindow".}: ptr ImGuiWindow
    lastActiveId* {.importc: "LastActiveId".}: ImGuiID
    lastActiveIdTimer* {.importc: "LastActiveIdTimer".}: float32
    nextWindowData* {.importc: "NextWindowData".}: ImGuiNextWindowData
    nextItemData* {.importc: "NextItemData".}: ImGuiNextItemData
    colorModifiers* {.importc: "ColorModifiers".}: ImVector[ImGuiColorMod]
    styleModifiers* {.importc: "StyleModifiers".}: ImVector[ImGuiStyleMod]
    fontStack* {.importc: "FontStack".}: ImVector[ptr ImFont]
    openPopupStack* {.importc: "OpenPopupStack".}: ImVector[ImGuiPopupData]
    beginPopupStack* {.importc: "BeginPopupStack".}: ImVector[ImGuiPopupData]
    navWindow* {.importc: "NavWindow".}: ptr ImGuiWindow
    navId* {.importc: "NavId".}: ImGuiID
    navFocusScopeId* {.importc: "NavFocusScopeId".}: ImGuiID
    navActivateId* {.importc: "NavActivateId".}: ImGuiID
    navActivateDownId* {.importc: "NavActivateDownId".}: ImGuiID
    navActivatePressedId* {.importc: "NavActivatePressedId".}: ImGuiID
    navInputId* {.importc: "NavInputId".}: ImGuiID
    navJustTabbedId* {.importc: "NavJustTabbedId".}: ImGuiID
    navJustMovedToId* {.importc: "NavJustMovedToId".}: ImGuiID
    navJustMovedToFocusScopeId* {.importc: "NavJustMovedToFocusScopeId".}: ImGuiID
    navJustMovedToKeyMods* {.importc: "NavJustMovedToKeyMods".}: ImGuiKeyModFlags
    navNextActivateId* {.importc: "NavNextActivateId".}: ImGuiID
    navInputSource* {.importc: "NavInputSource".}: ImGuiInputSource
    navScoringRect* {.importc: "NavScoringRect".}: ImRect
    navScoringCount* {.importc: "NavScoringCount".}: int32
    navLayer* {.importc: "NavLayer".}: ImGuiNavLayer
    navIdTabCounter* {.importc: "NavIdTabCounter".}: int32
    navIdIsAlive* {.importc: "NavIdIsAlive".}: bool
    navMousePosDirty* {.importc: "NavMousePosDirty".}: bool
    navDisableHighlight* {.importc: "NavDisableHighlight".}: bool
    navDisableMouseHover* {.importc: "NavDisableMouseHover".}: bool
    navAnyRequest* {.importc: "NavAnyRequest".}: bool
    navInitRequest* {.importc: "NavInitRequest".}: bool
    navInitRequestFromMove* {.importc: "NavInitRequestFromMove".}: bool
    navInitResultId* {.importc: "NavInitResultId".}: ImGuiID
    navInitResultRectRel* {.importc: "NavInitResultRectRel".}: ImRect
    navMoveFromClampedRefRect* {.importc: "NavMoveFromClampedRefRect".}: bool
    navMoveRequest* {.importc: "NavMoveRequest".}: bool
    navMoveRequestFlags* {.importc: "NavMoveRequestFlags".}: ImGuiNavMoveFlags
    navMoveRequestForward* {.importc: "NavMoveRequestForward".}: ImGuiNavForward
    navMoveRequestKeyMods* {.importc: "NavMoveRequestKeyMods".}: ImGuiKeyModFlags
    navMoveDir* {.importc: "NavMoveDir".}: ImGuiDir
    navMoveDirLast* {.importc: "NavMoveDirLast".}: ImGuiDir
    navMoveClipDir* {.importc: "NavMoveClipDir".}: ImGuiDir
    navMoveResultLocal* {.importc: "NavMoveResultLocal".}: ImGuiNavMoveResult
    navMoveResultLocalVisibleSet* {.importc: "NavMoveResultLocalVisibleSet".}: ImGuiNavMoveResult
    navMoveResultOther* {.importc: "NavMoveResultOther".}: ImGuiNavMoveResult
    navWindowingTarget* {.importc: "NavWindowingTarget".}: ptr ImGuiWindow
    navWindowingTargetAnim* {.importc: "NavWindowingTargetAnim".}: ptr ImGuiWindow
    navWindowingList* {.importc: "NavWindowingList".}: ptr ImGuiWindow
    navWindowingTimer* {.importc: "NavWindowingTimer".}: float32
    navWindowingHighlightAlpha* {.importc: "NavWindowingHighlightAlpha".}: float32
    navWindowingToggleLayer* {.importc: "NavWindowingToggleLayer".}: bool
    focusRequestCurrWindow* {.importc: "FocusRequestCurrWindow".}: ptr ImGuiWindow
    focusRequestNextWindow* {.importc: "FocusRequestNextWindow".}: ptr ImGuiWindow
    focusRequestCurrCounterRegular* {.importc: "FocusRequestCurrCounterRegular".}: int32
    focusRequestCurrCounterTabStop* {.importc: "FocusRequestCurrCounterTabStop".}: int32
    focusRequestNextCounterRegular* {.importc: "FocusRequestNextCounterRegular".}: int32
    focusRequestNextCounterTabStop* {.importc: "FocusRequestNextCounterTabStop".}: int32
    focusTabPressed* {.importc: "FocusTabPressed".}: bool
    drawData* {.importc: "DrawData".}: ImDrawData
    drawDataBuilder* {.importc: "DrawDataBuilder".}: ImDrawDataBuilder
    dimBgRatio* {.importc: "DimBgRatio".}: float32
    backgroundDrawList* {.importc: "BackgroundDrawList".}: ImDrawList
    foregroundDrawList* {.importc: "ForegroundDrawList".}: ImDrawList
    mouseCursor* {.importc: "MouseCursor".}: ImGuiMouseCursor
    dragDropActive* {.importc: "DragDropActive".}: bool
    dragDropWithinSource* {.importc: "DragDropWithinSource".}: bool
    dragDropWithinTarget* {.importc: "DragDropWithinTarget".}: bool
    dragDropSourceFlags* {.importc: "DragDropSourceFlags".}: ImGuiDragDropFlags
    dragDropSourceFrameCount* {.importc: "DragDropSourceFrameCount".}: int32
    dragDropMouseButton* {.importc: "DragDropMouseButton".}: int32
    dragDropPayload* {.importc: "DragDropPayload".}: ImGuiPayload
    dragDropTargetRect* {.importc: "DragDropTargetRect".}: ImRect
    dragDropTargetId* {.importc: "DragDropTargetId".}: ImGuiID
    dragDropAcceptFlags* {.importc: "DragDropAcceptFlags".}: ImGuiDragDropFlags
    dragDropAcceptIdCurrRectSurface* {.importc: "DragDropAcceptIdCurrRectSurface".}: float32
    dragDropAcceptIdCurr* {.importc: "DragDropAcceptIdCurr".}: ImGuiID
    dragDropAcceptIdPrev* {.importc: "DragDropAcceptIdPrev".}: ImGuiID
    dragDropAcceptFrameCount* {.importc: "DragDropAcceptFrameCount".}: int32
    dragDropPayloadBufHeap* {.importc: "DragDropPayloadBufHeap".}: ImVector[cuchar]
    dragDropPayloadBufLocal* {.importc: "DragDropPayloadBufLocal".}: array[16, cuchar]
    currentTabBar* {.importc: "CurrentTabBar".}: ptr ImGuiTabBar
    tabBars* {.importc: "TabBars".}: ImVector[ImGuiTabBar]
    currentTabBarStack* {.importc: "CurrentTabBarStack".}: ImVector[ImGuiPtrOrIndex]
    shrinkWidthBuffer* {.importc: "ShrinkWidthBuffer".}: ImVector[ImGuiShrinkWidthItem]
    lastValidMousePos* {.importc: "LastValidMousePos".}: ImVec2
    inputTextState* {.importc: "InputTextState".}: ImGuiInputTextState
    inputTextPasswordFont* {.importc: "InputTextPasswordFont".}: ImFont
    tempInputId* {.importc: "TempInputId".}: ImGuiID
    colorEditOptions* {.importc: "ColorEditOptions".}: ImGuiColorEditFlags
    colorEditLastHue* {.importc: "ColorEditLastHue".}: float32
    colorEditLastSat* {.importc: "ColorEditLastSat".}: float32
    colorEditLastColor* {.importc: "ColorEditLastColor".}: array[3, float32]
    colorPickerRef* {.importc: "ColorPickerRef".}: ImVec4
    dragCurrentAccumDirty* {.importc: "DragCurrentAccumDirty".}: bool
    dragCurrentAccum* {.importc: "DragCurrentAccum".}: float32
    dragSpeedDefaultRatio* {.importc: "DragSpeedDefaultRatio".}: float32
    scrollbarClickDeltaToGrabCenter* {.importc: "ScrollbarClickDeltaToGrabCenter".}: float32
    tooltipOverrideCount* {.importc: "TooltipOverrideCount".}: int32
    clipboardHandlerData* {.importc: "ClipboardHandlerData".}: ImVector[int8]
    menusIdSubmittedThisFrame* {.importc: "MenusIdSubmittedThisFrame".}: ImVector[ImGuiID]
    platformImePos* {.importc: "PlatformImePos".}: ImVec2
    platformImeLastPos* {.importc: "PlatformImeLastPos".}: ImVec2
    settingsLoaded* {.importc: "SettingsLoaded".}: bool
    settingsDirtyTimer* {.importc: "SettingsDirtyTimer".}: float32
    settingsIniData* {.importc: "SettingsIniData".}: ImGuiTextBuffer
    settingsHandlers* {.importc: "SettingsHandlers".}: ImVector[ImGuiSettingsHandler]
    settingsWindows* {.importc: "SettingsWindows".}: ImVector[ImGuiWindowSettings]
    logEnabled* {.importc: "LogEnabled".}: bool
    logType* {.importc: "LogType".}: ImGuiLogType
    logFile* {.importc: "LogFile".}: ImFileHandle
    logBuffer* {.importc: "LogBuffer".}: ImGuiTextBuffer
    logLinePosY* {.importc: "LogLinePosY".}: float32
    logLineFirstItem* {.importc: "LogLineFirstItem".}: bool
    logDepthRef* {.importc: "LogDepthRef".}: int32
    logDepthToExpand* {.importc: "LogDepthToExpand".}: int32
    logDepthToExpandDefault* {.importc: "LogDepthToExpandDefault".}: int32
    debugItemPickerActive* {.importc: "DebugItemPickerActive".}: bool
    debugItemPickerBreakId* {.importc: "DebugItemPickerBreakId".}: ImGuiID
    framerateSecPerFrame* {.importc: "FramerateSecPerFrame".}: array[120, float32]
    framerateSecPerFrameIdx* {.importc: "FramerateSecPerFrameIdx".}: int32
    framerateSecPerFrameAccum* {.importc: "FramerateSecPerFrameAccum".}: float32
    wantCaptureMouseNextFrame* {.importc: "WantCaptureMouseNextFrame".}: int32
    wantCaptureKeyboardNextFrame* {.importc: "WantCaptureKeyboardNextFrame".}: int32
    wantTextInputNextFrame* {.importc: "WantTextInputNextFrame".}: int32
    tempBuffer* {.importc: "TempBuffer".}: array[1024*3+1, int8]
  ImGuiDataTypeInfo* {.importc: "ImGuiDataTypeInfo", imgui_header.} = object
    size* {.importc: "Size".}: uint
    printFmt* {.importc: "PrintFmt".}: cstring
    scanFmt* {.importc: "ScanFmt".}: cstring
  ImGuiGroupData* {.importc: "ImGuiGroupData", imgui_header.} = object
    backupCursorPos* {.importc: "BackupCursorPos".}: ImVec2
    backupCursorMaxPos* {.importc: "BackupCursorMaxPos".}: ImVec2
    backupIndent* {.importc: "BackupIndent".}: ImVec1
    backupGroupOffset* {.importc: "BackupGroupOffset".}: ImVec1
    backupCurrLineSize* {.importc: "BackupCurrLineSize".}: ImVec2
    backupCurrLineTextBaseOffset* {.importc: "BackupCurrLineTextBaseOffset".}: float32
    backupActiveIdIsAlive* {.importc: "BackupActiveIdIsAlive".}: ImGuiID
    backupActiveIdPreviousFrameIsAlive* {.importc: "BackupActiveIdPreviousFrameIsAlive".}: bool
    emitItem* {.importc: "EmitItem".}: bool
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
    navInputs* {.importc: "NavInputs".}: array[21, float32]
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
    keyMods* {.importc: "KeyMods".}: ImGuiKeyModFlags
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
    navInputsDownDuration* {.importc: "NavInputsDownDuration".}: array[21, float32]
    navInputsDownDurationPrev* {.importc: "NavInputsDownDurationPrev".}: array[21, float32]
    inputQueueSurrogate* {.importc: "InputQueueSurrogate".}: ImWchar16
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
  ImGuiInputTextState* {.importc: "ImGuiInputTextState", imgui_header.} = object
    id* {.importc: "ID".}: ImGuiID
    curLenW* {.importc: "CurLenW".}: int32
    curLenA* {.importc: "CurLenA".}: int32
    textW* {.importc: "TextW".}: ImVector[ImWchar]
    textA* {.importc: "TextA".}: ImVector[int8]
    initialTextA* {.importc: "InitialTextA".}: ImVector[int8]
    textAIsValid* {.importc: "TextAIsValid".}: bool
    bufCapacityA* {.importc: "BufCapacityA".}: int32
    scrollX* {.importc: "ScrollX".}: float32
    stb* {.importc: "Stb".}: STB_TexteditState
    cursorAnim* {.importc: "CursorAnim".}: float32
    cursorFollow* {.importc: "CursorFollow".}: bool
    selectedAllMouseLock* {.importc: "SelectedAllMouseLock".}: bool
    userFlags* {.importc: "UserFlags".}: ImGuiInputTextFlags
    userCallback* {.importc: "UserCallback".}: ImGuiInputTextCallback
    userCallbackData* {.importc: "UserCallbackData".}: pointer
  ImGuiItemHoveredDataBackup* {.importc: "ImGuiItemHoveredDataBackup", imgui_header.} = object
    lastItemId* {.importc: "LastItemId".}: ImGuiID
    lastItemStatusFlags* {.importc: "LastItemStatusFlags".}: ImGuiItemStatusFlags
    lastItemRect* {.importc: "LastItemRect".}: ImRect
    lastItemDisplayRect* {.importc: "LastItemDisplayRect".}: ImRect
  ImGuiListClipper* {.importc: "ImGuiListClipper", imgui_header.} = object
    displayStart* {.importc: "DisplayStart".}: int32
    displayEnd* {.importc: "DisplayEnd".}: int32
    itemsCount* {.importc: "ItemsCount".}: int32
    stepNo* {.importc: "StepNo".}: int32
    itemsHeight* {.importc: "ItemsHeight".}: float32
    startPosY* {.importc: "StartPosY".}: float32
  ImGuiMenuColumns* {.importc: "ImGuiMenuColumns", imgui_header.} = object
    spacing* {.importc: "Spacing".}: float32
    width* {.importc: "Width".}: float32
    nextWidth* {.importc: "NextWidth".}: float32
    pos* {.importc: "Pos".}: array[3, float32]
    nextWidths* {.importc: "NextWidths".}: array[3, float32]
  ImGuiNavMoveResult* {.importc: "ImGuiNavMoveResult", imgui_header.} = object
    window* {.importc: "Window".}: ptr ImGuiWindow
    id* {.importc: "ID".}: ImGuiID
    focusScopeId* {.importc: "FocusScopeId".}: ImGuiID
    distBox* {.importc: "DistBox".}: float32
    distCenter* {.importc: "DistCenter".}: float32
    distAxial* {.importc: "DistAxial".}: float32
    rectRel* {.importc: "RectRel".}: ImRect
  ImGuiNextItemData* {.importc: "ImGuiNextItemData", imgui_header.} = object
    flags* {.importc: "Flags".}: ImGuiNextItemDataFlags
    width* {.importc: "Width".}: float32
    focusScopeId* {.importc: "FocusScopeId".}: ImGuiID
    openCond* {.importc: "OpenCond".}: ImGuiCond
    openVal* {.importc: "OpenVal".}: bool
  ImGuiNextWindowData* {.importc: "ImGuiNextWindowData", imgui_header.} = object
    flags* {.importc: "Flags".}: ImGuiNextWindowDataFlags
    posCond* {.importc: "PosCond".}: ImGuiCond
    sizeCond* {.importc: "SizeCond".}: ImGuiCond
    collapsedCond* {.importc: "CollapsedCond".}: ImGuiCond
    posVal* {.importc: "PosVal".}: ImVec2
    posPivotVal* {.importc: "PosPivotVal".}: ImVec2
    sizeVal* {.importc: "SizeVal".}: ImVec2
    contentSizeVal* {.importc: "ContentSizeVal".}: ImVec2
    collapsedVal* {.importc: "CollapsedVal".}: bool
    sizeConstraintRect* {.importc: "SizeConstraintRect".}: ImRect
    sizeCallback* {.importc: "SizeCallback".}: ImGuiSizeCallback
    sizeCallbackUserData* {.importc: "SizeCallbackUserData".}: pointer
    bgAlphaVal* {.importc: "BgAlphaVal".}: float32
    menuBarOffsetMinVal* {.importc: "MenuBarOffsetMinVal".}: ImVec2
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
  ImGuiPopupData* {.importc: "ImGuiPopupData", imgui_header.} = object
    popupId* {.importc: "PopupId".}: ImGuiID
    window* {.importc: "Window".}: ptr ImGuiWindow
    sourceWindow* {.importc: "SourceWindow".}: ptr ImGuiWindow
    openFrameCount* {.importc: "OpenFrameCount".}: int32
    openParentId* {.importc: "OpenParentId".}: ImGuiID
    openPopupPos* {.importc: "OpenPopupPos".}: ImVec2
    openMousePos* {.importc: "OpenMousePos".}: ImVec2
  ImGuiPtrOrIndex* {.importc: "ImGuiPtrOrIndex", imgui_header.} = object
    `ptr`* {.importc: "`ptr`".}: pointer
    index* {.importc: "Index".}: int32
  ImGuiSettingsHandler* {.importc: "ImGuiSettingsHandler", imgui_header.} = object
    typeName* {.importc: "TypeName".}: cstring
    typeHash* {.importc: "TypeHash".}: ImGuiID
    readOpenFn* {.importc: "ReadOpenFn".}: proc(ctx: ptr ImGuiContext, handler: ptr ImGuiSettingsHandler, name: cstring): pointer {.cdecl.}
    readLineFn* {.importc: "ReadLineFn".}: proc(ctx: ptr ImGuiContext, handler: ptr ImGuiSettingsHandler, entry: pointer, line: cstring): void {.cdecl.}
    writeAllFn* {.importc: "WriteAllFn".}: proc(ctx: ptr ImGuiContext, handler: ptr ImGuiSettingsHandler, out_buf: ptr ImGuiTextBuffer): void {.cdecl.}
    userData* {.importc: "UserData".}: pointer
  ImGuiShrinkWidthItem* {.importc: "ImGuiShrinkWidthItem", imgui_header.} = object
    index* {.importc: "Index".}: int32
    width* {.importc: "Width".}: float32
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
    circleSegmentMaxError* {.importc: "CircleSegmentMaxError".}: float32
    colors* {.importc: "Colors".}: array[48, ImVec4]
  ImGuiTabBar* {.importc: "ImGuiTabBar", imgui_header.} = object
    tabs* {.importc: "Tabs".}: ImVector[ImGuiTabItem]
    id* {.importc: "ID".}: ImGuiID
    selectedTabId* {.importc: "SelectedTabId".}: ImGuiID
    nextSelectedTabId* {.importc: "NextSelectedTabId".}: ImGuiID
    visibleTabId* {.importc: "VisibleTabId".}: ImGuiID
    currFrameVisible* {.importc: "CurrFrameVisible".}: int32
    prevFrameVisible* {.importc: "PrevFrameVisible".}: int32
    barRect* {.importc: "BarRect".}: ImRect
    lastTabContentHeight* {.importc: "LastTabContentHeight".}: float32
    offsetMax* {.importc: "OffsetMax".}: float32
    offsetMaxIdeal* {.importc: "OffsetMaxIdeal".}: float32
    offsetNextTab* {.importc: "OffsetNextTab".}: float32
    scrollingAnim* {.importc: "ScrollingAnim".}: float32
    scrollingTarget* {.importc: "ScrollingTarget".}: float32
    scrollingTargetDistToVisibility* {.importc: "ScrollingTargetDistToVisibility".}: float32
    scrollingSpeed* {.importc: "ScrollingSpeed".}: float32
    flags* {.importc: "Flags".}: ImGuiTabBarFlags
    reorderRequestTabId* {.importc: "ReorderRequestTabId".}: ImGuiID
    reorderRequestDir* {.importc: "ReorderRequestDir".}: int8
    wantLayout* {.importc: "WantLayout".}: bool
    visibleTabWasSubmitted* {.importc: "VisibleTabWasSubmitted".}: bool
    lastTabItemIdx* {.importc: "LastTabItemIdx".}: int16
    framePadding* {.importc: "FramePadding".}: ImVec2
    tabsNames* {.importc: "TabsNames".}: ImGuiTextBuffer
  ImGuiTabItem* {.importc: "ImGuiTabItem", imgui_header.} = object
    id* {.importc: "ID".}: ImGuiID
    flags* {.importc: "Flags".}: ImGuiTabItemFlags
    lastFrameVisible* {.importc: "LastFrameVisible".}: int32
    lastFrameSelected* {.importc: "LastFrameSelected".}: int32
    nameOffset* {.importc: "NameOffset".}: int32
    offset* {.importc: "Offset".}: float32
    width* {.importc: "Width".}: float32
    contentWidth* {.importc: "ContentWidth".}: float32
  ImGuiTextBuffer* {.importc: "ImGuiTextBuffer", imgui_header.} = object
    buf* {.importc: "Buf".}: ImVector[int8]
  ImGuiTextFilter* {.importc: "ImGuiTextFilter", imgui_header.} = object
    inputBuf* {.importc: "InputBuf".}: array[256, int8]
    filters* {.importc: "Filters".}: ImVector[ImGuiTextRange]
    countGrep* {.importc: "CountGrep".}: int32
  ImGuiTextRange* {.importc: "ImGuiTextRange", imgui_header.} = object
    b* {.importc: "b".}: cstring
    e* {.importc: "e".}: cstring
  ImGuiWindow* {.importc: "ImGuiWindow", imgui_header.} = object
    name* {.importc: "Name".}: cstring
    id* {.importc: "ID".}: ImGuiID
    flags* {.importc: "Flags".}: ImGuiWindowFlags
    pos* {.importc: "Pos".}: ImVec2
    size* {.importc: "Size".}: ImVec2
    sizeFull* {.importc: "SizeFull".}: ImVec2
    contentSize* {.importc: "ContentSize".}: ImVec2
    contentSizeExplicit* {.importc: "ContentSizeExplicit".}: ImVec2
    windowPadding* {.importc: "WindowPadding".}: ImVec2
    windowRounding* {.importc: "WindowRounding".}: float32
    windowBorderSize* {.importc: "WindowBorderSize".}: float32
    nameBufLen* {.importc: "NameBufLen".}: int32
    moveId* {.importc: "MoveId".}: ImGuiID
    childId* {.importc: "ChildId".}: ImGuiID
    scroll* {.importc: "Scroll".}: ImVec2
    scrollMax* {.importc: "ScrollMax".}: ImVec2
    scrollTarget* {.importc: "ScrollTarget".}: ImVec2
    scrollTargetCenterRatio* {.importc: "ScrollTargetCenterRatio".}: ImVec2
    scrollbarSizes* {.importc: "ScrollbarSizes".}: ImVec2
    scrollbarX* {.importc: "ScrollbarX".}: bool
    scrollbarY* {.importc: "ScrollbarY".}: bool
    active* {.importc: "Active".}: bool
    wasActive* {.importc: "WasActive".}: bool
    writeAccessed* {.importc: "WriteAccessed".}: bool
    collapsed* {.importc: "Collapsed".}: bool
    wantCollapseToggle* {.importc: "WantCollapseToggle".}: bool
    skipItems* {.importc: "SkipItems".}: bool
    appearing* {.importc: "Appearing".}: bool
    hidden* {.importc: "Hidden".}: bool
    isFallbackWindow* {.importc: "IsFallbackWindow".}: bool
    hasCloseButton* {.importc: "HasCloseButton".}: bool
    resizeBorderHeld* {.importc: "ResizeBorderHeld".}: int8
    beginCount* {.importc: "BeginCount".}: int16
    beginOrderWithinParent* {.importc: "BeginOrderWithinParent".}: int16
    beginOrderWithinContext* {.importc: "BeginOrderWithinContext".}: int16
    popupId* {.importc: "PopupId".}: ImGuiID
    autoFitFramesX* {.importc: "AutoFitFramesX".}: int8
    autoFitFramesY* {.importc: "AutoFitFramesY".}: int8
    autoFitChildAxises* {.importc: "AutoFitChildAxises".}: int8
    autoFitOnlyGrows* {.importc: "AutoFitOnlyGrows".}: bool
    autoPosLastDirection* {.importc: "AutoPosLastDirection".}: ImGuiDir
    hiddenFramesCanSkipItems* {.importc: "HiddenFramesCanSkipItems".}: int32
    hiddenFramesCannotSkipItems* {.importc: "HiddenFramesCannotSkipItems".}: int32
    setWindowPosAllowFlags* {.importc: "SetWindowPosAllowFlags".}: ImGuiCond
    setWindowSizeAllowFlags* {.importc: "SetWindowSizeAllowFlags".}: ImGuiCond
    setWindowCollapsedAllowFlags* {.importc: "SetWindowCollapsedAllowFlags".}: ImGuiCond
    setWindowPosVal* {.importc: "SetWindowPosVal".}: ImVec2
    setWindowPosPivot* {.importc: "SetWindowPosPivot".}: ImVec2
    iDStack* {.importc: "IDStack".}: ImVector[ImGuiID]
    dc* {.importc: "DC".}: ImGuiWindowTempData
    outerRectClipped* {.importc: "OuterRectClipped".}: ImRect
    innerRect* {.importc: "InnerRect".}: ImRect
    innerClipRect* {.importc: "InnerClipRect".}: ImRect
    workRect* {.importc: "WorkRect".}: ImRect
    clipRect* {.importc: "ClipRect".}: ImRect
    contentRegionRect* {.importc: "ContentRegionRect".}: ImRect
    lastFrameActive* {.importc: "LastFrameActive".}: int32
    lastTimeActive* {.importc: "LastTimeActive".}: float32
    itemWidthDefault* {.importc: "ItemWidthDefault".}: float32
    stateStorage* {.importc: "StateStorage".}: ImGuiStorage
    columnsStorage* {.importc: "ColumnsStorage".}: ImVector[ImGuiColumns]
    fontWindowScale* {.importc: "FontWindowScale".}: float32
    settingsOffset* {.importc: "SettingsOffset".}: int32
    drawList* {.importc: "DrawList".}: ptr ImDrawList
    drawListInst* {.importc: "DrawListInst".}: ImDrawList
    parentWindow* {.importc: "ParentWindow".}: ptr ImGuiWindow
    rootWindow* {.importc: "RootWindow".}: ptr ImGuiWindow
    rootWindowForTitleBarHighlight* {.importc: "RootWindowForTitleBarHighlight".}: ptr ImGuiWindow
    rootWindowForNav* {.importc: "RootWindowForNav".}: ptr ImGuiWindow
    navLastChildNavWindow* {.importc: "NavLastChildNavWindow".}: ptr ImGuiWindow
    navLastIds* {.importc: "NavLastIds".}: array[2, ImGuiID]
    navRectRel* {.importc: "NavRectRel".}: array[2, ImRect]
    memoryCompacted* {.importc: "MemoryCompacted".}: bool
    memoryDrawListIdxCapacity* {.importc: "MemoryDrawListIdxCapacity".}: int32
    memoryDrawListVtxCapacity* {.importc: "MemoryDrawListVtxCapacity".}: int32
  ImGuiWindowSettings* {.importc: "ImGuiWindowSettings", imgui_header.} = object
    id* {.importc: "ID".}: ImGuiID
    pos* {.importc: "Pos".}: ImVec2ih
    size* {.importc: "Size".}: ImVec2ih
    collapsed* {.importc: "Collapsed".}: bool
  ImGuiWindowTempData* {.importc: "ImGuiWindowTempData", imgui_header.} = object
    cursorPos* {.importc: "CursorPos".}: ImVec2
    cursorPosPrevLine* {.importc: "CursorPosPrevLine".}: ImVec2
    cursorStartPos* {.importc: "CursorStartPos".}: ImVec2
    cursorMaxPos* {.importc: "CursorMaxPos".}: ImVec2
    currLineSize* {.importc: "CurrLineSize".}: ImVec2
    prevLineSize* {.importc: "PrevLineSize".}: ImVec2
    currLineTextBaseOffset* {.importc: "CurrLineTextBaseOffset".}: float32
    prevLineTextBaseOffset* {.importc: "PrevLineTextBaseOffset".}: float32
    indent* {.importc: "Indent".}: ImVec1
    columnsOffset* {.importc: "ColumnsOffset".}: ImVec1
    groupOffset* {.importc: "GroupOffset".}: ImVec1
    lastItemId* {.importc: "LastItemId".}: ImGuiID
    lastItemStatusFlags* {.importc: "LastItemStatusFlags".}: ImGuiItemStatusFlags
    lastItemRect* {.importc: "LastItemRect".}: ImRect
    lastItemDisplayRect* {.importc: "LastItemDisplayRect".}: ImRect
    navLayerCurrent* {.importc: "NavLayerCurrent".}: ImGuiNavLayer
    navLayerCurrentMask* {.importc: "NavLayerCurrentMask".}: int32
    navLayerActiveMask* {.importc: "NavLayerActiveMask".}: int32
    navLayerActiveMaskNext* {.importc: "NavLayerActiveMaskNext".}: int32
    navFocusScopeIdCurrent* {.importc: "NavFocusScopeIdCurrent".}: ImGuiID
    navHideHighlightOneFrame* {.importc: "NavHideHighlightOneFrame".}: bool
    navHasScroll* {.importc: "NavHasScroll".}: bool
    menuBarAppending* {.importc: "MenuBarAppending".}: bool
    menuBarOffset* {.importc: "MenuBarOffset".}: ImVec2
    menuColumns* {.importc: "MenuColumns".}: ImGuiMenuColumns
    treeDepth* {.importc: "TreeDepth".}: int32
    treeJumpToParentOnPopMask* {.importc: "TreeJumpToParentOnPopMask".}: uint32
    childWindows* {.importc: "ChildWindows".}: ImVector[ptr ImGuiWindow]
    stateStorage* {.importc: "StateStorage".}: ptr ImGuiStorage
    currentColumns* {.importc: "CurrentColumns".}: ptr ImGuiColumns
    layoutType* {.importc: "LayoutType".}: ImGuiLayoutType
    parentLayoutType* {.importc: "ParentLayoutType".}: ImGuiLayoutType
    focusCounterRegular* {.importc: "FocusCounterRegular".}: int32
    focusCounterTabStop* {.importc: "FocusCounterTabStop".}: int32
    itemFlags* {.importc: "ItemFlags".}: ImGuiItemFlags
    itemWidth* {.importc: "ItemWidth".}: float32
    textWrapPos* {.importc: "TextWrapPos".}: float32
    itemFlagsStack* {.importc: "ItemFlagsStack".}: ImVector[ImGuiItemFlags]
    itemWidthStack* {.importc: "ItemWidthStack".}: ImVector[float32]
    textWrapPosStack* {.importc: "TextWrapPosStack".}: ImVector[float32]
    groupStack* {.importc: "GroupStack".}: ImVector[ImGuiGroupData]
    stackSizesBackup* {.importc: "StackSizesBackup".}: array[6, int16]
  ImRect* {.importc: "ImRect", imgui_header.} = object
    min* {.importc: "Min".}: ImVec2
    max* {.importc: "Max".}: ImVec2
  ImVec1* {.importc: "ImVec1", imgui_header.} = object
    x* {.importc: "x".}: float32
  ImVec2* {.importc: "ImVec2", imgui_header.} = object
    x* {.importc: "x".}: float32
    y* {.importc: "y".}: float32
  ImVec2ih* {.importc: "ImVec2ih", imgui_header.} = object
    x* {.importc: "x".}: int16
    y* {.importc: "y".}: int16
  ImVec4* {.importc: "ImVec4", imgui_header.} = object
    x* {.importc: "x".}: float32
    y* {.importc: "y".}: float32
    z* {.importc: "z".}: float32
    w* {.importc: "w".}: float32

# Procs
when not defined(cpp) or defined(cimguiDLL):
  {.push dynlib: imgui_dll, cdecl, discardable.}
else:
  {.push nodecl, discardable.}

proc clear*(self: ptr ImBitVector): void {.importc: "ImBitVector_Clear".}
proc clearBit*(self: ptr ImBitVector, n: int32): void {.importc: "ImBitVector_ClearBit".}
proc create*(self: ptr ImBitVector, sz: int32): void {.importc: "ImBitVector_Create".}
proc setBit*(self: ptr ImBitVector, n: int32): void {.importc: "ImBitVector_SetBit".}
proc testBit*(self: ptr ImBitVector, n: int32): bool {.importc: "ImBitVector_TestBit".}
proc alloc_chunk*[T](self: ptr ImChunkStream, sz: uint): ptr T {.importc: "ImChunkStream_alloc_chunk".}
proc begin*[T](self: ptr ImChunkStream): ptr T {.importc: "ImChunkStream_begin".}
proc chunk_size*[T](self: ptr ImChunkStream, p: ptr T): int32 {.importc: "ImChunkStream_chunk_size".}
proc clear*(self: ptr ImChunkStream): void {.importc: "ImChunkStream_clear".}
proc empty*(self: ptr ImChunkStream): bool {.importc: "ImChunkStream_empty".}
proc `end`*[T](self: ptr ImChunkStream): ptr T {.importc: "ImChunkStream_end".}
proc next_chunk*[T](self: ptr ImChunkStream, p: ptr T): ptr T {.importc: "ImChunkStream_next_chunk".}
proc offset_from_ptr*[T](self: ptr ImChunkStream, p: ptr T): int32 {.importc: "ImChunkStream_offset_from_ptr".}
proc ptr_from_offset*[T](self: ptr ImChunkStream, off: int32): ptr T {.importc: "ImChunkStream_ptr_from_offset".}
proc size*(self: ptr ImChunkStream): int32 {.importc: "ImChunkStream_size".}
proc hSVNonUDT*(pOut: ptr ImColor, self: ptr ImColor, h: float32, s: float32, v: float32, a: float32 = 1.0f): void {.importc: "ImColor_HSV".}
proc newImColor*(): void {.importc: "ImColor_ImColorNil".}
proc newImColor*(r: int32, g: int32, b: int32, a: int32 = 255): void {.importc: "ImColor_ImColorInt".}
proc newImColor*(rgba: uint32): void {.importc: "ImColor_ImColorU32".}
proc newImColor*(r: float32, g: float32, b: float32, a: float32 = 1.0f): void {.importc: "ImColor_ImColorFloat".}
proc newImColor*(col: ImVec4): void {.importc: "ImColor_ImColorVec4".}
proc setHSV*(self: ptr ImColor, h: float32, s: float32, v: float32, a: float32 = 1.0f): void {.importc: "ImColor_SetHSV".}
proc destroy*(self: ptr ImColor): void {.importc: "ImColor_destroy".}
proc newImDrawCmd*(): void {.importc: "ImDrawCmd_ImDrawCmd".}
proc destroy*(self: ptr ImDrawCmd): void {.importc: "ImDrawCmd_destroy".}
proc clear*(self: ptr ImDrawDataBuilder): void {.importc: "ImDrawDataBuilder_Clear".}
proc clearFreeMemory*(self: ptr ImDrawDataBuilder): void {.importc: "ImDrawDataBuilder_ClearFreeMemory".}
proc flattenIntoSingleLayer*(self: ptr ImDrawDataBuilder): void {.importc: "ImDrawDataBuilder_FlattenIntoSingleLayer".}
proc clear*(self: ptr ImDrawData): void {.importc: "ImDrawData_Clear".}
proc deIndexAllBuffers*(self: ptr ImDrawData): void {.importc: "ImDrawData_DeIndexAllBuffers".}
proc newImDrawData*(): void {.importc: "ImDrawData_ImDrawData".}
proc scaleClipRects*(self: ptr ImDrawData, fb_scale: ImVec2): void {.importc: "ImDrawData_ScaleClipRects".}
proc destroy*(self: ptr ImDrawData): void {.importc: "ImDrawData_destroy".}
proc newImDrawListSharedData*(): void {.importc: "ImDrawListSharedData_ImDrawListSharedData".}
proc setCircleSegmentMaxError*(self: ptr ImDrawListSharedData, max_error: float32): void {.importc: "ImDrawListSharedData_SetCircleSegmentMaxError".}
proc destroy*(self: ptr ImDrawListSharedData): void {.importc: "ImDrawListSharedData_destroy".}
proc clear*(self: ptr ImDrawListSplitter): void {.importc: "ImDrawListSplitter_Clear".}
proc clearFreeMemory*(self: ptr ImDrawListSplitter): void {.importc: "ImDrawListSplitter_ClearFreeMemory".}
proc newImDrawListSplitter*(): void {.importc: "ImDrawListSplitter_ImDrawListSplitter".}
proc merge*(self: ptr ImDrawListSplitter, draw_list: ptr ImDrawList): void {.importc: "ImDrawListSplitter_Merge".}
proc setCurrentChannel*(self: ptr ImDrawListSplitter, draw_list: ptr ImDrawList, channel_idx: int32): void {.importc: "ImDrawListSplitter_SetCurrentChannel".}
proc split*(self: ptr ImDrawListSplitter, draw_list: ptr ImDrawList, count: int32): void {.importc: "ImDrawListSplitter_Split".}
proc destroy*(self: ptr ImDrawListSplitter): void {.importc: "ImDrawListSplitter_destroy".}
proc addBezierCurve*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: uint32, thickness: float32, num_segments: int32 = 0): void {.importc: "ImDrawList_AddBezierCurve".}
proc addCallback*(self: ptr ImDrawList, callback: ImDrawCallback, callback_data: pointer): void {.importc: "ImDrawList_AddCallback".}
proc addCircle*(self: ptr ImDrawList, center: ImVec2, radius: float32, col: uint32, num_segments: int32 = 12, thickness: float32 = 1.0f): void {.importc: "ImDrawList_AddCircle".}
proc addCircleFilled*(self: ptr ImDrawList, center: ImVec2, radius: float32, col: uint32, num_segments: int32 = 12): void {.importc: "ImDrawList_AddCircleFilled".}
proc addConvexPolyFilled*(self: ptr ImDrawList, points: ptr ImVec2, num_points: int32, col: uint32): void {.importc: "ImDrawList_AddConvexPolyFilled".}
proc addDrawCmd*(self: ptr ImDrawList): void {.importc: "ImDrawList_AddDrawCmd".}
proc addImage*(self: ptr ImDrawList, user_texture_id: ImTextureID, p_min: ImVec2, p_max: ImVec2, uv_min: ImVec2 = ImVec2(x: 0, y: 0), uv_max: ImVec2 = ImVec2(x: 1, y: 1), col: uint32 = high(uint32)): void {.importc: "ImDrawList_AddImage".}
proc addImageQuad*(self: ptr ImDrawList, user_texture_id: ImTextureID, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, uv1: ImVec2 = ImVec2(x: 0, y: 0), uv2: ImVec2 = ImVec2(x: 1, y: 0), uv3: ImVec2 = ImVec2(x: 1, y: 1), uv4: ImVec2 = ImVec2(x: 0, y: 1), col: uint32 = high(uint32)): void {.importc: "ImDrawList_AddImageQuad".}
proc addImageRounded*(self: ptr ImDrawList, user_texture_id: ImTextureID, p_min: ImVec2, p_max: ImVec2, uv_min: ImVec2, uv_max: ImVec2, col: uint32, rounding: float32, rounding_corners: ImDrawCornerFlags = ImDrawCornerFlags.All): void {.importc: "ImDrawList_AddImageRounded".}
proc addLine*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, col: uint32, thickness: float32 = 1.0f): void {.importc: "ImDrawList_AddLine".}
proc addNgon*(self: ptr ImDrawList, center: ImVec2, radius: float32, col: uint32, num_segments: int32, thickness: float32 = 1.0f): void {.importc: "ImDrawList_AddNgon".}
proc addNgonFilled*(self: ptr ImDrawList, center: ImVec2, radius: float32, col: uint32, num_segments: int32): void {.importc: "ImDrawList_AddNgonFilled".}
proc addPolyline*(self: ptr ImDrawList, points: ptr ImVec2, num_points: int32, col: uint32, closed: bool, thickness: float32): void {.importc: "ImDrawList_AddPolyline".}
proc addQuad*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: uint32, thickness: float32 = 1.0f): void {.importc: "ImDrawList_AddQuad".}
proc addQuadFilled*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: uint32): void {.importc: "ImDrawList_AddQuadFilled".}
proc addRect*(self: ptr ImDrawList, p_min: ImVec2, p_max: ImVec2, col: uint32, rounding: float32 = 0.0f, rounding_corners: ImDrawCornerFlags = ImDrawCornerFlags.All, thickness: float32 = 1.0f): void {.importc: "ImDrawList_AddRect".}
proc addRectFilled*(self: ptr ImDrawList, p_min: ImVec2, p_max: ImVec2, col: uint32, rounding: float32 = 0.0f, rounding_corners: ImDrawCornerFlags = ImDrawCornerFlags.All): void {.importc: "ImDrawList_AddRectFilled".}
proc addRectFilledMultiColor*(self: ptr ImDrawList, p_min: ImVec2, p_max: ImVec2, col_upr_left: uint32, col_upr_right: uint32, col_bot_right: uint32, col_bot_left: uint32): void {.importc: "ImDrawList_AddRectFilledMultiColor".}
proc addText*(self: ptr ImDrawList, pos: ImVec2, col: uint32, text_begin: cstring, text_end: cstring = nil): void {.importc: "ImDrawList_AddTextVec2".}
proc addText*(self: ptr ImDrawList, font: ptr ImFont, font_size: float32, pos: ImVec2, col: uint32, text_begin: cstring, text_end: cstring = nil, wrap_width: float32 = 0.0f, cpu_fine_clip_rect: ptr ImVec4 = nil): void {.importc: "ImDrawList_AddTextFontPtr".}
proc addTriangle*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: uint32, thickness: float32 = 1.0f): void {.importc: "ImDrawList_AddTriangle".}
proc addTriangleFilled*(self: ptr ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: uint32): void {.importc: "ImDrawList_AddTriangleFilled".}
proc channelsMerge*(self: ptr ImDrawList): void {.importc: "ImDrawList_ChannelsMerge".}
proc channelsSetCurrent*(self: ptr ImDrawList, n: int32): void {.importc: "ImDrawList_ChannelsSetCurrent".}
proc channelsSplit*(self: ptr ImDrawList, count: int32): void {.importc: "ImDrawList_ChannelsSplit".}
proc clear*(self: ptr ImDrawList): void {.importc: "ImDrawList_Clear".}
proc clearFreeMemory*(self: ptr ImDrawList): void {.importc: "ImDrawList_ClearFreeMemory".}
proc cloneOutput*(self: ptr ImDrawList): ptr ImDrawList {.importc: "ImDrawList_CloneOutput".}
proc getClipRectMaxNonUDT*(pOut: ptr ImVec2, self: ptr ImDrawList): void {.importc: "ImDrawList_GetClipRectMax".}
proc getClipRectMinNonUDT*(pOut: ptr ImVec2, self: ptr ImDrawList): void {.importc: "ImDrawList_GetClipRectMin".}
proc newImDrawList*(shared_data: ptr ImDrawListSharedData): void {.importc: "ImDrawList_ImDrawList".}
proc pathArcTo*(self: ptr ImDrawList, center: ImVec2, radius: float32, a_min: float32, a_max: float32, num_segments: int32 = 10): void {.importc: "ImDrawList_PathArcTo".}
proc pathArcToFast*(self: ptr ImDrawList, center: ImVec2, radius: float32, a_min_of_12: int32, a_max_of_12: int32): void {.importc: "ImDrawList_PathArcToFast".}
proc pathBezierCurveTo*(self: ptr ImDrawList, p2: ImVec2, p3: ImVec2, p4: ImVec2, num_segments: int32 = 0): void {.importc: "ImDrawList_PathBezierCurveTo".}
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
proc primUnreserve*(self: ptr ImDrawList, idx_count: int32, vtx_count: int32): void {.importc: "ImDrawList_PrimUnreserve".}
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
proc getBit*(self: ptr ImFontGlyphRangesBuilder, n: uint): bool {.importc: "ImFontGlyphRangesBuilder_GetBit".}
proc newImFontGlyphRangesBuilder*(): void {.importc: "ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder".}
proc setBit*(self: ptr ImFontGlyphRangesBuilder, n: uint): void {.importc: "ImFontGlyphRangesBuilder_SetBit".}
proc destroy*(self: ptr ImFontGlyphRangesBuilder): void {.importc: "ImFontGlyphRangesBuilder_destroy".}
proc addGlyph*(self: ptr ImFont, c: ImWchar, x0: float32, y0: float32, x1: float32, y1: float32, u0: float32, v0: float32, u1: float32, v1: float32, advance_x: float32): void {.importc: "ImFont_AddGlyph".}
proc addRemapChar*(self: ptr ImFont, dst: ImWchar, src: ImWchar, overwrite_dst: bool = true): void {.importc: "ImFont_AddRemapChar".}
proc buildLookupTable*(self: ptr ImFont): void {.importc: "ImFont_BuildLookupTable".}
proc calcTextSizeANonUDT*(pOut: ptr ImVec2, self: ptr ImFont, size: float32, max_width: float32, wrap_width: float32, text_begin: cstring, text_end: cstring = nil, remaining: ptr cstring = nil): void {.importc: "ImFont_CalcTextSizeA".}
proc calcWordWrapPositionA*(self: ptr ImFont, scale: float32, text: cstring, text_end: cstring, wrap_width: float32): cstring {.importc: "ImFont_CalcWordWrapPositionA".}
proc clearOutputData*(self: ptr ImFont): void {.importc: "ImFont_ClearOutputData".}
proc findGlyph*(self: ptr ImFont, c: ImWchar): ptr ImFontGlyph {.importc: "ImFont_FindGlyph".}
proc findGlyphNoFallback*(self: ptr ImFont, c: ImWchar): ptr ImFontGlyph {.importc: "ImFont_FindGlyphNoFallback".}
proc getCharAdvance*(self: ptr ImFont, c: ImWchar): float32 {.importc: "ImFont_GetCharAdvance".}
proc getDebugName*(self: ptr ImFont): cstring {.importc: "ImFont_GetDebugName".}
proc growIndex*(self: ptr ImFont, new_size: int32): void {.importc: "ImFont_GrowIndex".}
proc newImFont*(): void {.importc: "ImFont_ImFont".}
proc isGlyphRangeUnused*(self: ptr ImFont, c_begin: uint32, c_last: uint32): bool {.importc: "ImFont_IsGlyphRangeUnused".}
proc isLoaded*(self: ptr ImFont): bool {.importc: "ImFont_IsLoaded".}
proc renderChar*(self: ptr ImFont, draw_list: ptr ImDrawList, size: float32, pos: ImVec2, col: uint32, c: ImWchar): void {.importc: "ImFont_RenderChar".}
proc renderText*(self: ptr ImFont, draw_list: ptr ImDrawList, size: float32, pos: ImVec2, col: uint32, clip_rect: ImVec4, text_begin: cstring, text_end: cstring, wrap_width: float32 = 0.0f, cpu_fine_clip: bool = false): void {.importc: "ImFont_RenderText".}
proc setFallbackChar*(self: ptr ImFont, c: ImWchar): void {.importc: "ImFont_SetFallbackChar".}
proc setGlyphVisible*(self: ptr ImFont, c: ImWchar, visible: bool): void {.importc: "ImFont_SetGlyphVisible".}
proc destroy*(self: ptr ImFont): void {.importc: "ImFont_destroy".}
proc newImGuiColumnData*(): void {.importc: "ImGuiColumnData_ImGuiColumnData".}
proc destroy*(self: ptr ImGuiColumnData): void {.importc: "ImGuiColumnData_destroy".}
proc clear*(self: ptr ImGuiColumns): void {.importc: "ImGuiColumns_Clear".}
proc newImGuiColumns*(): void {.importc: "ImGuiColumns_ImGuiColumns".}
proc destroy*(self: ptr ImGuiColumns): void {.importc: "ImGuiColumns_destroy".}
proc newImGuiContext*(shared_font_atlas: ptr ImFontAtlas): void {.importc: "ImGuiContext_ImGuiContext".}
proc destroy*(self: ptr ImGuiContext): void {.importc: "ImGuiContext_destroy".}
proc addInputCharacter*(self: ptr ImGuiIO, c: uint32): void {.importc: "ImGuiIO_AddInputCharacter".}
proc addInputCharacterUTF16*(self: ptr ImGuiIO, c: ImWchar16): void {.importc: "ImGuiIO_AddInputCharacterUTF16".}
proc addInputCharactersUTF8*(self: ptr ImGuiIO, str: cstring): void {.importc: "ImGuiIO_AddInputCharactersUTF8".}
proc clearInputCharacters*(self: ptr ImGuiIO): void {.importc: "ImGuiIO_ClearInputCharacters".}
proc newImGuiIO*(): void {.importc: "ImGuiIO_ImGuiIO".}
proc destroy*(self: ptr ImGuiIO): void {.importc: "ImGuiIO_destroy".}
proc deleteChars*(self: ptr ImGuiInputTextCallbackData, pos: int32, bytes_count: int32): void {.importc: "ImGuiInputTextCallbackData_DeleteChars".}
proc hasSelection*(self: ptr ImGuiInputTextCallbackData): bool {.importc: "ImGuiInputTextCallbackData_HasSelection".}
proc newImGuiInputTextCallbackData*(): void {.importc: "ImGuiInputTextCallbackData_ImGuiInputTextCallbackData".}
proc insertChars*(self: ptr ImGuiInputTextCallbackData, pos: int32, text: cstring, text_end: cstring = nil): void {.importc: "ImGuiInputTextCallbackData_InsertChars".}
proc destroy*(self: ptr ImGuiInputTextCallbackData): void {.importc: "ImGuiInputTextCallbackData_destroy".}
proc clearFreeMemory*(self: ptr ImGuiInputTextState): void {.importc: "ImGuiInputTextState_ClearFreeMemory".}
proc clearSelection*(self: ptr ImGuiInputTextState): void {.importc: "ImGuiInputTextState_ClearSelection".}
proc clearText*(self: ptr ImGuiInputTextState): void {.importc: "ImGuiInputTextState_ClearText".}
proc cursorAnimReset*(self: ptr ImGuiInputTextState): void {.importc: "ImGuiInputTextState_CursorAnimReset".}
proc cursorClamp*(self: ptr ImGuiInputTextState): void {.importc: "ImGuiInputTextState_CursorClamp".}
proc getRedoAvailCount*(self: ptr ImGuiInputTextState): int32 {.importc: "ImGuiInputTextState_GetRedoAvailCount".}
proc getUndoAvailCount*(self: ptr ImGuiInputTextState): int32 {.importc: "ImGuiInputTextState_GetUndoAvailCount".}
proc hasSelection*(self: ptr ImGuiInputTextState): bool {.importc: "ImGuiInputTextState_HasSelection".}
proc newImGuiInputTextState*(): void {.importc: "ImGuiInputTextState_ImGuiInputTextState".}
proc onKeyPressed*(self: ptr ImGuiInputTextState, key: int32): void {.importc: "ImGuiInputTextState_OnKeyPressed".}
proc selectAll*(self: ptr ImGuiInputTextState): void {.importc: "ImGuiInputTextState_SelectAll".}
proc destroy*(self: ptr ImGuiInputTextState): void {.importc: "ImGuiInputTextState_destroy".}
proc backup*(self: ptr ImGuiItemHoveredDataBackup): void {.importc: "ImGuiItemHoveredDataBackup_Backup".}
proc newImGuiItemHoveredDataBackup*(): void {.importc: "ImGuiItemHoveredDataBackup_ImGuiItemHoveredDataBackup".}
proc restore*(self: ptr ImGuiItemHoveredDataBackup): void {.importc: "ImGuiItemHoveredDataBackup_Restore".}
proc destroy*(self: ptr ImGuiItemHoveredDataBackup): void {.importc: "ImGuiItemHoveredDataBackup_destroy".}
proc begin*(self: ptr ImGuiListClipper, items_count: int32, items_height: float32 = -1.0f): void {.importc: "ImGuiListClipper_Begin".}
proc `end`*(self: ptr ImGuiListClipper): void {.importc: "ImGuiListClipper_End".}
proc newImGuiListClipper*(items_count: int32 = -1, items_height: float32 = -1.0f): void {.importc: "ImGuiListClipper_ImGuiListClipper".}
proc step*(self: ptr ImGuiListClipper): bool {.importc: "ImGuiListClipper_Step".}
proc destroy*(self: ptr ImGuiListClipper): void {.importc: "ImGuiListClipper_destroy".}
proc calcExtraSpace*(self: ptr ImGuiMenuColumns, avail_w: float32): float32 {.importc: "ImGuiMenuColumns_CalcExtraSpace".}
proc declColumns*(self: ptr ImGuiMenuColumns, w0: float32, w1: float32, w2: float32): float32 {.importc: "ImGuiMenuColumns_DeclColumns".}
proc newImGuiMenuColumns*(): void {.importc: "ImGuiMenuColumns_ImGuiMenuColumns".}
proc update*(self: ptr ImGuiMenuColumns, count: int32, spacing: float32, clear: bool): void {.importc: "ImGuiMenuColumns_Update".}
proc destroy*(self: ptr ImGuiMenuColumns): void {.importc: "ImGuiMenuColumns_destroy".}
proc clear*(self: ptr ImGuiNavMoveResult): void {.importc: "ImGuiNavMoveResult_Clear".}
proc newImGuiNavMoveResult*(): void {.importc: "ImGuiNavMoveResult_ImGuiNavMoveResult".}
proc destroy*(self: ptr ImGuiNavMoveResult): void {.importc: "ImGuiNavMoveResult_destroy".}
proc clearFlags*(self: ptr ImGuiNextItemData): void {.importc: "ImGuiNextItemData_ClearFlags".}
proc newImGuiNextItemData*(): void {.importc: "ImGuiNextItemData_ImGuiNextItemData".}
proc destroy*(self: ptr ImGuiNextItemData): void {.importc: "ImGuiNextItemData_destroy".}
proc clearFlags*(self: ptr ImGuiNextWindowData): void {.importc: "ImGuiNextWindowData_ClearFlags".}
proc newImGuiNextWindowData*(): void {.importc: "ImGuiNextWindowData_ImGuiNextWindowData".}
proc destroy*(self: ptr ImGuiNextWindowData): void {.importc: "ImGuiNextWindowData_destroy".}
proc newImGuiOnceUponAFrame*(): void {.importc: "ImGuiOnceUponAFrame_ImGuiOnceUponAFrame".}
proc destroy*(self: ptr ImGuiOnceUponAFrame): void {.importc: "ImGuiOnceUponAFrame_destroy".}
proc clear*(self: ptr ImGuiPayload): void {.importc: "ImGuiPayload_Clear".}
proc newImGuiPayload*(): void {.importc: "ImGuiPayload_ImGuiPayload".}
proc isDataType*(self: ptr ImGuiPayload, `type`: cstring): bool {.importc: "ImGuiPayload_IsDataType".}
proc isDelivery*(self: ptr ImGuiPayload): bool {.importc: "ImGuiPayload_IsDelivery".}
proc isPreview*(self: ptr ImGuiPayload): bool {.importc: "ImGuiPayload_IsPreview".}
proc destroy*(self: ptr ImGuiPayload): void {.importc: "ImGuiPayload_destroy".}
proc newImGuiPopupData*(): void {.importc: "ImGuiPopupData_ImGuiPopupData".}
proc destroy*(self: ptr ImGuiPopupData): void {.importc: "ImGuiPopupData_destroy".}
proc newImGuiPtrOrIndex*(`ptr`: pointer): void {.importc: "ImGuiPtrOrIndex_ImGuiPtrOrIndexPtr".}
proc newImGuiPtrOrIndex*(index: int32): void {.importc: "ImGuiPtrOrIndex_ImGuiPtrOrIndexInt".}
proc destroy*(self: ptr ImGuiPtrOrIndex): void {.importc: "ImGuiPtrOrIndex_destroy".}
proc newImGuiSettingsHandler*(): void {.importc: "ImGuiSettingsHandler_ImGuiSettingsHandler".}
proc destroy*(self: ptr ImGuiSettingsHandler): void {.importc: "ImGuiSettingsHandler_destroy".}
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
proc newImGuiStyleMod*(idx: ImGuiStyleVar, v: int32): void {.importc: "ImGuiStyleMod_ImGuiStyleModInt".}
proc newImGuiStyleMod*(idx: ImGuiStyleVar, v: float32): void {.importc: "ImGuiStyleMod_ImGuiStyleModFloat".}
proc newImGuiStyleMod*(idx: ImGuiStyleVar, v: ImVec2): void {.importc: "ImGuiStyleMod_ImGuiStyleModVec2".}
proc destroy*(self: ptr ImGuiStyleMod): void {.importc: "ImGuiStyleMod_destroy".}
proc newImGuiStyle*(): void {.importc: "ImGuiStyle_ImGuiStyle".}
proc scaleAllSizes*(self: ptr ImGuiStyle, scale_factor: float32): void {.importc: "ImGuiStyle_ScaleAllSizes".}
proc destroy*(self: ptr ImGuiStyle): void {.importc: "ImGuiStyle_destroy".}
proc getTabName*(self: ptr ImGuiTabBar, tab: ptr ImGuiTabItem): cstring {.importc: "ImGuiTabBar_GetTabName".}
proc getTabOrder*(self: ptr ImGuiTabBar, tab: ptr ImGuiTabItem): int32 {.importc: "ImGuiTabBar_GetTabOrder".}
proc newImGuiTabBar*(): void {.importc: "ImGuiTabBar_ImGuiTabBar".}
proc destroy*(self: ptr ImGuiTabBar): void {.importc: "ImGuiTabBar_destroy".}
proc newImGuiTabItem*(): void {.importc: "ImGuiTabItem_ImGuiTabItem".}
proc destroy*(self: ptr ImGuiTabItem): void {.importc: "ImGuiTabItem_destroy".}
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
proc newImGuiTextRange*(): void {.importc: "ImGuiTextRange_ImGuiTextRangeNil".}
proc newImGuiTextRange*(b: cstring, e: cstring): void {.importc: "ImGuiTextRange_ImGuiTextRangeStr".}
proc destroy*(self: ptr ImGuiTextRange): void {.importc: "ImGuiTextRange_destroy".}
proc empty*(self: ptr ImGuiTextRange): bool {.importc: "ImGuiTextRange_empty".}
proc split*(self: ptr ImGuiTextRange, separator: int8, `out`: ptr ImVector[ImGuiTextRange]): void {.importc: "ImGuiTextRange_split".}
proc getName*(self: ptr ImGuiWindowSettings): cstring {.importc: "ImGuiWindowSettings_GetName".}
proc newImGuiWindowSettings*(): void {.importc: "ImGuiWindowSettings_ImGuiWindowSettings".}
proc destroy*(self: ptr ImGuiWindowSettings): void {.importc: "ImGuiWindowSettings_destroy".}
proc newImGuiWindowTempData*(): void {.importc: "ImGuiWindowTempData_ImGuiWindowTempData".}
proc destroy*(self: ptr ImGuiWindowTempData): void {.importc: "ImGuiWindowTempData_destroy".}
proc calcFontSize*(self: ptr ImGuiWindow): float32 {.importc: "ImGuiWindow_CalcFontSize".}
proc getID*(self: ptr ImGuiWindow, str: cstring, str_end: cstring = nil): ImGuiID {.importc: "ImGuiWindow_GetIDStr".}
proc getID*(self: ptr ImGuiWindow, `ptr`: pointer): ImGuiID {.importc: "ImGuiWindow_GetIDPtr".}
proc getID*(self: ptr ImGuiWindow, n: int32): ImGuiID {.importc: "ImGuiWindow_GetIDInt".}
proc getIDFromRectangle*(self: ptr ImGuiWindow, r_abs: ImRect): ImGuiID {.importc: "ImGuiWindow_GetIDFromRectangle".}
proc getIDNoKeepAlive*(self: ptr ImGuiWindow, str: cstring, str_end: cstring = nil): ImGuiID {.importc: "ImGuiWindow_GetIDNoKeepAliveStr".}
proc getIDNoKeepAlive*(self: ptr ImGuiWindow, `ptr`: pointer): ImGuiID {.importc: "ImGuiWindow_GetIDNoKeepAlivePtr".}
proc getIDNoKeepAlive*(self: ptr ImGuiWindow, n: int32): ImGuiID {.importc: "ImGuiWindow_GetIDNoKeepAliveInt".}
proc newImGuiWindow*(context: ptr ImGuiContext, name: cstring): void {.importc: "ImGuiWindow_ImGuiWindow".}
proc menuBarHeight*(self: ptr ImGuiWindow): float32 {.importc: "ImGuiWindow_MenuBarHeight".}
proc menuBarRectNonUDT*(pOut: ptr ImRect, self: ptr ImGuiWindow): void {.importc: "ImGuiWindow_MenuBarRect".}
proc rectNonUDT*(pOut: ptr ImRect, self: ptr ImGuiWindow): void {.importc: "ImGuiWindow_Rect".}
proc titleBarHeight*(self: ptr ImGuiWindow): float32 {.importc: "ImGuiWindow_TitleBarHeight".}
proc titleBarRectNonUDT*(pOut: ptr ImRect, self: ptr ImGuiWindow): void {.importc: "ImGuiWindow_TitleBarRect".}
proc destroy*(self: ptr ImGuiWindow): void {.importc: "ImGuiWindow_destroy".}
proc add*[T](self: ptr ImPool): ptr T {.importc: "ImPool_Add".}
proc clear*(self: ptr ImPool): void {.importc: "ImPool_Clear".}
proc contains*[T](self: ptr ImPool, p: ptr T): bool {.importc: "ImPool_Contains".}
proc getByIndex*[T](self: ptr ImPool, n: ImPoolIdx): ptr T {.importc: "ImPool_GetByIndex".}
proc getByKey*[T](self: ptr ImPool, key: ImGuiID): ptr T {.importc: "ImPool_GetByKey".}
proc getIndex*[T](self: ptr ImPool, p: ptr T): ImPoolIdx {.importc: "ImPool_GetIndex".}
proc getOrAddByKey*[T](self: ptr ImPool, key: ImGuiID): ptr T {.importc: "ImPool_GetOrAddByKey".}
proc getSize*(self: ptr ImPool): int32 {.importc: "ImPool_GetSize".}
proc newImPool*(): void {.importc: "ImPool_ImPool".}
proc remove*[T](self: ptr ImPool, key: ImGuiID, p: ptr T): void {.importc: "ImPool_RemoveTPtr".}
proc remove*(self: ptr ImPool, key: ImGuiID, idx: ImPoolIdx): void {.importc: "ImPool_RemovePoolIdx".}
proc reserve*(self: ptr ImPool, capacity: int32): void {.importc: "ImPool_Reserve".}
proc destroy*(self: ptr ImPool): void {.importc: "ImPool_destroy".}
proc add*(self: ptr ImRect, p: ImVec2): void {.importc: "ImRect_AddVec2".}
proc add*(self: ptr ImRect, r: ImRect): void {.importc: "ImRect_AddRect".}
proc clipWith*(self: ptr ImRect, r: ImRect): void {.importc: "ImRect_ClipWith".}
proc clipWithFull*(self: ptr ImRect, r: ImRect): void {.importc: "ImRect_ClipWithFull".}
proc contains*(self: ptr ImRect, p: ImVec2): bool {.importc: "ImRect_ContainsVec2".}
proc contains*(self: ptr ImRect, r: ImRect): bool {.importc: "ImRect_ContainsRect".}
proc expand*(self: ptr ImRect, amount: float32): void {.importc: "ImRect_ExpandFloat".}
proc expand*(self: ptr ImRect, amount: ImVec2): void {.importc: "ImRect_ExpandVec2".}
proc floor*(self: ptr ImRect): void {.importc: "ImRect_Floor".}
proc getBLNonUDT*(pOut: ptr ImVec2, self: ptr ImRect): void {.importc: "ImRect_GetBL".}
proc getBRNonUDT*(pOut: ptr ImVec2, self: ptr ImRect): void {.importc: "ImRect_GetBR".}
proc getCenterNonUDT*(pOut: ptr ImVec2, self: ptr ImRect): void {.importc: "ImRect_GetCenter".}
proc getHeight*(self: ptr ImRect): float32 {.importc: "ImRect_GetHeight".}
proc getSizeNonUDT*(pOut: ptr ImVec2, self: ptr ImRect): void {.importc: "ImRect_GetSize".}
proc getTLNonUDT*(pOut: ptr ImVec2, self: ptr ImRect): void {.importc: "ImRect_GetTL".}
proc getTRNonUDT*(pOut: ptr ImVec2, self: ptr ImRect): void {.importc: "ImRect_GetTR".}
proc getWidth*(self: ptr ImRect): float32 {.importc: "ImRect_GetWidth".}
proc newImRect*(): void {.importc: "ImRect_ImRectNil".}
proc newImRect*(min: ImVec2, max: ImVec2): void {.importc: "ImRect_ImRectVec2".}
proc newImRect*(v: ImVec4): void {.importc: "ImRect_ImRectVec4".}
proc newImRect*(x1: float32, y1: float32, x2: float32, y2: float32): void {.importc: "ImRect_ImRectFloat".}
proc isInverted*(self: ptr ImRect): bool {.importc: "ImRect_IsInverted".}
proc overlaps*(self: ptr ImRect, r: ImRect): bool {.importc: "ImRect_Overlaps".}
proc translate*(self: ptr ImRect, d: ImVec2): void {.importc: "ImRect_Translate".}
proc translateX*(self: ptr ImRect, dx: float32): void {.importc: "ImRect_TranslateX".}
proc translateY*(self: ptr ImRect, dy: float32): void {.importc: "ImRect_TranslateY".}
proc destroy*(self: ptr ImRect): void {.importc: "ImRect_destroy".}
proc newImVec1*(): void {.importc: "ImVec1_ImVec1Nil".}
proc newImVec1*(x: float32): void {.importc: "ImVec1_ImVec1Float".}
proc destroy*(self: ptr ImVec1): void {.importc: "ImVec1_destroy".}
proc newImVec2*(): void {.importc: "ImVec2_ImVec2Nil".}
proc newImVec2*(x: float32, y: float32): void {.importc: "ImVec2_ImVec2Float".}
proc destroy*(self: ptr ImVec2): void {.importc: "ImVec2_destroy".}
proc newImVec2ih*(): void {.importc: "ImVec2ih_ImVec2ihNil".}
proc newImVec2ih*(x: int16, y: int16): void {.importc: "ImVec2ih_ImVec2ihshort".}
proc newImVec2ih*(rhs: ImVec2): ImVec2ih {.importc: "ImVec2ih_ImVec2ihVec2".}
proc destroy*(self: ptr ImVec2ih): void {.importc: "ImVec2ih_destroy".}
proc newImVec4*(): void {.importc: "ImVec4_ImVec4Nil".}
proc newImVec4*(x: float32, y: float32, z: float32, w: float32): void {.importc: "ImVec4_ImVec4Float".}
proc destroy*(self: ptr ImVec4): void {.importc: "ImVec4_destroy".}
proc grow_capacity*(self: ptr ImVector, sz: int32): int32 {.importc: "ImVector__grow_capacity".}
proc back*[T](self: ptr ImVector): ptr T {.importc: "ImVector_backNil".}
proc begin*[T](self: ptr ImVector): ptr T {.importc: "ImVector_beginNil".}
proc capacity*(self: ptr ImVector): int32 {.importc: "ImVector_capacity".}
proc clear*(self: ptr ImVector): void {.importc: "ImVector_clear".}
proc contains*[T](self: ptr ImVector, v: T): bool {.importc: "ImVector_contains".}
proc destroy*(self: ptr ImVector): void {.importc: "ImVector_destroy".}
proc empty*(self: ptr ImVector): bool {.importc: "ImVector_empty".}
proc `end`*[T](self: ptr ImVector): ptr T {.importc: "ImVector_endNil".}
proc erase*[T](self: ptr ImVector, it: ptr T): ptr T {.importc: "ImVector_eraseNil".}
proc erase*[T](self: ptr ImVector, it: ptr T, it_last: ptr T): ptr T {.importc: "ImVector_eraseTPtr".}
proc erase_unsorted*[T](self: ptr ImVector, it: ptr T): ptr T {.importc: "ImVector_erase_unsorted".}
proc find*[T](self: ptr ImVector, v: T): ptr T {.importc: "ImVector_findNil".}
proc find_erase*[T](self: ptr ImVector, v: T): bool {.importc: "ImVector_find_erase".}
proc find_erase_unsorted*[T](self: ptr ImVector, v: T): bool {.importc: "ImVector_find_erase_unsorted".}
proc front*[T](self: ptr ImVector): ptr T {.importc: "ImVector_frontNil".}
proc index_from_ptr*[T](self: ptr ImVector, it: ptr T): int32 {.importc: "ImVector_index_from_ptr".}
proc insert*[T](self: ptr ImVector, it: ptr T, v: T): ptr T {.importc: "ImVector_insert".}
proc pop_back*(self: ptr ImVector): void {.importc: "ImVector_pop_back".}
proc push_back*[T](self: ptr ImVector, v: T): void {.importc: "ImVector_push_back".}
proc push_front*[T](self: ptr ImVector, v: T): void {.importc: "ImVector_push_front".}
proc reserve*(self: ptr ImVector, new_capacity: int32): void {.importc: "ImVector_reserve".}
proc resize*(self: ptr ImVector, new_size: int32): void {.importc: "ImVector_resizeNil".}
proc resize*[T](self: ptr ImVector, new_size: int32, v: T): void {.importc: "ImVector_resizeT".}
proc shrink*(self: ptr ImVector, new_size: int32): void {.importc: "ImVector_shrink".}
proc size*(self: ptr ImVector): int32 {.importc: "ImVector_size".}
proc size_in_bytes*(self: ptr ImVector): int32 {.importc: "ImVector_size_in_bytes".}
proc swap*(self: ptr ImVector, rhs: ImVector): void {.importc: "ImVector_swap".}
proc igAcceptDragDropPayload*(`type`: cstring, flags: ImGuiDragDropFlags = 0.ImGuiDragDropFlags): ptr ImGuiPayload {.importc: "igAcceptDragDropPayload".}
proc igActivateItem*(id: ImGuiID): void {.importc: "igActivateItem".}
proc igAlignTextToFramePadding*(): void {.importc: "igAlignTextToFramePadding".}
proc igArrowButton*(str_id: cstring, dir: ImGuiDir): bool {.importc: "igArrowButton".}
proc igArrowButtonEx*(str_id: cstring, dir: ImGuiDir, size_arg: ImVec2, flags: ImGuiButtonFlags = 0.ImGuiButtonFlags): bool {.importc: "igArrowButtonEx".}
proc igBegin*(name: cstring, p_open: ptr bool = nil, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBegin".}
proc igBeginChild*(str_id: cstring, size: ImVec2 = ImVec2(x: 0, y: 0), border: bool = false, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBeginChildStr".}
proc igBeginChild*(id: ImGuiID, size: ImVec2 = ImVec2(x: 0, y: 0), border: bool = false, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBeginChildID".}
proc igBeginChildEx*(name: cstring, id: ImGuiID, size_arg: ImVec2, border: bool, flags: ImGuiWindowFlags): bool {.importc: "igBeginChildEx".}
proc igBeginChildFrame*(id: ImGuiID, size: ImVec2, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBeginChildFrame".}
proc igBeginColumns*(str_id: cstring, count: int32, flags: ImGuiColumnsFlags = 0.ImGuiColumnsFlags): void {.importc: "igBeginColumns".}
proc igBeginCombo*(label: cstring, preview_value: cstring, flags: ImGuiComboFlags = 0.ImGuiComboFlags): bool {.importc: "igBeginCombo".}
proc igBeginDragDropSource*(flags: ImGuiDragDropFlags = 0.ImGuiDragDropFlags): bool {.importc: "igBeginDragDropSource".}
proc igBeginDragDropTarget*(): bool {.importc: "igBeginDragDropTarget".}
proc igBeginDragDropTargetCustom*(bb: ImRect, id: ImGuiID): bool {.importc: "igBeginDragDropTargetCustom".}
proc igBeginGroup*(): void {.importc: "igBeginGroup".}
proc igBeginMainMenuBar*(): bool {.importc: "igBeginMainMenuBar".}
proc igBeginMenu*(label: cstring, enabled: bool = true): bool {.importc: "igBeginMenu".}
proc igBeginMenuBar*(): bool {.importc: "igBeginMenuBar".}
proc igBeginPopup*(str_id: cstring, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBeginPopup".}
proc igBeginPopupContextItem*(str_id: cstring = nil, mouse_button: ImGuiMouseButton = 1.ImGuiMouseButton): bool {.importc: "igBeginPopupContextItem".}
proc igBeginPopupContextVoid*(str_id: cstring = nil, mouse_button: ImGuiMouseButton = 1.ImGuiMouseButton): bool {.importc: "igBeginPopupContextVoid".}
proc igBeginPopupContextWindow*(str_id: cstring = nil, mouse_button: ImGuiMouseButton = 1.ImGuiMouseButton, also_over_items: bool = true): bool {.importc: "igBeginPopupContextWindow".}
proc igBeginPopupEx*(id: ImGuiID, extra_flags: ImGuiWindowFlags): bool {.importc: "igBeginPopupEx".}
proc igBeginPopupModal*(name: cstring, p_open: ptr bool = nil, flags: ImGuiWindowFlags = 0.ImGuiWindowFlags): bool {.importc: "igBeginPopupModal".}
proc igBeginTabBar*(str_id: cstring, flags: ImGuiTabBarFlags = 0.ImGuiTabBarFlags): bool {.importc: "igBeginTabBar".}
proc igBeginTabBarEx*(tab_bar: ptr ImGuiTabBar, bb: ImRect, flags: ImGuiTabBarFlags): bool {.importc: "igBeginTabBarEx".}
proc igBeginTabItem*(label: cstring, p_open: ptr bool = nil, flags: ImGuiTabItemFlags = 0.ImGuiTabItemFlags): bool {.importc: "igBeginTabItem".}
proc igBeginTooltip*(): void {.importc: "igBeginTooltip".}
proc igBeginTooltipEx*(extra_flags: ImGuiWindowFlags, tooltip_flags: ImGuiTooltipFlags): void {.importc: "igBeginTooltipEx".}
proc igBringWindowToDisplayBack*(window: ptr ImGuiWindow): void {.importc: "igBringWindowToDisplayBack".}
proc igBringWindowToDisplayFront*(window: ptr ImGuiWindow): void {.importc: "igBringWindowToDisplayFront".}
proc igBringWindowToFocusFront*(window: ptr ImGuiWindow): void {.importc: "igBringWindowToFocusFront".}
proc igBullet*(): void {.importc: "igBullet".}
proc igBulletText*(fmt: cstring): void {.importc: "igBulletText", varargs.}
proc igBulletTextV*(fmt: cstring): void {.importc: "igBulletTextV", varargs.}
proc igButton*(label: cstring, size: ImVec2 = ImVec2(x: 0, y: 0)): bool {.importc: "igButton".}
proc igButtonBehavior*(bb: ImRect, id: ImGuiID, out_hovered: ptr bool, out_held: ptr bool, flags: ImGuiButtonFlags = 0.ImGuiButtonFlags): bool {.importc: "igButtonBehavior".}
proc igButtonEx*(label: cstring, size_arg: ImVec2 = ImVec2(x: 0, y: 0), flags: ImGuiButtonFlags = 0.ImGuiButtonFlags): bool {.importc: "igButtonEx".}
proc igCalcItemSizeNonUDT*(pOut: ptr ImVec2, size: ImVec2, default_w: float32, default_h: float32): void {.importc: "igCalcItemSize".}
proc igCalcItemWidth*(): float32 {.importc: "igCalcItemWidth".}
proc igCalcListClipping*(items_count: int32, items_height: float32, out_items_display_start: ptr int32, out_items_display_end: ptr int32): void {.importc: "igCalcListClipping".}
proc igCalcTextSizeNonUDT*(pOut: ptr ImVec2, text: cstring, text_end: cstring = nil, hide_text_after_double_hash: bool = false, wrap_width: float32 = -1.0f): void {.importc: "igCalcTextSize".}
proc igCalcTypematicRepeatAmount*(t0: float32, t1: float32, repeat_delay: float32, repeat_rate: float32): int32 {.importc: "igCalcTypematicRepeatAmount".}
proc igCalcWindowExpectedSizeNonUDT*(pOut: ptr ImVec2, window: ptr ImGuiWindow): void {.importc: "igCalcWindowExpectedSize".}
proc igCalcWrapWidthForPos*(pos: ImVec2, wrap_pos_x: float32): float32 {.importc: "igCalcWrapWidthForPos".}
proc igCaptureKeyboardFromApp*(want_capture_keyboard_value: bool = true): void {.importc: "igCaptureKeyboardFromApp".}
proc igCaptureMouseFromApp*(want_capture_mouse_value: bool = true): void {.importc: "igCaptureMouseFromApp".}
proc igCheckbox*(label: cstring, v: ptr bool): bool {.importc: "igCheckbox".}
proc igCheckboxFlags*(label: cstring, flags: ptr uint32, flags_value: uint32): bool {.importc: "igCheckboxFlags".}
proc igClearActiveID*(): void {.importc: "igClearActiveID".}
proc igClearDragDrop*(): void {.importc: "igClearDragDrop".}
proc igCloseButton*(id: ImGuiID, pos: ImVec2): bool {.importc: "igCloseButton".}
proc igCloseCurrentPopup*(): void {.importc: "igCloseCurrentPopup".}
proc igClosePopupToLevel*(remaining: int32, restore_focus_to_window_under_popup: bool): void {.importc: "igClosePopupToLevel".}
proc igClosePopupsOverWindow*(ref_window: ptr ImGuiWindow, restore_focus_to_window_under_popup: bool): void {.importc: "igClosePopupsOverWindow".}
proc igCollapseButton*(id: ImGuiID, pos: ImVec2): bool {.importc: "igCollapseButton".}
proc igCollapsingHeader*(label: cstring, flags: ImGuiTreeNodeFlags = 0.ImGuiTreeNodeFlags): bool {.importc: "igCollapsingHeaderTreeNodeFlags".}
proc igCollapsingHeader*(label: cstring, p_open: ptr bool, flags: ImGuiTreeNodeFlags = 0.ImGuiTreeNodeFlags): bool {.importc: "igCollapsingHeaderBoolPtr".}
proc igColorButton*(desc_id: cstring, col: ImVec4, flags: ImGuiColorEditFlags = 0.ImGuiColorEditFlags, size: ImVec2 = ImVec2(x: 0, y: 0)): bool {.importc: "igColorButton".}
proc igColorConvertFloat4ToU32*(`in`: ImVec4): uint32 {.importc: "igColorConvertFloat4ToU32".}
proc igColorConvertHSVtoRGB*(h: float32, s: float32, v: float32, out_r: float32, out_g: float32, out_b: float32): void {.importc: "igColorConvertHSVtoRGB".}
proc igColorConvertRGBtoHSV*(r: float32, g: float32, b: float32, out_h: float32, out_s: float32, out_v: float32): void {.importc: "igColorConvertRGBtoHSV".}
proc igColorConvertU32ToFloat4NonUDT*(pOut: ptr ImVec4, `in`: uint32): void {.importc: "igColorConvertU32ToFloat4".}
proc igColorEdit3*(label: cstring, col: var array[3, float32], flags: ImGuiColorEditFlags = 0.ImGuiColorEditFlags): bool {.importc: "igColorEdit3".}
proc igColorEdit4*(label: cstring, col: var array[4, float32], flags: ImGuiColorEditFlags = 0.ImGuiColorEditFlags): bool {.importc: "igColorEdit4".}
proc igColorEditOptionsPopup*(col: ptr float32, flags: ImGuiColorEditFlags): void {.importc: "igColorEditOptionsPopup".}
proc igColorPicker3*(label: cstring, col: var array[3, float32], flags: ImGuiColorEditFlags = 0.ImGuiColorEditFlags): bool {.importc: "igColorPicker3".}
proc igColorPicker4*(label: cstring, col: var array[4, float32], flags: ImGuiColorEditFlags = 0.ImGuiColorEditFlags, ref_col: ptr float32 = nil): bool {.importc: "igColorPicker4".}
proc igColorPickerOptionsPopup*(ref_col: ptr float32, flags: ImGuiColorEditFlags): void {.importc: "igColorPickerOptionsPopup".}
proc igColorTooltip*(text: cstring, col: ptr float32, flags: ImGuiColorEditFlags): void {.importc: "igColorTooltip".}
proc igColumns*(count: int32 = 1, id: cstring = nil, border: bool = true): void {.importc: "igColumns".}
proc igCombo*(label: cstring, current_item: ptr int32, items: ptr cstring, items_count: int32, popup_max_height_in_items: int32 = -1): bool {.importc: "igComboStr_arr".}
proc igCombo*(label: cstring, current_item: ptr int32, items_separated_by_zeros: cstring, popup_max_height_in_items: int32 = -1): bool {.importc: "igComboStr".}
proc igCombo*(label: cstring, current_item: ptr int32, items_getter: proc(data: pointer, idx: int32, out_text: ptr cstring): bool, data: pointer, items_count: int32, popup_max_height_in_items: int32 = -1): bool {.importc: "igComboFnPtr".}
proc igCreateContext*(shared_font_atlas: ptr ImFontAtlas = nil): ptr ImGuiContext {.importc: "igCreateContext".}
proc igCreateNewWindowSettings*(name: cstring): ptr ImGuiWindowSettings {.importc: "igCreateNewWindowSettings".}
proc igDataTypeApplyOp*(data_type: ImGuiDataType, op: int32, output: pointer, arg_1: pointer, arg_2: pointer): void {.importc: "igDataTypeApplyOp".}
proc igDataTypeApplyOpFromText*(buf: cstring, initial_value_buf: cstring, data_type: ImGuiDataType, p_data: pointer, format: cstring): bool {.importc: "igDataTypeApplyOpFromText".}
proc igDataTypeFormatString*(buf: cstring, buf_size: int32, data_type: ImGuiDataType, p_data: pointer, format: cstring): int32 {.importc: "igDataTypeFormatString".}
proc igDataTypeGetInfo*(data_type: ImGuiDataType): ptr ImGuiDataTypeInfo {.importc: "igDataTypeGetInfo".}
proc igDebugCheckVersionAndDataLayout*(version_str: cstring, sz_io: uint, sz_style: uint, sz_vec2: uint, sz_vec4: uint, sz_drawvert: uint, sz_drawidx: uint): bool {.importc: "igDebugCheckVersionAndDataLayout".}
proc igDebugDrawItemRect*(col: uint32 = 427819033): void {.importc: "igDebugDrawItemRect".}
proc igDebugStartItemPicker*(): void {.importc: "igDebugStartItemPicker".}
proc igDestroyContext*(ctx: ptr ImGuiContext = nil): void {.importc: "igDestroyContext".}
proc igDragBehavior*(id: ImGuiID, data_type: ImGuiDataType, p_v: pointer, v_speed: float32, p_min: pointer, p_max: pointer, format: cstring, power: float32, flags: ImGuiDragFlags): bool {.importc: "igDragBehavior".}
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
proc igDragScalar*(label: cstring, data_type: ImGuiDataType, p_data: pointer, v_speed: float32, p_min: pointer = nil, p_max: pointer = nil, format: cstring = nil, power: float32 = 1.0f): bool {.importc: "igDragScalar".}
proc igDragScalarN*(label: cstring, data_type: ImGuiDataType, p_data: pointer, components: int32, v_speed: float32, p_min: pointer = nil, p_max: pointer = nil, format: cstring = nil, power: float32 = 1.0f): bool {.importc: "igDragScalarN".}
proc igDummy*(size: ImVec2): void {.importc: "igDummy".}
proc igEnd*(): void {.importc: "igEnd".}
proc igEndChild*(): void {.importc: "igEndChild".}
proc igEndChildFrame*(): void {.importc: "igEndChildFrame".}
proc igEndColumns*(): void {.importc: "igEndColumns".}
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
proc igFindBestWindowPosForPopupNonUDT*(pOut: ptr ImVec2, window: ptr ImGuiWindow): void {.importc: "igFindBestWindowPosForPopup".}
proc igFindBestWindowPosForPopupExNonUDT*(pOut: ptr ImVec2, ref_pos: ImVec2, size: ImVec2, last_dir: ptr ImGuiDir, r_outer: ImRect, r_avoid: ImRect, policy: ImGuiPopupPositionPolicy = ImGuiPopupPositionPolicy.Default): void {.importc: "igFindBestWindowPosForPopupEx".}
proc igFindOrCreateColumns*(window: ptr ImGuiWindow, id: ImGuiID): ptr ImGuiColumns {.importc: "igFindOrCreateColumns".}
proc igFindOrCreateWindowSettings*(name: cstring): ptr ImGuiWindowSettings {.importc: "igFindOrCreateWindowSettings".}
proc igFindRenderedTextEnd*(text: cstring, text_end: cstring = nil): cstring {.importc: "igFindRenderedTextEnd".}
proc igFindSettingsHandler*(type_name: cstring): ptr ImGuiSettingsHandler {.importc: "igFindSettingsHandler".}
proc igFindWindowByID*(id: ImGuiID): ptr ImGuiWindow {.importc: "igFindWindowByID".}
proc igFindWindowByName*(name: cstring): ptr ImGuiWindow {.importc: "igFindWindowByName".}
proc igFindWindowSettings*(id: ImGuiID): ptr ImGuiWindowSettings {.importc: "igFindWindowSettings".}
proc igFocusTopMostWindowUnderOne*(under_this_window: ptr ImGuiWindow, ignore_window: ptr ImGuiWindow): void {.importc: "igFocusTopMostWindowUnderOne".}
proc igFocusWindow*(window: ptr ImGuiWindow): void {.importc: "igFocusWindow".}
proc igFocusableItemRegister*(window: ptr ImGuiWindow, id: ImGuiID): bool {.importc: "igFocusableItemRegister".}
proc igFocusableItemUnregister*(window: ptr ImGuiWindow): void {.importc: "igFocusableItemUnregister".}
proc igGcAwakeTransientWindowBuffers*(window: ptr ImGuiWindow): void {.importc: "igGcAwakeTransientWindowBuffers".}
proc igGcCompactTransientWindowBuffers*(window: ptr ImGuiWindow): void {.importc: "igGcCompactTransientWindowBuffers".}
proc igGetActiveID*(): ImGuiID {.importc: "igGetActiveID".}
proc igGetBackgroundDrawList*(): ptr ImDrawList {.importc: "igGetBackgroundDrawList".}
proc igGetClipboardText*(): cstring {.importc: "igGetClipboardText".}
proc igGetColorU32*(idx: ImGuiCol, alpha_mul: float32 = 1.0f): uint32 {.importc: "igGetColorU32Col".}
proc igGetColorU32*(col: ImVec4): uint32 {.importc: "igGetColorU32Vec4".}
proc igGetColorU32*(col: uint32): uint32 {.importc: "igGetColorU32U32".}
proc igGetColumnIndex*(): int32 {.importc: "igGetColumnIndex".}
proc igGetColumnNormFromOffset*(columns: ptr ImGuiColumns, offset: float32): float32 {.importc: "igGetColumnNormFromOffset".}
proc igGetColumnOffset*(column_index: int32 = -1): float32 {.importc: "igGetColumnOffset".}
proc igGetColumnOffsetFromNorm*(columns: ptr ImGuiColumns, offset_norm: float32): float32 {.importc: "igGetColumnOffsetFromNorm".}
proc igGetColumnWidth*(column_index: int32 = -1): float32 {.importc: "igGetColumnWidth".}
proc igGetColumnsCount*(): int32 {.importc: "igGetColumnsCount".}
proc igGetColumnsID*(str_id: cstring, count: int32): ImGuiID {.importc: "igGetColumnsID".}
proc igGetContentRegionAvailNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetContentRegionAvail".}
proc igGetContentRegionMaxNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetContentRegionMax".}
proc igGetContentRegionMaxAbsNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetContentRegionMaxAbs".}
proc igGetCurrentContext*(): ptr ImGuiContext {.importc: "igGetCurrentContext".}
proc igGetCurrentWindow*(): ptr ImGuiWindow {.importc: "igGetCurrentWindow".}
proc igGetCurrentWindowRead*(): ptr ImGuiWindow {.importc: "igGetCurrentWindowRead".}
proc igGetCursorPosNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetCursorPos".}
proc igGetCursorPosX*(): float32 {.importc: "igGetCursorPosX".}
proc igGetCursorPosY*(): float32 {.importc: "igGetCursorPosY".}
proc igGetCursorScreenPosNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetCursorScreenPos".}
proc igGetCursorStartPosNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetCursorStartPos".}
proc igGetDefaultFont*(): ptr ImFont {.importc: "igGetDefaultFont".}
proc igGetDragDropPayload*(): ptr ImGuiPayload {.importc: "igGetDragDropPayload".}
proc igGetDrawData*(): ptr ImDrawData {.importc: "igGetDrawData".}
proc igGetDrawListSharedData*(): ptr ImDrawListSharedData {.importc: "igGetDrawListSharedData".}
proc igGetFocusID*(): ImGuiID {.importc: "igGetFocusID".}
proc igGetFocusScopeID*(): ImGuiID {.importc: "igGetFocusScopeID".}
proc igGetFont*(): ptr ImFont {.importc: "igGetFont".}
proc igGetFontSize*(): float32 {.importc: "igGetFontSize".}
proc igGetFontTexUvWhitePixelNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetFontTexUvWhitePixel".}
proc igGetForegroundDrawList*(): ptr ImDrawList {.importc: "igGetForegroundDrawListNil".}
proc igGetForegroundDrawList*(window: ptr ImGuiWindow): ptr ImDrawList {.importc: "igGetForegroundDrawListWindowPtr".}
proc igGetFrameCount*(): int32 {.importc: "igGetFrameCount".}
proc igGetFrameHeight*(): float32 {.importc: "igGetFrameHeight".}
proc igGetFrameHeightWithSpacing*(): float32 {.importc: "igGetFrameHeightWithSpacing".}
proc igGetHoveredID*(): ImGuiID {.importc: "igGetHoveredID".}
proc igGetID*(str_id: cstring): ImGuiID {.importc: "igGetIDStr".}
proc igGetID*(str_id_begin: cstring, str_id_end: cstring): ImGuiID {.importc: "igGetIDStrStr".}
proc igGetID*(ptr_id: pointer): ImGuiID {.importc: "igGetIDPtr".}
proc igGetIO*(): ptr ImGuiIO {.importc: "igGetIO".}
proc igGetInputTextState*(id: ImGuiID): ptr ImGuiInputTextState {.importc: "igGetInputTextState".}
proc igGetItemID*(): ImGuiID {.importc: "igGetItemID".}
proc igGetItemRectMaxNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetItemRectMax".}
proc igGetItemRectMinNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetItemRectMin".}
proc igGetItemRectSizeNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetItemRectSize".}
proc igGetItemStatusFlags*(): ImGuiItemStatusFlags {.importc: "igGetItemStatusFlags".}
proc igGetKeyIndex*(imgui_key: ImGuiKey): int32 {.importc: "igGetKeyIndex".}
proc igGetKeyPressedAmount*(key_index: int32, repeat_delay: float32, rate: float32): int32 {.importc: "igGetKeyPressedAmount".}
proc igGetMergedKeyModFlags*(): ImGuiKeyModFlags {.importc: "igGetMergedKeyModFlags".}
proc igGetMouseCursor*(): ImGuiMouseCursor {.importc: "igGetMouseCursor".}
proc igGetMouseDragDeltaNonUDT*(pOut: ptr ImVec2, button: ImGuiMouseButton = 0.ImGuiMouseButton, lock_threshold: float32 = -1.0f): void {.importc: "igGetMouseDragDelta".}
proc igGetMousePosNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetMousePos".}
proc igGetMousePosOnOpeningCurrentPopupNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetMousePosOnOpeningCurrentPopup".}
proc igGetNavInputAmount*(n: ImGuiNavInput, mode: ImGuiInputReadMode): float32 {.importc: "igGetNavInputAmount".}
proc igGetNavInputAmount2dNonUDT*(pOut: ptr ImVec2, dir_sources: ImGuiNavDirSourceFlags, mode: ImGuiInputReadMode, slow_factor: float32 = 0.0f, fast_factor: float32 = 0.0f): void {.importc: "igGetNavInputAmount2d".}
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
proc igGetTopMostPopupModal*(): ptr ImGuiWindow {.importc: "igGetTopMostPopupModal".}
proc igGetTreeNodeToLabelSpacing*(): float32 {.importc: "igGetTreeNodeToLabelSpacing".}
proc igGetVersion*(): cstring {.importc: "igGetVersion".}
proc igGetWindowAllowedExtentRectNonUDT*(pOut: ptr ImRect, window: ptr ImGuiWindow): void {.importc: "igGetWindowAllowedExtentRect".}
proc igGetWindowContentRegionMaxNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetWindowContentRegionMax".}
proc igGetWindowContentRegionMinNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetWindowContentRegionMin".}
proc igGetWindowContentRegionWidth*(): float32 {.importc: "igGetWindowContentRegionWidth".}
proc igGetWindowDrawList*(): ptr ImDrawList {.importc: "igGetWindowDrawList".}
proc igGetWindowHeight*(): float32 {.importc: "igGetWindowHeight".}
proc igGetWindowPosNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetWindowPos".}
proc igGetWindowResizeID*(window: ptr ImGuiWindow, n: int32): ImGuiID {.importc: "igGetWindowResizeID".}
proc igGetWindowScrollbarID*(window: ptr ImGuiWindow, axis: ImGuiAxis): ImGuiID {.importc: "igGetWindowScrollbarID".}
proc igGetWindowScrollbarRectNonUDT*(pOut: ptr ImRect, window: ptr ImGuiWindow, axis: ImGuiAxis): void {.importc: "igGetWindowScrollbarRect".}
proc igGetWindowSizeNonUDT*(pOut: ptr ImVec2): void {.importc: "igGetWindowSize".}
proc igGetWindowWidth*(): float32 {.importc: "igGetWindowWidth".}
proc igImAlphaBlendColors*(col_a: uint32, col_b: uint32): uint32 {.importc: "igImAlphaBlendColors".}
proc igImBezierCalcNonUDT*(pOut: ptr ImVec2, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, t: float32): void {.importc: "igImBezierCalc".}
proc igImBezierClosestPointNonUDT*(pOut: ptr ImVec2, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, p: ImVec2, num_segments: int32): void {.importc: "igImBezierClosestPoint".}
proc igImBezierClosestPointCasteljauNonUDT*(pOut: ptr ImVec2, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, p: ImVec2, tess_tol: float32): void {.importc: "igImBezierClosestPointCasteljau".}
proc igImBitArrayClearBit*(arr: ptr uint32, n: int32): void {.importc: "igImBitArrayClearBit".}
proc igImBitArraySetBit*(arr: ptr uint32, n: int32): void {.importc: "igImBitArraySetBit".}
proc igImBitArraySetBitRange*(arr: ptr uint32, n: int32, n2: int32): void {.importc: "igImBitArraySetBitRange".}
proc igImBitArrayTestBit*(arr: ptr uint32, n: int32): bool {.importc: "igImBitArrayTestBit".}
proc igImCharIsBlankA*(c: int8): bool {.importc: "igImCharIsBlankA".}
proc igImCharIsBlankW*(c: uint32): bool {.importc: "igImCharIsBlankW".}
proc igImClampNonUDT*(pOut: ptr ImVec2, v: ImVec2, mn: ImVec2, mx: ImVec2): void {.importc: "igImClamp".}
proc igImDot*(a: ImVec2, b: ImVec2): float32 {.importc: "igImDot".}
proc igImFileClose*(file: ImFileHandle): bool {.importc: "igImFileClose".}
proc igImFileGetSize*(file: ImFileHandle): uint64 {.importc: "igImFileGetSize".}
proc igImFileLoadToMemory*(filename: cstring, mode: cstring, out_file_size: ptr uint = nil, padding_bytes: int32 = 0): pointer {.importc: "igImFileLoadToMemory".}
proc igImFileOpen*(filename: cstring, mode: cstring): ImFileHandle {.importc: "igImFileOpen".}
proc igImFileRead*(data: pointer, size: uint64, count: uint64, file: ImFileHandle): uint64 {.importc: "igImFileRead".}
proc igImFileWrite*(data: pointer, size: uint64, count: uint64, file: ImFileHandle): uint64 {.importc: "igImFileWrite".}
proc igImFloor*(f: float32): float32 {.importc: "igImFloorFloat".}
proc igImFloorNonUDT*(pOut: ptr ImVec2, v: ImVec2): void {.importc: "igImFloorVec2".}
proc igImFontAtlasBuildFinish*(atlas: ptr ImFontAtlas): void {.importc: "igImFontAtlasBuildFinish".}
proc igImFontAtlasBuildInit*(atlas: ptr ImFontAtlas): void {.importc: "igImFontAtlasBuildInit".}
proc igImFontAtlasBuildMultiplyCalcLookupTable*(out_table: cuchar, in_multiply_factor: float32): void {.importc: "igImFontAtlasBuildMultiplyCalcLookupTable".}
proc igImFontAtlasBuildMultiplyRectAlpha8*(table: cuchar, pixels: ptr cuchar, x: int32, y: int32, w: int32, h: int32, stride: int32): void {.importc: "igImFontAtlasBuildMultiplyRectAlpha8".}
proc igImFontAtlasBuildPackCustomRects*(atlas: ptr ImFontAtlas, stbrp_context_opaque: pointer): void {.importc: "igImFontAtlasBuildPackCustomRects".}
proc igImFontAtlasBuildSetupFont*(atlas: ptr ImFontAtlas, font: ptr ImFont, font_config: ptr ImFontConfig, ascent: float32, descent: float32): void {.importc: "igImFontAtlasBuildSetupFont".}
proc igImFontAtlasBuildWithStbTruetype*(atlas: ptr ImFontAtlas): bool {.importc: "igImFontAtlasBuildWithStbTruetype".}
proc igImFormatString*(buf: cstring, buf_size: uint, fmt: cstring): int32 {.importc: "igImFormatString", varargs.}
proc igImFormatStringV*(buf: cstring, buf_size: uint, fmt: cstring): int32 {.importc: "igImFormatStringV", varargs.}
proc igImGetDirQuadrantFromDelta*(dx: float32, dy: float32): ImGuiDir {.importc: "igImGetDirQuadrantFromDelta".}
proc igImHashData*(data: pointer, data_size: uint, seed: uint32 = 0): uint32 {.importc: "igImHashData".}
proc igImHashStr*(data: cstring, data_size: uint = 0, seed: uint32 = 0): uint32 {.importc: "igImHashStr".}
proc igImInvLength*(lhs: ImVec2, fail_value: float32): float32 {.importc: "igImInvLength".}
proc igImIsPowerOfTwo*(v: int32): bool {.importc: "igImIsPowerOfTwo".}
proc igImLengthSqr*(lhs: ImVec2): float32 {.importc: "igImLengthSqrVec2".}
proc igImLengthSqr*(lhs: ImVec4): float32 {.importc: "igImLengthSqrVec4".}
proc igImLerpNonUDT*(pOut: ptr ImVec2, a: ImVec2, b: ImVec2, t: float32): void {.importc: "igImLerpVec2Float".}
proc igImLerpNonUDT2*(pOut: ptr ImVec2, a: ImVec2, b: ImVec2, t: ImVec2): void {.importc: "igImLerpVec2Vec2".}
proc igImLerpNonUDT3*(pOut: ptr ImVec4, a: ImVec4, b: ImVec4, t: float32): void {.importc: "igImLerpVec4".}
proc igImLineClosestPointNonUDT*(pOut: ptr ImVec2, a: ImVec2, b: ImVec2, p: ImVec2): void {.importc: "igImLineClosestPoint".}
proc igImLinearSweep*(current: float32, target: float32, speed: float32): float32 {.importc: "igImLinearSweep".}
proc igImMaxNonUDT*(pOut: ptr ImVec2, lhs: ImVec2, rhs: ImVec2): void {.importc: "igImMax".}
proc igImMinNonUDT*(pOut: ptr ImVec2, lhs: ImVec2, rhs: ImVec2): void {.importc: "igImMin".}
proc igImModPositive*(a: int32, b: int32): int32 {.importc: "igImModPositive".}
proc igImMulNonUDT*(pOut: ptr ImVec2, lhs: ImVec2, rhs: ImVec2): void {.importc: "igImMul".}
proc igImParseFormatFindEnd*(format: cstring): cstring {.importc: "igImParseFormatFindEnd".}
proc igImParseFormatFindStart*(format: cstring): cstring {.importc: "igImParseFormatFindStart".}
proc igImParseFormatPrecision*(format: cstring, default_value: int32): int32 {.importc: "igImParseFormatPrecision".}
proc igImParseFormatTrimDecorations*(format: cstring, buf: cstring, buf_size: uint): cstring {.importc: "igImParseFormatTrimDecorations".}
proc igImPow*(x: float32, y: float32): float32 {.importc: "igImPowFloat".}
proc igImPow*(x: float64, y: float64): float64 {.importc: "igImPowdouble".}
proc igImRotateNonUDT*(pOut: ptr ImVec2, v: ImVec2, cos_a: float32, sin_a: float32): void {.importc: "igImRotate".}
proc igImSaturate*(f: float32): float32 {.importc: "igImSaturate".}
proc igImStrSkipBlank*(str: cstring): cstring {.importc: "igImStrSkipBlank".}
proc igImStrTrimBlanks*(str: cstring): void {.importc: "igImStrTrimBlanks".}
proc igImStrbolW*(buf_mid_line: ptr ImWchar, buf_begin: ptr ImWchar): ptr ImWchar {.importc: "igImStrbolW".}
proc igImStrchrRange*(str_begin: cstring, str_end: cstring, c: int8): cstring {.importc: "igImStrchrRange".}
proc igImStrdup*(str: cstring): cstring {.importc: "igImStrdup".}
proc igImStrdupcpy*(dst: cstring, p_dst_size: ptr uint, str: cstring): cstring {.importc: "igImStrdupcpy".}
proc igImStreolRange*(str: cstring, str_end: cstring): cstring {.importc: "igImStreolRange".}
proc igImStricmp*(str1: cstring, str2: cstring): int32 {.importc: "igImStricmp".}
proc igImStristr*(haystack: cstring, haystack_end: cstring, needle: cstring, needle_end: cstring): cstring {.importc: "igImStristr".}
proc igImStrlenW*(str: ptr ImWchar): int32 {.importc: "igImStrlenW".}
proc igImStrncpy*(dst: cstring, src: cstring, count: uint): void {.importc: "igImStrncpy".}
proc igImStrnicmp*(str1: cstring, str2: cstring, count: uint): int32 {.importc: "igImStrnicmp".}
proc igImTextCharFromUtf8*(out_char: ptr uint32, in_text: cstring, in_text_end: cstring): int32 {.importc: "igImTextCharFromUtf8".}
proc igImTextCountCharsFromUtf8*(in_text: cstring, in_text_end: cstring): int32 {.importc: "igImTextCountCharsFromUtf8".}
proc igImTextCountUtf8BytesFromChar*(in_text: cstring, in_text_end: cstring): int32 {.importc: "igImTextCountUtf8BytesFromChar".}
proc igImTextCountUtf8BytesFromStr*(in_text: ptr ImWchar, in_text_end: ptr ImWchar): int32 {.importc: "igImTextCountUtf8BytesFromStr".}
proc igImTextStrFromUtf8*(buf: ptr ImWchar, buf_size: int32, in_text: cstring, in_text_end: cstring, in_remaining: ptr cstring = nil): int32 {.importc: "igImTextStrFromUtf8".}
proc igImTextStrToUtf8*(buf: cstring, buf_size: int32, in_text: ptr ImWchar, in_text_end: ptr ImWchar): int32 {.importc: "igImTextStrToUtf8".}
proc igImTriangleArea*(a: ImVec2, b: ImVec2, c: ImVec2): float32 {.importc: "igImTriangleArea".}
proc igImTriangleBarycentricCoords*(a: ImVec2, b: ImVec2, c: ImVec2, p: ImVec2, out_u: float32, out_v: float32, out_w: float32): void {.importc: "igImTriangleBarycentricCoords".}
proc igImTriangleClosestPointNonUDT*(pOut: ptr ImVec2, a: ImVec2, b: ImVec2, c: ImVec2, p: ImVec2): void {.importc: "igImTriangleClosestPoint".}
proc igImTriangleContainsPoint*(a: ImVec2, b: ImVec2, c: ImVec2, p: ImVec2): bool {.importc: "igImTriangleContainsPoint".}
proc igImUpperPowerOfTwo*(v: int32): int32 {.importc: "igImUpperPowerOfTwo".}
proc igImage*(user_texture_id: ImTextureID, size: ImVec2, uv0: ImVec2 = ImVec2(x: 0, y: 0), uv1: ImVec2 = ImVec2(x: 1, y: 1), tint_col: ImVec4 = ImVec4(x: 1, y: 1, z: 1, w: 1), border_col: ImVec4 = ImVec4(x: 0, y: 0, z: 0, w: 0)): void {.importc: "igImage".}
proc igImageButton*(user_texture_id: ImTextureID, size: ImVec2, uv0: ImVec2 = ImVec2(x: 0, y: 0), uv1: ImVec2 = ImVec2(x: 1, y: 1), frame_padding: int32 = -1, bg_col: ImVec4 = ImVec4(x: 0, y: 0, z: 0, w: 0), tint_col: ImVec4 = ImVec4(x: 1, y: 1, z: 1, w: 1)): bool {.importc: "igImageButton".}
proc igIndent*(indent_w: float32 = 0.0f): void {.importc: "igIndent".}
proc igInitialize*(context: ptr ImGuiContext): void {.importc: "igInitialize".}
proc igInputDouble*(label: cstring, v: ptr float64, step: float64 = 0.0, step_fast: float64 = 0.0, format: cstring = "%.6f", flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputDouble".}
proc igInputFloat*(label: cstring, v: ptr float32, step: float32 = 0.0f, step_fast: float32 = 0.0f, format: cstring = "%.3f", flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputFloat".}
proc igInputFloat2*(label: cstring, v: var array[2, float32], format: cstring = "%.3f", flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputFloat2".}
proc igInputFloat3*(label: cstring, v: var array[3, float32], format: cstring = "%.3f", flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputFloat3".}
proc igInputFloat4*(label: cstring, v: var array[4, float32], format: cstring = "%.3f", flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputFloat4".}
proc igInputInt*(label: cstring, v: ptr int32, step: int32 = 1, step_fast: int32 = 100, flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputInt".}
proc igInputInt2*(label: cstring, v: var array[2, int32], flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputInt2".}
proc igInputInt3*(label: cstring, v: var array[3, int32], flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputInt3".}
proc igInputInt4*(label: cstring, v: var array[4, int32], flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputInt4".}
proc igInputScalar*(label: cstring, data_type: ImGuiDataType, p_data: pointer, p_step: pointer = nil, p_step_fast: pointer = nil, format: cstring = nil, flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputScalar".}
proc igInputScalarN*(label: cstring, data_type: ImGuiDataType, p_data: pointer, components: int32, p_step: pointer = nil, p_step_fast: pointer = nil, format: cstring = nil, flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags): bool {.importc: "igInputScalarN".}
proc igInputText*(label: cstring, buf: cstring, buf_size: uint, flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags, callback: ImGuiInputTextCallback = nil, user_data: pointer = nil): bool {.importc: "igInputText".}
proc igInputTextEx*(label: cstring, hint: cstring, buf: cstring, buf_size: int32, size_arg: ImVec2, flags: ImGuiInputTextFlags, callback: ImGuiInputTextCallback = nil, user_data: pointer = nil): bool {.importc: "igInputTextEx".}
proc igInputTextMultiline*(label: cstring, buf: cstring, buf_size: uint, size: ImVec2 = ImVec2(x: 0, y: 0), flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags, callback: ImGuiInputTextCallback = nil, user_data: pointer = nil): bool {.importc: "igInputTextMultiline".}
proc igInputTextWithHint*(label: cstring, hint: cstring, buf: cstring, buf_size: uint, flags: ImGuiInputTextFlags = 0.ImGuiInputTextFlags, callback: ImGuiInputTextCallback = nil, user_data: pointer = nil): bool {.importc: "igInputTextWithHint".}
proc igInvisibleButton*(str_id: cstring, size: ImVec2): bool {.importc: "igInvisibleButton".}
proc igIsActiveIdUsingKey*(key: ImGuiKey): bool {.importc: "igIsActiveIdUsingKey".}
proc igIsActiveIdUsingNavDir*(dir: ImGuiDir): bool {.importc: "igIsActiveIdUsingNavDir".}
proc igIsActiveIdUsingNavInput*(input: ImGuiNavInput): bool {.importc: "igIsActiveIdUsingNavInput".}
proc igIsAnyItemActive*(): bool {.importc: "igIsAnyItemActive".}
proc igIsAnyItemFocused*(): bool {.importc: "igIsAnyItemFocused".}
proc igIsAnyItemHovered*(): bool {.importc: "igIsAnyItemHovered".}
proc igIsAnyMouseDown*(): bool {.importc: "igIsAnyMouseDown".}
proc igIsClippedEx*(bb: ImRect, id: ImGuiID, clip_even_when_logged: bool): bool {.importc: "igIsClippedEx".}
proc igIsDragDropPayloadBeingAccepted*(): bool {.importc: "igIsDragDropPayloadBeingAccepted".}
proc igIsItemActivated*(): bool {.importc: "igIsItemActivated".}
proc igIsItemActive*(): bool {.importc: "igIsItemActive".}
proc igIsItemClicked*(mouse_button: ImGuiMouseButton = 0.ImGuiMouseButton): bool {.importc: "igIsItemClicked".}
proc igIsItemDeactivated*(): bool {.importc: "igIsItemDeactivated".}
proc igIsItemDeactivatedAfterEdit*(): bool {.importc: "igIsItemDeactivatedAfterEdit".}
proc igIsItemEdited*(): bool {.importc: "igIsItemEdited".}
proc igIsItemFocused*(): bool {.importc: "igIsItemFocused".}
proc igIsItemHovered*(flags: ImGuiHoveredFlags = 0.ImGuiHoveredFlags): bool {.importc: "igIsItemHovered".}
proc igIsItemToggledOpen*(): bool {.importc: "igIsItemToggledOpen".}
proc igIsItemToggledSelection*(): bool {.importc: "igIsItemToggledSelection".}
proc igIsItemVisible*(): bool {.importc: "igIsItemVisible".}
proc igIsKeyDown*(user_key_index: int32): bool {.importc: "igIsKeyDown".}
proc igIsKeyPressed*(user_key_index: int32, repeat: bool = true): bool {.importc: "igIsKeyPressed".}
proc igIsKeyPressedMap*(key: ImGuiKey, repeat: bool = true): bool {.importc: "igIsKeyPressedMap".}
proc igIsKeyReleased*(user_key_index: int32): bool {.importc: "igIsKeyReleased".}
proc igIsMouseClicked*(button: ImGuiMouseButton, repeat: bool = false): bool {.importc: "igIsMouseClicked".}
proc igIsMouseDoubleClicked*(button: ImGuiMouseButton): bool {.importc: "igIsMouseDoubleClicked".}
proc igIsMouseDown*(button: ImGuiMouseButton): bool {.importc: "igIsMouseDown".}
proc igIsMouseDragPastThreshold*(button: ImGuiMouseButton, lock_threshold: float32 = -1.0f): bool {.importc: "igIsMouseDragPastThreshold".}
proc igIsMouseDragging*(button: ImGuiMouseButton, lock_threshold: float32 = -1.0f): bool {.importc: "igIsMouseDragging".}
proc igIsMouseHoveringRect*(r_min: ImVec2, r_max: ImVec2, clip: bool = true): bool {.importc: "igIsMouseHoveringRect".}
proc igIsMousePosValid*(mouse_pos: ptr ImVec2 = nil): bool {.importc: "igIsMousePosValid".}
proc igIsMouseReleased*(button: ImGuiMouseButton): bool {.importc: "igIsMouseReleased".}
proc igIsNavInputDown*(n: ImGuiNavInput): bool {.importc: "igIsNavInputDown".}
proc igIsNavInputTest*(n: ImGuiNavInput, rm: ImGuiInputReadMode): bool {.importc: "igIsNavInputTest".}
proc igIsPopupOpen*(str_id: cstring): bool {.importc: "igIsPopupOpenStr".}
proc igIsPopupOpen*(id: ImGuiID): bool {.importc: "igIsPopupOpenID".}
proc igIsRectVisible*(size: ImVec2): bool {.importc: "igIsRectVisibleNil".}
proc igIsRectVisible*(rect_min: ImVec2, rect_max: ImVec2): bool {.importc: "igIsRectVisibleVec2".}
proc igIsWindowAppearing*(): bool {.importc: "igIsWindowAppearing".}
proc igIsWindowChildOf*(window: ptr ImGuiWindow, potential_parent: ptr ImGuiWindow): bool {.importc: "igIsWindowChildOf".}
proc igIsWindowCollapsed*(): bool {.importc: "igIsWindowCollapsed".}
proc igIsWindowFocused*(flags: ImGuiFocusedFlags = 0.ImGuiFocusedFlags): bool {.importc: "igIsWindowFocused".}
proc igIsWindowHovered*(flags: ImGuiHoveredFlags = 0.ImGuiHoveredFlags): bool {.importc: "igIsWindowHovered".}
proc igIsWindowNavFocusable*(window: ptr ImGuiWindow): bool {.importc: "igIsWindowNavFocusable".}
proc igItemAdd*(bb: ImRect, id: ImGuiID, nav_bb: ptr ImRect = nil): bool {.importc: "igItemAdd".}
proc igItemHoverable*(bb: ImRect, id: ImGuiID): bool {.importc: "igItemHoverable".}
proc igItemSize*(size: ImVec2, text_baseline_y: float32 = -1.0f): void {.importc: "igItemSizeVec2".}
proc igItemSize*(bb: ImRect, text_baseline_y: float32 = -1.0f): void {.importc: "igItemSizeRect".}
proc igKeepAliveID*(id: ImGuiID): void {.importc: "igKeepAliveID".}
proc igLabelText*(label: cstring, fmt: cstring): void {.importc: "igLabelText", varargs.}
proc igLabelTextV*(label: cstring, fmt: cstring): void {.importc: "igLabelTextV", varargs.}
proc igListBox*(label: cstring, current_item: ptr int32, items: ptr cstring, items_count: int32, height_in_items: int32 = -1): bool {.importc: "igListBoxStr_arr".}
proc igListBox*(label: cstring, current_item: ptr int32, items_getter: proc(data: pointer, idx: int32, out_text: ptr cstring): bool, data: pointer, items_count: int32, height_in_items: int32 = -1): bool {.importc: "igListBoxFnPtr".}
proc igListBoxFooter*(): void {.importc: "igListBoxFooter".}
proc igListBoxHeader*(label: cstring, size: ImVec2 = ImVec2(x: 0, y: 0)): bool {.importc: "igListBoxHeaderVec2".}
proc igListBoxHeader*(label: cstring, items_count: int32, height_in_items: int32 = -1): bool {.importc: "igListBoxHeaderInt".}
proc igLoadIniSettingsFromDisk*(ini_filename: cstring): void {.importc: "igLoadIniSettingsFromDisk".}
proc igLoadIniSettingsFromMemory*(ini_data: cstring, ini_size: uint = 0): void {.importc: "igLoadIniSettingsFromMemory".}
proc igLogBegin*(`type`: ImGuiLogType, auto_open_depth: int32): void {.importc: "igLogBegin".}
proc igLogButtons*(): void {.importc: "igLogButtons".}
proc igLogFinish*(): void {.importc: "igLogFinish".}
proc igLogRenderedText*(ref_pos: ptr ImVec2, text: cstring, text_end: cstring = nil): void {.importc: "igLogRenderedText".}
proc igLogText*(fmt: cstring): void {.importc: "igLogText", varargs.}
proc igLogToBuffer*(auto_open_depth: int32 = -1): void {.importc: "igLogToBuffer".}
proc igLogToClipboard*(auto_open_depth: int32 = -1): void {.importc: "igLogToClipboard".}
proc igLogToFile*(auto_open_depth: int32 = -1, filename: cstring = nil): void {.importc: "igLogToFile".}
proc igLogToTTY*(auto_open_depth: int32 = -1): void {.importc: "igLogToTTY".}
proc igMarkIniSettingsDirty*(): void {.importc: "igMarkIniSettingsDirtyNil".}
proc igMarkIniSettingsDirty*(window: ptr ImGuiWindow): void {.importc: "igMarkIniSettingsDirtyWindowPtr".}
proc igMarkItemEdited*(id: ImGuiID): void {.importc: "igMarkItemEdited".}
proc igMemAlloc*(size: uint): pointer {.importc: "igMemAlloc".}
proc igMemFree*(`ptr`: pointer): void {.importc: "igMemFree".}
proc igMenuItem*(label: cstring, shortcut: cstring = nil, selected: bool = false, enabled: bool = true): bool {.importc: "igMenuItemBool".}
proc igMenuItem*(label: cstring, shortcut: cstring, p_selected: ptr bool, enabled: bool = true): bool {.importc: "igMenuItemBoolPtr".}
proc igNavInitWindow*(window: ptr ImGuiWindow, force_reinit: bool): void {.importc: "igNavInitWindow".}
proc igNavMoveRequestButNoResultYet*(): bool {.importc: "igNavMoveRequestButNoResultYet".}
proc igNavMoveRequestCancel*(): void {.importc: "igNavMoveRequestCancel".}
proc igNavMoveRequestForward*(move_dir: ImGuiDir, clip_dir: ImGuiDir, bb_rel: ImRect, move_flags: ImGuiNavMoveFlags): void {.importc: "igNavMoveRequestForward".}
proc igNavMoveRequestTryWrapping*(window: ptr ImGuiWindow, move_flags: ImGuiNavMoveFlags): void {.importc: "igNavMoveRequestTryWrapping".}
proc igNewFrame*(): void {.importc: "igNewFrame".}
proc igNewLine*(): void {.importc: "igNewLine".}
proc igNextColumn*(): void {.importc: "igNextColumn".}
proc igOpenPopup*(str_id: cstring): void {.importc: "igOpenPopup".}
proc igOpenPopupEx*(id: ImGuiID): void {.importc: "igOpenPopupEx".}
proc igOpenPopupOnItemClick*(str_id: cstring = nil, mouse_button: ImGuiMouseButton = 1.ImGuiMouseButton): bool {.importc: "igOpenPopupOnItemClick".}
proc igPlotEx*(plot_type: ImGuiPlotType, label: cstring, values_getter: proc(data: pointer, idx: int32): float32, data: pointer, values_count: int32, values_offset: int32, overlay_text: cstring, scale_min: float32, scale_max: float32, frame_size: ImVec2): int32 {.importc: "igPlotEx".}
proc igPlotHistogram*(label: cstring, values: ptr float32, values_count: int32, values_offset: int32 = 0, overlay_text: cstring = nil, scale_min: float32 = high(float32), scale_max: float32 = high(float32), graph_size: ImVec2 = ImVec2(x: 0, y: 0), stride: int32 = sizeof(float32).int32): void {.importc: "igPlotHistogramFloatPtr".}
proc igPlotHistogram*(label: cstring, values_getter: proc(data: pointer, idx: int32): float32, data: pointer, values_count: int32, values_offset: int32 = 0, overlay_text: cstring = nil, scale_min: float32 = high(float32), scale_max: float32 = high(float32), graph_size: ImVec2 = ImVec2(x: 0, y: 0)): void {.importc: "igPlotHistogramFnPtr".}
proc igPlotLines*(label: cstring, values: ptr float32, values_count: int32, values_offset: int32 = 0, overlay_text: cstring = nil, scale_min: float32 = high(float32), scale_max: float32 = high(float32), graph_size: ImVec2 = ImVec2(x: 0, y: 0), stride: int32 = sizeof(float32).int32): void {.importc: "igPlotLinesFloatPtr".}
proc igPlotLines*(label: cstring, values_getter: proc(data: pointer, idx: int32): float32, data: pointer, values_count: int32, values_offset: int32 = 0, overlay_text: cstring = nil, scale_min: float32 = high(float32), scale_max: float32 = high(float32), graph_size: ImVec2 = ImVec2(x: 0, y: 0)): void {.importc: "igPlotLinesFnPtr".}
proc igPopAllowKeyboardFocus*(): void {.importc: "igPopAllowKeyboardFocus".}
proc igPopButtonRepeat*(): void {.importc: "igPopButtonRepeat".}
proc igPopClipRect*(): void {.importc: "igPopClipRect".}
proc igPopColumnsBackground*(): void {.importc: "igPopColumnsBackground".}
proc igPopFocusScope*(): void {.importc: "igPopFocusScope".}
proc igPopFont*(): void {.importc: "igPopFont".}
proc igPopID*(): void {.importc: "igPopID".}
proc igPopItemFlag*(): void {.importc: "igPopItemFlag".}
proc igPopItemWidth*(): void {.importc: "igPopItemWidth".}
proc igPopStyleColor*(count: int32 = 1): void {.importc: "igPopStyleColor".}
proc igPopStyleVar*(count: int32 = 1): void {.importc: "igPopStyleVar".}
proc igPopTextWrapPos*(): void {.importc: "igPopTextWrapPos".}
proc igProgressBar*(fraction: float32, size_arg: ImVec2 = ImVec2(x: -1, y: 0), overlay: cstring = nil): void {.importc: "igProgressBar".}
proc igPushAllowKeyboardFocus*(allow_keyboard_focus: bool): void {.importc: "igPushAllowKeyboardFocus".}
proc igPushButtonRepeat*(repeat: bool): void {.importc: "igPushButtonRepeat".}
proc igPushClipRect*(clip_rect_min: ImVec2, clip_rect_max: ImVec2, intersect_with_current_clip_rect: bool): void {.importc: "igPushClipRect".}
proc igPushColumnClipRect*(column_index: int32): void {.importc: "igPushColumnClipRect".}
proc igPushColumnsBackground*(): void {.importc: "igPushColumnsBackground".}
proc igPushFocusScope*(id: ImGuiID): void {.importc: "igPushFocusScope".}
proc igPushFont*(font: ptr ImFont): void {.importc: "igPushFont".}
proc igPushID*(str_id: cstring): void {.importc: "igPushIDStr".}
proc igPushID*(str_id_begin: cstring, str_id_end: cstring): void {.importc: "igPushIDStrStr".}
proc igPushID*(ptr_id: pointer): void {.importc: "igPushIDPtr".}
proc igPushID*(int_id: int32): void {.importc: "igPushIDInt".}
proc igPushItemFlag*(option: ImGuiItemFlags, enabled: bool): void {.importc: "igPushItemFlag".}
proc igPushItemWidth*(item_width: float32): void {.importc: "igPushItemWidth".}
proc igPushMultiItemsWidths*(components: int32, width_full: float32): void {.importc: "igPushMultiItemsWidths".}
proc igPushOverrideID*(id: ImGuiID): void {.importc: "igPushOverrideID".}
proc igPushStyleColor*(idx: ImGuiCol, col: uint32): void {.importc: "igPushStyleColorU32".}
proc igPushStyleColor*(idx: ImGuiCol, col: ImVec4): void {.importc: "igPushStyleColorVec4".}
proc igPushStyleVar*(idx: ImGuiStyleVar, val: float32): void {.importc: "igPushStyleVarFloat".}
proc igPushStyleVar*(idx: ImGuiStyleVar, val: ImVec2): void {.importc: "igPushStyleVarVec2".}
proc igPushTextWrapPos*(wrap_local_pos_x: float32 = 0.0f): void {.importc: "igPushTextWrapPos".}
proc igRadioButton*(label: cstring, active: bool): bool {.importc: "igRadioButtonBool".}
proc igRadioButton*(label: cstring, v: ptr int32, v_button: int32): bool {.importc: "igRadioButtonIntPtr".}
proc igRender*(): void {.importc: "igRender".}
proc igRenderArrow*(draw_list: ptr ImDrawList, pos: ImVec2, col: uint32, dir: ImGuiDir, scale: float32 = 1.0f): void {.importc: "igRenderArrow".}
proc igRenderArrowPointingAt*(draw_list: ptr ImDrawList, pos: ImVec2, half_sz: ImVec2, direction: ImGuiDir, col: uint32): void {.importc: "igRenderArrowPointingAt".}
proc igRenderBullet*(draw_list: ptr ImDrawList, pos: ImVec2, col: uint32): void {.importc: "igRenderBullet".}
proc igRenderCheckMark*(draw_list: ptr ImDrawList, pos: ImVec2, col: uint32, sz: float32): void {.importc: "igRenderCheckMark".}
proc igRenderColorRectWithAlphaCheckerboard*(draw_list: ptr ImDrawList, p_min: ImVec2, p_max: ImVec2, fill_col: uint32, grid_step: float32, grid_off: ImVec2, rounding: float32 = 0.0f, rounding_corners_flags: int32): void {.importc: "igRenderColorRectWithAlphaCheckerboard".}
proc igRenderFrame*(p_min: ImVec2, p_max: ImVec2, fill_col: uint32, border: bool = true, rounding: float32 = 0.0f): void {.importc: "igRenderFrame".}
proc igRenderFrameBorder*(p_min: ImVec2, p_max: ImVec2, rounding: float32 = 0.0f): void {.importc: "igRenderFrameBorder".}
proc igRenderMouseCursor*(draw_list: ptr ImDrawList, pos: ImVec2, scale: float32, mouse_cursor: ImGuiMouseCursor, col_fill: uint32, col_border: uint32, col_shadow: uint32): void {.importc: "igRenderMouseCursor".}
proc igRenderNavHighlight*(bb: ImRect, id: ImGuiID, flags: ImGuiNavHighlightFlags = ImGuiNavHighlightFlags.TypeDefault): void {.importc: "igRenderNavHighlight".}
proc igRenderRectFilledRangeH*(draw_list: ptr ImDrawList, rect: ImRect, col: uint32, x_start_norm: float32, x_end_norm: float32, rounding: float32): void {.importc: "igRenderRectFilledRangeH".}
proc igRenderText*(pos: ImVec2, text: cstring, text_end: cstring = nil, hide_text_after_hash: bool = true): void {.importc: "igRenderText".}
proc igRenderTextClipped*(pos_min: ImVec2, pos_max: ImVec2, text: cstring, text_end: cstring, text_size_if_known: ptr ImVec2, align: ImVec2 = ImVec2(x: 0, y: 0), clip_rect: ptr ImRect = nil): void {.importc: "igRenderTextClipped".}
proc igRenderTextClippedEx*(draw_list: ptr ImDrawList, pos_min: ImVec2, pos_max: ImVec2, text: cstring, text_end: cstring, text_size_if_known: ptr ImVec2, align: ImVec2 = ImVec2(x: 0, y: 0), clip_rect: ptr ImRect = nil): void {.importc: "igRenderTextClippedEx".}
proc igRenderTextEllipsis*(draw_list: ptr ImDrawList, pos_min: ImVec2, pos_max: ImVec2, clip_max_x: float32, ellipsis_max_x: float32, text: cstring, text_end: cstring, text_size_if_known: ptr ImVec2): void {.importc: "igRenderTextEllipsis".}
proc igRenderTextWrapped*(pos: ImVec2, text: cstring, text_end: cstring, wrap_width: float32): void {.importc: "igRenderTextWrapped".}
proc igResetMouseDragDelta*(button: ImGuiMouseButton = 0.ImGuiMouseButton): void {.importc: "igResetMouseDragDelta".}
proc igSameLine*(offset_from_start_x: float32 = 0.0f, spacing: float32 = -1.0f): void {.importc: "igSameLine".}
proc igSaveIniSettingsToDisk*(ini_filename: cstring): void {.importc: "igSaveIniSettingsToDisk".}
proc igSaveIniSettingsToMemory*(out_ini_size: ptr uint = nil): cstring {.importc: "igSaveIniSettingsToMemory".}
proc igScrollToBringRectIntoViewNonUDT*(pOut: ptr ImVec2, window: ptr ImGuiWindow, item_rect: ImRect): void {.importc: "igScrollToBringRectIntoView".}
proc igScrollbar*(axis: ImGuiAxis): void {.importc: "igScrollbar".}
proc igScrollbarEx*(bb: ImRect, id: ImGuiID, axis: ImGuiAxis, p_scroll_v: ptr float32, avail_v: float32, contents_v: float32, rounding_corners: ImDrawCornerFlags): bool {.importc: "igScrollbarEx".}
proc igSelectable*(label: cstring, selected: bool = false, flags: ImGuiSelectableFlags = 0.ImGuiSelectableFlags, size: ImVec2 = ImVec2(x: 0, y: 0)): bool {.importc: "igSelectableBool".}
proc igSelectable*(label: cstring, p_selected: ptr bool, flags: ImGuiSelectableFlags = 0.ImGuiSelectableFlags, size: ImVec2 = ImVec2(x: 0, y: 0)): bool {.importc: "igSelectableBoolPtr".}
proc igSeparator*(): void {.importc: "igSeparator".}
proc igSeparatorEx*(flags: ImGuiSeparatorFlags): void {.importc: "igSeparatorEx".}
proc igSetActiveID*(id: ImGuiID, window: ptr ImGuiWindow): void {.importc: "igSetActiveID".}
proc igSetAllocatorFunctions*(alloc_func: proc(sz: uint, user_data: pointer): pointer, free_func: proc(`ptr`: pointer, user_data: pointer): void, user_data: pointer = nil): void {.importc: "igSetAllocatorFunctions".}
proc igSetClipboardText*(text: cstring): void {.importc: "igSetClipboardText".}
proc igSetColorEditOptions*(flags: ImGuiColorEditFlags): void {.importc: "igSetColorEditOptions".}
proc igSetColumnOffset*(column_index: int32, offset_x: float32): void {.importc: "igSetColumnOffset".}
proc igSetColumnWidth*(column_index: int32, width: float32): void {.importc: "igSetColumnWidth".}
proc igSetCurrentContext*(ctx: ptr ImGuiContext): void {.importc: "igSetCurrentContext".}
proc igSetCurrentFont*(font: ptr ImFont): void {.importc: "igSetCurrentFont".}
proc igSetCursorPos*(local_pos: ImVec2): void {.importc: "igSetCursorPos".}
proc igSetCursorPosX*(local_x: float32): void {.importc: "igSetCursorPosX".}
proc igSetCursorPosY*(local_y: float32): void {.importc: "igSetCursorPosY".}
proc igSetCursorScreenPos*(pos: ImVec2): void {.importc: "igSetCursorScreenPos".}
proc igSetDragDropPayload*(`type`: cstring, data: pointer, sz: uint, cond: ImGuiCond = 0.ImGuiCond): bool {.importc: "igSetDragDropPayload".}
proc igSetFocusID*(id: ImGuiID, window: ptr ImGuiWindow): void {.importc: "igSetFocusID".}
proc igSetHoveredID*(id: ImGuiID): void {.importc: "igSetHoveredID".}
proc igSetItemAllowOverlap*(): void {.importc: "igSetItemAllowOverlap".}
proc igSetItemDefaultFocus*(): void {.importc: "igSetItemDefaultFocus".}
proc igSetKeyboardFocusHere*(offset: int32 = 0): void {.importc: "igSetKeyboardFocusHere".}
proc igSetMouseCursor*(cursor_type: ImGuiMouseCursor): void {.importc: "igSetMouseCursor".}
proc igSetNavID*(id: ImGuiID, nav_layer: int32, focus_scope_id: ImGuiID): void {.importc: "igSetNavID".}
proc igSetNavIDWithRectRel*(id: ImGuiID, nav_layer: int32, focus_scope_id: ImGuiID, rect_rel: ImRect): void {.importc: "igSetNavIDWithRectRel".}
proc igSetNextItemOpen*(is_open: bool, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetNextItemOpen".}
proc igSetNextItemWidth*(item_width: float32): void {.importc: "igSetNextItemWidth".}
proc igSetNextWindowBgAlpha*(alpha: float32): void {.importc: "igSetNextWindowBgAlpha".}
proc igSetNextWindowCollapsed*(collapsed: bool, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetNextWindowCollapsed".}
proc igSetNextWindowContentSize*(size: ImVec2): void {.importc: "igSetNextWindowContentSize".}
proc igSetNextWindowFocus*(): void {.importc: "igSetNextWindowFocus".}
proc igSetNextWindowPos*(pos: ImVec2, cond: ImGuiCond = 0.ImGuiCond, pivot: ImVec2 = ImVec2(x: 0, y: 0)): void {.importc: "igSetNextWindowPos".}
proc igSetNextWindowSize*(size: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetNextWindowSize".}
proc igSetNextWindowSizeConstraints*(size_min: ImVec2, size_max: ImVec2, custom_callback: ImGuiSizeCallback = nil, custom_callback_data: pointer = nil): void {.importc: "igSetNextWindowSizeConstraints".}
proc igSetScrollFromPosX*(local_x: float32, center_x_ratio: float32 = 0.5f): void {.importc: "igSetScrollFromPosXFloat".}
proc igSetScrollFromPosX*(window: ptr ImGuiWindow, local_x: float32, center_x_ratio: float32 = 0.5f): void {.importc: "igSetScrollFromPosXWindowPtr".}
proc igSetScrollFromPosY*(local_y: float32, center_y_ratio: float32 = 0.5f): void {.importc: "igSetScrollFromPosYFloat".}
proc igSetScrollFromPosY*(window: ptr ImGuiWindow, local_y: float32, center_y_ratio: float32 = 0.5f): void {.importc: "igSetScrollFromPosYWindowPtr".}
proc igSetScrollHereX*(center_x_ratio: float32 = 0.5f): void {.importc: "igSetScrollHereX".}
proc igSetScrollHereY*(center_y_ratio: float32 = 0.5f): void {.importc: "igSetScrollHereY".}
proc igSetScrollX*(scroll_x: float32): void {.importc: "igSetScrollXFloat".}
proc igSetScrollX*(window: ptr ImGuiWindow, new_scroll_x: float32): void {.importc: "igSetScrollXWindowPtr".}
proc igSetScrollY*(scroll_y: float32): void {.importc: "igSetScrollYFloat".}
proc igSetScrollY*(window: ptr ImGuiWindow, new_scroll_y: float32): void {.importc: "igSetScrollYWindowPtr".}
proc igSetStateStorage*(storage: ptr ImGuiStorage): void {.importc: "igSetStateStorage".}
proc igSetTabItemClosed*(tab_or_docked_window_label: cstring): void {.importc: "igSetTabItemClosed".}
proc igSetTooltip*(fmt: cstring): void {.importc: "igSetTooltip", varargs.}
proc igSetTooltipV*(fmt: cstring): void {.importc: "igSetTooltipV", varargs.}
proc igSetWindowCollapsed*(collapsed: bool, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowCollapsedBool".}
proc igSetWindowCollapsed*(name: cstring, collapsed: bool, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowCollapsedStr".}
proc igSetWindowCollapsed*(window: ptr ImGuiWindow, collapsed: bool, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowCollapsedWindowPtr".}
proc igSetWindowFocus*(): void {.importc: "igSetWindowFocusNil".}
proc igSetWindowFocus*(name: cstring): void {.importc: "igSetWindowFocusStr".}
proc igSetWindowFontScale*(scale: float32): void {.importc: "igSetWindowFontScale".}
proc igSetWindowPos*(pos: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowPosVec2".}
proc igSetWindowPos*(name: cstring, pos: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowPosStr".}
proc igSetWindowPos*(window: ptr ImGuiWindow, pos: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowPosWindowPtr".}
proc igSetWindowSize*(size: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowSizeVec2".}
proc igSetWindowSize*(name: cstring, size: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowSizeStr".}
proc igSetWindowSize*(window: ptr ImGuiWindow, size: ImVec2, cond: ImGuiCond = 0.ImGuiCond): void {.importc: "igSetWindowSizeWindowPtr".}
proc igShadeVertsLinearColorGradientKeepAlpha*(draw_list: ptr ImDrawList, vert_start_idx: int32, vert_end_idx: int32, gradient_p0: ImVec2, gradient_p1: ImVec2, col0: uint32, col1: uint32): void {.importc: "igShadeVertsLinearColorGradientKeepAlpha".}
proc igShadeVertsLinearUV*(draw_list: ptr ImDrawList, vert_start_idx: int32, vert_end_idx: int32, a: ImVec2, b: ImVec2, uv_a: ImVec2, uv_b: ImVec2, clamp: bool): void {.importc: "igShadeVertsLinearUV".}
proc igShowAboutWindow*(p_open: ptr bool = nil): void {.importc: "igShowAboutWindow".}
proc igShowDemoWindow*(p_open: ptr bool = nil): void {.importc: "igShowDemoWindow".}
proc igShowFontSelector*(label: cstring): void {.importc: "igShowFontSelector".}
proc igShowMetricsWindow*(p_open: ptr bool = nil): void {.importc: "igShowMetricsWindow".}
proc igShowStyleEditor*(`ref`: ptr ImGuiStyle = nil): void {.importc: "igShowStyleEditor".}
proc igShowStyleSelector*(label: cstring): bool {.importc: "igShowStyleSelector".}
proc igShowUserGuide*(): void {.importc: "igShowUserGuide".}
proc igShrinkWidths*(items: ptr ImGuiShrinkWidthItem, count: int32, width_excess: float32): void {.importc: "igShrinkWidths".}
proc igShutdown*(context: ptr ImGuiContext): void {.importc: "igShutdown".}
proc igSliderAngle*(label: cstring, v_rad: ptr float32, v_degrees_min: float32 = -360.0f, v_degrees_max: float32 = +360.0f, format: cstring = "%.0f deg"): bool {.importc: "igSliderAngle".}
proc igSliderBehavior*(bb: ImRect, id: ImGuiID, data_type: ImGuiDataType, p_v: pointer, p_min: pointer, p_max: pointer, format: cstring, power: float32, flags: ImGuiSliderFlags, out_grab_bb: ptr ImRect): bool {.importc: "igSliderBehavior".}
proc igSliderFloat*(label: cstring, v: ptr float32, v_min: float32, v_max: float32, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igSliderFloat".}
proc igSliderFloat2*(label: cstring, v: var array[2, float32], v_min: float32, v_max: float32, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igSliderFloat2".}
proc igSliderFloat3*(label: cstring, v: var array[3, float32], v_min: float32, v_max: float32, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igSliderFloat3".}
proc igSliderFloat4*(label: cstring, v: var array[4, float32], v_min: float32, v_max: float32, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igSliderFloat4".}
proc igSliderInt*(label: cstring, v: ptr int32, v_min: int32, v_max: int32, format: cstring = "%d"): bool {.importc: "igSliderInt".}
proc igSliderInt2*(label: cstring, v: var array[2, int32], v_min: int32, v_max: int32, format: cstring = "%d"): bool {.importc: "igSliderInt2".}
proc igSliderInt3*(label: cstring, v: var array[3, int32], v_min: int32, v_max: int32, format: cstring = "%d"): bool {.importc: "igSliderInt3".}
proc igSliderInt4*(label: cstring, v: var array[4, int32], v_min: int32, v_max: int32, format: cstring = "%d"): bool {.importc: "igSliderInt4".}
proc igSliderScalar*(label: cstring, data_type: ImGuiDataType, p_data: pointer, p_min: pointer, p_max: pointer, format: cstring = nil, power: float32 = 1.0f): bool {.importc: "igSliderScalar".}
proc igSliderScalarN*(label: cstring, data_type: ImGuiDataType, p_data: pointer, components: int32, p_min: pointer, p_max: pointer, format: cstring = nil, power: float32 = 1.0f): bool {.importc: "igSliderScalarN".}
proc igSmallButton*(label: cstring): bool {.importc: "igSmallButton".}
proc igSpacing*(): void {.importc: "igSpacing".}
proc igSplitterBehavior*(bb: ImRect, id: ImGuiID, axis: ImGuiAxis, size1: ptr float32, size2: ptr float32, min_size1: float32, min_size2: float32, hover_extend: float32 = 0.0f, hover_visibility_delay: float32 = 0.0f): bool {.importc: "igSplitterBehavior".}
proc igStartMouseMovingWindow*(window: ptr ImGuiWindow): void {.importc: "igStartMouseMovingWindow".}
proc igStyleColorsClassic*(dst: ptr ImGuiStyle = nil): void {.importc: "igStyleColorsClassic".}
proc igStyleColorsDark*(dst: ptr ImGuiStyle = nil): void {.importc: "igStyleColorsDark".}
proc igStyleColorsLight*(dst: ptr ImGuiStyle = nil): void {.importc: "igStyleColorsLight".}
proc igTabBarCloseTab*(tab_bar: ptr ImGuiTabBar, tab: ptr ImGuiTabItem): void {.importc: "igTabBarCloseTab".}
proc igTabBarFindTabByID*(tab_bar: ptr ImGuiTabBar, tab_id: ImGuiID): ptr ImGuiTabItem {.importc: "igTabBarFindTabByID".}
proc igTabBarQueueChangeTabOrder*(tab_bar: ptr ImGuiTabBar, tab: ptr ImGuiTabItem, dir: int32): void {.importc: "igTabBarQueueChangeTabOrder".}
proc igTabBarRemoveTab*(tab_bar: ptr ImGuiTabBar, tab_id: ImGuiID): void {.importc: "igTabBarRemoveTab".}
proc igTabItemBackground*(draw_list: ptr ImDrawList, bb: ImRect, flags: ImGuiTabItemFlags, col: uint32): void {.importc: "igTabItemBackground".}
proc igTabItemCalcSizeNonUDT*(pOut: ptr ImVec2, label: cstring, has_close_button: bool): void {.importc: "igTabItemCalcSize".}
proc igTabItemEx*(tab_bar: ptr ImGuiTabBar, label: cstring, p_open: ptr bool, flags: ImGuiTabItemFlags): bool {.importc: "igTabItemEx".}
proc igTabItemLabelAndCloseButton*(draw_list: ptr ImDrawList, bb: ImRect, flags: ImGuiTabItemFlags, frame_padding: ImVec2, label: cstring, tab_id: ImGuiID, close_button_id: ImGuiID): bool {.importc: "igTabItemLabelAndCloseButton".}
proc igTempInputIsActive*(id: ImGuiID): bool {.importc: "igTempInputIsActive".}
proc igTempInputScalar*(bb: ImRect, id: ImGuiID, label: cstring, data_type: ImGuiDataType, p_data: pointer, format: cstring): bool {.importc: "igTempInputScalar".}
proc igTempInputText*(bb: ImRect, id: ImGuiID, label: cstring, buf: cstring, buf_size: int32, flags: ImGuiInputTextFlags): bool {.importc: "igTempInputText".}
proc igText*(fmt: cstring): void {.importc: "igText", varargs.}
proc igTextColored*(col: ImVec4, fmt: cstring): void {.importc: "igTextColored", varargs.}
proc igTextColoredV*(col: ImVec4, fmt: cstring): void {.importc: "igTextColoredV", varargs.}
proc igTextDisabled*(fmt: cstring): void {.importc: "igTextDisabled", varargs.}
proc igTextDisabledV*(fmt: cstring): void {.importc: "igTextDisabledV", varargs.}
proc igTextEx*(text: cstring, text_end: cstring = nil, flags: ImGuiTextFlags = 0.ImGuiTextFlags): void {.importc: "igTextEx".}
proc igTextUnformatted*(text: cstring, text_end: cstring = nil): void {.importc: "igTextUnformatted".}
proc igTextV*(fmt: cstring): void {.importc: "igTextV", varargs.}
proc igTextWrapped*(fmt: cstring): void {.importc: "igTextWrapped", varargs.}
proc igTextWrappedV*(fmt: cstring): void {.importc: "igTextWrappedV", varargs.}
proc igTreeNode*(label: cstring): bool {.importc: "igTreeNodeStr".}
proc igTreeNode*(str_id: cstring, fmt: cstring): bool {.importc: "igTreeNodeStrStr", varargs.}
proc igTreeNode*(ptr_id: pointer, fmt: cstring): bool {.importc: "igTreeNodePtr", varargs.}
proc igTreeNodeBehavior*(id: ImGuiID, flags: ImGuiTreeNodeFlags, label: cstring, label_end: cstring = nil): bool {.importc: "igTreeNodeBehavior".}
proc igTreeNodeBehaviorIsOpen*(id: ImGuiID, flags: ImGuiTreeNodeFlags = 0.ImGuiTreeNodeFlags): bool {.importc: "igTreeNodeBehaviorIsOpen".}
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
proc igTreePushOverrideID*(id: ImGuiID): void {.importc: "igTreePushOverrideID".}
proc igUnindent*(indent_w: float32 = 0.0f): void {.importc: "igUnindent".}
proc igUpdateHoveredWindowAndCaptureFlags*(): void {.importc: "igUpdateHoveredWindowAndCaptureFlags".}
proc igUpdateMouseMovingWindowEndFrame*(): void {.importc: "igUpdateMouseMovingWindowEndFrame".}
proc igUpdateMouseMovingWindowNewFrame*(): void {.importc: "igUpdateMouseMovingWindowNewFrame".}
proc igUpdateWindowParentAndRootLinks*(window: ptr ImGuiWindow, flags: ImGuiWindowFlags, parent_window: ptr ImGuiWindow): void {.importc: "igUpdateWindowParentAndRootLinks".}
proc igVSliderFloat*(label: cstring, size: ImVec2, v: ptr float32, v_min: float32, v_max: float32, format: cstring = "%.3f", power: float32 = 1.0f): bool {.importc: "igVSliderFloat".}
proc igVSliderInt*(label: cstring, size: ImVec2, v: ptr int32, v_min: int32, v_max: int32, format: cstring = "%d"): bool {.importc: "igVSliderInt".}
proc igVSliderScalar*(label: cstring, size: ImVec2, data_type: ImGuiDataType, p_data: pointer, p_min: pointer, p_max: pointer, format: cstring = nil, power: float32 = 1.0f): bool {.importc: "igVSliderScalar".}
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
