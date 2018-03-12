switch("path", "$projectDir/../src")
switch("debuginfo")
switch("debugger", "native")
when defined(windows):
  switch("cpu", "i386")