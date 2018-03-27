# Tests

This tests purpose is to help check the stability of the bindings and to give some
example on how to use them on other projects. So feel free to checkthe tests and
learn on how to use them.

I still need to add more tests to test the stability of the bindings. Some bindings
depend on another bindings for certain functionality so expect some tests to contain
several bindings.

The general.nim file is used for development purposes and is not expected to be
stable or to work at all, to test the stability of the bindings for yourself
only use the nim files starting with a 't' or use ```nimble test``` on the root
folder to automaticly check the stability.

As this is a graphics library it needs some specific hardware that most of the
computers have but cannot test on some CI servers.

| file | purpose | CI |
|:----:|---------|:--:|
|tglfw | Check that glfw is initialized correctly and that a window opens | No |
|tmath | Check that the math library gives correct values and works properly | Yes |

More to come...
