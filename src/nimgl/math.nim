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

converter toInt32*(n: int): int32 =
  ## This might be unsafe with bigger numbers, so please try to always use 'i32
  ## instead of depending on this converter
  int32(n)

converter toUint32*(n: uint): uint32 =
  ## This might be unsafe with bigger numbers, so please try to always use 'ui32
  ## instead of depending on this converter
  uint32(n)

converter toFloat32*(n: float): float32 =
  ## This might be unsafe with bigger numbers, so please try to always use 'f32
  ## instead of depending on this converter
  float32(n)

type
  Vec1i*  = tuple[x: int32]
    ## Vec1 of int32
  Vec1ui* = tuple[x: uint32]
    ## Vec1 of unsigned int32
  Vec1f*  = tuple[x: float32]
    ## Vec1 of float32
  Vec1*   = Vec1i | Vec1ui | Vec1f
    ## The combination of the three Vec1

  Vec2i*  = tuple[x: int32, y: int32]
    ## Vec2 of int32
  Vec2ui* = tuple[x: uint32, y: uint32]
    ## Vec2 of unsigned int32
  Vec2f*  = tuple[x: float32, y: float32]
    ## Vec2 of float32
  Vec2*   = Vec2i | Vec2ui | Vec2f
    ## The combination of the three Vec2

  Vec3i*  = tuple[x: int32, y: int32, z: int32]
    ## Vec3 of int32
  Vec3ui* = tuple[x: uint32, y: uint32, z: uint32]
    ## Vec3 of unsigned int32
  Vec3f*  = tuple[x: float32, y: float32, z: float32]
    ## Vec3 of float32
  Vec3*   = Vec3i | Vec3ui | Vec3f
    ## The combination of the three Vec3

  Vec4i*  = tuple[x: int32, y: int32, z: int32, w: int32]
    ## Vec4 of int32
  Vec4ui* = tuple[x: uint32, y: uint32, z: uint32, w: uint32]
    ## Vec4 of unsigned int32
  Vec4f*  = tuple[x: float32, y: float32, z: float32, w: float32]
    ## Vec4 of float32
  Vec4*   = Vec4i | Vec4ui | Vec4f
    ## The combination of the three Vec4

  Vec*    = Vec4   | Vec3   | Vec2   | Vec1
    ## Packs every vector of every kind
  Vecf*   = Vec4f  | Vec3f  | Vec2f  | Vec1f
    ## Packs all the float32 vectors
  Veci*   = Vec4i  | Vec3i  | Vec2i  | Vec1i
    ## Packs all the uint32 vectors
  Vecui*  = Vec4ui | Vec3ui | Vec2ui | Vec1ui
    ## Packs all the int32 vectors

template vPtr*(vec: Vec): ptr =
  ## Gets the pointer to the first attribute in the tuple
  vec[0].addr

template f32*(num: int): untyped =
  num.toFloat.toFloat32

template f32*(num: float): untyped =
  num.toFloat32

template f32*(num: uint32): untyped =
  float32(num)

proc `$`*(vec: Vec1): string =
  ## Converts a Vec1 into a string
  "vec1(x: "  & $vec.x & ")"

proc `$`*(vec: Vec2): string =
  ## Converts a Vec2 into a string
  "vec2(x: "  & $vec.x & ", y: " & $vec.y & ")"

proc `$`*(vec: Vec3): string =
  ## Converts a Vec3 into a string
  "vec3(x: "  & $vec.x & ", y: " & $vec.y & ", z: " & $vec.z & ")"

proc `$`*(vec: Vec4): string =
  ## Converts a Vec4 into a string
  "vec3(x: "  & $vec.x & ", y: " & $vec.y & ", z: " & $vec.z & ", w: " & $vec.w & ")"

# "Constructors"

proc vec1i* (vec: Veci): Vec1i  = (vec.x)
  ## Converts any Veci into a Vec1i
proc vec1ui*(vec: Vecui): Vec1ui = (vec.x)
  ## Converts any Vecui into a Vec1ui
proc vec1f* (vec: Vecf): Vec1f  = (vec.x)
  ## Converts any Vecf into a Vec1f

proc vec2i* (vec: Vec2i  | Vec3i  | Vec4i): Vec2i   = (vec.x, vec.y)
  ## Converts any Vec2,3,4i into a Vec2i
proc vec2ui*(vec: Vec2ui | Vec3ui | Vec4ui): Vec2ui = (vec.x, vec.y)
  ## Converts any Vec2,3,4ui into a Vec2ui
proc vec2f* (vec: Vec2f  | Vec3f  | Vec4f): Vec2f   = (vec.x, vec.y)
  ## Converts any Vec2,3,4f into a Vec2f

proc vec3i* (vec: Vec3i  | Vec4i): Vec3i   = (vec.x, vec.y, vec.z)
  ## Converts any Vec3,4i into a Vec2i
proc vec3ui*(vec: Vec3ui | Vec4ui): Vec3ui = (vec.x, vec.y, vec.z)
  ## Converts any Vec3,4ui into a Vec2ui
proc vec3f* (vec: Vec3f  | Vec4f): Vec3f   = (vec.x, vec.y, vec.z)
  ## Converts any Vec3,4f into a Vec2f

proc vec2i* (vec: Vec1i, y: int32): Vec2i    = (vec.x, y)
  ## Vec1i with a y to Vec2i
proc vec2ui*(vec: Vec1ui, y: uint32): Vec2ui = (vec.x, y)
  ## Vec1ui with a y to Vec2ui
proc vec2f* (vec: Vec1f, y: float32): Vec2f  = (vec.x, y)
  ## Veclf with a y to Vec2f

proc vec3i* (vec: Vec1i, y: int32, z: int32): Vec3i      = (vec.x, y, z)
  ## Vec1i with y and z to Vec3i
proc vec3ui*(vec: Vec1ui, y: uint32, z: uint32): Vec3ui  = (vec.x, y, z)
  ## Vec1ui with y and z to Vec3ui
proc vec3f* (vec: Vec1f, y: float32, z: float32): Vec3f  = (vec.x, y, z)
  ## Vec1f with y and z to Vec3f
proc vec3i* (vec: Vec2i, z: int32): Vec3i    = (vec.x, vec.y, z)
  ## Vec2i with y to Vec3i
proc vec3ui*(vec: Vec2ui, z: uint32): Vec3ui = (vec.x, vec.y, z)
  ## Vec2ui with y to Vec3ui
proc vec3f* (vec: Vec2f, z: float32): Vec3f  = (vec.x, vec.y, z)
  ## Vec2f with y to Vec3f

proc vec4i* (vec: Vec1i, y: int32, z: int32, w: int32): Vec4i        = (vec.x, y, z, w)
  ## Vec1i with y, z and w to Vec4i
proc vec4ui*(vec: Vec1ui, y: uint32, z: uint32, w: uint32): Vec4ui   = (vec.x, y, z, w)
  ## Vec1ui with y, z and w to Vec4ui
proc vec4f* (vec: Vec1f, y: float32, z: float32, w: float32): Vec4f  = (vec.x, y, z, w)
  ## Vec1f with y, z and w to Vec4f
proc vec4i* (vec: Vec2i, z: int32, w: int32): Vec4i      = (vec.x, vec.y, z, w)
  ## Vec2i with z, w to Vec4i
proc vec4ui*(vec: Vec2ui, z: uint32, w: uint32): Vec4ui  = (vec.x, vec.y, z, w)
  ## Vec2ui with z, w to Vec4ui
proc vec4f* (vec: Vec2f, z: float32, w: float32): Vec4f  = (vec.x, vec.y, z, w)
  ## Vec2f with z, w to Vec4f
proc vec4i* (vec: Vec3i, w: int32): Vec4i    = (vec.x, vec.y, vec.z, w)
  ## Vec3i with w to Vec4i
proc vec4ui*(vec: Vec3ui, w: uint32): Vec4ui = (vec.x, vec.y, vec.z, w)
  ## Vec3ui with w to Vec4ui
proc vec4f* (vec: Vec3f, w: float32): Vec4f  = (vec.x, vec.y, vec.z, w)
  ## Vec3f with w to Vec4f

# Operations
# I couldn't think of another way other than copy pasting this to the different
# types, please if you know other way, please change it so it's not all of this
# ugly big code

# float32

proc `+`*(v1, v2: Vec1f): Vec1f =
  ## Adding two vectors
  (x: v1.x + v2.x)

proc `-`*(v1, v2: Vec1f): Vec1f =
  ## Substracting two vectors
  (x: v1.x - v2.x)

proc `*`*(v1: Vec1f, s: float32): Vec1f =
  ## Multiplying one vector a scale v * s
  (x: v1.x * s)

proc `/`*(v: Vec1f, s: float32): Vec1f =
  ## Dividing one vector with a scale v / s
  (x: v.x / s)

proc mag*(v: Vec1f): float32 =
  ## Magnitude of this vector |v|
  sqrt(v.x)

proc dot*(v1, v2: Vec1f): float32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x

proc dot*(v1, v2: Vec1f, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2) * cos(angle)


proc `+`*(v1, v2: Vec2f): Vec2f =
  ## Adding two vectors
  (v1.x + v2.x, v1.y + v2.y)

proc `-`*(v1, v2: Vec2f): Vec2f =
  ## Substracting two vectors
  (v1.x - v2.x, v1.y - v2.y)

proc `*`*(v1: Vec2f, s: float32): Vec2f =
  ## Multiplying one vector a scale v * s
  (v1.x * s, v1.y * s)

proc `/`*(v: Vec2f, s: float32): Vec2f =
  ## Dividing one vector with a scale v / s
  (v.x / s, v.y / s)

proc mag*(v: Vec2f): float32 =
  ## Magnitude of this vector |v|
  sqrt(v.x + v.y)

proc dot*(v1, v2: Vec2f): float32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x + v1.y * v2.y

proc dot*(v1, v2: Vec2f, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2) * cos(angle)


proc `+`*(v1, v2: Vec3f): Vec3f =
  ## Adding two vectors
  (v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)

proc `-`*(v1, v2: Vec3f): Vec3f =
  ## Substracting two vectors
  (v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)

proc `*`*(v1: Vec3f, s: float32): Vec3f =
  ## Multiplying one vector a scale v * s
  (v1.x * s, v1.y * s, v1.z * s)

proc `/`*(v: Vec3f, s: float32): Vec3f =
  ## Dividing one vector with a scale v / s
  (v.x / s, v.y / s, v.z / s)

proc mag*(v: Vec3f): float32 =
  ## Magnitude of this vector |v|
  sqrt(v.x + v.y + v.z)

proc dot*(v1, v2: Vec3f): float32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x + v1.y * v2.y + v1.z * v2.z

proc dot*(v1, v2: Vec3f, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2) * cos(angle)


proc `+`*(v1, v2: Vec4f): Vec4f =
  ## Adding two vectors
  (v1.x + v2.x, v1.y + v2.y, v1.z + v2.z, v1.w + v2.w)

proc `-`*(v1, v2: Vec4f): Vec4f =
  ## Substracting two vectors
  (v1.x - v2.x, v1.y - v2.y, v1.z - v2.z, v1.w - v2.w)

proc `*`*(v1: Vec4f, s: float32): Vec4f =
  ## Multiplying one vector a scale v * s
  (v1.x * s, v1.y * s, v1.z * s, v1.w * s)

proc `/`*(v: Vec4f, s: float32): Vec4f =
  ## Dividing one vector with a scale v / s
  (v.x / s, v.y / s, v.z / s, v.w / s)

proc mag*(v: Vec4f): float32 =
  ## Magnitude of this vector |v|
  sqrt(v.x + v.y + v.z + v.w)

proc dot*(v1, v2: Vec4f): float32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x + v1.y * v2.y + v1.z * v2.z + v1.w * v2.w

proc dot*(v1, v2: Vec4f, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2) * cos(angle)


# Int32

proc `+`*(v1, v2: Vec1i): Vec1i =
  ## Adding two vectors
  (x: v1.x + v2.x)

proc `-`*(v1, v2: Vec1i): Vec1i =
  ## Substracting two vectors
  (x: v1.x - v2.x)

proc `*`*(v1: Vec1i, s: int32): Vec1i =
  ## Multiplying one vector a scale v * s
  (x: v1.x * s)

proc `/`*(v: Vec1i, s: int32): Vec1f =
  ## Dividing one vector with a scale v / s
  (x:(v.x / s).f32)

proc mag*(v: Vec1i): float32 =
  ## Magnitude of this vector |v|
  sqrt(v.x.f32)

proc dot*(v1, v2: Vec1i): int32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x

proc dot*(v1, v2: Vec1i, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2).f32 * cos(angle)


proc `+`*(v1, v2: Vec2i): Vec2i =
  ## Adding two vectors
  (v1.x + v2.x, v1.y + v2.y)

proc `-`*(v1, v2: Vec2i): Vec2i =
  ## Substracting two vectors
  (v1.x - v2.x, v1.y - v2.y)

proc `*`*(v1: Vec2i, s: int32): Vec2i =
  ## Multiplying one vector a scale v * s
  (v1.x * s, v1.y * s)

proc `/`*(v: Vec2i, s: float32): Vec2f =
  ## Dividing one vector with a scale v / s
  (v.x.f32 / s, v.y.f32 / s)

proc mag*(v: Vec2i): float32 =
  ## Magnitude of this vector |v|
  sqrt((v.x + v.y).f32)

proc dot*(v1, v2: Vec2i): int32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x + v1.y * v2.y

proc dot*(v1, v2: Vec2i, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2).f32 * cos(angle)


proc `+`*(v1, v2: Vec3i): Vec3i =
  ## Adding two vectors
  (v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)

proc `-`*(v1, v2: Vec3i): Vec3i =
  ## Substracting two vectors
  (v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)

proc `*`*(v1: Vec3i, s: int32): Vec3i =
  ## Multiplying one vector a scale v * s
  (v1.x * s, v1.y * s, v1.z * s)

proc `/`*(v: Vec3i, s: float32): Vec3f =
  ## Dividing one vector with a scale v / s
  (v.x.f32 / s, v.y.f32 / s, v.z.f32 / s)

proc mag*(v: Vec3i): float32 =
  ## Magnitude of this vector |v|
  sqrt((v.x + v.y + v.z).f32)

proc dot*(v1, v2: Vec3i): int32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x + v1.y * v2.y + v1.z * v2.z

proc dot*(v1, v2: Vec3i, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2).f32 * cos(angle)


proc `+`*(v1, v2: Vec4i): Vec4i =
  ## Adding two vectors
  (v1.x + v2.x, v1.y + v2.y, v1.z + v2.z, v1.w + v2.w)

proc `-`*(v1, v2: Vec4i): Vec4i =
  ## Substracting two vectors
  (v1.x - v2.x, v1.y - v2.y, v1.z - v2.z, v1.w - v2.w)

proc `*`*(v1: Vec4i, s: int32): Vec4i =
  ## Multiplying one vector a scale v * s
  (v1.x * s, v1.y * s, v1.z * s, v1.w * s)

proc `/`*(v: Vec4i, s: float32): Vec4f =
  ## Dividing one vector with a scale v / s
  (v.x.f32 / s, v.y.f32 / s, v.z.f32 / s, v.w.f32 / s)

proc mag*(v: Vec4i): float32 =
  ## Magnitude of this vector |v|
  sqrt((v.x + v.y + v.z + v.w).f32)

proc dot*(v1, v2: Vec4i): int32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x + v1.y * v2.y + v1.z * v2.z + v1.w * v2.w

proc dot*(v1, v2: Vec4i, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2).f32 * cos(angle)

# Uint32

proc `+`*(v1, v2: Vec1ui): Vec1ui =
  ## Adding two vectors
  (x: v1.x + v2.x)

proc `-`*(v1, v2: Vec1ui): Vec1ui =
  ## Substracting two vectors
  (x: v1.x - v2.x)

proc `*`*(v1: Vec1ui, s: uint32): Vec1ui =
  ## Multiplying one vector a scale v * s
  (x: v1.x * s)

proc `/`*(v: Vec1ui, s: uint32): Vec1f =
  ## Dividing one vector with a scale v / s
  (x:(v.x div s).f32)

proc mag*(v: Vec1ui): float32 =
  ## Magnitude of this vector |v|
  sqrt(v.x.f32)

proc dot*(v1, v2: Vec1ui): uint32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x

proc dot*(v1, v2: Vec1ui, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2).f32 * cos(angle)


proc `+`*(v1, v2: Vec2ui): Vec2ui =
  ## Adding two vectors
  (v1.x + v2.x, v1.y + v2.y)

proc `-`*(v1, v2: Vec2ui): Vec2ui =
  ## Substracting two vectors
  (v1.x - v2.x, v1.y - v2.y)

proc `*`*(v1: Vec2ui, s: uint32): Vec2ui =
  ## Multiplying one vector a scale v * s
  (v1.x * s, v1.y * s)

proc `/`*(v: Vec2ui, s: float32): Vec2f =
  ## Dividing one vector with a scale v / s
  (v.x.f32 / s, v.y.f32 / s)

proc mag*(v: Vec2ui): float32 =
  ## Magnitude of this vector |v|
  sqrt((v.x + v.y).f32)

proc dot*(v1, v2: Vec2ui): uint32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x + v1.y * v2.y

proc dot*(v1, v2: Vec2ui, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2).f32 * cos(angle)


proc `+`*(v1, v2: Vec3ui): Vec3ui =
  ## Adding two vectors
  (v1.x + v2.x, v1.y + v2.y, v1.z + v2.z)

proc `-`*(v1, v2: Vec3ui): Vec3ui =
  ## Substracting two vectors
  (v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)

proc `*`*(v1: Vec3ui, s: uint32): Vec3ui =
  ## Multiplying one vector a scale v * s
  (v1.x * s, v1.y * s, v1.z * s)

proc `/`*(v: Vec3ui, s: float32): Vec3f =
  ## Dividing one vector with a scale v / s
  (v.x.f32 / s, v.y.f32 / s, v.z.f32 / s)

proc mag*(v: Vec3ui): float32 =
  ## Magnitude of this vector |v|
  sqrt((v.x + v.y + v.z).f32)

proc dot*(v1, v2: Vec3ui): uint32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x + v1.y * v2.y + v1.z * v2.z

proc dot*(v1, v2: Vec3ui, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2).f32 * cos(angle)


proc `+`*(v1, v2: Vec4ui): Vec4ui =
  ## Adding two vectors
  (v1.x + v2.x, v1.y + v2.y, v1.z + v2.z, v1.w + v2.w)

proc `-`*(v1, v2: Vec4ui): Vec4ui =
  ## Substracting two vectors
  (v1.x - v2.x, v1.y - v2.y, v1.z - v2.z, v1.w - v2.w)

proc `*`*(v1: Vec4ui, s: uint32): Vec4ui =
  ## Multiplying one vector a scale v * s
  (v1.x * s, v1.y * s, v1.z * s, v1.w * s)

proc `/`*(v: Vec4ui, s: float32): Vec4f =
  ## Dividing one vector with a scale v / s
  (v.x.f32 / s, v.y.f32 / s, v.z.f32 / s, v.w.f32 / s)

proc mag*(v: Vec4ui): float32 =
  ## Magnitude of this vector |v|
  sqrt((v.x + v.y + v.z + v.w).f32)

proc dot*(v1, v2: Vec4ui): uint32 =
  ## Gives the dot product of this two vectors v1 . v2
  v1.x * v2.x + v1.y * v2.y + v1.z * v2.z + v1.w * v2.w

proc dot*(v1, v2: Vec4ui, angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2).f32 * cos(angle)