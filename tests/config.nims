switch("path", "$projectDir/../src")
switch("debuginfo")
switch("debugger", "native")
switch("d", "imguiDLL")
when defined(windows):
  switch("cpu", "i386")