Framework Text.PDF

Local pdf:TPDFDoc = New TPDFDoc()
pdf.UseUTFEncodings()

Local font:TPDFFont = pdf.GetFont(pdf.LoadTTFontFromFile("FallingSky.ttf", true), "UTF-8")

Local page:TPDFPage = pdf.AddPage()
page.SetWidth(200)
page.SetHeight(200)
page.SetFontAndSize(font, 24)

Local text:String = "Testing åäö ÅÄÖ"

Local tw:Float = page.TextWidth(text)

page.BeginText()
page.TextOut((page.GetWidth() - tw) / 2, (page.GetHeight() - 26) / 2 , text)
page.EndText()

pdf.Save("utf.pdf")

pdf.Free()