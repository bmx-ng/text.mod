SuperStrict

Function PrintGrid(pdf:TPDFDoc, page:TPDFPage)
	Local height:Float = page.GetHeight()
    Local width:Float = page.GetWidth()
    Local font:TPDFFont = pdf.GetFont("Helvetica", Null)

	page.SetFontAndSize(font, 5)
	page.SetGrayFill(0.5)
	page.SetGrayStroke(0.8)
	
	' Draw horizontal lines
	Local y:UInt = 0
	While y < height
		If y Mod 10 = 0 Then
			page.SetLineWidth(0.5)
		Else
			If page.GetLineWidth() <> 0.25 Then
				page.SetLineWidth(0.25)
			End If
		End If
		
		page.MoveTo(0, y)
		page.LineTo(width, y)
		page.Stroke()
		
		If y Mod 10 = 0 And y > 0 Then
			page.SetGrayStroke(0.5)
			
			page.MoveTo(0, y)
			page.LineTo(5, y)
			page.Stroke()
			
			page.SetGrayStroke(0.8)
		End If

		y :+ 5
	Wend
	
	
	' Draw vertical lines
	Local x:UInt = 0
	While x < width
		If x Mod 10 = 0 Then
			page.SetLineWidth(0.5)
		Else
			If page.GetLineWidth() <> 0.25 Then
				page.SetLineWidth(0.25)
			End If
		End If
		
		page.MoveTo(x, 0)
		page.LineTo(x, height)
		page.Stroke()
		
		If x Mod 50 = 0 And x > 0 Then
			page.SetGrayStroke(0.5)
			
			page.MoveTo(x, 0)
			page.LineTo(x, 5)
			page.Stroke()
			
			page.MoveTo(x, height)
			page.LineTo(x, height - 5)
			page.Stroke()
			
			page.SetGrayStroke(0.8)
		End If
		
		x :+ 5
	Wend
	
	' Draw horizontal text
	y = 0
	while y < height
		If y Mod 10 = 0 And y > 0 Then
			page.BeginText()
			page.MoveTextPos(5, y - 2)
			page.ShowText(y)
			page.EndText()
		End If
		
		y :+ 5
	Wend
	
	
	' Draw vertical text
	x = 0
	While x < width
		If x Mod 50 = 0 And x > 0 Then
			page.BeginText()
			page.MoveTextPos(x, 5)
			page.ShowText(x)
			page.EndText()
			
			page.BeginText()
			page.MoveTextPos(x, height - 10)
			page.ShowText(x)
			page.EndText()
		End If
	
		x :+ 5
	Wend
	
	page.SetGrayFill(0)
	page.SetGrayStroke(0)

End Function
