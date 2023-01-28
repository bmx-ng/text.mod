SuperStrict

Framework Text.PDF

Const PAGE_WIDTH:Float = 600
Const PAGE_HEIGHT:Float = 900


Local pdf:TPDFDoc = New TPDFDoc

Local hfont:TPDFFont = pdf.GetFont("Helvetica-Bold", Null)

' Add a new page object.
Local page:TPDFPage = pdf.AddPage()

page.SetFontAndSize(hfont, 10)

page.SetHeight(PAGE_HEIGHT)
page.SetWidth(PAGE_WIDTH)

' normal
page.GSave()
DrawCircles(page, "normal", 40.0, PAGE_HEIGHT - 170)
page.GRestore()

' transparency(0.8)
page.GSave()
Local gstate:TPDFExtGState = pdf.CreateExtGState()
gstate.SetAlphaFill(0.8)
gstate.SetAlphaStroke(0.8)
page.SetExtGState(gstate)
DrawCircles(page, "alpha fill = 0.8", 230.0, PAGE_HEIGHT - 170)
page.GRestore()

' transparency(0.4)
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetAlphaFill(0.4)
page.SetExtGState(gstate)
DrawCircles(page, "alpha fill = 0.4", 420.0, PAGE_HEIGHT - 170)
page.GRestore()

' blend-mode=MULTIPLY
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetBlendMode(EPDFBlendMode.MULTIPLY)
page.SetExtGState(gstate)
DrawCircles(page, "MULTIPLY", 40.0, PAGE_HEIGHT - 340)
page.GRestore()

' blend-mode=SCREEN
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetBlendMode(EPDFBlendMode.SCREEN)
page.SetExtGState(gstate)
DrawCircles(page, "SCREEN", 230.0, PAGE_HEIGHT - 340)
page.GRestore()

' blend-mode=OVERLAY
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetBlendMode(EPDFBlendMode.OVERLAY)
page.SetExtGState(gstate)
DrawCircles(page, "OVERLAY", 420.0, PAGE_HEIGHT - 340)
page.GRestore()

' blend-mode=DARKEN
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetBlendMode(EPDFBlendMode.DARKEN)
page.SetExtGState(gstate)
DrawCircles(page, "DARKEN", 40.0, PAGE_HEIGHT - 510)
page.GRestore()

' blend-mode=LIGHTEN
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetBlendMode(EPDFBlendMode.LIGHTEN)
page.SetExtGState(gstate)
DrawCircles(page, "LIGHTEN", 230.0, PAGE_HEIGHT - 510)
page.GRestore()

' blend-mode=COLOR_DODGE
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetBlendMode(EPDFBlendMode.COLOR_DODGE)
page.SetExtGState(gstate)
DrawCircles(page, "COLOR_DODGE", 420.0, PAGE_HEIGHT - 510)
page.GRestore()


' blend-mode=COLOR_BUM
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetBlendMode(EPDFBlendMode.COLOR_BUM)
page.SetExtGState(gstate)
DrawCircles(page, "COLOR_BUM", 40.0, PAGE_HEIGHT - 680)
page.GRestore()

' blend-mode=HARD_LIGHT
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetBlendMode(EPDFBlendMode.HARD_LIGHT)
page.SetExtGState(gstate)
DrawCircles(page, "HARD_LIGHT", 230.0, PAGE_HEIGHT - 680)
page.GRestore()

' blend-mode=SOFT_LIGHT
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetBlendMode(EPDFBlendMode.SOFT_LIGHT)
page.SetExtGState(gstate)
DrawCircles(page, "SOFT_LIGHT", 420.0, PAGE_HEIGHT - 680)
page.GRestore()

' blend-mode=DIFFERENCE
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetBlendMode(EPDFBlendMode.DIFFERENCE)
page.SetExtGState(gstate)
DrawCircles(page, "DIFFERENCE", 40.0, PAGE_HEIGHT - 850)
page.GRestore()


' blend-mode=EXCLUSION
page.GSave()
gstate = pdf.CreateExtGState()
gstate.SetBlendMode(EPDFBlendMode.EXCLUSION)
page.SetExtGState(gstate)
DrawCircles(page, "EXCLUSION", 230.0, PAGE_HEIGHT - 850)
page.GRestore()


' save the document to a file
pdf.Save("ext_gstate_example.pdf")

' free up
pdf.Free()


Function DrawCircles(page:TPDFPage, description:String, x:Float, y:Float)
	page.SetLineWidth(1.0)
	page.SetRGBStroke(0, 0, 0)
	page.SetRGBFill(1.0, 0, 0)
	page.Circle(x + 40, y + 40, 40)
	page.ClosePathFillStroke()
	page.SetRGBFill(0, 1.0, 0)
	page.Circle(x + 100, y + 40, 40)
	page.ClosePathFillStroke()
	page.SetRGBFill(0, 0, 1.0)
	page.Circle(x + 70, y + 74.64, 40)
	page.ClosePathFillStroke()
	
	page.SetRGBFill(0, 0, 0)
	page.BeginText()
	page.TextOut(x + 0, y + 130, description)
	page.EndText()	
End Function
