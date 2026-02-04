' Copyright (c) 2024 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict


Import Brl.FreeTypeFont
Import Collections.HashMap
Import "source.bmx"

Extern

	Function bmx_hb_ft_font_create:Byte Ptr(ftface:Byte Ptr)
	Function bmx_hb_ft_font_destroy(font:Byte Ptr)
	Function bmx_hb_ft_font_features:Byte Ptr(style:Int, length:Int Var)
	Function bmx_hb_buffer_create:Byte Ptr()
	Function bmx_hb_buffer_destroy(buffer:Byte Ptr)
	Function bmx_hb_buffer_calc_glyph_info(font:Byte Ptr, buffer:Byte Ptr, features:Byte Ptr, featuresLength:Int, char:Int, glyphInfo:SGlyphPosition Var)
	Function bmx_hb_features_destroy(features:Byte Ptr)

	Function bmx_hb_buffer_calc_glyphs_info:SGlyphPosition Ptr(font:Byte Ptr, buffer:Byte Ptr, features:Byte Ptr, featuresLength:Int, text:String, length:Int Var)
	Function bmx_hb_buffer_calc_glyphs_info_destroy(glyphs:SGlyphPosition Ptr)
End Extern

Struct SGlyphPosition
	Field glyphIndex:Int
	Field xAdvance:Int
	Field yAdvance:Int
	Field xOffset:Int
	Field yOffset:Int

	Method Operator=:Int(rhs:SGlyphPosition)
		Return glyphIndex = rhs.glyphIndex And ..
			xAdvance = rhs.xAdvance And ..
			yAdvance = rhs.yAdvance And ..
			xOffset = rhs.xOffset And ..
			yOffset = rhs.yOffset
	End Method
End Struct
