SuperStrict

Framework BRL.StandardIO
Import Text.Xlsx
Import BRL.Random

Print "********************************************************************************"
Print "DEMO PROGRAM #07: Row Handling (using iterators)"
Print "********************************************************************************"

' As an alternative to using cell ranges, you can use row ranges.
' This can be significantly faster (up to twice as fast for both reading and
' writing).

Print "~nGenerating spreadsheet ..."

Local doc:TXLDocument = New TXLDocument()
doc.Create("Demo07.xlsx", True)

Local wks:TXLWorksheet = doc.Workbook().Worksheet("Sheet1")

' The TXLWorksheet class has a 'Rows()' method, that returns a TXLRowRange
' object. Similar to TXLCellRange, TXLRowRange provides and iterator,
' enabeling iteration through the individual TXLRow objects.
' for (auto& row : wks.rows(OpenXLSX::MAX_ROWS)) {

For Local row:TXLRow = EachIn wks.Rows(XLSX_MAX_ROWS)
	For Local cell:TXLCell = EachIn row.Cells(8)
		cell.SetValue(RandomInt(0, 99))
	Next

	' The TXLRow class provides a 'Cells()' method. This provides an
	' iterator to the cells, or range of cells, in the row. Iterating through
	' the cells works in the usual manner and values can be read and written.
Next

' Saving a large spreadsheet can take a while...
Print "Saving spreadsheet ..."
doc.Save()
doc.Close()

' Reopen the spreadsheet..
Print "Re-opening spreadsheet ..."
doc.Open("Demo07.xlsx")

wks = doc.Workbook().Worksheet("Sheet1")

' Prepare for reading...
Print "Reading data from spreadsheet ..."
Local sum:ULong
Local count:ULong

For Local row:TXLRow = EachIn wks.Rows()
	' Count the number of cell values
	For Local cell:TXLCell = EachIn row.Cells()
		If cell.ValueType() <> EXLValueType.ValueType_Empty Then
			count :+ 1
		End If
	Next

	' Sum the cell values
	For Local cell:TXLCell = EachIn row.Cells()
		sum :+ cell.GetValueULong()
	Next
Next

Print "Cell count: " + count
Print "Sum of cell values: " + sum

doc.Close()
