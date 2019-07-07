# Package

version     = "1.0.0" # pre-pre^100 1.0
author      = "Leonardo Mariscal"
description = "Nim Game Library"
license     = "MIT"
srcDir      = "src"
skipDirs    = @[".circleci", ".github", "examples"]

# Dependencies

requires "nim >= 0.18.0"

# Tasks

import
  strutils

const
  docDir = "docs"

proc nimExt(file: string): bool =
  file[file.len - 4 ..< file.len] == ".nim"

proc genDocs(pathr: string, output: string) =
  var
    path = pathr.replace(r"\", "/")
    src = path[path.rfind("/") + 1 .. path.len - 5]
  echo "\n[info] generating " & src & ".nim"

  if src == "nimgl":
    src = "index"
  exec("nim doc -o:" & output & "/" & src & ".html" & " " & path)

proc walkRecursive(dir: string) =
  for f in listFiles(dir):
    if f.nimExt: genDocs(f, docDir)
  for od in listDirs(dir):
    walkRecursive(od)

task test, "test stuff under examples dir":
  exec("nimble install -y glm")
  for file in listFiles("examples"):
    if file[9] == 't' and file.nimExt:
      echo "\n[info] testing " & file[6..<file.len]
      #exec("nim c --verbosity:0 --hints:off -r " & file)
      exec("nim c -d:opengl_debug " & file)

task general, "run examples/general.nim which is the general test for dev":
  exec("nim c -r -d:opengl_debug examples/timgui.nim")

task docs, "Generate Documentation for all of the Library":
  walkRecursive(srcDir)
