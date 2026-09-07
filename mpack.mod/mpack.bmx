' Copyright (c) 2026 Bruce A Henderson
'
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
'
SuperStrict

Rem
bbdoc: A MessagePack encoder / decoder.
End Rem
Module Text.MPack

ModuleInfo "Version: 1.12"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: MIT"
ModuleInfo "Copyright: 2026 Bruce A Henderson"

ModuleInfo "History: 1.12"
ModuleInfo "History: Add explicit String and UTF-8 pointer writer overloads"
ModuleInfo "History: 1.11"
ModuleInfo "History: Update vendored MPack development snapshot to c9d1820"
ModuleInfo "History: 1.10"
ModuleInfo "History: Add bounded memory I/O, extensions, timestamps, raw and chunked values, durable error reporting, and release tracking"
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release"

' MPack's tree/node API is intentionally omitted. Text.MPack exposes the
' streaming tag/expect API, which is smaller and permits callers to enforce
' input limits while decoding. Container tracking stays enabled in release
' builds so incomplete and over-filled containers are always reported.
ModuleInfo "CC_OPTS: -DMPACK_NODE=0 -DMPACK_EXTENSIONS=1 -DMPACK_READ_TRACKING=1 -DMPACK_WRITE_TRACKING=1"

Import brl.stream

Import "common.bmx"

Rem
bbdoc: Resource limits applied while decoding untrusted MessagePack data.
End Rem
Type TMPackLimits
	Field maxStringBytes:UInt = 8 * 1024 * 1024
	Field maxBinaryBytes:UInt = 64 * 1024 * 1024
	Field maxContainerElements:UInt = 1024 * 1024
	Field maxDepth:Int = 64

	Function Create:TMPackLimits(maxStringBytes:UInt = 8 * 1024 * 1024, maxBinaryBytes:UInt = 64 * 1024 * 1024, maxContainerElements:UInt = 1024 * 1024, maxDepth:Int = 64)
		Local limits:TMPackLimits = New TMPackLimits
		limits.maxStringBytes = maxStringBytes
		limits.maxBinaryBytes = maxBinaryBytes
		limits.maxContainerElements = maxContainerElements
		limits.maxDepth = maxDepth
		Return limits
	End Function
End Type

Rem
bbdoc: A MessagePack timestamp value.
End Rem
Struct TMPackTimestamp
	Field seconds:Long
	Field nanoseconds:UInt
End Struct


Rem
bbdoc: A writer for MessagePack data.
End Rem
Type TMPackWriter

	Field mpackWriterPtr:Byte Ptr

	Field StaticArray buffer:Byte[8192]
	Field stream:TStream
	Field memoryBuffer:Byte[]
	Field memoryOffset:Int
	Field memoryCapacity:Int
	Field growable:Int
	Field finalBytesUsed:Size_T
	Field callbackFailed:Int
	Field maxStringBytes:UInt
	Field maxBinaryBytes:UInt
	Field maxContainerElements:UInt
	Field maxDepth:Int
	Field depth:Int

	Method New(stream:TStream, limits:TMPackLimits = Null)
		If Not stream Then Throw "Text.MPack writer requires a stream"
		SetLimits(limits)
		Self.stream = stream
		mpackWriterPtr = bmx_mpack_writer_init(self, buffer, buffer.Length)
		If Not mpackWriterPtr Then Throw "Text.MPack could not allocate a writer"
	End Method

	Rem
	bbdoc: Creates a fixed-capacity memory-backed writer.
	about: The caller retains ownership of @data. Use #BytesWritten before or after #Free to obtain the encoded length.
	End Rem
	Method New(data:Byte[], offset:Int = 0, count:Int = -1, limits:TMPackLimits = Null)
		If data = Null Then Throw "Text.MPack writer requires a byte array"
		If count < 0 Then count = data.Length - offset
		If offset < 0 Or count < 0 Or offset > data.Length Or count > data.Length - offset Then Throw "Text.MPack writer byte range is invalid"
		If count = 0 Then Throw "Text.MPack writer requires a non-empty byte range"
		SetLimits(limits)
		memoryBuffer = data
		memoryOffset = offset
		memoryCapacity = count
		mpackWriterPtr = bmx_mpack_writer_init_memory(Byte Ptr(data) + offset, Size_T(count))
		If Not mpackWriterPtr Then Throw "Text.MPack could not allocate a writer"
	End Method

	Rem
	bbdoc: Creates a growable memory-backed writer.
	about: Prefer #CreateGrowable. Call #Finish to destroy the writer and take ownership of the encoded byte array.
	End Rem
	Method New(growable:Int, limits:TMPackLimits = Null)
		SetLimits(limits)
		Self.growable = True
		mpackWriterPtr = bmx_mpack_writer_init_growable()
		If Not mpackWriterPtr Then Throw "Text.MPack could not allocate a writer"
	End Method

	Function CreateGrowable:TMPackWriter(limits:TMPackLimits = Null)
		Return New TMPackWriter(True, limits)
	End Function

	Method SetLimits(limits:TMPackLimits)
		If Not limits Then limits = New TMPackLimits
		If limits.maxDepth < 1 Then Throw "Text.MPack maximum depth must be positive"
		maxStringBytes = limits.maxStringBytes
		maxBinaryBytes = limits.maxBinaryBytes
		maxContainerElements = limits.maxContainerElements
		maxDepth = limits.maxDepth
	End Method

	Method Free:EMPackError()
		If mpackWriterPtr
			If memoryBuffer Then finalBytesUsed = mpack_writer_buffer_used(mpackWriterPtr)
			Local res:EMPackError = bmx_mpack_writer_destroy(mpackWriterPtr)
			mpackWriterPtr = Null
			Return res
		End If
	End Method

	Rem
	bbdoc: Completes a growable memory writer and returns its encoded bytes.
	about: On failure an empty array is returned and @error receives the writer error. The writer is destroyed in all cases.
	End Rem
	Method Finish:Byte[](error:EMPackError Var)
		If Not mpackWriterPtr Then error = EMPackError.error_bug; Return New Byte[0]
		If Not growable Then FlagError(EMPackError.error_bug)
		Local result:Byte[] = bmx_mpack_writer_destroy_to_array(mpackWriterPtr, error)
		mpackWriterPtr = Null
		Return result
	End Method

	Method Delete()
		Free()
	End Method

	Rem
	bbdoc: Returns the writer's current error state.
	End Rem
	Method Error:EMPackError()
		If Not mpackWriterPtr Then Return EMPackError.error_bug
		Return mpack_writer_error(mpackWriterPtr)
	End Method

	Method HasError:Int()
		Return Error() <> EMPackError.ok
	End Method

	Method FlagError(error:EMPackError)
		If mpackWriterPtr Then bmx_mpack_writer_flag_error(mpackWriterPtr, error)
	End Method

	Method OpenContainer:Int(count:UInt = 0, countKnown:Int = False)
		If depth >= maxDepth Then
			FlagError(EMPackError.error_too_big)
			Return False
		End If
		If countKnown And count > maxContainerElements Then
			FlagError(EMPackError.error_too_big)
			Return False
		End If
		depth :+ 1
		Return True
	End Method

	Method CloseContainer()
		If depth > 0 Then depth :- 1
	End Method

	Rem
	bbdoc: Writes a #Byte in the most efficient packing available.
	End Rem
	Method Write(value:Byte)
		mpack_write_u8(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #Byte in the most efficient packing available.
	End Rem
	Method WriteByte(value:Byte)
		mpack_write_u8(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #Short in the most efficient packing available.
	End Rem
	Method Write(value:Short)
		mpack_write_u16(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #Short in the most efficient packing available.
	End Rem
	Method WriteShort(value:Short)
		mpack_write_u16(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes an #Int in the most efficient packing available.
	End Rem
	Method Write(value:Int)
		mpack_write_i32(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes an #Int in the most efficient packing available.
	End Rem
	Method WriteInt(value:Int)
		mpack_write_i32(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #Long in the most efficient packing available.
	End Rem
	Method Write(value:Long)
		mpack_write_i64(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #Long in the most efficient packing available.
	End Rem
	Method WriteLong(value:Long)
		mpack_write_i64(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #Float in the most efficient packing available.
	End Rem
	Method Write(value:Float)
		mpack_write_float(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #Float in the most efficient packing available.
	End Rem
	Method WriteFloat(value:Float)
		mpack_write_float(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #Double in the most efficient packing available.
	End Rem
	Method Write(value:Double)
		mpack_write_double(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #Double in the most efficient packing available.
	End Rem
	Method WriteDouble(value:Double)
		mpack_write_double(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #UInt in the most efficient packing available.
	End Rem
	Method Write(value:UInt)
		mpack_write_u32(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #UInt in the most efficient packing available.
	End Rem
	Method WriteUInt(value:UInt)
		mpack_write_u32(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #ULong in the most efficient packing available.
	End Rem
	Method Write(value:ULong)
		mpack_write_u64(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #ULong in the most efficient packing available.
	End Rem
	Method WriteULong(value:ULong)
		mpack_write_u64(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #Size_T in the most efficient packing available.
	End Rem
	Method Write(value:Size_T)
		mpack_write_u64(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #Size_T in the most efficient packing available.
	End Rem
	Method WriteSizeT(value:Size_T)
		mpack_write_u64(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #LongInt in the most efficient packing available.
	End Rem
	Method Write(value:LongInt)
		mpack_write_i64(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #LongInt in the most efficient packing available.
	End Rem
	Method WriteLongInt(value:LongInt)
		mpack_write_i64(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #ULongInt in the most efficient packing available.
	End Rem
	Method Write(value:ULongInt)
		mpack_write_u64(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a #ULongInt in the most efficient packing available.
	End Rem
	Method WriteULongInt(value:ULongInt)
		mpack_write_u64(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a true value.
	End Rem
	Method WriteTrue()
		mpack_write_true(mpackWriterPtr)
	End Method

	Rem
	bbdoc: Writes a false value.
	End Rem
	Method WriteFalse()
		mpack_write_false(mpackWriterPtr)
	End Method

	Rem
	bbdoc: Writes a boolean value.
	End Rem
	Method WriteBool(value:Int)
		mpack_write_bool(mpackWriterPtr, value)
	End Method

	Rem
	bbdoc: Writes a nil value.
	End Rem
	Method WriteNil()
		mpack_write_nil(mpackWriterPtr)
	End Method

	Rem
	bbdoc: Writes a #String.
	End Rem
	Method Write(value:String)
		WriteString(value)
	End Method

	Rem
	bbdoc: Writes a #String as UTF-8.
	End Rem
	Method WriteString(value:String)
		bmx_mpack_write_utf8(mpackWriterPtr, value, maxStringBytes)
	End Method

	Rem
	bbdoc: Flushes any buffered data to the underlying stream.
	about: If the writer is connected to a socket and you are keeping it open, you will want to call this after writing a message (or set of
	messages) so that the data is actually sent.

	It is not necessary to call this if you are not keeping the writer open afterwards. You can just call #Free() and it
	will flush before cleaning up.
	End Rem
	Method Flush()
		If stream Then mpack_writer_flush_message(mpackWriterPtr)
	End Method

	Rem
	bbdoc: Returns the number of bytes used in the buffer.
	End Rem
	Method BufferUsed:Size_T()
		Return mpack_writer_buffer_used(mpackWriterPtr)
	End Method

	Rem
	bbdoc: Starts building a map.
	about: An even number of elements must follow, and #CompleteMap() must be called when done. The number of elements is
	determined automatically.

	If you know ahead of time the number of elements in the map, it is more efficient to call #StartMap() instead, even if
	you are already within another open build.

	Builder containers can be nested within normal (known size) containers and vice versa. You can call #BuildMap(), then
	#StartMap() inside it, then #BuildMap() inside that, and so forth.

	A writer in build mode diverts writes to a builder buffer that allocates as needed. Once the last map or array being
	built is completed, the deferred message is composed with computed array and map sizes into the writer.
	Builder maps and arrays are encoded exactly the same as ordinary maps and arrays in the final message.

	This indirect encoding is costly, as it incurs at least an extra copy of all data written within a builder (but not additional
	copies for nested builders.) Expect a speed penalty of half or more.

	A good strategy is to use this during early development when your messages are constantly changing, and then closer to release
	when your message formats have stabilized, replace all your build calls with start calls with pre-computed sizes. Or don't, if
	you find the builder has little impact on performance, because even with builders MPack is extremely fast.

	Note : When an array or map starts being built, nothing will be flushed until it is completed. If you are building a large message that does not fit in the output stream, you won't get an error about it until everything is written.
	End Rem
	Method BuildMap()
		If OpenContainer() Then mpack_build_map(mpackWriterPtr)
	End Method

	Rem
	bbdoc: Completes a map being built.
	about: See #BuildMap() for more information.
	End Rem
	Method CompleteMap()
		mpack_complete_map(mpackWriterPtr)
		CloseContainer()
	End Method

	Rem
	bbdoc: Opens a map.
	about: `count * 2` elements must follow, and #FinishMap() must be called when done.

	If you do not know the number of elements to be written ahead of time, call #BuildMap() instead.

	Remember that while map elements in MessagePack are implicitly ordered, they are not ordered in JSON.
	If you need elements to be read back in the order they are written, consider use an array instead.
	End Rem
	Method StartMap(count:UInt)
		If OpenContainer(count, True) Then mpack_start_map(mpackWriterPtr, count)
	End Method

	Rem
	bbdoc: Closes a map.
	about: See #StartMap() for more information.
	End Rem
	Method FinishMap()
		mpack_finish_map(mpackWriterPtr)
		CloseContainer()
	End Method

	Rem
	bbdoc: Starts building an array.
	about: Elements must follow, and #CompleteArray() must be called when done. The number of elements is determined automatically.

	If you know ahead of time the number of elements in the array, it is more efficient to call #StartArray() instead,
	even if you are already within another open build.

	Builder containers can be nested within normal (known size) containers and vice versa. You can call #BuildArray(), then #StartArray()
	inside it, then #BuildArray() inside that, and so forth.

	End Rem
	Method BuildArray()
		If OpenContainer() Then mpack_build_array(mpackWriterPtr)
	End Method

	Rem
	bbdoc: Completes an array being built.
	about: See #BuildArray() for more information.
	End Rem
	Method CompleteArray()
		mpack_complete_array(mpackWriterPtr)
		CloseContainer()
	End Method

	Rem
	bbdoc: Opens an array.
	about: `count` elements must follow, and #FinishArray() must be called when done.

	If you do not know the number of elements to be written ahead of time, call #BuildArray() instead.
	End Rem
	Method StartArray(count:UInt)
		If OpenContainer(count, True) Then mpack_start_array(mpackWriterPtr, count)
	End Method

	Rem
	bbdoc: Closes an array.
	End Rem
	Method FinishArray()
		mpack_finish_array(mpackWriterPtr)
		CloseContainer()
	End Method

	Rem
	bbdoc: Writes a binary blob.
	about: To stream a binary blob in chunks, use #StartBin() instead.

	You should not call #FinishBin() after calling this; this performs both start and finish.
	End Rem
	Method WriteBin(value:Byte Ptr, count:UInt)
		If count > maxBinaryBytes Then FlagError(EMPackError.error_too_big); Return
		If count And Not value Then FlagError(EMPackError.error_bug); Return
		mpack_write_bin(mpackWriterPtr, value, count)
	End Method

	Rem
	bbdoc: Writes a byte array as a binary blob.
	about: By default writes the whole array. Optionally, you can specify a @count to write only a portion of the array.

	To stream a binary blob in chunks, use #StartBin() instead.

	You should not call #FinishBin() after calling this - this performs both start and finish.
	End Rem
	Method WriteBin(value:Byte[], count:UInt = 0)
		If value = Null Then value = New Byte[0]
		If Not count Then count = UInt(value.Length)
		If count > UInt(value.Length) Then FlagError(EMPackError.error_too_big); Return
		WriteBin(Byte Ptr(value), count)
	End Method

	Rem
	bbdoc: Opens a binary blob.
	about: `count` bytes should be written with calls to #WriteBytes(), and #FinishBin() should be called when done.
	End Rem
	Method StartBin(count:UInt)
		If count > maxBinaryBytes Then FlagError(EMPackError.error_too_big); Return
		mpack_start_bin(mpackWriterPtr, count)
	End Method

	Rem
	bbdoc: Writes a portion of bytes for a binary blob which was opened with #StartBin.
	about: This can be called multiple times to write the data in chunks, as long as the total amount of bytes written
	matches the count given when the compound type was started.

	The corresponding #FinishBin must be called when done.

	To write an binary blob at once, use one of the #WriteBin() methods instead.
	End Rem
	Method WriteBytes(value:Byte Ptr, count:Size_T)
		If count And Not value Then FlagError(EMPackError.error_bug); Return
		mpack_write_bytes(mpackWriterPtr, value, count)
	End Method

	Rem
	bbdoc: Writes a portion of bytes for a binary blob which was opened with #StartBin.
	about: By default writes the whole array. Optionally, you can specify a @count to write only a portion of the array.

	This can be called multiple times to write the data in chunks, as long as the total amount of bytes written
	matches the count given when the compound type was started.

	The corresponding #FinishBin must be called when done.

	To write an binary blob at once, use one of the #WriteBin() methods instead.
	End Rem
	Method WriteBytes(value:Byte[], count:Size_T = 0)
		If value = Null Then value = New Byte[0]
		If Not count Then count = Size_T(value.Length)
		If count > Size_T(value.Length) Then FlagError(EMPackError.error_too_big); Return
		WriteBytes(Byte Ptr(value), count)
	End Method

	Rem
	bbdoc: Finishes writing a binary blob.
	about: This should be called only after a corresponding call to #StartBin() and after the binary bytes are written with #WriteBytes().

	This will track writes to ensure that the correct number of bytes are written.
	End Rem
	Method FinishBin()
		mpack_finish_bin(mpackWriterPtr)
	End Method

	Rem
	bbdoc: Opens a raw MessagePack string whose UTF-8 bytes will be supplied with #WriteBytes.
	End Rem
	Method StartString(count:UInt)
		If count > maxStringBytes Then FlagError(EMPackError.error_too_big); Return
		mpack_start_str(mpackWriterPtr, count)
	End Method

	Method FinishString()
		mpack_finish_str(mpackWriterPtr)
	End Method

	Rem
	bbdoc: Writes already UTF-8 encoded bytes as a MessagePack string.
	about: @count is required because a raw pointer does not carry its buffer length. Embedded NUL bytes are preserved.
	End Rem
	Method WriteStringBytes(value:Byte Ptr, count:UInt)
		If count > maxStringBytes Then FlagError(EMPackError.error_too_big); Return
		If count And Not value Then FlagError(EMPackError.error_bug); Return
		mpack_write_utf8(mpackWriterPtr, value, count)
	End Method

	Rem
	bbdoc: Writes already UTF-8 encoded bytes as a MessagePack string.
	End Rem
	Method WriteStringBytes(value:Byte[], count:UInt = 0)
		If value = Null Then value = New Byte[0]
		If Not count Then count = UInt(value.Length)
		If count > UInt(value.Length) Then FlagError(EMPackError.error_too_big); Return
		WriteStringBytes(Byte Ptr(value), count)
	End Method

	Rem
	bbdoc: Writes an extension value.
	End Rem
	Method WriteExt(extType:Int, value:Byte[], count:UInt = 0)
		If extType < -128 Or extType > 127 Then FlagError(EMPackError.error_data); Return
		If value = Null Then value = New Byte[0]
		If Not count Then count = UInt(value.Length)
		If count > UInt(value.Length) Or count > maxBinaryBytes Then FlagError(EMPackError.error_too_big); Return
		mpack_write_ext(mpackWriterPtr, Byte(extType), Byte Ptr(value), count)
	End Method

	Method StartExt(extType:Int, count:UInt)
		If extType < -128 Or extType > 127 Then FlagError(EMPackError.error_data); Return
		If count > maxBinaryBytes Then FlagError(EMPackError.error_too_big); Return
		mpack_start_ext(mpackWriterPtr, Byte(extType), count)
	End Method

	Method FinishExt()
		mpack_finish_ext(mpackWriterPtr)
	End Method

	Method WriteTimestamp(seconds:Long, nanoseconds:UInt = 0)
		If nanoseconds >= 1000000000 Then FlagError(EMPackError.error_data); Return
		mpack_write_timestamp(mpackWriterPtr, seconds, nanoseconds)
	End Method

	Rem
	bbdoc: Inserts one complete, pre-encoded MessagePack object.
	about: The object is structurally validated only when it is later decoded. The byte range is checked before it is passed to MPack.
	End Rem
	Method WriteObjectBytes(value:Byte[], count:Size_T = 0)
		If value = Null Then value = New Byte[0]
		If Not count Then count = Size_T(value.Length)
		If count > Size_T(value.Length) Or count > Size_T(maxBinaryBytes) Then FlagError(EMPackError.error_too_big); Return
		mpack_write_object_bytes(mpackWriterPtr, Byte Ptr(value), count)
	End Method

	Rem
	bbdoc: Returns the encoded length for a memory-backed writer.
	End Rem
	Method BytesWritten:Size_T()
		If mpackWriterPtr And (memoryBuffer Or growable) Then Return mpack_writer_buffer_used(mpackWriterPtr)
		Return finalBytesUsed
	End Method

	Function _Flush:Int(writer:TMPackWriter, buf:Byte Ptr, size:Size_T) { nomangle }
		Try
			Return writer.stream.Write(buf, Long(size)) = Long(size)
		Catch exception:Object
			writer.callbackFailed = True
			Return False
		End Try
	End Function
End Type

Rem
bbdoc: A reader for MessagePack data.
End Rem
Type TMPackReader

	Field mpackReaderPtr:Byte Ptr

	Field StaticArray buffer:Byte[8192]
	Field stream:TStream
	Field memoryBuffer:Byte[]
	Field memoryBacked:Int
	Field callbackFailed:Int
	Field maxStringBytes:UInt
	Field maxBinaryBytes:UInt
	Field maxContainerElements:UInt
	Field maxDepth:Int
	Field depth:Int

	Method New(stream:TStream, limits:TMPackLimits = Null)
		If Not stream Then Throw "Text.MPack reader requires a stream"
		SetLimits(limits)
		Self.stream = stream
		mpackReaderPtr = bmx_mpack_reader_init(self, buffer, buffer.Length)
		If Not mpackReaderPtr Then Throw "Text.MPack could not allocate a reader"
	End Method

	Rem
	bbdoc: Creates a zero-copy memory-backed reader over a byte array.
	about: The reader retains the array for its lifetime. No input bytes are copied.
	End Rem
	Method New(data:Byte[], offset:Int = 0, count:Int = -1, limits:TMPackLimits = Null)
		If count < 0 Then count = data.Length - offset
		If offset < 0 Or count < 0 Or offset > data.Length Or count > data.Length - offset Then Throw "Text.MPack reader byte range is invalid"
		SetLimits(limits)
		memoryBuffer = data
		memoryBacked = True
		mpackReaderPtr = bmx_mpack_reader_init_memory(Byte Ptr(data) + offset, Size_T(count))
		If Not mpackReaderPtr Then Throw "Text.MPack could not allocate a reader"
	End Method

	Method SetLimits(limits:TMPackLimits)
		If Not limits Then limits = New TMPackLimits
		If limits.maxDepth < 1 Then Throw "Text.MPack maximum depth must be positive"
		maxStringBytes = limits.maxStringBytes
		maxBinaryBytes = limits.maxBinaryBytes
		maxContainerElements = limits.maxContainerElements
		maxDepth = limits.maxDepth
	End Method

	Method Free:EMPackError()
		If mpackReaderPtr
			Local res:EMPackError = bmx_mpack_reader_destroy(mpackReaderPtr)
			mpackReaderPtr = Null
			Return res
		End If
	End Method

	Method Delete()
		Free()
	End Method

	Rem
	bbdoc: Returns the current error state of the reader.
	End Rem
	Method HasReaderError:EMPackError()
		Return Error()
	End Method

	Method Error:EMPackError()
		If Not mpackReaderPtr Then Return EMPackError.error_bug
		Return mpack_reader_error(mpackReaderPtr)
	End Method

	Method HasError:Int()
		Return Error() <> EMPackError.ok
	End Method

	Method FlagError(error:EMPackError)
		If mpackReaderPtr Then bmx_mpack_reader_flag_error(mpackReaderPtr, error)
	End Method

	Method OpenContainer:Int()
		If depth >= maxDepth Then
			FlagError(EMPackError.error_too_big)
			Return False
		End If
		depth :+ 1
		Return True
	End Method

	Method CloseContainer()
		If depth > 0 Then depth :- 1
	End Method

	Rem
	bbdoc: Returns the tag type of the next tag without advancing the reader.
	about: This is useful for reading a tag and then deciding what to do with it.
	This is especially the case because using an incorrect Read method can put the reader into an error state.
	Once it is in an error state it will remain so until it is freed.
	End Rem
	Method NextType:EMPackType()
		Return bmx_mpack_tag_type(mpackReaderPtr)
	End Method

	Rem
	bbdoc: Reads a #Byte.
	about: The underlying type may be an integer type of any size and signedness, as long as the value can be represented in an 8-bit unsigned int.

	Returns zero if an error occurs.
	End Rem
	Method ReadByte:Byte()
		Return mpack_expect_u8(mpackReaderPtr)
	End Method

	Rem
	bbdoc: Reads a #Short.
	End Rem
	Method ReadShort:Short()
		Return mpack_expect_u16(mpackReaderPtr)
	End Method

	Rem
	bbdoc: Reads an #Int.
	End Rem
	Method ReadInt:Int()
		Return mpack_expect_i32(mpackReaderPtr)
	End Method

	Rem
	bbdoc: Reads a #UInt.
	End Rem
	Method ReadUInt:UInt()
		Return mpack_expect_u32(mpackReaderPtr)
	End Method

	Rem
	bbdoc: Reads a #Long.
	End Rem
	Method ReadLong:Long()
		Return mpack_expect_i64(mpackReaderPtr)
	End Method

	Rem
	bbdoc: Reads a #ULong.
	End Rem
	Method ReadULong:ULong()
		Return mpack_expect_u64(mpackReaderPtr)
	End Method

	Rem
	bbdoc: Reads a #Float.
	End Rem
	Method ReadFloat:Float()
		Return mpack_expect_float(mpackReaderPtr)
	End Method

	Rem
	bbdoc: Reads a #Double.
	End Rem
	Method ReadDouble:Double()
		Return mpack_expect_double(mpackReaderPtr)
	End Method

	Method ReadLongInt:LongInt()
		Return mpack_expect_i64(mpackReaderPtr)
	End Method

	Method ReadULongInt:ULongInt()
		Return mpack_expect_u64(mpackReaderPtr)
	End Method

	Rem
	bbdoc: Reads a boolean, returning either #True or #False.
	End Rem
	Method ReadBool:Int()
		Return mpack_expect_bool(mpackReaderPtr)
	End Method

	Rem
	bbdoc: Reads a nil value.
	End Rem
	Method ReadNil()
		mpack_expect_nil(mpackReaderPtr)
	End Method

	Rem
	bbdoc: Reads a #String.
	End Rem
	Method ReadString:String()
		Return bmx_mpack_read_utf8(mpackReaderPtr, maxStringBytes)
	End Method

	Rem
	bbdoc: Begins reading the bytes of a MessagePack string.
	End Rem
	Method BeginString:UInt()
		Return bmx_mpack_expect_str_max(mpackReaderPtr, maxStringBytes)
	End Method

	Method DoneString()
		mpack_done_str(mpackReaderPtr)
	End Method

	Method ReadStringBytes:Byte[]()
		Local count:UInt = BeginString()
		If HasError() Or count > UInt(2147483647) Then
			If count > UInt(2147483647) Then FlagError(EMPackError.error_too_big)
			Return New Byte[0]
		End If
		Local result:Byte[] = New Byte[Int(count)]
		If count Then mpack_read_bytes(mpackReaderPtr, result, Size_T(count))
		DoneString()
		Return result
	End Method

	Method BeginBin:UInt()
		Return bmx_mpack_expect_bin_max(mpackReaderPtr, maxBinaryBytes)
	End Method

	Method DoneBin()
		mpack_done_bin(mpackReaderPtr)
	End Method

	Method ReadBin:Byte[]()
		Local count:UInt = BeginBin()
		If HasError() Or count > UInt(2147483647) Then
			If count > UInt(2147483647) Then FlagError(EMPackError.error_too_big)
			Return New Byte[0]
		End If
		Local result:Byte[] = New Byte[Int(count)]
		If count Then mpack_read_bytes(mpackReaderPtr, result, Size_T(count))
		DoneBin()
		Return result
	End Method

	Method BeginExt:UInt(extType:Int Var)
		Local count:UInt = bmx_mpack_expect_ext(mpackReaderPtr, extType)
		If count > maxBinaryBytes Then FlagError(EMPackError.error_too_big)
		Return count
	End Method

	Method DoneExt()
		mpack_done_ext(mpackReaderPtr)
	End Method

	Method ReadExt:Byte[](extType:Int Var)
		Local count:UInt = BeginExt(extType)
		If HasError() Or count > UInt(2147483647) Then
			If count > UInt(2147483647) Then FlagError(EMPackError.error_too_big)
			Return New Byte[0]
		End If
		Local result:Byte[] = New Byte[Int(count)]
		If count Then mpack_read_bytes(mpackReaderPtr, result, Size_T(count))
		DoneExt()
		Return result
	End Method

	Method ReadTimestamp:TMPackTimestamp()
		Local result:TMPackTimestamp
		bmx_mpack_read_timestamp(mpackReaderPtr, result.seconds, result.nanoseconds)
		Return result
	End Method

	Rem
	bbdoc: Reads raw bytes from an open string, binary, or extension value.
	End Rem
	Method ReadBytes(value:Byte[], count:Size_T = 0)
		If value = Null Then value = New Byte[0]
		If Not count Then count = Size_T(value.Length)
		If count > Size_T(value.Length) Then FlagError(EMPackError.error_too_big); Return
		If count Then mpack_read_bytes(mpackReaderPtr, value, count)
	End Method

	Rem
	bbdoc: Returns a temporary pointer to raw bytes without copying.
	about: The pointer is valid only until the next reader operation. The owning reader and its memory array or stream buffer must remain alive.
	End Rem
	Method ReadBytesInPlace:Byte Ptr(count:Size_T)
		Return mpack_read_bytes_inplace(mpackReaderPtr, count)
	End Method

	Method SkipBytes(count:Size_T)
		mpack_skip_bytes(mpackReaderPtr, count)
	End Method

	Rem
	bbdoc: Discards the next complete value while enforcing this reader's limits.
	End Rem
	Method Discard()
		bmx_mpack_discard_limited(mpackReaderPtr, maxContainerElements, maxStringBytes, maxBinaryBytes, maxDepth)
	End Method

	Method IsMemoryBacked:Int()
		Return memoryBacked
	End Method

	Rem
	bbdoc: Returns unread bytes currently buffered by MPack.
	about: For a memory-backed reader this is the complete remaining input. For a stream reader it is only the data already buffered.
	End Rem
	Method BufferedRemaining:Size_T()
		Return mpack_reader_remaining(mpackReaderPtr, Null)
	End Method

	Rem
	bbdoc: Reads the start of an array returning its element count.
	returns: The number of elements in the array.
	about: This does not read the elements of the array. You must call the appropriate Read method for each element.

	Call #DoneArray() when you are done reading the array.
	End Rem
	Method BeginArray:UInt()
		If Not OpenContainer() Then Return 0
		Local count:UInt = bmx_mpack_expect_array_max(mpackReaderPtr, maxContainerElements)
		If HasError() Then CloseContainer()
		Return count
	End Method

	Rem
	bbdoc: Ends the reading of an array.
	End Rem
	Method DoneArray()
		mpack_done_array(mpackReaderPtr)
		CloseContainer()
	End Method

	Rem
	bbdoc: Reads the start of a map returning a count of the key/value pairs.
	about: This does not read the elements of the map. You must call the appropriate Read method for each key and value.
	End Rem
	Method BeginMap:UInt()
		If Not OpenContainer() Then Return 0
		Local count:UInt = bmx_mpack_expect_map_max(mpackReaderPtr, maxContainerElements)
		If HasError() Then CloseContainer()
		Return count
	End Method

	Rem
	bbdoc: Ends the reading of a map.
	End Rem
	Method DoneMap()
		mpack_done_map(mpackReaderPtr)
		CloseContainer()
	End Method

	Function _Fill:Size_T(reader:TMPackReader, buf:Byte Ptr, count:Size_T) { nomangle }
		reader.callbackFailed = False
		Try
			Local readCount:Long = reader.stream.Read(buf, Long(count))
			If readCount < 0 Then reader.callbackFailed = True; Return 0
			Return Size_T(readCount)
		Catch exception:Object
			reader.callbackFailed = True
			Return 0
		End Try
	End Function

	Function _FillFailed:Int(reader:TMPackReader) { nomangle }
		Return reader.callbackFailed
	End Function

End Type
