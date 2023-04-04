SuperStrict

Framework brl.standardio
Import Text.Encoding
Import BRL.MaxUnit

New TTestSuite.run()

Type TISOStrategyTest Extends TTest


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

	Method testISO_8859_1() { test }
		CompareStreams(EStreamEncoding.ISO_8859_1)
	End Method

	Method testISO_8859_2() { test }
		CompareStreams(EStreamEncoding.ISO_8859_2)
	End Method

	Method testISO_8859_5() { test }
		CompareStreams(EStreamEncoding.ISO_8859_5)
	End Method

	Method testISO_8859_6() { test }
		CompareStreams(EStreamEncoding.ISO_8859_6)
	End Method

	Method testISO_8859_7() { test }
		CompareStreams(EStreamEncoding.ISO_8859_7)
	End Method

	Method testISO_8859_8() { test }
		CompareStreams(EStreamEncoding.ISO_8859_8)
	End Method

	Method testISO_8859_9() { test }
		CompareStreams(EStreamEncoding.ISO_8859_9)
	End Method

	Method testISO_8859_15() { test }
		CompareStreams(EStreamEncoding.ISO_8859_15)
	End Method

	Method testWindows_1250() { test }
		CompareStreams(EStreamEncoding.CP1250)
	End Method

	Method testWindows_1251() { test }
		CompareStreams(EStreamEncoding.CP1251)
	End Method

	Method testWindows_1252() { test }
		CompareStreams(EStreamEncoding.CP1252)
	End Method

	Method testWindows_1253() { test }
		CompareStreams(EStreamEncoding.CP1253)
	End Method

	Method testWindows_1254() { test }
		CompareStreams(EStreamEncoding.CP1254)
	End Method

	Method testWindows_1255() { test }
		CompareStreams(EStreamEncoding.CP1255)
	End Method

	Method testWindows_1256() { test }
		CompareStreams(EStreamEncoding.CP1256)
	End Method

	Method testWindows_1257() { test }
		CompareStreams(EStreamEncoding.CP1257)
	End Method

End Type
