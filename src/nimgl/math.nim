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

type
  RGB* = tuple[r, g, b: float32]
    ## RGB Tuple
  Vec1i*  = array[1, int32]
    ## Vec1 of int32
  Vec1ui* = array[1, uint32]
    ## Vec1 of unsigned int32
  Vec1f*  = array[1, float32]
    ## Vec1 of float32
  Vec1*   = Vec1i | Vec1ui | Vec1f
    ## The combination of the three Vec1

  Vec2i*  = array[2, int32]
    ## Vec2 of int32
  Vec2ui* = array[2, uint32]
    ## Vec2 of unsigned int32
  Vec2f*  = array[2, float32]
    ## Vec2 of float32
  Vec2*   = Vec2i | Vec2ui | Vec2f
    ## The combination of the three Vec2

  Vec3i*  = array[3, int32]
    ## Vec3 of int32
  Vec3ui* = array[3, uint32]
    ## Vec3 of unsigned int32
  Vec3f*  = array[3, float32]
    ## Vec3 of float32
  Vec3*   = Vec3i | Vec3ui | Vec3f
    ## The combination of the three Vec3

  Vec4i*  = array[4, int32]
    ## Vec4 of int32
  Vec4ui* = array[4, uint32]
    ## Vec4 of unsigned int32
  Vec4f*  = array[4, float32]
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

template x*(vec: Vec): untyped = vec[0]
template y*(vec: Vec): untyped = vec[1]
template z*(vec: Vec): untyped = vec[2]
template w*(vec: Vec): untyped = vec[3]

template r*(vec: Vec): untyped = vec[0]
template g*(vec: Vec): untyped = vec[1]
template b*(vec: Vec): untyped = vec[2]
template a*(vec: Vec): untyped = vec[3]

template i*(vec: Vec): untyped = vec[0]
template j*(vec: Vec): untyped = vec[1]
template k*(vec: Vec): untyped = vec[2]
template s*(vec: Vec): untyped = vec[3]

template vPtr*(vec: Vec): ptr = vec[0].addr
  ## Gets the pointer to the first attribute in the tuple
template rgba*(vec: Vec4f): Vec4f = [vec[0] / 255'f32, vec[1] / 255'f32, vec[2] / 255'f32, vec[3]]
  ## Little utility to normalize rgba
template rgb*(vec: Vec3f): Vec3f = [vec[0] / 255'f32, vec[1] / 255'f32, vec[2] / 255'f32]
  ## Little utility to normalize rgb

proc `$`*(vec: Vec1): string = "vec1(x: "  & $vec.x & ")"
  ## Converts a Vec1 into a string
proc `$`*(vec: Vec2): string = "vec2(x: "  & $vec.x & ", y: " & $vec.y & ")"
  ## Converts a Vec2 into a string
proc `$`*(vec: Vec3): string = "vec3(x: "  & $vec.x & ", y: " & $vec.y & ", z: " & $vec.z & ")"
  ## Converts a Vec3 into a string
proc `$`*(vec: Vec4): string = "vec3(x: "  & $vec.x & ", y: " & $vec.y & ", z: " & $vec.z & ", w: " & $vec.w & ")"
  ## Converts a Vec4 into a string

# "Constructors"

proc vec1i* (vec: Veci): Vec1i = [vec.x]
  ## Converts any Veci into a Vec1i
proc vec1ui*(vec: Vecui): Vec1ui = [vec.x]
  ## Converts any Vecui into a Vec1ui
proc vec1f* (vec: Vecf): Vec1f  = [vec.x]
  ## Converts any Vecf into a Vec1f

proc vec2i* (vec: Vec2i  | Vec3i  | Vec4i): Vec2i   = [vec.x, vec.y]
  ## Converts any Vec2,3,4i into a Vec2i
proc vec2ui*(vec: Vec2ui | Vec3ui | Vec4ui): Vec2ui = [vec.x, vec.y]
  ## Converts any Vec2,3,4ui into a Vec2ui
proc vec2f* (vec: Vec2f  | Vec3f  | Vec4f): Vec2f   = [vec.x, vec.y]
  ## Converts any Vec2,3,4f into a Vec2f

proc vec3i* (vec: Vec3i  | Vec4i): Vec3i   = [vec.x, vec.y, vec.z]
  ## Converts any Vec3,4i into a Vec2i
proc vec3ui*(vec: Vec3ui | Vec4ui): Vec3ui = [vec.x, vec.y, vec.z]
  ## Converts any Vec3,4ui into a Vec2ui
proc vec3f* (vec: Vec3f  | Vec4f): Vec3f   = [vec.x, vec.y, vec.z]
  ## Converts any Vec3,4f into a Vec2f

proc vec1i* (x: int32): Vec1i   = [x]
  ## x to Vec1i
proc vec1ui*(x: uint32): Vec1ui = [x]
  ## x to Vec1ui
proc vec1f* (x: float32): Vec1f = [x]
  ## x to Vec1f

proc vec2i* (x: int32, y: int32): Vec2i     = [x, y]
  ## x and y to Vec2i
proc vec2ui*(x: uint32, y: uint32): Vec2ui  = [x, y]
  ## x and y to Vec2ui
proc vec2f* (x: float32, y: float32): Vec2f = [x, y]
  ## x and y to Vec2f
proc vec2i* (vec: Vec1i, y: int32): Vec2i    = [vec.x, y]
  ## Vec1i with a y to Vec2i
proc vec2ui*(vec: Vec1ui, y: uint32): Vec2ui = [vec.x, y]
  ## Vec1ui with a y to Vec2ui
proc vec2f* (vec: Vec1f, y: float32): Vec2f  = [vec.x, y]
  ## Veclf with a y to Vec2f

proc vec3i* (x: int32, y: int32, z: int32): Vec3i       = [x, y, z]
  ## x, y and z to Vec3i
proc vec3ui*(x: uint32, y: uint32, z: uint32): Vec3ui   = [x, y, z]
  ## x, y and z to Vec3ui
proc vec3f* (x: float32, y: float32, z: float32): Vec3f = [x, y, z]
  ## x, y and z to Vec3f
proc vec3i* (vec: Vec1i, y: int32, z: int32): Vec3i      = [vec.x, y, z]
  ## Vec1i with y and z to Vec3i
proc vec3ui*(vec: Vec1ui, y: uint32, z: uint32): Vec3ui  = [vec.x, y, z]
  ## Vec1ui with y and z to Vec3ui
proc vec3f* (vec: Vec1f, y: float32, z: float32): Vec3f  = [vec.x, y, z]
  ## Vec1f with y and z to Vec3f
proc vec3i* (vec: Vec2i, z: int32): Vec3i    = [vec.x, vec.y, z]
  ## Vec2i with y to Vec3i
proc vec3ui*(vec: Vec2ui, z: uint32): Vec3ui = [vec.x, vec.y, z]
  ## Vec2ui with y to Vec3ui
proc vec3f* (vec: Vec2f, z: float32): Vec3f  = [vec.x, vec.y, z]
  ## Vec2f with y to Vec3f

proc vec4i* (x: int32, y: int32, z: int32, w: int32): Vec4i          = [x, y, z, w]
  ## x, y, z and w to Vec4i
proc vec4ui*(x: uint32, y: uint32, z: uint32, w: uint32): Vec4ui     = [x, y, z, w]
  ## x, y, z and w to Vec4ui
proc vec4f* (x: float32, y: float32, z: float32, w: float32): Vec4f  = [x, y, z, w]
  ## x, y, z and w to Vec4f
proc vec4i* (vec: Vec1i, y: int32, z: int32, w: int32): Vec4i        = [vec.x, y, z, w]
  ## Vec1i with y, z and w to Vec4i
proc vec4ui*(vec: Vec1ui, y: uint32, z: uint32, w: uint32): Vec4ui   = [vec.x, y, z, w]
  ## Vec1ui with y, z and w to Vec4ui
proc vec4f* (vec: Vec1f, y: float32, z: float32, w: float32): Vec4f  = [vec.x, y, z, w]
  ## Vec1f with y, z and w to Vec4f
proc vec4i* (vec: Vec2i, z: int32, w: int32): Vec4i      = [vec.x, vec.y, z, w]
  ## Vec2i with z, w to Vec4i
proc vec4ui*(vec: Vec2ui, z: uint32, w: uint32): Vec4ui  = [vec.x, vec.y, z, w]
  ## Vec2ui with z, w to Vec4ui
proc vec4f* (vec: Vec2f, z: float32, w: float32): Vec4f  = [vec.x, vec.y, z, w]
  ## Vec2f with z, w to Vec4f
proc vec4i* (vec: Vec3i, w: int32): Vec4i    = [vec.x, vec.y, vec.z, w]
  ## Vec3i with w to Vec4i
proc vec4ui*(vec: Vec3ui, w: uint32): Vec4ui = [vec.x, vec.y, vec.z, w]
  ## Vec3ui with w to Vec4ui
proc vec4f* (vec: Vec3f, w: float32): Vec4f  = [vec.x, vec.y, vec.z, w]
  ## Vec3f with w to Vec4f

proc vec*[T](x: T): Vec1 = [x]
proc vec*[T](x, y: T): Vec2 = [x, y]
proc vec*[T](x, y, z: T): Vec3 = [x, y, z]
proc vec*[T](x, y, z, w: T): Vec4 = [x, y, z, w]

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