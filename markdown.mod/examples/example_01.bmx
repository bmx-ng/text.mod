SuperStrict

Framework brl.standardio
Import text.markdown

Local parser:TParser = New TParser

TMarkdown.Parse(parser, """
Hello *World*!
* First
* Second
""")


Type TParser Implements IMDParser

	Method EnterBlock:Int(block:TMDBlock)
		Print "EnterBlock : " + block.GetType().ToString()
	End Method

	Method LeaveBlock:Int(block:TMDBlock)
		Print "LeaveBlock : " + block.GetType().ToString()
	End Method

	Method EnterSpan:Int(span:TMDSpan)
		Print "EnterSpan : " + span.GetType().ToString()
	End Method

	Method LeaveSpan:Int(span:TMDSpan)
		Print "LeaveSpan : " + span.GetType().ToString()
	End Method

	Method Text:Int(text:String, textType:EMDTextType)
		Print "Text : " + text
	End Method

End Type
