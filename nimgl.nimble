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
    exec(r"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars32.bat")

proc subs(original: string, start: int, ending: int): string =
  ## Substring the string, because I don't have strutils here
  result = ""
  for w in countup(start, ending):
    result.add(original[w])

proc genDocs(path: string, output: string) =
  var src = path.subs(4, path.len - 5)
  echo "\nGenerating " & src & ".nim"
  exec("nim doc -o:" & output & "/" & src & ".html" & " " & path)

task docs, "Generate Documentation for all of the Library":
  for file in listFiles(srcDir):
    genDocs(file, docDir)
  for dir in listDirs(srcDir):
    for file in listFiles(dir):
      genDocs(file, docDir)