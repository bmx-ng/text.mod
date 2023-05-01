' Copyright (c) 2023 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

ModuleInfo "Version: 1.01"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: MIT"
ModuleInfo "md4c - Copyright (c) Martin Mitas - https://github.com/woollybah/MarkdownEdit_md4c"
ModuleInfo "Copyright: 2023 Bruce A Henderson"

ModuleInfo "History: 1.01"
ModuleInfo "History: Added TMDHtmlCodeHighlighter for code highlighting."
ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release"

Rem
bbdoc: A markdown processor.
about: Can either use a custom renderer, or generate HTML directly.
End Rem
Module Text.Markdown

Import "common.bmx"

Rem
bbdoc: A renderer for markdown parser events.
End Rem
Interface IMDRenderer
	Method EnterBlock:Int(block:TMDBlock)
	Method LeaveBlock:Int(block:TMDBlock)
	Method EnterSpan:Int(span:TMDSpan)
	Method LeaveSpan:Int(span:TMDSpan)
	Method Text:Int(text:String, textType:EMDTextType)
End Interface

Rem
bbdoc: 
End Rem
Type TMDHtmlCodeHighlighter Abstract

	Private
	Field _codeblock:TStringBuilder
	Field _output:TStringBuilder
	Field _lang:String

	Method _EnterCodeBlock:Int(block:TMDBlockCode)
		_codeblock = New TStringBuilder
		Local lang:SMDAttribute = block.Lang()
		If lang.size > 0 Then
			_lang = String.FromUTF8Bytes(lang.text, lang.size)
		End If
		Return 0
	End Method

	Method _LeaveCodeBlock:Int(block:TMDBlockCode)
		Local processed:Int = Text(_lang, _codeblock.ToString(), _output)
		If Not processed Then
			_output.Append("<pre><code")
			If _lang Then
				_output.Append(" class=~qlanguage-").Append(_lang).Append("~q")
			End If
			_output.Append(">")
			_output.Append(_codeblock.ToString()) ' TODO - escape
			_output.Append("</code></pre>")
		End If
	End Method

	Method _CodeBlockText:Int(txt:String, textType:EMDTextType)
		_codeblock.Append(txt)
	End Method

	Public

	Rem
	bbdoc: Provides the text for a code block.
	returns: #True if the code was processed, #False if the default code block rendering should be used.
	about: If the code is processed, the output should be appended to @output.
	End Rem
	Method Text:Int(lang:String, text:String, output:TStringBuilder) Abstract

End Type

Rem
bbdoc: Html table of contents options.
End Rem
Type TMDHtmlTocOptions
	Field depth:Int
	Field placeHolder:String
End Type

Rem
bbdoc: A Markdown text processor. 
End Rem
Type TMarkdown

	Rem
	bbdoc: Parses markdown @text, feeding parser events into the supplied @renderer. 
	End Rem
	Function Parse:Int(renderer:IMDRenderer, text:String, flags:EMDFlags = EMDFlags.DIALECT_COMMONMARK)
		Return bmx_md_parse(renderer, text, flags)
	End Function

	Rem
	bbdoc: Parses markdown @text, appending HTML into @output.
	End Rem
	Function ParseToHtml:Int(text:String, output:TStringBuilder, parserFlags:EMDFlags = EMDFlags.DIALECT_COMMONMARK,..
				rendererFlags:EMDHtmlFlags = EMDHtmlFlags.NONE,
				tocOptions:TMDHtmlTocOptions = Null,
				codehilite:TMDHtmlCodeHighlighter = Null)
		Local depth:Int = 0
		Local ph:Byte Ptr
		If tocOptions Then
			depth = tocOptions.depth
			ph = tocOptions.placeHolder.ToUTF8String()
		End If
		if codehilite Then
			codehilite._output = output
		End If
		Local res:Int = bmx_md_html(text, output, parserFlags, rendererFlags, depth, ph, codehilite)
		MemFree(ph)
		Return res
	End Function

	Private
	Function _HtmlOutput(text:Byte Ptr, size:UInt, output:TStringBuilder) { nomangle }
		output.AppendUTF8Bytes(text, Int(size))
	End Function

	Function _EnterBlock:Int(parser:IMDRenderer, blockType:EMDBlockType, detail:Byte Ptr) { nomangle }
		Local block:TMDBlock = BlockAs(blockType, detail)
		Return parser.EnterBlock(block)
	End Function

	Function _LeaveBlock:Int(parser:IMDRenderer, blockType:EMDBlockType, detail:Byte Ptr) { nomangle }
		Local block:TMDBlock = BlockAs(blockType, detail)
		Return parser.LeaveBlock(block)
	End Function

	Function _EnterSpan:Int(parser:IMDRenderer, spanType:EMDSpanType, detail:Byte Ptr) { nomangle }
		Local span:TMDSpan = SpanAs(spanType, detail)
		Return parser.EnterSpan(span)
	End Function

	Function _LeaveSpan:Int(parser:IMDRenderer, spanType:EMDSpanType, detail:Byte Ptr) { nomangle }
		Local span:TMDSpan = SpanAs(spanType, detail)
		Return parser.LeaveSpan(span)
	End Function

	Function _Text:Int(parser:IMDRenderer, textType:EMDTextType, text:String) { nomangle }
		Return parser.Text(text, textType)
	End Function

	Function _EnterCodeBlock:Int(hilite:TMDHtmlCodeHighlighter, blockType:EMDBlockType, detail:Byte Ptr) { nomangle }
		Local block:TMDBlockCode = TMDBlockCode(BlockAs(blockType, detail))
		Return hilite._EnterCodeBlock(block)
	End Function

	Function _LeaveCodeBlock:Int(hilite:TMDHtmlCodeHighlighter, blockType:EMDBlockType, detail:Byte Ptr) { nomangle }
		Local block:TMDBlockCode = TMDBlockCode(BlockAs(blockType, detail))
		Return hilite._LeaveCodeBlock(block)
	End Function

	Function _CodeBlockText:Int(hilite:TMDHtmlCodeHighlighter, textType:EMDTextType, text:String) { nomangle }
		Return hilite._CodeBlockText(text, textType)
	End Function

	Function BlockAs:TMDBlock(blockType:EMDBlockType, detail:Byte Ptr)
		Select blockType
			Case EMDBlockType.BLOCK_DOC
				Return New TMDBlockDoc(detail)
			Case EMDBlockType.BLOCK_QUOTE
				Return New TMDBlockQuote(detail)
			Case EMDBlockType.BLOCK_UL
				Return New TMDBlockUL(detail)
			Case EMDBlockType.BLOCK_OL
				Return New TMDBlockOL(detail)
			Case EMDBlockType.BLOCK_LI
				Return New TMDBlockLI(detail)
			Case EMDBlockType.BLOCK_HR
				Return New TMDBlockHR(detail)
			Case EMDBlockType.BLOCK_H
				Return New TMDBlockH(detail)
			Case EMDBlockType.BLOCK_CODE
				Return New TMDBlockCode(detail)
			Case EMDBlockType.BLOCK_HTML
				Return New TMDBlockHtml(detail)
			Case EMDBlockType.BLOCK_P
				Return New TMDBlockP(detail)
			Case EMDBlockType.BLOCK_TABLE
				Return New TMDBlockTable(detail)
			Case EMDBlockType.BLOCK_THEAD
				Return New TMDBlockTHead(detail)
			Case EMDBlockType.BLOCK_TBODY
				Return New TMDBlockTBody(detail)
			Case EMDBlockType.BLOCK_TR
				Return New TMDBlockTR(detail)
			Case EMDBlockType.BLOCK_TH
				Return New TMDBlockTH(detail)
			Case EMDBlockType.BLOCK_TD
				Return New TMDBlockTD(detail)
		End Select
	End Function

	Function SpanAs:TMDSpan(spanType:EMDSpanType, detail:Byte Ptr)
		Select spanType
			Case EMDSpanType.SPAN_EM
				Return New TMDSpanEM(detail)
			Case EMDSpanType.SPAN_STRONG
				Return New TMDSpanStrong(detail)
			Case EMDSpanType.SPAN_A
				Return New TMDSpanA(detail)
			Case EMDSpanType.SPAN_IMG
				Return New TMDSpanImg(detail)
			Case EMDSpanType.SPAN_CODE
				Return New TMDSpanCode(detail)
			Case EMDSpanType.SPAN_DEL
				Return New TMDSpanDel(detail)
			Case EMDSpanType.SPAN_LATEXMATH
				Return New TMDSpanLatexMath(detail)
			Case EMDSpanType.SPAN_LATEXMATH_DISPLAY
				Return New TMDSpanLatexMathDisplay(detail)
			Case EMDSpanType.SPAN_WIKILINK
				Return New TMDSpanWikiLink(detail)
			Case EMDSpanType.SPAN_U
				Return New TMDSpanU(detail)
		End Select
	End Function
End Type

Rem
bbdoc: A markdown block.
about: A block represents a part of document hierarchy structure like a paragraph or list item.
End Rem
Type TMDBlock Abstract
	Field detail:Byte Ptr

	Method GetType:EMDBlockType() Abstract
End Type

Rem
bbdoc: A markdown block document body
End Rem
Type TMDBlockDoc Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_DOC
	End Method
End Type

Rem
bbdoc: A markdown block block quote
End Rem
Type TMDBlockQuote Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_QUOTE
	End Method
End Type

Rem
bbdoc: A markdown block unordered list
End Rem
Type TMDBlockUL Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_UL
	End Method

	Rem
	bbdoc: Non-zero if tight list, zero if loose.
	End Rem
	Method IsTight:Int()
		Return bmx_md_blockul_istight(detail)
	End Method

	Rem
	bbdoc: Item bullet character in Markdown source of the list.
	about: e.g. `-`, `+`, `*`.
	End Rem
	Method Mark:Int()
		Return bmx_md_blockul_mark(detail)
	End Method
End Type

Rem
bbdoc: A markdown block ordered list
End Rem
Type TMDBlockOL Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_OL
	End Method

	Rem
	bbdoc: Start index of the ordered list.
	End Rem
	Method Start:UInt()
		Return bmx_md_blockol_start(detail)
	End Method

	Rem
	bbdoc: Non-zero if tight list, zero if loose.
	End Rem
	Method IsTight:Int()
		Return bmx_md_blockol_istight(detail)
	End Method

	Rem
	bbdoc: Character delimiting the item marks in MarkDown source.
	about: e.g. `.` or `)`
	End Rem
	Method MarkDelimiter:Int()
		Return bmx_md_blockol_markdelimiter(detail)
	End Method

End Type

Rem
bbdoc: A markdown block list item
End Rem
Type TMDBlockLI Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_LI
	End Method

	Rem
	bbdoc: Can be non-zero only with MD_FLAG_TASKLISTS
	End Rem
	Method IsTask:Int()
		Return bmx_md_blockli_istask(detail)
	End Method

	Rem
	bbdoc: If IsTask, then one of `x`, `X` or ` `, otherwise undefined.
	End Rem
	Method TaskMark:Int()
		Return bmx_md_blockli_taskmark(detail)
	End Method

	Rem
	bbdoc: If IsTask, then offset in the input of the char between `[` and `]`.
	End Rem
	Method TaskMarkOffset:UInt()
		Return bmx_md_blockli_taskmarkoffset(detail)
	End Method

End Type

Rem
bbdoc: A markdown block thematic break.
End Rem
Type TMDBlockHR Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_HR
	End Method
End Type

Rem
bbdoc: A markdown header block.
End Rem
Type TMDBlockH Extends TMDBlock

	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_H
	End Method

	Rem
	bbdoc: Header level (1 - 6)
	End Rem
	Method Level:UInt()
		Return bmx_md_blockh_level(detail)
	End Method

	Rem
	bbdoc: An identifier, eg `{#some-id}` or autogenerated from the heading text
	End Rem
	Method Identifier:SMDAttribute()
		Return bmx_md_blockh_identifier(detail)
	End Method

End Type

Rem
bbdoc: A markdown code block.
End Rem
Type TMDBlockCode Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_CODE
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Info:SMDAttribute()
		Return bmx_md_blockcode_info(detail)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method Lang:SMDAttribute()
		Return bmx_md_blockcode_lang(detail)
	End Method

	Rem
	bbdoc: 
	End Rem
	Method FenceChar:Int()
		Return bmx_md_blockcode_fencechar(detail)
	End Method

End Type

Rem
bbdoc: A markdown HTML block.
End Rem
Type TMDBlockHtml Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_HTML
	End Method
End Type

Rem
bbdoc: A markdown paragraph block. 
End Rem
Type TMDBlockP Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_P
	End Method
End Type

Rem
bbdoc: A markdown table block.
End Rem
Type TMDBlockTable Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_TABLE
	End Method

	Rem
	bbdoc: The number of columns in the table.
	End Rem
	Method ColCount:UInt()
		Return bmx_md_blocktable_colcount(detail)
	End Method

	Rem
	bbdoc: The number of header rows.
	about: Always returns 1.
	End Rem
	Method HeadRowCount:UInt()
		Return bmx_md_blocktable_headrowcount(detail)
	End Method

	Rem
	bbdoc: The number of body rows.
	End Rem
	Method BodyRowCount:UInt()
		Return bmx_md_blocktable_bodyrowcount(detail)
	End Method

End Type

Rem
bbdoc: A markdown table head block.
End Rem
Type TMDBlockTHead Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_THEAD
	End Method
End Type

Rem
bbdoc: A markdown table body block.
End Rem
Type TMDBlockTBody Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_TBODY
	End Method
End Type

Rem
bbdoc: A markdown table row block.
End Rem
Type TMDBlockTR Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_TR
	End Method
End Type

Rem
bbdoc: A markdown table header cell block 
End Rem
Type TMDBlockTH Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_TH
	End Method

	Rem
	bbdoc: Alignment
	End Rem
	Method Align:EMDAlign()
		Return bmx_md_blocktd_align(detail)
	End Method

End Type

Rem
bbdoc: A markdown table cell block 
End Rem
Type TMDBlockTD Extends TMDBlock
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDBlockType() Override
		Return EMDBlockType.BLOCK_TD
	End Method

	Rem
	bbdoc: Alignment
	End Rem
	Method Align:EMDAlign()
		Return bmx_md_blocktd_align(detail)
	End Method
End Type

Rem
bbdoc: A markdown span.
End Rem
Type TMDSpan Abstract
	Field detail:Byte Ptr

	Method GetType:EMDSpanType() Abstract
End Type

Rem
bbdoc: A markdown emphasize span. 
End Rem
Type TMDSpanEM Extends TMDSpan
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDSpanType() Override
		Return EMDSpanType.SPAN_EM
	End Method
End Type

Rem
bbdoc: A markdown strong span.
End Rem
Type TMDSpanStrong Extends TMDSpan
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDSpanType() Override
		Return EMDSpanType.SPAN_STRONG
	End Method
End Type

Rem
bbdoc: A markdown hyperlink span.
End Rem
Type TMDSpanA Extends TMDSpan
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDSpanType() Override
		Return EMDSpanType.SPAN_A
	End Method

	Method HRef:SMDAttribute()
		Return bmx_md_spana_href(detail)
	End Method

	Method Title:SMDAttribute()
		Return bmx_md_spana_title(detail)
	End Method

End Type

Rem
bbdoc: A markdown image span.
End Rem
Type TMDSpanImg Extends TMDSpan
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDSpanType() Override
		Return EMDSpanType.SPAN_IMG
	End Method

	Method Src:SMDAttribute()
		Return bmx_md_spanimg_src(detail)
	End Method

	Method Title:SMDAttribute()
		Return bmx_md_spanimg_title(detail)
	End Method

End Type

Rem
bbdoc: A markdown code span.
End Rem
Type TMDSpanCode Extends TMDSpan
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDSpanType() Override
		Return EMDSpanType.SPAN_CODE
	End Method
End Type

Rem
bbdoc: A markdown strikethrough span.
End Rem
Type TMDSpanDel Extends TMDSpan
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDSpanType() Override
		Return EMDSpanType.SPAN_DEL
	End Method
End Type

Rem
bbdoc: A markdown latex math span.
End Rem
Type TMDSpanLatexMath Extends TMDSpan
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDSpanType() Override
		Return EMDSpanType.SPAN_LATEXMATH
	End Method
End Type

Rem
bbdoc: A markdown latex math display span.
End Rem
Type TMDSpanLatexMathDisplay Extends TMDSpan
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDSpanType() Override
		Return EMDSpanType.SPAN_LATEXMATH_DISPLAY
	End Method
End Type

Rem
bbdoc: A markdown wikilink span.
End Rem
Type TMDSpanWikiLink Extends TMDSpan
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDSpanType() Override
		Return EMDSpanType.SPAN_WIKILINK
	End Method

	Method Target:SMDAttribute()
		Return bmx_md_spanwikilink_target(detail)
	End Method
	
End Type

Rem
bbdoc: A markdown underline span.
End Rem
Type TMDSpanU Extends TMDSpan
	Method New(detail:Byte Ptr)
		Self.detail = detail
	End Method

	Method GetType:EMDSpanType() Override
		Return EMDSpanType.SPAN_U
	End Method
End Type

Rem
bbdoc: A markdown attribute.
End Rem
Struct SMDAttribute
	Field text:Byte Ptr
	Field size:UInt
	Field substrTypes:EMDTextType Ptr
	Field substrOffsets:UInt Ptr
End Struct

Private

Extern
	Function bmx_md_parse:Int(parser:IMDRenderer, text:String, flags:EMDFlags)
	Function bmx_md_html:Int(text:String, output:TStringBuilder, parserFlags:EMDFlags, ..
		rendererFlags:EMDHtmlFlags, depth:Int, ph:Byte Ptr, ch:Object)

	Function bmx_md_blockul_istight:Int(detail:Byte Ptr)
	Function bmx_md_blockul_mark:Int(detail:Byte Ptr)

	Function bmx_md_blockol_start:UInt(detail:Byte Ptr)
	Function bmx_md_blockol_istight:Int(detail:Byte Ptr)
	Function bmx_md_blockol_markdelimiter:Int(detail:Byte Ptr)

	Function bmx_md_blockli_istask:Int(detail:Byte Ptr)
	Function bmx_md_blockli_taskmark:Int(detail:Byte Ptr)
	Function bmx_md_blockli_taskmarkoffset:UInt(detail:Byte Ptr)

	Function bmx_md_blockh_level:UInt(detail:Byte Ptr)
	Function bmx_md_blockh_identifier:SMDAttribute(detail:Byte Ptr)

	Function bmx_md_blockcode_info:SMDAttribute(detail:Byte Ptr)
	Function bmx_md_blockcode_lang:SMDAttribute(detail:Byte Ptr)
	Function bmx_md_blockcode_fencechar:Int(detail:Byte Ptr)

	Function bmx_md_blocktable_colcount:UInt(detail:Byte Ptr)
	Function bmx_md_blocktable_headrowcount:UInt(detail:Byte Ptr)
	Function bmx_md_blocktable_bodyrowcount:UInt(detail:Byte Ptr)

	Function bmx_md_blocktd_align:EMDAlign(detail:Byte Ptr)
	
	Function bmx_md_spana_href:SMDAttribute(detail:Byte Ptr)
	Function bmx_md_spana_title:SMDAttribute(detail:Byte Ptr)
	
	Function bmx_md_spanimg_src:SMDAttribute(detail:Byte Ptr)
	Function bmx_md_spanimg_title:SMDAttribute(detail:Byte Ptr)

	Function bmx_md_spanwikilink_target:SMDAttribute(detail:Byte Ptr)

End Extern
