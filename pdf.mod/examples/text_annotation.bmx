SuperStrict

Framework Text.PDF


Local rect1:SPDFRect = New SPDFRect(50, 350, 150, 400)
Local rect2:SPDFRect = New SPDFRect(210, 350, 350, 400)
Local rect3:SPDFRect = New SPDFRect(50, 250, 150, 300)
Local rect4:SPDFRect = New SPDFRect(210, 250, 350, 300)
Local rect5:SPDFRect = New SPDFRect(50, 150, 150, 200)
Local rect6:SPDFRect = New SPDFRect(210, 150, 350, 200)
Local rect7:SPDFRect = New SPDFRect(50, 50, 150, 100)
Local rect8:SPDFRect = New SPDFRect(210, 50, 350, 100)


Local pdf:TPDFDoc = New TPDFDoc

' use Times-Roman font.
Local font:TPDFFont = pdf.GetFont("Times-Roman", "WinAnsiEncoding")

Local page:TPDFPage = pdf.AddPage()

page.SetWidth(400)
page.SetHeight(500)

page.BeginText()
page.SetFontAndSize(font, 16)
page.MoveTextPos(130, 450)
page.ShowText("Annotation Demo")
page.EndText()

Local annot:TPDFAnnotation = page.CreateTextAnnot(rect1, "Annotation with Comment Icon. ~n This annotation set to be opened initially.", Null)

annot.SetIcon(EPDFAnnotIcon.COMMENT)
annot.SetOpened(True)

annot = page.CreateTextAnnot(rect2, "Annotation with Key Icon", Null)
annot.SetIcon(EPDFAnnotIcon.PARAGRAPH)

annot = page.CreateTextAnnot(rect3, "Annotation with Note Icon", Null)
annot.SetIcon(EPDFAnnotIcon.NOTE)

annot = page.CreateTextAnnot(rect4, "Annotation with Help Icon", Null)
annot.SetIcon(EPDFAnnotIcon.HELP)

annot = page.CreateTextAnnot(rect5, "Annotation with NewParagraph Icon", Null)
annot.SetIcon(EPDFAnnotIcon.NEW_PARAGRAPH)

annot = page.CreateTextAnnot(rect6, "Annotation with Paragraph Icon", Null)
annot.SetIcon(EPDFAnnotIcon.PARAGRAPH)

annot = page.CreateTextAnnot(rect7, "Annotation with Insert Icon", Null)
annot.SetIcon(EPDFAnnotIcon.INSERT)

Local encoding:TPDFEncoder = pdf.GetEncoder("ISO8859-2")

page.CreateTextAnnot(rect8, "Annotation with ISO8859 text �������", encoding)

page.SetFontAndSize(font, 11)

page.BeginText()
page.MoveTextPos(rect1.left + 35, rect1.top - 20)
page.ShowText("Comment Icon.")
page.EndText()

page.BeginText()
page.MoveTextPos(rect2.left + 35, rect2.top - 20)
page.ShowText("Key Icon")
page.EndText()

page.BeginText()
page.MoveTextPos(rect3.left + 35, rect3.top - 20)
page.ShowText("Note Icon.")
page.EndText()

page.BeginText()
page.MoveTextPos(rect4.left + 35, rect4.top - 20)
page.ShowText("Help Icon")
page.EndText()

page.BeginText()
page.MoveTextPos(rect5.left + 35, rect5.top - 20)
page.ShowText("NewParagraph Icon")
page.EndText()

page.BeginText()
page.MoveTextPos(rect6.left + 35, rect6.top - 20)
page.ShowText("Paragraph Icon")
page.EndText()

page.BeginText()
page.MoveTextPos(rect7.left + 35, rect7.top - 20)
page.ShowText("Insert Icon")
page.EndText()

page.BeginText()
page.MoveTextPos(rect8.left + 35, rect8.top - 20)
page.ShowText("Text Icon(ISO8859-2 text)")
page.EndText()

' save the document to a file
pdf.Save("text_annotation.pdf")

' free up
pdf.Free()

