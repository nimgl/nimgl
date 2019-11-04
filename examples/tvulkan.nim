# Written by Leonardo Mariscal <leo@ldmd.mx>, 2019

# TODO following vulkan-tutorial.com

import nimgl/vulkan, nimgl/glfw

var
  window: GLFWWindow
  instance: VkInstance

proc toString(chars: openArray[char]): string =
  result = ""
  for c in chars:
    if c != '\0':
      result.add(c)

proc initWindow() =
  if not glfwInit():
    quit("failed to init glfw")

  glfwWindowHint(GLFWClientApi, GLFWNoApi)
  glfwWindowHint(GLFWResizable, GLFWFalse)

  window = glfwCreateWindow(800, 600)

  if not vkInit():
    quit("failed to load vulkan")

proc loop() =
  while not window.windowShouldClose():
    glfwPollEvents()

proc cleanUp() =
  vkDestroyInstance(instance, nil)
  window.destroyWindow()
  glfwTerminate()

proc initVulkan() =
  var appInfo = newVkApplicationInfo(
    pApplicationName = "NimGL Vulkan Example",
    applicationVersion = vkMakeVersion(1, 0, 0),
    pEngineName = "No Engine",
    engineVersion = vkMakeVersion(1, 0, 0),
    apiVersion = vkApiVersion1_1
  )

  var glfwExtensionCount: uint32 = 0
  var glfwExtensions: cstringArray
  glfwExtensions = glfwGetRequiredInstanceExtensions(glfwExtensionCount.addr)

  var instanceCreateInfo = newVkInstanceCreateInfo(
    pApplicationInfo = appInfo.addr,
    enabledExtensionCount = glfwExtensionCount,
    ppEnabledExtensionNames = glfwExtensions,
    enabledLayerCount = 0,
    flags = 0.VkInstanceCreateFlags,
    ppEnabledLayerNames = nil,
  )

  if vkCreateInstance(instanceCreateInfo.addr, nil, instance.addr) != VKSuccess:
    quit("failed to create instance")

  var extensionCount: uint32 = 0
  discard vkEnumerateInstanceExtensionProperties(nil, extensionCount.addr, nil)
  var extensionsArray = newSeq[VkExtensionProperties](extensionCount)
  discard vkEnumerateInstanceExtensionProperties(nil, extensionCount.addr, extensionsArray[0].addr)

  for extension in extensionsArray:
    echo extension.extensionName.toString()

if isMainModule:
  initWindow()
  initVulkan()
  loop()
  cleanUp()
