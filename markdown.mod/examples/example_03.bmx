SuperStrict

Framework brl.standardio
Import text.markdown
Import text.pikchr

Local sb:TStringBuilder = New TStringBuilder
Local highlighter:THighlighter = New THighlighter

sb.Append("<!DOCTYPE html><html><head><meta charset=~qutf-8~q><title>Markdown</title>")
sb.Append("<body>")

TMarkdown.ParseToHtml("""
Hello !
```pikchr
arrow right 200% "Markdown" "Source"
box rad 10px "Markdown" "Formatter" "(markdown.c)" fit
arrow right 200% "HTML+SVG" "Output"
arrow <-> down 70% from last box.s
box same "Pikchr" "Formatter" "(pikchr.c)" fit
```
hmm...
```csharp
Console.WriteLine("Hello World!");
```
World!
""", sb,,,,highlighter)

sb.Append("</body></html>")

SaveString(sb.ToString(), "markdown.html")


Type THighlighter Extends TMDHtmlCodeHighlighter

	Method Text:Int(lang:String, txt:String, output:TStringBuilder)

		If lang = "pikchr" Then
			Local width:Int, height:Int
			Local out:String = Pikchr(txt, Null, EPikChrFlags.NONE, width, height)
			
			output.Append("<div style=~qmax-width:").Append(width).Append("px~q>")
			output.Append(out)
			output.Append("</div>")

			Return True
		End If

		Return False
	End Method

End Type
