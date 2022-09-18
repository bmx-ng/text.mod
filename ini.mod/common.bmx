' Copyright (c) 2022 Bruce A Henderson
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

Import BRL.Stream

Import "src/*.h"
Import "glue.c"


Extern
	Function ini_create:Byte Ptr(mem:Byte Ptr)
	Function ini_load:Byte Ptr(data:Byte Ptr, mem:Byte Ptr)
	Function ini_destroy(ini:Byte Ptr)
	Function ini_save:Int(ini:Byte Ptr, data:Byte Ptr, size:Int)
	
	Function ini_section_count:Int(ini:Byte Ptr)
	Function bmx_ini_section_name:String(ini:Byte Ptr, section:Int)
	Function bmx_ini_find_section:Int(ini:Byte Ptr, name:String)
	Function bmx_ini_section_name_set(ini:Byte Ptr, section:Int, name:String)
	Function ini_section_remove(ini:Byte Ptr, section:Int)
	Function bmx_ini_section_add:Int(ini:Byte Ptr, name:String)

	Function ini_property_count:Int(ini:Byte Ptr, section:Int)
	Function bmx_ini_property_add(ini:Byte Ptr, section:Int, name:String, value:String)

	Function bmx_ini_property_name:String(ini:Byte Ptr, section:Int, property:Int)
	Function bmx_ini_property_value:String(ini:Byte Ptr, section:Int, property:Int)
	Function ini_property_remove(ini:Byte Ptr, section:Int, property:Int)
	Function bmx_ini_property_value_set(ini:Byte Ptr, section:Int, property:Int, value:String)
	Function bmx_ini_property_name_set(ini:Byte Ptr, section:Int, property:Int, name:String)
End Extern

Rem
bbdoc: The index that indicates the global section.
End Rem
Const INI_GLOBAL_SECTION:Int = 0
Const INI_NOT_FOUND:Int = -1
