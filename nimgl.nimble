# Package

version     = "0.1.0"
author      = "Leonardo Mariscal"
description = "Nim Game Library"
license     = "MIT"
srcDir      = "src"

# Dependencies

requires "nim >= 0.18.0"

# Tasks

const
  docDir = "docs"

before test:
  when defined(vcc):
    echo("Installing Visual Studio Variables")
    #exec(r"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars32.bat")

proc genDocs(path: string, output: string, index: bool) =
  var src = path[4 .. path.len - 5]
  echo "\nGenerating " & src & ".nim"
  exec("nim doc -o:" & output & (if index: ("/index.html ") else: ("/" & src & ".html" & " ")) & path)

task docs, "Generate Documentation for all of the Library":
  for file in listFiles(srcDir):
    genDocs(file, docDir, if file == "src\\nimgl.nim" or file == "src/nimgl.nim": true else: false)
  for dir in listDirs(srcDir):
    for file in listFiles(dir):
      genDocs(file, docDir, false)