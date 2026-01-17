' Copyright (c) 2023 Bruce A Henderson
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

Import Collections.StringMap
Import BRL.TextStream
Import BRL.StringBuilder

Import "source.bmx"

Rem
bbdoc: Toml node type.
End Rem
Enum ETomlNodeType
	TomlNone
	TomlTable
	TomlArray
	TomlString
	TomlInteger
	TomlFloatingPoint
	TomlBoolean
	TomlDate
	TomlTime
	TomlDateTime
End Enum

Rem
bbdoc: A toml date representation.
End Rem
Struct STomlDate
	Field year:Short
	Field month:Byte
	Field day:Byte

	Method ToString:String()
		Local sb:TStringBuilder = New TStringBuilder
		sb.Format("%04d-", year)
		sb.Format("%02d-", month)
		sb.Format("%02d", day)
		Return sb.ToString()
	End Method
End Struct

Rem
bbdoc: A toml time representation.
End Rem
Struct STomlTime
	Field hour:Byte
	Field minute:Byte
	Field second:Byte
	Field nanosecond:UInt

	Method ToString:String()
		Local sb:TStringBuilder = New TStringBuilder
		sb.Format("%02d:", hour)
		sb.Format("%02d:", minute)
		sb.Format("%02d", second)
		If nanosecond Then
			sb.Format(".%09d", nanosecond)
		End If
		Return sb.ToString()
	End Method
End Struct

Struct STomlTimeOffset
	Field minutes:Short
End Struct

Struct STomlOptionalOffset
	Field hasValue:Byte
	Field offset:STomlTimeOffset
End Struct

Rem
bbdoc: A toml date time representation, with optional offset.
End Rem
Struct STomlDateTime
	Rem
	bbdoc: The date.
	End Rem
	Field date:STomlDate
	Rem
	bbdoc: The time.
	End Rem
	Field time:STomlTime
	Rem
	bbdoc: An optional offset.
	End Rem
	Field offset:STomlOptionalOffset

	Method ToString:String()
		Local sb:TStringBuilder = New TStringBuilder
		sb.Append(date.ToString())
		sb.Append("T")
		sb.Append(time.ToString())

		If offset.hasValue Then
			If Not offset.offset.minutes Then
				sb.Append("Z")
			Else
				Local mins:Int = offset.offset.minutes
				If mins < 0 Then
					sb.Append("-")
					mins = -mins
				Else
					sb.Append("+")
				End If
				Local hours:Int = mins / 60
				If hours Then
					sb.Format("%02d", hours)
					mins :- hours * 60
				End If
				sb.Format("%02d", mins)
			End If
		End If
		Return sb.ToString()
	End Method
End Struct

Rem
bbdoc: Source region, provided with parsing errors.
End Rem
Type TTomlSourceRegion
	Field beginPos:STomlSourcePosition
	Field endPos:STomlSourcePosition
	Field path:String

	Method New(beginPos:STomlSourcePosition, endPos:STomlSourcePosition, path:String)
		Self.beginPos = beginPos
		Self.endPos = endPos
		Self.path = path
	End Method

	Function _create:TTomlSourceRegion(beginPos:STomlSourcePosition, endPos:STomlSourcePosition, path:String) { nomangle }
		Return New TTomlSourceRegion(beginPos, endPos, path)
	End Function
End Type

Struct STomlSourcePosition
	Field line:UInt
	Field column:UInt
End Struct
