SuperStrict

Framework BRL.StandardIO
Import Text.Xlsx

Print "********************************************************************************"
Print "DEMO PROGRAM #01A: Basic Usage"
Print "********************************************************************************"

Local doc:TXLDocument = New TXLDocument()
doc.Create("Demo01A.xlsx", True)

Local wks:TXLWorkSheet = doc.Workbook().Worksheet("Sheet1")

Local a1:TXLCell = wks.Cell("A1")
Local b1:TXLCell = wks.Cell("B1")
Local c1:TXLCell = wks.Cell("C1")
Local d1:TXLCell = wks.Cell("D1")

a1.SetValue(3.14159)
b1.SetValue(42)
c1.SetValue("  Hello OpenXLSX!  ")
d1.SetValueBool(True)

a1 = wks.Cell("A1")

Print "Cell A1: (" + a1.typeAsString() + ") " + a1.GetValueDouble()
Print "Cell B1: (" + b1.typeAsString() + ") " + b1.GetValueLong()
Print "Cell C1: (" + c1.typeAsString() + ") '" + c1.GetValueString() + "'"
Print "Cell D1: (" + d1.typeAsString() + ") " + d1.GetValueBool()

Print ""

wks.Cell("E1").SetValue(wks.Cell("C1"))
Print "Cell E1: (" + wks.Cell("E1").typeAsString() + ") '" + wks.Cell("E1").GetValueString() + "'"

doc.Save()
doc.Close()
