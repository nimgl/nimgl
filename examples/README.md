## Examples

This examples purpose is to help check the stability of the bindings and to give some example on
how to use them on other projects. So feel free to check the tests and learn on how to use them.

I still need to add more examples to test the stability of the bindings. Some bindings depend on
another bindings for certain functionality so expect some tests to contain several bindings.

As this is a graphics library it needs some specific hardware that most of the computers have but
cannot test on some CI servers. In the future it would be nice to implement the CI service with
Xvfb. All the tests go through the CI by compiling them but they are not tested in execution.

### Which examples are integrated

| File        | Purpose                                               | CI  |
|-------------|-------------------------------------------------------|-----|
| tglfw.nim   | GLFW is initialized correctly and that a window opens | :x: |
| topengl.nim | OpenGL bindings work and give out correct data        | :x: |
| timgui.nim  | ImGui actually build and display demo window          | :x: |
| tvulkan.nim | Vulkan bindings work                                  | :x: |

###### More to come...
