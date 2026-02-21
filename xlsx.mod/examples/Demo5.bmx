SuperStrict

Framework BRL.StandardIO
Import Text.Xlsx
Import BRL.Random

Print "********************************************************************************"
Print "DEMO PROGRAM #05: Ranges and Iterators"
Print "********************************************************************************"

Print "~nGenerating spreadsheet ..."

Local doc:TXLDocument = New TXLDocument()
doc.Create("Demo05.xlsx", True)

Local wks:TXLWorksheet = doc.Workbook().Worksheet("Sheet1")

' Create a cell range using the 'Range()' method of the TXLWorksheet class.
' The 'Range()' method takes two TXLCellReference objects; one for the cell
' in the upper left corner, and one for the cell in the lower right corner.
' OpenXLSX defines two constants: XLSX_MAX_ROWS which is the maximum number of
' rows in a worksheet, and XLSX_MAX_COLS which is the maximum number of columns.
Local rng:TXLCellRange = wks.Range(New TXLCellReference("A1"), New TXLCellReference(XLSX_MAX_ROWS, 8))

For Local cell:TXLCell = EachIn rng
	cell.SetValue(RandomInt(0, 99))
Next

' Saving a large spreadsheet can take a while...
Print "Saving spreadsheet ..."
doc.Save()
doc.Close()

' Reopen the spreadsheet..
Print "Re-opening spreadsheet ..."
doc.Open("Demo05.xlsx")

wks = doc.Workbook().Worksheet("Sheet1")

' Create the range, count the cells in the range, and sum the numbers assigned
' to the cells in the range.
Print "Reading data from spreadsheet ..."
rng = wks.Range(New TXLCellReference("A1"), New TXLCellReference(XLSX_MAX_ROWS, 8))

Print "Cell count: " + rng.Distance()
Local total:Long
For Local cell:TXLCell = EachIn rng
	total :+ cell.GetValueLong()
Next
Print "Sum of cell values: " + total

doc.Close()
