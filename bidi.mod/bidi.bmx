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
bbdoc: Optional bidirectional paragraph analysis, independent of graphics and fonts.
End Rem
Module Text.Bidi
ModuleInfo "Version: 1.00"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: zlib/libpng"

Rem
bbdoc: Auto uses an imported provider; Disabled skips all bidi analysis. Explicit directions require a provider.
End Rem
Enum ETextDirection
	Auto = 0
	Disabled = 1
	LeftToRight = 2
	RightToLeft = 3
End Enum

Rem
bbdoc: One logical source range in a visually ordered line. Offsets are UTF-16 and relative to the requested line.
about: Odd embedding levels mean right-to-left. script is an ISO 15924 tag encoded as a 32-bit integer. Treat results as read-only.
End Rem
Type TTextBidiRun
	Field first:Int,last:Int,level:Int,script:Int
End Type

Type TTextBidiParagraph Abstract
	Field length:Int,baseLevel:Int
	Rem
	bbdoc: Resolves line-end whitespace and returns script/level runs in left-to-right visual order.
	about: first and length refer to the analyzed paragraph, not the original pre-normalized application string. Empty lines return an empty array. The paragraph remains usable after provider registration changes.
	End Rem
	Method Line:TTextBidiRun[](first:Int,length:Int) Abstract
End Type

Type TTextBidiProvider Abstract
	Method Name:String() Abstract
	Method Analyze:TTextBidiParagraph(text:String,direction:ETextDirection=ETextDirection.Auto) Abstract
End Type

Private
Global bidiProvider:TTextBidiProvider
Public

Rem
bbdoc: Registers a default provider during initialization; Null removes it. Existing paragraphs remain valid.
End Rem
Function RegisterTextBidiProvider(provider:TTextBidiProvider)
	bidiProvider=provider
End Function
Function GetTextBidiProvider:TTextBidiProvider()
	Return bidiProvider
End Function
Function UnicodeTextBidiAvailable:Int()
	Return bidiProvider<>Null
End Function
