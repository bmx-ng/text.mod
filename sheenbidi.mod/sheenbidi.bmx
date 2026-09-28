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

Rem
bbdoc: Optional Unicode bidirectional analysis using bundled SheenBidi 3.0.0 (Unicode 17.0).
about: Importing this module registers the provider with Text.Bidi. Sources compile directly into the application.
End Rem
Module Text.SheenBidi
ModuleInfo "Version: 1.00"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: zlib/libpng (wrapper); Apache-2.0 (SheenBidi); Unicode data licence"
ModuleInfo "CC_OPTS: -std=c99 -DSB_CONFIG_UNITY -I%PWD%/SheenBidi/Headers -I%PWD%/SheenBidi/Source"

Import "common.bmx"

Type TSheenBidiParagraph Extends TTextBidiParagraph
	Private
	Field handle:Byte Ptr
	Public
	Method Delete()
		If handle Then bmx_sheen_free(handle)
	End Method
	Method Line:TTextBidiRun[](first:Int,length:Int) Override
		If first<0 Or length<0 Or first>Self.length-length Then Throw "Text.SheenBidi: invalid line range"
		If Not length Then Return New TTextBidiRun[0]
		Local count:Int
		Local native:Byte Ptr=bmx_sheen_line(handle,first,length,count)
		If Not native Then Throw "Text.SheenBidi: cannot resolve line"
		Local result:TTextBidiRun[]
		Try
			result=New TTextBidiRun[count]
			For Local i:Int=0 Until count
				Local run:TTextBidiRun=New TTextBidiRun
				bmx_sheen_run(native,i,run.first,run.last,run.level,run.script)
				result[i]=run
			Next
		Catch error:Object
			bmx_sheen_runs_free(native)
			Throw error
		End Try
		bmx_sheen_runs_free(native)
		Return result
	End Method
	Function Create:TSheenBidiParagraph(text:String,direction:ETextDirection)
		Local result:TSheenBidiParagraph=New TSheenBidiParagraph
		result.length=text.Length
		If Not text.Length Then
			result.baseLevel=Int(direction=ETextDirection.RightToLeft)
			Return result
		End If
		result.handle=bmx_sheen_create(text,Int(direction),result.baseLevel)
		If Not result.handle Then Throw "Text.SheenBidi: expected a single paragraph or allocation failed"
		Return result
	End Function
End Type

Type TSheenBidiProvider Extends TTextBidiProvider
	Method Name:String() Override
		Return "SheenBidi 3.0.0 / Unicode 17.0"
	End Method
	Method Analyze:TTextBidiParagraph(text:String,direction:ETextDirection=ETextDirection.Auto) Override
		If direction<>ETextDirection.Auto And direction<>ETextDirection.LeftToRight And direction<>ETextDirection.RightToLeft Then Throw "Text.SheenBidi: invalid analysis direction"
		Return TSheenBidiParagraph.Create(text,direction)
	End Method
End Type

RegisterTextBidiProvider(New TSheenBidiProvider)
