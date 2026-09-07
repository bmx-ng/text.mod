SuperStrict

Framework BRL.StandardIO
Import BRL.ByteArrayStream
Import BRL.MaxUnit
Import Text.MPack

New TTestSuite.Run()

Type TMPackTest Extends TTest

	Method TestMemoryRoundTrip() { test }
		Local data:Byte[] = New Byte[4096]
		Local writer:TMPackWriter = New TMPackWriter(data)
		writer.StartArray(10)
		writer.WriteNil()
		writer.WriteBool(True)
		writer.WriteInt(-42)
		writer.WriteUInt(42)
		writer.WriteLong(-5000000000:Long)
		writer.WriteULong(5000000000:ULong)
		writer.WriteFloat(1.25)
		writer.WriteDouble(3.5)
		writer.Write("hello")
		writer.WriteBin([1:Byte, 2:Byte, 3:Byte])
		writer.FinishArray()
		Local used:Int = Int(writer.BytesWritten())
		AssertEquals(EMPackError.ok, writer.Free())

		Local reader:TMPackReader = New TMPackReader(data, 0, used)
		AssertEquals(10, Int(reader.BeginArray()))
		reader.ReadNil()
		AssertTrue(reader.ReadBool())
		AssertEquals(-42, reader.ReadInt())
		AssertEquals(42:UInt, reader.ReadUInt())
		AssertEquals(-5000000000:Long, reader.ReadLong())
		AssertEquals(5000000000:ULong, reader.ReadULong())
		AssertEquals(1.25:Float, reader.ReadFloat())
		AssertEquals(3.5:Double, reader.ReadDouble())
		AssertEquals("hello", reader.ReadString())
		Local binary:Byte[] = reader.ReadBin()
		AssertEquals(3, binary.Length)
		AssertEquals(2:Byte, binary[1])
		reader.DoneArray()
		AssertEquals(EMPackError.ok, reader.Free())
	End Method

	Method TestGrowableMemoryWriter() { test }
		Local writer:TMPackWriter = TMPackWriter.CreateGrowable()
		writer.StartArray(2000)
		For Local index:Int = 0 Until 2000
			writer.WriteInt(index)
		Next
		writer.FinishArray()
		Local error:EMPackError
		Local data:Byte[] = writer.Finish(error)
		AssertEquals(EMPackError.ok, error)
		AssertTrue(data.Length > 4096)
		Local reader:TMPackReader = New TMPackReader(data)
		AssertEquals(2000, Int(reader.BeginArray()))
		For Local index:Int = 0 Until 2000
			AssertEquals(index, reader.ReadInt())
		Next
		reader.DoneArray()
		AssertEquals(EMPackError.ok, reader.Free())
	End Method

	Method TestEmbeddedNullAndUnicode() { test }
		Local units:Short[] = [65:Short, 0:Short, 66:Short, $d83d:Short, $de00:Short]
		Local expected:String = String.FromShorts(units, units.Length)
		Local data:Byte[] = New Byte[128]
		Local writer:TMPackWriter = New TMPackWriter(data)
		writer.Write(expected)
		Local used:Int = Int(writer.BytesWritten())
		AssertEquals(EMPackError.ok, writer.Free())
		Local reader:TMPackReader = New TMPackReader(data, 0, used)
		Local actual:String = reader.ReadString()
		AssertEquals(expected.Length, actual.Length)
		AssertEquals(expected, actual)
		AssertEquals(EMPackError.ok, reader.Free())
	End Method

	Method TestStringWriterOverloads() { test }
		Local utf8:Byte[] = [112:Byte, 116:Byte, 114:Byte, 0:Byte, 111:Byte, 107:Byte]
		Local data:Byte[] = New Byte[128]
		Local writer:TMPackWriter = New TMPackWriter(data)
		writer.StartArray(3)
		writer.WriteString("explicit")
		writer.Write("generic")
		writer.WriteStringBytes(Byte Ptr(utf8), UInt(utf8.Length))
		writer.FinishArray()
		Local used:Int = Int(writer.BytesWritten())
		AssertEquals(EMPackError.ok, writer.Free())

		Local reader:TMPackReader = New TMPackReader(data, 0, used)
		AssertEquals(3, Int(reader.BeginArray()))
		AssertEquals("explicit", reader.ReadString())
		AssertEquals("generic", reader.ReadString())
		Local pointerValue:String = reader.ReadString()
		AssertEquals(6, pointerValue.Length)
		AssertEquals(0, pointerValue[3])
		AssertEquals("ptr", pointerValue[..3])
		AssertEquals("ok", pointerValue[4..])
		reader.DoneArray()
		AssertEquals(EMPackError.ok, reader.Free())
	End Method

	Method TestExtensionTimestampAndDiscard() { test }
		Local data:Byte[] = New Byte[256]
		Local writer:TMPackWriter = New TMPackWriter(data)
		writer.StartArray(4)
		writer.Write("keep")
		writer.StartMap(1)
		writer.Write("ignored")
		writer.StartArray(2)
		writer.WriteInt(1)
		writer.WriteInt(2)
		writer.FinishArray()
		writer.FinishMap()
		writer.WriteExt(7, [9:Byte, 8:Byte])
		writer.WriteTimestamp(-123456789:Long, 42)
		writer.FinishArray()
		Local used:Int = Int(writer.BytesWritten())
		AssertEquals(EMPackError.ok, writer.Free())

		Local reader:TMPackReader = New TMPackReader(data, 0, used)
		AssertEquals(4, Int(reader.BeginArray()))
		AssertEquals("keep", reader.ReadString())
		reader.Discard()
		Local extType:Int
		Local ext:Byte[] = reader.ReadExt(extType)
		AssertEquals(7, extType)
		AssertEquals(2, ext.Length)
		AssertEquals(8:Byte, ext[1])
		Local timestamp:TMPackTimestamp = reader.ReadTimestamp()
		AssertEquals(-123456789:Long, timestamp.seconds)
		AssertEquals(42:UInt, timestamp.nanoseconds)
		reader.DoneArray()
		AssertEquals(EMPackError.ok, reader.Free())
	End Method

	Method TestRawObjectBytes() { test }
		Local data:Byte[] = New Byte[32]
		Local writer:TMPackWriter = New TMPackWriter(data)
		writer.StartArray(2)
		writer.WriteObjectBytes([$2a:Byte])
		writer.WriteObjectBytes([$a2:Byte, 111:Byte, 107:Byte])
		writer.FinishArray()
		Local used:Int = Int(writer.BytesWritten())
		AssertEquals(EMPackError.ok, writer.Free())
		Local reader:TMPackReader = New TMPackReader(data, 0, used)
		AssertEquals(2, Int(reader.BeginArray()))
		AssertEquals(42, reader.ReadInt())
		AssertEquals("ok", reader.ReadString())
		reader.DoneArray()
		AssertEquals(EMPackError.ok, reader.Free())
	End Method

	Method TestTruncatedAndMalformedUtf8() { test }
		Local truncated:TMPackReader = New TMPackReader([$d9:Byte, 5:Byte, 65:Byte])
		AssertEquals("", truncated.ReadString())
		AssertTrue(truncated.HasError())
		' A bounded memory reader knows the document is structurally invalid;
		' a streaming reader reports EOF when its fill callback is exhausted.
		AssertEquals(EMPackError.error_invalid, truncated.Free())

		Local malformed:TMPackReader = New TMPackReader([$a1:Byte, $80:Byte])
		AssertEquals("", malformed.ReadString())
		AssertEquals(EMPackError.error_type, malformed.Error())
		AssertEquals(EMPackError.error_type, malformed.Free())
	End Method

	Method TestLimits() { test }
		Local stringLimited:TMPackReader = New TMPackReader([$a2:Byte, 111:Byte, 107:Byte], 0, -1, TMPackLimits.Create(1, 64, 64, 8))
		stringLimited.ReadString()
		AssertEquals(EMPackError.error_too_big, stringLimited.Free())

		Local containerLimited:TMPackReader = New TMPackReader([$93:Byte, 1:Byte, 2:Byte, 3:Byte], 0, -1, TMPackLimits.Create(64, 64, 2, 8))
		containerLimited.BeginArray()
		AssertEquals(EMPackError.error_too_big, containerLimited.Free())

		Local depthLimited:TMPackReader = New TMPackReader([$91:Byte, $91:Byte, $91:Byte, 1:Byte], 0, -1, TMPackLimits.Create(64, 64, 64, 2))
		depthLimited.Discard()
		AssertEquals(EMPackError.error_too_big, depthLimited.Free())
	End Method

	Method TestFixedMemoryOverflowAndArrayBounds() { test }
		Local tiny:Byte[] = New Byte[1]
		Local writer:TMPackWriter = New TMPackWriter(tiny)
		writer.Write("too large")
		AssertEquals(EMPackError.error_too_big, writer.Free())

		Local bounded:TMPackWriter = New TMPackWriter(New Byte[32])
		bounded.WriteBin([1:Byte], 2)
		AssertEquals(EMPackError.error_too_big, bounded.Free())
	End Method

	Method TestStreamRoundTripAndShortWrite() { test }
		Local stream:TByteArrayStream = New TByteArrayStream(New Byte[0], False, False)
		Local writer:TMPackWriter = New TMPackWriter(stream)
		writer.Write("stream")
		AssertEquals(EMPackError.ok, writer.Free())
		stream.Seek(0)
		Local reader:TMPackReader = New TMPackReader(stream)
		AssertEquals("stream", reader.ReadString())
		AssertEquals(EMPackError.ok, reader.Free())

		Local failed:TMPackWriter = New TMPackWriter(New TShortWriteStream)
		failed.Write("failure")
		AssertEquals(EMPackError.error_io, failed.Free())

		Local failedRead:TMPackReader = New TMPackReader(New TFailedReadStream)
		failedRead.ReadString()
		AssertEquals(EMPackError.error_io, failedRead.Free())
	End Method

	Method TestChunkedAndInPlaceBytes() { test }
		Local data:Byte[] = New Byte[128]
		Local writer:TMPackWriter = New TMPackWriter(data)
		writer.StartArray(3)
		writer.StartString(3)
		writer.WriteBytes([97:Byte, 0:Byte])
		writer.WriteBytes([98:Byte])
		writer.FinishString()
		writer.StartBin(3)
		writer.WriteBytes([4:Byte])
		writer.WriteBytes([5:Byte, 6:Byte])
		writer.FinishBin()
		writer.StartExt(-7, 2)
		writer.WriteBytes([8:Byte, 9:Byte])
		writer.FinishExt()
		writer.FinishArray()
		Local used:Int = Int(writer.BytesWritten())
		AssertEquals(EMPackError.ok, writer.Free())

		Local reader:TMPackReader = New TMPackReader(data, 0, used)
		AssertTrue(reader.IsMemoryBacked())
		AssertEquals(3, Int(reader.BeginArray()))
		AssertEquals(3, Int(reader.BeginString()))
		Local stringPtr:Byte Ptr = reader.ReadBytesInPlace(3)
		AssertTrue(stringPtr <> Null)
		AssertEquals(0:Byte, stringPtr[1])
		reader.DoneString()
		AssertEquals(3, Int(reader.BeginBin()))
		reader.SkipBytes(1)
		Local tail:Byte[] = New Byte[2]
		reader.ReadBytes(tail)
		AssertEquals(5:Byte, tail[0])
		AssertEquals(6:Byte, tail[1])
		reader.DoneBin()
		Local extType:Int
		AssertEquals(2, Int(reader.BeginExt(extType)))
		AssertEquals(-7, extType)
		reader.SkipBytes(2)
		reader.DoneExt()
		reader.DoneArray()
		AssertEquals(0, Int(reader.BufferedRemaining()))
		AssertEquals(EMPackError.ok, reader.Free())

		Local empty:TMPackReader = New TMPackReader(New Byte[0])
		empty.ReadNil()
		AssertEquals(EMPackError.error_invalid, empty.Free())
	End Method
End Type

Type TShortWriteStream Extends TStream
	Method Write:Long(buffer:Byte Ptr, count:Long) Override
		Return 0
	End Method
End Type

Type TFailedReadStream Extends TStream
	Method Read:Long(buffer:Byte Ptr, count:Long) Override
		Throw "simulated read failure"
	End Method
End Type
