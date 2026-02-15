SuperStrict


Type TNumbers

	Field a:Int
	Field b:Long
	Field c:Float
	Field d:Double
	Field e:Byte
	Field f:Short
	Field g:UInt
	Field h:ULong
	Field i:LongInt
	Field j:ULongInt
	
	Method Create:TNumbers(a:Int, b:Long, c:Float, d:Double, e:Byte, f:Short, g:UInt, h:ULong, i:LongInt, j:ULongInt)
		Self.a = a
		Self.b = b
		Self.c = c
		Self.d = d
		Self.e = e
		Self.f = f
		Self.g = g
		Self.h = h
		Self.i = i
		Self.j = j
		Return Self
	End Method

End Type

Type TStrings

	Field a:String
	Field b:String
	Field c:String

	Method Create:TStrings(a:String, b:String, c:String)
		Self.a = a
		Self.b = b
		Self.c = c
		Return Self
	End Method

End Type

Type TObject

	Field code:Int

	Method Create:TObject(code:Int)
		Self.code = code
		Return Self
	End Method

End Type

Type TObjectContainer

	Field object1:TObject
	Field object2:TObject
	Field object3:TObject

	Method Create:TObjectContainer(object1:TObject, object2:TObject, object3:TObject)
		Self.object1 = object1
		Self.object2 = object2
		Self.object3 = object3
		Return Self
	End Method

End Type

Type TRoom
	Field id:Int
	
	Method Create:TRoom(id:Int)
		Self.Id = id
		Return Self
	End Method
End Type

Type TArrays

	Field bytes:Byte[]
	Field shorts:Short[]
	Field ints:Int[]
	Field uints:UInt[]
	Field longs:Long[]
	Field ulongs:ULong[]
	Field longints:LongInt[]
	Field ulongints:ULongInt[]
	Field sizets:Size_T[]
	Field floats:Float[]
	Field doubles:Double[]

	Method populate()
		bytes = [0:Byte, 1:Byte, 2:Byte, 3:Byte, 4:Byte, 5:Byte, 6:Byte, 7:Byte, 8:Byte, 9:Byte, 255:Byte]
		shorts = [0:Short, 1:Short, 2:Short, 3:Short, 4:Short, 5:Short, 6:Short, 7:Short, 8:Short, 9:Short, 65535:Short]
		ints = [0:Int, 1:Int, 2:Int, 3:Int, 4:Int, 5:Int, 6:Int, 7:Int, 8:Int, 9:Int, 2147483647:Int]
		uints = [0:UInt, 1:UInt, 2:UInt, 3:UInt, 4:UInt, 5:UInt, 6:UInt, 7:UInt, 8:UInt, 9:UInt, 4294967295:UInt]
		longs = [0:Long, 1:Long, 2:Long, 3:Long, 4:Long, 5:Long, 6:Long, 7:Long, 8:Long, 9:Long, 9223372036854775807:Long]
		ulongs = [0:ULong, 1:ULong, 2:ULong, 3:ULong, 4:ULong, 5:ULong, 6:ULong, 7:ULong, 8:ULong, 9:ULong, 18446744073709551615:ULong]
		longints = [0:LongInt, 1:LongInt, 2:LongInt, 3:LongInt, 4:LongInt, 5:LongInt, 6:LongInt, 7:LongInt, 8:LongInt, 9:LongInt, 9223372036854775807:LongInt]
		ulongints = [0:ULongInt, 1:ULongInt, 2:ULongInt, 3:ULongInt, 4:ULongInt, 5:ULongInt, 6:ULongInt, 7:ULongInt, 8:ULongInt, 9:ULongInt, 18446744073709551615:ULongInt]
		sizets = [0:Size_T, 1:Size_T, 2:Size_T, 3:Size_T, 4:Size_T, 5:Size_T, 6:Size_T, 7:Size_T, 8:Size_T, 9:Size_T, 18446744073709551615:Size_T]
		floats = [0.0:Float, 1.0:Float, 2.0:Float, 3.0:Float, 4.0:Float, 5.0:Float, 6.0:Float, 7.0:Float, 8.0:Float, 9.0:Float, 34028235:Float]
		doubles = [0.0:Double, 1.0:Double, 2.0:Double, 3.0:Double, 4.0:Double, 5.0:Double, 6.0:Double, 7.0:Double, 8.0:Double, 9.0:Double, 179769313486231:Double]
	End Method

End Type

