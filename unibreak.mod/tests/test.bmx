SuperStrict

Framework BRL.StandardIO
Import BRL.MaxUnit
Import Text.Unibreak

New TTestSuite.Run()

Type TUnibreakTest Extends TTest
	Method TestMapSelection() { test }
		Local provider:TTextBoundaryProvider=GetTextBoundaryProvider()
		For Local value:String=EachIn ["", "one two"]
			Local all:TTextBoundaries=provider.Analyze(value)
			AssertEquals(value.Length+1,all.lineBreaks.Length)
			AssertEquals(value.Length+1,all.wordBreaks.Length)
			AssertEquals(value.Length+1,all.graphemeBreaks.Length)
			Local selections:ETextBoundaryMaps[] = [ETextBoundaryMaps.None, ETextBoundaryMaps.Line, ETextBoundaryMaps.Word, ETextBoundaryMaps.Grapheme, ETextBoundaryMaps.Line | ETextBoundaryMaps.Word, ETextBoundaryMaps.Line | ETextBoundaryMaps.Grapheme, ETextBoundaryMaps.Word | ETextBoundaryMaps.Grapheme, ETextBoundaryMaps.All]
			For Local maps:ETextBoundaryMaps=EachIn selections
				Local result:TTextBoundaries=provider.Analyze(value,"",maps)
				If (maps & ETextBoundaryMaps.Line) <> ETextBoundaryMaps.None Then
					AssertEquals(value.Length+1,result.lineBreaks.Length)
					For Local i:Int=0 To value.Length
						AssertEquals(Int(all.lineBreaks[i]),Int(result.lineBreaks[i]))
					Next
				Else
					AssertTrue(result.lineBreaks=Null)
				End If
				If (maps & ETextBoundaryMaps.Word) <> ETextBoundaryMaps.None Then
					AssertEquals(value.Length+1,result.wordBreaks.Length)
					For Local i:Int=0 To value.Length
						AssertEquals(Int(all.wordBreaks[i]),Int(result.wordBreaks[i]))
					Next
				Else
					AssertTrue(result.wordBreaks=Null)
				End If
				If (maps & ETextBoundaryMaps.Grapheme) <> ETextBoundaryMaps.None Then
					AssertEquals(value.Length+1,result.graphemeBreaks.Length)
					For Local i:Int=0 To value.Length
						AssertEquals(Int(all.graphemeBreaks[i]),Int(result.graphemeBreaks[i]))
					Next
				Else
					AssertTrue(result.graphemeBreaks=Null)
				End If
			Next
		Next
	End Method
	Method TestRegistrationAndOffsets() { test }
		AssertTrue(UnicodeTextBoundariesAvailable())
		Local breaks:Byte[]=UnibreakLineBreaks("a b")
		AssertEquals(4,breaks.Length)
		AssertEquals(0,Int(breaks[0]));AssertEquals(0,Int(breaks[1]))
		AssertEquals(TEXT_BOUNDARY_ALLOWED,Int(breaks[2]))
		AssertTrue(breaks[3]<>0)
	End Method
	Method TestGraphemes() { test }
		Local breaks:Byte[]=UnibreakGraphemeBreaks("a"+Chr($301)+"b")
		AssertTrue(breaks[0]);AssertFalse(breaks[1]);AssertTrue(breaks[2]);AssertTrue(breaks[3])
		Local units:Short[]=[$d83d:Short,$dc69:Short,$200d:Short,$d83d:Short,$dcbb:Short]
		Local emoji:String=String.FromShorts(units,units.Length)
		breaks=UnibreakGraphemeBreaks(emoji)
		For Local i:Int=1 Until emoji.Length
			AssertFalse(breaks[i])
		Next
		AssertTrue(breaks[emoji.Length])
	End Method
	Method TestMandatoryAndNonbreaking() { test }
		Local breaks:Byte[]=UnibreakLineBreaks("a~r~nb")
		AssertEquals(TEXT_BOUNDARY_NONE,Int(breaks[2]))
		AssertEquals(TEXT_BOUNDARY_MANDATORY,Int(breaks[3]))
		breaks=UnibreakLineBreaks("a"+Chr($a0)+"b")
		AssertFalse(breaks[1]);AssertFalse(breaks[2])
		breaks=UnibreakLineBreaks("a"+Chr($2060)+"b")
		AssertFalse(breaks[1]);AssertFalse(breaks[2])
	End Method
	Method TestEmptyAndEmbeddedNull() { test }
		AssertEquals(1,UnibreakLineBreaks("").Length)
		AssertTrue(UnibreakGraphemeBreaks("")[0])
		Local units:Short[]=[65:Short,0:Short,66:Short]
		Local value:String=String.FromShorts(units,units.Length)
		AssertEquals(4,UnibreakWordBreaks(value).Length)
		AssertTrue(UnibreakGraphemeBreaks(value)[3])
	End Method
	Method TestWordBoundariesAndSnapshot() { test }
		Local provider:TTextBoundaryProvider=GetTextBoundaryProvider()
		Local result:TTextBoundaries=provider.Analyze("one two")
		AssertTrue(result.wordBreaks[0]);AssertTrue(result.wordBreaks[3]);AssertTrue(result.wordBreaks[4]);AssertTrue(result.wordBreaks[7])
		RegisterTextBoundaryProvider(Null)
		AssertFalse(UnicodeTextBoundariesAvailable())
		AssertTrue(result.wordBreaks[4])
		RegisterTextBoundaryProvider(provider)
	End Method
End Type
