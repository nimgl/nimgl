# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import
  nimgl/[glfw, math, opengl], os

if os.getEnv("CI") != "":
  quit()

proc keyProc(window: Window, key: Key, scancode: cint, action: KeyAction, mods: KeyMod): void {.cdecl.} =
  if key == keyESCAPE and action == kaPress:
    window.setWindowShouldClose(true)
  if key == keySpace:
    polygonMode(GL_FRONT_AND_BACK, if action != kaRelease: GL_LINE else: GL_FILL)

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

  var w: Window = createWindow(800, 600)
  assert w != nil

  w.setKeyCallback(keyProc)
  w.makeContextCurrent

  # Glew / Opengl
  assert opengl.init() == GLEW_OK

  enable(GL_BLEND)
  blendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

  var
    mesh: tuple[vbo, vao, ebo: uint32]
    vertex  : uint32
    fragment: uint32
    program : uint32

  var vert = @[
     0.3f,  0.3f,
     0.3f, -0.3f,
    -0.3f, -0.3f,
    -0.3f,  0.3f
  ]

  var ind = @[
    0'u32, 1'u32, 3'u32,
    1'u32, 2'u32, 3'u32
  ]

  genBuffers(1, mesh.vbo.addr)
  genBuffers(1, mesh.ebo.addr)
  genVertexArrays(1, mesh.vao.addr)

  bindVertexArray(mesh.vao)

  bindBuffer(GL_ARRAY_BUFFER, mesh.vbo)
  bindBuffer(GL_ELEMENT_ARRAY_BUFFER, mesh.ebo)

  bufferData(GL_ARRAY_BUFFER, cint(cfloat.sizeof * vert.len), vert[0].addr, GL_STATIC_DRAW)
  bufferData(GL_ELEMENT_ARRAY_BUFFER, cint(cuint.sizeof * ind.len), ind[0].addr, GL_STATIC_DRAW)

  enableVertexAttribArray(0)
  vertexAttribPointer(0'u32, 2, GL_FLOAT, false, cfloat.sizeof * 2, nil)

  vertex = createShader(GL_VERTEX_SHADER)
  var vsrc: cstring = """
#version 330 core
layout (location = 0) in vec2 aPos;

uniform mat4 uMVP;

void main() {
  gl_Position = vec4(aPos, 0.0, 1.0) * uMVP;
}
  """
  shaderSource(vertex, 1'i32, vsrc.addr, nil)
  compileShader(vertex)
  statusShader(vertex)

  fragment = createShader(GL_FRAGMENT_SHADER)
  var fsrc: cstring = """
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

  var
    log_length: int32
    message = newSeq[char](1024)
    pLinked: int32
  getProgramiv(program, GL_LINK_STATUS, pLinked.addr);
  if pLinked != GL_TRUE.ord:
    getProgramInfoLog(program, 1024, log_length.addr, message[0].addr);
    echo message

  let
    uColor = getUniformLocation(program, "uColor")
    uMVP   = getUniformLocation(program, "uMVP")
  var
    bg    = vec(33f, 33f, 33f).rgb
    color = vec(50f, 205f, 50f).rgb
    mvp   = ortho(-2f, 2f, -1.5f, 1.5f, -1f, 1f)

  while not w.windowShouldClose:
    clearColor(bg.r, bg.g, bg.b, 1f)
    clear(GL_COLOR_BUFFER_BIT)

    useProgram(program)
    uniform3fv(uColor, 1, color.vPtr)
    uniformMatrix4fv(uMVP, 1, false, mvp.vPtr)

    bindVertexArray(mesh.vao)
    drawElements(GL_TRIANGLES, ind.len.cint, GL_UNSIGNED_INT, nil)

    w.swapBuffers
    glfw.pollEvents()

  w.destroyWindow

  glfw.terminate()

  deleteVertexArrays(1, mesh.vao.addr)
  deleteBuffers(1, mesh.vbo.addr)
  deleteBuffers(1, mesh.ebo.addr)

main()
