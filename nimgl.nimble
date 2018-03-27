# Package

version     = "0.0.1"
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

proc genDocs(path: string, output: string) =
  var src = path[4 .. path.len - 5]
  echo "\nGenerating " & src & ".nim"
  exec("nim doc -o:" & output & "/" & src & ".html" & " " & path)

task docs, "Generate Documentation for all of the Library":
  genDocs("src/nimgl.nim", docDir)
  for dir in listDirs(srcDir):
    for file in listFiles(dir):
      genDocs(file, docDir)
