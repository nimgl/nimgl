# Package

version     = "1.0.0"
author      = "Leonardo Mariscal"
description = "Nim Game Library"
license     = "MIT"
srcDir      = "src"
skipDirs    = @[".github", "tests"]

# Dependencies

requires "nim >= 1.0.0"

# Tasks

import
  strutils

const
  docDir = "docs"

proc nimExt(file: string): bool =
  file[file.len - 4 ..< file.len] == ".nim"

proc genDocs(pathr: string, output: string) =
  let path = pathr.replace(r"\", "/")
  var src = path[path.rfind("/") + 1 .. path.len - 5]
  echo "\n[info] generating " & src & ".nim"
  if src == "nimgl":
    src = "index"
  exec("nim doc -d:vulkan -o:" & output & "/" & src & ".html" & " " & path)

proc walkRecursive(dir: string) =
  for f in listFiles(dir):
    if f.nimExt: genDocs(f, docDir)
  for od in listDirs(dir):
    walkRecursive(od)

task test, "Run files under examples dir":
  exec("nimble install -y glm")
  for file in listFiles("examples"):
    if file[6] == 't' and file.nimExt:
      echo "\n[info] testing " & file[6..<file.len]
      exec("nim c -d:opengl_debug " & file)

task docs, "Generate documentation for all of the library":
  walkRecursive(srcDir)
