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

type
  VTypes* = int32 | uint32 | float32
    ## Valid Types
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
template y*(vec: Vec2 | Vec3 | Vec4): untyped = vec[1]
template z*(vec: Vec3 | Vec4): untyped = vec[2]
template w*(vec: Vec4): untyped = vec[3]

template r*(vec: Vec): untyped = vec[0]
template g*(vec: Vec2 | Vec3 | Vec4): untyped = vec[1]
template b*(vec: Vec3 | Vec4): untyped = vec[2]
template a*(vec: Vec4): untyped = vec[3]

template i*(vec: Vec): untyped = vec[0]
template j*(vec: Vec2 | Vec3 | Vec4): untyped = vec[1]
template k*(vec: Vec3 | Vec4): untyped = vec[2]
template s*(vec: Vec4): untyped = vec[3]

template vPtr*(vec: Vec): ptr = vec[0].addr
  ## Gets the pointer to the first attribute in the tuple
template rgba*(vec: Vec4f): Vec4f = [vec[0] / 255'f32, vec[1] / 255'f32, vec[2] / 255'f32, vec[3]]
  ## Little utility to normalize rgba
template rgb*(vec: Vec3f): Vec3f = [vec[0] / 255'f32, vec[1] / 255'f32, vec[2] / 255'f32]
  ## Little utility to normalize rgb

{.push inline.}

proc `$`*(vec: Vec1): string = "vec1(x: "  & $vec.x & ")"
  ## Converts a Vec1 into a string
proc `$`*(vec: Vec2): string = "vec2(x: "  & $vec.x & ", y: " & $vec.y & ")"
  ## Converts a Vec2 into a string
proc `$`*(vec: Vec3): string = "vec3(x: "  & $vec.x & ", y: " & $vec.y & ", z: " & $vec.z & ")"
  ## Converts a Vec3 into a string
proc `$`*(vec: Vec4): string = "vec3(x: "  & $vec.x & ", y: " & $vec.y & ", z: " & $vec.z & ", w: " & $vec.w & ")"
  ## Converts a Vec4 into a string

# "Constructors"

proc vec*(x: VTypes): Vec1 = [x]
proc vec*(x, y: VTypes): Vec2 = [x, y]
proc vec*(x, y, z: VTypes): Vec3 = [x, y, z]
proc vec*(x, y, z, w: VTypes): Vec4 = [x, y, z, w]

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