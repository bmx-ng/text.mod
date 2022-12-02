SuperStrict

Framework Text.Csv
Import BRL.Standardio

Local stream:TStream = ReadStream("../zsv/data/Excel.tsv")

Local options:TCsvOptions = New TCsvOptions
options.delimiter = "~t"
'options.insertHeaderRow = "col1~tcol2~n"

Local csv:TCsvParser = TCsvParser.Parse(stream, options)

While csv.NextRow() = ECsvStatus.row
	Local row:TCsvRow = csv.GetRow()
	
	Print "cols : " + row.ColumnCount()
Wend

csv.Free()
stream.Close()
