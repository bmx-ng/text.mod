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

Import Text.Bidi
Import "source.bmx"

Extern "C"
	Function bmx_sheen_create:Byte Ptr(text:String,direction:Int,baseLevel:Int Var)
	Function bmx_sheen_free(handle:Byte Ptr)
	Function bmx_sheen_line:Byte Ptr(handle:Byte Ptr,first:Int,length:Int,count:Int Var)
	Function bmx_sheen_run(runs:Byte Ptr,index:Int,first:Int Var,last:Int Var,level:Int Var,script:Int Var)
	Function bmx_sheen_runs_free(runs:Byte Ptr)
End Extern
