' Copyright (c) 2022-2023 Bruce A Henderson
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

Import BRL.Map
Import BRL.Stream

Import "zsv/include/*.h"

Import "zsv/src/zsv.c"


Import "glue.c"

Extern
	Function bmx_csv_opts_new:Byte Ptr(obj:Object)
	Function bmx_csv_opts_free(opts:Byte Ptr)
	Function bmx_csv_opts_set_options(opts:Byte Ptr, maxColumns:UInt, delimiter:Int, noQuotes:Int, insertHeaderRow:Byte Ptr, headerSpan:UInt, rowsToIgnore:UInt, keepEmptyHeaderRows:UInt)

	Function zsv_new:Byte Ptr(opts:Byte Ptr)
	Function zsv_get_cell:SCsvColumn(handle:Byte Ptr, index:Size_T)
	Function zsv_cell_count:Size_T(handle:Byte Ptr)
	Function zsv_abort(handle:Byte Ptr)
	Function zsv_delete:ECsvStatus(handle:Byte Ptr)
	Function zsv_next_row:ECsvStatus(handle:Byte Ptr)
End Extern

Rem
bbdoc: A csv column.
End Rem
Struct SCsvColumn
Private
	Field str:Byte Ptr
Public
	Rem
	bbdoc: The length of the column.
	End Rem
	Field length:Size_T
	Rem
	bbdoc: A non-zero value indicates that the column is quoted.
	End Rem
	Field quoted:Byte

	Rem
	bbdoc: Returns the value of the column, or #Null if the column is empty.
	End Rem
	Method GetValue:String()
		If length Then
			Return String.FromUTF8Bytes(str, Int(length))
		End If
	End Method
End Struct

Enum ECsvStatus
	ok = 0
	cancelled
	noMoreInput
	invalidOption
	memory
	error
	row
	done = 100
	maxRowsRead = 999
End Enum
