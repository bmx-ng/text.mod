' Copyright (c) 2023 Bruce A Henderson
'
' This software is provided 'as-is', without any express or implied
' warranty. In no event will the authors be held liable for any damages
' arising from the use of this software.
' 
' Permission is granted to anyone to use this software for any purpose,
' including commercial applications, and to alter it and redistribute it
' freely, subject to the following restrictions:
' 
'    1. The origin of this software must not be misrepresented; you must not
'    claim that you wrote the original software. If you use this software
'    in a product, an acknowledgment in the product documentation would be
'    appreciated but is not required.
' 
'    2. Altered source versions must be plainly marked as such, and must not be
'    misrepresented as being the original software.
' 
'    3. This notice may not be removed or altered from any source
'    distribution.
' 
SuperStrict

Import BRL.UTF8Stream


Type TEncodingStrategyLoaderISO_8859_2 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.ISO_8859_2
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TISO_8859_2_EncodingStrategy(stream)
	End Method
End Type

Type TISO_8859_2_EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$0080:Short, $0081:Short, $0082:Short, $0083:Short, $0084:Short, $0085:Short, $0086:Short, $0087:Short, $0088:Short, $0089:Short, $008A:Short, $008B:Short, $008C:Short, $008D:Short, $008E:Short, $008F:Short,..
				$0090:Short, $0091:Short, $0092:Short, $0093:Short, $0094:Short, $0095:Short, $0096:Short, $0097:Short, $0098:Short, $0099:Short, $009A:Short, $009B:Short, $009C:Short, $009D:Short, $009E:Short, $009F:Short,..
				$00A0:Short, $0104:Short, $02D8:Short, $0141:Short, $00A4:Short, $013D:Short, $015A:Short, $00A7:Short, $00A8:Short, $0160:Short, $015E:Short, $0164:Short, $0179:Short, $00AD:Short, $017D:Short, $017B:Short,..
				$00B0:Short, $0105:Short, $02DB:Short, $0142:Short, $00B4:Short, $013E:Short, $015B:Short, $02C7:Short, $00B8:Short, $0161:Short, $015F:Short, $0165:Short, $017A:Short, $02DD:Short, $017E:Short, $017C:Short,..
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


Type TEncodingStrategyLoaderISO_8859_5 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.ISO_8859_5
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TISO_8859_5_EncodingStrategy(stream)
	End Method
End Type


Type TISO_8859_5_EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$0080:Short, $0081:Short, $0082:Short, $0083:Short, $0084:Short, $0085:Short, $0086:Short, $0087:Short, $0088:Short, $0089:Short, $008A:Short, $008B:Short, $008C:Short, $008D:Short, $008E:Short, $008F:Short,..
				$0090:Short, $0091:Short, $0092:Short, $0093:Short, $0094:Short, $0095:Short, $0096:Short, $0097:Short, $0098:Short, $0099:Short, $009A:Short, $009B:Short, $009C:Short, $009D:Short, $009E:Short, $009F:Short,..
				$00A0:Short, $0401:Short, $0402:Short, $0403:Short, $0404:Short, $0405:Short, $0406:Short, $0407:Short, $0408:Short, $0409:Short, $040A:Short, $040B:Short, $040C:Short, $00AD:Short, $040E:Short, $040F:Short,..
				$0410:Short, $0411:Short, $0412:Short, $0413:Short, $0414:Short, $0415:Short, $0416:Short, $0417:Short, $0418:Short, $0419:Short, $041A:Short, $041B:Short, $041C:Short, $041D:Short, $041E:Short, $041F:Short,..
				$0420:Short, $0421:Short, $0422:Short, $0423:Short, $0424:Short, $0425:Short, $0426:Short, $0427:Short, $0428:Short, $0429:Short, $042A:Short, $042B:Short, $042C:Short, $042D:Short, $042E:Short, $042F:Short,..
				$0430:Short, $0431:Short, $0432:Short, $0433:Short, $0434:Short, $0435:Short, $0436:Short, $0437:Short, $0438:Short, $0439:Short, $043A:Short, $043B:Short, $043C:Short, $043D:Short, $043E:Short, $043F:Short,..
				$0440:Short, $0441:Short, $0442:Short, $0443:Short, $0444:Short, $0445:Short, $0446:Short, $0447:Short, $0448:Short, $0449:Short, $044A:Short, $044B:Short, $044C:Short, $044D:Short, $044E:Short, $044F:Short,..
				$2116:Short, $0451:Short, $0452:Short, $0453:Short, $0454:Short, $0455:Short, $0456:Short, $0457:Short, $0458:Short, $0459:Short, $045A:Short, $045B:Short, $045C:Short, $00A7:Short, $045E:Short, $045F:Short]
        End If

        For Local i:Int = 0 To 127
            table[i] = encodingTable[i]
        Next
    End Method
End Type

Type TEncodingStrategyLoaderISO_8859_6 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.ISO_8859_6
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TISO_8859_6_EncodingStrategy(stream)
	End Method
End Type


Type TISO_8859_6_EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$0080:Short, $0081:Short, $0082:Short, $0083:Short, $0084:Short, $0085:Short, $0086:Short, $0087:Short, $0088:Short, $0089:Short, $008A:Short, $008B:Short, $008C:Short, $008D:Short, $008E:Short, $008F:Short,..
				$0090:Short, $0091:Short, $0092:Short, $0093:Short, $0094:Short, $0095:Short, $0096:Short, $0097:Short, $0098:Short, $0099:Short, $009A:Short, $009B:Short, $009C:Short, $009D:Short, $009E:Short, $009F:Short,..
				$00A0:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $00A4:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $060C:Short, $00AD:Short, $FFFD:Short, $FFFD:Short,..
				$FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $061B:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $061F:Short,..
				$FFFD:Short, $0621:Short, $0622:Short, $0623:Short, $0624:Short, $0625:Short, $0626:Short, $0627:Short, $0628:Short, $0629:Short, $062A:Short, $062B:Short, $062C:Short, $062D:Short, $062E:Short, $062F:Short,..
				$0630:Short, $0631:Short, $0632:Short, $0633:Short, $0634:Short, $0635:Short, $0636:Short, $0637:Short, $0638:Short, $0639:Short, $063A:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short,..
				$0640:Short, $0641:Short, $0642:Short, $0643:Short, $0644:Short, $0645:Short, $0646:Short, $0647:Short, $0648:Short, $0649:Short, $064A:Short, $064B:Short, $064C:Short, $064D:Short, $064E:Short, $064F:Short,..
				$0650:Short, $0651:Short, $0652:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short]
        End If

        For Local i:Int = 0 To 127
            table[i] = encodingTable[i]
        Next
    End Method
End Type

Type TEncodingStrategyLoaderISO_8859_7 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.ISO_8859_7
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TISO_8859_7_EncodingStrategy(stream)
	End Method
End Type

Type TISO_8859_7_EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$0080:Short, $0081:Short, $0082:Short, $0083:Short, $0084:Short, $0085:Short, $0086:Short, $0087:Short, $0088:Short, $0089:Short, $008A:Short, $008B:Short, $008C:Short, $008D:Short, $008E:Short, $008F:Short,..
				$0090:Short, $0091:Short, $0092:Short, $0093:Short, $0094:Short, $0095:Short, $0096:Short, $0097:Short, $0098:Short, $0099:Short, $009A:Short, $009B:Short, $009C:Short, $009D:Short, $009E:Short, $009F:Short,..
				$00A0:Short, $2018:Short, $2019:Short, $00A3:Short, $20AC:Short, $20AF:Short, $00A6:Short, $00A7:Short, $00A8:Short, $00A9:Short, $037A:Short, $00AB:Short, $00AC:Short, $00AD:Short, $FFFD:Short, $2015:Short,..
				$00B0:Short, $00B1:Short, $00B2:Short, $00B3:Short, $0384:Short, $0385:Short, $0386:Short, $00B7:Short, $0388:Short, $0389:Short, $038A:Short, $00BB:Short, $038C:Short, $00BD:Short, $038E:Short, $038F:Short,..
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

Type TEncodingStrategyLoaderISO_8859_8 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.ISO_8859_8
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TISO_8859_8_EncodingStrategy(stream)
	End Method
End Type

Type TISO_8859_8_EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$0080:Short, $0081:Short, $0082:Short, $0083:Short, $0084:Short, $0085:Short, $0086:Short, $0087:Short, $0088:Short, $0089:Short, $008A:Short, $008B:Short, $008C:Short, $008D:Short, $008E:Short, $008F:Short,..
				$0090:Short, $0091:Short, $0092:Short, $0093:Short, $0094:Short, $0095:Short, $0096:Short, $0097:Short, $0098:Short, $0099:Short, $009A:Short, $009B:Short, $009C:Short, $009D:Short, $009E:Short, $009F:Short,..
				$00A0:Short, $FFFD:Short, $00A2:Short, $00A3:Short, $00A4:Short, $00A5:Short, $00A6:Short, $00A7:Short, $00A8:Short, $00A9:Short, $00D7:Short, $00AB:Short, $00AC:Short, $00AD:Short, $00AE:Short, $00AF:Short,..
				$00B0:Short, $00B1:Short, $00B2:Short, $00B3:Short, $00B4:Short, $00B5:Short, $00B6:Short, $00B7:Short, $00B8:Short, $00B9:Short, $00F7:Short, $00BB:Short, $00BC:Short, $00BD:Short, $00BE:Short, $FFFD:Short,..
				$FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short,..
				$FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $FFFD:Short, $2017:Short,..
				$05D0:Short, $05D1:Short, $05D2:Short, $05D3:Short, $05D4:Short, $05D5:Short, $05D6:Short, $05D7:Short, $05D8:Short, $05D9:Short, $05DA:Short, $05DB:Short, $05DC:Short, $05DD:Short, $05DE:Short, $05DF:Short,..
				$05E0:Short, $05E1:Short, $05E2:Short, $05E3:Short, $05E4:Short, $05E5:Short, $05E6:Short, $05E7:Short, $05E8:Short, $05E9:Short, $05EA:Short, $FFFD:Short, $FFFD:Short, $200E:Short, $200F:Short, $FFFD:Short]
        End If

        For Local i:Int = 0 To 127
            table[i] = encodingTable[i]
        Next
    End Method
End Type

Type TEncodingStrategyLoaderISO_8859_9 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.ISO_8859_9
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TISO_8859_9_EncodingStrategy(stream)
	End Method
End Type

Type TISO_8859_9_EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$0080:Short, $0081:Short, $0082:Short, $0083:Short, $0084:Short, $0085:Short, $0086:Short, $0087:Short, $0088:Short, $0089:Short, $008A:Short, $008B:Short, $008C:Short, $008D:Short, $008E:Short, $008F:Short,..
				$0090:Short, $0091:Short, $0092:Short, $0093:Short, $0094:Short, $0095:Short, $0096:Short, $0097:Short, $0098:Short, $0099:Short, $009A:Short, $009B:Short, $009C:Short, $009D:Short, $009E:Short, $009F:Short,..
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

Type TEncodingStrategyLoaderISO_8859_15 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.ISO_8859_15
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TISO_8859_15_EncodingStrategy(stream)
	End Method
End Type

Type TISO_8859_15_EncodingStrategy Extends TBaseSingleByteEncodingStrategy
    Method New(sourceStream:TStream)
        stream = sourceStream
        LoadMapping()
    End Method

    Method LoadTable(table:Short Ptr)
        Global encodingTable:Short[]
        If Not encodingTable Then
            encodingTable = [..
				$0080:Short, $0081:Short, $0082:Short, $0083:Short, $0084:Short, $0085:Short, $0086:Short, $0087:Short, $0088:Short, $0089:Short, $008A:Short, $008B:Short, $008C:Short, $008D:Short, $008E:Short, $008F:Short,..
				$0090:Short, $0091:Short, $0092:Short, $0093:Short, $0094:Short, $0095:Short, $0096:Short, $0097:Short, $0098:Short, $0099:Short, $009A:Short, $009B:Short, $009C:Short, $009D:Short, $009E:Short, $009F:Short,..
				$00A0:Short, $00A1:Short, $00A2:Short, $00A3:Short, $20AC:Short, $00A5:Short, $0160:Short, $00A7:Short, $0161:Short, $00A9:Short, $00AA:Short, $00AB:Short, $00AC:Short, $00AD:Short, $00AE:Short, $00AF:Short,..
				$00B0:Short, $00B1:Short, $00B2:Short, $00B3:Short, $017D:Short, $00B5:Short, $00B6:Short, $00B7:Short, $017E:Short, $00B9:Short, $00BA:Short, $00BB:Short, $0152:Short, $0153:Short, $0178:Short, $00BF:Short,..
				$00C0:Short, $00C1:Short, $00C2:Short, $00C3:Short, $00C4:Short, $00C5:Short, $00C6:Short, $00C7:Short, $00C8:Short, $00C9:Short, $00CA:Short, $00CB:Short, $00CC:Short, $00CD:Short, $00CE:Short, $00CF:Short,..
				$00D0:Short, $00D1:Short, $00D2:Short, $00D3:Short, $00D4:Short, $00D5:Short, $00D6:Short, $00D7:Short, $00D8:Short, $00D9:Short, $00DA:Short, $00DB:Short, $00DC:Short, $00DD:Short, $00DE:Short, $00DF:Short,..
				$00E0:Short, $00E1:Short, $00E2:Short, $00E3:Short, $00E4:Short, $00E5:Short, $00E6:Short, $00E7:Short, $00E8:Short, $00E9:Short, $00EA:Short, $00EB:Short, $00EC:Short, $00ED:Short, $00EE:Short, $00EF:Short,..
				$00F0:Short, $00F1:Short, $00F2:Short, $00F3:Short, $00F4:Short, $00F5:Short, $00F6:Short, $00F7:Short, $00F8:Short, $00F9:Short, $00FA:Short, $00FB:Short, $00FC:Short, $00FD:Short, $00FE:Short, $00FF:Short]
        End If

        For Local i:Int = 0 To 127
            table[i] = encodingTable[i]
        Next
    End Method
End Type


New TEncodingStrategyLoaderISO_8859_2
New TEncodingStrategyLoaderISO_8859_5
New TEncodingStrategyLoaderISO_8859_6
New TEncodingStrategyLoaderISO_8859_7
New TEncodingStrategyLoaderISO_8859_8
New TEncodingStrategyLoaderISO_8859_9
New TEncodingStrategyLoaderISO_8859_15
