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

Rem
bbdoc: An INI reader/writer.
End Rem
Module Text.Ini

ModuleInfo "Version: 1.01"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: MIT"
ModuleInfo "ini.h - Copyright (c) 2015 Mattias Gustavsson"
ModuleInfo "Copyright: 2022-2023 Bruce A Henderson"

ModuleInfo "History: 1.01"
ModuleInfo "History: Fixed missing terminator"
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release"

Import "common.bmx"

Rem
bbdoc: Represents the contents of an ini file.
about: The global section index is defined by #INI_GLOBAL_SECTION.
You should call #Free() when you are finished working with it, to allow it to clean up any resources it is using.
End Rem
Type TIni

	Private
	Field iniPtr:Byte Ptr

	Field sections:TIniSection[]

	Public 
	Rem
	bbdoc: Creates a new empty #TIni instance.
	End Rem
	Method New()
		iniPtr = ini_create(Null)
		InitSections()
	End Method

	Private
	Method New(data:Byte[])
		iniPtr = ini_load(data, Null)
		InitSections()
	End Method

	Method InitSections()
		Local count:Int = ini_section_count(iniPtr)
		sections = New TIniSection[count]
		For Local i:Int = 0 Until count
			sections[i] = New TIniSection(Self, i)
		Next
	End Method

	Public

	Rem
	bbdoc: Loads an ini file at the given @path.
	End Rem
	Function Load:TIni(path:String)
		Local stream:TStream = ReadStream(path)
		If stream Then
			Local ini:TIni = Load(stream)
			stream.Close()
			Return ini
		End If
	End Function

	Rem
	bbdoc: Loads an ini file from the given @stream.
	about: Does not close the #TStream.
	End Rem
	Function Load:TIni(stream:TStream)
		Local data:Byte[]

		If stream Then
			data = New Byte[1024]
			Local size:Int

			While Not stream.Eof()
				If size=data.length data=data[..size*3/2]
				size:+stream.Read( (Byte Ptr data)+size,data.length-size )
			Wend

			data = data[..size + 1]
			data[size] = 0
		End If

		If data Then
			Local ini:TIni = New TIni(data)
			Return ini
		End If
	End Function

	Rem
	bbdoc: Saves the ini file to the specified @path.
	End Rem
	Method Save(path:String)
		Local stream:TStream = WriteStream(path)
		If stream Then
			Save(stream)
			stream.Close()
		End If
	End Method

	Rem
	bbdoc: Saves the ini file to the specified @stream.
	about: Does not close the #TStream.
	End Rem
	Method Save(stream:TStream)
		Local size:Int = ini_save(iniPtr, Null, 0)
		Local data:Byte[size]
		size = ini_save(iniPtr, data, size)

		If size > 1 Then
			stream.WriteBytes(data, size - 1)
		End If
	End Method

	Rem
	bbdoc: Returns the number of sections.
	End Rem
	Method CountSections:Int()
		Return ini_section_count(iniPtr)
	End Method

	Rem
	bbdoc: Returns the section at the given @index, or #Null if the index is out of bounds.
	End Rem
	Method GetSection:TIniSection(index:Int)
		If index < 0 Or index >= ini_section_count(iniPtr) Then
			Return Null
		End If
		Return sections[index]
	End Method

	Rem
	bbdoc: Finds a section by @name.
	returns: The named section, or Null if not found.
	End Rem
	Method FindSection:TIniSection(name:String)
		name = name.ToUpper()
		For Local section:TIniSection = Eachin sections
			If Not section.upperName Then
				section.upperName = section.name.ToUpper()
			End If
			If name = section.upperName Then
				Return section
			End If
		Next
	End Method

	Rem
	bbdoc: Adds a section with the specified @name.
	about: There is no check done to see if a section with the specified name already exists - multiple sections of the same name are allowed.
	End Rem
	Method AddSection:TIniSection(name:String)
		Local index:Int = bmx_ini_section_add(iniPtr, name)
		If index = INI_NOT_FOUND Then
			Return Null
		End If
		Local section:TIniSection = New TIniSection(Self, index)
		sections :+ [section]
		Return section
	End Method

	Rem
	bbdoc: Removes a section at the given @index.
	End Rem
	Method RemoveSection(index:Int)
		If index < 0 Or index >= ini_section_count(iniPtr) Then
			Return
		End If

		ini_section_remove(iniPtr, index)

		' not the last section?  We'll need to fix the array
		If index < sections.Length - 1 Then
			Local secs:TIniSection[sections.Length - 1]
			Local n:Int
			For Local i:Int = 0 Until sections.Length
				If i <> index Then
					Local section:TIniSection = sections[i]
					secs[n] = section
					section.index = n
					n :+ 1
				End If
			Next
			sections = secs
		Else
			sections = sections[..index]
		End If
	End Method

	Rem
	bbdoc: Frees instance and associated data.
	End Rem
	Method Free()
		If sections Then
			For Local section:TIniSection = Eachin sections
				section.Free()
			Next
			sections = Null
		End If

		If iniPtr Then
			ini_destroy(iniPtr)
			iniPtr = Null
		End If
	End Method

	Method Delete()
		Free()
	End Method

End Type


Rem
bbdoc: An ini section. 
End Rem
Type TIniSection

	Private
	Field ini:TIni
	Field index:Int
	Field name:String
	Field upperName:String

	Field properties:TIniProperty[]

	Method New()
	End Method

	Method New(ini:TIni, index:Int)
		Self.ini = ini
		Self.index = index
		name = bmx_ini_section_name(ini.iniPtr, index)
		InitProperties()
	End Method

	Method InitProperties()
		Local count:Int = ini_property_count(ini.iniPtr, index)
		properties = New TIniProperty[count]
		For Local i:Int = 0 Until count
			properties[i] = New TIniProperty(Self, i)
		Next
	End Method

	Public

	Rem
	bbdoc: Returns the name of the section, or Null if it is the global section.
	End Rem
	Method GetName:String()
		Return name
	End Method

	Rem
	bbdoc: Sets the name of the section.
	End Rem
	Method SetName(name:String)
		bmx_ini_section_name_set(ini.iniPtr, index, name)
		name = bmx_ini_section_name(ini.iniPtr, index)
		upperName = Null
	End Method

	Rem
	bbdoc: Returns the number of properties in the section.
	End Rem
	Method CountProperties:Int()
		Return ini_property_count(ini.iniPtr, index)
	End Method

	Rem
	bbdoc: Returns a property at the given @index position, or Null if the @index is out of range.
	End Rem
	Method GetProperty:TIniProperty(index:Int)
		If index < 0 Or index >= ini_property_count(ini.iniPtr, Self.index) Then
			Return Null
		End If
		Return properties[index]
	End Method

	Rem
	bbdoc: Finds the property with the given @name, or #Null if not found.
	End Rem
	Method FindProperty:TIniProperty(name:String)
		name = name.ToUpper()
		For Local property:TIniProperty = Eachin properties
			If Not property.upperName Then
				property.upperName = property.name.ToUpper()
			End If
			If name = property.upperName Then
				Return property
			End If
		Next
	End Method

	Rem
	bbdoc: Adds a new property to the section using the specified @name and @value
	End Rem
	Method AddProperty:TIniProperty(name:String, value:String)
		bmx_ini_property_add(ini.iniPtr, index, name, value)
		Local property:TIniProperty = New TIniProperty(Self, CountProperties() - 1)
		properties :+ [property]
		Return property
	End Method

	Rem
	bbdoc: Removes the property with the given @index from the section.
	End Rem
	Method RemoveProperty(index:Int)
		If index < 0 Or index >= ini_property_count(ini.iniPtr, Self.index) Then
			Return
		End If

		ini_property_remove(ini.iniPtr, Self.index, index)

		' not the last property?  We'll need to fix the array
		If index < properties.Length - 1 Then
			Local props:TIniProperty[properties.Length - 1]
			Local n:Int
			For Local i:Int = 0 Until properties.Length
				If i <> index Then
					Local prop:TIniProperty = properties[i]
					props[n] = prop
					prop.index = n
					n :+ 1
				End If
			Next
			properties = props
		Else
			properties = properties[..index]
		End If
	End Method

	Method Free()
		properties = Null
	End Method

End Type

Rem
bbdoc: An ini property, with a name and value.
End Rem
Type TIniProperty

	Private
	Field section:TIniSection
	Field index:Int
	Field name:String
	Field upperName:String

	Method New()
	End Method

	Method New(section:TIniSection, index:Int)
		Self.section = section
		Self.index = index
		name = bmx_ini_property_name(section.ini.iniPtr, section.index, index)
	End Method

	Public

	Rem
	bbdoc: Returns the name of the property.
	End Rem
	Method GetName:String()
		Return name
	End Method

	Rem
	bbdoc: Sets the name the property.
	End Rem
	Method SetName(name:String)
		bmx_ini_property_name_set(section.ini.iniPtr, section.index, index, name)
		name = bmx_ini_property_name(section.ini.iniPtr, section.index, index)
	End Method

	Rem
	bbdoc: Returns the value for the property
	End Rem
	Method GetValue:String()
		Return bmx_ini_property_value(section.ini.iniPtr, section.index, index)
	End Method

	Rem
	bbdoc: Sets the value for the property
	End Rem
	Method SetValue(value:String)
		bmx_ini_property_value_set(section.ini.iniPtr, section.index, index, value)
	End Method

	Rem
	bbdoc: Removes the property from its section.
	End Rem
	Method Remove()
		section.RemoveProperty(index)
	End Method

End Type
