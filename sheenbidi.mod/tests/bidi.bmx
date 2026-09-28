SuperStrict
Framework BRL.StandardIO
Import Text.SheenBidi

Function Check(value:Int,message:String)
	If Not value Then Throw message
End Function
Local provider:TTextBidiProvider=GetTextBidiProvider()
Local paragraph:TTextBidiParagraph=provider.Analyze("abc אבג 123")
Local runs:TTextBidiRun[]=paragraph.Line(0,paragraph.length)
Check(paragraph.baseLevel=0,"base level")
Check(runs.Length=3,"three level/script runs")
Check(runs[0].first=0 And runs[1].first=8 And runs[2].first=4,"visual order")
Check(runs[1].level=2 And runs[2].level=1,"nested number direction")
Check(provider.Analyze("אבג abc").baseLevel=1,"auto RTL")
Check(provider.Analyze("abc",ETextDirection.RightToLeft).baseLevel=1,"explicit RTL")
Check(provider.Analyze("").Line(0,0).Length=0,"empty")
Local whitespace:TTextBidiParagraph=provider.Analyze("abc אבג   xyz")
For Local run:TTextBidiRun=EachIn whitespace.Line(0,10)
	If run.last>7 Then Check(run.level=0,"Wrapped line trailing whitespace resets to paragraph level")
Next
Local supplementary:String=String.FromShorts([$d83d:Short,$de00:Short],2)
Local unicodeText:String="abc "+supplementary+" אבג"
Local unicodeParagraph:TTextBidiParagraph=provider.Analyze(unicodeText)
For Local run:TTextBidiRun=EachIn unicodeParagraph.Line(0,unicodeText.Length)
	Check(run.first<>5 And run.last<>5,"No run splits a surrogate pair")
Next
Local isolate:String="a "+Chr($2067)+"אבג 123"+Chr($2069)+" z"
Local isolated:TTextBidiParagraph=provider.Analyze(isolate)
Local covered:Int
For Local run:TTextBidiRun=EachIn isolated.Line(0,isolate.Length)
	covered:+run.last-run.first
Next
Check(covered=isolate.Length,"Isolates retain source coverage")
Local rejected:Int
Try
	paragraph.Line(-1,1)
Catch error:Object
	rejected=True
End Try
Check(rejected,"Invalid line ranges rejected")
Print "SheenBidi provider tests passed"
