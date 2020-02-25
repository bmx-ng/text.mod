' Replaces 'bb' for 'd'

SuperStrict

Framework Text.RegEx
Import BRL.StandardIO

Local change:String = "yabba dabba doo"


Local regex:TRegEx = TRegEx.Create("bb")

Try

	Local s:String = regex.Replace(change, "d")
		
	Print "before = " + change
	Print "after  = " + s
	

Catch e:TRegExException

	Print "Error : " + e.toString()
	End
	
End Try

Print "Done."


