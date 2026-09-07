SuperStrict

Framework BRL.Standardio
Import Text.MPack

' save

Local stream:TStream = WriteStream("example01.mp")

Local writer:TMPackWriter = New TMPackWriter(stream)

writer.BuildMap()
writer.Write("compact")
writer.WriteBool(True)
writer.Write("schema")
writer.Write(100:UInt)
writer.CompleteMap()

If writer.Free() <> EMPackError.ok
	Print "Error freeing writer"
End If

stream.Close()
