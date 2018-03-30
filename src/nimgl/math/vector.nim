# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## Vector - Math Module
## =======
## `return <../math.html>`_.  
## 
## Lovely vectors with some useful utilities

import
  pure/math

type
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

{.push inline.}

template  x*[R, T](vec: Vec[R, T]): untyped = vec[0]
template  y*[T](vec: Vec2[T] | Vec3[T] | Vec4[T]): untyped = vec[1]
template  z*[T](vec: Vec3[T] | Vec4[T]): untyped = vec[2]
template  w*[T](vec: Vec4[T]): untyped = vec[3]
template `x=`*[R, T](vec: Vec[R, T], e: T): untyped = vec[0] = e
template `y=`*[T](vec: Vec2[T] | Vec3[T] | Vec4[T], e: T): untyped = vec[1] = e
template `z=`*[T](vec: Vec3[T] | Vec4[T], e: T): untyped = vec[2] = e
template `w=`*[T](vec: Vec4[T], e: T): untyped = vec[3] = e

template  r*[R, T](vec: Vec[R, T]): untyped = vec[0]
template  g*[T](vec: Vec2[T] | Vec3[T] | Vec4[T]): untyped = vec[1]
template  b*[T](vec: Vec3[T] | Vec4[T]): untyped = vec[2]
template  a*[T](vec: Vec4[T]): untyped = vec[3]
template `r=`*[R, T](vec: Vec[R, T], e: T): untyped = vec[0] = e
template `g=`*[T](vec: Vec2[T] | Vec3[T] | Vec4[T], e: T): untyped = vec[1] = e
template `b=`*[T](vec: Vec3[T] | Vec4[T], e: T): untyped = vec[2] = e
template `a=`*[T](vec: Vec4[T], e: T): untyped = vec[3] = e

template  i*[R, T](vec: Vec[R, T]): untyped = vec[0]
template  j*[T](vec: Vec2[T] | Vec3[T] | Vec4[T]): untyped = vec[1]
template  k*[T](vec: Vec3[T] | Vec4[T]): untyped = vec[2]
template  s*[T](vec: Vec4[T]): untyped = vec[3]
template `i=`*[R, T](vec: Vec[R, T], e: T): untyped = vec[0] = e
template `j=`*[T](vec: Vec2[T] | Vec3[T] | Vec4[T], e: T): untyped = vec[1] = e
template `k=`*[T](vec: Vec3[T] | Vec4[T], e: T): untyped = vec[2] = e
template `s=`*[T](vec: Vec4[T], e: T): untyped = vec[3] = e

template vPtr*[R, T](vec: array[R, T]): ptr = vec[0].addr
  ## Gets the pointer to the first attribute in the array
template rgba*(vec: Vec4f): Vec4f =
  ## Little utility to normalize rgba
  if vec[3] > 1'f32:
    [vec[0] / 255'f32, vec[1] / 255'f32, vec[2] / 255'f32, vec[3] / 100'f32]
  else:
    [vec[0] / 255'f32, vec[1] / 255'f32, vec[2] / 255'f32, vec[3]]
template rgb*(vec: Vec3f): Vec3f =
  ## Little utility to normalize rgb
  [vec[0] / 255'f32, vec[1] / 255'f32, vec[2] / 255'f32]

const vecIndex = ['x', 'y', 'z', 'w']

proc `$`*[R, T](vec: Vec[R,T] | Vec1[T] | Vec2[T] | Vec3[T] | Vec4[T]): string =
  ## Converts a Vec into a string
  result = "vec" & $vec.len & "("
  for n in 0 ..< vec.len:
    result = result & vecIndex[n] & ": " & $vec[n] & ", "
  result = result.substr(0, result.len - 3) & ")"

# "Constructors"
proc vec*[T](x: T): Vec1[T] = [x]
  ## Any type of data for Vec1
proc vec*[T](x, y: T): Vec2[T] = [x, y]
  ## Any type of data for Vec2
proc vec*[T](x, y, z: T): Vec3[T] = [x, y, z]
  ## Any type of data for Vec3
proc vec*[T](x, y, z, w: T): Vec4[T] = [x, y, z, w]
  ## Any type of data for Vec4

proc vec2*[t](x: t): Vec2[t] = [x, x]
  ## Uses the same value for the rest Vec2
proc vec3*[t](x: t): Vec3[t] = [x, x, x]
  ## Uses the same value for the rest Vec3
proc vec4*[t](x: t): Vec4[t] = [x, x, x, x]
  ## Uses the same value for the rest Vec4

proc vec2f*(x: float32): Vec2[float32] = [x, x]
  ## Uses the same value for the rest Vec2f
proc vec3f*(x: float32): Vec3[float32] = [x, x, x]
  ## Uses the same value for the rest Vec3f
proc vec4f*(x: float32): Vec4[float32] = [x, x, x, x]
  ## Uses the same value for the rest Vec4f
proc vec2i*(x: int32): Vec2[int32] = [x, x]
  ## Uses the same value for the rest Vec2i
proc vec3i*(x: int32): Vec3[int32] = [x, x, x]
  ## Uses the same value for the rest Vec3i
proc vec4i*(x: int32): Vec4[int32] = [x, x, x, x]
  ## Uses the same value for the rest Vec4i
proc vec2ui*(x: uint32): Vec2[uint32] = [x, x]
  ## Uses the same value for the rest Vec2ui
proc vec3ui*(x: uint32): Vec3[uint32] = [x, x, x]
  ## Uses the same value for the rest Vec3ui
proc vec4ui*(x: uint32): Vec4[uint32] = [x, x, x, x]
  ## Uses the same value for the rest Vec4ui

proc vec*[R: static[int32], T](v: array[R, T]): Vec[R, T] = v
  ## Array to Vec using the size of the Array

proc vecf*(x: float32): Vec1[float32] = [x]
  ## float32 to Vec1
proc vecf*(x, y: float32): Vec2[float32] = [x, y]
  ## float32 to Vec2
proc vecf*(x, y, z: float32): Vec3[float32] = [x, y, z]
  ## float32 to Vec3
proc vecf*(x, y, z, w: float32): Vec4[float32] = [x, y, z, w]
  ## float32 to Vec4
proc veci*(x: int32): Vec1[int32] = [x]
  ## int32 to Vec1
proc veci*(x, y: int32): Vec2[int32] = [x, y]
  ## int32 to Vec2
proc veci*(x, y, z: int32): Vec3[int32] = [x, y, z]
  ## int32 to Vec3
proc veci*(x, y, z, w: int32): Vec4[int32] = [x, y, z, w]
  ## int32 to Vec4
proc vecui*(x: uint32): Vec1[uint32] = [x]
  ## uint32 to Vec1
proc vecui*(x, y: uint32): Vec2[uint32] = [x, y]
  ## uint32 to Vec2
proc vecui*(x, y, z: uint32): Vec3[uint32] = [x, y, z]
  ## uint32 to Vec3
proc vecui*(x, y, z, w: uint32): Vec4[uint32] = [x, y, z, w]
  ## uint32 to Vec4

proc vec1f*(x: float32): Vec1[float32] = [x]
  ## float32 to Vec1
proc vec2f*(x, y: float32): Vec2[float32] = [x, y]
  ## float32 to Vec2
proc vec3f*(x, y, z: float32): Vec3[float32] = [x, y, z]
  ## float32 to Vec3
proc vec4f*(x, y, z, w: float32): Vec4[float32] = [x, y, z, w]
  ## float32 to Vec4
proc vec1i*(x: int32): Vec1[int32] = [x]
  ## int32 to Vec1
proc vec2i*(x, y: int32): Vec2[int32] = [x, y]
  ## int32 to Vec2
proc vec3i*(x, y, z: int32): Vec3[int32] = [x, y, z]
  ## int32 to Vec3
proc vec4i*(x, y, z, w: int32): Vec4[int32] = [x, y, z, w]
  ## int32 to Vec4
proc vec1ui*(x: uint32): Vec1[uint32] = [x]
  ## uint32 to Vec1
proc vec2ui*(x, y: uint32): Vec2[uint32] = [x, y]
  ## uint32 to Vec2
proc vec3ui*(x, y, z: uint32): Vec3[uint32] = [x, y, z]
  ## uint32 to Vec3
proc vec4ui*(x, y, z, w: uint32): Vec4[uint32] = [x, y, z, w]
  ## uint32 to Vec4

proc vec1f*(): Vec1[float32] = [0'f32]
  ## zeros of type float32 to Vec1
proc vec2f*(): Vec2[float32] = [0'f32, 0'f32]
  ## zeros of type float32 to Vec2
proc vec3f*(): Vec3[float32] = [0'f32, 0'f32, 0'f32]
  ## zeros of type float32 to Vec3
proc vec4f*(): Vec4[float32] = [0'f32, 0'f32, 0'f32, 0'f32]
  ## zeros of type float32 to Vec4
proc vec1i*(): Vec1[int32] = [0'i32]
  ## zeros of type int32 to Vec1
proc vec2i*(): Vec2[int32] = [0'i32, 0'i32]
  ## zeros of type int32 to Vec2
proc vec3i*(): Vec3[int32] = [0'i32, 0'i32, 0'i32]
  ## zeros of type int32 to Vec3
proc vec4i*(): Vec4[int32] = [0'i32, 0'i32, 0'i32, 0'i32]
  ## zeros of type int32 to Vec4
proc vec1ui*(): Vec1[uint32] = [0'u32]
  ## zeros of type uint32 to Vec1
proc vec2ui*(): Vec2[uint32] = [0'u32, 0'u32]
  ## zeros of type uint32 to Vec2
proc vec3ui*(): Vec3[uint32] = [0'u32, 0'u32, 0'u32]
  ## zeros of type uint32 to Vec3
proc vec4ui*(): Vec4[uint32] = [0'u32, 0'u32, 0'u32, 0'u32]
  ## zeros of type uint32 to Vec4

proc vec1*[T](): Vec1[T] = [T(0)]
  ## zeros of manual type T to Vec1
proc vec2*[T](): Vec2[T] = [T(0), T(0)]
  ## zeros of manual type T to Vec2
proc vec3*[T](): Vec2[T] = [T(0), T(0), T(0)]
  ## zeros of manual type T to Vec3
proc vec4*[T](): Vec2[T] = [T(0), T(0), T(0), T(0)]
  ## zeros of manual type T to Vec4

template vec1*[T](v: seq[T]): Vec1[T] = vec(v[0])
  ## seq of any type to Vec1
template vec2*[T](v: seq[T]): Vec2[T] = vec(v[0], v[1])
  ## seq of any type to Vec2
template vec3*[T](v: seq[T]): Vec3[T] = vec(v[0], v[1], v[2])
  ## seq of any type to Vec3
template vec4*[T](v: seq[T]): Vec4[T] = vec(v[0], v[1], v[2], v[3])
  ## seq of any type to Vec4

proc vec1*[R, T] (vec: Vec[R, T]): Vec1[T] = [vec.x]
  ## Converts any Veci into a Vec1i
proc vec2*[T] (vec: Vec2[T] | Vec3[T] | Vec4[T]): Vec2[T] = [vec.x, vec.y]
  ## Converts any Vec2,3,4i into a Vec2i
proc vec3*[T] (vec: Vec3[T] | Vec4[T]): Vec3[T] = [vec.x, vec.y, vec.z]
  ## Converts any Vec3,4 into a Vec3

proc vec1*[T] (x: T): Vec1[T] = [x]
  ## x to Vec1
proc vec2*[T] (x, y: T): Vec2[T] = [x, y]
  ## x and y to Vec2
proc vec3*[T] (x, y, z: T): Vec3[T] = [x, y, z]
  ## x, y and z to Vec3i
proc vec4*[T] (x, y, z, w: T): Vec4[T] = [x, y, z, w]
  ## x, y, z and w to Vec4i

proc vec2*[T] (vec: Vec1[T], y: T): Vec2[T] = [vec.x, y]
  ## Vec1 with a y to Vec2

proc vec3*[T] (vec: Vec1[T], y, z: T): Vec3[T] = [vec.x, y, z]
  ## Vec1 with y and z to Vec3
proc vec3*[T] (vec: Vec2[T], z: T): Vec3[T] = [vec.x, vec.y, z]
  ## Vec2 with y to Vec3

proc vec4*[T] (vec: Vec1[T], y, z, w: T): Vec4[T] = [vec.x, y, z, w]
  ## Vec1 with y, z and w to Vec4
proc vec4*[T] (vec: Vec2[T], z, w: T): Vec4[T] = [vec.x, vec.y, z, w]
  ## Vec2 with z, w to Vec4
proc vec4*[T] (vec: Vec3[T], w: T): Vec4[T] = [vec.x, vec.y, vec.z, w]
  ## Vec3 with w to Vec4
proc vec4*[T] (v1: Vec2[T], v2: Vec2[T]): Vec4[T] = [v1.x, v1.y, v2.x, v2.y]
  ## 2 vec2 to Vec4

# Operations

proc `+`*[R: static[int32], T](v1, v2: array[R, T]): Vec[R, T] =
  ## Adding two vectors
  for n in 0 ..< v1.len:
    result[n] = v1[n] + v2[n]

proc `-`*[R: static[int32], T](v1, v2: array[R, T]): Vec[R, T] =
  ## Substracting two vectors
  for n in 0 ..< v1.len:
    result[n] = v1[n] - v2[n]

proc `*`*[R: static[int32], T](v: array[R, T], s: T): Vec[R, T] =
  ## Multiplying one vector a scale v * s
  for n in 0 ..< v.len:
    result[n] = T(v[n] * s)

proc `/`*[R: static[int32], T](v: array[R, T], s: T): Vec[R, T] =
  ## Dividing one vector with a scale v / s
  for n in 0 ..< v.len:
    result[n] = T(v[n].float / s.float)

proc mag*(v: Vec): float32 =
  ## Magnitude of this vector |v|
  var t: float32
  for n in 0 ..< v.len:
    t += float32(v[n] * v[n])
  sqrt(t)

proc dot*[R: static[int32], T](v1, v2: array[R, T]): float32 =
  ## Gives the dot product of this two vectors v1 . v2
  result  = 0f
  for n in 0 ..< v1.len:
    result += float32(v1[n] * v2[n])

proc dot*[R: static[int32], T](v1, v2: array[R, T], angle: float32): float32 =
  ## Gives the dot product of this two vectors with the given angle
  dot(v1, v2) * cos(angle)

proc sqrt*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## square root of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].sqrt)

proc cbrt*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## cube root of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].cbrt)

proc log10*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## log10 of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].log10)

proc log2*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## log2 of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].log2)

proc ln*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## natural log of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].ln)

proc pow*[R: static[int32], T](v: array[R, T], p: int): Vec[R, T] =
  ## power of p of every value in the vector
  for n in 0 ..< v.len:
    result[n] = v[n]
    for t in 1 ..< p:
      result[n] = T(v[n] * result[n])

proc pow*[R: static[int32], T](v: array[R, T], p: float): Vec[R, T] =
  ## power of p of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].pow(p))

proc exp*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## E to the power of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].exp())

proc cos*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## cosine of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].cos())

proc cosh*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## hyperbolic cosine of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].cosh())

proc sin*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## sine of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].cos())

proc sinh*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## hyperbolic sine of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].sinh())

proc tan*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## tangent of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].cos())

proc tanh*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## hyperbolic tangent of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].tanh())

proc arccos*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## arc cosine of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].arccos())

proc arcsin*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## arc sine of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].arcsin())

proc arctan*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## arc tangent of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].arctan())
  
proc trunc*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## remove the decimal digits
  for n in 0 ..< v.len:
    result[n] = T(v[n].trunc())
  
proc round*[R: static[int32], T](v: array[R, T], p: int): Vec[R, T] =
  ## value rounded to the nearest integer
  for n in 0 ..< v.len:
    result[n] = T(v[n].round(p))
  
proc floor*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## value rounded to the nearest integer below
  for n in 0 ..< v.len:
    result[n] = T(v[n].floor())
  
proc ceil*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## value rounded to the nearest integer above
  for n in 0 ..< v.len:
    result[n] = T(v[n].ceil())
  
proc degToRad*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## converts the values from degress to radians
  for n in 0 ..< v.len:
    result[n] = T(v[n].degToRad())
  
proc radToDeg*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## converts the values from radians to degress
  for n in 0 ..< v.len:
    result[n] = T(v[n].radToDeg())
  
proc abs*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## absolute values of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(v[n].abs())
  
proc sign*[R: static[int32], T](v: array[R, T]): Vec[R, T] =
  ## returns a number representing the sign of every value in the vector
  for n in 0 ..< v.len:
    result[n] = T(0)
    if v[n] > 0: result[n] = T(1)
    elif v[n] < 0: result[n] = T(-1)

{.pop.}
