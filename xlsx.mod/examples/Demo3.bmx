SuperStrict

Framework BRL.StandardIO
Import Text.Xlsx

Print "********************************************************************************"
Print "DEMO PROGRAM #03: Sheet Handling"
Print "********************************************************************************"

' OpenXLSX can be used to create and delete sheets in a workbook, as well as re-ordering of sheets.
' This example illustrates how this can be done. Please note that at the moment, chartsheets can only
' be renamed and deleted, not created or manipulated.

' First, create a new document and store the workbook object in a variable. Print the sheet names.
Local doc:TXLDocument = New TXLDocument()
doc.Create("Demo03.xlsx", True)

Local wbk:TXLWorkbook = doc.Workbook()
PrintWorkbook(wbk)

' Add two new worksheets. The 'addWorksheet' method takes the name of the new sheet as an argument,
' and appends the new workdheet at the end.
' Only worksheets can be added; there is no 'AddChartsheet' method.
wbk.AddWorksheet("Sheet2")
wbk.AddWorksheet("Sheet3")
PrintWorkbook(wbk)

Print "Sheet1 active: " + GetActive(wbk.Worksheet("Sheet1"))
Print "Sheet2 active: " + GetActive(wbk.Worksheet("Sheet2"))
Print "Sheet3 active: " + GetActive(wbk.Worksheet("Sheet3"))

wbk.Worksheet("Sheet3").SetActive()

Print "Sheet1 active: " + GetActive(wbk.Worksheet("Sheet1"))
Print "Sheet2 active: " + GetActive(wbk.Worksheet("Sheet2"))
Print "Sheet3 active: " + GetActive(wbk.Worksheet("Sheet3"))

' Existing sheets can be cloned by calling the 'clone' method on the individual sheet,
' or by calling the 'CloneSheet' method from the TXLWorkbook object. If the latter is
' chosen, both the name of the sheet to be cloned, as well as the name of the new
' sheet must be provided.
wbk.Worksheet("Sheet1").Clone("Sheet4")
wbk.CloneSheet("Sheet2", "Sheet5")
PrintWorkbook(wbk)

' The sheets in the workbook can be reordered by calling the 'SetIndex' method on the
' individual sheets (or worksheets/chartsheets).
wbk.DeleteSheet("Sheet1")
wbk.Worksheet("Sheet5").SetIndex(1)
wbk.Worksheet("Sheet4").SetIndex(2)
wbk.Worksheet("Sheet3").SetIndex(3)
wbk.Worksheet("Sheet2").SetIndex(4)
PrintWorkbook(wbk)

' The color of each sheet tab can be set using the 'setColor' method for a
' sheet, and passing an XLColor object as an argument.
wbk.Worksheet("Sheet2").setColor(New SColor8(0, 0, 0))
wbk.Worksheet("Sheet3").setColor(New SColor8(255, 0, 0))
wbk.Worksheet("Sheet4").setColor(New SColor8(0, 255, 0))
wbk.Worksheet("Sheet5").setColor(New SColor8(0, 0, 255))

doc.Save()
doc.Close()

Function PrintWorkbook(wb:TXLWorkbook)
    Print "~nSheets in workbook:"
	For Local name:String = EachIn wb.WorksheetNames()
		Print wb.IndexOfSheet(name) + " : " + name
	Next
End Function

Function GetActive:String(worksheet:TXLWorksheet)
	If worksheet.IsActive() Then
		Return "true"
	Else
		Return "false"
	End If
End Function
