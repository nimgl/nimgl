# Copyright (C) Leonardo Mariscal. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import
  nimgl/math, unittest

suite "vec1":
  test "equality":
    var
      vecA = vec1(333416892.8447f)
      vecB = vec1(333416892.8447f)

    check((vecA == vecB) != (vecB != vecA))

    vecA *= 2.3f
    vecB *= 2.3

    check((vecA == vecB) != (vecB != vecA))

  test "size":
    var
      vecA = vec1[float32](1140853155.4688)
      vecB = vec1[float64](213123387435839.9354)
      vecC = vec1[int8](127'i8)
      vecD = vec1[int16](32767'i16)
      vecE = vec1[int32](2147483647)

    check(vecA.sizeof == float32.sizeof)
    check(vecB.sizeof == float64.sizeof)
    check(vecC.sizeof == int8.sizeof)
    check(vecD.sizeof == int16.sizeof)
    check(vecE.sizeof == int32.sizeof)

suite "vec2":
  test "equality":
    var
      vecA = vec2(333416892.8447f, 333416892.8447f)
      vecB = vec2(333416892.8447f)

    check((vecA == vecB) != (vecB != vecA))

    vecA *= 4.5f
    vecB *= 4.5

    check((vecA == vecB) != (vecB != vecA))

  test "size":
    var
      vecA = vec2[float32](1140853155.4688)
      vecB = vec2[float64](213123387435839.9354)
      vecC = vec2[int8](127'i8)
      vecD = vec2[int16](32767'i16)
      vecE = vec2[int32](2147483647)

    check(vecA.sizeof == float32.sizeof * 2)
    check(vecB.sizeof == float64.sizeof * 2)
    check(vecC.sizeof == int8.sizeof * 2)
    check(vecD.sizeof == int16.sizeof * 2)
    check(vecE.sizeof == int32.sizeof * 2)

  test "convertion":
    let k = @[123'f32, 456'f32]
    var
      vecA = vec1[float32](41543234.9128'f32)
      vecB = vec1[float32](49230420.1029'f32)
      vecC = vec2[float32](vecA, 23129301.1392'f32)
      vecD = vec2[float32](vecA, vecB[0])
      vecE = vec2[float32](k)

    check(vecC == vec2[float32](41543234.9128'f32, 23129301.1392'f32))
    check(vecD == vec2[float32](41543234.9128'f32, 49230420.1029'f32))
    check(vecE == vec2[float32](123'f32, 456'f32))

suite "vec3":
  test "equality":
    var
      vecA = vec3(333416892.8447f, 333416892.8447f, 333416892.8447f)
      vecB = vec3(333416892.8447f)

    check((vecA == vecB) != (vecB != vecA))

    vecA *= 6.7f
    vecB *= 6.7

    check((vecA == vecB) != (vecB != vecA))

  test "size":
    var
      vecA = vec3[float32](1140853155.4688)
      vecB = vec3[float64](213123387435839.9354)
      vecC = vec3[int8](127'i8)
      vecD = vec3[int16](32767'i16)
      vecE = vec3[int32](2147483647)

    check(vecA.sizeof == float32.sizeof * 3)
    check(vecB.sizeof == float64.sizeof * 3)
    check(vecC.sizeof == int8.sizeof * 3)
    check(vecD.sizeof == int16.sizeof * 3)
    check(vecE.sizeof == int32.sizeof * 3)

  test "convertion":
    let k = @[123'f32, 456'f32, 78'f32]
    var
      vecA = vec1[float32](41543234.3183'f32)
      vecB = vec2[float32](12390190.9012'f32, 42392799.3782'f32)
      vecC = vec3[float32](vecA, 158914129.8123'f32, 13281239123'f32)
      vecD = vec3[float32](vecB, 891239021.1289'f32)
      vecE = vec3[float32](k)

    check(vecC == vec3[float32](41543234.3183'f32, 158914129.8123'f32, 13281239123'f32))
    check(vecD == vec3[float32](12390190.9012'f32, 42392799.3782'f32, 891239021.1289'f32))
    check(vecE == vec3[float32](123'f32, 456'f32, 78'f32))

suite "vec4":
  test "equality":
    var
      vecA = vec4(333416892.8447f, 333416892.8447f, 333416892.8447f, 333416892.8447f)
      vecB = vec4(333416892.8447f)

    check((vecA == vecB) != (vecB != vecA))

    vecA *= 6.7f
    vecB *= 6.7

    check((vecA == vecB) != (vecB != vecA))

  test "size":
    var
      vecA = vec4[float32](1140853155.4688)
      vecB = vec4[float64](213123387435839.9354)
      vecC = vec4[int8](127'i8)
      vecD = vec4[int16](32767'i16)
      vecE = vec4[int32](2147483647)

    check(vecA.sizeof == float32.sizeof * 4)
    check(vecB.sizeof == float64.sizeof * 4)
    check(vecC.sizeof == int8.sizeof * 4)
    check(vecD.sizeof == int16.sizeof * 4)
    check(vecE.sizeof == int32.sizeof * 4)

  test "convertion":
    let k = @[123'f32, 456'f32, 78'f32, 1345'f32]
    var
      vecA = vec1[float32](41543234.3183'f32)
      vecB = vec2[float32](12390190.9012'f32, 42392799.3782'f32)
      vecC = vec3[float32](58131013.9138'f32, 158914129.8123'f32, 13281239123'f32)
      vecD = vec4[float32](vecA, 891239021.1289'f32, 1293123.21893'f32, 902131233.8142'f32)
      vecE = vec4[float32](vecB, 981231234.3128'f32, 9102931.4131'f32)
      vecF = vec4[float32](vecC, 211039139.9391'f32)
      vecG = vec4[float32](k)

    check(vecD == vec4[float32](41543234.3183'f32, 891239021.1289'f32, 1293123.21893'f32, 902131233.8142'f32))
    check(vecE == vec4[float32](12390190.9012'f32, 42392799.3782'f32, 981231234.3128'f32, 9102931.4131'f32))
    check(vecF == vec4[float32](58131013.9138'f32, 158914129.8123'f32, 13281239123'f32, 211039139.9391'f32))
    check(vecG == vec4[float32](123'f32, 456'f32, 78'f32, 1345'f32))
