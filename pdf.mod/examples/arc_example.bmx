SuperStrict

Framework Text.PDF

Import "grid_sheet.bmx"

Local pdf:TPDFDoc = New TPDFDoc

' add a new page object
Local page:TPDFPage = pdf.AddPage()

page.SetHeight(220)
page.SetWidth(200)

'draw grid to the page
PrintGrid(pdf, page)


' draw pie chart
'
'   A: 45% Red
'   B: 25% Blue
'   C: 15% green
'   D: other yellow
'

' A
page.SetRGBFill(1.0, 0, 0)
page.MoveTo(100, 100)
page.LineTo(100, 180)
page.Arc(100, 100, 80, 0, 360 * 0.45)
Local pos:SPDFPoint = page.GetCurrentPos()
page.LineTo(100, 100)
page.Fill()

' B
page.SetRGBFill(0, 0, 1.0)
page.MoveTo(100, 100)
page.LineTo(pos.x, pos.y)
page.Arc(100, 100, 80, 360 * 0.45, 360 * 0.7)
pos = page.GetCurrentPos()
page.LineTo(100, 100)
page.Fill()

' C
page.SetRGBFill(0, 1.0, 0)
page.MoveTo(100, 100)
page.LineTo(pos.x, pos.y)
page.Arc(100, 100, 80, 360 * 0.7, 360 * 0.85)
pos = page.GetCurrentPos()
page.LineTo(100, 100)
page.Fill()

' D
page.SetRGBFill(1.0, 1.0, 0)
page.MoveTo(100, 100)
page.LineTo(pos.x, pos.y)
page.Arc(100, 100, 80, 360 * 0.85, 360)
pos = page.GetCurrentPos()
page.LineTo(100, 100)
page.Fill()

' draw center circle
page.SetGrayStroke(0)
page.SetGrayFill(1)
page.Circle(100, 100, 30)
page.Fill()


' save the document to a file
pdf.Save("arc_example.pdf")

' free up
pdf.Free()
