Framework Text.PDF

Local pdf:TPDFDoc = New TPDFDoc()

Local font:TPDFFont = pdf.GetFont(pdf.LoadTTFontFromFile("FallingSky.ttf"))

Local page:TPDFPage = pdf.AddPage()
page.SetWidth(200)
page.SetHeight(200)
page.SetFontAndSize(font, 24)

Local text:String = "Testing"

Local tw:Float = page.TextWidth(text)

page.BeginText()
page.TextOut((page.GetWidth() - tw) / 2, (page.GetHeight() - 26) / 2 , text)
page.EndText()

pdf.Save("load_font.pdf")

pdf.Free()