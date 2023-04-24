' Copyright (c) 2023 Bruce A Henderson
' 
' This software is provided 'as-is', without any express or implied
' warranty. In no event will the authors be held liable for any damages
' arising from the use of this software.
' 
' Permission is granted to anyone to use this software for any purpose,
' including commercial applications, and to alter it and redistribute it
' freely, subject to the following restrictions:
' 
' 1. The origin of this software must not be misrepresented; you must not
'    claim that you wrote the original software. If you use this software
'    in a product, an acknowledgment in the product documentation would be
'    appreciated but is not required.
' 2. Altered source versions must be plainly marked as such, and must not be
'    misrepresented as being the original software.
' 3. This notice may not be removed or altered from any source distribution.
' 
SuperStrict

Import Pub.Zlib
Import BRL.Stream
Import BRL.Math
Import BRL.Pixmap

Import "source.bmx"

Extern

	Function bmx_pdf_HPDF_New:Byte Ptr()

	Function HPDF_Free(handle:Byte Ptr)
	Function HPDF_SaveToStream:ULongInt(handle:Byte Ptr)
	Function HPDF_ResetStream:ULongInt(handle:Byte Ptr)
	Function HPDF_ReadFromStream:ULongInt(handle:Byte Ptr, buf:Byte Ptr, size:UInt Var)
	Function HPDF_AddPage:Byte Ptr(handle:Byte Ptr)
	Function HPDF_GetFont:Byte Ptr(handle:Byte Ptr, fn:Byte Ptr, en:Byte Ptr)
	Function HPDF_GetCurrentPage:Byte Ptr(handle:Byte Ptr)
	Function HPDF_InsertPage:Byte Ptr(handle:Byte Ptr, page:Byte Ptr)
	Function HPDF_SetCompressionMode:ULongInt(handle:Byte Ptr, mode:EPDFCompressionMode)
	Function HPDF_CreateExtGState:Byte Ptr(handle:Byte Ptr)
	Function HPDF_SetPassword:ULongInt(handle:Byte Ptr, owner:Byte Ptr, user:Byte Ptr)
	Function HPDF_SetPermission:ULongInt(handle:Byte Ptr, permission:UInt)
	Function HPDF_SetEncryptionMode:ULongInt(handle:Byte Ptr, mode:EPDFEncryptMode, keyLen:UInt)
	Function HPDF_SetPagesConfiguration:ULongInt(handle:Byte Ptr, pagePerPages:UInt)
	Function HPDF_SetPageLayout:ULongInt(handle:Byte Ptr, layout:EPDFPageLayout)
	Function HPDF_CreateOutline:Byte Ptr(handle:Byte Ptr, parent:Byte Ptr, t:Byte Ptr, encoder:Byte Ptr)
	Function HPDF_SetPageMode:ULongInt(handle:Byte Ptr, mode:EPDFPageMode)
	Function HPDF_GetPageMode:EPDFPageMode(handle:Byte Ptr)
	Function HPDF_AddPageLabel:ULongInt(handle:Byte Ptr, pageNum:UInt, style:EPDFPageNumStyle, firstPage:UInt, p:Byte Ptr)
	Function HPDF_GetPageLayout:EPDFPageLayout(handle:Byte Ptr)
	Function HPDF_UseJPFonts:ULongInt(handle:Byte Ptr)
	Function HPDF_UseKRFonts:ULongInt(handle:Byte Ptr)
	Function HPDF_UseCNSFonts:ULongInt(handle:Byte Ptr)
	Function HPDF_UseCNTFonts:ULongInt(handle:Byte Ptr)
	Function HPDF_SetInfoAttr:ULongInt(handle:Byte Ptr, infoType:EPDFInfoType, v:Byte Ptr)
	Function HPDF_GetInfoAttr:Byte Ptr(handle:Byte Ptr, infoType:EPDFInfoType)
	Function HPDF_SetInfoDateAttr:ULongInt(handle:Byte Ptr, infoType:EPDFInfoType, date:SPDFDate)
	Function HPDF_GetEncoder:Byte Ptr(handler:Byte Ptr, encodingName:Byte Ptr)
	Function HPDF_GetCurrentEncoder:Byte ptr(handler:Byte Ptr, encodingName:Byte Ptr)
	Function HPDF_SetCurrentEncoder:ULongInt(handler:Byte Ptr, encodingName:Byte Ptr)
	Function HPDF_LoadRawImageFromMem:Byte Ptr(handler:Byte Ptr, buf:Byte Ptr, width:UInt, height:UInt, colorSpace:EPDFColorSpace, bitsPerComponent:UInt)

	Function HPDF_Page_BeginText:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_EndText:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_ShowText:ULongInt(handle:Byte Ptr, text:Byte Ptr)
	Function HPDF_Page_ShowTextNextLine:ULongInt(handle:Byte Ptr, text:Byte Ptr)
	Function HPDF_Page_ShowTextNextLineEx:ULongInt(handle:Byte Ptr, wordSpace:Float, charSpace:Float, text:Byte Ptr)
	Function HPDF_Page_SetWidth:ULongInt(handle:Byte Ptr, width:Float)
	Function HPDF_Page_SetHeight:ULongInt(handle:Byte Ptr, height:Float)
	Function HPDF_Page_SetRotate:ULongInt(handle:Byte Ptr, angle:Short)
		
	Function HPDF_Page_TextWidth:Float(handle:Byte Ptr, text:Byte Ptr)
	Function HPDF_Page_SetLineWidth:ULongInt(handle:Byte Ptr, width:Float)
	Function HPDF_Page_SetLineCap:ULongInt(handle:Byte Ptr, lineCap:EPDFLineCap)
	Function HPDF_Page_SetLineJoin:ULongInt(handle:Byte Ptr, lineJoin:EPDFLineJoin)
	Function HPDF_Page_SetMiterLimit:ULongInt(handle:Byte Ptr, miterLimit:Float)
	Function HPDF_Page_GetWidth:Float(handle:Byte Ptr)
	Function HPDF_Page_GetHeight:Float(handle:Byte Ptr)
	Function HPDF_Page_Rectangle:ULongInt(handle:Byte Ptr, x:Float, y:Float, width:Float, height:Float)
	Function HPDF_Page_Stroke:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_ClosePathStroke:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_Fill:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_Eofill:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_FillStroke:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_EofillStroke:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_ClosePathFillStroke:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_ClosePathEofillStroke:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_EndPath:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_GSave:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_GRestore:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_Clip:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_Eoclip:ULongInt(handle:Byte Ptr)
	Function HPDF_Page_Circle:ULongInt(handle:Byte Ptr, x:Float, y:Float, r:Float)
	Function HPDF_Page_Ellipse:ULongInt(handle:Byte Ptr, x:Float, y:Float, xr:Float, yr:Float)
	Function HPDF_Page_Arc:ULongInt(handle:Byte Ptr, x:Float, y:Float, r:Float, a1:Float, a2:Float)
	Function HPDF_Page_TextOut:ULongInt(handle:Byte Ptr, xpos:Float, ypos:Float, t:Byte Ptr)
	Function HPDF_Page_TextRect:ULongInt(handle:Byte Ptr, left:Float, top:Float, right:Float, bottom:Float, t:Byte Ptr, align:EPDFTextAlignment, length:UInt Var)
	Function HPDF_Page_MeasureText:UInt(handle:Byte Ptr, t:Byte Ptr, width:Float, wordwrap:Int, realWidth:Float Ptr)
	Function HPDF_Page_CreateTextAnnot:Byte Ptr(handle:Byte Ptr, rect:SPDFRect, t:Byte Ptr, encoder:Byte Ptr)
	Function HPDF_Page_CreateLinkAnnot:Byte Ptr(handle:Byte Ptr, rect:SPDFRect, dest:Byte Ptr)
	Function HPDF_Page_CreateURILinkAnnot:Byte Ptr(handle:Byte Ptr, rect:SPDFRect, uri:Byte Ptr)
	Function HPDF_Page_GetGrayFill:Float(handle:Byte Ptr)
	Function HPDF_Page_GetGrayStroke:Float(handle:Byte Ptr)
	Function HPDF_Page_DrawImage:UInt(handle:Byte Ptr, image:Byte Ptr, x:Float, y:Float, width:Float, height:Float)

	Function HPDF_Page_SetFontAndSize:ULongInt(handle:Byte Ptr, font:Byte Ptr, size:Float)
	Function HPDF_Page_SetCharSpace:ULongInt(handle:Byte Ptr, value:Float)
	Function HPDF_Page_SetWordSpace:ULongInt(handle:Byte Ptr, value:Float)
	Function HPDF_Page_SetHorizontalScalling:ULongInt(handle:Byte Ptr, value:Float)
	Function HPDF_Page_SetTextLeading:ULongInt(handle:Byte Ptr, value:Float)
	Function HPDF_Page_GetCurrentFont:Byte Ptr(handle:Byte Ptr)
	Function HPDF_Page_GetCurrentFontSize:Float(handle:Byte Ptr)

	Function HPDF_Page_MoveTextPos:ULongInt(handle:Byte Ptr, x:Float, y:Float)
	Function HPDF_Page_MoveTextPos2:ULongInt(handle:Byte Ptr, x:Float, y:Float)
	Function HPDF_Page_SetTextMatrix:ULongInt(handle:Byte Ptr, a:Float, b:Float, c:Float, d:Float, x:Float, y:Float)
	Function HPDF_Page_MoveToNextLine:ULongInt(handle:Byte Ptr)

	Function HPDF_Page_MoveTo:ULongInt(handle:Byte Ptr, x:Float, y:Float)
	Function HPDF_Page_LineTo:ULongInt(handle:Byte Ptr, x:Float, y:Float)
	Function HPDF_Page_CurveTo:ULongInt(handle:Byte Ptr, x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float)
	Function HPDF_Page_CurveTo2:ULongInt(handle:Byte Ptr, x2:Float, y2:Float, x3:Float, y3:Float)
	Function HPDF_Page_CurveTo3:ULongInt(handle:Byte Ptr, x1:Float, y1:Float, x3:Float, y3:Float)
	
	Function HPDF_Page_SetDash:ULongInt(handle:Byte Ptr, dashes:Float Ptr, count:UInt, phase:Float)
	Function HPDF_Page_SetRGBFill:ULongInt(handle:Byte Ptr, r:Float, g:Float, b:Float)
	Function HPDF_Page_SetRGBStroke:ULongInt(handle:Byte Ptr, r:Float, g:Float, b:Float)
	Function HPDF_Page_SetCMYKFill:ULongInt(handle:Byte Ptr, c:Float, m:Float, y:Float, k:Float)
	Function HPDF_Page_SetCMYKStroke:ULongInt(handle:Byte Ptr, c:Float, m:Float, y:Float, k:Float)
	Function HPDF_Page_SetGrayFill:ULongInt(handle:Byte Ptr, gray:Float)
	Function HPDF_Page_SetGrayStroke:ULongInt(handle:Byte Ptr, gray:Float)
	Function HPDF_Page_GetLineWidth:Float(handle:Byte Ptr)
	Function HPDF_Page_GetCurrentPos:SPDFPoint(handle:Byte Ptr)
	Function HPDF_Page_GetCurrentTextPos:SPDFPoint(handle:Byte Ptr)
	Function HPDF_Page_GetRGBFill:SPDFRGBColor(handle:Byte Ptr)
	Function HPDF_Page_GetRGBStroke:SPDFRGBColor(handle:Byte Ptr)
	Function HPDF_Page_GetCMYKFill:SPDFCMYKColor(handle:Byte Ptr)
	Function HPDF_Page_GetCMYKStroke:SPDFCMYKColor(handle:Byte Ptr)
	Function HPDF_Page_SetTextRenderingMode:ULongInt(handle:Byte Ptr, mode:EPDFTextRenderingMode)
	Function HPDF_Page_SetExtGState:ULongInt(handle:Byte Ptr, gstate:Byte Ptr)
	Function HPDF_Page_GetStrokingColorSpace:EPDFColorSpace(handle:Byte Ptr)
	Function HPDF_Page_GetFillingColorSpace:EPDFColorSpace(handle:Byte Ptr)
	Function HPDF_Page_GetTextMatrix:SPDFTransMatrix(handle:Byte Ptr)
	Function HPDF_Page_GetGStateDepth:UInt(handle:Byte Ptr)
	Function HPDF_Page_GetTextRise:Float(handle:Byte Ptr)
	Function HPDF_Page_GetTextLeading:Float(handle:Byte Ptr)
	Function HPDF_Page_GetTextRenderingMode:EPDFTextRenderingMode(handle:Byte Ptr)
	Function HPDF_Page_GetHorizontalScalling:Float(handle:Byte Ptr)
	Function HPDF_Page_GetWordSpace:Float(handle:Byte Ptr)
	Function HPDF_Page_GetCharSpace:Float(handle:Byte Ptr)
	Function HPDF_Page_GetFlat:Float(handle:Byte Ptr)
	Function HPDF_Page_GetDash:SPDFDashMode(handle:Byte Ptr)
	Function HPDF_Page_GetMiterLimit:Float(handle:Byte Ptr)
	Function HPDF_Page_GetLineJoin:EPDFLineJoin(handle:Byte Ptr)
	Function HPDF_Page_GetLineCap:EPDFLineCap(handle:Byte Ptr)
	Function HPDF_Page_GetTransMatrix:SPDFTransMatrix(handle:Byte Ptr)
	Function HPDF_Page_GetGMode:Short(handle:Byte Ptr)
	Function HPDF_Page_SetFlat:ULongInt(handle:Byte Ptr, flatness:Float)
	Function HPDF_Page_Concat:ULongInt(handle:Byte Ptr, a:Float, b:Float, c:Float, d:Float, x:Float, y:Float)
	Function HPDF_Page_SetSize:ULongInt(handle:Byte Ptr, size:EPDFPageSize, direction:EPDFPageDirection)
	Function HPDF_Page_CreateDestination:Byte Ptr(handle:Byte Ptr)
	Function HPDF_SetOpenAction:ULongInt(handle:Byte Ptr, action:Byte Ptr)
	Function HPDF_Page_SetSlideShow:ULongInt(handle:Byte Ptr, style:EPDFTransitionStyle, dispTime:Float, transTime:Float)

	Function HPDF_Font_MeasureText:UInt(handle:Byte Ptr, t:Byte Ptr, length:UInt, width:Float, fontSize:Float, charSpace:Float, wordSpace:Float, wordwrap:Int, realWidth:Float Ptr)
	Function HPDF_Font_GetFontName:Byte Ptr(handle:Byte Ptr)
	Function HPDF_Font_GetEncodingName:Byte Ptr(handle:Byte Ptr)
	Function HPDF_Font_GetBBox:SPDFRect(handle:Byte Ptr)
	Function HPDF_Font_GetAscent:Int(handle:Byte Ptr)
	Function HPDF_Font_GetDescent:Int(handle:Byte Ptr)
	Function HPDF_Font_GetXHeight:UInt(handle:Byte Ptr)
	Function HPDF_Font_GetCapHeight:UInt(handle:Byte Ptr)
	Function HPDF_Font_TextWidth:SPDFTextWidth(handle:Byte Ptr, t:Byte Ptr, length:UInt)

	Function HPDF_ExtGState_SetAlphaStroke:ULongInt(handle:Byte Ptr, value:Float)
	Function HPDF_ExtGState_SetAlphaFill:ULongInt(handle:Byte Ptr, value:Float)
	Function HPDF_ExtGState_SetBlendMode:ULongInt(handle:Byte Ptr, mode:EPDFBlendMode)

	Function HPDF_Destination_SetXYZ:ULongInt(handle:Byte Ptr, left:Float, top:Float, zoom:Float)
	Function HPDF_Destination_SetFit:ULongInt(handle:Byte Ptr)
	Function HPDF_Destination_SetFitH:ULongInt(handle:Byte Ptr, top:Float)
	Function HPDF_Destination_SetFitV:ULongInt(handle:Byte Ptr, left:Float)
	Function HPDF_Destination_SetFitR:ULongInt(handle:Byte Ptr, left:Float, bottom:Float, right:Float, top:Float)
	Function HPDF_Destination_SetFitB:ULongInt(handle:Byte Ptr)
	Function HPDF_Destination_SetFitBH:ULongInt(handle:Byte Ptr, top:Float)
	Function HPDF_Destination_SetFitBV:ULongInt(handle:Byte Ptr, left:Float)

	Function HPDF_Outline_SetOpened:ULongInt(handle:Byte Ptr, opened:Int)
	Function HPDF_Outline_SetDestination:ULongInt(handle:Byte Ptr, dest:Byte Ptr)
	
	Function HPDF_LinkAnnot_SetHighlightMode:ULongInt(handle:Byte Ptr, mode:EPDFAnnotHighlightMode)
	Function HPDF_LinkAnnot_SetBorderStyle:ULongInt(handle:Byte Ptr, width:Float, dashOn:Short, dashOff:Short)
	Function HPDF_TextAnnot_SetIcon:ULongInt(handle:Byte Ptr, icon:EPDFAnnotIcon)
	Function HPDF_TextAnnot_SetOpened:ULongInt(handle:Byte Ptr, open:Int)
	Function HPDF_Annotation_SetBorderStyle:ULongInt(handle:Byte Ptr, subtype:EPDFBSSubtype, width:Float, dashOn:Short, dashOff:Short, dashPhase:Short)

	Function HPDF_Encoder_GetType:EPDFEncoderType(handle:Byte Ptr)
	Function HPDF_Encoder_GetByteType:EPDFByteType(handle:Byte Ptr, text:Byte Ptr, index:UInt)
	Function HPDF_Encoder_GetUnicode:Short(handle:Byte Ptr, code:Short)
	Function HPDF_Encoder_GetWritingMode:EPDFWritingMode(handle:Byte Ptr)

	Function HPDF_Image_GetWidth:UInt(handle:Byte Ptr)
	Function HPDF_Image_GetHeight:UInt(handle:Byte Ptr)
	Function HPDF_Image_GetBitsPerComponent:UInt(handle:Byte Ptr)
	Function HPDF_Image_GetSize:SPDFPoint(handle:Byte Ptr)
	Function HPDF_Image_GetColorSpace:Byte Ptr(handle:Byte Ptr)
	Function HPDF_Image_SetColorMask:UInt(handle:Byte Ptr, rmin:UInt, rmax:UInt, gmin:UInt, gmax:UInt, bmin:UInt, bmax:UInt)
	Function HPDF_Image_SetMaskImage:UInt(handle:Byte Ptr, mask:Byte Ptr)

End Extern

Rem
bbdoc: 
End Rem
Enum EPDFLineCap
	BUTT_END
	ROUND_END
	PROJECTING_SQUARE_END
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFLineJoin
	MITER_JOIN
    ROUND_JOIN
    BEVEL_JOIN
End Enum

Rem
bbdoc: 
End Rem
Struct SPDFPoint
	Field x:Float
	Field y:Float

	Method New()
	End Method

	Method New(x:Float, y:Float)
		Self.x = x
		Self.y = y
	End Method
	
End Struct

Rem
bbdoc: 
End Rem
Struct SPDFRGBColor
	Field r:Float
	Field g:Float
	Field b:Float
End Struct

Rem
bbdoc: 
End Rem
Struct SPDFCMYKColor
	Field c:Float
	Field m:Float
	Field y:Float
	Field k:Float
End Struct

Rem
bbdoc: 
End Rem
Struct SPDFTransMatrix
	Field a:Float
	Field b:Float
	Field c:Float
	Field d:Float
	Field x:Float
	Field y:Float
End Struct

Rem
bbdoc: 
End Rem
Struct SPDF3DMatrix
	Field a:Float
	Field b:Float
	Field c:Float
	Field d:Float
	Field e:Float
	Field f:Float
	Field g:Float
	Field h:Float
	Field i:Float
	Field tx:Float
	Field ty:Float
	Field tz:Float
End Struct

Rem
bbdoc: 
End Rem
Struct SPDFDashMode
	Field StaticArray ptn:Float[8]
	Field numPtn:UInt
	Field phase:Float
End Struct

Rem
bbdoc: 
End Rem
Struct SPDFRect
	Field left:Float
	Field bottom:Float
	Field right:Float
	Field top:Float

	Method New(left:Float, bottom:Float, right:Float, top:Float)
		Self.left = left
		Self.bottom = bottom
		Self.right = right
		Self.top = top
	End Method
End Struct

Rem
bbdoc: 
End Rem
Struct SPDFTextWidth
	Field numChars:UInt
	Field _numwords:UInt ' unused
	Field width:UInt
	Field numSpace:UInt
End Struct

Struct SPDFDate
	Field year:Int
	Field month:Int
	Field day:Int
	Field hour:Int
	Field minutes:Int
	Field seconds:Int
	Field ind:Byte
	Field offHour:Int
	Field offMinutes:Int
End Struct

Rem
bbdoc: Compression mode.
End Rem
Enum EPDFCompressionMode Flags
	NONE = $00
	TEXT = $01
	IMAGE = $02
	METADATA = $04
	ALL = $0F
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFTextAlignment
	LEFT
	RIGHT
	CENTER
	JUSTIFY
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFTextRenderingMode
	FILL
    STROKE
    FILL_THEN_STROKE
    INVISIBLE
    FILL_CLIPPING
    STROKE_CLIPPING
    FILL_STROKE_CLIPPING
    CLIPPING
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFPageSize
	LETTER
	LEGAL
	A3
	A4
	A5
	B4
	B5
	EXECUTIVE
	US4x6
	US4x8
	US5x7
	COMM10
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFPageDirection
	PORTRAIT
	LANDSCAPE
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFBlendMode
	NORMAL
	MULTIPLY
	SCREEN
	OVERLAY
	DARKEN
	LIGHTEN
	COLOR_DODGE
	COLOR_BUM
	HARD_LIGHT
	SOFT_LIGHT
	DIFFERENCE
	EXCLUSION
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFWritingMode
	HORIZONTAL
	VERTICAL
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFPageLayout
	SINGLE
	ONE_COLUMN
	TWO_COLUMN_LEFT
	TWO_COLUMN_RIGHT
	TWO_PAGE_LEFT
	TWO_PAGE_RIGHT
End Enum

Rem
bbdoc: Document page mode.
End Rem
Enum EPDFPageMode
	USE_NONE
	USE_OUTLINE
	USE_THUMBS
	FULL_SCREEN
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFPageNumStyle
	DECIMAL
	UPPER_ROMAN
	LOWER_ROMAN
	UPPER_LETTERS
	LOWER_LETTERS
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFColorSpace
    DEVICE_GRAY
    DEVICE_RGB
    DEVICE_CMYK
    CAL_GRAY
    CAL_RGB
    LAB
    ICC_BASED
    SEPARATION
    DEVICE_N
    INDEXED
    PATTERN
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFEncryptMode
	R2
	R3
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFInfoType
	CREATION_DATE
    MOD_DATE
    AUTHOR
    CREATOR
    PRODUCER
    TITLE
    SUBJECT
    KEYWORDS
    TRAPPED
    GTS_PDFX
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFTransitionStyle
    WIPE_RIGHT
    WIPE_UP
    WIPE_LEFT
    WIPE_DOWN
    BARN_DOORS_HORIZONTAL_OUT
    BARN_DOORS_HORIZONTAL_IN
    BARN_DOORS_VERTICAL_OUT
    BARN_DOORS_VERTICAL_IN
    BOX_OUT
    BOX_IN
    BLINDS_HORIZONTAL
    BLINDS_VERTICAL
    DISSOLVE
    GLITTER_RIGHT
    GLITTER_DOWN
    GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT
    REPLACE
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFAnnotHighlightMode
	NO_HIGHTLIGHT
	INVERT_BOX
	INVERT_BORDER
	DOWN_APPEARANCE
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFAnnotIcon
    COMMENT
    KEY
    NOTE
	HELP
    NEW_PARAGRAPH
    PARAGRAPH
    INSERT
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFBSSubtype
    SOLID
    DASHED
    BEVELED
    INSET
    UNDERLINED
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFEncoderType
	SINGLE_BYTE
    DOUBLE_BYTE
    UNINITIALIZED
End Enum

Rem
bbdoc: 
End Rem
Enum EPDFByteType
    SINGLE
    LEAD
    TRAIL
End Enum

Rem
bbdoc: Succeeded.
End Rem
Const HPDF_OK:ULongInt = 0
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_ARRAY_COUNT_ERR:ULongInt = $1001
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_ARRAY_ITEM_NOT_FOUND:ULongInt = $1002
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_ARRAY_ITEM_UNEXPECTED_TYPE:ULongInt = $1003
Rem
bbdoc: Data length > HPDF_LIMIT_MAX_STRING_LEN.
End Rem
Const HPDF_BINARY_LENGTH_ERR:ULongInt = $1004
Rem
bbdoc: Cannot get pallet data from PNG image.
End Rem
Const HPDF_CANNOT_GET_PALLET:ULongInt = $1005
Rem
bbdoc: Dictionary elements > HPDF_LIMIT_MAX_DICT_ELEMENT
End Rem
Const HPDF_DICT_COUNT_ERR:ULongInt = $1007
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_DICT_ITEM_NOT_FOUND:ULongInt = $1008
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_DICT_ITEM_UNEXPECTED_TYPE:ULongInt = $1009
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_DICT_STREAM_LENGTH_NOT_FOUND:ULongInt = $100A
Rem
bbdoc: HPDF_SetEncryptMode() or HPDF_SetPermission() called before password set.
End Rem
Const HPDF_DOC_ENCRYPTDICT_NOT_FOUND:ULongInt = $100B
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_DOC_INVALID_OBJECT:ULongInt = $100C
Rem
bbdoc: Tried to re-register a registered font.
End Rem
Const HPDF_DUPLICATE_REGISTRATION:ULongInt = $100E
Rem
bbdoc: Cannot register a character to the Japanese word wrap characters list.
End Rem
Const HPDF_EXCEED_JWW_CODE_NUM_LIMIT:ULongInt = $100F
Rem
bbdoc: Tried to set the owner password to Null, or Owner and user password are the same.
End Rem
Const HPDF_ENCRYPT_INVALID_PASSWORD:ULongInt = $1011
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_ERR_UNKNOWN_CLASS:ULongInt = $1013
Rem
bbdoc: Stack depth > HPDF_LIMIT_MAX_GSTATE.
End Rem
Const HPDF_EXCEED_GSTATE_LIMIT:ULongInt = $1014
Rem
bbdoc: Memory allocation failed.
End Rem
Const HPDF_FAILD_TO_ALLOC_MEM:ULongInt = $1015
Rem
bbdoc: File processing failed. (Detailed code is set.)
End Rem
Const HPDF_FILE_IO_ERROR:ULongInt = $1016
Rem
bbdoc: Cannot open a file. (Detailed code is set.)
End Rem
Const HPDF_FILE_OPEN_ERROR:ULongInt = $1017
Rem
bbdoc: Tried to load a font that has been registered.
End Rem
Const HPDF_FONT_EXISTS:ULongInt = $1019
Rem
bbdoc: Font-file format is invalid.
about: Internal error. Data consistency was lost.
End Rem
Const HPDF_FONT_INVALID_WIDTHS_TABLE:ULongInt = $101A
Rem
bbdoc: Cannot recognize header of afm file.
End Rem
Const HPDF_INVALID_AFM_HEADER:ULongInt = $101B
Rem
bbdoc: Specified annotation handle is invalid.
End Rem
Const HPDF_INVALID_ANNOTATION:ULongInt = $101C
Rem
bbdoc: Bit-per-component of a image which was set as mask-image is invalid.
End Rem
Const HPDF_INVALID_BIT_PER_COMPONENT:ULongInt = $101E
Rem
bbdoc: Cannot recognize char-matrics-data of afm file.
End Rem
Const HPDF_INVALID_CHAR_MATRICS_DATA:ULongInt = $101F
Rem
bbdoc: Invalid color_space parameter of HPDF_LoadRawImage.
about: Color-space of a image which was set as mask-image is invalid.

Invoked function invalid in present color-space.
End Rem
Const HPDF_INVALID_COLOR_SPACE:ULongInt = $1020
Rem
bbdoc: Invalid value set when invoking HPDF_SetCommpressionMode().
End Rem
Const HPDF_INVALID_COMPRESSION_MODE:ULongInt = $1021
Rem
bbdoc: An invalid date-time value was set.
End Rem
Const HPDF_INVALID_DATE_TIME:ULongInt = $1022
Rem
bbdoc: An invalid destination handle was set.
End Rem
Const HPDF_INVALID_DESTINATION:ULongInt = $1023
Rem
bbdoc: An invalid document handle was set.
End Rem
Const HPDF_INVALID_DOCUMENT:ULongInt = $1025
Rem
bbdoc: Function invalid in the present state was invoked.
End Rem
Const HPDF_INVALID_DOCUMENT_STATE:ULongInt = $1026
Rem
bbdoc: An invalid encoder handle was set.
End Rem
Const HPDF_INVALID_ENCODER:ULongInt = $1027
Rem
bbdoc: Combination between font and encoder is wrong.
End Rem
Const HPDF_INVALID_ENCODER_TYPE:ULongInt = $1028
Rem
bbdoc: An Invalid encoding name is specified.
End Rem
Const HPDF_INVALID_ENCODING_NAME:ULongInt = $102B
Rem
bbdoc: Encryption key length is invalid.
End Rem
Const HPDF_INVALID_ENCRYPT_KEY_LEN:ULongInt = $102C
Rem
bbdoc: An invalid font handle was set.
about: Unsupported font format.
End Rem
Const HPDF_INVALID_FONTDEF_DATA:ULongInt = $102D
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_INVALID_FONTDEF_TYPE:ULongInt = $102E
Rem
bbdoc: Font with the specified name is not found.
End Rem
Const HPDF_INVALID_FONT_NAME:ULongInt = $102F
Rem
bbdoc: Unsupported image format.
End Rem
Const HPDF_INVALID_IMAGE:ULongInt = $1030
Rem
bbdoc: Unsupported image format.
End Rem
Const HPDF_INVALID_JPEG_DATA:ULongInt = $1031
Rem
bbdoc: Cannot read a postscript-name from an afm file.
End Rem
Const HPDF_INVALID_N_DATA:ULongInt = $1032
Rem
bbdoc: An invalid object is set.
about: Internal error. Data consistency was lost.
End Rem
Const HPDF_INVALID_OBJECT:ULongInt = $1033
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_INVALID_OBJ_ID:ULongInt = $1034
Rem
bbdoc: Invoked HPDF_Image_SetColorMask() against the image-object which was set a mask-image.
End Rem
Const HPDF_INVALID_OPERATION:ULongInt = $1035
Rem
bbdoc: An invalid outline-handle was specified.
End Rem
Const HPDF_INVALID_OUTLINE:ULongInt = $1036
Rem
bbdoc: An invalid page-handle was specified.
End Rem
Const HPDF_INVALID_PAGE:ULongInt = $1037
Rem
bbdoc: An invalid pages-handle was specified. (internal error)
End Rem
Const HPDF_INVALID_PAGES:ULongInt = $1038
Rem
bbdoc: An invalid value is set.
End Rem
Const HPDF_INVALID_PARAMETER:ULongInt = $1039
Rem
bbdoc: Invalid PNG image format.
End Rem
Const HPDF_INVALID_PNG_IMAGE:ULongInt = $103B
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_INVALID_STREAM:ULongInt = $103C
Rem
bbdoc: Internal error. "_FILE_NAME" entry for delayed loading is missing.
End Rem
Const HPDF_MISSING_FILE_NAME_ENTRY:ULongInt = $103D
Rem
bbdoc: Invalid .TTC file format.
End Rem
Const HPDF_INVALID_TTC_FILE:ULongInt = $103F
Rem
bbdoc: Index parameter > number of included fonts.
End Rem
Const HPDF_INVALID_TTC_INDEX:ULongInt = $1040
Rem
bbdoc: Cannot read a width-data from an afm file.
End Rem
Const HPDF_INVALID_WX_DATA:ULongInt = $1041
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_ITEM_NOT_FOUND:ULongInt = $1042
Rem
bbdoc: Error returned from PNGLIB while loading image.
End Rem
Const HPDF_LIBPNG_ERROR:ULongInt = $1043
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_NAME_INVALID_VALUE:ULongInt = $1044
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_NAME_OUT_OF_RANGE:ULongInt = $1045
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_PAGES_MISSING_KIDS_ENTRY:ULongInt = $1049
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_PAGE_CANNOT_FIND_OBJECT:ULongInt = $104A
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_PAGE_CANNOT_GET_ROOT_PAGES:ULongInt = $104B
Rem
bbdoc: There are no graphics-states to be restored.
End Rem
Const HPDF_PAGE_CANNOT_RESTORE_GSTATE:ULongInt = $104C
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_PAGE_CANNOT_SET_PARENT:ULongInt = $104D
Rem
bbdoc: The current font is not set.
End Rem
Const HPDF_PAGE_FONT_NOT_FOUND:ULongInt = $104E
Rem
bbdoc: An invalid font-handle was specified.
End Rem
Const HPDF_PAGE_INVALID_FONT:ULongInt = $104F
Rem
bbdoc: An invalid font-size was set.
End Rem
Const HPDF_PAGE_INVALID_FONT_SIZE:ULongInt = $1050
Rem
bbdoc: See Graphics mode.
End Rem
Const HPDF_PAGE_INVALID_GMODE:ULongInt = $1051
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_PAGE_INVALID_INDEX:ULongInt = $1052
Rem
bbdoc: Specified value is not multiple of 90.
End Rem
Const HPDF_PAGE_INVALID_ROTATE_VALUE:ULongInt = $1053
Rem
bbdoc: An invalid page-size was set.
End Rem
Const HPDF_PAGE_INVALID_SIZE:ULongInt = $1054
Rem
bbdoc: An invalid image-handle was set.
End Rem
Const HPDF_PAGE_INVALID_XOBJECT:ULongInt = $1055
Rem
bbdoc: The specified value is out of range.
End Rem
Const HPDF_PAGE_OUT_OF_RANGE:ULongInt = $1056
Rem
bbdoc: The specified value is out of range.
End Rem
Const HPDF_REAL_OUT_OF_RANGE:ULongInt = $1057
Rem
bbdoc: Unexpected EOF marker was detected.
End Rem
Const HPDF_STREAM_EOF:ULongInt = $1058
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_STREAM_READLN_CONTINUE:ULongInt = $1059
Rem
bbdoc: The length of the text is too long.
End Rem
Const HPDF_STRING_OUT_OF_RANGE:ULongInt = $105B
Rem
bbdoc: Function not executed because of other errors.
End Rem
Const HPDF_THIS_FUNC_WAS_SKIPPED:ULongInt = $105C
Rem
bbdoc: Font cannot be embedded. (license restriction)
End Rem
Const HPDF_TTF_CANNOT_EMBEDDING_FONT:ULongInt = $105D
Rem
bbdoc: Unsupported ttf format. (cannot find unicode cmap)
End Rem
Const HPDF_TTF_INVALID_CMAP:ULongInt = $105E
Rem
bbdoc: Unsupported ttf format.
End Rem
Const HPDF_TTF_INVALID_FOMAT:ULongInt = $105F
Rem
bbdoc: Unsupported ttf format. (cannot find a necessary table)
End Rem
Const HPDF_TTF_MISSING_TABLE:ULongInt = $1060
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_UNSUPPORTED_FONT_TYPE:ULongInt = $1061
Rem
bbdoc: Library not configured to use PNGLIB.
about: Internal error. Data consistency was lost.
End Rem
Const HPDF_UNSUPPORTED_FUNC:ULongInt = $1062
Rem
bbdoc: Unsupported JPEG format.
End Rem
Const HPDF_UNSUPPORTED_JPEG_FORMAT:ULongInt = $1063
Rem
bbdoc: Failed to parse .PFB file.
End Rem
Const HPDF_UNSUPPORTED_TYPE1_FONT:ULongInt = $1064
Rem
bbdoc: Internal error. Data consistency was lost.
End Rem
Const HPDF_XREF_COUNT_ERR:ULongInt = $1065
Rem
bbdoc: Error while executing ZLIB function.
End Rem
Const HPDF_ZLIB_ERROR:ULongInt = $1066
Rem
bbdoc: An invalid page index was passed.
End Rem
Const HPDF_INVALID_PAGE_INDEX:ULongInt = $1067
Rem
bbdoc: An invalid URI was set.
End Rem
Const HPDF_INVALID_URI:ULongInt = $1068
Rem
bbdoc: An invalid page-layout was set.
End Rem
Const HPDF_PAGELAYOUT_OUT_OF_RANGE:ULongInt = $1069
Rem
bbdoc: An invalid page-mode was set.
End Rem
Const HPDF_PAGEMODE_OUT_OF_RANGE:ULongInt = $1070
Rem
bbdoc: An invalid page-num-style was set.
End Rem
Const HPDF_PAGENUM_STYLE_OUT_OF_RANGE:ULongInt = $1071
Rem
bbdoc: An invalid icon was set.
End Rem
Const HPDF_ANNOT_INVALID_ICON:ULongInt = $1072
Rem
bbdoc: An invalid border-style was set.
End Rem
Const HPDF_ANNOT_INVALID_BORDER_STYLE:ULongInt = $1073
Rem
bbdoc: An invalid page-direction was set.
End Rem
Const HPDF_PAGE_INVALID_DIRECTION:ULongInt = $1074
Rem
bbdoc: An invalid font-handle was specified.
End Rem
Const HPDF_INVALID_FONT:ULongInt = $1075
Const HPDF_PAGE_INSUFFICIENT_SPACE:ULongInt = $1076
Const HPDF_PAGE_INVALID_DISPLAY_TIME:ULongInt = $1077
Const HPDF_PAGE_INVALID_TRANSITION_TIME:ULongInt = $1078
Const HPDF_INVALID_PAGE_SLIDESHOW_TYPE:ULongInt = $1079
Const HPDF_EXT_GSTATE_OUT_OF_RANGE:ULongInt = $1080
Const HPDF_INVALID_EXT_GSTATE:ULongInt = $1081
Const HPDF_EXT_GSTATE_READ_ONLY:ULongInt = $1082
Const HPDF_INVALID_U3D_DATA:ULongInt = $1083
Const HPDF_NAME_CANNOT_GET_NAMES:ULongInt = $1084
Const HPDF_INVALID_ICC_COMPONENT_NUM:ULongInt = $1085
Const HPDF_INVALID_SHADING_TYPE:ULongInt = $1088

Rem
bbdoc: The default line width.
End Rem
Const HPDF_DEF_LINEWIDTH:Float = 1
