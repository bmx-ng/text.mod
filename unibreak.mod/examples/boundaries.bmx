SuperStrict
Framework BRL.StandardIO
Import Text.Unibreak

Local text:String = "Hello world"
Local provider:TTextBoundaryProvider = GetTextBoundaryProvider()
Print provider.Name()
Local boundaries:TTextBoundaries = provider.Analyze(text)
For Local offset:Int = 0 To text.Length
	If boundaries.lineBreaks[offset] Then Print "Line break allowed at UTF-16 offset " + offset
Next
