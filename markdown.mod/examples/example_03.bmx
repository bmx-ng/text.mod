SuperStrict

Framework brl.standardio
Import text.markdown
Import text.pikchr
Import text.graphviz

Local sb:TStringBuilder = New TStringBuilder
Local highlighter:THighlighter = New THighlighter

sb.Append("<!DOCTYPE html><html><head><meta charset=~qutf-8~q><title>Markdown</title>")
sb.Append("<body>")

TMarkdown.ParseToHtml("""
Hello !
```pikchr
A: ellipse thick
line thin color gray left 70% from 2mm left of (A.w,A.n)
line same from 2mm left of (A.w,A.s)
text "height" at (7/8<previous.start,previous.end>,1/2<1st line,2ndline>)
line thin color gray from previous text.n up until even with 1st line ->
line thin color gray from previous text.s down until even with 2nd line ->
X1: line thin color gray down 50% from 2mm below (A.w,A.s)
X2: line thin color gray down 50% from 2mm below (A.e,A.s)
text "width" at (1/2<X1,X2>,6/8<X1.start,X1.end>)
line thin color gray from previous text.w left until even with X1 ->
line thin color gray from previous text.e right until even with X2 ->
```
hmm...
```csharp
Console.WriteLine("Hello World!");
```
World!
```dot
digraph U {
  eee -> {
  a [label="abc &aelig; z"]
  2[label="ü"];
  3[label="ä"];
  4[label="ö"];
  d [label=" well &#9679; ok"]

  F [label="f: &#958;"]

  B  [label= "Fichier non trouvé"]
  p1 [label="p1: &#9816;"]
  p2 [label="p2: &#x2658;"]
  }
}
```
""", sb,,,,highlighter)

sb.Append("</body></html>")

Local s:String = sb.ToString()
Local buf:Byte[] = New Byte[s.length * 3]
Local length:size_t = buf.length
s.ToUTF8StringBuffer(buf, length)
SaveByteArray( buf, "markdown.html" )


Type THighlighter Extends TMDHtmlCodeHighlighter

	Method Text:Int(lang:String, info:String[], txt:String, output:TStringBuilder)

		Select lang
		Case "pikchr"
			Local width:Int, height:Int
			Local out:String = Pikchr(txt, Null, EPikChrFlags.NONE, width, height)

			output.Append("<div style=~qmax-width:").Append(width).Append("px~q>")
			output.Append(out)
			output.Append("</div>")

			Return True
		Case "dot"

			Local g:TGVGraphviz = New TGVGraphviz
			Local graph:TAGraph = TAGraph.FromString(txt)

			Local engine:String = "dot"
			Local parts:String[] = info[0].Split(" ")
			If parts.Length > 1 Then
				engine = parts[1]
			End If

			graph.Unflatten(4)

			Local res:Int = g.Layout(graph, engine)
			Local svg:String = g.ToSvg(graph)

			output.Append(svg)
			Return True
		End Select

		Return False
	End Method

End Type
