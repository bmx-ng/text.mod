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

Import "source.bmx"

Extern

	Function bmx_mpack_writer_init:Byte Ptr(obj:Object, buffer:Byte Ptr, length:Int)
	Function bmx_mpack_writer_init_memory:Byte Ptr(buffer:Byte Ptr, length:Size_T)
	Function bmx_mpack_writer_init_growable:Byte Ptr()
	Function bmx_mpack_writer_destroy:EMPackError(writer:Byte Ptr)
	Function bmx_mpack_writer_destroy_to_array:Byte[](writer:Byte Ptr, error:EMPackError Var)
	Function bmx_mpack_writer_flag_error(writer:Byte Ptr, error:EMPackError)
	Function mpack_writer_error:EMPackError(writer:Byte Ptr)

	Function mpack_write_u8(writer:Byte Ptr, value:Byte)
	Function mpack_write_u16(writer:Byte Ptr, value:Short)
	Function mpack_write_i32(writer:Byte Ptr, value:Int)
	Function mpack_write_i64(writer:Byte Ptr, value:Long)
	Function mpack_write_float(writer:Byte Ptr, value:Float)
	Function mpack_write_double(writer:Byte Ptr, value:Double)
	Function mpack_write_u32(writer:Byte Ptr, value:UInt)
	Function mpack_write_u64(writer:Byte Ptr, value:ULong)
	Function mpack_write_true(writer:Byte Ptr)
	Function mpack_write_false(writer:Byte Ptr)
	Function mpack_write_bool(writer:Byte Ptr, value:Int)
	Function mpack_write_nil(writer:Byte Ptr)

	Function bmx_mpack_write_utf8(writer:Byte Ptr, str:String, maxLength:UInt)
	Function mpack_write_str(writer:Byte Ptr, str:Byte Ptr, count:UInt)
	Function mpack_write_utf8(writer:Byte Ptr, str:Byte Ptr, count:UInt)
	Function mpack_start_str(writer:Byte Ptr, count:UInt)
	Function mpack_finish_str(writer:Byte Ptr)

	Function mpack_write_bin(writer:Byte Ptr, data:Byte Ptr, count:UInt)
	Function mpack_start_bin(writer:Byte Ptr, count:UInt)
	Function mpack_finish_bin(writer:Byte Ptr)
	Function mpack_write_bytes(writer:Byte Ptr, data:Byte Ptr, count:Size_T)
	Function mpack_write_object_bytes(writer:Byte Ptr, data:Byte Ptr, count:Size_T)

	Function mpack_write_ext(writer:Byte Ptr, extType:Byte, data:Byte Ptr, count:UInt)
	Function mpack_start_ext(writer:Byte Ptr, extType:Byte, count:UInt)
	Function mpack_finish_ext(writer:Byte Ptr)
	Function mpack_write_timestamp(writer:Byte Ptr, seconds:Long, nanoseconds:UInt)

	Function mpack_writer_buffer_used:Size_T(writer:Byte Ptr)
	Function mpack_writer_flush_message(writer:Byte Ptr)

	Function mpack_build_map(writer:Byte Ptr)
	Function mpack_complete_map(writer:Byte Ptr)
	Function mpack_start_map(writer:Byte Ptr, count:UInt)
	Function mpack_finish_map(writer:Byte Ptr)

	Function mpack_build_array(writer:Byte Ptr)
	Function mpack_complete_array(writer:Byte Ptr)
	Function mpack_start_array(writer:Byte Ptr, count:UInt)
	Function mpack_finish_array(writer:Byte Ptr)


	Function bmx_mpack_reader_init:Byte Ptr(obj:Object, buffer:Byte Ptr, length:Int)
	Function bmx_mpack_reader_init_memory:Byte Ptr(data:Byte Ptr, length:Size_T)
	Function bmx_mpack_reader_destroy:EMPackError(reader:Byte Ptr)
	Function bmx_mpack_tag_type:EMPackType(reader:Byte Ptr)
	Function bmx_mpack_read_utf8:String(reader:Byte Ptr, maxLength:UInt)
	Function bmx_mpack_reader_flag_error(reader:Byte Ptr, error:EMPackError)
	Function bmx_mpack_discard_limited(reader:Byte Ptr, maxContainerElements:UInt, maxStringBytes:UInt, maxBinaryBytes:UInt, maxDepth:Int)

	Function mpack_reader_error:EMPackError(reader:Byte Ptr)

	Function mpack_expect_u8:Byte(reader:Byte Ptr)
	Function mpack_expect_u16:Short(reader:Byte Ptr)
	Function mpack_expect_i32:Int(reader:Byte Ptr)
	Function mpack_expect_i64:Long(reader:Byte Ptr)
	Function mpack_expect_float:Float(reader:Byte Ptr)
	Function mpack_expect_double:Double(reader:Byte Ptr)
	Function mpack_expect_u32:UInt(reader:Byte Ptr)
	Function mpack_expect_u64:ULong(reader:Byte Ptr)
	Function mpack_expect_bool:Int(reader:Byte Ptr)
	Function mpack_expect_nil(reader:Byte Ptr)
	Function bmx_mpack_expect_str_max:UInt(reader:Byte Ptr, maxSize:UInt)
	Function mpack_done_str(reader:Byte Ptr)
	Function bmx_mpack_expect_bin_max:UInt(reader:Byte Ptr, maxSize:UInt)
	Function mpack_done_bin(reader:Byte Ptr)
	Function bmx_mpack_expect_ext:UInt(reader:Byte Ptr, extType:Int Var)
	Function mpack_done_ext(reader:Byte Ptr)
	Function bmx_mpack_read_timestamp(reader:Byte Ptr, seconds:Long Var, nanoseconds:UInt Var)
	Function mpack_read_bytes(reader:Byte Ptr, data:Byte Ptr, count:Size_T)
	Function mpack_read_bytes_inplace:Byte Ptr(reader:Byte Ptr, count:Size_T)
	Function mpack_skip_bytes(reader:Byte Ptr, count:Size_T)
	Function mpack_reader_remaining:Size_T(reader:Byte Ptr, data:Byte Ptr Ptr)

	Function bmx_mpack_expect_array_max:UInt(reader:Byte Ptr, maxCount:UInt)
	Function mpack_done_array(reader:Byte Ptr)

	Function bmx_mpack_expect_map_max:UInt(reader:Byte Ptr, maxCount:UInt)
	Function mpack_done_map(reader:Byte Ptr)

End Extern

Enum EMPackError
	ok = 0
	error_io = 2
	error_invalid
	error_unsupported
	error_type
	error_too_big
	error_memory
	error_bug
	error_data
	error_eof
End Enum

Enum EMPackType
	type_missing = 0
    type_nil
    type_bool
    type_int
    type_uint
    type_float
    type_double
    type_str
    type_bin
    type_array
    type_map
	type_ext
End Enum
