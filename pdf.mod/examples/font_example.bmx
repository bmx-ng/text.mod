SuperStrict

Framework Text.PDF

Const pageTitle:String = "Font example"

Local fontList:String[] = ["Courier", "Courier-Bold", "Courier-Oblique", "Courier-BoldOblique", ..
	"Helvetica", "Helvetica-Bold", "Helvetica-Oblique", "Helvetica-BoldOblique","Times-Roman", ..
	"Times-Bold", "Times-Italic", "Times-BoldItalic", "Symbol", "ZapfDingbats"]

Local pdf:TPDFDoc = New TPDFDoc

' Add a new page object.
Local page:TPDFPage = pdf.AddPage()

Local height:Float = page.GetHeight()
Local width:Float = page.GetWidth()

' Print the lines of the page.
page.SetLineWidth(1)
page.Rectangle(50, 50, width - 100, height - 110)
page.Stroke()

' Print the title of the page(with positioning center).
Local defaultFont:TPDFFont = pdf.GetFont("Helvetica", NULL)
page.SetFontAndSize(defaultFont, 24)

Local tw:Float = page.TextWidth(pageTitle)
page.BeginText()
page.TextOut((width - tw) / 2, height - 50, pageTitle)
page.EndText()

' output subtitle.
page.BeginText()
page.SetFontAndSize(defaultFont, 16)
page.TextOut(60, height - 80, "<Standerd Type1 fonts samples>")
page.EndText()

page.BeginText()
page.MoveTextPos(60, height - 105)

For Local i:Int = 0 Until fontList.Length
	Const sampText:String = "abcdefgABCDEFG12345!#$%&+-@?"
	Local font:TPDFFont = pdf.GetFont(fontList[i], Null)

	'print a label of text
	page.SetFontAndSize(defaultFont, 9)
	page.ShowText(fontList[i])
	page.MoveTextPos(0, -18)

	'print a sample text.
	page.SetFontAndSize(font, 20)
	page.ShowText(sampText)
	page.MoveTextPos(0, -20)
Next

page.EndText()

' save the document to a file
pdf.Save("font_example.pdf")

' free up
pdf.Free()
