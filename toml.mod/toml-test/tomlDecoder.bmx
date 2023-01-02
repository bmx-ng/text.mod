'
' Can be used with the toml-test test suite ( https://github.com/BurntSushi/toml-test )
'
' eg:  ./toml-test ./tomlDecoder
'
SuperStrict

Framework Text.Toml
Import Text.JSON
Import BRL.Stream
Import BRL.StringBuilder
Import BRL.StandardIO

Local sb:TStringBuilder = New TStringBuilder

Local stdin:TTextStream = TTextStream(StandardIOStream)

While Not stdin.Eof()
	sb.AppendChar(stdin.ReadChar())
Wend

Try
	Local table:TTomlTable = TToml.Parse(sb.ToString())

	Local json:TJSONObject = TableToJson(table)

	Print json.SaveString()

Catch e:TTomlParseError
	ErrPrint e.message
	exit_(1)
End Try

Function NodeToJson:TJSON(node:ITomlNode)
	Select node.NodeType()
		Case ETomlNodeType.TomlTable
			Return TableToJson(TTomlTable(node))
		Case ETomlNodeType.TomlArray
			Return ArrayToJson(TTomlArray(node))
		Case ETomlNodeType.TomlString
			Return StringToJson(TTomlString(node))
		Case ETomlNodeType.TomlInteger
			Return IntegerToJson(TTomlInteger(node))
		Case ETomlNodeType.TomlFloatingPoint
			Return FloatToJson(TTomlFloatingPoint(node))
		Case ETomlNodeType.TomlBoolean
			Return BoolToJson(TTomlBoolean(node))
		Case ETomlNodeType.TomlDate
			Return DateToJson(TTomlDate(node))
		Case ETomlNodeType.TomlTime
			Return TimeToJson(TTomlTime(node))
		Case ETomlNodeType.TomlDateTime
			Return DateTimeToJson(TTomlDateTime(node))
	End Select
End Function

Function TableToJson:TJSONObject(table:TTomlTable)
	Local obj:TJSONObject = New TJSONObject.Create()

	For Local k:String = Eachin table.Keys()
		Local value:ITomlNode = table[k]

		obj.Set(k, NodeToJson(value))
	Next

	Return obj
End Function

Function ArrayToJson:TJSONArray(array:TTomlArray)
	Local arr:TJSONArray = New TJSONArray.Create()

	For Local v:ITomlNode = Eachin array.value
		arr.Append(NodeToJson(v))
	Next

	Return arr
End Function

Function IntegerToJson:TJSONObject(value:TTomlInteger)
	Local obj:TJSONObject = New TJSONObject.Create()
	obj.Set("type", "integer")
	obj.Set("value", String(value.value))
	Return obj
End Function

Function StringToJson:TJSONObject(value:TTomlString)
	Local obj:TJSONObject = New TJSONObject.Create()
	obj.Set("type", "string")
	obj.Set("value", value.value)
	Return obj
End Function

Function FloatToJson:TJSONObject(value:TTomlFloatingPoint)
	Local obj:TJSONObject = New TJSONObject.Create()
	obj.Set("type", "float")
	obj.Set("value", String(value.value))
	Return obj
End Function

Function BoolToJson:TJSONObject(value:TTomlBoolean)
	Local obj:TJSONObject = New TJSONObject.Create()
	obj.Set("type", "bool")
	If value.value Then
		obj.Set("value", "true")
	Else
		obj.Set("value", "false")
	End If
	Return obj
End Function

Function DateToJson:TJSONObject(value:TTomlDate)
	Local obj:TJSONObject = New TJSONObject.Create()
	obj.Set("type", "date-local")
	obj.Set("value", value.value.ToString())
	Return obj
End Function

Function TimeToJson:TJSONObject(value:TTomlTime)
	Local obj:TJSONObject = New TJSONObject.Create()
	obj.Set("type", "time-local")
	obj.Set("value", value.value.ToString())
	Return obj
End Function

Function DateTimeToJson:TJSONObject(value:TTomlDateTime)
	Local obj:TJSONObject = New TJSONObject.Create()
	If value.IsLocal() Then
		obj.Set("type", "datetime-local")
	Else
		obj.Set("type", "datetime")
	End If
	obj.Set("value", value.value.ToString())
	Return obj
End Function
