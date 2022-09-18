SuperStrict

Framework Text.Ini
Import BRL.StandardIO

Local ini:TIni = TIni.Load("cfg.ini")

If ini Then
	For Local i:Int = 0 Until ini.CountSections()

		Local section:TIniSection = ini.GetSection(i)

		If section.GetName() Then
			Print "[" + section.GetName() + "]"
		End If

		For Local n:Int = 0 Until section.CountProperties()
			Local property:TIniProperty = section.GetProperty(n)
			
			Print property.GetName() + "=" + property.GetValue()
		Next

		Print ""
	Next

	Local section:TIniSection = ini.FindSection("postOSInstall")
	If section Then
		Print "Found : " + section.GetName()
	End If

	ini.Free()
End If
