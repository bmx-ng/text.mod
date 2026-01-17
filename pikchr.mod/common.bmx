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
' 1. The origin of this software must not be misrepresented; you must not
'    claim that you wrote the original software. If you use this software
'    in a product, an acknowledgment in the product documentation would be
'    appreciated but is not required.
' 2. Altered source versions must be plainly marked as such, and must not be
'    misrepresented as being the original software.
' 3. This notice may not be removed or altered from any source distribution.
' 
SuperStrict

Import "pikchr/*.h"
Import "pikchr/pikchr.c"

Rem
bbdoc: Pikchr Flags
about: Flags used to control Pikchr rendering.

| Flag | Description |
|------|-------------|
| NONE | No special flags. |
| PLAINTEXT_ERRORS | Normally, the text returned in the event of an error is formatted as HTML. Setting this flag causes the error message to be plain text. |
| DARK_MODE | Inverts the colors in the diagram to make them suitable for "dark mode" pages. |

End Rem
Enum EPikChrFlags:UInt Flags
	NONE
	PLAINTEXT_ERRORS = $0001
	DARK_MODE = $0002
End Enum
