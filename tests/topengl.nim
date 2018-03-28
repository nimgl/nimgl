# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import 
  nimgl/[glfw, math, opengl]

proc keyProc(window: Window, key: Key, scancode: cint, action: KeyAction, mods: KeyMod): void {.cdecl.} =
  if key == keyESCAPE and action == kaPress:
    window.setWindowShouldClose(true)
  if key == keySpace:
    glPolygonMode(GL_FRONT_AND_BACK, if action != kaRelease: GL_LINE else: GL_FILL)

proc statusShader(shader: uint32) =
  var status: int32
  glGetShaderiv(shader, GL_COMPILE_STATUS, status.addr);
  if status != GL_TRUE.ord:
    var
      log_length: int32
      message: cstring
    glGetShaderInfoLog(shader, 1024, log_length.addr, message);
    echo message

proc main =
  # GLFW
  assert glfw.init()

  windowHint whContextVersionMajor, 4
  windowHint whContextVersionMinor, 1
  windowHint whOpenglForwardCompat, glfwTRUE
  windowHint whOpenglProfile      , glfwOpenglCoreProfile
  windowHint whResizable          , glfwFalse

  var w: Window = createWindow(800, 600)
  assert w != nil

  w.setKeyCallback(keyProc)
  w.makeContextCurrent

  # Glew / Opengl
  assert opengl.init() == GLEW_OK

  glEnable(GL_BLEND)
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

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

  glGenBuffers(1, mesh.vbo.addr)
  glGenBuffers(1, mesh.ebo.addr)
  glGenVertexArrays(1, mesh.vao.addr)

  glBindVertexArray(mesh.vao)

  glBindBuffer(GL_ARRAY_BUFFER, mesh.vbo)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, mesh.ebo)

  glBufferData(GL_ARRAY_BUFFER, cint(cfloat.sizeof * vert.len), vert[0].addr, GL_STATIC_DRAW)
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, cint(cuint.sizeof * ind.len), ind[0].addr, GL_STATIC_DRAW)

  glEnableVertexAttribArray(0)
  glVertexAttribPointer(0'u32, 2, GL_FLOAT, false, cfloat.sizeof * 2, nil)

  vertex = glCreateShader(GL_VERTEX_SHADER)
  var vsrc: cstring = """
#version 330 core
layout (location = 0) in vec2 aPos;

uniform mat4 uMVP;

void main() {
  gl_Position = vec4(aPos, 0.0, 1.0) * uMVP;
}
  """
  glShaderSource(vertex, 1'i32, vsrc.addr, nil)
  glCompileShader(vertex)
  statusShader(vertex)

  fragment = glCreateShader(GL_FRAGMENT_SHADER)
  var fsrc: cstring = """
#version 330 core
out vec4 FragColor;

uniform vec3 uColor;

void main() {
  FragColor = vec4(uColor, 1.0f);
}
  """
  glShaderSource(fragment, 1, fsrc.addr, nil)
  glCompileShader(fragment)
  statusShader(fragment)

  program = glCreateProgram()
  glAttachShader(program, vertex)
  glAttachShader(program, fragment)
  glLinkProgram(program)

  var
    log_length: int32
    message: cstring
    pLinked: int32
  glGetProgramiv(program, GL_LINK_STATUS, pLinked.addr);
  if pLinked != GL_TRUE.ord:
    glGetProgramInfoLog(program, 1024, log_length.addr, message);
    echo message

  let
    uColor = glGetUniformLocation(program, "uColor")
    uMVP   = glGetUniformLocation(program, "uMVP")
  var
    bg    = vec(33f, 33f, 33f).rgb
    color = vec(50f, 205f, 50f).rgb
    mvp   = ortho(-2f, 2f, -1.5f, 1.5f, -1f, 1f)

  while not w.windowShouldClose:
    glClearColor(bg.r, bg.g, bg.b, 1f)
    glClear(GL_COLOR_BUFFER_BIT)

    glUseProgram(program)
    glUniform3fv(uColor, 1, color.vPtr)
    glUniformMatrix4fv(uMVP, 1, false, mvp.vPtr)

    glBindVertexArray(mesh.vao)
    glDrawElements(GL_TRIANGLES, ind.len.cint, GL_UNSIGNED_INT, nil)

    w.swapBuffers
    glfw.pollEvents()

  w.destroyWindow

  glfw.terminate()

  glDeleteVertexArrays(1, mesh.vao.addr)
  glDeleteBuffers(1, mesh.vbo.addr)
  glDeleteBuffers(1, mesh.ebo.addr)

main()
