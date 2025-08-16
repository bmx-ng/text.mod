SuperStrict

Framework brl.standardio
Import Text.CP932Encoding
Import BRL.MaxUnit

New TTestSuite.run()

Type TCP932StrategyTest Extends TTest


	Method CompareStreams(encoding:EStreamEncoding)

		Local encodedStream:TStream = ReadStream("test_data/" + encoding.ToString().ToLower() +"_encoded.txt")
		Local utf8Sstream:TStream = ReadStream("test_data/" + encoding.ToString().ToLower() + "_utf8.txt")
	
		If Not encodedStream Or Not utf8Sstream Then
			Fail("Error: Unable to open the input or expected files.")
		End If
	
		Local encodingStream:TEncodingToUTF8Stream = New TEncodingToUTF8Stream(encodedStream, encoding)
		Local buf:Byte[128]
	
		Local totalBytesRead:Long
		Local expectedByte:Byte
		Local success:Int = True
	
		Local bytesRead:Long = encodingStream.Read(buf, 128)

		While bytesRead > 0
			For Local i:Int = 0 Until bytesRead
				utf8Sstream.ReadBytes(varptr expectedByte, 1)
				If buf[i] <> expectedByte Then
					Print "Mismatch at position " + (totalBytesRead + i) + ": Expected " + expectedByte + " but got " + buf[i]
					success = False
				End If
			Next
	
			totalBytesRead :+ bytesRead

			bytesRead = encodingStream.Read(buf, 128)
		Wend

		encodingStream.Close()
		utf8Sstream.Close()

		AssertTrue(success)
	End Method

	Method testWindows_932() { test }
		CompareStreams(EStreamEncoding.CP932)
	End Method

End Type
