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

  assert a == b
  assert a * 2 == vec(2.0f, 4.0f, 6.0f, 8.0f)
  assert (a * 2) / 2 == b
  assert (a * 2) + (b * 3) == vec(5.0f, 10.0f, 15.0f, 20.0f)

main()
