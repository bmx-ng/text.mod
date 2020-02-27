SuperStrict

Framework Text.Json
Import BRL.StandardIO


Local json:TJSONObject = New TJSONObject.Create()

json.Set("data", New TJSONString.Create("~q'~~\}{][!@£$%^&*"))


Print "* RE-ENCODED *"
Print json.SaveString(0, 2)

