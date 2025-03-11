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

Rem
bbdoc: A font implementation that uses FreeType and HarfBuzz to render text.
End Rem
Module Text.HBFreeTypeFont


ModuleInfo "CPP_OPTS: -std=c++11"
ModuleInfo "CC_OPTS: -DHAVE_FREETYPE"

?linux
ModuleInfo "CC_OPTS: `pkg-config --cflags freetype2`"
?

Import "common.bmx"

Private

Function PadPixmap:TPixmap( p:TPixmap )
	Local t:TPixmap=TPixmap.Create( p.width+2,p.height+2,p.format )
	MemClear t.pixels,Size_T(t.capacity)
	t.Paste p,1,1
	Return t
End Function

Public
Type THBFreeTypeFont Extends BRL.Font.TFont

	Field _ft_face:Byte Ptr
	Field _hb_font:Byte Ptr
	Field _style:Int
	Field _height:Int
	Field _ascend:Int
	Field _descend:Int
	Field _glyphs:TFreeTypeGlyph[]
	Field _buf:Byte[]

	Field _buffer:Byte Ptr
	Field _featuresLength:Int
	Field _features:Byte Ptr

	Field _glyphMap:TTreeMap<Int,SGlyphPosition> = New TTreeMap<Int,SGlyphPosition>
	Field _positionMap:TTreeMap<Int,SGlyphPosition> = New TTreeMap<Int,SGlyphPosition>

	Method Delete()
		bmx_hb_ft_font_destroy(_hb_font)
		bmx_hb_buffer_destroy(_buffer)
		bmx_hb_features_destroy(_features)
		FT_Done_Face _ft_face
	End Method

	Method Style:Int() Override
		Return _style
	End Method

	Method Height:Int() Override
		Return _height
	End Method
	
	Method CountGlyphs:Int() Override
		Return _glyphs.length
	End Method
	
	Method CharToGlyph:Int( char:Int ) Override

		Local info:SGlyphPosition

		If Not _glyphMap.TryGetValue(char, info) Then
			bmx_hb_buffer_calc_glyph_info(_hb_font, _buffer, _features, _featuresLength, char, info)

			_glyphMap.Add(char, info)
			_positionMap.Add(info.glyphIndex, info)
		End If

		Return info.glyphIndex
	End Method

	Method LoadGlyph:TFreeTypeGlyph( index:Int ) Override

		Local glyph:TFreeTypeGlyph=_glyphs[index]
		If glyph Return glyph

		glyph=New TFreeTypeGlyph
		_glyphs[index]=glyph

		If FT_Load_Glyph( _ft_face,index,FT_LOAD_RENDER ) Return glyph

		Local info:SGlyphPosition
		_positionMap.TryGetValue(index, info)

		BuildGlyph(glyph, info)
		
		Return glyph

	End Method

	Method BuildGlyph(glyph:TFreeTypeGlyph, info:SGlyphPosition)
		Local _slot:Byte Ptr = bmx_freetype_Face_glyph(_ft_face)

		Local width:Int = bmx_freetype_Slot_bitmap_width(_slot)
		Local rows:Int = bmx_freetype_Slot_bitmap_rows(_slot)
		Local pitch:Int = bmx_freetype_Slot_bitmap_pitch(_slot)
		Local advancex:Int = info.xAdvance
		Local buffer:Byte Ptr = bmx_freetype_Slot_bitmap_buffer(_slot)
		
		glyph._x=bmx_freetype_Slot_bitmapleft(_slot) + info.xOffset
		glyph._y=-bmx_freetype_Slot_bitmaptop(_slot)+_ascend + info.yOffset
		glyph._w=width
		glyph._h=rows
		glyph._advance=advancex Sar 6
		
		If width=0 Return
	
		If Not glyph._pixmap Then
			Local pixmap:TPixmap
			
			If bmx_freetype_Slot_bitmap_numgreys(_slot)
				pixmap=TPixmap.CreateStatic( buffer,width,rows,pitch,PF_A8 ).Copy()
			Else
				pixmap=CreatePixmap( width,rows,PF_A8 )
				Local b:Int
				For Local y:Int=0 Until rows
					Local dst:Byte Ptr=pixmap.PixelPtr(0,y)
					Local src:Byte Ptr=buffer+y*pitch
					For Local x:Int=0 Until width
						If (x&7)=0 b=src[x/8]
						If b & $80 dst[x]=$ff Else dst[x]=0
						b:+b
					Next
				Next
			EndIf
			
			If _style & SMOOTHFONT
				glyph._x:-1
				glyph._y:-1
				glyph._w:+2
				glyph._h:+2
				pixmap=PadPixmap(pixmap)
			EndIf
			
			glyph._pixmap=pixmap
		End If
	End Method

	Method LoadGlyphs:TGlyph[]( text:String )
		
		Local length:Int

		Local infos:SGlyphPosition Ptr = bmx_hb_buffer_calc_glyphs_info(_hb_font, _buffer, _features, _featuresLength, text, length)

		Local glyphs:TFreeTypeGlyph[] = New TFreeTypeGlyph[length]

		For Local i:Int = 0 Until length

			Local index:Int = infos[i].glyphIndex

			Local cachedGlyph:TFreeTypeGlyph = _glyphs[index]

			Local glyph:TFreeTypeGlyph = New TFreeTypeGlyph

			If cachedGlyph Then
				glyph._pixmap = cachedGlyph._pixmap
			End If

			glyphs[i] = glyph

			If FT_Load_Glyph( _ft_face,index,FT_LOAD_RENDER ) Continue

			BuildGlyph(glyph, infos[i])

			If Not cachedGlyph Then
				_glyphs[index] = glyph
			Else If Not cachedGlyph._pixmap Then
				cachedGlyph._pixmap = glyph._pixmap
			End If

		Next

		bmx_hb_buffer_calc_glyphs_info_destroy(infos)

		Return glyphs
	End Method

	Function Load:THBFreeTypeFont( src:Object,size:Float,style:Int )

		Local buf:Byte[]

		Local ft_face:Byte Ptr = TFreeTypeFont.LoadFace(src, size, style, buf)

		If Not ft_face Then
			Return Null
		End If

		Local ft_size:Byte Ptr = bmx_freetype_Face_size(ft_face)

		Local font:THBFreeTypeFont = New THBFreeTypeFont
		font._ft_face = ft_face
		font._hb_font = bmx_hb_ft_font_create(ft_face)
		font._style = style
		font._buf = buf
		font._buffer = bmx_hb_buffer_create()
		font._features = bmx_hb_ft_font_features(style, font._featuresLength)
		font._height=bmx_freetype_Size_height(ft_size) Sar 6
		font._ascend=bmx_freetype_Size_ascend(ft_size) Sar 6
		font._descend=bmx_freetype_Size_descend(ft_size) Sar 6
		font._glyphs=New TFreeTypeGlyph[bmx_freetype_Face_numglyphs(ft_face)]

		Return font
	End Function

End Type

Type THBFreeTypeFontLoader Extends TFontLoader

	Method LoadFont:THBFreeTypeFont( url:Object,size:Float,style:Int ) Override
	
		Return THBFreeTypeFont.Load( url,size,style )
	
	End Method

End Type

AddFontLoader New THBFreeTypeFontLoader
