SuperStrict

Framework Text.Toml
Import brl.standardio


Local table:TTomlTable = TToml.Load("example.toml")

If table Then
	Print "Is a table : " + table.IsTable()

	For Local key:String = Eachin table.Keys()
		Print "key : " + key
	Next

	Print ""
	
	Local title:ITomlNode = table["title"]
	If title Then
		Print title.AsString()
	End if

	Print table["str1"].AsString()
End If
