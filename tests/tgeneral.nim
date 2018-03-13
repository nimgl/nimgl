# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import 
  nimgl/glfw,
  nimgl/math,
  nimgl/glew

type
  KeysArray = array[-1 .. ord(Key.keyLast), bool]

var
  keys: KeysArray

proc keyProc(window: Window, key: Key, scancode: cint, action: KeyAction, mods: KeyMod): void {.cdecl.} =
  keys[key.ord] = action != kaRelease
  if key == keyESCAPE and action == kaPress:
    window.setWindowShouldClose(true)

converter toString(chars: seq[cchar]): string =
  result = ""
  for c in chars:
    if c == '\0': continue
    result.add c

proc statusShader(shader: glUint) =
  var status: glInt
  glGetShaderiv(shader, GL_COMPILE_STATUS, status.addr);
  if status != GL_TRUE.ord:
    var
      log_length: glSizei
      message = newSeq[glChar](1024)
    glGetShaderInfoLog(shader, 1024, log_length.addr, message[0].addr);
    echo toString(message)
  
proc main =
  assert glfw.init()

  windowHint(whContextVersionMajor, 4);
  windowHint(whContextVersionMinor, 1);
  windowHint(whOpenglForwardCompat, glfwTRUE);
  windowHint(whOpenglProfile      , glfwOpenglCoreProfile);
  windowHint(whResizable          , glfwFalse);
  windowHint(whDecorated          , glfwTrue);
  windowHint(whRefreshRate        , glfwDontCare);

  var w: Window = createWindow(1280, 720, "NimGL")
  assert w != nil

  w.setKeyCallback(keyProc)
  w.makeContextCurrent

  assert glew.init() == GLEW_OK

  glEnable(GL_BLEND)
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)

  var
    vertices: seq[cfloat]
    indices: seq[cuint]
    vbo: glUint
    vao: glUint
    ebo: glUint

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

  glGenBuffers(1, vbo.addr)
  glGenBuffers(1, ebo.addr)
  glGenVertexArrays(1, vao.addr)

  glBindVertexArray(vao)

  glBindBuffer(GL_ARRAY_BUFFER, vbo)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo)

  glBufferData(GL_ARRAY_BUFFER, cint(cfloat.sizeof * vertices.len), vertices[0].addr, GL_STATIC_DRAW)
  glBufferData(GL_ELEMENT_ARRAY_BUFFER, cint(cuint.sizeof * indices.len), indices[0].addr, GL_STATIC_DRAW)

  glEnableVertexAttribArray(0)
  glVertexAttribPointer(0'u32, 3, GL_FLOAT, false, cfloat.sizeof * 3, nil)

  var
    vertex: glUint
    fragment: glUint
    program: glUint
    vsrc: cstring
    fsrc: cstring

  vertex = glCreateShader(GL_VERTEX_SHADER)
  vsrc = """
#version 330 core
layout (location = 0) in vec3 aPos;
void main() {
  gl_Position = vec4(aPos, 1.0);
}
  """
  glShaderSource(vertex, 1, vsrc.addr, nil)
  glCompileShader(vertex)
  statusShader(vertex)

  fragment = glCreateShader(GL_FRAGMENT_SHADER)
  fsrc = """
#version 330 core
out vec4 FragColor;

void main() {
  FragColor = vec4(0.50f, 0.78f, 0.51f, 1.0f);
}
  """
  glShaderSource(fragment, 1, fsrc.addr, nil)
  glCompileShader(fragment)
  statusShader(fragment)

  program = glCreateProgram()
  glAttachShader(program, vertex)
  glAttachShader(program, fragment)
  glLinkProgram(program)

  var programLinked: glInt
  glGetProgramiv(program, GL_LINK_STATUS, programLinked.addr);
  if program_linked != GL_TRUE.ord:
    var
      log_length: glSizei
      message = newSeq[glChar](1024)
    glGetProgramInfoLog(program, 1024, log_length.addr, message[0].addr);
    echo toString(message)

  while not w.windowShouldClose:
    glPolygonMode(GL_FRONT_AND_BACK, if keys[keySpace.ord]: GL_LINE else: GL_FILL)

    glClearColor(0.13, 0.13, 0.13, 1)
    glClear(GL_COLOR_BUFFER_BIT)

    glUseProgram(program)

    glBindVertexArray(vao)
    glDrawElements(GL_TRIANGLES, indices.len.cint, GL_UNSIGNED_INT, nil)

    w.swapBuffers
    glfw.pollEvents()

  w.destroyWindow
  glfw.terminate()

  glDeleteVertexArrays(1, vao.addr)
  glDeleteBuffers(1, vbo.addr)
  glDeleteBuffers(1, ebo.addr)

main()