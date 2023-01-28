SuperStrict

Framework Text.PDF

Local pageTitle:String = "Line Example"

Local DASH_MODE1:Float[] = [3]
Local DASH_MODE2:Float[] = [3, 7]
Local DASH_MODE3:Float[] = [8, 7, 2, 7]


Local pdf:TPDFDoc = New TPDFDoc

Local font:TPDFFont = pdf.GetFont("Helvetica", NULL);

' add a new page object
Local page:TPDFPage = pdf.AddPage()

' print the lines of the page
page.SetLineWidth(1)
page.Rectangle(50, 50, page.GetWidth() - 100, page.GetHeight() - 110)
page.Stroke()



' print the title of the page (with positioning center).
page.SetFontAndSize(font, 24)
Local textWidth:Float = page.TextWidth(pageTitle)
page.BeginText()
page.MoveTextPos((page.GetWidth() - textWidth) / 2, page.GetHeight() - 50)
page.ShowText(pageTitle)
page.EndText()

page.SetFontAndSize(font, 10)

' Draw various widths of lines.
page.SetLineWidth(0)
DrawLine(page, 60, 770, "line width = 0")

page.SetLineWidth(1.0)
DrawLine(page, 60, 740, "line width = 1.0")

page.SetLineWidth(2.0)
DrawLine(page, 60, 710, "line width = 2.0")

' Line dash pattern
page.SetLineWidth(1.0)

page.SetDash(DASH_MODE1, 1, 1)
DrawLine(page, 60, 680, "dash_ptn=[3], phase=1 -- 2 on, 3 off, 3 on...")

page.SetDash(DASH_MODE2, 2, 2)
DrawLine(page, 60, 650, "dash_ptn=[7, 3], phase=2 -- 5 on 3 off, 7 on,...")

page.SetDash(DASH_MODE3, 4, 0)
DrawLine(page, 60, 620, "dash_ptn=[8, 7, 2, 7], phase=0")

page.SetDash(Null, 0, 0)

page.SetLineWidth(30)
page.SetRGBStroke(0.0, 0.5, 0.0)

' Line Cap Style
page.SetLineCap(EPDFLineCap.BUTT_END)
DrawLine2(page, 60, 570, "BUTT_END")

page.SetLineCap(EPDFLineCap.ROUND_END)
DrawLine2(page, 60, 505, "ROUND_END")

page.SetLineCap(EPDFLineCap.PROJECTING_SQUARE_END)
DrawLine2(page, 60, 440, "PROJECTING_SQUARE_END")

' Line Join Style
page.SetLineWidth(30)
page.SetRGBStroke(0.0, 0.0, 0.5)

page.SetLineJoin(EPDFLineJoin.MITER_JOIN)
page.MoveTo(120, 300)
page.LineTo(160, 340)
page.LineTo(200, 300)
page.Stroke()

page.BeginText()
page.MoveTextPos(60, 360)
page.ShowText("MITER_JOIN")
page.EndText()

page.SetLineJoin(EPDFLineJoin.ROUND_JOIN)
page.MoveTo(120, 195)
page.LineTo(160, 235)
page.LineTo(200, 195)
page.Stroke()

page.BeginText()
page.MoveTextPos(60, 255)
page.ShowText("ROUND_JOIN")
page.EndText()

page.SetLineJoin(EPDFLineJoin.BEVEL_JOIN)
page.MoveTo(120, 90)
page.LineTo(160, 130)
page.LineTo(200, 90)
page.Stroke()

page.BeginText()
page.MoveTextPos(60, 150)
page.ShowText("BEVEL_JOIN")
page.EndText()

' Draw Rectangle
page.SetLineWidth(2)
page.SetRGBStroke(0, 0, 0)
page.SetRGBFill(0.75, 0.0, 0.0)

DrawRect(page, 300, 770, "Stroke")
page.Stroke()

DrawRect(page, 300, 720, "Fill")
page.Fill()

DrawRect(page, 300, 670, "Fill then Stroke")
page.FillStroke()

' Clip Rect
page.GSave()  ' Save the current graphic state
DrawRect(page, 300, 620, "Clip Rectangle")
page.Clip()
page.Stroke()
page.SetFontAndSize(font, 13)

page.BeginText()
page.MoveTextPos(290, 600)
page.SetTextLeading(12)
page.ShowText("Clip Clip Clip Clip Clip Clipi Clip Clip Clip")
page.ShowTextNextLine("Clip Clip Clip Clip Clip Clip Clip Clip Clip")
page.ShowTextNextLine("Clip Clip Clip Clip Clip Clip Clip Clip Clip")
page.EndText()
page.GRestore()

' Curve Example(CurveTo2)
Local x:Float = 330
Local y:Float = 440
Local x1:Float = 430
Local y1:Float = 530
Local x2:Float = 480
Local y2:Float = 470
Local x3 :Float= 480
Local y3:Float = 90

page.SetRGBFill(0, 0, 0)

page.BeginText()
page.MoveTextPos(300, 540)
page.ShowText("CurveTo2(x1, y1, x2, y2)")
page.EndText()

page.BeginText()
page.MoveTextPos(x + 5, y - 5)
page.ShowText("Current point")
page.MoveTextPos(x1 - x, y1 - y)
page.ShowText("(x1, y1)")
page.MoveTextPos(x2 - x1, y2 - y1)
page.ShowText("(x2, y2)")
page.EndText()

page.SetDash(DASH_MODE1, 1, 0)

page.SetLineWidth(0.5)
page.MoveTo(x1, y1)
page.LineTo(x2, y2)
page.Stroke()

page.SetDash(Null, 0, 0)

page.SetLineWidth(1.5)

page.MoveTo(x, y)
page.CurveTo2(x1, y1, x2, y2)
page.Stroke()

' Curve Example(CurveTo3)
y :- 150
y1 :- 150
y2 :- 150

page.BeginText()
page.MoveTextPos(300, 390)
page.ShowText("CurveTo3(x1, y1, x2, y2)")
page.EndText()

page.BeginText()
page.MoveTextPos(x + 5, y - 5)
page.ShowText("Current point")
page.MoveTextPos(x1 - x, y1 - y)
page.ShowText("(x1, y1)")
page.MoveTextPos(x2 - x1, y2 - y1)
page.ShowText("(x2, y2)")
page.EndText()

page.SetDash(DASH_MODE1, 1, 0)

page.SetLineWidth(0.5)
page.MoveTo(x, y)
page.LineTo(x1, y1)
page.Stroke()

page.SetDash(Null, 0, 0)

page.SetLineWidth(1.5)
page.MoveTo(x, y)
page.CurveTo3(x1, y1, x2, y2)
page.Stroke()

' Curve Example(CurveTo)
y :- 150
y1 :- 160
y2 :- 130
x2 :+ 10

page.BeginText()
page.MoveTextPos(300, 240)
page.ShowText("CurveTo(x1, y1, x2. y2, x3, y3)")
page.EndText()

page.BeginText()
page.MoveTextPos(x + 5, y - 5)
page.ShowText("Current point")
page.MoveTextPos(x1 - x, y1 - y)
page.ShowText("(x1, y1)")
page.MoveTextPos(x2 - x1, y2 - y1)
page.ShowText("(x2, y2)")
page.MoveTextPos(x3 - x2, y3 - y2)
page.ShowText("(x3, y3)")
page.EndText()

page.SetDash(DASH_MODE1, 1, 0)

page.SetLineWidth(0.5)
page.MoveTo(x, y)
page.LineTo(x1, y1)
page.Stroke()
page.MoveTo(x2, y2)
page.LineTo(x3, y3)
page.Stroke()

page.SetDash(Null, 0, 0)

page.SetLineWidth(1.5)
page.MoveTo(x, y)
page.CurveTo(x1, y1, x2, y2, x3, y3)
page.Stroke()


' save the document to a file
pdf.Save("line_example.pdf")

' free up
pdf.Free()


Function DrawLine(page:TPDFPage, x:Float, y:Float, label:String)
	page.BeginText()
	page.MoveTextPos(x, y - 10)
	page.ShowText(label)
	page.EndText()

	page.MoveTo(x, y - 15)
	page.LineTo(x + 220, y - 15)
	page.Stroke()
End Function

Function DrawLine2(page:TPDFPage, x:Float, y:Float, label:String)
	page.BeginText()
	page.MoveTextPos(x, y)
	page.ShowText(label)
	page.EndText()

	page.MoveTo(x + 30, y - 25)
	page.LineTo(x + 160, y - 25)
	page.Stroke()
End Function

Function DrawRect(page:TPDFPage, x:Float, y:Float, label:String)
	page.BeginText()
	page.MoveTextPos(x, y - 10)
	page.ShowText(label)
	page.EndText()

	page.Rectangle(x, y - 40, 220, 25)
End Function
