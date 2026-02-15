SuperStrict

Import brl.maxunit
Import text.persistencexml

Import "types.bmx"

Type FieldsTest Extends TTest

	Const NUM_INT:Int = 12345
	Const NUM_LONG:Long = 84343238901:Long
	Const NUM_FLOAT:Float = 10.688:Float
	Const NUM_DOUBLE:Double = 9420.0394:Double
	Const NUM_BYTE:Byte = 129
	Const NUM_SHORT:Short = 40000
	Const NUM_UINT:UInt = 123456
	Const NUM_ULONG:ULong = 4473709551615:ULong
	Const NUM_LONGINT:LongInt = 998800
	Const NUM_ULONGINT:ULongInt = 560000
	
	Const STR_ONE:String = "ABCDEFG"
	Const STR_TWO:String = "HIJKLMNOP"
	Const STR_THREE:String = "QRSTUVWXYZ"
	
	Const OBJ_ONE:Int = 6644
	Const OBJ_TWO:Int = 7755
	Const OBJ_THREE:Int = 8833
	
	Field persist:TPersist
	
	Field obj1:TObject
	Field obj2:TObject
	Field obj3:TObject

	Method Setup() { before }
		persist = New TXMLPersistenceBuilder.Build()
		
		obj1 = New TObject.Create(OBJ_ONE)
		obj2 = New TObject.Create(OBJ_TWO)
		obj3 = New TObject.Create(OBJ_THREE)
	End Method

	Method TearDown() { after }
		persist.Free()
	End Method

	Method testNumbers() { test }
		Local numbers:TNumbers = New TNumbers.Create(NUM_INT, NUM_LONG, NUM_FLOAT, NUM_DOUBLE, NUM_BYTE, NUM_SHORT, NUM_UINT, NUM_ULONG, NUM_LONGINT, NUM_ULONGINT)
		
		Local s:String = persist.SerializeToString(numbers)

		persist.Free()
		
		Local result:TNumbers = TNumbers(persist.DeserializeObject(s))
	
		assertEquals(NUM_INT, result.a)
		assertEquals(NUM_LONG, result.b)
		assertEquals(NUM_FLOAT, result.c)
		assertEquals(NUM_DOUBLE, result.d)
		assertEquals(NUM_BYTE, result.e)
		assertEquals(NUM_SHORT, result.f)
		assertEquals(NUM_UINT, result.g)
		assertEquals(NUM_ULONG, result.h)
		assertEquals(NUM_LONGINT, result.i)
		assertEquals(NUM_ULONGINT, result.j)
	End Method
	
	Method testStrings() { test }
	
		Local strings:TStrings = New TStrings.Create(STR_ONE, STR_TWO, STR_THREE)
		
		Local s:String = persist.SerializeToString(strings)
		
		validateStringRefs(s, STR_ONE, 1)
		validateStringRefs(s, STR_TWO, 1)
		validateStringRefs(s, STR_THREE, 1)
		
		persist.Free()
		
		Local result:TStrings = TStrings(persist.DeserializeObject(s))
	
		assertEquals(STR_ONE, result.a)
		assertEquals(STR_TWO, result.b)
		assertEquals(STR_THREE, result.c)
	
	End Method

	' should only store a single copy of the string
	Method testStringRefs() { test }
	
		Local strings:TStrings = New TStrings.Create(STR_ONE, STR_ONE, STR_ONE)
		
		Local s:String = persist.SerializeToString(strings)
		
		validateStringRefs(s, STR_ONE, 1)
				
		persist.Free()
		
		Local result:TStrings = TStrings(persist.DeserializeObject(s))
	
		assertEquals(STR_ONE, result.a)
		assertEquals(STR_ONE, result.b)
		assertEquals(STR_ONE, result.c)
	
	End Method
	
	Method testObjects() { test }
		
		Local container:TObjectContainer = New TObjectContainer.Create(obj1, obj2, obj3)

		Local s:String = persist.SerializeToString(container)

		validateStringRefs(s, OBJ_ONE, 1)
		validateStringRefs(s, OBJ_TWO, 1)
		validateStringRefs(s, OBJ_THREE, 1)

		persist.Free()

		Local result:TObjectContainer = TObjectContainer(persist.DeserializeObject(s))

		assertEquals(OBJ_ONE, result.object1.code)
		assertEquals(OBJ_TWO, result.object2.code)
		assertEquals(OBJ_THREE, result.object3.code)
	End Method

	Method testObjectRefs() { test }
		
		Local container:TObjectContainer = New TObjectContainer.Create(obj1, obj2, obj1)

		Local s:String = persist.SerializeToString(container)

		validateStringRefs(s, OBJ_ONE, 1)
		validateStringRefs(s, OBJ_TWO, 1)

		persist.Free()

		Local result:TObjectContainer = TObjectContainer(persist.DeserializeObject(s))

		assertEquals(OBJ_ONE, result.object1.code)
		assertEquals(OBJ_TWO, result.object2.code)
		assertEquals(OBJ_ONE, result.object3.code)
	End Method

	Method testEmptyStrings() { test }
	
		Local strings:TStrings = New TStrings.Create(Null, STR_ONE, Null)
		
		assertNull(strings.a)
		assertEquals(STR_ONE, strings.b)
		assertNull(strings.c)

		Local s:String = persist.SerializeToString(strings)

		validateStringRefs(s, STR_ONE, 1)

		persist.Free()

		Local result:TStrings = TStrings(persist.DeserializeObject(s))
	
		assertNull(result.a)
		assertEquals(STR_ONE, result.b)
		assertNull(result.c)
		
	End Method
	
	Method validateStringRefs(ser:String, txt:String, expected:Int)
		Local count:Int
		Local i:Int = ser.Find(txt, 0)

		While i <> -1
			count :+ 1
			i = ser.Find(txt, i + txt.length)
		Wend
		
		assertEquals(expected, count, "Refs mismatch")
	End Method

	Method testArrays() { test }
		Local arrays:TArrays = New TArrays()
		arrays.populate()
		
		Local s:String = persist.SerializeToString(arrays)

		persist.Free()
		
		Local result:TArrays = TArrays(persist.DeserializeObject(s))

		AssertEquals(arrays.bytes.Length, result.bytes.Length, "Bytes Array length mismatch")
		For Local i:Int = 0 Until arrays.bytes.Length
			AssertEquals(arrays.bytes[i], result.bytes[i], "Bytes Array item mismatch at index " + i)
		Next

		AssertEquals(arrays.shorts.Length, result.shorts.Length, "Shorts Array length mismatch")
		For Local i:Int = 0 Until arrays.shorts.Length
			AssertEquals(arrays.shorts[i], result.shorts[i], "Shorts Array item mismatch at index " + i)
		Next

		AssertEquals(arrays.ints.Length, result.ints.Length, "Ints Array length mismatch")
		For Local i:Int = 0 Until arrays.ints.Length
			AssertEquals(arrays.ints[i], result.ints[i], "Ints Array item mismatch at index " + i)
		Next

		AssertEquals(arrays.uints.Length, result.uints.Length, "UInts Array length mismatch")
		For Local i:Int = 0 Until arrays.uints.Length
			AssertEquals(arrays.uints[i], result.uints[i], "UInts Array item mismatch at index " + i)
		Next

		AssertEquals(arrays.longs.Length, result.longs.Length, "Longs Array length mismatch")
		For Local i:Int = 0 Until arrays.longs.Length
			AssertEquals(arrays.longs[i], result.longs[i], "Longs Array item mismatch at index " + i)
		Next

		AssertEquals(arrays.ulongs.Length, result.ulongs.Length, "ULongs Array length mismatch")
		For Local i:Int = 0 Until arrays.ulongs.Length
			AssertEquals(arrays.ulongs[i], result.ulongs[i], "ULongs Array item mismatch at index " + i)
		Next

		AssertEquals(arrays.longints.Length, result.longints.Length, "LongInts Array length mismatch")
		For Local i:Int = 0 Until arrays.longints.Length
			AssertEquals(arrays.longints[i], result.longints[i], "LongInts Array item mismatch at index " + i)
		Next

		AssertEquals(arrays.ulongints.Length, result.ulongints.Length, "ULongInts Array length mismatch")
		For Local i:Int = 0 Until arrays.ulongints.Length
			AssertEquals(arrays.ulongints[i], result.ulongints[i], "ULongInts Array item mismatch at index " + i)
		Next

		AssertEquals(arrays.sizets.Length, result.sizets.Length, "Size_Ts Array length mismatch")
		For Local i:Int = 0 Until arrays.sizets.Length
			AssertEquals(arrays.sizets[i], result.sizets[i], "Size_Ts Array item mismatch at index " + i)
		Next

		AssertEquals(arrays.floats.Length, result.floats.Length, "Floats Array length mismatch")
		For Local i:Int = 0 Until arrays.floats.Length
			AssertEquals(arrays.floats[i], result.floats[i], 0, "Floats Array item mismatch at index " + i)
		Next

		AssertEquals(arrays.doubles.Length, result.doubles.Length, "Doubles Array length mismatch")
		For Local i:Int = 0 Until arrays.doubles.Length
			AssertEquals(arrays.doubles[i], result.doubles[i], 0, "Doubles Array item mismatch at index " + i)
		Next

	End Method

	Method testIntArray() { test }
		Local ints:Int[] = [-2147483648, 1, 2, 3, 4, 5, 6, 7, 8, 9, 2147483647]
		
		Local s:String = persist.SerializeToString(ints)

		persist.Free()
		
		Local result:Int[] = Int[](persist.DeserializeObject(s))

		AssertEquals(ints.Length, result.Length, "Ints Array length mismatch")
		For Local i:Int = 0 Until ints.Length
			AssertEquals(ints[i], result[i], "Ints Array item mismatch at index " + i)
		Next
	End Method

	Method testByteArray() { test }
		Local bytes:Byte[] = [0:Byte, 1:Byte, 2:Byte, 3:Byte, 4:Byte, 5:Byte, 6:Byte, 7:Byte, 8:Byte, 9:Byte, 255:Byte]
		
		Local s:String = persist.SerializeToString(bytes)

		persist.Free()
		
		Local result:Byte[] = Byte[](persist.DeserializeObject(s))

		AssertEquals(bytes.Length, result.Length, "Bytes Array length mismatch")
		For Local i:Int = 0 Until bytes.Length
			AssertEquals(bytes[i], result[i], "Bytes Array item mismatch at index " + i)
		Next
	End Method

	Method testShortArray() { test }
		Local shorts:Short[] = [0:Short, 1:Short, 2:Short, 3:Short, 4:Short, 5:Short, 6:Short, 7:Short, 8:Short, 9:Short, 65535:Short]
		
		Local s:String = persist.SerializeToString(shorts)

		persist.Free()
		
		Local result:Short[] = Short[](persist.DeserializeObject(s))

		AssertEquals(shorts.Length, result.Length, "Shorts Array length mismatch")
		For Local i:Int = 0 Until shorts.Length
			AssertEquals(shorts[i], result[i], "Shorts Array item mismatch at index " + i)
		Next
	End Method

	Method testUIntArray() { test }
		Local uints:UInt[] = [0:UInt, 1:UInt, 2:UInt, 3:UInt, 4:UInt, 5:UInt, 6:UInt, 7:UInt, 8:UInt, 9:UInt, 4294967295:UInt]
		
		Local s:String = persist.SerializeToString(uints)

		persist.Free()
		
		Local result:UInt[] = UInt[](persist.DeserializeObject(s))

		AssertEquals(uints.Length, result.Length, "UInts Array length mismatch")
		For Local i:Int = 0 Until uints.Length
			AssertEquals(uints[i], result[i], "UInts Array item mismatch at index " + i)
		Next
	End Method

	Method testLongArray() { test }
		Local longs:Long[] = [-9223372036854775808:Long, 1:Long, 2:Long, 3:Long, 4:Long, 5:Long, 6:Long, 7:Long, 8:Long, 9:Long, 9223372036854775807:Long]
		
		Local s:String = persist.SerializeToString(longs)

		persist.Free()
		
		Local result:Long[] = Long[](persist.DeserializeObject(s))

		AssertEquals(longs.Length, result.Length, "Longs Array length mismatch")
		For Local i:Int = 0 Until longs.Length
			AssertEquals(longs[i], result[i], "Longs Array item mismatch at index " + i)
		Next
	End Method

	Method testULongArray() { test }
		Local ulongs:ULong[] = [0:ULong, 1:ULong, 2:ULong, 3:ULong, 4:ULong, 5:ULong, 6:ULong, 7:ULong, 8:ULong, 9:ULong, 18446744073709551615:ULong]
		
		Local s:String = persist.SerializeToString(ulongs)

		persist.Free()
		
		Local result:ULong[] = ULong[](persist.DeserializeObject(s))

		AssertEquals(ulongs.Length, result.Length, "ULongs Array length mismatch")
		For Local i:Int = 0 Until ulongs.Length
			AssertEquals(ulongs[i], result[i], "ULongs Array item mismatch at index " + i)
		Next
	End Method

' ?ptr32
' 	Method testSizeTArray() { test }
' 		Local sizets:Size_T[] = [0:Size_T, 1:Size_T, 2:Size_T, 3:Size_T, 4:Size_T, 5:Size_T, 6:Size_T, 7:Size_T, 8:Size_T, 9:Size_T, 4294967295:Size_T]
		
' 		Local s:String = persist.SerializeToString(sizets)

' 		persist.Free()
		
' 		Local result:Size_T[] = Size_T[](persist.DeserializeObject(sizets))

' 		AssertEquals(sizets.Length, result.Length, "Size_Ts Array length mismatch")
' 		For Local i:Int = 0 Until sizets.Length
' 			AssertEquals(sizets[i], result[i], "Size_Ts Array item mismatch at index " + i)
' 		Next
' 	End Method
' ?ptr64
	' Method testSizeTArray() { test }
	' 	Local sizets:Size_T[] = [0:Size_T, 1:Size_T, 2:Size_T, 3:Size_T, 4:Size_T, 5:Size_T, 6:Size_T, 7:Size_T, 8:Size_T, 9:Size_T, 18446744073709551615:Size_T]
		
	' 	Local s:String = persist.SerializeToString(sizets)

	' 	persist.Free()
		
	' 	Local result:Size_T[] = Size_T[](persist.DeserializeObject(sizets))

	' 	AssertEquals(sizets.Length, result.Length, "Size_Ts Array length mismatch")
	' 	For Local i:Int = 0 Until sizets.Length
	' 		AssertEquals(sizets[i], result[i], "Size_Ts Array item mismatch at index " + i)
	' 	Next
	' End Method
' ?

	Method testLongIntArray() { test }
		Local longints:LongInt[] = [-2147483648:LongInt, 1:LongInt, 2:LongInt, 3:LongInt, 4:LongInt, 5:LongInt, 6:LongInt, 7:LongInt, 8:LongInt, 9:LongInt, 2147483647:LongInt]
		
		Local s:String = persist.SerializeToString(longints)

		persist.Free()
		
		Local result:LongInt[] = LongInt[](persist.DeserializeObject(s))

		AssertEquals(longints.Length, result.Length, "LongInts Array length mismatch")
		For Local i:Int = 0 Until longints.Length
			AssertEquals(longints[i], result[i], "LongInts Array item mismatch at index " + i)
		Next
	End Method

	Method testULongIntArray() { test }
		Local ulongints:ULongInt[] = [0:ULongInt, 1:ULongInt, 2:ULongInt, 3:ULongInt, 4:ULongInt, 5:ULongInt, 6:ULongInt, 7:ULongInt, 8:ULongInt, 9:ULongInt, 4294967295:ULongInt]
		
		Local s:String = persist.SerializeToString(ulongints)

		persist.Free()
		
		Local result:ULongInt[] = ULongInt[](persist.DeserializeObject(s))

		AssertEquals(ulongints.Length, result.Length, "ULongInts Array length mismatch")
		For Local i:Int = 0 Until ulongints.Length
			AssertEquals(ulongints[i], result[i], "ULongInts Array item mismatch at index " + i)
		Next
	End Method

	Method testFloatArray() { test }
		Local floats:Float[] = [-3.4028235E+38:Float, 1.4E-45:Float, 0:Float, 3.4028235E+38:Float]
		
		Local s:String = persist.SerializeToString(floats)

		persist.Free()
		
		Local result:Float[] = Float[](persist.DeserializeObject(s))

		AssertEquals(floats.Length, result.Length, "Floats Array length mismatch")
		For Local i:Int = 0 Until floats.Length
			AssertEquals(floats[i], result[i], 0, "Floats Array item mismatch at index " + i)
		Next
	End Method

	Method testDoubleArray() { test }
		Local doubles:Double[] = [-1.7976931348623157E+17:Double, 4.9406564584124654E-17:Double, 0:Double, 1.7976931348623157E+17:Double]
		
		Local s:String = persist.SerializeToString(doubles)

		persist.Free()
		
		Local result:Double[] = Double[](persist.DeserializeObject(s))

		AssertEquals(doubles.Length, result.Length, "Doubles Array length mismatch")
		For Local i:Int = 0 Until doubles.Length
			AssertEquals(doubles[i], result[i], 0, "Doubles Array item mismatch at index " + i)
		Next
	End Method

End Type
