# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## Matrices
## =======
## `return <../math.html>`_.  
##
## Lovely matrices with some useful utilities

import
  pure/math,
  vector

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

{.push inline.}

template  a*[c, r, t](mat: array[c, array[r, t]]): untyped = mat[0]
template  b*[c, r, t](mat: array[c, array[r, t]]): untyped = mat[1]
template  c*[c, r, t](mat: array[c, array[r, t]]): untyped = mat[2]
template  d*[c, r, t](mat: array[c, array[r, t]]): untyped = mat[3]
template `a=`*[C, R, T](mat: array[C, array[R, T]], e: T): untyped = mat[0] = e
template `b=`*[C, R, T](mat: array[C, array[R, T]], e: T): untyped = mat[1] = e
template `c=`*[C, R, T](mat: array[C, array[R, T]], e: T): untyped = mat[2] = e
template `d=`*[C, R, T](mat: array[C, array[R, T]], e: T): untyped = mat[3] = e

proc `$`*[C, R, T](mat: array[C, array[R, T]]): string =
  ## Converts Mat to string
  result = "mat" & $mat.len & "\n  ["
  for c in 0 ..< mat.len:
    for r in 0 ..< mat[c].len:
      result = result & $mat[c][r] & ", "
    result = result.substr(0, result.len - 3) & "]"
    if c != mat.len - 1:
      result = result & "\n  ["

template vPtr*[C, R, T](mat: array[C, array[R, T]]): ptr = mat[0][0].addr
  ## Gets the pointer to the first attribute in the array

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
  [c0, c1]

proc mat2*[T](c0, c1: Vec2[T]): Mat2x2[T] =
  ## Creates a 2x2 Matrix
  [c0, c1]


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

# Math

proc ortho*(left, right, bottom, top, near, far: float32): Mat4x4[float32] =
  result = mat4(0.0f)
  result[0][0] =  2.0f / (right  - left)
  result[1][1] =  2.0f / (top - bottom)
  result[2][2] = -2.0f / (far - near)
  result[0][3] = -(right + left) / (right - left)
  result[1][3] = -(top + bottom) / (top - bottom)
  result[2][3] = -(far + near) / (far - near)
  result[3][3] =  1.0f

{.pop.}
