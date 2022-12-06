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

Rem
bbdoc: A CSV parser.
End Rem
Module Text.CSV

ModuleInfo "Version: 1.00"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: MIT"
ModuleInfo "zsv - Copyright (c) 2021 Guarnerix Inc dba Liquidaty"
ModuleInfo "Copyright: 2022 Bruce A Henderson"

ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release"

ModuleInfo "CC_OPTS: -DVERSION=\~qv0.3.3\~q"
ModuleInfo "CC_OPTS: -DZSV_EXTRAS=1"

Import "common.bmx"

Rem
bbdoc: Csv Parser
about: The parser expects at least 1 header row. If a file does not have a header row, one can be
provided by setting #TCsvOptions.insertHeaderRow with an appropriate value.
End Rem
Type TCsvParser

	Private
	Field zsvPtr:Byte Ptr

	Field opts:TCsvOpts
	Field stream:TStream
	Field shouldCloseStream:Int

	Field row:TCsvRow

	Method New(stream:TStream, options:TCsvOptions)
		If Not options Then
			options = New TCsvOptions
		End If

		Self.opts = New TCsvOpts(Self, options)
		Self.stream = stream

		zsvPtr = zsv_new(opts.optsPtr)

		row = New TCsvRow(zsvPtr)
		ReadHeader()
	End Method

	Method ReadHeader()
		If NextRow() = ECsvStatus.row Then
			Local count:Size_T = row.ColumnCount()
			Local header:TCsvHeader = New TCsvHeader(count)
			For Local i:Int = 0 Until count
				Local col:SCsvColumn = row.GetColumn(i)
				Local v:String = col.GetValue()
				If v Then
					header.Put(v, i)
				End If
			Next
			row.header = header
		End If
	End Method

	Public
	Rem
	bbdoc: Creates a new #TCsvParser instance, using the given path.
	End Rem
	Function Parse:TCsvParser(path:String, opts:TCsvOptions)
		Local stream:TStream = ReadStream(path)
		If stream Then
			Local csv:TCsvParser = Parse(stream, opts)
			csv.shouldCloseStream = True
			Return csv
		End If
	End Function

	Rem
	bbdoc: Creates a new #TCsvParser instance, using the provided #TStream.
	End Rem
	Function Parse:TCsvParser(stream:TStream, options:TCsvOptions = Null)
		Return New TCsvParser(stream, options)
	End Function

	Rem
	bbdoc: Fetches the next row.
	returns: Returns ECsvStatus.row when a row is retrieved.
	End Rem
	Method NextRow:ECsvStatus()
		Return zsv_next_row(zsvPtr)
	End Method

	Rem
	bbdoc: Returns the current row.
	about: The cell values are only valid until the next call to #NextRow.
	End Rem
	Method GetRow:TCsvRow()
		Return row
	End Method

	Rem
	bbdoc: Frees the parser and any associated data.
	End Rem
	Method Free()
		If zsvPtr Then
			If shouldCloseStream Then
				stream.Close()
			End If
			zsv_delete(zsvPtr)
			zsvPtr = Null
		End If
	End Method

	Method Delete()
		Free()
	End Method

	Private
	Method ReadStream:Size_T(data:Byte Ptr, n:Size_T, size:Size_T)
		Return stream.Read(data, n * size)
	End Method

	Function _ReadStream:Size_T(data:Byte Ptr, n:Size_T, size:Size_T, csv:TCsvParser) { nomangle }
		Return csv.ReadStream(data, n, size)
	End Function

End Type

Rem
bbdoc: Options for customising the parser.
End Rem
Type TCsvOptions

	Rem
	bbdoc: Maximum number of columns to parse.
	about: Defaults to 1024.	
	End Rem
	Field maxColumns:UInt = 1024
	Rem
	bbdoc: The delimiter.
	about: Typically a comma or tab. Can be any char other than newline, form feed or quote. Defaults to comma.
	End Rem
	Field delimiter:String = ","
	Rem
	bbdoc: When enabled, indicates that the parser should treat double-quotes just like any ordinary character.
	End Rem
	Field noQuotes:Int
	Rem
	bbdoc: If the actual data does not have a header row with column names, the caller should provide one (in CSV format) which will be treated as if it was the first row of data.
	End Rem
	Field insertHeaderRow:String
	Rem
	bbdoc: The number of rows that the header row spans.
	about: If 0 or 1, header is assumed to span 1 row otherwise, set to number > 1 to span multiple rows.
	End Rem
	Field headerSpan:UInt = 1
	Rem
	bbdoc: The number of rows to ignore before the initial row is processed.
	End Rem
	Field rowsToIgnore:UInt
	Rem
	bbdoc: By default, ignores empty header rows.
	about: To disable this behaviour, set to #True.
	End Rem
	Field keepEmptyHeaderRows:UInt

End Type

Private
Type TCsvOpts

	Field optsPtr:Byte Ptr
	Field headerRow:Byte Ptr

	Method New(csv:TCsvParser, options:TCsvOptions)
		optsPtr = bmx_csv_opts_new(csv)
		If options.insertHeaderRow Then
			headerRow = options.insertHeaderRow.ToUTF8String()
		End If
		bmx_csv_opts_set_options(optsPtr, options.maxColumns, Asc(options.delimiter), options.noQuotes, headerRow, options.headerSpan, options.rowsToIgnore, options.keepEmptyHeaderRows)
	End Method

	Method Delete()
		If headerRow Then
			MemFree(headerRow)
			headerRow = Null
		End If
		If optsPtr Then
			bmx_csv_opts_free(optsPtr)
			optsPtr = Null
		End If
	End Method
End Type

Public
Rem
bbdoc: A Csv Row.
End Rem
Type TCsvRow
	Private
	Field zsvPtr:Byte Ptr
	Field header:TCsvHeader

	Method New(zsvPtr:Byte Ptr)
		Self.zsvPtr = zsvPtr
	End Method
	Public

	Rem
	bbdoc: Returns the number of columns in the row.
	End Rem
	Method ColumnCount:Size_T()
		Return zsv_cell_count(zsvPtr)
	End Method

	Rem
	bbdoc: Returns the column at the given index.
	End Rem
	Method GetColumn:SCsvColumn(index:Size_T)
		Return zsv_get_cell(zsvPtr, index)
	End Method

	Rem
	bbdoc: Returns the column at the given index.
	End Rem
	Method GetColumn:SCsvColumn(index:Int)
		Return zsv_get_cell(zsvPtr, Size_T(index))
	End Method

	Rem
	bbdoc: Returns the column with the given column @name.
	End Rem
	Method GetColumn:SCsvColumn(name:String)
		If header Then
			Local index:Int = header.IndexForName(name)
			If index >= 0 Then
				Return zsv_get_cell(zsvPtr, Size_T(index))
			End If
		End If
		Return Null
	End Method

	Rem
	bbdoc: Returns the value of the column at the given @index.
	End Rem
	Method GetValue:String(index:Size_T)
		Return zsv_get_cell(zsvPtr, index).GetValue()
	End Method

	Rem
	bbdoc: Returns the value of the given column @name.
	End Rem
	Method GetValue:String(name:String)
		Return GetColumn(name).GetValue()
	ENd Method

	Rem
	bbdoc: Returns the header.
	End Rem
	Method GetHeader:TCsvHeader()
		Return header
	End Method
	
	Method Abort()
		zsv_abort(zsvPtr)
	End Method
End Type

Rem
bbdoc: A csv header.
about: A header consists of 1 or more rows.
End Rem
Type TCsvHeader
	Field cols:String[]
	Field map:TStringMap = New TStringMap

	Private
	Method New(count:Size_T)
		cols = New String[count]
	End Method

	Method Put(col:String, index:Int)
		cols[index] = col
		map.Insert(col, New TInt(index))
	End Method

	Public

	Rem
	bbdoc: Returns the column index for the column header @name.
	End Rem
	Method IndexForName:Int(name:String)
		Local value:TInt = TInt(map.ValueForKey(name))
		If value Then
			Return value.value
		Else
			Return -1
		End If
	End Method

	Rem
	bbdoc: Returns the number of header columns.
	End Rem
	Method ColumnCount:Size_T()
		Return cols.Length
	End Method

	Rem
	bbdoc: Returns the header for the given @index.
	End Rem
	Method GetHeader:String(index:Size_T)
		If index < cols.Length Then
			Return cols[index]
		End If
	End Method

End Type

Private
Type TInt
	Field value:Int
	Method New(value:Int)
		Self.value = value
	End Method
End Type

