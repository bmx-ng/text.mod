SuperStrict

Framework Text.Ini
Import BRL.StandardIO

Local ini:TIni = New TIni

Local section:TIniSection = ini.AddSection("First")
Local property:TIniProperty = section.AddProperty("key", "value")


ini.Save("example_02.ini")

section.AddProperty("k2", "v2")

property.SetName("name")
property.SetValue("new value")

ini.Save("example_02b.ini")

Local prop:TIniProperty = section.FindProperty("k2")
If prop Then
	Print "Found : " + prop.GetName() + "=" + prop.GetValue()
End If
