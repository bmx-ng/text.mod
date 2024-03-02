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

Import "source.bmx"

Extern
	
	Function detect_obj_init:Byte Ptr()
	Function detect_r:Short(buf:Byte Ptr, buflen:Size_T, obj:Byte Ptr)
	Function detect_obj_free(obj:Byte Ptr Var)
	
	Function bmx_chardet_encoding:Byte Ptr(obj:Byte Ptr)
	Function bmx_chardet_confidence:Float(obj:Byte Ptr)
	Function bmx_chardet_bom:Short(obj:Byte Ptr)
	
EndExtern