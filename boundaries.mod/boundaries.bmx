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
bbdoc: Optional Unicode text boundary provider interface, independent of graphics and fonts.
End Rem
Module Text.Boundaries
ModuleInfo "Version: 1.00"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: zlib/libpng"
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release"

Const TEXT_BOUNDARY_NONE:Int = 0
Const TEXT_BOUNDARY_ALLOWED:Int = 1
Const TEXT_BOUNDARY_MANDATORY:Int = 2

Rem
bbdoc: Boundary maps to calculate; combine flags with |.
End Rem
Enum ETextBoundaryMaps Flags
	None = 0
	Line = 1
	Word = 2
	Grapheme = 4
	All = Line | Word | Grapheme
End Enum

Rem
bbdoc: Selects automatic, basic or required Unicode text breaking.
End Rem
Enum ETextBreakMode
	Auto = 0
	Basic = 1
	Unicode = 2
End Enum

Rem
bbdoc: Boundary arrays indexed by BlitzMax UTF-16 string offsets, from zero through text.Length.
about: Array indices are string offsets; byte values are boundary flags, never offsets. A nonzero entry describes a boundary before that offset. Line entries distinguish allowed and mandatory breaks. Word and grapheme entries are Boolean. Unrequested maps are Null. Treat results as read-only.
End Rem
Type TTextBoundaries
	Field lineBreaks:Byte[]
	Field wordBreaks:Byte[]
	Field graphemeBreaks:Byte[]
End Type

Type TTextBoundaryProvider Abstract
	Method Name:String() Abstract
	Rem
	bbdoc: Analyzes the requested boundary maps, defaulting to all three.
	about: Combine ETextBoundaryMaps.Line, ETextBoundaryMaps.Word and ETextBoundaryMaps.Grapheme with |. Unrequested maps remain Null; maps = ETextBoundaryMaps.None requests none. Each requested map has text.Length + 1 entries, even for empty text. Providers must skip allocation and analysis for unrequested maps.
	End Rem
	Method Analyze:TTextBoundaries(text:String, language:String = "", maps:ETextBoundaryMaps = ETextBoundaryMaps.All) Abstract
End Type

Private
Global boundaryProvider:TTextBoundaryProvider
Public

Rem
bbdoc: Registers a process-wide default provider. Passing Null removes it.
about: Register during application/module initialization, before starting concurrent preparation. Existing results remain valid.
End Rem
Function RegisterTextBoundaryProvider(provider:TTextBoundaryProvider)
	boundaryProvider = provider
End Function
Function GetTextBoundaryProvider:TTextBoundaryProvider()
	Return boundaryProvider
End Function
Function UnicodeTextBoundariesAvailable:Int()
	Return boundaryProvider <> Null
End Function
