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

Rem
bbdoc: Additional encodings support for BRL.UTF8Stream
about: This adds support for the following encodings :
  - ISO-8859-2
  - ISO-8859-5
  - ISO-8859-6
  - ISO-8859-7
  - ISO-8859-8
  - ISO-8859-9
  - ISO-8859-15
  - Windows-1250
  - Windows-1251
  - Windows-1253
  - Windows-1254
  - Windows-1255
  - Windows-1256
  - Windows-1257
End Rem
Module Text.Encoding

ModuleInfo "Version: 1.00"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: zlib"
ModuleInfo "Copyright: 2023 Bruce A Henderson"

ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release"

Import "codepage.bmx"
Import "iso.bmx"
