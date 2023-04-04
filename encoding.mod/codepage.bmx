SuperStrict

Import BRL.UTF8Stream

Type TEncodingStrategyLoaderWindows1250 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.WINDOWS_1250
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TWindows1250EncodingStrategy(stream)
	End Method
End Type

Type TWindows1250EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

	Method LoadTable(table:Short Ptr)
		Global encodingTable:Short[]
		If Not encodingTable Then
			encodingTable = [..
				$20AC:Short, $FFFD:Short, $201A:Short, $FFFD:Short, $201E:Short, $2026:Short, $2020:Short, $2021:Short, $FFFD:Short, $2030:Short, $0160:Short, $2039:Short, $015A:Short, $0164:Short, $017D:Short, $0179:Short,..
				$FFFD:Short, $2018:Short, $2019:Short, $201C:Short, $201D:Short, $2022:Short, $2013:Short, $2014:Short, $FFFD:Short, $2122:Short, $0161:Short, $203A:Short, $015B:Short, $0165:Short, $017E:Short, $017A:Short,..
				$00A0:Short, $02C7:Short, $02D8:Short, $0141:Short, $00A4:Short, $0104:Short, $00A6:Short, $00A7:Short, $00A8:Short, $00A9:Short, $015E:Short, $00AB:Short, $00AC:Short, $00AD:Short, $00AE:Short, $017B:Short,..
				$00B0:Short, $00B1:Short, $02DB:Short, $0142:Short, $00B4:Short, $00B5:Short, $00B6:Short, $00B7:Short, $00B8:Short, $0105:Short, $015F:Short, $00BB:Short, $013D:Short, $02DD:Short, $013E:Short, $017C:Short,..
				$0154:Short, $00C1:Short, $00C2:Short, $0102:Short, $00C4:Short, $0139:Short, $0106:Short, $00C7:Short, $010C:Short, $00C9:Short, $0118:Short, $00CB:Short, $011A:Short, $00CD:Short, $00CE:Short, $010E:Short,..
				$0110:Short, $0143:Short, $0147:Short, $00D3:Short, $00D4:Short, $0150:Short, $00D6:Short, $00D7:Short, $0158:Short, $016E:Short, $00DA:Short, $0170:Short, $00DC:Short, $00DD:Short, $0162:Short, $00DF:Short,..
				$0155:Short, $00E1:Short, $00E2:Short, $0103:Short, $00E4:Short, $013A:Short, $0107:Short, $00E7:Short, $010D:Short, $00E9:Short, $0119:Short, $00EB:Short, $011B:Short, $00ED:Short, $00EE:Short, $010F:Short,..
				$0111:Short, $0144:Short, $0148:Short, $00F3:Short, $00F4:Short, $0151:Short, $00F6:Short, $00F7:Short, $0159:Short, $016F:Short, $00FA:Short, $0171:Short, $00FC:Short, $00FD:Short, $0163:Short, $02D9:Short]
		End If

		For Local i:Int = 0 To 127
			table[i] = encodingTable[i]
		Next
	End Method
End Type

Type TEncodingStrategyLoaderWindows1251 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.WINDOWS_1251
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TWindows1251EncodingStrategy(stream)
	End Method
End Type

Type TWindows1251EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$0402:Short, $0403:Short, $201A:Short, $0453:Short, $201E:Short, $2026:Short, $2020:Short, $2021:Short, $20AC:Short, $2030:Short, $0409:Short, $2039:Short, $040A:Short, $040C:Short, $040B:Short, $040F:Short,..
				$0452:Short, $2018:Short, $2019:Short, $201C:Short, $201D:Short, $2022:Short, $2013:Short, $2014:Short, $FFFD:Short, $2122:Short, $0459:Short, $203A:Short, $045A:Short, $045C:Short, $045B:Short, $045F:Short,..
				$00A0:Short, $040E:Short, $045E:Short, $0408:Short, $00A4:Short, $0490:Short, $00A6:Short, $00A7:Short, $0401:Short, $00A9:Short, $0404:Short, $00AB:Short, $00AC:Short, $00AD:Short, $00AE:Short, $0407:Short,..
				$00B0:Short, $00B1:Short, $0406:Short, $0456:Short, $0491:Short, $00B5:Short, $00B6:Short, $00B7:Short, $0451:Short, $2116:Short, $0454:Short, $00BB:Short, $0458:Short, $0405:Short, $0455:Short, $0457:Short,..
				$0410:Short, $0411:Short, $0412:Short, $0413:Short, $0414:Short, $0415:Short, $0416:Short, $0417:Short, $0418:Short, $0419:Short, $041A:Short, $041B:Short, $041C:Short, $041D:Short, $041E:Short, $041F:Short,..
				$0420:Short, $0421:Short, $0422:Short, $0423:Short, $0424:Short, $0425:Short, $0426:Short, $0427:Short, $0428:Short, $0429:Short, $042A:Short, $042B:Short, $042C:Short, $042D:Short, $042E:Short, $042F:Short,..
				$0430:Short, $0431:Short, $0432:Short, $0433:Short, $0434:Short, $0435:Short, $0436:Short, $0437:Short, $0438:Short, $0439:Short, $043A:Short, $043B:Short, $043C:Short, $043D:Short, $043E:Short, $043F:Short,..
				$0440:Short, $0441:Short, $0442:Short, $0443:Short, $0444:Short, $0445:Short, $0446:Short, $0447:Short, $0448:Short, $0449:Short, $044A:Short, $044B:Short, $044C:Short, $044D:Short, $044E:Short, $044F:Short]
        End If

        For Local i:Int = 0 To 127
            table[i] = encodingTable[i]
        Next
    End Method
End Type

Type TEncodingStrategyLoaderWindows1253 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.WINDOWS_1253
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TWindows1253EncodingStrategy(stream)
	End Method
End Type

Type TWindows1253EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$20AC:Short, $FFFD:Short, $201A:Short, $0192:Short, $201E:Short, $2026:Short, $2020:Short, $2021:Short, $FFFD:Short, $2030:Short, $FFFD:Short, $2039:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short,..
				$FFFD:Short, $2018:Short, $2019:Short, $201C:Short, $201D:Short, $2022:Short, $2013:Short, $2014:Short, $FFFD:Short, $2122:Short, $FFFD:Short, $203A:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short,..
				$00A0:Short, $0385:Short, $0386:Short, $00A3:Short, $00A4:Short, $00A5:Short, $00A6:Short, $00A7:Short, $00A8:Short, $00A9:Short, $FFFD:Short, $00AB:Short, $00AC:Short, $00AD:Short, $00AE:Short, $2015:Short,..
				$00B0:Short, $00B1:Short, $00B2:Short, $00B3:Short, $0384:Short, $00B5:Short, $00B6:Short, $00B7:Short, $0388:Short, $0389:Short, $038A:Short, $00BB:Short, $038C:Short, $00BD:Short, $038E:Short, $038F:Short,..
				$0390:Short, $0391:Short, $0392:Short, $0393:Short, $0394:Short, $0395:Short, $0396:Short, $0397:Short, $0398:Short, $0399:Short, $039A:Short, $039B:Short, $039C:Short, $039D:Short, $039E:Short, $039F:Short,..
				$03A0:Short, $03A1:Short, $FFFD:Short, $03A3:Short, $03A4:Short, $03A5:Short, $03A6:Short, $03A7:Short, $03A8:Short, $03A9:Short, $03AA:Short, $03AB:Short, $03AC:Short, $03AD:Short, $03AE:Short, $03AF:Short,..
				$03B0:Short, $03B1:Short, $03B2:Short, $03B3:Short, $03B4:Short, $03B5:Short, $03B6:Short, $03B7:Short, $03B8:Short, $03B9:Short, $03BA:Short, $03BB:Short, $03BC:Short, $03BD:Short, $03BE:Short, $03BF:Short,..
				$03C0:Short, $03C1:Short, $03C2:Short, $03C3:Short, $03C4:Short, $03C5:Short, $03C6:Short, $03C7:Short, $03C8:Short, $03C9:Short, $03CA:Short, $03CB:Short, $03CC:Short, $03CD:Short, $03CE:Short, $FFFD:Short]
        End If

        For Local i:Int = 0 To 127
            table[i] = encodingTable[i]
        Next
    End Method
End Type

Type TEncodingStrategyLoaderWindows1254 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.WINDOWS_1254
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TWindows1254EncodingStrategy(stream)
	End Method
End Type

Type TWindows1254EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$20AC:Short, $FFFD:Short, $201A:Short, $0192:Short, $201E:Short, $2026:Short, $2020:Short, $2021:Short, $02C6:Short, $2030:Short, $0160:Short, $2039:Short, $0152:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short,..
				$FFFD:Short, $2018:Short, $2019:Short, $201C:Short, $201D:Short, $2022:Short, $2013:Short, $2014:Short, $02DC:Short, $2122:Short, $0161:Short, $203A:Short, $0153:Short, $FFFD:Short, $FFFD:Short, $0178:Short,..
				$00A0:Short, $00A1:Short, $00A2:Short, $00A3:Short, $00A4:Short, $00A5:Short, $00A6:Short, $00A7:Short, $00A8:Short, $00A9:Short, $00AA:Short, $00AB:Short, $00AC:Short, $00AD:Short, $00AE:Short, $00AF:Short,..
				$00B0:Short, $00B1:Short, $00B2:Short, $00B3:Short, $00B4:Short, $00B5:Short, $00B6:Short, $00B7:Short, $00B8:Short, $00B9:Short, $00BA:Short, $00BB:Short, $00BC:Short, $00BD:Short, $00BE:Short, $00BF:Short,..
				$00C0:Short, $00C1:Short, $00C2:Short, $00C3:Short, $00C4:Short, $00C5:Short, $00C6:Short, $00C7:Short, $00C8:Short, $00C9:Short, $00CA:Short, $00CB:Short, $00CC:Short, $00CD:Short, $00CE:Short, $00CF:Short,..
				$011E:Short, $00D1:Short, $00D2:Short, $00D3:Short, $00D4:Short, $00D5:Short, $00D6:Short, $00D7:Short, $00D8:Short, $00D9:Short, $00DA:Short, $00DB:Short, $00DC:Short, $0130:Short, $015E:Short, $00DF:Short,..
				$00E0:Short, $00E1:Short, $00E2:Short, $00E3:Short, $00E4:Short, $00E5:Short, $00E6:Short, $00E7:Short, $00E8:Short, $00E9:Short, $00EA:Short, $00EB:Short, $00EC:Short, $00ED:Short, $00EE:Short, $00EF:Short,..
				$011F:Short, $00F1:Short, $00F2:Short, $00F3:Short, $00F4:Short, $00F5:Short, $00F6:Short, $00F7:Short, $00F8:Short, $00F9:Short, $00FA:Short, $00FB:Short, $00FC:Short, $0131:Short, $015F:Short, $00FF:Short]
        End If

        For Local i:Int = 0 To 127
            table[i] = encodingTable[i]
        Next
    End Method
End Type

Type TEncodingStrategyLoaderWindows1255 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.WINDOWS_1255
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TWindows1255EncodingStrategy(stream)
	End Method
End Type

Type TWindows1255EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$20AC:Short, $FFFD:Short, $201A:Short, $0192:Short, $201E:Short, $2026:Short, $2020:Short, $2021:Short, $02C6:Short, $2030:Short, $FFFD:Short, $2039:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short,..
				$FFFD:Short, $2018:Short, $2019:Short, $201C:Short, $201D:Short, $2022:Short, $2013:Short, $2014:Short, $02DC:Short, $2122:Short, $FFFD:Short, $203A:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short,..
				$00A0:Short, $00A1:Short, $00A2:Short, $00A3:Short, $20AA:Short, $00A5:Short, $00A6:Short, $00A7:Short, $00A8:Short, $00A9:Short, $00D7:Short, $00AB:Short, $00AC:Short, $00AD:Short, $00AE:Short, $00AF:Short,..
				$00B0:Short, $00B1:Short, $00B2:Short, $00B3:Short, $00B4:Short, $00B5:Short, $00B6:Short, $00B7:Short, $00B8:Short, $00B9:Short, $00F7:Short, $00BB:Short, $00BC:Short, $00BD:Short, $00BE:Short, $00BF:Short,..
				$05B0:Short, $05B1:Short, $05B2:Short, $05B3:Short, $05B4:Short, $05B5:Short, $05B6:Short, $05B7:Short, $05B8:Short, $05B9:Short, $FFFD:Short, $05BB:Short, $05BC:Short, $05BD:Short, $05BE:Short, $05BF:Short,..
				$05C0:Short, $05C1:Short, $05C2:Short, $05C3:Short, $05F0:Short, $05F1:Short, $05F2:Short, $05F3:Short, $05F4:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short,..
				$05D0:Short, $05D1:Short, $05D2:Short, $05D3:Short, $05D4:Short, $05D5:Short, $05D6:Short, $05D7:Short, $05D8:Short, $05D9:Short, $05DA:Short, $05DB:Short, $05DC:Short, $05DD:Short, $05DE:Short, $05DF:Short,..
				$05E0:Short, $05E1:Short, $05E2:Short, $05E3:Short, $05E4:Short, $05E5:Short, $05E6:Short, $05E7:Short, $05E8:Short, $05E9:Short, $05EA:Short, $FFFD:Short, $FFFD:Short, $200E:Short, $200F:Short, $FFFD:Short]
        End If

        For Local i:Int = 0 To 127
            table[i] = encodingTable[i]
        Next
    End Method
End Type

Type TEncodingStrategyLoaderWindows1256 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.WINDOWS_1256
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TWindows1256EncodingStrategy(stream)
	End Method
End Type

Type TWindows1256EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$20AC:Short, $067E:Short, $201A:Short, $0192:Short, $201E:Short, $2026:Short, $2020:Short, $2021:Short, $02C6:Short, $2030:Short, $0679:Short, $2039:Short, $0152:Short, $0686:Short, $0698:Short, $0688:Short,..
				$06AF:Short, $2018:Short, $2019:Short, $201C:Short, $201D:Short, $2022:Short, $2013:Short, $2014:Short, $06A9:Short, $2122:Short, $0691:Short, $203A:Short, $0153:Short, $200C:Short, $200D:Short, $06BA:Short,..
				$00A0:Short, $060C:Short, $00A2:Short, $00A3:Short, $00A4:Short, $00A5:Short, $00A6:Short, $00A7:Short, $00A8:Short, $00A9:Short, $06BE:Short, $00AB:Short, $00AC:Short, $00AD:Short, $00AE:Short, $00AF:Short,..
				$00B0:Short, $00B1:Short, $00B2:Short, $00B3:Short, $00B4:Short, $00B5:Short, $00B6:Short, $00B7:Short, $00B8:Short, $00B9:Short, $061B:Short, $00BB:Short, $00BC:Short, $00BD:Short, $00BE:Short, $061F:Short,..
				$06C1:Short, $0621:Short, $0622:Short, $0623:Short, $0624:Short, $0625:Short, $0626:Short, $0627:Short, $0628:Short, $0629:Short, $062A:Short, $062B:Short, $062C:Short, $062D:Short, $062E:Short, $062F:Short,..
				$0630:Short, $0631:Short, $0632:Short, $0633:Short, $0634:Short, $0635:Short, $0636:Short, $00D7:Short, $0637:Short, $0638:Short, $0639:Short, $063A:Short, $0640:Short, $0641:Short, $0642:Short, $0643:Short,..
				$00E0:Short, $0644:Short, $00E2:Short, $0645:Short, $0646:Short, $0647:Short, $0648:Short, $00E7:Short, $00E8:Short, $00E9:Short, $00EA:Short, $00EB:Short, $0649:Short, $064A:Short, $00EE:Short, $00EF:Short,..
				$064B:Short, $064C:Short, $064D:Short, $064E:Short, $00F4:Short, $064F:Short, $0650:Short, $00F7:Short, $0651:Short, $00F9:Short, $0652:Short, $00FB:Short, $00FC:Short, $200E:Short, $200F:Short, $06D2:Short]
        End If

        For Local i:Int = 0 To 127
            table[i] = encodingTable[i]
        Next
    End Method
End Type

Type TEncodingStrategyLoaderWindows1257 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.WINDOWS_1257
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TWindows1257EncodingStrategy(stream)
	End Method
End Type

Type TWindows1257EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$20AC:Short, $FFFD:Short, $201A:Short, $FFFD:Short, $201E:Short, $2026:Short, $2020:Short, $2021:Short, $FFFD:Short, $2030:Short, $FFFD:Short, $2039:Short, $FFFD:Short, $00A8:Short, $02C7:Short, $00B8:Short,..
				$FFFD:Short, $2018:Short, $2019:Short, $201C:Short, $201D:Short, $2022:Short, $2013:Short, $2014:Short, $FFFD:Short, $2122:Short, $FFFD:Short, $203A:Short, $FFFD:Short, $00AF:Short, $02DB:Short, $FFFD:Short,..
				$00A0:Short, $FFFD:Short, $00A2:Short, $00A3:Short, $00A4:Short, $FFFD:Short, $00A6:Short, $00A7:Short, $00D8:Short, $00A9:Short, $0156:Short, $00AB:Short, $00AC:Short, $00AD:Short, $00AE:Short, $00C6:Short,..
				$00B0:Short, $00B1:Short, $00B2:Short, $00B3:Short, $00B4:Short, $00B5:Short, $00B6:Short, $00B7:Short, $00F8:Short, $00B9:Short, $0157:Short, $00BB:Short, $00BC:Short, $00BD:Short, $00BE:Short, $00E6:Short,..
				$0104:Short, $012E:Short, $0100:Short, $0106:Short, $00C4:Short, $00C5:Short, $0118:Short, $0112:Short, $010C:Short, $00C9:Short, $0179:Short, $0116:Short, $0122:Short, $0136:Short, $012A:Short, $013B:Short,..
				$0160:Short, $0143:Short, $0145:Short, $00D3:Short, $014C:Short, $00D5:Short, $00D6:Short, $00D7:Short, $0172:Short, $0141:Short, $015A:Short, $016A:Short, $00DC:Short, $017B:Short, $017D:Short, $00DF:Short,..
				$0105:Short, $012F:Short, $0101:Short, $0107:Short, $00E4:Short, $00E5:Short, $0119:Short, $0113:Short, $010D:Short, $00E9:Short, $017A:Short, $0117:Short, $0123:Short, $0137:Short, $012B:Short, $013C:Short,..
				$0161:Short, $0144:Short, $0146:Short, $00F3:Short, $014D:Short, $00F5:Short, $00F6:Short, $00F7:Short, $0173:Short, $0142:Short, $015B:Short, $016B:Short, $00FC:Short, $017C:Short, $017E:Short, $02D9:Short]
        End If

        For Local i:Int = 0 To 127
            table[i] = encodingTable[i]
        Next
    End Method
End Type

New TEncodingStrategyLoaderWindows1250
New TEncodingStrategyLoaderWindows1251
New TEncodingStrategyLoaderWindows1253
New TEncodingStrategyLoaderWindows1254
New TEncodingStrategyLoaderWindows1255
New TEncodingStrategyLoaderWindows1256
New TEncodingStrategyLoaderWindows1257

