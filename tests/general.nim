# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

#[
  This is just a testing file, as stated in the README on this folder still
  need to make some useful tests to prevent bugs and catch breaking changes.
]#

import 
  nimgl/[imgui, glfw, math, opengl, imgui/implGL]

proc keyProc(window: Window, key: Key, scancode: cint,
            action: KeyAction, mods: KeyMod): void {.cdecl.} =
  if key == keyESCAPE and action == kaPress:
    window.setWindowShouldClose(true)
  if key == keySpace:
    polygonMode(GL_FRONT_AND_BACK,
                  if action != kaRelease: GL_LINE else: GL_FILL)

proc statusShader(shader: uint32) =
  var status: int32
  getShaderiv(shader, GL_COMPILE_STATUS, status.addr);
  if status != GL_TRUE.ord:
    var
      log_length: int32
      message = newSeq[char](1024)
    getShaderInfoLog(shader, 1024, log_length.addr, message[0].addr);
    echo message

proc main =
  # GLFW
  assert glfw.init()

  windowHint whContextVersionMajor, 4
  windowHint whContextVersionMinor, 1
  windowHint whOpenglForwardCompat, GLFW_TRUE
  windowHint whOpenglProfile      , GLFW_OPENGL_CORE_PROFILE
  windowHint whResizable          , GLFW_FALSE

  var w: Window = createWindow(1280, 720)
  assert w != nil

  w.setKeyCallback(keyProc)
  w.makeContextCurrent

  # Glew / Opengl
  assert opengl.init() == GLEW_OK

  enable(GL_BLEND)
  blendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

  var
    vertices: seq[cfloat]
    indices : seq[cuint]
    vbo     : uint32
    vao     : uint32
    ebo     : uint32
    vertex  : uint32
    fragment: uint32
    program : uint32
    vsrc    : cstring
    fsrc    : cstring

  vertices = @[
     0.5f,  0.5f, 0.0f,
     0.5f, -0.5f, 0.0f,
    -0.5f, -0.5f, 0.0f,
    -0.5f,  0.5f, 0.0f
  ]

  indices = @[
    0'u32, 1'u32, 3'u32,
    1'u32, 2'u32, 3'u32
  ]

  genBuffers(1, vbo.addr)
  genBuffers(1, ebo.addr)
  genVertexArrays(1, vao.addr)

  bindVertexArray(vao)

  bindBuffer(GL_ARRAY_BUFFER, vbo)
  bindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo)

  bufferData(GL_ARRAY_BUFFER, cint(cfloat.sizeof * vertices.len),
            vertices[0].addr, GL_STATIC_DRAW)
  bufferData(GL_ELEMENT_ARRAY_BUFFER, cint(cuint.sizeof * indices.len),
              indices[0].addr, GL_STATIC_DRAW)

  enableVertexAttribArray(0)
  vertexAttribPointer(0'u32, 3, GL_FLOAT, false, cfloat.sizeof * 3, nil)

  vertex = createShader(GL_VERTEX_SHADER)
  vsrc = """
#version 330 core
layout (location = 0) in vec3 aPos;

uniform mat4 uMVP;

void main() {
  gl_Position = vec4(aPos, 1.0) * uMVP;
}
  """
  shaderSource(vertex, 1, vsrc.addr, nil)
  compileShader(vertex)
  statusShader(vertex)

  fragment = createShader(GL_FRAGMENT_SHADER)
  fsrc = """
#version 330 core
out vec4 FragColor;

uniform vec3 uColor;

void main() {
  FragColor = vec4(uColor, 1.0f);
}
  """
  shaderSource(fragment, 1, fsrc.addr, nil)
  compileShader(fragment)
  statusShader(fragment)

  program = createProgram()
  attachShader(program, vertex)
  attachShader(program, fragment)
  linkProgram(program)

  var pLinked: int32
  getProgramiv(program, GL_LINK_STATUS, pLinked.addr);
  if pLinked != GL_TRUE.ord:
    var
      log_length: int32
      message = newSeq[char](1024)
    getProgramInfoLog(program, 1024, log_length.addr, message[0].addr);
    echo message

  let
    uColor = getUniformLocation(program, "uColor")
    uMVP   = getUniformLocation(program, "uMVP")
  var
    bg    = vec(33f, 33f, 33f).rgb
    color = vec(102f, 187f, 106f).rgb
    mvp   = ortho(-8f, 8f, -4.5f, 4.5f, -1f, 1f)

  # Imgui

  var
    ctx = createContext()
    io  = getIO()

  assert implGL.init(w, false, 330) == true
  styleColorsDark()

  polygonMode(GL_FRONT_AND_BACK, GL_FILL)
  while not w.windowShouldClose:
    implGL.newFrame()

    clearColor(bg.r, bg.g, bg.b, 1f)
    clear(GL_COLOR_BUFFER_BIT)

    useProgram(program)
    uniform3fv(uColor, 1, color.vPtr)
    uniformMatrix4fv(uMVP, 1, false, mvp.vPtr)

    bindVertexArray(vao)
    drawElements(GL_TRIANGLES, indices.len.cint, GL_UNSIGNED_INT, nil)

    imgui.render()
    implGL.renderData()

    w.swapBuffers
    glfw.pollEvents()

  w.destroyWindow

  # +Imgui
  implGL.shutdown()
  ctx.destroyContext
  # -Imgui

  glfw.terminate()

  deleteVertexArrays(1, vao.addr)
  deleteBuffers(1, vbo.addr)
  deleteBuffers(1, ebo.addr)

main()
