# Copyright (C) CavariuX. License on the root folder.
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## Glew Bindings - An OpenGL loading Library
## ====
## `return <../nimgl.html>`_.  
##
## There are too many procedures and constants, please run while you can
## but if you want to kill the monster you can add the procedures you still need
## you can use `https://docs.gl/<https://docs.gl/>`_ to get references of how every
## procedure works.
##
## Or if you want `the official docs<https://www.khronos.org/registry/OpenGL-Refpages/gl4/>`_

from os import splitPath

proc getHeaderPath(): string {.compileTime.} =
  result = currentSourcePath()
  result = result.splitPath.head & "/private/glew/include/GL"
  echo result

{.passC: "-DGLEW_NO_GLU -DGLEW_BUILD -DGLEW_STATIC -I" & getHeaderPath().}

when defined(glewDLL):
  when defined(windows):
    const
      glew_dll* = "glew32.dll"
  elif defined(macosx):
    const
      glew_dll* = "libglew.dylib"
  else:
    const
      glew_dll* = "libglew.so"
  {.pragma: glew_lib, dynlib: glew_dll, cdecl, header: "<glew.h>".}
else:
  {.compile: "private/glew/src/glew.c"}
  {.pragma: glew_lib, cdecl, header: "<glew.h>".}

# Types

type
  glBitfield*       = cuint
  glBoolean*        = bool
  glByte*           = int8
  glChar*           = cchar
  glChararb*        = byte
  glClampd*         = float64
  glClampf*         = cfloat
  glClampx*         = cint
  glDouble*         = float64
  glEglimageoes*    = distinct pointer
  glEnum*           = cuint
  glFixed*          = cint
  glFloat*          = cfloat
  glHalf*           = uint16
  glHalfarb*        = uint16
  glHalfnv*         = uint16
  glHandlearb*      = cuint
  glInt*            = cint
  glInt64*          = int64
  glInt64ext*       = int64
  glIntptr*         = cint
  glIntptrarb*      = cint
  glShort*          = int16
  glSizei*          = cint
  glSizeiptr*       = cint
  glSizeiptrarb*    = cint
  glSync*           = distinct pointer
  glUbyte*          = uint8
  glUint*           = cuint
  glUint64*         = uint64
  glUint64ext*      = uint64
  glUshort*         = uint16
  glVdpausurfacenv* = cint
  glVoid*           = pointer

# Constants / Enums

const
  GL_ZERO*: glEnum = 0
  GL_FALSE*: glEnum = 0
  GL_LOGIC_OP*: glEnum = 0x0BF1
  GL_NONE*: glEnum = 0
  GL_TEXTURE_COMPONENTS*: glEnum = 0x1003
  GL_NO_ERROR*: glEnum = 0
  GL_POINTS*: glEnum = 0x0000
  GL_CURRENT_BIT*: glEnum = 0x00000001
  GL_TRUE*: glEnum = 1
  GL_ONE*: glEnum = 1
  GL_CLIENT_PIXEL_STORE_BIT*: glEnum = 0x00000001
  GL_LINES*: glEnum = 0x0001
  GL_LINE_LOOP*: glEnum = 0x0002
  GL_POINT_BIT*: glEnum = 0x00000002
  GL_CLIENT_VERTEX_ARRAY_BIT*: glEnum = 0x00000002
  GL_LINE_STRIP*: glEnum = 0x0003
  GL_LINE_BIT*: glEnum = 0x00000004
  GL_TRIANGLES*: glEnum = 0x0004
  GL_TRIANGLE_STRIP*: glEnum = 0x0005
  GL_TRIANGLE_FAN*: glEnum = 0x0006
  GL_QUADS*: glEnum = 0x0007
  GL_QUAD_STRIP*: glEnum = 0x0008
  GL_POLYGON_BIT*: glEnum = 0x00000008
  GL_POLYGON*: glEnum = 0x0009
  GL_POLYGON_STIPPLE_BIT*: glEnum = 0x00000010
  GL_PIXEL_MODE_BIT*: glEnum = 0x00000020
  GL_LIGHTING_BIT*: glEnum = 0x00000040
  GL_FOG_BIT*: glEnum = 0x00000080
  GL_DEPTH_BUFFER_BIT*: glEnum = 0x00000100
  GL_ACCUM*: glEnum = 0x0100
  GL_LOAD*: glEnum = 0x0101
  GL_RETURN*: glEnum = 0x0102
  GL_MULT*: glEnum = 0x0103
  GL_ADD*: glEnum = 0x0104
  GL_NEVER*: glEnum = 0x0200
  GL_ACCUM_BUFFER_BIT*: glEnum = 0x00000200
  GL_LESS*: glEnum = 0x0201
  GL_EQUAL*: glEnum = 0x0202
  GL_LEQUAL*: glEnum = 0x0203
  GL_GREATER*: glEnum = 0x0204
  GL_NOTEQUAL*: glEnum = 0x0205
  GL_GEQUAL*: glEnum = 0x0206
  GL_ALWAYS*: glEnum = 0x0207
  GL_SRC_COLOR*: glEnum = 0x0300
  GL_ONE_MINUS_SRC_COLOR*: glEnum = 0x0301
  GL_SRC_ALPHA*: glEnum = 0x0302
  GL_ONE_MINUS_SRC_ALPHA*: glEnum = 0x0303
  GL_DST_ALPHA*: glEnum = 0x0304
  GL_ONE_MINUS_DST_ALPHA*: glEnum = 0x0305
  GL_DST_COLOR*: glEnum = 0x0306
  GL_ONE_MINUS_DST_COLOR*: glEnum = 0x0307
  GL_SRC_ALPHA_SATURATE*: glEnum = 0x0308
  GL_STENCIL_BUFFER_BIT*: glEnum = 0x00000400
  GL_FRONT_LEFT*: glEnum = 0x0400
  GL_FRONT_RIGHT*: glEnum = 0x0401
  GL_BACK_LEFT*: glEnum = 0x0402
  GL_BACK_RIGHT*: glEnum = 0x0403
  GL_FRONT*: glEnum = 0x0404
  GL_BACK*: glEnum = 0x0405
  GL_LEFT*: glEnum = 0x0406
  GL_RIGHT*: glEnum = 0x0407
  GL_FRONT_AND_BACK*: glEnum = 0x0408
  GL_AUX0*: glEnum = 0x0409
  GL_AUX1*: glEnum = 0x040A
  GL_AUX2*: glEnum = 0x040B
  GL_AUX3*: glEnum = 0x040C
  GL_INVALID_ENUM*: glEnum = 0x0500
  GL_INVALID_VALUE*: glEnum = 0x0501
  GL_INVALID_OPERATION*: glEnum = 0x0502
  GL_STACK_OVERFLOW*: glEnum = 0x0503
  GL_STACK_UNDERFLOW*: glEnum = 0x0504
  GL_OUT_OF_MEMORY*: glEnum = 0x0505
  GL_2D*: glEnum = 0x0600
  GL_3D*: glEnum = 0x0601
  GL_3D_COLOR*: glEnum = 0x0602
  GL_3D_COLOR_TEXTURE*: glEnum = 0x0603
  GL_4D_COLOR_TEXTURE*: glEnum = 0x0604
  GL_PASS_THROUGH_TOKEN*: glEnum = 0x0700
  GL_POINT_TOKEN*: glEnum = 0x0701
  GL_LINE_TOKEN*: glEnum = 0x0702
  GL_POLYGON_TOKEN*: glEnum = 0x0703
  GL_BITMAP_TOKEN*: glEnum = 0x0704
  GL_DRAW_PIXEL_TOKEN*: glEnum = 0x0705
  GL_COPY_PIXEL_TOKEN*: glEnum = 0x0706
  GL_LINE_RESET_TOKEN*: glEnum = 0x0707
  GL_EXP*: glEnum = 0x0800
  GL_VIEWPORT_BIT*: glEnum = 0x00000800
  GL_EXP2*: glEnum = 0x0801
  GL_CW*: glEnum = 0x0900
  GL_CCW*: glEnum = 0x0901
  GL_COEFF*: glEnum = 0x0A00
  GL_ORDER*: glEnum = 0x0A01
  GL_DOMAIN*: glEnum = 0x0A02
  GL_CURRENT_COLOR*: glEnum = 0x0B00
  GL_CURRENT_INDEX*: glEnum = 0x0B01
  GL_CURRENT_NORMAL*: glEnum = 0x0B02
  GL_CURRENT_TEXTURE_COORDS*: glEnum = 0x0B03
  GL_CURRENT_RASTER_COLOR*: glEnum = 0x0B04
  GL_CURRENT_RASTER_INDEX*: glEnum = 0x0B05
  GL_CURRENT_RASTER_TEXTURE_COORDS*: glEnum = 0x0B06
  GL_CURRENT_RASTER_POSITION*: glEnum = 0x0B07
  GL_CURRENT_RASTER_POSITION_VALID*: glEnum = 0x0B08
  GL_CURRENT_RASTER_DISTANCE*: glEnum = 0x0B09
  GL_POINT_SMOOTH*: glEnum = 0x0B10
  GL_POINT_SIZE*: glEnum = 0x0B11
  GL_POINT_SIZE_RANGE*: glEnum = 0x0B12
  GL_POINT_SIZE_GRANULARITY*: glEnum = 0x0B13
  GL_LINE_SMOOTH*: glEnum = 0x0B20
  GL_LINE_WIDTH*: glEnum = 0x0B21
  GL_LINE_WIDTH_RANGE*: glEnum = 0x0B22
  GL_LINE_WIDTH_GRANULARITY*: glEnum = 0x0B23
  GL_LINE_STIPPLE*: glEnum = 0x0B24
  GL_LINE_STIPPLE_PATTERN*: glEnum = 0x0B25
  GL_LINE_STIPPLE_REPEAT*: glEnum = 0x0B26
  GL_LIST_MODE*: glEnum = 0x0B30
  GL_MAX_LIST_NESTING*: glEnum = 0x0B31
  GL_LIST_BASE*: glEnum = 0x0B32
  GL_LIST_INDEX*: glEnum = 0x0B33
  GL_POLYGON_MODE*: glEnum = 0x0B40
  GL_POLYGON_SMOOTH*: glEnum = 0x0B41
  GL_POLYGON_STIPPLE*: glEnum = 0x0B42
  GL_EDGE_FLAG*: glEnum = 0x0B43
  GL_CULL_FACE*: glEnum = 0x0B44
  GL_CULL_FACE_MODE*: glEnum = 0x0B45
  GL_FRONT_FACE*: glEnum = 0x0B46
  GL_LIGHTING*: glEnum = 0x0B50
  GL_LIGHT_MODEL_LOCAL_VIEWER*: glEnum = 0x0B51
  GL_LIGHT_MODEL_TWO_SIDE*: glEnum = 0x0B52
  GL_LIGHT_MODEL_AMBIENT*: glEnum = 0x0B53
  GL_SHADE_MODEL*: glEnum = 0x0B54
  GL_COLOR_MATERIAL_FACE*: glEnum = 0x0B55
  GL_COLOR_MATERIAL_PARAMETER*: glEnum = 0x0B56
  GL_COLOR_MATERIAL*: glEnum = 0x0B57
  GL_FOG*: glEnum = 0x0B60
  GL_FOG_INDEX*: glEnum = 0x0B61
  GL_FOG_DENSITY*: glEnum = 0x0B62
  GL_FOG_START*: glEnum = 0x0B63
  GL_FOG_END*: glEnum = 0x0B64
  GL_FOG_MODE*: glEnum = 0x0B65
  GL_FOG_COLOR*: glEnum = 0x0B66
  GL_DEPTH_RANGE*: glEnum = 0x0B70
  GL_DEPTH_TEST*: glEnum = 0x0B71
  GL_DEPTH_WRITEMASK*: glEnum = 0x0B72
  GL_DEPTH_CLEAR_VALUE*: glEnum = 0x0B73
  GL_DEPTH_FUNC*: glEnum = 0x0B74
  GL_ACCUM_CLEAR_VALUE*: glEnum = 0x0B80
  GL_STENCIL_TEST*: glEnum = 0x0B90
  GL_STENCIL_CLEAR_VALUE*: glEnum = 0x0B91
  GL_STENCIL_FUNC*: glEnum = 0x0B92
  GL_STENCIL_VALUE_MASK*: glEnum = 0x0B93
  GL_STENCIL_FAIL*: glEnum = 0x0B94
  GL_STENCIL_PASS_DEPTH_FAIL*: glEnum = 0x0B95
  GL_STENCIL_PASS_DEPTH_PASS*: glEnum = 0x0B96
  GL_STENCIL_REF*: glEnum = 0x0B97
  GL_STENCIL_WRITEMASK*: glEnum = 0x0B98
  GL_MATRIX_MODE*: glEnum = 0x0BA0
  GL_NORMALIZE*: glEnum = 0x0BA1
  GL_VIEWPORT*: glEnum = 0x0BA2
  GL_MODELVIEW_STACK_DEPTH*: glEnum = 0x0BA3
  GL_PROJECTION_STACK_DEPTH*: glEnum = 0x0BA4
  GL_TEXTURE_STACK_DEPTH*: glEnum = 0x0BA5
  GL_MODELVIEW_MATRIX*: glEnum = 0x0BA6
  GL_PROJECTION_MATRIX*: glEnum = 0x0BA7
  GL_TEXTURE_MATRIX*: glEnum = 0x0BA8
  GL_ATTRIB_STACK_DEPTH*: glEnum = 0x0BB0
  GL_CLIENT_ATTRIB_STACK_DEPTH*: glEnum = 0x0BB1
  GL_ALPHA_TEST*: glEnum = 0x0BC0
  GL_ALPHA_TEST_FUNC*: glEnum = 0x0BC1
  GL_ALPHA_TEST_REF*: glEnum = 0x0BC2
  GL_DITHER*: glEnum = 0x0BD0
  GL_BLEND_DST*: glEnum = 0x0BE0
  GL_BLEND_SRC*: glEnum = 0x0BE1
  GL_BLEND*: glEnum = 0x0BE2
  GL_LOGIC_OP_MODE*: glEnum = 0x0BF0
  GL_INDEX_LOGIC_OP*: glEnum = 0x0BF1
  GL_COLOR_LOGIC_OP*: glEnum = 0x0BF2
  GL_AUX_BUFFERS*: glEnum = 0x0C00
  GL_DRAW_BUFFER*: glEnum = 0x0C01
  GL_READ_BUFFER*: glEnum = 0x0C02
  GL_SCISSOR_BOX*: glEnum = 0x0C10
  GL_SCISSOR_TEST*: glEnum = 0x0C11
  GL_INDEX_CLEAR_VALUE*: glEnum = 0x0C20
  GL_INDEX_WRITEMASK*: glEnum = 0x0C21
  GL_COLOR_CLEAR_VALUE*: glEnum = 0x0C22
  GL_COLOR_WRITEMASK*: glEnum = 0x0C23
  GL_INDEX_MODE*: glEnum = 0x0C30
  GL_RGBA_MODE*: glEnum = 0x0C31
  GL_DOUBLEBUFFER*: glEnum = 0x0C32
  GL_STEREO*: glEnum = 0x0C33
  GL_RENDER_MODE*: glEnum = 0x0C40
  GL_PERSPECTIVE_CORRECTION_HINT*: glEnum = 0x0C50
  GL_POINT_SMOOTH_HINT*: glEnum = 0x0C51
  GL_LINE_SMOOTH_HINT*: glEnum = 0x0C52
  GL_POLYGON_SMOOTH_HINT*: glEnum = 0x0C53
  GL_FOG_HINT*: glEnum = 0x0C54
  GL_TEXTURE_GEN_S*: glEnum = 0x0C60
  GL_TEXTURE_GEN_T*: glEnum = 0x0C61
  GL_TEXTURE_GEN_R*: glEnum = 0x0C62
  GL_TEXTURE_GEN_Q*: glEnum = 0x0C63
  GL_PIXEL_MAP_I_TO_I*: glEnum = 0x0C70
  GL_PIXEL_MAP_S_TO_S*: glEnum = 0x0C71
  GL_PIXEL_MAP_I_TO_R*: glEnum = 0x0C72
  GL_PIXEL_MAP_I_TO_G*: glEnum = 0x0C73
  GL_PIXEL_MAP_I_TO_B*: glEnum = 0x0C74
  GL_PIXEL_MAP_I_TO_A*: glEnum = 0x0C75
  GL_PIXEL_MAP_R_TO_R*: glEnum = 0x0C76
  GL_PIXEL_MAP_G_TO_G*: glEnum = 0x0C77
  GL_PIXEL_MAP_B_TO_B*: glEnum = 0x0C78
  GL_PIXEL_MAP_A_TO_A*: glEnum = 0x0C79
  GL_PIXEL_MAP_I_TO_I_SIZE*: glEnum = 0x0CB0
  GL_PIXEL_MAP_S_TO_S_SIZE*: glEnum = 0x0CB1
  GL_PIXEL_MAP_I_TO_R_SIZE*: glEnum = 0x0CB2
  GL_PIXEL_MAP_I_TO_G_SIZE*: glEnum = 0x0CB3
  GL_PIXEL_MAP_I_TO_B_SIZE*: glEnum = 0x0CB4
  GL_PIXEL_MAP_I_TO_A_SIZE*: glEnum = 0x0CB5
  GL_PIXEL_MAP_R_TO_R_SIZE*: glEnum = 0x0CB6
  GL_PIXEL_MAP_G_TO_G_SIZE*: glEnum = 0x0CB7
  GL_PIXEL_MAP_B_TO_B_SIZE*: glEnum = 0x0CB8
  GL_PIXEL_MAP_A_TO_A_SIZE*: glEnum = 0x0CB9
  GL_UNPACK_SWAP_BYTES*: glEnum = 0x0CF0
  GL_UNPACK_LSB_FIRST*: glEnum = 0x0CF1
  GL_UNPACK_ROW_LENGTH*: glEnum = 0x0CF2
  GL_UNPACK_SKIP_ROWS*: glEnum = 0x0CF3
  GL_UNPACK_SKIP_PIXELS*: glEnum = 0x0CF4
  GL_UNPACK_ALIGNMENT*: glEnum = 0x0CF5
  GL_PACK_SWAP_BYTES*: glEnum = 0x0D00
  GL_PACK_LSB_FIRST*: glEnum = 0x0D01
  GL_PACK_ROW_LENGTH*: glEnum = 0x0D02
  GL_PACK_SKIP_ROWS*: glEnum = 0x0D03
  GL_PACK_SKIP_PIXELS*: glEnum = 0x0D04
  GL_PACK_ALIGNMENT*: glEnum = 0x0D05
  GL_MAP_COLOR*: glEnum = 0x0D10
  GL_MAP_STENCIL*: glEnum = 0x0D11
  GL_INDEX_SHIFT*: glEnum = 0x0D12
  GL_INDEX_OFFSET*: glEnum = 0x0D13
  GL_RED_SCALE*: glEnum = 0x0D14
  GL_RED_BIAS*: glEnum = 0x0D15
  GL_ZOOM_X*: glEnum = 0x0D16
  GL_ZOOM_Y*: glEnum = 0x0D17
  GL_GREEN_SCALE*: glEnum = 0x0D18
  GL_GREEN_BIAS*: glEnum = 0x0D19
  GL_BLUE_SCALE*: glEnum = 0x0D1A
  GL_BLUE_BIAS*: glEnum = 0x0D1B
  GL_ALPHA_SCALE*: glEnum = 0x0D1C
  GL_ALPHA_BIAS*: glEnum = 0x0D1D
  GL_DEPTH_SCALE*: glEnum = 0x0D1E
  GL_DEPTH_BIAS*: glEnum = 0x0D1F
  GL_MAX_EVAL_ORDER*: glEnum = 0x0D30
  GL_MAX_LIGHTS*: glEnum = 0x0D31
  GL_MAX_CLIP_PLANES*: glEnum = 0x0D32
  GL_MAX_TEXTURE_SIZE*: glEnum = 0x0D33
  GL_MAX_PIXEL_MAP_TABLE*: glEnum = 0x0D34
  GL_MAX_ATTRIB_STACK_DEPTH*: glEnum = 0x0D35
  GL_MAX_MODELVIEW_STACK_DEPTH*: glEnum = 0x0D36
  GL_MAX_NAME_STACK_DEPTH*: glEnum = 0x0D37
  GL_MAX_PROJECTION_STACK_DEPTH*: glEnum = 0x0D38
  GL_MAX_TEXTURE_STACK_DEPTH*: glEnum = 0x0D39
  GL_MAX_VIEWPORT_DIMS*: glEnum = 0x0D3A
  GL_MAX_CLIENT_ATTRIB_STACK_DEPTH*: glEnum = 0x0D3B
  GL_SUBPIXEL_BITS*: glEnum = 0x0D50
  GL_INDEX_BITS*: glEnum = 0x0D51
  GL_RED_BITS*: glEnum = 0x0D52
  GL_GREEN_BITS*: glEnum = 0x0D53
  GL_BLUE_BITS*: glEnum = 0x0D54
  GL_ALPHA_BITS*: glEnum = 0x0D55
  GL_DEPTH_BITS*: glEnum = 0x0D56
  GL_STENCIL_BITS*: glEnum = 0x0D57
  GL_ACCUM_RED_BITS*: glEnum = 0x0D58
  GL_ACCUM_GREEN_BITS*: glEnum = 0x0D59
  GL_ACCUM_BLUE_BITS*: glEnum = 0x0D5A
  GL_ACCUM_ALPHA_BITS*: glEnum = 0x0D5B
  GL_NAME_STACK_DEPTH*: glEnum = 0x0D70
  GL_AUTO_NORMAL*: glEnum = 0x0D80
  GL_MAP1_COLOR_4*: glEnum = 0x0D90
  GL_MAP1_INDEX*: glEnum = 0x0D91
  GL_MAP1_NORMAL*: glEnum = 0x0D92
  GL_MAP1_TEXTURE_COORD_1*: glEnum = 0x0D93
  GL_MAP1_TEXTURE_COORD_2*: glEnum = 0x0D94
  GL_MAP1_TEXTURE_COORD_3*: glEnum = 0x0D95
  GL_MAP1_TEXTURE_COORD_4*: glEnum = 0x0D96
  GL_MAP1_VERTEX_3*: glEnum = 0x0D97
  GL_MAP1_VERTEX_4*: glEnum = 0x0D98
  GL_MAP2_COLOR_4*: glEnum = 0x0DB0
  GL_MAP2_INDEX*: glEnum = 0x0DB1
  GL_MAP2_NORMAL*: glEnum = 0x0DB2
  GL_MAP2_TEXTURE_COORD_1*: glEnum = 0x0DB3
  GL_MAP2_TEXTURE_COORD_2*: glEnum = 0x0DB4
  GL_MAP2_TEXTURE_COORD_3*: glEnum = 0x0DB5
  GL_MAP2_TEXTURE_COORD_4*: glEnum = 0x0DB6
  GL_MAP2_VERTEX_3*: glEnum = 0x0DB7
  GL_MAP2_VERTEX_4*: glEnum = 0x0DB8
  GL_MAP1_GRID_DOMAIN*: glEnum = 0x0DD0
  GL_MAP1_GRID_SEGMENTS*: glEnum = 0x0DD1
  GL_MAP2_GRID_DOMAIN*: glEnum = 0x0DD2
  GL_MAP2_GRID_SEGMENTS*: glEnum = 0x0DD3
  GL_TEXTURE_1D*: glEnum = 0x0DE0
  GL_TEXTURE_2D*: glEnum = 0x0DE1
  GL_FEEDBACK_BUFFER_POINTER*: glEnum = 0x0DF0
  GL_FEEDBACK_BUFFER_SIZE*: glEnum = 0x0DF1
  GL_FEEDBACK_BUFFER_TYPE*: glEnum = 0x0DF2
  GL_SELECTION_BUFFER_POINTER*: glEnum = 0x0DF3
  GL_SELECTION_BUFFER_SIZE*: glEnum = 0x0DF4
  GL_TEXTURE_WIDTH*: glEnum = 0x1000
  GL_TRANSFORM_BIT*: glEnum = 0x00001000
  GL_TEXTURE_HEIGHT*: glEnum = 0x1001
  GL_TEXTURE_INTERNAL_FORMAT*: glEnum = 0x1003
  GL_TEXTURE_BORDER_COLOR*: glEnum = 0x1004
  GL_TEXTURE_BORDER*: glEnum = 0x1005
  GL_DONT_CARE*: glEnum = 0x1100
  GL_FASTEST*: glEnum = 0x1101
  GL_NICEST*: glEnum = 0x1102
  GL_AMBIENT*: glEnum = 0x1200
  GL_DIFFUSE*: glEnum = 0x1201
  GL_SPECULAR*: glEnum = 0x1202
  GL_POSITION*: glEnum = 0x1203
  GL_SPOT_DIRECTION*: glEnum = 0x1204
  GL_SPOT_EXPONENT*: glEnum = 0x1205
  GL_SPOT_CUTOFF*: glEnum = 0x1206
  GL_CONSTANT_ATTENUATION*: glEnum = 0x1207
  GL_LINEAR_ATTENUATION*: glEnum = 0x1208
  GL_QUADRATIC_ATTENUATION*: glEnum = 0x1209
  GL_COMPILE*: glEnum = 0x1300
  GL_COMPILE_AND_EXECUTE*: glEnum = 0x1301
  GL_UNSIGNED_BYTE*: glEnum = 0x1401
  GL_UNSIGNED_SHORT*: glEnum = 0x1403
  GL_UNSIGNED_INT*: glEnum = 0x1405
  GL_2_BYTES*: glEnum = 0x1407
  GL_3_BYTES*: glEnum = 0x1408
  GL_4_BYTES*: glEnum = 0x1409
  GL_CLEAR*: glEnum = 0x1500
  GL_AND*: glEnum = 0x1501
  GL_AND_REVERSE*: glEnum = 0x1502
  GL_COPY*: glEnum = 0x1503
  GL_AND_INVERTED*: glEnum = 0x1504
  GL_NOOP*: glEnum = 0x1505
  GL_XOR*: glEnum = 0x1506
  GL_OR*: glEnum = 0x1507
  GL_NOR*: glEnum = 0x1508
  GL_EQUIV*: glEnum = 0x1509
  GL_INVERT*: glEnum = 0x150A
  GL_OR_REVERSE*: glEnum = 0x150B
  GL_COPY_INVERTED*: glEnum = 0x150C
  GL_OR_INVERTED*: glEnum = 0x150D
  GL_NAND*: glEnum = 0x150E
  GL_SET*: glEnum = 0x150F
  GL_EMISSION*: glEnum = 0x1600
  GL_SHININESS*: glEnum = 0x1601
  GL_AMBIENT_AND_DIFFUSE*: glEnum = 0x1602
  GL_COLOR_INDEXES*: glEnum = 0x1603
  GL_MODELVIEW*: glEnum = 0x1700
  GL_PROJECTION*: glEnum = 0x1701
  GL_TEXTURE*: glEnum = 0x1702
  GL_COLOR*: glEnum = 0x1800
  GL_DEPTH*: glEnum = 0x1801
  GL_STENCIL*: glEnum = 0x1802
  GL_COLOR_INDEX*: glEnum = 0x1900
  GL_STENCIL_INDEX*: glEnum = 0x1901
  GL_DEPTH_COMPONENT*: glEnum = 0x1902
  GL_RED*: glEnum = 0x1903
  GL_GREEN*: glEnum = 0x1904
  GL_BLUE*: glEnum = 0x1905
  GL_ALPHA*: glEnum = 0x1906
  GL_RGB*: glEnum = 0x1907
  GL_RGBA*: glEnum = 0x1908
  GL_LUMINANCE*: glEnum = 0x1909
  GL_LUMINANCE_ALPHA*: glEnum = 0x190A
  GL_BITMAP*: glEnum = 0x1A00
  GL_POINT*: glEnum = 0x1B00
  GL_LINE*: glEnum = 0x1B01
  GL_FILL*: glEnum = 0x1B02
  GL_RENDER*: glEnum = 0x1C00
  GL_FEEDBACK*: glEnum = 0x1C01
  GL_SELECT*: glEnum = 0x1C02
  GL_FLAT*: glEnum = 0x1D00
  GL_SMOOTH*: glEnum = 0x1D01
  GL_KEEP*: glEnum = 0x1E00
  GL_REPLACE*: glEnum = 0x1E01
  GL_INCR*: glEnum = 0x1E02
  GL_DECR*: glEnum = 0x1E03
  GL_VENDOR*: glEnum = 0x1F00
  GL_RENDERER*: glEnum = 0x1F01
  GL_VERSION*: glEnum = 0x1F02
  GL_EXTENSIONS*: glEnum = 0x1F03
  GL_S*: glEnum = 0x2000
  GL_ENABLE_BIT*: glEnum = 0x00002000
  GL_T*: glEnum = 0x2001
  GL_R*: glEnum = 0x2002
  GL_Q*: glEnum = 0x2003
  GL_MODULATE*: glEnum = 0x2100
  GL_DECAL*: glEnum = 0x2101
  GL_TEXTURE_ENV_MODE*: glEnum = 0x2200
  GL_TEXTURE_ENV_COLOR*: glEnum = 0x2201
  GL_TEXTURE_ENV*: glEnum = 0x2300
  GL_EYE_LINEAR*: glEnum = 0x2400
  GL_OBJECT_LINEAR*: glEnum = 0x2401
  GL_SPHERE_MAP*: glEnum = 0x2402
  GL_TEXTURE_GEN_MODE*: glEnum = 0x2500
  GL_OBJECT_PLANE*: glEnum = 0x2501
  GL_EYE_PLANE*: glEnum = 0x2502
  GL_NEAREST*: glEnum = 0x2600
  GL_LINEAR*: glEnum = 0x2601
  GL_NEAREST_MIPMAP_NEAREST*: glEnum = 0x2700
  GL_LINEAR_MIPMAP_NEAREST*: glEnum = 0x2701
  GL_NEAREST_MIPMAP_LINEAR*: glEnum = 0x2702
  GL_LINEAR_MIPMAP_LINEAR*: glEnum = 0x2703
  GL_TEXTURE_MAG_FILTER*: glEnum = 0x2800
  GL_TEXTURE_MIN_FILTER*: glEnum = 0x2801
  GL_TEXTURE_WRAP_S*: glEnum = 0x2802
  GL_TEXTURE_WRAP_T*: glEnum = 0x2803
  GL_CLAMP*: glEnum = 0x2900
  GL_REPEAT*: glEnum = 0x2901
  GL_POLYGON_OFFSET_UNITS*: glEnum = 0x2A00
  GL_POLYGON_OFFSET_POINT*: glEnum = 0x2A01
  GL_POLYGON_OFFSET_LINE*: glEnum = 0x2A02
  GL_R3_G3_B2*: glEnum = 0x2A10
  GL_V2F*: glEnum = 0x2A20
  GL_V3F*: glEnum = 0x2A21
  GL_C4UB_V2F*: glEnum = 0x2A22
  GL_C4UB_V3F*: glEnum = 0x2A23
  GL_C3F_V3F*: glEnum = 0x2A24
  GL_N3F_V3F*: glEnum = 0x2A25
  GL_C4F_N3F_V3F*: glEnum = 0x2A26
  GL_T2F_V3F*: glEnum = 0x2A27
  GL_T4F_V4F*: glEnum = 0x2A28
  GL_T2F_C4UB_V3F*: glEnum = 0x2A29
  GL_T2F_C3F_V3F*: glEnum = 0x2A2A
  GL_T2F_N3F_V3F*: glEnum = 0x2A2B
  GL_T2F_C4F_N3F_V3F*: glEnum = 0x2A2C
  GL_T4F_C4F_N3F_V4F*: glEnum = 0x2A2D
  GL_CLIP_PLANE0*: glEnum = 0x3000
  GL_CLIP_PLANE1*: glEnum = 0x3001
  GL_CLIP_PLANE2*: glEnum = 0x3002
  GL_CLIP_PLANE3*: glEnum = 0x3003
  GL_CLIP_PLANE4*: glEnum = 0x3004
  GL_CLIP_PLANE5*: glEnum = 0x3005
  GL_LIGHT0*: glEnum = 0x4000
  GL_COLOR_BUFFER_BIT*: glEnum = 0x00004000
  GL_LIGHT1*: glEnum = 0x4001
  GL_LIGHT2*: glEnum = 0x4002
  GL_LIGHT3*: glEnum = 0x4003
  GL_LIGHT4*: glEnum = 0x4004
  GL_LIGHT5*: glEnum = 0x4005
  GL_LIGHT6*: glEnum = 0x4006
  GL_LIGHT7*: glEnum = 0x4007
  GL_HINT_BIT*: glEnum = 0x00008000
  GL_POLYGON_OFFSET_FILL*: glEnum = 0x8037
  GL_POLYGON_OFFSET_FACTOR*: glEnum = 0x8038
  GL_ALPHA4*: glEnum = 0x803B
  GL_ALPHA8*: glEnum = 0x803C
  GL_ALPHA12*: glEnum = 0x803D
  GL_ALPHA16*: glEnum = 0x803E
  GL_LUMINANCE4*: glEnum = 0x803F
  GL_LUMINANCE8*: glEnum = 0x8040
  GL_LUMINANCE12*: glEnum = 0x8041
  GL_LUMINANCE16*: glEnum = 0x8042
  GL_LUMINANCE4_ALPHA4*: glEnum = 0x8043
  GL_LUMINANCE6_ALPHA2*: glEnum = 0x8044
  GL_LUMINANCE8_ALPHA8*: glEnum = 0x8045
  GL_LUMINANCE12_ALPHA4*: glEnum = 0x8046
  GL_LUMINANCE12_ALPHA12*: glEnum = 0x8047
  GL_LUMINANCE16_ALPHA16*: glEnum = 0x8048
  GL_INTENSITY*: glEnum = 0x8049
  GL_INTENSITY4*: glEnum = 0x804A
  GL_INTENSITY8*: glEnum = 0x804B
  GL_INTENSITY12*: glEnum = 0x804C
  GL_INTENSITY16*: glEnum = 0x804D
  GL_RGB4*: glEnum = 0x804F
  GL_RGB5*: glEnum = 0x8050
  GL_RGB8*: glEnum = 0x8051
  GL_RGB10*: glEnum = 0x8052
  GL_RGB12*: glEnum = 0x8053
  GL_RGB16*: glEnum = 0x8054
  GL_RGBA2*: glEnum = 0x8055
  GL_RGBA4*: glEnum = 0x8056
  GL_RGB5_A1*: glEnum = 0x8057
  GL_RGBA8*: glEnum = 0x8058
  GL_RGB10_A2*: glEnum = 0x8059
  GL_RGBA12*: glEnum = 0x805A
  GL_RGBA16*: glEnum = 0x805B
  GL_TEXTURE_RED_SIZE*: glEnum = 0x805C
  GL_TEXTURE_GREEN_SIZE*: glEnum = 0x805D
  GL_TEXTURE_BLUE_SIZE*: glEnum = 0x805E
  GL_TEXTURE_ALPHA_SIZE*: glEnum = 0x805F
  GL_TEXTURE_LUMINANCE_SIZE*: glEnum = 0x8060
  GL_TEXTURE_INTENSITY_SIZE*: glEnum = 0x8061
  GL_PROXY_TEXTURE_1D*: glEnum = 0x8063
  GL_PROXY_TEXTURE_2D*: glEnum = 0x8064
  GL_TEXTURE_PRIORITY*: glEnum = 0x8066
  GL_TEXTURE_RESIDENT*: glEnum = 0x8067
  GL_TEXTURE_BINDING_1D*: glEnum = 0x8068
  GL_TEXTURE_BINDING_2D*: glEnum = 0x8069
  GL_VERTEX_ARRAY*: glEnum = 0x8074
  GL_NORMAL_ARRAY*: glEnum = 0x8075
  GL_COLOR_ARRAY*: glEnum = 0x8076
  GL_INDEX_ARRAY*: glEnum = 0x8077
  GL_TEXTURE_COORD_ARRAY*: glEnum = 0x8078
  GL_EDGE_FLAG_ARRAY*: glEnum = 0x8079
  GL_VERTEX_ARRAY_SIZE*: glEnum = 0x807A
  GL_VERTEX_ARRAY_TYPE*: glEnum = 0x807B
  GL_VERTEX_ARRAY_STRIDE*: glEnum = 0x807C
  GL_NORMAL_ARRAY_TYPE*: glEnum = 0x807E
  GL_NORMAL_ARRAY_STRIDE*: glEnum = 0x807F
  GL_COLOR_ARRAY_SIZE*: glEnum = 0x8081
  GL_COLOR_ARRAY_TYPE*: glEnum = 0x8082
  GL_COLOR_ARRAY_STRIDE*: glEnum = 0x8083
  GL_INDEX_ARRAY_TYPE*: glEnum = 0x8085
  GL_INDEX_ARRAY_STRIDE*: glEnum = 0x8086
  GL_TEXTURE_COORD_ARRAY_SIZE*: glEnum = 0x8088
  GL_TEXTURE_COORD_ARRAY_TYPE*: glEnum = 0x8089
  GL_TEXTURE_COORD_ARRAY_STRIDE*: glEnum = 0x808A
  GL_EDGE_FLAG_ARRAY_STRIDE*: glEnum = 0x808C
  GL_VERTEX_ARRAY_POINTER*: glEnum = 0x808E
  GL_NORMAL_ARRAY_POINTER*: glEnum = 0x808F
  GL_COLOR_ARRAY_POINTER*: glEnum = 0x8090
  GL_INDEX_ARRAY_POINTER*: glEnum = 0x8091
  GL_TEXTURE_COORD_ARRAY_POINTER*: glEnum = 0x8092
  GL_EDGE_FLAG_ARRAY_POINTER*: glEnum = 0x8093
  GL_COLOR_INDEX1_EXT*: glEnum = 0x80E2
  GL_COLOR_INDEX2_EXT*: glEnum = 0x80E3
  GL_COLOR_INDEX4_EXT*: glEnum = 0x80E4
  GL_COLOR_INDEX8_EXT*: glEnum = 0x80E5
  GL_COLOR_INDEX12_EXT*: glEnum = 0x80E6
  GL_COLOR_INDEX16_EXT*: glEnum = 0x80E7
  GL_EVAL_BIT*: glEnum = 0x00010000
  GL_LIST_BIT*: glEnum = 0x00020000
  GL_TEXTURE_BIT*: glEnum = 0x00040000
  GL_SCISSOR_BIT*: glEnum = 0x00080000
  GL_ALL_ATTRIB_BITS*: glEnum = 0x000fffff
  GLEW_OK*: glEnum = 0
  GLEW_NO_ERROR*: glEnum = 0
  GLEW_ERROR_NO_GL_VERSION*: glEnum = 1
  GLEW_ERROR_GL_VERSION_10_ONLY*: glEnum = 2
  GLEW_ERROR_GLX_VERSION_11_ONLY*: glEnum = 3
  GL_BLEND_DST_RGB*: glEnum = 0x80C8
  GL_BLEND_SRC_RGB*: glEnum = 0x80C9
  GL_BLEND_DST_ALPHA*: glEnum = 0x80CA
  GL_BLEND_SRC_ALPHA*: glEnum = 0x80CB
  GL_POINT_SIZE_MIN*: glEnum = 0x8126
  GL_POINT_SIZE_MAX*: glEnum = 0x8127
  GL_POINT_FADE_THRESHOLD_SIZE*: glEnum = 0x8128
  GL_POINT_DISTANCE_ATTENUATION*: glEnum = 0x8129
  GL_GENERATE_MIPMAP*: glEnum = 0x8191
  GL_GENERATE_MIPMAP_HINT*: glEnum = 0x8192
  GL_DEPTH_COMPONENT16*: glEnum = 0x81A5
  GL_DEPTH_COMPONENT24*: glEnum = 0x81A6
  GL_DEPTH_COMPONENT32*: glEnum = 0x81A7
  GL_MIRRORED_REPEAT*: glEnum = 0x8370
  GL_FOG_COORDINATE_SOURCE*: glEnum = 0x8450
  GL_FOG_COORDINATE*: glEnum = 0x8451
  GL_FRAGMENT_DEPTH*: glEnum = 0x8452
  GL_CURRENT_FOG_COORDINATE*: glEnum = 0x8453
  GL_FOG_COORDINATE_ARRAY_TYPE*: glEnum = 0x8454
  GL_FOG_COORDINATE_ARRAY_STRIDE*: glEnum = 0x8455
  GL_FOG_COORDINATE_ARRAY_POINTER*: glEnum = 0x8456
  GL_FOG_COORDINATE_ARRAY*: glEnum = 0x8457
  GL_COLOR_SUM*: glEnum = 0x8458
  GL_CURRENT_SECONDARY_COLOR*: glEnum = 0x8459
  GL_SECONDARY_COLOR_ARRAY_SIZE*: glEnum = 0x845A
  GL_SECONDARY_COLOR_ARRAY_TYPE*: glEnum = 0x845B
  GL_SECONDARY_COLOR_ARRAY_STRIDE*: glEnum = 0x845C
  GL_SECONDARY_COLOR_ARRAY_POINTER*: glEnum = 0x845D
  GL_SECONDARY_COLOR_ARRAY*: glEnum = 0x845E
  GL_MAX_TEXTURE_LOD_BIAS*: glEnum = 0x84FD
  GL_TEXTURE_FILTER_CONTROL*: glEnum = 0x8500
  GL_TEXTURE_LOD_BIAS*: glEnum = 0x8501
  GL_INCR_WRAP*: glEnum = 0x8507
  GL_DECR_WRAP*: glEnum = 0x8508
  GL_TEXTURE_DEPTH_SIZE*: glEnum = 0x884A
  GL_DEPTH_TEXTURE_MODE*: glEnum = 0x884B
  GL_TEXTURE_COMPARE_MODE*: glEnum = 0x884C
  GL_TEXTURE_COMPARE_FUNC*: glEnum = 0x884D
  GL_COMPARE_R_TO_TEXTURE*: glEnum = 0x884E
  GL_CURRENT_FOG_COORD*: glEnum = GL_CURRENT_FOG_COORDINATE
  GL_FOG_COORD*: glEnum = GL_FOG_COORDINATE
  GL_FOG_COORD_ARRAY*: glEnum = GL_FOG_COORDINATE_ARRAY
  GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING*: glEnum = 0x889D
  GL_FOG_COORD_ARRAY_BUFFER_BINDING*: glEnum = GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING
  GL_FOG_COORD_ARRAY_POINTER*: glEnum = GL_FOG_COORDINATE_ARRAY_POINTER
  GL_FOG_COORD_ARRAY_STRIDE*: glEnum = GL_FOG_COORDINATE_ARRAY_STRIDE
  GL_FOG_COORD_ARRAY_TYPE*: glEnum = GL_FOG_COORDINATE_ARRAY_TYPE
  GL_FOG_COORD_SRC*: glEnum = GL_FOG_COORDINATE_SOURCE
  GL_SOURCE0_ALPHA*: glEnum = 0x8588
  GL_SOURCE1_ALPHA*: glEnum = 0x8589
  GL_SOURCE2_ALPHA*: glEnum = 0x858A
  GL_SOURCE0_RGB*: glEnum = 0x8580
  GL_SOURCE1_RGB*: glEnum = 0x8581
  GL_SOURCE2_RGB*: glEnum = 0x8582
  GL_SRC0_ALPHA*: glEnum = GL_SOURCE0_ALPHA
  GL_SRC0_RGB*: glEnum = GL_SOURCE0_RGB
  GL_SRC1_ALPHA*: glEnum = GL_SOURCE1_ALPHA
  GL_SRC1_RGB*: glEnum = GL_SOURCE1_RGB
  GL_SRC2_ALPHA*: glEnum = GL_SOURCE2_ALPHA
  GL_SRC2_RGB*: glEnum = GL_SOURCE2_RGB
  GL_BUFFER_SIZE*: glEnum = 0x8764
  GL_BUFFER_USAGE*: glEnum = 0x8765
  GL_QUERY_COUNTER_BITS*: glEnum = 0x8864
  GL_CURRENT_QUERY*: glEnum = 0x8865
  GL_QUERY_RESULT*: glEnum = 0x8866
  GL_QUERY_RESULT_AVAILABLE*: glEnum = 0x8867
  GL_ARRAY_BUFFER*: glEnum = 0x8892
  GL_ELEMENT_ARRAY_BUFFER*: glEnum = 0x8893
  GL_ARRAY_BUFFER_BINDING*: glEnum = 0x8894
  GL_ELEMENT_ARRAY_BUFFER_BINDING*: glEnum = 0x8895
  GL_VERTEX_ARRAY_BUFFER_BINDING*: glEnum = 0x8896
  GL_NORMAL_ARRAY_BUFFER_BINDING*: glEnum = 0x8897
  GL_COLOR_ARRAY_BUFFER_BINDING*: glEnum = 0x8898
  GL_INDEX_ARRAY_BUFFER_BINDING*: glEnum = 0x8899
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING*: glEnum = 0x889A
  GL_EDGE_FLAG_ARRAY_BUFFER_BINDING*: glEnum = 0x889B
  GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING*: glEnum = 0x889C
  GL_WEIGHT_ARRAY_BUFFER_BINGDING*: glEnum = 0x889E
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING*: glEnum = 0x889F
  GL_READ_ONLY*: glEnum = 0x88B8
  GL_WRITE_ONLY*: glEnum = 0x88B9
  GL_READ_WRITE*: glEnum = 0x88BA
  GL_BUFFER_ACCESS*: glEnum = 0x88BB
  GL_BUFFER_MAPPED*: glEnum = 0x88BC
  GL_BUFFER_MAP_POINTER*: glEnum = 0x88BD
  GL_STREAM_DRAW*: glEnum = 0x88E0
  GL_STREAM_READ*: glEnum = 0x88E1
  GL_STREAM_COPY*: glEnum = 0x88E2
  GL_STATIC_DRAW*: glEnum = 0x88E4
  GL_STATIC_READ*: glEnum = 0x88E5
  GL_STATIC_COPY*: glEnum = 0x88E6
  GL_DYNAMIC_DRAW*: glEnum = 0x88E8
  GL_DYNAMIC_READ*: glEnum = 0x88E9
  GL_DYNAMIC_COPY*: glEnum = 0x88EA
  GL_SAMPLES_PASSED*: glEnum = 0x8914
  GL_FLOAT*: glEnum = 0x1406
  GL_BLEND_EQUATION*: glEnum = 0x8009
  GL_BLEND_EQUATION_RGB*: glEnum = GL_BLEND_EQUATION
  GL_VERTEX_ATTRIB_ARRAY_ENABLED*: glEnum = 0x8622
  GL_VERTEX_ATTRIB_ARRAY_SIZE*: glEnum = 0x8623
  GL_VERTEX_ATTRIB_ARRAY_STRIDE*: glEnum = 0x8624
  GL_VERTEX_ATTRIB_ARRAY_TYPE*: glEnum = 0x8625
  GL_CURRENT_VERTEX_ATTRIB*: glEnum = 0x8626
  GL_VERTEX_PROGRAM_POINT_SIZE*: glEnum = 0x8642
  GL_VERTEX_PROGRAM_TWO_SIDE*: glEnum = 0x8643
  GL_VERTEX_ATTRIB_ARRAY_POINTER*: glEnum = 0x8645
  GL_STENCIL_BACK_FUNC*: glEnum = 0x8800
  GL_STENCIL_BACK_FAIL*: glEnum = 0x8801
  GL_STENCIL_BACK_PASS_DEPTH_FAIL*: glEnum = 0x8802
  GL_STENCIL_BACK_PASS_DEPTH_PASS*: glEnum = 0x8803
  GL_MAX_DRAW_BUFFERS*: glEnum = 0x8824
  GL_DRAW_BUFFER0*: glEnum = 0x8825
  GL_DRAW_BUFFER1*: glEnum = 0x8826
  GL_DRAW_BUFFER2*: glEnum = 0x8827
  GL_DRAW_BUFFER3*: glEnum = 0x8828
  GL_DRAW_BUFFER4*: glEnum = 0x8829
  GL_DRAW_BUFFER5*: glEnum = 0x882A
  GL_DRAW_BUFFER6*: glEnum = 0x882B
  GL_DRAW_BUFFER7*: glEnum = 0x882C
  GL_DRAW_BUFFER8*: glEnum = 0x882D
  GL_DRAW_BUFFER9*: glEnum = 0x882E
  GL_DRAW_BUFFER10*: glEnum = 0x882F
  GL_DRAW_BUFFER11*: glEnum = 0x8830
  GL_DRAW_BUFFER12*: glEnum = 0x8831
  GL_DRAW_BUFFER13*: glEnum = 0x8832
  GL_DRAW_BUFFER14*: glEnum = 0x8833
  GL_DRAW_BUFFER15*: glEnum = 0x8834
  GL_BLEND_EQUATION_ALPHA*: glEnum = 0x883D
  GL_POINT_SPRITE*: glEnum = 0x8861
  GL_COORD_REPLACE*: glEnum = 0x8862
  GL_MAX_VERTEX_ATTRIBS*: glEnum = 0x8869
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED*: glEnum = 0x886A
  GL_MAX_TEXTURE_COORDS*: glEnum = 0x8871
  GL_MAX_TEXTURE_IMAGE_UNITS*: glEnum = 0x8872
  GL_FRAGMENT_SHADER*: glEnum = 0x8B30
  GL_VERTEX_SHADER*: glEnum = 0x8B31
  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS*: glEnum = 0x8B49
  GL_MAX_VERTEX_UNIFORM_COMPONENTS*: glEnum = 0x8B4A
  GL_MAX_VARYING_FLOATS*: glEnum = 0x8B4B
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS*: glEnum = 0x8B4C
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS*: glEnum = 0x8B4D
  GL_SHADER_TYPE*: glEnum = 0x8B4F
  GL_FLOAT_VEC2*: glEnum = 0x8B50
  GL_FLOAT_VEC3*: glEnum = 0x8B51
  GL_FLOAT_VEC4*: glEnum = 0x8B52
  GL_INT_VEC2*: glEnum = 0x8B53
  GL_INT_VEC3*: glEnum = 0x8B54
  GL_INT_VEC4*: glEnum = 0x8B55
  GL_BOOL*: glEnum = 0x8B56
  GL_BOOL_VEC2*: glEnum = 0x8B57
  GL_BOOL_VEC3*: glEnum = 0x8B58
  GL_BOOL_VEC4*: glEnum = 0x8B59
  GL_FLOAT_MAT2*: glEnum = 0x8B5A
  GL_FLOAT_MAT3*: glEnum = 0x8B5B
  GL_FLOAT_MAT4*: glEnum = 0x8B5C
  GL_SAMPLER_1D*: glEnum = 0x8B5D
  GL_SAMPLER_2D*: glEnum = 0x8B5E
  GL_SAMPLER_3D*: glEnum = 0x8B5F
  GL_SAMPLER_CUBE*: glEnum = 0x8B60
  GL_SAMPLER_1D_SHADOW*: glEnum = 0x8B61
  GL_SAMPLER_2D_SHADOW*: glEnum = 0x8B62
  GL_DELETE_STATUS*: glEnum = 0x8B80
  GL_COMPILE_STATUS*: glEnum = 0x8B81
  GL_LINK_STATUS*: glEnum = 0x8B82
  GL_VALIDATE_STATUS*: glEnum = 0x8B83
  GL_INFO_LOG_LENGTH*: glEnum = 0x8B84
  GL_ATTACHED_SHADERS*: glEnum = 0x8B85
  GL_ACTIVE_UNIFORMS*: glEnum = 0x8B86
  GL_ACTIVE_UNIFORM_MAX_LENGTH*: glEnum = 0x8B87
  GL_SHADER_SOURCE_LENGTH*: glEnum = 0x8B88
  GL_ACTIVE_ATTRIBUTES*: glEnum = 0x8B89
  GL_ACTIVE_ATTRIBUTE_MAX_LENGTH*: glEnum = 0x8B8A
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT*: glEnum = 0x8B8B
  GL_SHADING_LANGUAGE_VERSION*: glEnum = 0x8B8C
  GL_CURRENT_PROGRAM*: glEnum = 0x8B8D
  GL_POINT_SPRITE_COORD_ORIGIN*: glEnum = 0x8CA0
  GL_LOWER_LEFT*: glEnum = 0x8CA1
  GL_UPPER_LEFT*: glEnum = 0x8CA2
  GL_STENCIL_BACK_REF*: glEnum = 0x8CA3
  GL_STENCIL_BACK_VALUE_MASK*: glEnum = 0x8CA4
  GL_STENCIL_BACK_WRITEMASK*: glEnum = 0x8CA5

# OpenGL Procedures
proc init*(): glEnum {.glew_lib, importc: "glewInit".}
proc glClear*(mask: glBitfield): void {.glew_lib.}
proc glClearColor*(red: glFloat, green: glFloat, blue: glFloat, alpha: glFloat): void {.glew_lib.}
proc glEnable*(cap: glEnum): void {.glew_lib.}
proc glBlendFunc*(sfactor, dfactor: glEnum): void {.glew_lib.}
proc glPolygonMode*(face, mode: glEnum): void {.glew_lib.}
proc glGenBuffers*(number: glSizei, buffers: ptr glUint): void {.glew_lib.}
proc glDeleteBuffers*(number: glSizei, buffers: ptr glUint): void {.glew_lib.}
proc glGenVertexArrays*(number: glSizei, buffers: ptr glUint): void {.glew_lib.}
proc glDeleteVertexArrays*(number: glSizei, buffers: ptr glUint): void {.glew_lib.}
proc glBindVertexArray*(arrai: glUint): void {.glew_lib.}
proc glBindBuffer*(target: glEnum, buffer: glUint): void {.glew_lib.}
proc glBufferData*(target: glEnum, size: glSizeiptr, data: glVoid, usage: glEnum): void {.glew_lib.}
proc glNamedBufferData*(buffer: glUint, size: glSizei, data: glVoid, usage: glEnum): void {.glew_lib.}
proc glEnableVertexAttribArray*(indice: glUint): void {.glew_lib.}
proc glVertexAttribPointer*(index: glUint, size: glInt, tipe: glEnum, normalized: glBoolean, stride: glSizei, poynter: glVoid): void {.glew_lib.}
proc glDrawElements*(mode: glEnum, count: glSizei, tipe: glEnum, indices: glVoid): void {.glew_lib.}
proc glGetShaderiv*(shader: glUint, pname: glEnum, params: ptr glInt): void {.glew_lib.}
proc glGetShaderInfoLog*(shader: glUint, maxLength: glSizei, length: ptr glSizei, infoLog: ptr glChar): void {.glew_lib.}
proc glCreateShader*(shaderType: glEnum): glUint {.glew_lib.}
proc glShaderSource*(shader: glUint, count: glSizei, source: ptr cstring, lenght: ptr glInt): void {.glew_lib.}
proc glCompileShader*(shader: glUint): void {.glew_lib.}
proc glCreateProgram*(): glUint {.glew_lib.}
proc glAttachShader*(program: glUint, shader: glUint): void {.glew_lib.}
proc glLinkProgram*(program: glUint): void {.glew_lib.}
proc glGetProgramiv*(program: glUint, pname: glEnum, params: ptr glInt): void {.glew_lib.}
proc glGetProgramInfoLog*(program: glUint, maxLength: glSizei, length: ptr glSizei, infoLog: ptr glChar): void {.glew_lib.}
proc glUseProgram*(program: glUint): void {.glew_lib.}
proc glGetUniformLocation*(program: glUint, name: cstring): glInt {.glew_lib.}

proc glUniform4f* (location: glInt, v0, v1, v2, v3: glFloat): void {.glew_lib.}
proc glUniform3f* (location: glInt, v0, v1, v2: glFloat): void {.glew_lib.}
proc glUniform2f* (location: glInt, v0, v1: glFloat): void {.glew_lib.}
proc glUniform1f* (location: glInt, v0: glFloat): void {.glew_lib.}
proc glUniform4i* (location: glInt, v0, v1, v2, v3: glInt): void {.glew_lib.}
proc glUniform3i* (location: glInt, v0, v1, v2: glInt): void {.glew_lib.}
proc glUniform2i* (location: glInt, v0, v1: glInt): void {.glew_lib.}
proc glUniform1i* (location: glInt, v0: glInt): void {.glew_lib.}
proc glUniform4ui*(location: glInt, v0, v1, v2, v3: glUint): void {.glew_lib.}
proc glUniform3ui*(location: glInt, v0, v1, v2: glUint): void {.glew_lib.}
proc glUniform2ui*(location: glInt, v0, v1: glUint): void {.glew_lib.}
proc glUniform1ui*(location: glInt, v0: glUint): void {.glew_lib.}

proc glUniform4fv* (location: glInt, count: glSizei, v: ptr glFloat): void {.glew_lib.}
proc glUniform3fv* (location: glInt, count: glSizei, v: ptr glFloat): void {.glew_lib.}
proc glUniform2fv* (location: glInt, count: glSizei, v: ptr glFloat): void {.glew_lib.}
proc glUniform1fv* (location: glInt, count: glSizei, v: ptr glFloat): void {.glew_lib.}
proc glUniform4iv* (location: glInt, count: glSizei, v: ptr glInt): void {.glew_lib.}
proc glUniform3iv* (location: glInt, count: glSizei, v: ptr glInt): void {.glew_lib.}
proc glUniform2iv* (location: glInt, count: glSizei, v: ptr glInt): void {.glew_lib.}
proc glUniform1iv* (location: glInt, count: glSizei, v: ptr glInt): void {.glew_lib.}
proc glUniform4uiv*(location: glInt, count: glSizei, v: ptr glUint): void {.glew_lib.}
proc glUniform3uiv*(location: glInt, count: glSizei, v: ptr glUint): void {.glew_lib.}
proc glUniform2uiv*(location: glInt, count: glSizei, v: ptr glUint): void {.glew_lib.}
proc glUniform1uiv*(location: glInt, count: glSizei, v: ptr glUint): void {.glew_lib.}

proc glUniformMatrix2fv*(location: glInt, count: glSizei, transpose: glBoolean, value: ptr glFloat): void {.glew_lib.}
proc glUniformMatrix3fv*(location: glInt, count: glSizei, transpose: glBoolean, value: ptr glFloat): void {.glew_lib.}
proc glUniformMatrix4fv*(location: glInt, count: glSizei, transpose: glBoolean, value: ptr glFloat): void {.glew_lib.}
proc glUniformMatrix2x3fv*(location: glInt, count: glSizei, transpose: glBoolean, value: ptr glFloat): void {.glew_lib.}
proc glUniformMatrix3x2fv*(location: glInt, count: glSizei, transpose: glBoolean, value: ptr glFloat): void {.glew_lib.}
proc glUniformMatrix2x4fv*(location: glInt, count: glSizei, transpose: glBoolean, value: ptr glFloat): void {.glew_lib.}
proc glUniformMatrix4x2fv*(location: glInt, count: glSizei, transpose: glBoolean, value: ptr glFloat): void {.glew_lib.}
proc glUniformMatrix3x4fv*(location: glInt, count: glSizei, transpose: glBoolean, value: ptr glFloat): void {.glew_lib.}
proc glUniformMatrix4x3fv*(location: glInt, count: glSizei, transpose: glBoolean, value: ptr glFloat): void {.glew_lib.}