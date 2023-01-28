SuperStrict

Framework Text.PDF
Import BRL.Math

Import "grid_sheet.bmx"


Const pageTitle:String = "Text example"
Const sampText:String = "abcdefgABCDEFG123!#$%&+-@?"
Const sampText2:String = "The quick brown fox jumps over the lazy dog."



Local pdf:TPDFDoc = New TPDFDoc

pdf.SetCompressionMode(EPDFCompressionMode.COMP_ALL)

' create default-font */
Local font:TPDFFont = pdf.GetFont("Helvetica", Null)

' add a new page object
Local page:TPDFPage = pdf.AddPage()

PrintGrid(pdf, page)

' print the title of the page (with positioning center).
page.SetFontAndSize(font, 24)
Local tw:Float = page.TextWidth(pageTitle)
page.BeginText()
page.TextOut((page.GetWidth() - tw) / 2, page.GetHeight() - 50, pageTitle)
page.EndText()

page.BeginText()
page.MoveTextPos(60, page.GetHeight() - 60)

' font size

Local fsize:Float = 8
While fsize < 60

	' set style and size of font.
	page.SetFontAndSize(font, fsize)

	' set the position of the text.
	page.MoveTextPos(0, -5 - fsize)

	' measure the number of characters which included in the page.
	Local length:Int = page.MeasureText(sampText, page.GetWidth() - 120, False, Null)

	page.ShowText(sampText[..length])

	' print the description.
	page.MoveTextPos(0, -10)
	page.SetFontAndSize(font, 8)
	page.ShowText("Fontsize=" + Int(fsize))

	fsize :* 1.5
Wend

' font color

page.SetFontAndSize(font, 8)
page.MoveTextPos(0, -30)
page.ShowText("Font color")

page.SetFontAndSize(font, 18)
page.MoveTextPos(0, -20)
Local length:Int = sampText.Length
for Local i:Int = 0 Until length
	Local r:Float =Float(i) / Float(length)
	Local g:Float = 1 - (Float(i) / Float(length))

	page.SetRGBFill(r, g, 0.0)
	page.ShowText(sampText[i..i+1])
Next
page.MoveTextPos(0, -25)

For Local i:Int = 0 Until length
	Local r:Float = Float(i) / Float(length)
	Local b:Float = 1 - (Float(i) / Float(length))

	page.SetRGBFill(r, 0.0, b)
	page.ShowText(sampText[i..i+1])
Next
page.MoveTextPos(0, -25)

For Local i:Int = 0 Until length
	Local b:Float = Float(i) / Float(length)
	Local g:Float = 1 - (Float(i) / Float(length))

	page.SetRGBFill(0.0, g, b)
	page.ShowText(sampText[i..i+1])
Next

page.EndText()

Local ypos:Float = 450

' Font rendering mode
page.SetFontAndSize(font, 32)
page.SetRGBFill(0.5, 0.5, 0.0)
page.SetLineWidth(1.5)

' PDF_FILL
ShowDescription(page, 60, ypos, "RenderingMode=FILL")
page.SetTextRenderingMode(EPDFTextRenderingMode.FILL)
page.BeginText()
page.TextOut(60, ypos, "ABCabc123")
page.EndText()

' PDF_STROKE
ShowDescription(page, 60, ypos - 50, "RenderingMode=STROKE")
page.SetTextRenderingMode(EPDFTextRenderingMode.STROKE)
page.BeginText()
page.TextOut(60, ypos - 50, "ABCabc123")
page.EndText()

' PDF_FILL_THEN_STROKE
ShowDescription(page, 60, ypos - 100, "RenderingMode=FILL_THEN_STROKE")
page.SetTextRenderingMode(EPDFTextRenderingMode.FILL_THEN_STROKE)
page.BeginText()
page.TextOut(60, ypos - 100, "ABCabc123")
page.EndText()

' PDF_FILL_CLIPPING
ShowDescription(page, 60, ypos - 150, "RenderingMode=FILL_CLIPPING")
page.GSave()
page.SetTextRenderingMode(EPDFTextRenderingMode.FILL_CLIPPING)
page.BeginText()
page.TextOut(60, ypos - 150, "ABCabc123")
page.EndText()
ShowStripePattern(page, 60, ypos - 150)
page.GRestore()

' PDF_STROKE_CLIPPING
ShowDescription(page, 60, ypos - 200, "RenderingMode=STROKE_CLIPPING")
page.GSave()
page.SetTextRenderingMode(EPDFTextRenderingMode.STROKE_CLIPPING)
page.BeginText()
page.TextOut(60, ypos - 200, "ABCabc123")
page.EndText()
ShowStripePattern(page, 60, ypos - 200)
page.GRestore()

' PDF_FILL_STROKE_CLIPPING
ShowDescription(page, 60, ypos - 250, "RenderingMode=FILL_STROKE_CLIPPING")
page.GSave()
page.SetTextRenderingMode(EPDFTextRenderingMode.FILL_STROKE_CLIPPING)
page.BeginText()
page.TextOut(60, ypos - 250, "ABCabc123")
page.EndText()
ShowStripePattern(page, 60, ypos - 250)
page.GRestore()

' Reset text attributes
page.SetTextRenderingMode(EPDFTextRenderingMode.FILL)
page.SetRGBFill(0, 0, 0)
page.SetFontAndSize(font, 30)


' Rotating text
Local angle1:Float = 30 ' A rotation of 30 degrees.

ShowDescription(page, 320, ypos - 60, "Rotating text")
page.BeginText()
page.SetTextMatrix(Float(Cos(angle1)), Float(Sin(angle1)), Float(-Sin(angle1)), Float(Cos(angle1)), 330, ypos - 60)
page.ShowText("ABCabc123")
page.EndText()

' Skewing text.
ShowDescription(page, 320, ypos - 120, "Skewing text")
page.BeginText()

angle1 = 10
Local angle2:Float = 20

page.SetTextMatrix(1, Float(Tan(angle1)), Float(tan(angle2)), 1, 320, ypos - 120)
page.ShowText("ABCabc123")
page.EndText()

' scaling text(X direction)
ShowDescription(page, 320, ypos - 175, "Scaling text(X direction)")
page.BeginText()
page.SetTextMatrix(1.5, 0, 0, 1, 320, ypos - 175)
page.ShowText("ABCabc12")
page.EndText()


' scaling text(Y direction)
ShowDescription(page, 320, ypos - 250, "Scaling text(Y direction)")
page.BeginText()
page.SetTextMatrix(1, 0, 0, 2, 320, ypos - 250)
page.ShowText("ABCabc123")
page.EndText()

' char spacing, word spacing

ShowDescription(page, 60, 140, "char-spacing 0")
ShowDescription(page, 60, 100, "char-spacing 1.5")
ShowDescription(page, 60, 60, "char-spacing 1.5, word-spacing 2.5")

page.SetFontAndSize(font, 20)
page.SetRGBFill(0.1, 0.3, 0.1)

' char-spacing 0
page.BeginText()
page.TextOut(60, 140, sampText2)
page.EndText()

' char-spacing 1.5
page.SetCharSpace(1.5)

page.BeginText()
page.TextOut(60, 100, sampText2)
page.EndText()

' char-spacing 1.5, word-spacing 3.5
page.SetWordSpace(2.5)

page.BeginText()
page.TextOut(60, 60, sampText2)
page.EndText()

' save the document to a file
pdf.Save("text_example.pdf")

' free up
pdf.Free()


Function ShowDescription(page:TPDFPage, x:Float, y:Float, text:String)

	Local fsize:Float = page.GetCurrentFontSize()
	Local font:TPDFFont = page.GetCurrentFont()
	Local c:SPDFRGBColor = page.GetRGBFill()

	page.BeginText()
	page.SetRGBFill(0, 0, 0)
	page.SetTextRenderingMode(EPDFTextRenderingMode.FILL)
	page.SetFontAndSize(font, 10)
	page.TextOut(x, y - 12, text)
	page.EndText()

	page.SetFontAndSize(font, fsize)
	page.SetRGBFill(c.r, c.g, c.b)
End Function

Function ShowStripePattern(page:TPDFPage, x:Float, y:Float)

	Local iy:UInt = 0

	While iy < 50
		page.SetRGBStroke(0.0, 0.0, 0.5)
		page.SetLineWidth(1)
		page.MoveTo(x, y + iy)
		page.LineTo(x + page.TextWidth("ABCabc123"), y + iy)
		page.Stroke()
		iy :+ 3
	Wend

	page.SetLineWidth(2.5)
End Function
