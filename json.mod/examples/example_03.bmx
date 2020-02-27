SuperStrict

Framework Text.Json
Import BRL.StandardIO
Import BRL.TextStream

Local Text:String = LoadText("menu.json")

Local error:TJSONError

Local json:TJSON = TJSON.Load(Text, 0, error)

If Not error Then

	If TJSONObject(json) Then

		For Local j:TJSON = EachIn TJSONObject(json)
			Print j.SaveString(0, 2)
		Next

	End If
	
End If


