' Copyright (c) 2026 Bruce A Henderson
'
' This software is provided 'as-is', without any express or implied warranty.
' In no event will the authors be held liable for any damages arising from
' the use of this software.
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

Rem
bbdoc: Unicode line, word and grapheme boundaries using bundled libunibreak.
about: Importing this module registers the Unicode provider with Text.Boundaries. All offsets use BlitzMax UTF-16 string indexing.
End Rem
Module Text.Unibreak
ModuleInfo "Version: 1.00"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: zlib/libpng; Unicode data licence"
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release; Unicode 17.0 boundary tables"
ModuleInfo "CC_OPTS: -std=c99"

Import "common.bmx"

Rem
bbdoc: Returns allowed/mandatory line boundaries at string offsets (Length + 1 entries).
about: The array index is the UTF-16 string offset; the byte stored there is a status (0 = none, 1 = allowed, 2 = mandatory), not an offset. Index zero is not a line break. End of text is allowed unless it is already a mandatory break. No dictionary-based segmentation or automatic hyphenation is provided.
End Rem
Function UnibreakLineBreaks:Byte[](text:String, language:String = "")
	Local result:Byte[] = New Byte[text.Length + 1]
	bmx_unibreak_boundaries(text, language, 0, result)
	Return result
End Function

Rem
bbdoc: Returns Boolean word boundaries at string offsets (Length + 1 entries).
End Rem
Function UnibreakWordBreaks:Byte[](text:String, language:String = "")
	Local result:Byte[] = New Byte[text.Length + 1]
	bmx_unibreak_boundaries(text, language, 1, result)
	Return result
End Function

Rem
bbdoc: Returns Boolean extended-grapheme boundaries at string offsets (Length + 1 entries).
End Rem
Function UnibreakGraphemeBreaks:Byte[](text:String, language:String = "")
	Local result:Byte[] = New Byte[text.Length + 1]
	bmx_unibreak_boundaries(text, language, 2, result)
	Return result
End Function

Type TUnibreakProvider Extends TTextBoundaryProvider
	Method Name:String() Override
		Return "libunibreak / Unicode 17.0"
	End Method
	Method Analyze:TTextBoundaries(text:String, language:String = "", maps:ETextBoundaryMaps = ETextBoundaryMaps.All) Override
		Local result:TTextBoundaries = New TTextBoundaries
		If (maps & ETextBoundaryMaps.Line) <> ETextBoundaryMaps.None Then result.lineBreaks = UnibreakLineBreaks(text, language)
		If (maps & ETextBoundaryMaps.Word) <> ETextBoundaryMaps.None Then result.wordBreaks = UnibreakWordBreaks(text, language)
		If (maps & ETextBoundaryMaps.Grapheme) <> ETextBoundaryMaps.None Then result.graphemeBreaks = UnibreakGraphemeBreaks(text, language)
		Return result
	End Method
End Type

bmx_unibreak_init()
RegisterTextBoundaryProvider(New TUnibreakProvider)
