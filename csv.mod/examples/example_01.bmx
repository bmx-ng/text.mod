SuperStrict

Framework Text.Csv
Import BRL.Standardio

Local stream:TStream = ReadStream("data.csv")

Local csv:TCsvParser = TCsvParser.Parse(stream)

Local count:Int
Local total:Int
While csv.NextRow() = ECsvStatus.row
	Local row:TCsvRow = csv.GetRow()
	Local col:SCsvColumn = row.GetColumn("Country")
	If col.GetValue() = "gb" Then
		count :+ 1

		col = row.GetColumn(4)
		total :+ Int(col.GetValue())
	End If
Wend
csv.Free()
stream.Close()

Print "gb rows    = " + count
Print "population = " + total
