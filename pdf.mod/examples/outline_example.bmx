SuperStrict

Framework Text.PDF

Local pageTitle:String = "Outline Example"

Local page:TPDFPage[] = New TPDFPage[3]
Local outline:TPDFOutline[] = New TPDFOutline[3]

Local pdf:TPDFDoc = New TPDFDoc

' create default-font
Local font:TPDFFont = pdf.GetFont("Helvetica", Null)

' Set page mode to use outlines.
pdf.SetPageMode(EPDFPageMode.USE_OUTLINE)

' Add 3 pages to the document.
page[0] = pdf.AddPage()
page[0].SetFontAndSize(font, 30)
PrintPage(page[0], 1)

page[1] = pdf.AddPage()
page[1].SetFontAndSize(font, 30)
PrintPage(page[1], 2)

page[2] = pdf.AddPage()
page[2].SetFontAndSize(font, 30)
PrintPage(page[2], 3)

' create outline root.
Local root:TPDFOutline = pdf.CreateOutline(Null, "OutlineRoot2", Null)
root.SetOpened(True)

outline[0] = pdf.CreateOutline(root, "page1.2", Null)
outline[1] = pdf.CreateOutline(root, "page2.2", Null)

' create outline with test which is ISO8859-2 encoding
Local buf:Byte Ptr = "ISO8859-2 text �������".ToCString()
outline[2] = pdf.CreateOutline(root, buf, pdf.GetEncoder("ISO8859-2"))
MemFree(buf)

' create destination objects on each pages
' and link it to outline items.
Local dst:TPDFDestination = page[0].CreateDestination()
dst.SetXYZ(0, page[0].GetHeight(), 1)
outline[0].SetDestination(dst)
' pdf.Catalog_SetOpenAction(dst)

dst = page[1].CreateDestination()
dst.SetXYZ(0, page[1].GetHeight(), 1)
outline[1].SetDestination(dst)

dst = page[2].CreateDestination()
dst.SetXYZ(0, page[2].GetHeight(), 1)
outline[2].SetDestination(dst)

' save the document to a file
pdf.Save("outline_example.pdf")

' free up
pdf.Free()


Function PrintPage(page:TPDFPage,  pageNum:Int)
	page.SetWidth(800)
	page.SetHeight(800)

	page.BeginText()
	page.MoveTextPos(30, 740)

	page.ShowText(pageNum)
	page.EndText()
End Function
