# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

import
  nimgl/math

# Just created the file with some simple asserts, please add more if you can
# make them as complex as you can, if a good test should have +1k lines
proc main =
  var
    a = vec(1.0f, 2.0f, 3.0f, 4.0f)
    b = vec(1.0f, 2.0f, 3.0f, 4.0f)
    ar = [2.0f, 4.0f, 8.0f]
    av = vec(2.0f, 4.0f, 8.0f)
    avr = vec(ar)
    s = @[3.0f, 9.0f, 12.0f, 15.0f]
    sv = vec4(s)
    zv = vec3(1.0f)
    sqt = vec(4.0f, 9.0f, 16.0f, 25.0f)
    svt = vec(-20f, 0f, 10f, 0.01f)
    eq = vec(2f, 4f, 8f, 16f)

  assert a == b
  assert a * 2 == vec(2.0f, 4.0f, 6.0f, 8.0f)
  assert (a * 2) / 2 == b
  assert a + (b * 3) == vec(4.0f, 8.0f, 12.0f, 16.0f)
  assert (a * 4) / 2 == vec(2.0f, 4.0f, 6.0f, 8.0f)
  assert a - b == vec(0.0f, 0.0f, 0.0f, 0.0f)
  var ln: float32 = 0.519002950192582399
  assert a / ln == vec(1.0f / ln, 2.0f / ln, 3.0f / ln, 4.0f / ln)
  assert av == ar
  assert av == avr
  assert ar == avr
  assert sqt.sqrt == vec(2.0f, 3.0f, 4.0f, 5.0f)
  eq *= 2
  echo eq
  assert vec(4f, 8f, 16f, 32f) == eq
  echo svt.ceil()

main()
