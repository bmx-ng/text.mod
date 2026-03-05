SuperStrict

Framework BRL.StandardIO
Import Text.Xlsx

Print "********************************************************************************"
Print "DEMO PROGRAM #02: Formulas"
Print "********************************************************************************"

Local doc:TXLDocument = New TXLDocument()
doc.Create("Demo02.xlsx", True)

Local wks:TXLWorkSheet = doc.Workbook().Worksheet("Sheet1")

' Similar cell values, formulas can be accessed through the TXLCell interface using the .Formula()
' member function. It should be noted, however, that the functionality of formulas is somewhat
' limited. Excel often uses 'shared' formulas, where the same formula is applied to several
' cells. But here it cannot handle shared formulas. Also, it cannot handle array formulas. This,
' in effect, means that formulas are not very useful for reading formulas from existing spread-
' sheets, but should rather be used to add or overwrite formulas to spreadsheets.

wks.Cell("A1").SetValue("Number:")
wks.Cell("B1").SetValue(1)
wks.Cell("C1").SetValue(2)
wks.Cell("D1").SetValue(3)


' Formulas can be added to a cell using the .SetFormula() method on an TXLCell object. The formula can
' be added by assigning a string holding the formula;
' Nota that OpenXLSX does not calculate the results of a formula. If you add a formula
' to a spreadsheet using OpenXLSX, you have to open the spreadsheet in the Excel application
' in order to see the results of the calculation.
wks.Cell("A2").SetValue("Calculation:")
wks.Cell("B2").SetFormula("SQRT(B1)")
wks.Cell("C2").SetFormula("EXP(C1)")
wks.Cell("D2").SetFormula("LN(D1)")

Print "Cell B2: " + wks.Cell("B2").Formula()
Print "Cell C2: " + wks.Cell("C2").Formula()
Print "Cell D2: " + wks.Cell("D2").Formula()

wks.Cell("D2").ClearFormula()

doc.Save()
doc.Close()
