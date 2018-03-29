# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## stb_image.h - Image loading/decoding library
## ====
## `return <../nimgl.html>`_.  
##
## Thanks to Nothings for this awesome library. This are some bindings to
## directly interact with the library. WIP
##
## You can always visit the original "doc" embeded in the header file to get
## a better idea `here <https://github.com/nothings/stb/blob/master/stb_image.h>`_.

# WIP

from os import splitPath

{.passC: "-DSTB_IMAGE_IMPLEMENTATION -I" & currentSourcePath().splitPath.head & "/private/stb",
  compile: "private/stb/stb_image.c"}
{.pragma: stb_image, cdecl, importc.}

type
  ImageData* = tuple
    width: int32
    height: int32
    channels: int32
    data: ptr char 

proc load*(filename: cstring, width, height, channels: ptr int32, components: int = 0): ptr char {.stb_image, importc: "stbi_load".}
  ## returns a pointer to the image requested, nil if nothind found.
  ## width and Height as you imagine are from the image
  ## channels, how many channels the image has 
  ##    1  grey
  ##    2  grey, alpha
  ##    3  red, green, blue
  ##    4  red, green, blue, alpha
  ## components, define if you require some especific number of channels. If 0
  ## uses the number of channels the image has.

proc load*(filename: cstring, width, height, channels: var int32, components: int = 0): ptr char =
  ## a utility to use normal integers instead o having to pass the addresses
  ## more info in the original proc
  load(filename, width.addr, height.addr, channels.addr, components)

proc load*(filename: cstring): ImageData =
  ## a utility to only give the filename and get a tupple with all the data
  #3 more info in the original proc
  result.data = load(filename, result.width.addr, result.height.addr, result.channels.addr)

proc image_free*(data: ptr char): void {.stb_image, importc: "stbi_image_free".}
  ## frees the data, loaded from stbi_load

proc set_flip_vertically_on_load*(state: bool): void {.stb_image, importc: "stbi_set_flip_vertically_on_load".}
  ## flip the image vertically, so the first pixel in the output array is the bottom left
