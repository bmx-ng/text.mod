' Copyright (c) 2025 Bruce A Henderson
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

IncBin "cp932.bin"

Type TEncodingStrategyLoaderWindows932 Extends TEncodingStrategyLoader
	Method Encoding:EStreamEncoding()
		Return EStreamEncoding.WINDOWS_932
	End Method

	Method Load:IEncodingStrategy(stream:TStream)
		Return New TWindows932EncodingStrategy(stream)
	End Method
End Type

Type TWindows932EncodingStrategy Extends TBaseMultiByteEncodingStrategy

	Const CP932_REPLACEMENT:Int = $FFFD

	Field lookahead:Int = -1              ' -1 = empty, otherwise 0..255
    Field table:Short Ptr                 ' 65536 entries (lead<<8|trail) → Unicode (BMP)

    Method New(sourceStream:TStream)
        Super.New(sourceStream)
        
		table = Short Ptr IncBinPtr("cp932.bin")
    End Method

    Method ReadEncodedChar(utf8Char:SUTF8Char Var) Override
        ' fetch first byte (respect lookahead)
        Local b0:Int
        If lookahead >= 0 Then
            b0 = lookahead
            lookahead = -1
        Else
            Local buf:Byte
            If stream.Read(VarPtr buf, 1) = 0 Then
                utf8Char.count = 0
                Return
            End If
            b0 = buf & $FF
        End If

        ' ASCII
        If b0 < $80 Then
            utf8Char.bytes[0] = b0
            utf8Char.count = 1
            Return
        End If

        ' Half-width Katakana (JIS X 0201): 0xA1–0xDF → U+FF61..U+FF9F
        If b0 >= $A1 And b0 <= $DF Then
            Local u:Int = $FF61 + (b0 - $A1)
            EncodeSingleCharacterToUTF8(utf8Char, Short(u))
            Return
        End If

        ' Double-byte lead? (0x81–0x9F, 0xE0–0xFC)
        If (b0 >= $81 And b0 <= $9F) Or (b0 >= $E0 And b0 <= $FC) Then
            ' read trail byte
            Local buf2:Byte
            If stream.Read(VarPtr buf2, 1) = 0 Then
                ' dangling lead at EOF
                EncodeSingleCharacterToUTF8(utf8Char, CP932_REPLACEMENT)
                Return
            End If
            Local b1:Int = buf2 & $FF

            ' Trail must be 0x40–0x7E or 0x80–0xFC (0x7F excluded)
            If b1 = $7F Or ((b1 < $40) Or (b1 > $FC) Or (b1 >= $7F And b1 < $80)) Then
                ' invalid trail -> push back and emit U+FFFD
                lookahead = b1
                EncodeSingleCharacterToUTF8(utf8Char, CP932_REPLACEMENT)
                Return
            End If

            ' Lookup in the 256x256 table: index = (lead<<8)|trail
            Local idx:Int = (b0 Shl 8) | b1
            Local u:Int = table[idx] & $FFFF

            If u = CP932_REPLACEMENT Or u = 0 Then
                u = CP932_REPLACEMENT
            End If

            EncodeSingleCharacterToUTF8(utf8Char, Short(u))
            Return
        End If

        ' Any other single byte is undefined in CP932
        EncodeSingleCharacterToUTF8(utf8Char, CP932_REPLACEMENT)
    End Method
End Type

New TEncodingStrategyLoaderWindows932
