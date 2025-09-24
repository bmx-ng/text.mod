SuperStrict

Framework brl.standardio
Import Text.Ini
Import BRL.MaxUnit

New TTestSuite.run()

Type TIniTest Extends TTest

	Method TestFileLoadSave() { test }

		DeleteFile( "test.ini" )

		assertEquals( 0, FileType("test.ini") )

		Local ini:TIni = New TIni

		ini.Set("key1","value1")
		ini.Set("key2","value2")

		ini.Save("test.ini")

		assertEquals( FILETYPE_FILE, FileType("test.ini") )

		Local ini2:TIni = TIni.Load("test.ini")

		assertEquals( "value1", ini2.Get("key1") )
		assertEquals( "value2", ini2.Get("key2") )

	End Method

	Method TestGeneral() { test }

		Local ini:TIni = New TIni

		assertEquals( 1, ini.CountSections() ) ' global section

		Local s0:TIniSection = ini.GetSection(INI_GLOBAL_SECTION)

		assertNotNull(s0)

		s0.AddProperty("key1","value1")
		s0.AddProperty("key2","value2")


		Local s1:TIniSection = ini.AddSection("section1")

		assertEquals( 2, ini.CountSections() )

		s1.AddProperty("key1","value1")
		s1.AddProperty("key2","value2")

		Local s2:TIniSection = ini.AddSection("section2")

		assertEquals( 3, ini.CountSections() )

		s2.AddProperty("key1","value1")
		s2.AddProperty("key2","value2")

		Local stream:TStream = New TByteArrayStream
		ini.Save( stream )

		stream.Seek(0)

		Local ini2:TIni = TIni.Load( stream )

		s0 = ini2.GetSection(INI_GLOBAL_SECTION)

		assertNotNull(s0)

		assertEquals( 2, s0.CountProperties() )

		Local p:TIniProperty = s0.FindProperty("key1")

		assertNotNull(p)
		assertEquals( "value1", p.GetValue() )


		s1 = ini2.FindSection("section1")

		AssertNotNull(s1)

		p = s1.FindProperty("key1")

		AssertNotNull(p)
		assertEquals( "value1", p.GetValue() )

		p = s1.FindProperty("key2")

		AssertNotNull(p)
		assertEquals( "value2", p.GetValue() )

		assertEquals( "value1", ini2.Get("section2","key1") )
		assertEquals( "value2", ini2.Get("section2","key2") )

		ini2.Set("section1","key1","value3")
		ini2.Set("section1","key2","value4")
		ini2.Set("section2","key1","value3")
		ini2.Set("section2","key2","value4")

		stream = New TByteArrayStream
		ini2.Save( stream )

		stream.Seek(0)

		ini = TIni.Load( stream )

		assertEquals( "value3", ini.Get("section1","key1") )
		assertEquals( "value4", ini.Get("section1","key2") )
		assertEquals( "value3", ini.Get("section2","key1") )
		assertEquals( "value4", ini.Get("section2","key2") )

		ini.Set("section1","key1","value5")
		ini.Set("section1","key2","value6")
		ini.Set("section2","key1","value5")
		ini.Set("section2","key2","value6")

		stream = New TByteArrayStream
		ini.Save( stream )

		stream.Seek(0)

		ini2 = TIni.Load( stream )

		assertEquals( "value5", ini2.Get("section1","key1") )
		assertEquals( "value6", ini2.Get("section1","key2") )
		assertEquals( "value5", ini2.Get("section2","key1") )
		assertEquals( "value6", ini2.Get("section2","key2") )

	End Method

	Method TestSetNames() { test }
		
		Local ini:TIni = New TIni

		Local s1:TIniSection = ini.AddSection("section1")
		Local p1:TIniProperty = s1.AddProperty("key1","value1")
		Local p2:TIniProperty = s1.AddProperty("key2","value2")

		assertEquals( "section1", s1.GetName() )
		assertEquals( "key1", p1.GetName() )
		assertEquals( "key2", p2.GetName() )

		s1.SetName("section3")
	
		assertEquals( "section3", s1.GetName() )

		p1.SetName("key3")

		assertEquals( "key3", p1.GetName() )

		p2.SetName("key4")

		assertEquals( "key4", p2.GetName() )

	End Method

	Method TestIndexes() { test }

		Local ini:TIni = New TIni

		Local s1:TIniSection = ini.AddSection("section1")
		Local p1:TIniProperty = s1.AddProperty("key1","value1")
		Local p2:TIniProperty = s1.AddProperty("key2","value2")

		assertEquals( 1, s1.GetIndex() )
		assertEquals( 0, p1.GetIndex() )
		assertEquals( 1, p2.GetIndex() )

		Local s0:TIniSection = ini.GetSection(INI_GLOBAL_SECTION)

		assertEquals( 0, s0.GetIndex() )

		s0.Set("key1","value1")

		Local stream:TStream = New TByteArrayStream
		ini.Save( stream )

		stream.Seek(0)

		Local ini2:TIni = TIni.Load( stream )

		s0 = ini2.GetSection(INI_GLOBAL_SECTION)

		assertEquals( 0, s0.GetIndex() )

		s1 = ini2.GetSection(1)

		assertEquals( "section1", s1.GetName() )

		p1 = s1.GetProperty(0)

		assertEquals( "key1", p1.GetName() )

		p2 = s1.GetProperty(1)

		assertEquals( "key2", p2.GetName() )

	End Method

	Method TestRemove() { test }

		Local ini:TIni = New TIni

		assertEquals( 1, ini.CountSections() ) ' global section

		ini.Set("key1","value1")
		Local p0:TIniProperty = ini.GetSection(INI_GLOBAL_SECTION).FindProperty("key1")

		Local s1:TIniSection = ini.AddSection("section1")
		Local p1:TIniProperty = s1.AddProperty("key1","value1")
		Local p2:TIniProperty = s1.AddProperty("key2","value2")

		assertEquals( 2, ini.CountSections() )
		assertEquals( 2, s1.CountProperties() )

		assertEquals( 0, p1.GetIndex() )
		assertEquals( 1, p2.GetIndex() )

		Local s2:TIniSection = ini.AddSection("section2")

		assertEquals( 2, s2.GetIndex() )

		assertEquals( 3, ini.CountSections() )

		s1.RemoveProperty(p1.GetIndex())

		assertEquals( 0, p2.GetIndex() )

		assertEquals( 1, s1.CountProperties() )

		p2.Remove()

		assertEquals( 0, s1.CountProperties() )

		ini.RemoveSection(s1.GetIndex())

		assertEquals( 2, ini.CountSections() )

		assertEquals( 1, s2.GetIndex() )

		Local s0:TIniSection = ini.GetSection(INI_GLOBAL_SECTION)

		assertEquals( 1, s0.CountProperties() )

		s0.Remove()

		assertEquals( 2, ini.CountSections() )

		s0 = ini.GetSection(INI_GLOBAL_SECTION)

		assertEquals( 0, s0.CountProperties() )

		s2.Remove()

		assertEquals( 1, ini.CountSections() )

	End Method

	Method TestHas() { test }

		Local ini:TIni = New TIni

		Local s1:TIniSection = ini.AddSection("section1")
		Local p1:TIniProperty = s1.AddProperty("key1","value1")
		Local p2:TIniProperty = s1.AddProperty("key2","value2")

		assertTrue( ini.Has("section1", "key1") )
		assertTrue( ini.Has("section1", "key2") )
		assertFalse( ini.Has("section1", "key3") )

		assertTrue( s1.Has("key1") )
		assertTrue( s1.Has("key2") )
		assertFalse( s1.Has("key3") )

	End Method

	Method TestTryGet() { test }

		Local ini:TIni = New TIni

		Local s1:TIniSection = ini.AddSection("section1")
		Local p1:TIniProperty = s1.AddProperty("key1","value1")
		Local p2:TIniProperty = s1.AddProperty("key2","value2")
		Local p3:TIniProperty = s1.AddProperty("key4","")

		Local value:String

		assertTrue( ini.TryGet("section1", "key1", value) )
		assertEquals( "value1", value )

		value = ""
		assertTrue( ini.TryGet("section1", "key2", value) )
		assertEquals( "value2", value )

		value = ""
		assertFalse( ini.TryGet("section1", "key3", value) )
		assertEquals( "", value )

		value = ""
		assertTrue( ini.TryGet("section1", "key4", value) )
		assertEquals( "", value )

		value = ""
		assertTrue( s1.TryGet("key1", value) )
		assertEquals( "value1", value )

		value = ""
		assertTrue( s1.TryGet("key2", value) )
		assertEquals( "value2", value )

		value = ""
		assertFalse( s1.TryGet("key3", value) )
		assertEquals( "", value )

		value = ""
		assertTrue( s1.TryGet("key4", value) )
		assertEquals( "", value )
		
	End Method

End Type



Type TByteArrayStream Extends TStream

	Field _data:Byte[]
	Field _pos:Int

	Method New(txt:String)

		Local t:Byte Ptr = txt.ToUTF8String()
		_data = New Byte[txt.Length]
		MemCopy( _data, t, Size_T(txt.Length) )
		MemFree(t)

	End Method

	Method New(data:Byte[])

		Self._data = data

	End Method

	Method Pos:Long() Override
		Return _pos
	End Method

	Method Size:Long() Override
		Return _data.Length
	End Method

	Method Seek:Long( pos:Long, whence:Int = SEEK_SET_ ) Override
		_pos = pos
		Return _pos
	End Method

	Method Read:Long( buf:Byte Ptr,count:Long ) Override
		If _pos+count>_data.Length Then
			count=_data.Length-_pos
		End If

		Local bptr:Byte Ptr = _data
		MemCopy( buf, bptr + _pos, Size_T(count) )

		_pos:+count
		Return count
	End Method

	Method Write:Long( buf:Byte Ptr,count:Long ) Override

		If _pos+count>_data.Length Then
			_data = _data[0.._pos+count]
		End If

		Local bptr:Byte Ptr = _data
		MemCopy( bptr + _pos, buf, Size_T(count) )

		_pos:+count

		Return count
	End Method

	Method Close()
		
	End Method

End Type
