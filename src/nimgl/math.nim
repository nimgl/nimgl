# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## Math
## ====
## `return <../>`_.  
##
## A Math library that helps with linear algebra. It is built on the idea
## to directly interact with opengl.
##
## This module exposes the std math's module and is packed together with
## useful functions to help interface with opengl. We use the std math's module
## to avoid rewriting what has already been writen.
##
## All of this library is using int32, uint32 and float32 to be able to interact
## with C. please don't forget to put 'i32, 'ui32 and 'f32 we have some converters
## but don't rely on them.
##
## Also everything in here is in Radians so use the radToDeg and degToRad to
## convert back and forth
##
## This library is made for graphics engines so if you want to do more advanced
## linear algebra stuff please use `Neo <https://github.com/unicredit/neo>`_.

import
  pure/math

export
  math

## Vectors

## TODO: Make Vec and Mat printable with echo instead of print

type
  VTypes* = int32 | uint32 | float32
    ## Valid Types

  Vec*[R: static[int32], T] = array[R, T]
    ## Primitive type of Vector

  Vec1*[T] = Vec[1, T]
    ## The combination of the three Vec1
  Vec1i*   = Vec1[int32]
    ## Vec1 of in
  Vec1ui*  = Vec1[uint32]
    ## Vec1 of unned int32
  Vec1f*   = Vec1[float32]
    ## Vec1 of float32

  Vec2*[T] = Vec[2, T]
    ## The combination of the three Vec2
  Vec2i*   = Vec2[int32]
    ## Vec2 of in
  Vec2ui*  = Vec2[uint32]
    ## Vec2 of unned int32
  Vec2f*   = Vec2[float32]
    ## Vec2 of float32

  Vec3*[T] = Vec[3, T]
    ## The combination of the three Vec3
  Vec3i*   = Vec3[int32]
    ## Vec3 of in
  Vec3ui*  = Vec3[uint32]
    ## Vec3 of unned int32
  Vec3f*   = Vec3[float32]
    ## Vec3 of float32

  Vec4*[T] = Vec[4, T]
    ## The combination of the three Vec4
  Vec4i*   = Vec4[int32]
    ## Vec4 of in
  Vec4ui*  = Vec4[uint32]
    ## Vec4 of unned int32
  Vec4f*   = Vec4[float32]
    ## Vec4 of float32

  Vecf*    = Vec4f  | Vec3f  | Vec2f  | Vec1f
    ## Packs all the float32 vectors
  Veci*    = Vec4i  | Vec3i  | Vec2i  | Vec1i
    ## Packs all the uint32 vectors
  Vecui*   = Vec4ui | Vec3ui | Vec2ui | Vec1ui
    ## Packs all the int32 vectors

template x*(vec: Vec): untyped = vec[0]
template y*(vec: Vec2 | Vec3 | Vec4): untyped = vec[1]
template z*(vec: Vec3 | Vec4): untyped = vec[2]
template w*(vec: Vec4): untyped = vec[3]

template r*(vec: Vec): untyped = vec[0]
template g*(vec: Vec2 | Vec3 | Vec4): untyped = vec[1]
template b*(vec: Vec3 | Vec4): untyped = vec[2]

template i*(vec: Vec): untyped = vec[0]
template j*(vec: Vec2 | Vec3 | Vec4): untyped = vec[1]
template k*(vec: Vec3 | Vec4): untyped = vec[2]

template vPtr*(vec: Vec): ptr = vec[0].addr
  ## Gets the pointer to the first attribute in the tuple
template rgba*(vec: Vec4f): Vec4f = [vec[0] / 255'f32, vec[1] / 255'f32, vec[2] / 255'f32, vec[3]]
  ## Little utility to normalize rgba
template rgb*(vec: Vec3f): Vec3f = [vec[0] / 255'f32, vec[1] / 255'f32, vec[2] / 255'f32]
  ## Little utility to normalize rgb

{.push inline.}

const
  vecIndex = ['x', 'y', 'z', 'w']

proc vecToStr*(vec: Vec): string =
  ## Converts a Vec into a string
  result = "vec" & $vec.len & "("
  for n in 0 ..< vec.len:
    result = result & vecIndex[n] & ": " & $vec[n] & ", "
  result = result.substr(0, result.len - 3) & ")"

# "Constructors"

proc vec*[T](x: T): Vec1[T] = [x]
proc vec*[T](x, y: T): Vec2[T] = [x, y]
proc vec*[T](x, y, z: T): Vec3[T] = [x, y, z]
proc vec*[T](x, y, z, w: T): Vec4[T] = [x, y, z, w]

proc vec1* (vec: Vec): Vec1 = [vec.x]
  ## Converts any Veci into a Vec1i
proc vec2* (vec: Vec2 | Vec3 | Vec4): Vec2 = [vec.x, vec.y]
  ## Converts any Vec2,3,4i into a Vec2i
proc vec3* (vec: Vec3 | Vec4): Vec3 = [vec.x, vec.y, vec.z]
  ## Converts any Vec3,4 into a Vec3

proc vec1* (x: VTypes): Vec1 = [x]
  ## x to Vec1
proc vec2* (x, y: VTypes): Vec2 = [x, y]
  ## x and y to Vec2
proc vec3* (x, y, z: VTypes): Vec3 = [x, y, z]
  ## x, y and z to Vec3i
proc vec4* (x, y, z, w: VTypes): Vec4 = [x, y, z, w]
  ## x, y, z and w to Vec4i

proc vec2* (vec: Vec1, y: VTypes): Vec2 = [vec.x, y]
  ## Vec1 with a y to Vec2

proc vec3* (vec: Vec1, y, z: VTypes): Vec3 = [vec.x, y, z]
  ## Vec1 with y and z to Vec3
proc vec3* (vec: Vec2, z: VTypes): Vec3 = [vec.x, vec.y, z]
  ## Vec2 with y to Vec3

proc vec4* (vec: Vec1, y, z, w: VTypes): Vec4 = [vec.x, y, z, w]
  ## Vec1 with y, z and w to Vec4
proc vec4* (vec: Vec2, z, w: VTypes): Vec4 = [vec.x, vec.y, z, w]
  ## Vec2 with z, w to Vec4
proc vec4* (vec: Vec3, w: VTypes): Vec4 = [vec.x, vec.y, vec.z, w]
  ## Vec3 with w to Vec4
proc vec4* (v1: Vec2, v2: Vec2): Vec4 = [v1.x, v1.y, v2.x, v2.y]
  ## 2 vec2 to Vec4

# Operations

proc `+`*(v1, v2: Vec): Vec =
  ## Adding two vectors
  for n in 0 ..< v1.len:
    result[n] = v1[n] + v2[n]

proc `-`*(v1, v2: Vec): Vec =
  ## Substracting two vectors
  for n in 0 ..< v1.len:
    result[n] = v1[n] - v2[n]

proc `*`*(v1: Vecf, s: float32): Vecf =
  ## Multiplying one vector a scale v * s
  for n in 0 ..< v1.len:
    result[n] = v1[n] * s

proc `*`*(v1: Veci, s: int32): Veci =
  ## Multiplying one vector a scale v * s
  for n in 0 ..< v1.len:
    result[n] = v1[n] * s

proc `*`*(v1: Vecui, s: int32): Vecui =
  ## Multiplying one vector a scale v * s
  for n in 0 ..< v1.len:
    result[n] = v1[n] * s

proc `/`*(v: Vecf, s: float32): Vecf =
  ## Dividing one vector with a scale v / s
  for n in 0 ..< v.len:
    result[n] = v[n] / s

proc `/`*(v: Veci, s: float32): Veci =
  ## Dividing one vector with a scale v / s
  for n in 0 ..< v.len:
    result[n] = int32(float32(v[n]) / s)

proc `/`*(v: Vecui, s: float32): Vecui =
  ## Dividing one vector with a scale v / s
  for n in 0 ..< v.len:
    result[n] = uint32(float32(v[n]) / s)

proc mag*(v: Vec): float32 =
  ## Magnitude of this vector |v|
  var t: float32
  for n in 0 ..< v.len:
    t += float32(v[n] * v[n])
  sqrt(t)

proc dot*(v1, v2: Vec): float32 =
  ## Gives the dot product of this two vectors v1 . v2
  result  = 0f
  for n in 0 ..< v1.len:
    result += float32(v1[n] * v2[n])

proc dot*(v1, v2: Vec, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2) * cos(angle)

{.pop.}

## Matrices

type
  Mat*[C, R: static[int32], T] = array[C, Vec[R, T]]
    ## Primitive type of Matrix
  Mat4*[R: static[int32], T] = Mat[4, R, T]
  Mat3*[R: static[int32], T] = Mat[3, R, T]
  Mat2*[R: static[int32], T] = Mat[2, R, T]
  
  Mat4x4*[T] = Mat4[4, T]
    ## Matrix 4x4
  Mat4x3*[T] = Mat4[3, T]
    ## Matrix 4x3
  Mat4x2*[T] = Mat4[2, T]
    ## Matrix 4x2
  Mat4x1*[T] = Mat4[1, T]
    ## Matrix 4x2

  Mat3x3*[T] = Mat3[3, T]
    ## Matrix 3x3
  Mat3x4*[T] = Mat3[4, T]
    ## Matrix 3x4
  Mat3x2*[T] = Mat3[2, T]
    ## Matrix 3x2

  Mat2x2*[T] = Mat2[2, T]
    ## Matrix 2x2
  Mat2x3*[T] = Mat2[3, T]
    ## Matrix 2x3
  Mat2x4*[T] = Mat2[4, T]
    ## Matrix 2x4

template c0*(mat: Mat): untyped = mat[0]
template c1*(mat: Mat): untyped = mat[1]
template c2*(mat: Mat3 | Mat4): untyped = mat[2]
template c3*(mat: Mat4): untyped = mat[3]

template a*(mat: Mat): untyped = mat[0]
template b*(mat: Mat): untyped = mat[1]
template c*(mat: Mat3 | Mat4): untyped = mat[2]
template d*(mat: Mat4): untyped = mat[3]

proc matToStr*(mat: Mat): string =
  ## Converts Mat to string
  result = "mat" & $mat.len & "\n  ["
  for c in 0 ..< mat.len:
    for r in 0 ..< mat[c].len:
      result = result & $mat[c][r] & ", "
    result = result.substr(0, result.len - 3) & "]"
    if c != mat.len - 1:
      result = result & "\n  ["

# "Constructors"

proc mat4x4*[T](c0, c1, c2, c4: Vec4[T]): Mat4x4[T] =
  ## Creates a 4x4 Matrix
  [c0, c1, c2, c4]

proc mat4*[T](c0, c1, c2, c4: Vec4[T]): Mat4x4[T] =
  ## Creates a 4x4 Matrix
  [c0, c1, c2, c4]

proc mat3x3*[T](c0, c1, c2: Vec3[T]): Mat3x3[T] =
  ## Creates a 3x3 Matrix
  [c0, c1, c2]

proc mat3*[T](c0, c1, c2: Vec3[T]): Mat3x3[T] =
  ## Creates a 3x3 Matrix
  [c0, c1, c2]

proc mat2x2*[T](c0, c1: Vec2[T]): Mat2x2[T] =
  ## Creates a 2x2 Matrix
  [c0, c1, c2]

proc mat2*[T](c0, c1: Vec2[T]): Mat2x2[T] =
  ## Creates a 2x2 Matrix
  [c0, c1, c2]


proc mat4x3*[T](c0, c1, c2, c3: Vec3[T]): Mat4x3[T] =
  ## Creates a 4x3 Matrix
  [c0, c1, c2, c3]

proc mat4x2*[T](c0, c1, c2, c3: Vec2[T]): Mat4x2[T] =
  ## Creates a 4x2 Matrix
  [c0, c1, c2, c3]

proc mat4x1*[T](c0, c1, c2, c3: Vec1[T]): Mat4x1[T] =
  ## Creates a 4x1 Matrix
  [c0, c1, c2, c3]

proc mat4*[T](n: T): Mat4x4[T] =
  [
    [n, n, n, n],
    [n, n, n, n],
    [n, n, n, n],
    [n, n, n, n]
  ]

proc identity4*[T](): Mat4x4[T] =
  [
    [T(1), T(0), T(0), T(0)],
    [T(0), T(1), T(0), T(0)],
    [T(0), T(0), T(1), T(0)],
    [T(0), T(0), T(0), T(1)]
  ]

proc mat3x4*[T](c0, c1, c2: Vec4[T]): Mat3x4[T] =
  ## Creates a 3x4 Matrix
  [c0, c1, c2]

proc mat3x2*[T](c0, c1, c2: Vec2[T]): Mat3x2[T] =
  ## Creates a 4x2 Matrix
  [c0, c1, c2]

proc mat3*[T](n: T): Mat3x3[T] =
  [
    [n, n, n],
    [n, n, n],
    [n, n, n]
  ]

proc identity3*[T](): Mat3x3[T] =
  [
    [T(1), T(0), T(0)],
    [T(0), T(1), T(0)],
    [T(0), T(0), T(1)]
  ]


proc mat2x4*[T](c0, c1: Vec4[T]): Mat2x4[T] =
  ## Creates a 3x4 Matrix
  [c0, c1]

proc mat2x3*[T](c0, c1: Vec3[T]): Mat2x3[T] =
  ## Creates a 4x2 Matrix
  [c0, c1]

proc mat2*[T](n: T): Mat2x2[T] =
  [
    [n, n],
    [n, n]
  ]

proc identity2*[T](): Mat2x2[T] =
  [
    [T(1), T(0)],
    [T(0), T(1)]
  ]


# Algebra

proc ortho*[T](left, right, bottom, top, near, far: T): Mat4x4[T] =
  # TODO
  identity4[T]()