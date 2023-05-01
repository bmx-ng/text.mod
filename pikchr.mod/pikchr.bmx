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

Rem
bbdoc: A PIC-like markup language for diagrams in technical documentation.
End Rem
Module Text.Pikchr

ModuleInfo "Version: 1.00"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: zlib/libpng"
ModuleInfo "pikchr - Copyright (C) 2020-09-01 by D. Richard Hipp <drh@sqlite.org>"
ModuleInfo "Copyright: 2023 Bruce A Henderson"

ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release"

Import "common.bmx"

Rem
bbdoc: Converts a #String of Pikchr markup, returning an SVG #String.
End Rem
Function PikChr:String(txt:String, class:String, flags:EPikChrFlags, width:Int Var, height:Int Var)
	Local t:Byte Ptr = txt.ToUTF8String()
	Local c:Byte Ptr
	If class Then
		c = class.ToUTF8String()
	End If

	Local w:Int, h:Int
	Local s:Byte Ptr = pikchr_(t, c, flags, VarPtr w, VarPtr h)

	width = w
	height = h

	MemFree(c)
	MemFree(t)

	Local res:String = String.FromUTF8String(s)
	free_(s)
	Return res
End Function

Private

Extern
	Function pikchr_:Byte Ptr(zText:Byte Ptr, zClass:Byte Ptr, mFlags:EPikChrFlags, pnWidth:Int Ptr, pnHeight:Int Ptr)="pikchr"
	Function free_( buf:Byte Ptr )="void free( void * ) !"
End Extern
