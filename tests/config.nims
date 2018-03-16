switch("path", "$projectDir/../src")
switch("debuginfo")
switch("debugger", "native")
#switch("d", "nimNoArrayToString")
when defined(windows):
  switch("cpu", "i386")