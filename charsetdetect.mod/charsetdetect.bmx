' Copyright (c) 2024 Carl Arwed Husberg
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

Rem
bbdoc: A charset detector
EndRem
Module Text.CharsetDetect

Import "common.bmx"

Rem
bbdoc: A charset detector
EndRem
Type TCharsetDetect

Private
	Field obj:Byte Ptr
	
Public
	Rem
	bbdoc: Creates a new charset detect object
	EndRem
	Method New()
		obj = detect_obj_init()
	EndMethod
	
	Rem
	bbdoc: Detects the charset of a buffer
	EndRem
	Method Detect:Int(buf:Byte Ptr, buflen:Size_T)
		Return detect_r(buf, buflen, Varptr obj) = 0
	EndMethod
	
	Rem
	bbdoc: Detects the charset of a string
	EndRem
	Method Detect:Int(data:String)
		Local buf:Byte Ptr = data.ToCString()
		Local res:Short = detect_r(buf, SizeOf data, Varptr obj)
		MemFree(buf)
		Return res = 0
	EndMethod
	
	Rem
	bbdoc: Returns the encoding detected
	EndRem
	Method GetEncoding:String()
		Local buf:Byte Ptr = bmx_chardet_encoding(obj)
		
		If buf
			Return String.FromCString(buf)
		EndIf
	EndMethod
	
	Rem
	bbdoc: Returns the confidence in the encoding detected (0.0 to 1.0)
	EndRem
	Method GetConfidence:Float()
		Return bmx_chardet_confidence(obj)
	EndMethod
	
	Rem
	bbdoc: Returns true if the encoding uses BOM (Byte Order Mark) to signal the encoding used
	EndRem
	Method GetBOM:Short()
		Return bmx_chardet_bom(obj)
	EndMethod
	
Private
	Method Free()
		If obj
			detect_obj_free(Varptr obj)
			obj = Null
		EndIf
	EndMethod
	
	Method Delete()
		Free()
	EndMethod
	
EndType