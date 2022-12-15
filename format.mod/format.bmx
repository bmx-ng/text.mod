' Copyright (c) 2007-2020 Bruce A Henderson
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
bbdoc: String Formatter
End Rem
Module Text.Format

ModuleInfo "Version: 1.04"
ModuleInfo "License: MIT"
ModuleInfo "Copyright: 2007-2020 Bruce A Henderson"
ModuleInfo "Modserver: BRL"

ModuleInfo "History: 1.04"
ModuleInfo "History: TStringBuilder usage improvements."
ModuleInfo "History: 1.03"
ModuleInfo "History: Updated for inclusion into NG/BRL."
ModuleInfo "History: 1.02"
ModuleInfo "History: Fixed offset problem."
ModuleInfo "History: Use StringBuilder/Buffer for string concat."
ModuleInfo "History: 1.01"
ModuleInfo "History: Rewritten to use native snfprintf."
ModuleInfo "History: License change to MIT."
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release."


Import Text.RegEx
Import BRL.LinkedList
Import BRL.StringBuilder

Import "glue.c"

Private
Extern
	Function bmx_sprintf_string(format:Byte Ptr, value:String, sb:Byte Ptr)
	Function bmx_sprintf_float(format:Byte Ptr, value:Float, sb:Byte Ptr)
	Function bmx_sprintf_int(format:Byte Ptr, value:Int, sb:Byte Ptr)
	Function bmx_sprintf_uint(format:Byte Ptr, value:UInt, sb:Byte Ptr)
	Function bmx_sprintf_double(format:Byte Ptr, value:Double, sb:Byte Ptr)
	Function bmx_sprintf_long(format:Byte Ptr, value:Long, sb:Byte Ptr)
	Function bmx_sprintf_ulong(format:Byte Ptr, value:ULong, sb:Byte Ptr)
	Function bmx_sprintf_sizet(format:Byte Ptr, value:Size_T, sb:Byte Ptr)
	Function bmx_sprintf_ptr(format:Byte Ptr, value:Byte Ptr, sb:Byte Ptr)
End Extern
Public

Rem
bbdoc: The string formatter.
about: Processes printf-style format strings.
End Rem
Type TFormatter

	Private
	Global regex:TRegEx = TRegEx.Create("%(\d+\$)?([-#+ 0,l(\<]*)?(\d+)?(\.\d+)?([a-zA-Z%])")
	Field Text:String
	
	Field formatParts:TStringFormatPart[]
	Field args:TArg[]
	Field argCount:Int
	
	Public
	Rem
	bbdoc: Creates a new #TFormatter object.
	about: Parameters:
	<ul>
	<li><b>text</b> : The text containing formatting instructions</li>
	</ul>
	End Rem
	Function Create:TFormatter(Text:String)
		Local this:TFormatter = New TFormatter
		
		this.Text = Text
		
		If Text Then
			this.parse()
		End If
		
		Return this
	End Function
	
Private	
	Method parse()
		Local parts:TList = New TList
		
		Local match:TRegExMatch = regex.Find(Text)
		Local i:Int = 0
		
		While i < Text.length
			
			If match Then
				
				' is there text before the formatting text ?
				If i <> match.SubStart(0) Then

					parts.addLast(TPlainText.Create(Text[i..match.SubStart(0)]))
					
				End If

				' this is the formatting part
				Local sections:String[] = New String[5]
				For Local n:Int = 1 Until 6
					sections[n-1] = match.SubExp(n)
				Next
				
				parts.addLast(TFormattingText.Create(sections))
				
			Else
				' is there text at the end of all the formatting parts?
				parts.addLast(TPlainText.Create(Text[i..]))
				
				Exit
			End If
			
			i = match.SubEnd(0) + 1
			
			match = regex.find()
		Wend

		formatParts = New TStringFormatPart[parts.count()]
		i = 0
		For Local part:TStringFormatPart = EachIn parts
			formatParts[i] = part
			i:+ 1
		Next
		
	End Method

	Method addArg(arg:TArg)
		If argCount >= args.length
			args = args[0..argCount + 4]
		End If
		
		args[argCount] = arg
		
		argCount :+ 1
	End Method
Public

	Rem
	bbdoc: Appends a #Byte argument to the formatter.
	End Rem
	Method Arg:TFormatter(value:Byte)
		Local arg:TByteArg = New TByteArg
		arg.value = value
		
		addArg(arg)
		
		Return Self
	End Method

	Rem
	bbdoc: Appends a #Short argument to the formatter.
	End Rem
	Method Arg:TFormatter(value:Short)
		Local arg:TShortArg = New TShortArg
		arg.value = value
		
		addArg(arg)

		Return Self
	End Method

	Rem
	bbdoc: Appends an #Int argument to the formatter.
	End Rem
	Method Arg:TFormatter(value:Int)
		Local arg:TIntArg = New TIntArg
		arg.value = value
		
		addArg(arg)

		Return Self
	End Method

	Rem
	bbdoc: Appends a #UInt argument to the formatter.
	End Rem
	Method Arg:TFormatter(value:UInt)
		Local arg:TUIntArg = New TUIntArg
		arg.value = value
		
		addArg(arg)

		Return Self
	End Method

	Rem
	bbdoc: Appends a #Long argument to the formatter.
	End Rem
	Method Arg:TFormatter(value:Long)
		Local arg:TLongArg = New TLongArg
		arg.value = value
		
		addArg(arg)

		Return Self
	End Method
	
	Rem
	bbdoc: Appends a #ULong argument to the formatter.
	End Rem
	Method Arg:TFormatter(value:ULong)
		Local arg:TULongArg = New TULongArg
		arg.value = value
		
		addArg(arg)

		Return Self
	End Method

	Rem
	bbdoc: Appends a #Float argument to the formatter.
	End Rem
	Method Arg:TFormatter(value:Float)
		Local arg:TFloatArg = New TFloatArg
		arg.value = value
		
		addArg(arg)

		Return Self
	End Method

	Rem
	bbdoc: Appends a #Double argument to the formatter.
	End Rem
	Method Arg:TFormatter(value:Double)
		Local arg:TDoubleArg = New TDoubleArg
		arg.value = value
		
		addArg(arg)

		Return Self
	End Method

	Rem
	bbdoc: Appends a #Size_T argument to the formatter.
	End Rem
	Method Arg:TFormatter(value:Size_T)
		Local arg:TSizeTArg = New TSizeTArg
		arg.value = value
		
		addArg(arg)

		Return Self
	End Method

	Rem
	bbdoc: Appends a Byte Ptr argument to the formatter.
	End Rem
	Method Arg:TFormatter(value:Byte Ptr)
		Local arg:TPtrArg = New TPtrArg
		arg.value = value
		
		addArg(arg)

		Return Self
	End Method

	Rem
	bbdoc: Appends a #String argument to the formatter.
	End Rem
	Method Arg:TFormatter(value:String)
		Local arg:TStringArg = New TStringArg
		arg.value = value
		
		addArg(arg)

		Return Self
	End Method

	Rem
	bbdoc: Processes and returns the formatted string.
	returns: The formatted String.
	End Rem
	Method Format:String(sb:TStringBuilder = Null)
		If Not sb Then
			sb = New TStringBuilder
		End If

		Local arg:Int = 0
		
		If Text Then
			For Local i:Int = 0 Until formatParts.length
				Local part:TStringFormatPart = formatParts[i]
				If TPlainText(part) Then
					sb.Append(part.ToString())
				Else
					Local fpart:TFormattingText = TFormattingText(part)
					If fpart.formatType = TFormattingText.FTYPE_PERCENT Then
						sb.Append("%")
					Else
						If (Not fpart.invalid) And (args And arg < argCount) Then
							fpart.processArg(args[arg], sb)
							' next arg only if this was a "real" arg format
							If fpart.formatType <> TFormattingText.FTYPE_LINEBREAK Then
								arg:+ 1
							End If
						Else	
							If Not fpart.invalid Then
								fpart.processArg(New TNullArg, sb)
							Else
								sb.Append(part.ToString())
							End If
						End If
					End If
				End If
			Next
		End If
		
		Return sb.ToString()
	End Method

	Rem
	bbdoc: Clears the formatter argument list, ready for new arguments.
	End Rem
	Method Clear:TFormatter()
		For Local i:Int = 0 Until argCount
			args[i] = Null
		Next
		argCount = 0
		Return Self
	End Method
	
End Type

Private
Type TStringFormatPart
	
	Method ToString:String() Abstract
End Type

Type TPlainText Extends TStringFormatPart

	Field Text:String

	Function Create:TPlainText(Text:String)
		Local this:TPlainText = New TPlainText
		
		this.Text = Text
		
		Return this
	End Function
	
	Method ToString:String()
		Return Text
	End Method
	
End Type

Type TFormattingText Extends TStringFormatPart

	Const FTYPE_LINEBREAK:Int = 110  ' n
	Const FTYPE_PERCENT:Int = 37     ' %

	Field sections:String[]
	Field formatType:Int = 0
	
	Field formatText:String
	Field formatPtr:Byte Ptr
	
	Field invalid:Int = False
	
	Function Create:TFormattingText(sections:String[])
		Local this:TFormattingText = New TFormattingText
		
		this.sections = sections
		this.configure()
		
		Return this
	End Function

	Method configure()
		formatText = "%"
		For Local i:Int = 0 Until sections.length
			formatText:+ sections[i]
		Next

		If formatText = "%%" Then
			formatType = FTYPE_PERCENT
		End If
		formatPtr = formatText.ToCString()
	End Method
	
	Method ProcessArg(arg:TArg, sb:TStringBuilder)

		Select arg.ArgType()
			Case TArg.ARG_STRING
				bmx_sprintf_string(formatText, TStringArg(arg).value, sb.buffer)
			Case TArg.ARG_INT
				bmx_sprintf_int(formatText, TIntArg(arg).value, sb.buffer)
			Case TArg.ARG_UINT
				bmx_sprintf_uint(formatText, TUIntArg(arg).value, sb.buffer)
			Case TArg.ARG_FLOAT
				bmx_sprintf_float(formatText, TFloatArg(arg).value, sb.buffer)
			Case TArg.ARG_DOUBLE
				bmx_sprintf_double(formatText, TDoubleArg(arg).value, sb.buffer)
			Case TArg.ARG_LONG
				bmx_sprintf_long(formatText, TLongArg(arg).value, sb.buffer)
			Case TArg.ARG_ULONG
				bmx_sprintf_ulong(formatText, TULongArg(arg).value, sb.buffer)
			Case TArg.ARG_SIZET
				bmx_sprintf_sizet(formatText, TSizeTArg(arg).value, sb.buffer)
			Case TArg.ARG_SHORT
				bmx_sprintf_int(formatText, Int(TShortArg(arg).value), sb.buffer)
			Case TArg.ARG_BYTE
				bmx_sprintf_int(formatText, Int(TByteArg(arg).value), sb.buffer)
			Case TArg.ARG_PTR
				bmx_sprintf_ptr(formatText, TPtrArg(arg).value, sb.buffer)
		End Select

	End Method

	Method ToString:String()
		Return "-"
	End Method
	
	Method Delete()
		If formatPtr Then
			MemFree(formatPtr)
			formatPtr = Null
		End If
	End Method
	
End Type

Type TArg
	Const ARG_NULL:Int = 0
	Const ARG_BYTE:Int = 1
	Const ARG_SHORT:Int = 2
	Const ARG_INT:Int = 3
	Const ARG_UINT:Int = 4
	Const ARG_LONG:Int = 5
	Const ARG_ULONG:Int = 6
	Const ARG_FLOAT:Int = 7
	Const ARG_DOUBLE:Int = 8
	Const ARG_SIZET:Int = 9
	Const ARG_STRING:Int = 10
	Const ARG_PTR:Int = 11

	Method ToString:String() Abstract
	Method ArgType:Int() Abstract
End Type

Type TNullArg Extends TArg
	Method ToString:String()
		Return Null
	End Method
	
	Method ArgType:Int()
		Return ARG_NULL
	End Method
End Type

Type TByteArg Extends TArg
	Field value:Byte

	Method ToString:String()
		Return String.fromInt(Int(value))
	End Method

	Method ArgType:Int()
		Return ARG_BYTE
	End Method
End Type

Type TShortArg Extends TArg
	Field value:Short

	Method ToString:String()
		Return String.fromInt(Int(value))
	End Method

	Method ArgType:Int()
		Return ARG_SHORT
	End Method
End Type

Type TIntArg Extends TArg
	Field value:Int

	Method ToString:String()
		Return String.fromInt(value)
	End Method

	Method ArgType:Int()
		Return ARG_INT
	End Method
End Type

Type TUIntArg Extends TArg
	Field value:UInt

	Method ToString:String()
		Return String.fromUInt(value)
	End Method

	Method ArgType:Int()
		Return ARG_UINT
	End Method
End Type

Type TFloatArg Extends TArg
	Field value:Float

	Method ToString:String()
		Return String.fromFloat(value)
	End Method

	Method ArgType:Int()
		Return ARG_FLOAT
	End Method
End Type

Type TDoubleArg Extends TArg
	Field value:Double

	Method ToString:String()
		Return String.fromDouble(value)
	End Method

	Method ArgType:Int()
		Return ARG_DOUBLE
	End Method
End Type

Type TStringArg Extends TArg
	Field value:String

	Method ToString:String()
		Return value
	End Method

	Method ArgType:Int()
		Return ARG_STRING
	End Method
End Type

Type TLongArg Extends TArg
	Field value:Long

	Method ToString:String()
		Return String.fromLong(value)
	End Method

	Method ArgType:Int()
		Return ARG_LONG
	End Method
End Type

Type TULongArg Extends TArg
	Field value:ULong

	Method ToString:String()
		Return String.fromULong(value)
	End Method

	Method ArgType:Int()
		Return ARG_ULONG
	End Method
End Type

Type TSizeTArg Extends TArg
	Field value:Size_T

	Method ToString:String()
		Return String.fromSizeT(value)
	End Method

	Method ArgType:Int()
		Return ARG_SIZET
	End Method
End Type

Type TPtrArg Extends TArg
	Field value:Byte Ptr

	Method ToString:String()
		Return String.fromSizeT((Size_T Ptr(value))[0])
	End Method

	Method ArgType:Int()
		Return ARG_PTR
	End Method
End Type
