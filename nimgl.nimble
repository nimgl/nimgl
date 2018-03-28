# Package

version     = "0.0.2"
author      = "Leonardo Mariscal"
description = "Nim Game Library"
license     = "MIT"
srcDir      = "src"
skipDirs    = @["tools", ".vscode"]

# Dependencies

requires "nim >= 0.18.0"

# Tasks

const
  docDir = "docs"

before test:
  when defined(vcc):
    echo("Installing Visual Studio Variables")
    exec(r"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars32.bat")

proc nimExt(file: string): bool =
  var ext = ".nim"
  for n in 0 ..< ext.len:
    if file[file.len - (n + 1)] != ext[ext.len - (n + 1)]:
      return false
  return true

proc genDocs(path: string, output: string) =
  var src = path[4 .. path.len - 5]
  echo "\nGenerating " & src & ".nim"
  exec("nim doc -o:" & output & "/" & src & ".html" & " " & path)

task test, "test stuff under tests dir":
  for file in listFiles("tests"):
    if file[6] == 't' and file.nimExt:
      exec("nim c -r " & file)

task general, "run tests/general.nim which is the general test for dev":
  exec("nim c -r tests/general.nim")

task docs, "Generate Documentation for all of the Library":
  genDocs("src/nimgl.nim", docDir)
  for dir in listDirs(srcDir):
    for file in listFiles(dir):
      if file.nimExt:
        genDocs(file, docDir)
