SuperStrict
Framework BRL.StandardIO
Import Text.MPack
Local data:Byte[] = New Byte[16]
Local writer:TMPackWriter = New TMPackWriter(data)
writer.WriteInt(1)
Print writer.BytesWritten()
writer.Free()
