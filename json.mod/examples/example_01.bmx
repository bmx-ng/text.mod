SuperStrict

Framework Text.Json
Import BRL.StandardIO
Import BRL.TextStream

Local Text:String = LoadText("menu.json")

Print "* ORIGINAL *"
Print Text

Local error:TJSONError

Local json:TJSON = TJSON.Load(Text, 0, error)

Print "* RE-ENCODED *"
Print json.SaveString(0, 2)
