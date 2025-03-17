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

Rem
bbdoc: A PDF encoder.
End Rem
Module Text.PDF

ModuleInfo "Version: 1.01"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: zlib/libpng"
ModuleInfo "libharu - Copyright (c) 1999-2006 Takeshi Kanno"
ModuleInfo "libharu - Copyright (c) 2007-2009 Antony Dovgal"
ModuleInfo "libharu - https://github.com/woollybah/libharu"
ModuleInfo "Copyright: 2023 Bruce A Henderson"

ModuleInfo "History: 1.01"
ModuleInfo "History: Update to libharu.f80dfbc"
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release"

Import "common.bmx"


Rem
bbdoc: A PDF Document
End Rem
Type TPDFDoc
	Private
	Field docPtr:Byte Ptr
	Field pageCount:Int

	Global lastError:TPDFException

	Function _setLastError(error:TPDFException) { nomangle }
		lastError = error
	End Function

	Public
	Method New()
		docPtr = bmx_pdf_HPDF_New()
	End Method

	Rem
	bbdoc: Returns the last PDF error.
	End Rem
	Function GetLastError:TPDFException()
		Return lastError
	End Function
	
	Rem
	bbdoc: Load TrueType font from external .ttf file and register it in the document object.
	about:
	<a href="../examples/load_font.bmx">Example source</a>
	EndRem
	Method LoadTTFontFromFile:String(path:String, embedding:Int=True)
		Local pb:Byte Ptr = path.ToCString()
		Local fb:Byte Ptr = HPDF_LoadTTFontFromFile(docPtr, pb, embedding)
		MemFree(pb)
		
		Local f:String = String.FromCString(fb)
		
		Return f
	EndMethod
	
	Rem
	bbdoc: Gets the requested font object.
	returns: Returns the handle of a font object. Otherwise, it returns #Null and error-handler is called.
	End Rem
	Method GetFont:TPDFFont(fontName:String, encodingName:String = Null)
		Local fontPtr:Byte Ptr

		Local fn:Byte Ptr = fontName.ToUTF8String()
		Local en:Byte Ptr

		If encodingName Then
			en = encodingName.ToUTF8String()
		End If

		Try
			fontPtr = HPDF_GetFont(docPtr, fn, en)
		Finally
			MemFree(en)
			MemFree(fn)
		End Try

		If fontPtr Then
			Return TPDFFont._create(fontPtr)
		End If
		
	End Method

	Rem
	bbdoc: Gets the current page object.
	returns: The current page object. Otherwise it returns #Null.
	End Rem
	Method GetCurrentPage:TPDFPage()
		Local page:Byte Ptr = HPDF_GetCurrentPage(docPtr)
		If page Then
			Return TPDFPage._create(page, self)
		End If
	End Method

	Rem
	bbdoc: Creates a new page and adds it after the last page of a document.
	returns: The created page object on success. Otherwise, it returns #Null and error-handler is called.
	End Rem
	Method AddPage:TPDFPage()
		pageCount :+ 1
		Return TPDFPage._create(HPDF_AddPage(docPtr), Self)
	End Method

	Rem
	bbdoc: Creates a new page and inserts it just before the specified page.
	returns: The created page object on success. Otherwise, it returns #Null and error-handler is called.
	End Rem
	Method InsertPage:TPDFPage(page:TPDFPage)
		pageCount :+ 1
		Return TPDFPage._create(HPDF_InsertPage(docPtr, page.pagePtr), Self)
	End Method

	Rem
	bbdoc: Saves the document.
	End Rem
	Method Save(file:Object)
		Local stream:TStream = TStream(file)
		If Not stream And String(file) Then
			stream = WriteStream(file)
		End If

		HPDF_SaveToStream(docPtr)
		HPDF_ResetStream(docPtr)

		Local buf:Byte[4096]

		While True
			Local size:UInt = 4096
			Local ret:Int = HPDF_ReadFromStream(docPtr, buf, size)

			If size = 0 Then
				Exit
			End If

			ret = stream.Write(buf, size)
			If ret = 0 Then
				Exit
			End If
		Wend

		If String(file) Then
			stream.Close()
		End If
	End Method

	Rem
	bbdoc: Sets the mode of compression.
	returns: #HPDF_OK on success. Otherwise, it returns error code and error-handler is called.
	End Rem
	Method SetCompressionMode:Int(mode:EPDFCompressionMode)
		Return HPDF_SetCompressionMode(docPtr, mode)
	End Method

	Rem
	bbdoc: Creates an extended graphics states object.
	End Rem
	Method CreateExtGState:TPDFExtGState()
		Return TPDFExtGState._create(HPDF_CreateExtGState(docPtr))
	End Method

	Rem
	bbdoc: Creates an extended graphics states object, with the specified @alpha.
	End Rem
	Method CreateExtGStateWithAlpha:TPDFExtGState(alpha:Float)
		Local state:TPDFExtGState = TPDFExtGState._create(HPDF_CreateExtGState(docPtr))
		state.SetAlphaFill(alpha)
		return state
	End Method

	Rem
	bbdoc: Sets a password for the document.
	returns: #HPDF_OK on success. Otherwise, it returns error code and error-handler is called.
	about: If the password is set, document contents are encrypted.
	End Rem
	Method SetPassword:Int(ownerPassword:String, userPassword:String)
		Local o:Byte Ptr
		Local u:Byte Ptr
		If ownerPassword Then
			o = ownerPassword.ToUTF8String()
		End If
		If userPassword Then
			u = userPassword.ToUTF8String()
		End If

		Local ret:Int = HPDF_SetPassword(docPtr, o, u)

		MemFree(u)
		MemFree(o)

		Return ret
	End Method

	Rem
	bbdoc: Sets the permission flags for the document.
	End Rem
	Method SetPermission:Int(permission:UInt)
		Return HPDF_SetPermission(docPtr, permission)
	End Method

	Rem
	bbdoc: Sets the encryption mode.
	returns: #HPDF_OK on success. Otherwise, it returns error code and error-handler is called.
	about: As the side effect, ups the version of PDF to 1.4 when the mode is set to #EPDFEncryptMode.R3.
	End Rem
	Method SetEncryptionMode:Int(mode:EPDFEncryptMode, keyLen:UInt)
		Return HPDF_SetEncryptionMode(docPtr, mode, keyLen)
	End Method

	Rem
	bbdoc: Specifies the number of pages that a "Pages" object can own.
	returns: #HPDF_OK on success. Otherwise, it returns error-code and error-handler is called.
	about: In the default setting, a #TPDFDoc object has one "Pages" object as root of pages. All "Page" objects are created as a kid of the "Pages" object. Since a "Pages" object can own only 8191 kids objects, the maximum number of pages are 8191 page. Additionally, the state that there are a lot of "Page" object under one "Pages" object is not good, because it causes performance degradation of a viewer application.

An application can change the setting of a pages tree by invoking #SetPagesConfiguration(). If @pagePerPages parameter is set to more than zero, a two-tier pages tree is created. A root "Pages" object can own 8191 "Pages" object, and each lower "Pages" object can own @pagePerPages "Page" objects. As a result, the maximum number of pages becomes `8191 * pagePerPages` page. An application cannot invoke #SetPageConfiguration() after a page is added to document.
	End Rem
	Method SetPagesConfiguration:Int(pagePerPages:UInt)
		Return HPDF_SetPagesConfiguration(docPtr, pagePerPages)
	End Method

	Rem
	bbdoc: Sets how the page should be displayed. If this attribute is not set, the setting of the viewer application is used.
	returns: #HPDF_OK on success. Otherwise, it returns error-code and error-handler is called.
	End Rem
	Method SetPageLayout:Int(layout:EPDFPageLayout)
		Return HPDF_SetPageLayout(docPtr, layout)
	End Method

	Rem
	bbdoc: Returns the current setting for page layout.
	End Rem
	Method GetPageLayout:EPDFPageLayout()
		Return HPDF_GetPageLayout(docPtr)
	End Method

	Rem
	bbdoc: Sets how the document should be displayed.
	returns: #HPDF_OK on success. Otherwise, it returns error-code and error-handler is called.
	End Rem
	Method SetPageMode:Int(mode:EPDFPageMode)
		Return HPDF_SetPageMode(docPtr, mode)
	End Method

	Rem
	bbdoc: Returns the current setting for page mode.
	End Rem
	Method GetPageMode:EPDFPageMode()
		Return HPDF_GetPageMode(docPtr)
	End Method

	Rem
	bbdoc: Sets the first page to appear when a document is opened.
	returns: #HPDF_OK on success. Otherwise, it returns error-code and error-handler is called.
	End Rem
	Method SetOpenAction:Int(action:TPDFDestination)
		Return HPDF_SetOpenAction(docPtr, action.destinationPtr)
	End Method

	Method CreateOutline:TPDFOutline(parent:TPDFOutline, title:String, encoder:TPDFEncoder)
		Local t:Byte Ptr = title.ToUTF8String()
		Local outline:TPDFOutline = CreateOutline(parent, t, encoder)
		MemFree(t)
		Return outline
	End Method

	Rem
	bbdoc: Creates a new outline object.
	End Rem
	Method CreateOutline:TPDFOutline(parent:TPDFOutline, title:Byte Ptr, encoder:TPDFEncoder)
		Local outline:TPDFOutline
		If parent Then
			If encoder Then
				outline = TPDFOutline._create(HPDF_CreateOutline(docPtr, parent.outlinePtr, title, encoder.encoderPtr))
			Else
				outline = TPDFOutline._create(HPDF_CreateOutline(docPtr, parent.outlinePtr, title, Null))
			End If
		Else
			If encoder Then
				outline = TPDFOutline._create(HPDF_CreateOutline(docPtr, Null, title, encoder.encoderPtr))
			Else
				outline = TPDFOutline._create(HPDF_CreateOutline(docPtr, Null, title, Null))
			End If
		End If
		Return outline
	End Method

	Rem
	bbdoc: Adds a page labeling range for the document.
	about: The page label is shown in the thumbnails view.
	End Rem
	Method AddPageLabel:Int(pageNum:UInt, style:EPDFPageNumStyle, firstPage:UInt, prefix:String = Null)
		Local p:Byte Ptr
		If prefix Then
			p = prefix.ToUTF8String()
		End If
		Local ret:Int = HPDF_AddPageLabel(docPtr, pageNum, style, firstPage, p)
		MemFree(p)
		Return ret
	End Method

	Rem
	bbdoc: Enables Japanese fonts.
	returns: #HPDF_OK on success. Otherwise, it returns error code and error-handler is invoked.
	about: After calling #UseJPFonts(), the following fonts become available :
	* MS-Mincyo
	* MS-Mincyo,Bold
	* MS-Mincyo,Italic
	* MS-Mincyo,BoldItalic
	* MS-Gothic
	* MS-Gothic,Bold
	* MS-Gothic,Italic
	* MS-Gothic,BoldItalic
	* MS-PMincyo
	* MS-PMincyo,Bold
	* MS-PMincyo,Italic
	* MS-PMincyo,BoldItalic
	* MS-PGothic
	* MS-PGothic,Bold
	* MS-PGothic,Italic
	* MS-PGothic,BoldItalic
	End Rem
	Method UseJPFonts:Int()
		Return HPDF_UseJPFonts(docPtr)
	End Method

	Rem
	bbdoc: Enables Korean fonts.
	returns: #HPDF_OK on success. Otherwise, it returns error code and error-handler is invoked.
	about: After calling #UseKRFonts(), the following fonts become available :
	* DotumChe
	* DotumChe,Bold
	* DotumChe,Italic
	* DotumChe,BoldItalic
	* Dotum
	* Dotum,Bold
	* Dotum,Italic
	* Dotum,BoldItalic
	* BatangChe
	* BatangChe,Bold
	* BatangChe,Italic
	* BatangChe,BoldItalic
	* Batang
	* Batang,Bold
	* Batang,Italic
	* Batang,BoldItalic
	End Rem
	Method UseKRFonts:Int()
		Return HPDF_UseKRFonts(docPtr)
	End Method

	Rem
	bbdoc: Enables simplified Chinese fonts.
	returns: #HPDF_OK on success. Otherwise, it returns error code and error-handler is invoked.
	about: After calling #UseCNSFonts(), the following fonts become available :
	* SimSun
	* SimSun,Bold
	* SimSun,Italic
	* SimSun,BoldItalic
	* SimHei
	* SimHei,Bold
	* SimHei,Italic
	* SimHei,BoldItalic
	End Rem
	Method UseCNSFonts:Int()
		Return HPDF_UseCNSFonts(docPtr)
	End Method

	Rem
	bbdoc: Enables traditional Chinese fonts.
	returns: #HPDF_OK on success. Otherwise, it returns error code and error-handler is invoked.
	about: After calling #UseCNTFonts(), the following fonts become available :
	* MingLiU
	* MingLiU,Bold
	* MingLiU,Italic
	* MingLiU,BoldItalic
	End Rem
	Method UseCNTFonts:Int()
		Return HPDF_UseCNTFonts(docPtr)
	End Method
	
	Rem
	bbdoc: Enables UTF support for better text rendering when using non-ascii characters.
	about:
	<a href="../examples/utf.bmx">Example source</a>
	EndRem
	Method UseUTFEncodings()
		HPDF_UseUTFEncodings(docPtr)
	EndMethod

	Rem
	bbdoc: Sets the text of an info dictionary attribute, using current encoding of the document.
	about: If encoding is not set, PDFDocEncoding is used.
	End Rem
	Method SetInfoAttr:Int(infoType:EPDFInfoType, value:String)
		Local v:Byte Ptr = value.ToUTF8String()
		Local ret:Int = HPDF_SetInfoAttr(docPtr, infoType, v)
		MemFree(v)
		Return ret
	End Method

	Rem
	bbdoc: Gets an attribute value from info dictionary.
	returns: The string value of the info dictionary. If the infomation has not been set or an error has occurred, it returns #Null.
	End Rem
	Method HPDF_GetInfoAttr:String(infoType:EPDFInfoType)
		Local v:Byte Ptr = HPDF_GetInfoAttr(docPtr, infoType)
		If v Then
			Return String.FromUTF8String(v)
		End If
	End Method

	Rem
	bbdoc: Sets a datetime attribute in the info dictionary.
	End Rem
	Method SetInfoDateAttr:Int(infoType:EPDFInfoType, date:SPDFDate)
		Return HPDF_SetInfoDateAttr(docPtr, infoType, date)
	End Method

	Rem
	bbdoc: Gets the handle of an encoder object by specified encoding name.
	End Rem
	Method GetEncoder:TPDFEncoder(encodingName:String)
		Local n:Byte Ptr = encodingName.ToUTF8String()
		Local res:Byte Ptr = HPDF_GetEncoder(docPtr, n)
		MemFree(n)
		Return TPDFEncoder._create(res)
	End Method

	Rem
	bbdoc: Gets the handle of the current encoder of the document object.
	about: The current encoder is set by invoking #SetCurrentEncoder() and it is used to processing a text when an
	application invokes #SetInfoAttr(). The default value of it is #Null.
	End Rem
	Method GetCurrentEncoder:TPDFEncoder(encodingName:String)
		Local n:Byte Ptr = encodingName.ToUTF8String()
		Local res:Byte Ptr = HPDF_GetCurrentEncoder(docPtr, n)
		MemFree(n)
		Return TPDFEncoder._create(res)
	End Method

	Rem
	bbdoc: Sets the current encoder of the document.
	End Rem
	Method SetCurrentEncoder:Int(encodingName:String)
		Local n:Byte Ptr = encodingName.ToUTF8String()
		Local res:Int = HPDF_SetCurrentEncoder(docPtr, n)
		MemFree(n)
		Return res
	End Method

	Rem
	bbdoc: Returns the number of pages in the document.
	End Rem
	Method GetPageCount:Int()
		Return pageCount
	End Method

	Rem
	bbdoc: Loads a #TPDFImage from a #TPixmap.
	End Rem
	Method LoadImage:TPDFImage(pix:TPixmap)
		If pix.format <> PF_RGB888 Then
			pix = pix.Convert(PF_RGB888)
		End If
		Return TPDFImage._create(HPDF_LoadRawImageFromMem(docPtr, pix.pixels, UInt(pix.width), UInt(pix.height), EPDFColorSpace.DEVICE_RGB, 8))
	End Method

	Rem
	bbdoc: Sets the current encoder for the document.
	End Rem
	Method Free()
		If docPtr Then
			HPDF_Free(docPtr:Byte Ptr)
			docPtr = Null
		End If
	End Method

	Method Delete()
		Free()
	End Method

End Type

Rem
bbdoc: A PDF page.
End Rem
Type TPDFPage
	Private

	Field pagePtr:Byte Ptr
	Field doc:TPDFDoc

	Method New()
	End Method

	Function _create:TPDFPage(pagePtr:Byte Ptr, doc:TPDFDoc)
		If pagePtr Then
			Local page:TPDFPage = New TPDFPage
			page.pagePtr = pagePtr
			page.doc = doc
			Return page
		End If
	End Function

	Public

	Rem
	bbdoc: Gets the document object for this page.
	End Rem
	Method GetDoc:TPDFDoc()
		Return doc
	End Method

	Rem
	bbdoc: Changes the width of a page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetWidth:Int(width:Float)
		Return HPDF_Page_SetWidth(pagePtr, width)
	End Method

	Rem
	bbdoc: Changes the height of a page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetHeight:Int(height:Float)
		Return HPDF_Page_SetHeight(pagePtr, height)
	End Method

	Rem
	bbdoc: Begins a text object and sets the text position to (0, 0).
	End Rem
	Method BeginText:Int()
		Return HPDF_Page_BeginText(pagePtr)
	End Method

	Rem
	bbdoc: Ends a text object.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method EndText:Int()
		Return HPDF_Page_EndText(pagePtr)
	End Method

	Rem
	bbdoc: Prints the text at the current position on the page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method ShowText:Int(text:String)
		Local t:Byte Ptr = text.ToUTF8String()
		Local ret:Int = HPDF_Page_ShowText(pagePtr, t)
		MemFree(t)
		Return ret
	End Method

	Rem
	bbdoc: Prints the null-terminated Byte Ptr text at the current position on the page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method ShowText:Int(text:Byte Ptr)
		Return HPDF_Page_ShowText(pagePtr, text)
	End Method

	Rem
	bbdoc: Moves the current text position to the start of the next line, then prints the text at the current position on the page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method ShowTextNextLine:Int(text:String)
		Local t:Byte Ptr = text.ToUTF8String()
		Local ret:Int = HPDF_Page_ShowTextNextLine(pagePtr, t)
		MemFree(t)
		Return ret
	End Method

	Rem
	bbdoc: Moves the current text position to the start of the next line, then prints the null-terminated Byte Ptr text at the current position on the page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method ShowTextNextLine:Int(text:Byte Ptr)
		Return HPDF_Page_ShowTextNextLine(pagePtr, text)
	End Method

	Rem
	bbdoc: Moves the current text position to the start of the next line, then sets word spacing and character spacing, and finally prints the text at the current position on the page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method ShowTextNextLineEx:Int(wordSpace:Float, charSpace:Float, text:String)
		Local t:Byte Ptr = text.ToUTF8String()
		Local ret:Int = HPDF_Page_ShowTextNextLineEx(pagePtr, wordSpace, charSpace, t)
		MemFree(t)
		Return ret
	End Method

	Rem
	bbdoc: Moves the current text position to the start of the next line, then sets word spacing and character spacing, and finally prints the null-terminate Byte Ptr text at the current position on the page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method ShowTextNextLineEx:Int(wordSpace:Float, charSpace:Float, text:Byte Ptr)
		Return HPDF_Page_ShowTextNextLineEx(pagePtr, wordSpace, charSpace, text)
	End Method

	Rem
	bbdoc: Gets the width of the text in current fontsize, character spacing and word spacing.
	returns: The width of the text in current fontsize, character spacing and word spacing. Otherwise it returns ZERO and error-handler is called.
	End Rem
	Method TextWidth:Float(text:String)
		Local s:Byte Ptr = text.ToUTF8String()
		Local res:Float = HPDF_Page_TextWidth(pagePtr, s)
		MemFree(s)
		Return res
	End Method

	Rem
	bbdoc: Gets the width of the text in current fontsize, character spacing and word spacing.
	returns: The width of the text in current fontsize, character spacing and word spacing. Otherwise it returns ZERO and error-handler is called.
	End Rem
	Method TextWidth:Float(text:Byte Ptr)
		Return HPDF_Page_TextWidth(pagePtr, text)
	End Method

	Rem
	bbdoc: Sets the width of the line used to stroke a path.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetLineWidth:Int(width:Float)
		Return HPDF_Page_SetLineWidth(pagePtr, width)
	End Method

	Rem
	bbdoc: Gets the width of the page.
	returns: The height of a page. Otherwise it returns 0.
	End Rem
	Method GetWidth:Float()
		Return HPDF_Page_GetWidth(pagePtr)
	End Method

	Rem
	bbdoc: Gets the height of a page.
	returns: The height of a page. Otherwise it returns 0.
	End Rem
	Method GetHeight:Float()
		Return HPDF_Page_GetHeight(pagePtr)
	End Method

	Rem
	bbdoc: Appends a rectangle to the current path.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method Rectangle:Int(x:Float, y:Float, width:Float, height:Float)
		Return HPDF_Page_Rectangle(pagePtr, x, y, width, height)
	End Method

	Rem
	bbdoc: Starts a new subpath and moves the current point for drawing path, setting the start point for the path to the point (x, y).
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method MoveTo:Int(x:Float, y:Float)
		Return HPDF_Page_MoveTo(pagePtr, x, y)
	End Method

	Rem
	bbdoc: Appends a path from the current point to the specified point
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method LineTo:Int(x:Float, y:Float)
		Return HPDF_Page_LineTo(pagePtr, x, y)
	End Method

	Rem
	bbdoc: Appends a Bézier curve to the current path using the control points (x1, y1) and (x2, y2) and (x3, y3), then sets the current point to (x3, y3).
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method CurveTo:Int(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float)
		Return HPDF_Page_CurveTo(pagePtr, x1, y1, x2, y2, x3, y3)
	End Method

	Rem
	bbdoc: Appends a Bézier curve to the current path using the current point and (x2, y2) and (x3, y3) as control points.
	returns: Returns HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	about: Then, the current point is set to (x3, y3).
	End Rem
	Method CurveTo2:Int(x2:Float, y2:Float, x3:Float, y3:Float)
		Return HPDF_Page_CurveTo2(pagePtr, x2, y2, x3, y3)
	End Method

	Rem
	bbdoc: Appends a Bézier curve to the current path using two spesified points.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	about: The point (x1, y1) and the point (x3, y3) are used as the control points for a Bézier curve and current point is moved to the point (x3, y3)
	End Rem
	Method CurveTo3:Int(x1:Float, y1:Float, x3:Float, y3:Float)
		Return HPDF_Page_CurveTo3(pagePtr, x1, y1, x3, y3)
	End Method

	Rem
	bbdoc: Paints the current path.
	Returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method Stroke:Int()
		Return HPDF_Page_Stroke(pagePtr)
	End Method

	Rem
	bbdoc: Closes and then paints the current path.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method ClosePathStroke:Int()
		Return HPDF_Page_ClosePathStroke(pagePtr)
	End Method

	Rem
	bbdoc: Fills the current path using the nonzero winding number rule.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method Fill:Int()
		Return HPDF_Page_Fill(pagePtr)
	End Method

	Rem
	bbdoc: Fills the current path using the even-odd rule.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method Eofill:Int()
		Return HPDF_Page_Eofill(pagePtr)
	End Method

	Rem
	bbdoc: Fills the current path using the nonzero winding number rule, then paints the path.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method FillStroke:Int()
		Return HPDF_Page_FillStroke(pagePtr)
	End Method

	Rem
	bbdoc: Fills the current path using the even-odd rule, then paints the path.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method EofillStroke:Int()
		Return HPDF_Page_EofillStroke(pagePtr)
	End Method

	Rem
	bbdoc: Closes the current path, fills the current path using the nonzero winding number rule, then paints the path.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method ClosePathFillStroke:Int()
		Return HPDF_Page_ClosePathFillStroke(pagePtr)
	End Method

	Rem
	bbdoc: Closes the current path, fills the current path using the even-odd rule, then paints the path.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method ClosePathEofillStroke:Int()
		Return HPDF_Page_ClosePathEofillStroke(pagePtr)
	End Method

	Rem
	bbdoc: Ends the path object without filling or painting.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method EndPath:Int()
		Return HPDF_Page_EndPath(pagePtr)
	End Method

	Rem
	bbdoc: Sets the type of font and size leading.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetFontAndSize:Int(font:TPDFFont, size:Float)
		Return HPDF_Page_SetFontAndSize(pagePtr, font.fontPtr, size)
	End Method

	Rem
	bbdoc: Changes the current text position, using the specified offset values.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	about: If the current text position is (x1, y1), the new text position will be (x1 + x, y1 + y).
	End Rem
	Method MoveTextPos:Int(x:Float, y:Float)
		Return HPDF_Page_MoveTextPos(pagePtr, x, y)
	End Method

	Rem
	bbdoc: Changes the current text position, using the specified offset values.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	about: If the current text position is (x1, y1), the new text position will be (x1 + x, y1 + y).
	Also, the text-leading is set to -y.
	End Rem
	Method MoveTextPos2:Int(x:Float, y:Float)
		Return HPDF_Page_MoveTextPos2(pagePtr, x, y)
	End Method

	Rem
	bbdoc: Sets a transformation matrix for text to be drawn in using #ShowText().
	returns: #HPDF_OK on success, otherwise an error code.
	about: If the parameter @a or @d is zero, then the parameters @b or @c cannot be zero.

	Text is typically output using #ShowText(). The method #TextRect() does not use the active text matrix.
	End Rem
	Method SetTextMatrix:Int(a:Float, b:Float, c:Float, d:Float, x:Float, y:Float)
		Return HPDF_Page_SetTextMatrix(pagePtr, a, b, c, d, x, y)
	End Method

	Rem
	bbdoc: Moves current position for the text showing depending on current text showing point and text leading.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	about: The new position is calculated with current text transition matrix.
	End Rem
	Method MoveToNextLine:Int()
		Return HPDF_Page_MoveToNextLine(pagePtr)
	End Method

	Rem
	bbdoc: Sets the dash pattern for lines in the page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetDash:Int(dashes:Float Ptr, count:UInt, phase:Float)
		Return HPDF_Page_SetDash(pagePtr, dashes, count, phase)
	End Method

	Rem
	bbdoc: Sets the dash pattern for lines in the page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetDash:Int(dashes:Float[], phase:Float)
		Return HPDF_Page_SetDash(pagePtr, dashes, UInt(dashes.Length), phase)
	End Method

	Rem
	bbdoc: Sets the filling color.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetRGBFill:Int(r:Float, g:Float, b:Float)
		Return HPDF_Page_SetRGBFill(pagePtr, r, g, b)
	End Method

	Rem
	bbdoc: Sets the stroking color.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetRGBStroke:Int(r:Float, g:Float, b:Float)
		Return HPDF_Page_SetRGBStroke(pagePtr, r, g, b)
	End Method

	Rem
	bbdoc: Sets the filling color.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetCMYKFill:Int(c:Float, m:Float, y:Float, k:Float)
		Return HPDF_Page_SetCMYKFill(pagePtr, c, m, y, k)
	End Method

	Rem
	bbdoc: Sets the stroking color.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetCMYKStroke:Int(c:Float, m:Float, y:Float, k:Float)
		Return HPDF_Page_SetCMYKStroke(pagePtr, c, m, y, k)
	End Method

	Rem
	bbdoc: Sets the shape to be used at the ends of lines.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetLineCap:Int(lineCap:EPDFLineCap)
		Return HPDF_Page_SetLineCap(pagePtr, lineCap)
	End Method

	Rem
	bbdoc: Sets the line join style on the page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetLineJoin:Int(lineJoin:EPDFLineJoin)
		Return HPDF_Page_SetLineJoin(pagePtr, lineJoin)
	End Method

	Rem
	bbdoc: Sets the miter limit to @miterLimit.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetMiterLimit:Int(miterLimit:Float)
		Return HPDF_Page_SetMiterLimit(pagePtr, miterLimit)
	End Method
	
	Rem
	bbdoc: Saves the page's current graphics parameter to the stack.
	returns: HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	about: An application can invoke #GSave up to a depth of 28 times and can restore the saved parameter by invoking #GRestore.
The parameters that are saved by #GSave are:
 * Character Spacing
 * Clipping Path
 * Dash Mode
 * Filling Color
 * Flatness
 * Font
 * Font Size
 * Horizontal Scalling
 * Line Width
 * Line Cap Style
 * Line Join Style
 * Miter Limit
 * Rendering Mode
 * Stroking Color
 * Text Leading
 * Text Rise
 * Transformation Matrix
 * Word Spacing
	End Rem
	Method GSave:Int()
		Return HPDF_Page_GSave(pagePtr)
	End Method

	Rem
	bbdoc: Restores the graphics state which is saved by #GSave.
	returns: HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method GRestore:Int()
		Return HPDF_Page_GRestore(pagePtr)
	End Method

	Rem
	bbdoc: Modifies the current clipping path by intersecting it with the current path using the nonzero winding number rule.
	about: The clipping path is only modified after the succeeding painting operator. 
	To avoid painting the current path, use the function #EndPath().

	Following painting operations will only affect the regions of the page contained by the clipping path.
	Initially, the clipping path includes the entire page. There is no way to enlarge the current clipping path,
	or to replace the clipping path with a new one. The functions #GSave() and #GRestore() may be used to save and restore
	the current graphics state, including the clipping path.
	End Rem
	Method Clip:Int()
		Return HPDF_Page_Clip(pagePtr)
	End Method

	Rem
	bbdoc: Modifies the current clipping path by intersecting it with the current path using the even-odd rule.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	about: The clipping path is only modified after the succeeding painting operator. 
	To avoid painting the current path, use the function #EndPath().

	Following painting operations will only affect the regions of the page contained by the clipping path.
	Initially, the clipping path includes the entire page. There is no way to enlarge the current clipping path,
	or to replace the clipping path with a new one. The functions #GSave() and #GRestore() may be used to save and 
	restore the current graphics state, including the clipping path.
	End Rem
	Method Eoclip:Int()
		Return HPDF_Page_Eoclip(pagePtr)
	End Method

	Rem
	bbdoc: Sets the character spacing for text.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetCharSpace:Int(value:Float)
		Return HPDF_Page_SetCharSpace(pagePtr, value)
	End Method

	Rem
	bbdoc: Sets the word spacing for text.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetWordSpace:Int(value:Float)
		Return HPDF_Page_SetWordSpace(pagePtr, value)
	End Method

	Rem
	bbdoc: Sets the horizontal scalling (scaling) for text showing.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetHorizontalScalling:Int(value:Float)
		Return HPDF_Page_SetHorizontalScalling(pagePtr, value)
	End Method

	Rem
	bbdoc: Sets the text leading (line spacing) for text showing.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetTextLeading:Int(value:Float)
		Return HPDF_Page_SetTextLeading(pagePtr, value)
	End Method

	Rem
	bbdoc: Sets the filling color.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetGrayFill:Int(gray:Float)
		Return HPDF_Page_SetGrayFill(pagePtr, gray)
	End Method

	Rem
	bbdoc: Sets the stroking color.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetGrayStroke:Int(gray:Float)
		Return HPDF_Page_SetGrayStroke(pagePtr, gray)
	End Method

	Rem
	bbdoc: Gets the current line width of the page.
	returns: The current line width for path painting of the page. Otherwise it returns #HPDF_DEF_LINEWIDTH.
	End Rem
	Method GetLineWidth:Float()
		Return HPDF_Page_GetLineWidth(pagePtr)
	End Method

	Rem
	bbdoc: Gets the current position for path painting.
	returns: A #SPDFPoint struct indicating the current position for path painting of the page. Otherwise it returns a #SPDFPoint struct of {0, 0}.
	End Rem
	Method GetCurrentPos:SPDFPoint()
		Return HPDF_Page_GetCurrentPos(pagePtr)
	End Method

	Rem
	bbdoc: Gets the current position for text showing.
	returns: A #SPDFPoint struct indicating the current position for text showing of the page. Otherwise it returns a #SPDFPoint struct of {0, 0}.
	End Rem
	Method GetCurrentTextPos:SPDFPoint()
		Return HPDF_Page_GetCurrentTextPos(pagePtr)
	End Method

	Rem
	bbdoc: Shows an image.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method DrawImage:UInt(image:TPDFImage, x:Float, y:Float, width:Float, height:Float)
		Return HPDF_Page_DrawImage(pagePtr, image.imagePtr, x, y, width, height)
	End Method

	Rem
	bbdoc: Appends a circle to the current path.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method Circle:Int(x:Float, y:Float, r:Float)
		Return HPDF_Page_Circle(pagePtr, x, y, r)
	End Method

	Rem
	bbdoc: Appends an ellipse to the current path.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method Ellipse:Int(x:Float, y:Float, xr:Float, yr:Float)
		Return HPDF_Page_Ellipse(pagePtr, x, y, xr, yr)
	End Method

	Rem
	bbdoc: Appends a circle arc to the current path.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	about: Angles are given in degrees, with 0 degrees being vertical, upward, from the (x,y) position.
	End Rem
	Method Arc:Int(x:Float, y:Float, r:Float, a1:Float, a2:Float)
		Return HPDF_Page_Arc(pagePtr, x, y, r, a1, a2)
	End Method

	Rem
	bbdoc: Prints the text at the specified position.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method TextOut:Int(xpos:Float, ypos:Float, text:String)
		Local t:Byte Ptr = text.ToUTF8String()
		Local res:Int = HPDF_Page_TextOut(pagePtr, xpos, ypos, t)
		MemFree(t)
		Return res
	End Method

	Rem
	bbdoc: Prints the null-terminated Byte Ptr of text at the specified position.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method TextOut:Int(xpos:Float, ypos:Float, text:Byte Ptr)
		Return HPDF_Page_TextOut(pagePtr, xpos, ypos, text)
	End Method

	Rem
	bbdoc: Prints the text inside the specified region.
	returns: #HPDF_OK on success. Returns #HPDF_PAGE_INSUFFICIENT_SPACE on success but whole text doesn't fit into declared space. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method TextRect:Int(left:Float, top:Float, right:Float, bottom:Float, text:String, align:EPDFTextAlignment, length:Uint Var)
		Local t:Byte Ptr = text.ToUTF8String()
		Local res:Int = HPDF_Page_TextRect(pagePtr, left, top, right, bottom, t, align, length)
		MemFree(t)
		Return res
	End Method

	Rem
	bbdoc: Prints the null-terminated Byte Ptr of text inside the specified region.
	returns: #HPDF_OK on success. Returns #HPDF_PAGE_INSUFFICIENT_SPACE on success but whole text doesn't fit into declared space. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method TextRect:Int(left:Float, top:Float, right:Float, bottom:Float, text:Byte Ptr, align:EPDFTextAlignment, length:Uint Var)
		Return HPDF_Page_TextRect(pagePtr, left, top, right, bottom, text, align, length)
	End Method

	Rem
	bbdoc: Calculates the byte length which can be included within the specified width.
	returns: The byte length which can be included within the specified width in current fontsize, character spacing and word spacing. Otherwise it returns ZERO and error-handler is called.
	End Rem
	Method MeasureText:UInt(text:String, width:Float, wordwrap:Int, realWidth:Float Ptr)
		Local t:Byte Ptr = text.ToUTF8String()
		Local res:UInt = HPDF_Page_MeasureText(pagePtr, t, width, wordwrap, realWidth)
		MemFree(t)
		Return res
	End Method

	Rem
	bbdoc: Calculates the byte length which can be included within the specified width.
	returns: The byte length which can be included within the specified width in current fontsize, character spacing and word spacing. Otherwise it returns ZERO and error-handler is called.
	End Rem
	Method MeasureText:UInt(text:Byte Ptr, width:Float, wordwrap:Int, realWidth:Float Ptr)
		Return HPDF_Page_MeasureText(pagePtr, text, width, wordwrap, realWidth)
	End Method

	Rem
	bbdoc: Gets the page's current font.
	returns: The page's current font. Otherwise it returns #Null.
	End Rem
	Method GetCurrentFont:TPDFFont()
		Return TPDFFont._create(HPDF_Page_GetCurrentFont(pagePtr))
	End Method

	Rem
	bbdoc: Gets the size of the page's current font.
	returns: The size of the page's current font. Otherwise it returns 0.
	End Rem
	Method GetCurrentFontSize:Float()
		Return HPDF_Page_GetCurrentFontSize(pagePtr)
	End Method

	Rem
	bbdoc: Returns the current value of the page's filling color.
	returns: The current value of the page's filling color. Otherwise it returns {0, 0, 0}.
	about: #GetRGBFill() is valid only when the page's filling color space is DEVICE_RGB.
	End Rem
	Method GetRGBFill:SPDFRGBColor()
		Return HPDF_Page_GetRGBFill(pagePtr)
	End Method

	Rem
	bbdoc: Returns the current value of the page's stroking color.
	returns: The current value of the page's stroking color. Otherwise it returns {0, 0, 0}.
	about: #GetRGBStroke() is valid only when the page's stroking color space is DEVICE_RGB.
	End Rem
	Method GetRGBStroke:SPDFRGBColor()
		Return HPDF_Page_GetRGBStroke(pagePtr)
	End Method

	Rem
	bbdoc: Returns the current value of the page's filling color.
	about: #GetCMYKFill() is valid only when the page's filling color space is DEVICE_CMYK.
	End Rem
	Method GetCMYKFill:SPDFCMYKColor()
		Return HPDF_Page_GetCMYKFill(pagePtr)
	End Method

	Rem
	bbdoc: Returns the current value of the page's stroking color.
	about: #CMYKStroke() is valid only when the page's stroking color space is DEVICE_CMYK.
	End Rem
	Method GetCMYKStroke:SPDFCMYKColor()
		Return HPDF_Page_GetCMYKStroke(pagePtr)
	End Method

	Rem
	bbdoc: Returns the current value of the page's filling color.
	about: #GetGrayFill() is valid only when the page's stroking color space is DEVICE_GRAY.
	End Rem
	Method GetGrayFill:Float()
		Return HPDF_Page_GetGrayFill(pagePtr)
	End Method

	Rem
	bbdoc: Returns the current value of the page's stroking color.
	about: #GetGrayStroke() is valid only when the page's stroking color space is DEVICE_GRAY.
	End Rem
	Method GetGrayStroke:Float()
		Return HPDF_Page_GetGrayStroke(pagePtr)
	End Method

	Rem
	bbdoc: Sets the text rendering mode.
	about: The initial value of text rendering mode is FILL.
	End Rem
	Method SetTextRenderingMode:Int(mode:EPDFTextRenderingMode)
		Return HPDF_Page_SetTextRenderingMode(pagePtr, mode)
	End Method
	
	Rem
	bbdoc: Applies the graphics state to the page.
	returns: #HPDF_OK on success. Otherwise, returns error code and error-handler is invoked.
	End Rem
	Method SetExtGState:Int(gstate:TPDFExtGState)
		Return HPDF_Page_SetExtGState(pagePtr, gstate.gstatePtr)
	End Method

	Rem
	bbdoc: Returns the current value of the page's stroking color space.
	End Rem
	Method GetStrokingColorSpace:EPDFColorSpace()
		Return HPDF_Page_GetStrokingColorSpace(pagePtr)
	End Method

	Rem
	bbdoc: Returns the current value of the page's stroking color space.
	End Rem
	Method GetFillingColorSpace:EPDFColorSpace()
		Return HPDF_Page_GetFillingColorSpace(pagePtr)
	End Method

	Rem
	bbdoc: Gets the current text transformation matrix of the page.
	End Rem
	Method GetTextMatrix:SPDFTransMatrix()
		Return HPDF_Page_GetTextMatrix(pagePtr)
	End Method

	Rem
	bbdoc: Returns the number of the page's graphics state stack.
	End Rem
	Method GetGStateDepth:UInt()
		Return HPDF_Page_GetGStateDepth(pagePtr)
	End Method

	Rem
	bbdoc: Returns the current value of the page's text rising.
	End Rem
	Method GetTextRise:Float()
		Return HPDF_Page_GetTextRise(pagePtr)
	End Method

	Rem
	bbdoc: Returns the current value of the page's line spacing.
	End Rem
	Method GetTextLeading:Float()
		Return HPDF_Page_GetTextLeading(pagePtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetTextRenderingMode:EPDFTextRenderingMode()
		Return HPDF_Page_GetTextRenderingMode(pagePtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetHorizontalScaling:Float()
		Return HPDF_Page_GetHorizontalScalling(pagePtr)
	End Method

	Rem
	bbdoc: Returns the current value of the page's word spacing.
	End Rem
	Method GetWordSpace:Float()
		Return HPDF_Page_GetWordSpace(pagePtr)
	End Method

	Rem
	bbdoc: Gets the current value of the page's character spacing.
	End Rem
	Method GetCharSpace:Float()
		Return HPDF_Page_GetCharSpace(pagePtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method GetFlat:Float()
		Return HPDF_Page_GetFlat(pagePtr)
	End Method

	Rem
	bbdoc: Gets the current pattern of the page.
	End Rem
	Method GetDash:SPDFDashMode()
		Return HPDF_Page_GetDash(pagePtr)
	End Method

	Rem
	bbdoc: Gets the current value of the page's miter limit.
	End Rem
	Method GetMiterLimit:Float()
		Return HPDF_Page_GetMiterLimit(pagePtr)
	End Method

	Rem
	bbdoc: Gets the current line join style of the page.
	End Rem
	Method GetLineJoin:EPDFLineJoin()
		Return HPDF_Page_GetLineJoin(pagePtr)
	End Method

	Rem
	bbdoc: Gets the current line cap style of the page.
	End Rem
	Method GetLineCap:EPDFLineCap()
		Return HPDF_Page_GetLineCap(pagePtr)
	End Method

	Rem
	bbdoc: Gets the current transformation matrix of the page.
	End Rem
	Method GetTransMatrix:SPDFTransMatrix()
		Return HPDF_Page_GetTransMatrix(pagePtr)
	End Method

	Rem
	bbdoc: Gets the current graphics mode.
	End Rem
	Method GetGMode:Short()
		Return HPDF_Page_GetGMode(pagePtr)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetFlat:Int(flatness:Float)
		Return HPDF_Page_SetFlat(pagePtr, flatness)
	End Method

	Rem
	bbdoc: Concatenates the page's current transformation matrix and specified matrix.
	about: For example, if you want to rotate the coordinate system of the page by 45 degrees, use #Concat() as follows.
	```
	Local angle:Float = 45
	page.Concat(Cos(angle), Sin(angle), -Sin(angle), Cos(angle), 220, 350)
  	```
	To change the coordinate system of the page to 300 dpi, use #Concat() as follows.
	```
	page.Concat(72 / 300.0, 0, 0, 72.0 / 300.0, 0, 0)
	```
	Invoke #GSave() before #Concat(). Then the change by #Concat() can be restored by invoking #GRestore().
	```
	' save the current graphics states
  	page.GSave(page)
  
	' concatenate the transformation matrix
  	page.Concat(72.0 / 300.0, 0, 0, 72.0 / 300.0, 0, 0)
  
	' show text on the translated coordinates
  	page.BeginText()
  	page.MoveTextPos(50, 100)
  	page.ShowText("Text on the translated coordinates")
  	page.EndText()
  	' restore the graphics states
  	page.GRestore()
	```
	End Rem
	Method Concat:Int(a:Float, b:Float, c:Float, d:Float, x:Float, y:Float)
		Return HPDF_Page_Concat(pagePtr, a, b, c, d, x, y)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Rotate:Int(angle:Float, x:Float, y:Float)
		Return Concat(Float(Cos(angle)), Float(Sin(angle)), Float(-Sin(angle)), Float(Cos(angle)), x, y)
	End Method

	Rem
	bbdoc: Changes the size and direction of a page to a predefined size.
	about: Defaults to Portrait direction.
	End Rem
	Method SetSize:Int(size:EPDFPageSize, direction:EPDFPageDirection = EPDFPageDirection.PORTRAIT)
		Return HPDF_Page_SetSize(pagePtr, size, direction)
	End Method

	Rem
	bbdoc: Creates a new destination object for the page.
	End Rem
	Method CreateDestination:TPDFDestination()
		Return TPDFDestination._create(HPDF_Page_CreateDestination(pagePtr))
	End Method

	Rem
	bbdoc: Sets rotation angle of the page.
	End Rem
	Method SetRotate:Int(angle:Short)
		Return HPDF_Page_SetRotate(pagePtr, angle)
	End Method

	Rem
	bbdoc: Creates a new text annotation object for the page.
	End Rem
	Method CreateTextAnnot:TPDFAnnotation(rect:SPDFRect, text:String, encoder:TPDFEncoder = Null)
		Local t:Byte Ptr = text.ToUTF8String()
		Local res:TPDFAnnotation
		If encoder Then
			res = TPDFAnnotation._create(HPDF_Page_CreateTextAnnot(pagePtr, rect, t, encoder.encoderPtr))
		Else
			res = TPDFAnnotation._create(HPDF_Page_CreateTextAnnot(pagePtr, rect, t, Null))
		End If
		MemFree(t)
		Return res
	End Method

	Rem
	bbdoc: Creates a new text annotation object for the page.
	End Rem
	Method CreateTextAnnot:TPDFAnnotation(rect:SPDFRect, text:Byte Ptr, encoder:TPDFEncoder = Null)
		Local res:TPDFAnnotation
		If encoder Then
			res = TPDFAnnotation._create(HPDF_Page_CreateTextAnnot(pagePtr, rect, text, encoder.encoderPtr))
		Else
			res = TPDFAnnotation._create(HPDF_Page_CreateTextAnnot(pagePtr, rect, text, Null))
		End If
		Return res
	End Method

	Rem
	bbdoc: Creates a new link annotation object for the page.
	End Rem
	Method CreateLinkAnnot:TPDFAnnotation(rect:SPDFRect, dest:TPDFDestination)
		Return TPDFAnnotation._create(HPDF_Page_CreateLinkAnnot(pagePtr, rect, dest.destinationPtr))
	End Method

	Rem
	bbdoc: Creates a new web link annotation object for the page.
	End Rem
	Method CreateURILinkAnnot:TPDFAnnotation(rect:SPDFRect, uri:String)
		Local u:Byte Ptr = uri.ToUTF8String()
		Local res:TPDFAnnotation = TPDFAnnotation._create(HPDF_Page_CreateURILinkAnnot(pagePtr, rect, u))
		MemFree(u)
		Return res
	End Method

	Rem
	bbdoc: Configures the setting for slide transition of the page.
	End Rem
	Method SetSlideShow:Int(style:EPDFTransitionStyle, dispTime:Float, transTime:Float)
		Return HPDF_Page_SetSlideShow(pagePtr, style, dispTime, transTime)
	End Method

	Rem
	bbdoc: Sets the size of the given page @boundary.
	End Rem
	Method SetBoundary:Int(boundary:EPDFPageBoundary, left:Float, bottom:Float, right:Float, top:Float)
		Return HPDF_Page_SetBoundary(pagePtr, boundary, left, bottom, right, top)
	End Method

End Type

Rem
bbdoc: A PDF Font object.
End Rem
Type TPDFFont
	Private
	Field fontPtr:Byte Ptr

	Function _create:TPDFFont(fontPtr:Byte Ptr)
		If fontPtr Then
			Local font:TPDFFont = New TPDFFont
			font.fontPtr = fontPtr
			Return font
		End If
	End Function
	Public

	Rem
	bbdoc: gets the name of the font.
	returns: Font name on success. Otherwise, returns #Null.
	End Rem
	Method GetFontName:String()
		Local s:Byte Ptr = HPDF_Font_GetFontName(fontPtr)
		If s Then
			Return String.FromUTF8String(s)
		End If
	End Method

	Rem
	bbdoc: Gets the encoding name of the font.
	returns: Font encoding name on success. Otherwise, returns #Null.
	End Rem
	Method GetEncodingName:String()
		Local s:Byte Ptr = HPDF_Font_GetEncodingName(fontPtr)
		If s Then
			Return String.FromUTF8String(s)
		End If
	End Method

	Rem
	bbdoc: Gets the bounding box of the font.
	returns: On success, returns #SPDFRect specifying the font bounding box. Otherwise, returns a #SPDFRect of {0, 0, 0, 0}.
	End Rem
	Method GetBBox:SPDFRect()
		Return HPDF_Font_GetBBox(fontPtr)
	End Method

	Rem
	bbdoc: Gets the vertical ascent of the font.
	returns: Font vertical ascent on success. Otherwise, returns 0.
	End Rem
	Method GetAscent:Int()
		Return HPDF_Font_GetAscent(fontPtr)
	End Method

	Rem
	bbdoc: Gets the vertical descent of the font.
	returns: Font vertical descent on success. Otherwise, returns 0.
	End Rem
	Method GetDescent:Int()
		Return HPDF_Font_GetDescent(fontPtr)
	End Method

	Rem
	bbdoc: Gets the distance from the baseline of lowercase letters.
	returns: Font x-height value on success. Otherwise, returns 0.
	End Rem
	Method GetXHeight:UInt()
		Return HPDF_Font_GetXHeight(fontPtr)
	End Method

	Rem
	bbdoc: Gets the distance from the baseline of uppercase letters.
	returns: Font cap height on success. Otherwise, returns 0.
	End Rem
	Method GetCapHeight:UInt()
		Return HPDF_Font_GetCapHeight(fontPtr)
	End Method

	Rem
	bbdoc: Calculates the byte length which can be included within the specified width.
	returns: Byte length which can be included within specified width. Otherwise, returns 0.
	End Rem
	Method MesureText:UInt(text:String, length:UInt, width:Float, fontSize:Float, charSpace:Float, wordSpace:Float, wordwrap:Int, realWidth:Float Ptr)
		Local t:Byte Ptr = text.ToUTF8String()
		Local res:UInt = HPDF_Font_MeasureText(fontPtr, t, length, width, fontSize, charSpace, wordSpace, wordwrap, realWidth)
		MemFree(t)
		Return res
	End Method

	Rem
	bbdoc: Gets total width of the text, number of characters, and number of words.
	End Rem
	Method TextWidth:SPDFTextWidth(text:String)
		Local t:Byte Ptr = text.ToUTF8String()
		Local length:UInt = strlen_(t)
		Local w:SPDFTextWidth = HPDF_Font_TextWidth(fontPtr, t, length)
		MemFree(t)
		Return w
	End Method

End Type

Rem
bbdoc: PDF extended graphics state.
End Rem
Type TPDFExtGState
	Private
	Field gstatePtr:Byte Ptr

	Function _create:TPDFExtGState(gstatePtr:Byte Ptr)
		If gstatePtr Then
			Local gstate:TPDFExtGState = New TPDFExtGState
			gstate.gstatePtr = gstatePtr
			Return gstate
		End If
	End Function
	Public

	Rem
	bbdoc: 
	End Rem
	Method SetAlphaStroke:Int(value:Float)
		Return HPDF_ExtGState_SetAlphaStroke(gstatePtr, value)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetAlphaFill:Int(value:Float)
		Return HPDF_ExtGState_SetAlphaFill(gstatePtr, value)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetBlendMode:Int(mode:EPDFBlendMode)
		Return HPDF_ExtGState_SetBlendMode(gstatePtr, mode)
	End Method

End Type

Rem
bbdoc: A PDF outline.
End Rem
Type TPDFOutline
	Private
	Field outlinePtr:Byte Ptr

	Function _create:TPDFOutline(outlinePtr:Byte Ptr)
		If outlinePtr Then
			Local outline:TPDFOutline = New TPDFOutline
			outline.outlinePtr = outlinePtr
			Return outline
		End If
	End Function

	Public
	Rem
	bbdoc: Sets whether this node is opened or not when the outline is displayed for the first time.
	End Rem
	Method SetOpened:Int(opened:Int)
		Return HPDF_Outline_SetOpened(outlinePtr, opened)
	End Method

	Rem
	bbdoc: Sets a destination object which becomes to a target to jump when the outline is clicked.
	End Rem
	Method SetDestination:Int(dst:TPDFDestination)
		Return HPDF_Outline_SetDestination(outlinePtr, dst.destinationPtr)
	End Method
End Type

Rem
bbdoc: A PDF destination object.
End Rem
Type TPDFDestination
	Private
	Field destinationPtr:Byte Ptr

	Function _create:TPDFDestination(destinationPtr:Byte Ptr)
		If destinationPtr Then
			Local dest:TPDFDestination = New TPDFDestination
			dest.destinationPtr = destinationPtr
			Return dest
		End If
	End Function

	Public
	Rem
	bbdoc: Defines the appearance of a page with three parameters which are left, top and zoom.
	End Rem
	Method SetXYZ:Int(left:Float, top:Float, zoom:Float)
		Return HPDF_Destination_SetXYZ(destinationPtr, left, top, zoom)
	End Method

	Rem
	bbdoc: Sets the appearance of the page to displaying entire page within the window.
	End Rem
	Method SetFit:Int()
		Return HPDF_Destination_SetFit(destinationPtr)
	End Method

	Rem
	bbdoc: Defines the appearance of a page to magnifying to fit the width of the page within the window and setting the top position of the page to the value of the "top" parameter.
	End Rem
	Method SetFitH:Int(top:Float)
		Return HPDF_Destination_SetFitH(destinationPtr, top)
	End Method

	Rem
	bbdoc: Defines the appearance of a page to magnifying to fit the height of the page within the window and setting the left position of the page to the value of the "top" parameter.
	End Rem
	Method SetFitV:Int(left:Float)
		Return HPDF_Destination_SetFitV(destinationPtr, left)
	End Method

	Rem
	bbdoc: Defines the appearance of a page to magnifying the page to fit a rectangle specified by left, bottom, right and top.
	End Rem
	Method SetFitR:Int(left:Float, bottom:Float, right:Float, top:Float)
		Return HPDF_Destination_SetFitR(destinationPtr, left, bottom, right, top)
	End Method

	Rem
	bbdoc: Sets the appearance of the page to magnifying to fit the bounding box of the page within the window.
	End Rem
	Method SetFitB:Int()
		Return HPDF_Destination_SetFitB(destinationPtr)
	End Method

	Rem
	bbdoc: Defines the appearance of a page to magnifying to fit the width of the bounding box of the page within the window and setting the top position of the page to the value of the "top" parameter.
	End Rem
	Method SetFitBH:Int(top:Float)
		Return HPDF_Destination_SetFitBH(destinationPtr, top)
	End Method

	Rem
	bbdoc: Defines the appearance of a page to magnifying to fit the height of the bounding box of the page within the window and setting the top position of the page to the value of the "top" parameter.
	End Rem
	Method SetFitBV:Int(left:Float)
		Return HPDF_Destination_SetFitBV(destinationPtr, left)
	End Method

End Type

Rem
bbdoc: A PDF encoder.
End Rem
Type TPDFEncoder
	Private
	Field encoderPtr:Byte Ptr

	Function _create:TPDFEncoder(encoderPtr:Byte Ptr)
		If encoderPtr Then
			Local enc:TPDFEncoder = New TPDFEncoder
			enc.encoderPtr = encoderPtr
			Return enc
		End If
	End Function

	Public
End Type

Rem
bbdoc: A PDF annotation
End Rem
Type TPDFAnnotation
	Private
	Field annotationPtr:Byte Ptr

	Function _create:TPDFAnnotation(annotationPtr:Byte Ptr)
		If annotationPtr Then
			Local anno:TPDFAnnotation = New TPDFAnnotation
			anno.annotationPtr = annotationPtr
			Return anno
		End If
	End Function

	Public

	Rem
	bbdoc: 
	End Rem
	Method SetHighlightMode:Int(mode:EPDFAnnotHighlightMode)
		Return HPDF_LinkAnnot_SetHighlightMode(annotationPtr, mode)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetBorderStyle:Int(width:Float, dashOn:Short, dashOff:Short)
		Return HPDF_LinkAnnot_SetBorderStyle(annotationPtr, width, dashOn, dashOff)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetIcon:Int(icon:EPDFAnnotIcon)
		Return HPDF_TextAnnot_SetIcon(annotationPtr, icon)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetOpened:Int(open:Int)
		Return HPDF_TextAnnot_SetOpened(annotationPtr, open)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method SetBorderStyle:Int(subtype:EPDFBSSubtype, width:Float, dashOn:Short, dashOff:Short, dashPhase:Short)
		Return HPDF_Annotation_SetBorderStyle(annotationPtr, subtype, width, dashOn, dashOff, dashPhase)
	End Method

End Type

Rem
bbdoc: A PDF image.
End Rem
Type TPDFImage
	Private
	Field imagePtr:Byte Ptr

	Function _create:TPDFImage(imagePtr:Byte Ptr)
		If imagePtr Then
			Local img:TPDFImage = New TPDFImage
			img.imagePtr = imagePtr
			Return img
		End If
	End Function

	Public

	Rem
	bbdoc: Returns the width of the image.
	End Rem
	Method GetWidth:UInt()
		Return HPDF_Image_GetWidth(imagePtr)
	End Method

	Rem
	bbdoc: Returns the height of the image.
	End Rem
	Method GetHeight:UInt()
		Return HPDF_Image_GetHeight(imagePtr)
	End Method

	Rem
	bbdoc: Returns the number of bits used to represent each color component.
	End Rem
	Method GetBitsPerComponent:UInt()
		Return HPDF_Image_GetBitsPerComponent(imagePtr)
	End Method

	Rem
	bbdoc: Returns the size of the image.
	End Rem
	Method GetSize:SPDFPoint()
		Return HPDF_Image_GetSize(imagePtr)
	End Method

	Rem
	bbdoc: Returns the color space of the image.
	End Rem
	Method GetColorSpace:String()
		Return String.FromCString(HPDF_Image_GetColorSpace(imagePtr))
	End Method

	Rem
	bbdoc: Sets the colour mask.
	End Rem
	Method SetColorMask:UInt(rmin:UInt, rmax:UInt, gmin:UInt, gmax:UInt, bmin:UInt, bmax:UInt)
		Return HPDF_Image_SetColorMask(imagePtr, rmin, rmax, gmin, gmax, bmin, bmax)
	End Method

	Rem
	bbdoc: Sets the mask image.
	End Rem
	Method SetMaskImage:UInt(maskImage:TPDFImage)
		Return HPDF_Image_SetMaskImage(imagePtr, maskImage.imagePtr)
	End Method

End Type

Rem
bbdoc: A PDF exception.
End Rem
Type TPDFException

	Field errorNo:UInt
	Field detailNo:UInt

	Method New(errorNo:UInt, detailNo:UInt)
		Self.errorNo = errorNo
		Self.detailNo = detailNo
	End Method

	Function _create:TPDFException(errorNo:UInt, detailNo:UInt ) { nomangle }
		Return New TPDFException(errorNo, detailNo)
	End Function

	Method ToString:String()
		Return "PDF error : " + errorNo
	End Method
End Type
