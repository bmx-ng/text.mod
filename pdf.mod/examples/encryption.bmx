SuperStrict

Framework Text.PDF

Const txt:String = "This is an encrypt document example."
Const ownerPasswd:String = "owner"
Const userPasswd:String = "user"

Local pdf:TPDFDoc = New TPDFDoc

' create default-font
Local font:TPDFFont = pdf.GetFont("Helvetica", Null)

' add a new page object
Local page:TPDFPage = pdf.AddPage()

page.SetSize(EPDFPageSize.B5, EPDFPageDirection.LANDSCAPE)

page.BeginText()
page.SetFontAndSize(font, 20)
Local tw:Float = page.TextWidth(txt)
page.MoveTextPos((page.GetWidth() - tw) / 2, (page.GetHeight()  - 20) / 2)
page.ShowText(txt)
page.EndText()

pdf.SetPassword(ownerPasswd, userPasswd)

' save the document to a file
pdf.Save("encryption.pdf")

' free up
pdf.Free()
