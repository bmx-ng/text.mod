Framework BRL.Blitz
Import BRL.FileSystem
Import BRL.StandardIO
Import Text.CharsetDetect

Local files:String[] = LoadDir(".")

For Local file:String = EachIn files
	Local ext:String = ExtractExt(file)
	
	If ext <> "txt"
		Continue
	EndIf
	
	Print file
	
	Local cd:TCharsetDetect = New TCharsetDetect()
	cd.Detect(LoadString(file))
	
	Print "Encoding: " + cd.GetEncoding()
	Print "Confidence: " + cd.GetConfidence()
	Print "BOM: " + cd.GetBom()
	Print
Next