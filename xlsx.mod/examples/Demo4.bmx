SuperStrict

Framework BRL.StandardIO
Import Text.Xlsx

Print "********************************************************************************"
Print "DEMO PROGRAM #04: Unicode"
Print "********************************************************************************"

' First, create a new document and access the sheet named 'Sheet1'.
' Then rename the worksheet to 'Простыня'.
Local doc1:TXLDocument = New TXLDocument()
doc1.Create("Demo04.xlsx", True)
Local wks1:TXLWorkSheet = doc1.Workbook().Worksheet("Sheet1")
wks1.SetName("Простыня")

' Cell values can be set to any Unicode string using the normal value assignment methods.
wks1.Cell(New TXLCellReference("A1")).SetValue("안녕하세요 세계!")
wks1.Cell(New TXLCellReference("A2")).SetValue("你好，世界!")
wks1.Cell(New TXLCellReference("A3")).SetValue("こんにちは 世界")
wks1.Cell(New TXLCellReference("A4")).SetValue("नमस्ते दुनिया!")
wks1.Cell(New TXLCellReference("A5")).SetValue("Привет, мир!")
wks1.Cell(New TXLCellReference("A6")).SetValue("Γειά σου Κόσμε!")

' Workbooks can also be saved and loaded with Unicode names
doc1.Save()

doc1.SaveAs("./スプレッドシート.xlsx", True)
doc1.Close()

doc1.Open("./スプレッドシート.xlsx")
wks1 = doc1.Workbook().Worksheet("Простыня")

Print "Cell A1 (Korean)  : " + wks1.Cell(New TXLCellReference("A1")).GetValueString()
Print "Cell A2 (Chinese) : " + wks1.Cell(New TXLCellReference("A2")).GetValueString()
Print "Cell A3 (Japanese): " + wks1.Cell(New TXLCellReference("A3")).GetValueString()
Print "Cell A4 (Hindi)   : " + wks1.Cell(New TXLCellReference("A4")).GetValueString()
Print "Cell A5 (Russian) : " + wks1.Cell(New TXLCellReference("A5")).GetValueString()
Print "Cell A6 (Greek)   : " + wks1.Cell(New TXLCellReference("A6")).GetValueString()

doc1.Close()
