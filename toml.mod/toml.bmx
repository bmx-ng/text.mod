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

Rem
bbdoc: A TOML decoder.
End Rem
Module Text.Toml

ModuleInfo "Version: 1.02"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: MIT"
ModuleInfo "toml.hpp - Copyright (c) Mark Gillard"
ModuleInfo "Copyright: 2023 Bruce A Henderson"

ModuleInfo "History: 1.02"
ModuleInfo "History: Updated to toml++ 3.4.0.d8fa9a1"
ModuleInfo "History: 1.01"
ModuleInfo "History: Updated to toml++ 3.3.0.7eb2ffc"
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release"

ModuleInfo "CPP_OPTS: -std=c++17 -fexceptions"

Import "common.bmx"

Rem
bbdoc: TOML loader.
End Rem
Type TToml

	Rem
	bbdoc: Parses a String of TOML.
	about:
	May throw a #TTomlParseError.
	End Rem
	Function Parse:TTomlTable(doc:String)
		Return bmx_toml_parse_string(doc)
	End Function

	Rem
	bbdoc: Loads a TOML file from the given @path.
	about:
	May throw a #TTomlParseError.
	End Rem
	Function Load:TTomlTable(path:String)
		Local stream:TStream = ReadStream(path)
		If stream Then
			Local table:TTomlTable = Load(stream)
			stream.Close()
			Return table
		End If
	End Function

	Rem
	bbdoc: Loads a TOML file from the given @stream.
	about:
	May throw a #TTomlParseError.
	End Rem
	Function Load:TTomlTable(stream:TStream)
		Local doc:String = LoadText(stream)
		Return Parse(doc)
	End Function

End Type

Rem
bbdoc: A TOML table.
End Rem
Type TTomlTable Implements ITomlNode

	Field value:TStringMap

	Method New()
		value = New TStringMap
	End Method

	Private
	Function _create:TTomlTable() { nomangle }
		Return New TTomlTable
	End Function

	Function _Add(table:TTomlTable, key:String, node:ITomlNode) { nomangle }
		table.Add(key, node)
	End Function

	Public
	Rem
	bbdoc: Adds a node with the key @key.
	End Rem
	Method Add(key:String, node:ITomlNode)
		value.Insert(key, node)
	End Method

	Rem
	bbdoc: Returns the node for the given @key, or #Null if none exists.
	End Rem
	Method Operator [] :ITomlNode(key:String)
        Return ITomlNode(value.ValueForKey(key))
    End Method

	Rem
	bbdoc: Returns an enumeration of the table keys.
	End Rem
	Method Keys:TStringMapEnumerator()
		Return value.Keys()
	End Method

	Method NodeType:ETomlNodeType()
		Return ETomlNodeType.TomlTable
	End Method

	Method IsTable:Int() Override
		Return True
	End Method

	Method IsArray:Int() Override
		Return False
	End Method

	Method IsString:Int() Override
		Return False
	End Method

	Method IsInteger:Int() Override
		Return False
	End Method

	Method IsFloatingPoint:Int() Override
		Return False
	End Method

	Method IsBoolean:Int() Override
		Return False
	End Method

	Method IsDate:Int() Override
		Return False
	End Method

	Method IsTime:Int() Override
		Return False
	End Method

	Method IsDateTime:Int() Override
		Return False
	End Method
	
	Method AsTable:TTomlTable() Override
		Return Self
	End Method

	Method AsArray:TTomlArray() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsString:String() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsLong:Long() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDouble:Double() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsBoolean:Int() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDate:STomlDate() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsTime:STomlTime() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDateTime:STomlDateTime() Override
		Throw New TUnsupportedNodeError
	End Method

End Type

Rem
bbdoc: A TOML array.
End Rem
Type TTomlArray Implements ITomlNode

	Field value:ITomlNode[]

	Method New(size:Int)
		value = New ITomlNode[size]
	End Method

	Private
	Function _create:TTomlArray(size:Int) { nomangle }
		Return New TTomlArray(size)
	End Function

	Function _Set(array:TTomlArray, index:Int, node:ITomlNode) { nomangle }
		array.Set(index, node)
	End Function

	Public
	Method Set(index:Int, node:ITomlNode)
		value[index] = node
	End Method

	Method Add(node:ITomlNode)

	End Method

	Method NodeType:ETomlNodeType()
		Return ETomlNodeType.TomlArray
	End Method

	Method IsTable:Int() Override
		Return False
	End Method

	Method IsArray:Int() Override
		Return True
	End Method

	Method IsString:Int() Override
		Return False
	End Method

	Method IsInteger:Int() Override
		Return False
	End Method

	Method IsFloatingPoint:Int() Override
		Return False
	End Method

	Method IsBoolean:Int() Override
		Return False
	End Method

	Method IsDate:Int() Override
		Return False
	End Method

	Method IsTime:Int() Override
		Return False
	End Method

	Method IsDateTime:Int() Override
		Return False
	End Method
	
	Method AsTable:TTomlTable() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsArray:TTomlArray() Override
		Return Self
	End Method

	Method AsString:String() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsLong:Long() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDouble:Double() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsBoolean:Int() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDate:STomlDate() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsTime:STomlTime() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDateTime:STomlDateTime() Override
		Throw New TUnsupportedNodeError
	End Method

End Type

Rem
bbdoc: A TOML string.
End Rem
Type TTomlString Implements ITomlNode

	Field value:String

	Method New(value:String)
		Self.value = value
	End Method

	Private
	Function _create:TTomlString(value:String) { nomangle }
		Return New TTomlString(value)
	End Function

	Public
	Method NodeType:ETomlNodeType()
		Return ETomlNodeType.TomlString
	End Method

	Method IsTable:Int() Override
		Return False
	End Method

	Method IsArray:Int() Override
		Return False
	End Method

	Method IsString:Int() Override
		Return True
	End Method

	Method IsInteger:Int() Override
		Return False
	End Method

	Method IsFloatingPoint:Int() Override
		Return False
	End Method

	Method IsBoolean:Int() Override
		Return False
	End Method

	Method IsDate:Int() Override
		Return False
	End Method

	Method IsTime:Int() Override
		Return False
	End Method

	Method IsDateTime:Int() Override
		Return False
	End Method
	
	Method AsTable:TTomlTable() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsArray:TTomlArray() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsString:String() Override
		Return value
	End Method

	Method AsLong:Long() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDouble:Double() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsBoolean:Int() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDate:STomlDate() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsTime:STomlTime() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDateTime:STomlDateTime() Override
		Throw New TUnsupportedNodeError
	End Method
	
End Type

Rem
bbdoc: A TOML integer number, represented as a #Long.
End Rem
Type TTomlInteger Implements ITomlNode

	Field value:Long

	Method New(value:Long)
		Self.value = value
	End Method

	Private
	Function _create:TTomlInteger(value:Long) { nomangle }
		Return New TTomlInteger(value)
	End Function

	Public
	Method NodeType:ETomlNodeType()
		Return ETomlNodeType.TomlInteger
	End Method

	Method IsTable:Int() Override
		Return False
	End Method

	Method IsArray:Int() Override
		Return False
	End Method

	Method IsString:Int() Override
		Return False
	End Method

	Method IsInteger:Int() Override
		Return True
	End Method

	Method IsFloatingPoint:Int() Override
		Return False
	End Method

	Method IsBoolean:Int() Override
		Return False
	End Method

	Method IsDate:Int() Override
		Return False
	End Method

	Method IsTime:Int() Override
		Return False
	End Method

	Method IsDateTime:Int() Override
		Return False
	End Method
	
	Method AsTable:TTomlTable() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsArray:TTomlArray() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsString:String() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsLong:Long() Override
		Return value
	End Method

	Method AsDouble:Double() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsBoolean:Int() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDate:STomlDate() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsTime:STomlTime() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDateTime:STomlDateTime() Override
		Throw New TUnsupportedNodeError
	End Method

End Type

Rem
bbdoc: A TOML floating point number, represented as a #Double.
End Rem
Type TTomlFloatingPoint Implements ITomlNode

	Field value:Double

	Method New(value:Double)
		Self.value = value
	End Method

	Private
	Function _create:TTomlFloatingPoint(value:Double) { nomangle }
		Return New TTomlFloatingPoint(value)
	End Function

	Public
	Method NodeType:ETomlNodeType()
		Return ETomlNodeType.TomlFloatingPoint
	End Method

	Method IsTable:Int() Override
		Return False
	End Method

	Method IsArray:Int() Override
		Return False
	End Method

	Method IsString:Int() Override
		Return False
	End Method

	Method IsInteger:Int() Override
		Return False
	End Method

	Method IsFloatingPoint:Int() Override
		Return True
	End Method

	Method IsBoolean:Int() Override
		Return False
	End Method

	Method IsDate:Int() Override
		Return False
	End Method

	Method IsTime:Int() Override
		Return False
	End Method

	Method IsDateTime:Int() Override
		Return False
	End Method
	
	Method AsTable:TTomlTable() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsArray:TTomlArray() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsString:String() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsLong:Long() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDouble:Double() Override
		Return value
	End Method

	Method AsBoolean:Int() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDate:STomlDate() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsTime:STomlTime() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDateTime:STomlDateTime() Override
		Throw New TUnsupportedNodeError
	End Method

End Type

Rem
bbdoc: A TOML boolean.
End Rem
Type TTomlBoolean Implements ITomlNode

	Field value:Int

	Method New(value:Int)
		Self.value = value
	End Method

	Private
	Function _create:TTomlBoolean(value:Int) { nomangle }
		Return New TTomlBoolean(value)
	End Function

	Public
	Method NodeType:ETomlNodeType()
		Return ETomlNodeType.TomlBoolean
	End Method

	Method IsTable:Int() Override
		Return False
	End Method

	Method IsArray:Int() Override
		Return False
	End Method

	Method IsString:Int() Override
		Return False
	End Method

	Method IsInteger:Int() Override
		Return False
	End Method

	Method IsFloatingPoint:Int() Override
		Return False
	End Method

	Method IsBoolean:Int() Override
		Return True
	End Method

	Method IsDate:Int() Override
		Return False
	End Method

	Method IsTime:Int() Override
		Return False
	End Method

	Method IsDateTime:Int() Override
		Return False
	End Method
	
	Method AsTable:TTomlTable() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsArray:TTomlArray() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsString:String() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsLong:Long() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDouble:Double() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsBoolean:Int() Override
		Return value
	End Method

	Method AsDate:STomlDate() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsTime:STomlTime() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDateTime:STomlDateTime() Override
		Throw New TUnsupportedNodeError
	End Method

End Type

Rem
bbdoc: A TOML date.
End Rem
Type TTomlDate Implements ITomlNode

	Field value:STomlDate

	Method New(value:STomlDate)
		Self.value = value
	End Method

	Private
	Function _create:TTomlDate(value:STomlDate) { nomangle }
		Return New TTomlDate(value)
	End Function

	Public
	Method NodeType:ETomlNodeType()
		Return ETomlNodeType.TomlDate
	End Method

	Method IsTable:Int() Override
		Return False
	End Method

	Method IsArray:Int() Override
		Return False
	End Method

	Method IsString:Int() Override
		Return False
	End Method

	Method IsInteger:Int() Override
		Return False
	End Method

	Method IsFloatingPoint:Int() Override
		Return False
	End Method

	Method IsBoolean:Int() Override
		Return False
	End Method

	Method IsDate:Int() Override
		Return True
	End Method

	Method IsTime:Int() Override
		Return False
	End Method

	Method IsDateTime:Int() Override
		Return False
	End Method
	
	Method AsTable:TTomlTable() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsArray:TTomlArray() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsString:String() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsLong:Long() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDouble:Double() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsBoolean:Int() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDate:STomlDate() Override
		Return value
	End Method

	Method AsTime:STomlTime() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDateTime:STomlDateTime() Override
		Throw New TUnsupportedNodeError
	End Method

End Type

Rem
bbdoc: A TOML time.
End Rem
Type TTomlTime Implements ITomlNode

	Field value:STomlTime

	Method New(value:STomlTime)
		Self.value = value
	End Method

	Private
	Function _create:TTomlTime(value:STomlTime) { nomangle }
		Return New TTomlTime(value)
	End Function

	Public
	Method NodeType:ETomlNodeType()
		Return ETomlNodeType.TomlTime
	End Method

	Method IsTable:Int() Override
		Return False
	End Method

	Method IsArray:Int() Override
		Return False
	End Method

	Method IsString:Int() Override
		Return False
	End Method

	Method IsInteger:Int() Override
		Return False
	End Method

	Method IsFloatingPoint:Int() Override
		Return False
	End Method

	Method IsBoolean:Int() Override
		Return False
	End Method

	Method IsDate:Int() Override
		Return False
	End Method

	Method IsTime:Int() Override
		Return True
	End Method

	Method IsDateTime:Int() Override
		Return False
	End Method
	
	Method AsTable:TTomlTable() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsArray:TTomlArray() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsString:String() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsLong:Long() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDouble:Double() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsBoolean:Int() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDate:STomlDate() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsTime:STomlTime() Override
		Return value
	End Method

	Method AsDateTime:STomlDateTime() Override
		Throw New TUnsupportedNodeError
	End Method

End Type

Rem
bbdoc: A TOML date time.
End Rem
Type TTomlDateTime Implements ITomlNode

	Field value:STomlDateTime

	Method New(value:STomlDateTime)
		Self.value = value
	End Method

	Private
	Function _create:TTomlDateTime(value:STomlDateTime) { nomangle }
		Return New TTomlDateTime(value)
	End Function

	Public

	Rem
	bbdoc: Returns #True if the date time is local.
	End Rem
	Method IsLocal:Int()
		Return Not value.offset.hasValue
	End Method

	Method NodeType:ETomlNodeType()
		Return ETomlNodeType.TomlDateTime
	End Method

	Method IsTable:Int() Override
		Return False
	End Method

	Method IsArray:Int() Override
		Return False
	End Method

	Method IsString:Int() Override
		Return False
	End Method

	Method IsInteger:Int() Override
		Return False
	End Method

	Method IsFloatingPoint:Int() Override
		Return False
	End Method

	Method IsBoolean:Int() Override
		Return False
	End Method

	Method IsDate:Int() Override
		Return False
	End Method

	Method IsTime:Int() Override
		Return False
	End Method

	Method IsDateTime:Int() Override
		Return True
	End Method
	
	Method AsTable:TTomlTable() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsArray:TTomlArray() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsString:String() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsLong:Long() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDouble:Double() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsBoolean:Int() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDate:STomlDate() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsTime:STomlTime() Override
		Throw New TUnsupportedNodeError
	End Method

	Method AsDateTime:STomlDateTime() Override
		Return value
	End Method

End Type

Rem
bbdoc: A toml node.
End Rem
Interface ITomlNode
	Rem
	bbdoc: Returns the type of this node.
	End Rem
	Method NodeType:ETomlNodeType()

	Rem
	bbdoc: Returns #True if the node is a table.
	End Rem
	Method IsTable:Int()
	Rem
	bbdoc: Returns #True if the node is an array.
	End Rem
	Method IsArray:Int()
	Rem
	bbdoc: Returns #True if the node is a String.
	End Rem
	Method IsString:Int()
	Rem
	bbdoc: Returns #True if the node is an integer.
	End Rem
	Method IsInteger:Int()
	Rem
	bbdoc: Returns #True if the node is a floating point number.
	End Rem
	Method IsFloatingPoint:Int()
	Rem
	bbdoc: Returns #True if the node is a boolean.
	End Rem
	Method IsBoolean:Int()
	Rem
	bbdoc: Returns #True if the node is a date.
	End Rem
	Method IsDate:Int()
	Rem
	bbdoc: Returns #True if the node is a time.
	End Rem
	Method IsTime:Int()
	Rem
	bbdoc: Returns #True if the node is a date time.
	End Rem
	Method IsDateTime:Int()

	Rem
	bbdoc: Returns this node as a table, or throws a #TUnsupportedNodeError.
	End Rem
	Method AsTable:TTomlTable()
	Rem
	bbdoc: Returns this node as an array, or throws a #TUnsupportedNodeError.
	End Rem
	Method AsArray:TTomlArray()
	Rem
	bbdoc: Returns this node as a #String, or throws a #TUnsupportedNodeError.
	End Rem
	Method AsString:String()
	Rem
	bbdoc: Returns this node as a #Long, or throws a #TUnsupportedNodeError.
	End Rem
	Method AsLong:Long()
	Rem
	bbdoc: Returns this node as a #Double, or throws a #TUnsupportedNodeError.
	End Rem
	Method AsDouble:Double()
	Rem
	bbdoc: Returns this node as a boolean, or throws a #TUnsupportedNodeError.
	End Rem
	Method AsBoolean:Int()
	Rem
	bbdoc: Returns this node as a date, or throws a #TUnsupportedNodeError.
	End Rem
	Method AsDate:STomlDate()
	Rem
	bbdoc: Returns this node as a time, or throws a #TUnsupportedNodeError.
	End Rem
	Method AsTime:STomlTime()
	Rem
	bbdoc: Returns this node as a date time, or throws a #TUnsupportedNodeError.
	End Rem
	Method AsDateTime:STomlDateTime()
End Interface


Type TUnsupportedNodeError Extends TBlitzException
End Type

Rem
bbdoc: A toml parse error.
End Rem
Type TTomlParseError Extends TBlitzException
	Field message:String
	Field source:TTomlSourceRegion

	Method New(message:String, source:TTomlSourceRegion)
		Self.message = message
		Self.source = source
	End Method
	
	Private
	Function _create:TTomlParseError(message:String, source:TTomlSourceRegion) { nomangle }
		Return New TTomlParseError(message, source)
	End Function

	Public
	Method ToString:String()
		Return message
	End Method

End Type

Extern

	Function bmx_toml_parse_string:TTomlTable(doc:String)

End Extern
