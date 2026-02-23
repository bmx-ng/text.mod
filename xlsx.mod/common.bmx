' Copyright (c) 2026 Bruce A Henderson
' All rights reserved.
' 
' Redistribution and use in source and binary forms, with or without
' modification, are permitted provided that the following conditions are met:
' 
' * Redistributions of source code must retain the above copyright notice, this
'   list of conditions and the following disclaimer.
' 
' * Redistributions in binary form must reproduce the above copyright notice,
'   this list of conditions and the following disclaimer in the documentation
'   and/or other materials provided with the distribution.
' 
' * Neither the name of the copyright holder nor the names of its
'   contributors may be used to endorse or promote products derived from
'   this software without specific prior written permission.
' 
' THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
' IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
' DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
' FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
' DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
' SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
' CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
' OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
' OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
' 
SuperStrict

Import BRL.Color
Import "source.bmx"


Extern
	Function bmx_openxlsx_xldocument_new:Byte Ptr()
	Function bmx_openxlsx_xldocument_free(handle:Byte Ptr)
	Function bmx_openxlsx_xldocument_open(document:Byte Ptr, filename:String)
	Function bmx_openxlsx_xldocument_create(document:Byte Ptr, filename:String, forceOverwrite:Int)
	Function bmx_openxlsx_xldocument_workbook:Byte Ptr(document:Byte Ptr)
	Function bmx_openxlsx_xldocument_save(document:Byte Ptr)
	Function bmx_openxlsx_xldocument_saveas(document:Byte Ptr, filename:String, forceOverwrite:Int)
	Function bmx_openxlsx_xldocument_close(document:Byte Ptr)
	Function bmx_openxlsx_xldocument_name:String(document:Byte Ptr)
	Function bmx_openxlsx_xldocument_path:String(document:Byte Ptr)
	Function bmx_openxlsx_xldocument_property:String(document:Byte Ptr, property:EXLProperty)
	Function bmx_openxlsx_xldocument_setproperty(document:Byte Ptr, property:EXLProperty, value:String)
	Function bmx_openxlsx_xldocument_deleteproperty(document:Byte Ptr, property:EXLProperty)
	Function bmx_openxlsx_xldocument_isopen:Int(document:Byte Ptr)
	Function bmx_openxlsx_xldocument_styles:Byte Ptr(document:Byte Ptr)

	Function bmx_openxlsx_xlworkbook_worksheet:Byte Ptr(document:Byte Ptr, index:Short)
	Function bmx_openxlsx_xlworkbook_worksheet_str:Byte Ptr(document:Byte Ptr, name:String)
	Function bmx_openxlsx_xlworkbook_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlworkbook_worksheetnames:String[](workbook:Byte Ptr)
	Function bmx_openxlsx_xlworkbook_addworksheet(workbook:Byte Ptr, name:String)
	Function bmx_openxlsx_xlworkbook_deletesheet(workbook:Byte Ptr, name:String)
	Function bmx_openxlsx_xlworkbook_clonesheet(workbook:Byte Ptr, name:String, newName:String)
	Function bmx_openxlsx_xlworkbook_setsheetindex(workbook:Byte Ptr, name:String, index:UInt)
	Function bmx_openxlsx_xlworkbook_indexofsheet:UInt(workbook:Byte Ptr, name:String)
	Function bmx_openxlsx_xlworkbook_typeofsheet:EXLSheetType(workbook:Byte Ptr, name:String)
	Function bmx_openxlsx_xlworkbook_typeofsheetbyindex:EXLSheetType(workbook:Byte Ptr, index:UInt)
	Function bmx_openxlsx_xlworkbook_worksheetexists:Int(workbook:Byte Ptr, name:String)

	Function bmx_openxlsx_xlworksheet_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_cell:Byte Ptr(worksheet:Byte Ptr, reference:String)
	Function bmx_openxlsx_xlworksheet_cell_ref:Byte Ptr(worksheet:Byte Ptr, reference:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_visibility:EXLSheetState(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_setvisibility(worksheet:Byte Ptr, state:EXLSheetState)
	Function bmx_openxlsx_xlworksheet_color:SColor8(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_setcolor(worksheet:Byte Ptr, color:SColor8)
	Function bmx_openxlsx_xlworksheet_index:Short(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_setindex(worksheet:Byte Ptr, index:Short)
	Function bmx_openxlsx_xlworksheet_name:String(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_setname(worksheet:Byte Ptr, name:String)
	Function bmx_openxlsx_xlworksheet_isselected:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_setselected(worksheet:Byte Ptr, selected:Int)
	Function bmx_openxlsx_xlworksheet_isactive:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_setactive(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_clone(worksheet:Byte Ptr, newName:String)
	Function bmx_openxlsx_xlworksheet_range:Byte Ptr(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_range_str:Byte Ptr(worksheet:Byte Ptr, topLeft:String, bottomRight:String)
	Function bmx_openxlsx_xlworksheet_range_ref:Byte Ptr(worksheet:Byte Ptr, topLeft:Byte Ptr, bottomRight:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_range_refstr:Byte Ptr(worksheet:Byte Ptr, rangeReference:String)
	Function bmx_openxlsx_xlworksheet_row:Byte Ptr(worksheet:Byte Ptr, rowNumber:UInt)
	Function bmx_openxlsx_xlworksheet_rows:Byte Ptr(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_rows_count:Byte Ptr(worksheet:Byte Ptr, rowCount:UInt)
	Function bmx_openxlsx_xlworksheet_rows_range:Byte Ptr(worksheet:Byte Ptr, firstRow:UInt, lastRow:UInt)
	Function bmx_openxlsx_xlworksheet_column:Byte Ptr(worksheet:Byte Ptr, columnNumber:Short)
	Function bmx_openxlsx_xlworksheet_column_str:Byte Ptr(worksheet:Byte Ptr, columnRef:String)
	Function bmx_openxlsx_xlworksheet_lastcell:Byte Ptr(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_columncount:Short(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_rowcount:UInt(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_deleterow(worksheet:Byte Ptr, rowNumber:UInt)
	Function bmx_openxlsx_xlworksheet_updatesheetname(worksheet:Byte Ptr, oldName:String, newName:String)
	Function bmx_openxlsx_xlworksheet_protectsheet:Int(worksheet:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlworksheet_protectobjects:Int(worksheet:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlworksheet_protectscenarios:Int(worksheet:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlworksheet_allowinsertcolumns:Int(worksheet:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlworksheet_allowinsertrows:Int(worksheet:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlworksheet_allowdeletecolumns:Int(worksheet:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlworksheet_allowdeleterows:Int(worksheet:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlworksheet_allowselectlockedcells:Int(worksheet:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlworksheet_allowselectunlockedcells:Int(worksheet:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlworksheet_setpasswordhash:Int(worksheet:Byte Ptr, hash:String)
	Function bmx_openxlsx_xlworksheet_setpassword:Int(worksheet:Byte Ptr, password:String)
	Function bmx_openxlsx_xlworksheet_clearpassword:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_clearsheetprotection:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_sheetprotected:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_objectsprotected:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_scenariosprotected:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_insertcolumnsallowed:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_insertrowsallowed:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_deletecolumnsallowed:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_deleterowsallowed:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_selectlockedcellsallowed:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_selectunlockedcellsallowed:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_passwordhash:String(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_passwordisset:Int(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_mergecells(worksheet:Byte Ptr, range:Byte Ptr, emptyHiddenCells:Int)
	Function bmx_openxlsx_xlworksheet_mergecells_str(worksheet:Byte Ptr, range:String, emptyHiddenCells:Int)
	Function bmx_openxlsx_xlworksheet_unmergecells(worksheet:Byte Ptr, range:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_unmergecells_str(worksheet:Byte Ptr, range:String)
	Function bmx_openxlsx_xlworksheet_conditionalformats:Byte Ptr(worksheet:Byte Ptr)
	Function bmx_openxlsx_xlworksheet_getcolumnformat:Size_T(worksheet:Byte Ptr, column:Short)
	Function bmx_openxlsx_xlworksheet_getcolumnformat_str:Size_T(worksheet:Byte Ptr, columnRef:String)
	Function bmx_openxlsx_xlworksheet_setcolumnformat(worksheet:Byte Ptr, column:Short, cellFormatIndex:Size_T)
	Function bmx_openxlsx_xlworksheet_setcolumnformat_str(worksheet:Byte Ptr, columnRef:String, cellFormatIndex:Size_T)
	Function bmx_openxlsx_xlworksheet_getrowformat:Size_T(worksheet:Byte Ptr, row:UInt)
	Function bmx_openxlsx_xlworksheet_setrowformat(worksheet:Byte Ptr, row:UInt, cellFormatIndex:Size_T)

	Function bmx_openxlsx_xlcell_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcell_setvalue_double(cell:Byte Ptr, value:Double)
	Function bmx_openxlsx_xlcell_setvalue_long(cell:Byte Ptr, value:Long)
	Function bmx_openxlsx_xlcell_setvalue_ulong(cell:Byte Ptr, value:ULong)
	Function bmx_openxlsx_xlcell_setvalue_string(cell:Byte Ptr, value:String)
	Function bmx_openxlsx_xlcell_setvalue_bool(cell:Byte Ptr, value:Int)
	Function bmx_openxlsx_xlcell_getvalue_double:Double(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_getvalue_long:Long(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_getvalue_ulong:ULong(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_getvalue_string:String(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_getvalue_bool:Int(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_typeasstring:String(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_type:EXLValueType(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_setvalue_cell(cell:Byte Ptr, value:Byte Ptr)
	Function bmx_openxlsx_xlcell_hasformula:Int(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_formula:String(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_setformula(cell:Byte Ptr, formula:String)
	Function bmx_openxlsx_xlcell_clearformula(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_valuetype:EXLValueType(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_empty:Int(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_cellformat:Size_T(cell:Byte Ptr)
	Function bmx_openxlsx_xlcell_setcellformat:Int(cell:Byte Ptr, cellFormatIndex:Size_T)

	Function bmx_openxlsx_xlcellreference_new_celladdress:Byte Ptr(cellAddress:String)
	Function bmx_openxlsx_xlcellreference_new_rowcolumn:Byte Ptr(row:UInt, column:Short)
	Function bmx_openxlsx_xlcellreference_new_rowcolumn_str:Byte Ptr(row:UInt, column:String)
	Function bmx_openxlsx_xlcellreference_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcellreference_row:UInt(cellReference:Byte Ptr)
	Function bmx_openxlsx_xlcellreference_setrow(cellReference:Byte Ptr, row:UInt)
	Function bmx_openxlsx_xlcellreference_column:Short(cellReference:Byte Ptr)
	Function bmx_openxlsx_xlcellreference_setcolumn(cellReference:Byte Ptr, column:Short)
	Function bmx_openxlsx_xlcellreference_setrowcolumn(cellReference:Byte Ptr, row:UInt, column:Short)
	Function bmx_openxlsx_xlcellreference_address:String(cellReference:Byte Ptr)
	Function bmx_openxlsx_xlcellreference_setaddress(cellReference:Byte Ptr, address:String)
	Function bmx_openxlsx_xlcellreference_rowasstring:String(row:UInt)
	Function bmx_openxlsx_xlcellreference_rowasnumber:UInt(row:String)
	Function bmx_openxlsx_xlcellreference_columnasstring:String(column:Short)
	Function bmx_openxlsx_xlcellreference_columnasnumber:Short(column:String)

	Function bmx_openxlsx_xlcellrange_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_address:String(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_topleft:Byte Ptr(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_bottomright:Byte Ptr(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_numrows:UInt(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_numcolumns:Short(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_iterator:Byte Ptr(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_distance:ULong(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_setvalue_double(cellRange:Byte Ptr, value:Double)
	Function bmx_openxlsx_xlcellrange_setvalue_long(cellRange:Byte Ptr, value:Long)
	Function bmx_openxlsx_xlcellrange_setvalue_ulong(cellRange:Byte Ptr, value:ULong)
	Function bmx_openxlsx_xlcellrange_setvalue_string(cellRange:Byte Ptr, value:String)
	Function bmx_openxlsx_xlcellrange_setvalue_bool(cellRange:Byte Ptr, value:Int)
	Function bmx_openxlsx_xlcellrange_setformat:Int(cellRange:Byte Ptr, formatIndex:Size_T)

	Function bmx_openxlsx_xlcellrange_iterator_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_iterator_hasnext:Int(iterator:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_iterator_next:Byte Ptr(iterator:Byte Ptr)

	Function bmx_openxlsx_xlrow_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlrow_empty:Int(row:Byte Ptr)
	Function bmx_openxlsx_xlrow_height:Float(row:Byte Ptr)
	Function bmx_openxlsx_xlrow_setheight(row:Byte Ptr, height:Float)
	Function bmx_openxlsx_xlrow_descent:Float(row:Byte Ptr)
	Function bmx_openxlsx_xlrow_setdescent(row:Byte Ptr, descent:Float)
	Function bmx_openxlsx_xlrow_ishidden:Int(row:Byte Ptr)
	Function bmx_openxlsx_xlrow_sethidden(row:Byte Ptr, state:Int)
	Function bmx_openxlsx_xlrow_rownumber:UInt(row:Byte Ptr)
	Function bmx_openxlsx_xlrow_cellcount:Short(row:Byte Ptr)
	Function bmx_openxlsx_xlrow_cells:Byte Ptr(row:Byte Ptr)
	Function bmx_openxlsx_xlrow_cells_count:Byte Ptr(row:Byte Ptr, cellCount:Short)
	Function bmx_openxlsx_xlrow_cells_range:Byte Ptr(row:Byte Ptr, firstCell:Short, lastCell:Short)
		
	Function bmx_openxlsx_xlrowrange_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlrowrange_rowcount:UInt(rowRange:Byte Ptr)
	Function bmx_openxlsx_xlrowrange_iterator:Byte Ptr(rowRange:Byte Ptr)

	Function bmx_openxlsx_xlrowrange_iterator_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlrowrange_iterator_hasnext:Int(iterator:Byte Ptr)
	Function bmx_openxlsx_xlrowrange_iterator_next:Byte Ptr(iterator:Byte Ptr)

	Function bmx_openxlsx_xlrowdatarange_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlrowdatarange_iterator:Byte Ptr(rowDataRange:Byte Ptr)
	Function bmx_openxlsx_xlrowdatarange_setvalue_double(rowDataRange:Byte Ptr, value:Double)
	Function bmx_openxlsx_xlrowdatarange_setvalue_long(rowDataRange:Byte Ptr, value:Long)
	Function bmx_openxlsx_xlrowdatarange_setvalue_ulong(rowDataRange:Byte Ptr, value:ULong)
	Function bmx_openxlsx_xlrowdatarange_setvalue_string(rowDataRange:Byte Ptr, value:String)
	Function bmx_openxlsx_xlrowdatarange_setvalue_bool(rowDataRange:Byte Ptr, value:Int)

	Function bmx_openxlsx_xlrowdatarange_iterator_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlrowdatarange_iterator_hasnext:Int(iterator:Byte Ptr)
	Function bmx_openxlsx_xlrowdatarange_iterator_next:Byte Ptr(iterator:Byte Ptr)

	Function bmx_openxlsx_xlcolumn_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcolumn_width:Float(column:Byte Ptr)
	Function bmx_openxlsx_xlcolumn_setwidth(column:Byte Ptr, width:Float)
	Function bmx_openxlsx_xlcolumn_ishidden:Int(column:Byte Ptr)
	Function bmx_openxlsx_xlcolumn_sethidden(column:Byte Ptr, state:Int)

	Function bmx_openxlsx_xlstyles_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlstyles_fonts:Byte Ptr(styles:Byte Ptr)
	Function bmx_openxlsx_xlstyles_fills:Byte Ptr(styles:Byte Ptr)
	Function bmx_openxlsx_xlstyles_borders:Byte Ptr(styles:Byte Ptr)
	Function bmx_openxlsx_xlstyles_cellformats:Byte Ptr(styles:Byte Ptr)
	Function bmx_openxlsx_xlstyles_cellstyles:Byte Ptr(styles:Byte Ptr)
	Function bmx_openxlsx_xlstyles_numberformats:Byte Ptr(styles:Byte Ptr)

	Function bmx_openxlsx_xlfonts_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlfonts_count:Size_T(fonts:Byte Ptr)
	Function bmx_openxlsx_xlfonts_fontbyindex:Byte Ptr(fonts:Byte Ptr, index:Size_T)
	Function bmx_openxlsx_xlfonts_create:Size_T(fonts:Byte Ptr, copyFrom:Byte Ptr)
	
	Function bmx_openxlsx_xlfont_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlfont_fontname:String(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_fontcharset:Size_T(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_fontfamily:Size_T(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_fontsize:Size_T(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_fontcolor:SColor8(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_bold:Int(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_italic:Int(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_strikethrough:Int(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_underline:EXLUnderlineStyle(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_scheme:EXLFontSchemeStyle(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_vertalign:EXLVerticalAlignRunStyle(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_outline:Int(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_shadow:Int(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_condense:Int(font:Byte Ptr)
	Function bmx_openxlsx_xlfont_setfontname:Int(font:Byte Ptr, newName:String)
	Function bmx_openxlsx_xlfont_setfontcharset:Int(font:Byte Ptr, newCharset:Size_T)
	Function bmx_openxlsx_xlfont_setfontfamily:Int(font:Byte Ptr, newFamily:Size_T)
	Function bmx_openxlsx_xlfont_setfontsize:Int(font:Byte Ptr, newSize:Size_T)
	Function bmx_openxlsx_xlfont_setfontcolor:Int(font:Byte Ptr, newColor:SColor8)
	Function bmx_openxlsx_xlfont_setbold:Int(font:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlfont_setitalic:Int(font:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlfont_setstrikethrough:Int(font:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlfont_setunderline:Int(font:Byte Ptr, underline:EXLUnderlineStyle)
	Function bmx_openxlsx_xlfont_setscheme:Int(font:Byte Ptr, scheme:EXLFontSchemeStyle)
	Function bmx_openxlsx_xlfont_setvertalign:Int(font:Byte Ptr, vertAlign:EXLVerticalAlignRunStyle)
	Function bmx_openxlsx_xlfont_setoutline:Int(font:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlfont_setshadow:Int(font:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlfont_setcondense:Int(font:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlfont_summary:String(font:Byte Ptr)

	Function bmx_openxlsx_xlfills_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlfills_count:Size_T(fills:Byte Ptr)
	Function bmx_openxlsx_xlfills_fillbyindex:Byte Ptr(fills:Byte Ptr, index:Size_T)
	Function bmx_openxlsx_xlfills_create:Size_T(fills:Byte Ptr, copyFrom:Byte Ptr)

	Function bmx_openxlsx_xlfill_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlfill_filltype:EXLFillType(fill:Byte Ptr)
	Function bmx_openxlsx_xlfill_setfilltype:Int(fill:Byte Ptr, fillType:EXLFillType, force:Int)
	Function bmx_openxlsx_xlfill_gradienttype:EXLGradientType(fill:Byte Ptr)
	Function bmx_openxlsx_xlfill_degree:Double(fill:Byte Ptr)
	Function bmx_openxlsx_xlfill_left:Double(fill:Byte Ptr)
	Function bmx_openxlsx_xlfill_right:Double(fill:Byte Ptr)
	Function bmx_openxlsx_xlfill_top:Double(fill:Byte Ptr)
	Function bmx_openxlsx_xlfill_bottom:Double(fill:Byte Ptr)
	Function bmx_openxlsx_xlfill_stops:Byte Ptr(fill:Byte Ptr)
	Function bmx_openxlsx_xlfill_patterntype:EXLPatternType(fill:Byte Ptr)
	Function bmx_openxlsx_xlfill_color:SColor8(fill:Byte Ptr)
	Function bmx_openxlsx_xlfill_backgroundcolor:SColor8(fill:Byte Ptr)
	Function bmx_openxlsx_xlfill_setgradienttype:Int(fill:Byte Ptr, newType:EXLGradientType)
	Function bmx_openxlsx_xlfill_setdegree:Int(fill:Byte Ptr, newDegree:Double)
	Function bmx_openxlsx_xlfill_setleft:Int(fill:Byte Ptr, newLeft:Double)
	Function bmx_openxlsx_xlfill_setright:Int(fill:Byte Ptr, newRight:Double)
	Function bmx_openxlsx_xlfill_settop:Int(fill:Byte Ptr, newTop:Double)
	Function bmx_openxlsx_xlfill_setbottom:Int(fill:Byte Ptr, newBottom:Double)
	Function bmx_openxlsx_xlfill_setpatterntype:Int(fill:Byte Ptr, newPatternType:EXLPatternType)
	Function bmx_openxlsx_xlfill_setcolor:Int(fill:Byte Ptr, newColor:SColor8)
	Function bmx_openxlsx_xlfill_setbackgroundcolor:Int(fill:Byte Ptr, newColor:SColor8)
	Function bmx_openxlsx_xlfill_summary:String(fill:Byte Ptr)

	Function bmx_openxlsx_xlborders_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlborders_count:Size_T(borders:Byte Ptr)
	Function bmx_openxlsx_xlborders_borderbyindex:Byte Ptr(borders:Byte Ptr, index:Size_T)
	Function bmx_openxlsx_xlborders_create:Size_T(borders:Byte Ptr, copyFrom:Byte Ptr)

	Function bmx_openxlsx_xlborder_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlborder_diagonalup:Int(border:Byte Ptr)
	Function bmx_openxlsx_xlborder_diagonaldown:Int(border:Byte Ptr)
	Function bmx_openxlsx_xlborder_outline:Int(border:Byte Ptr)
	Function bmx_openxlsx_xlborder_left:Byte Ptr(border:Byte Ptr)
	Function bmx_openxlsx_xlborder_right:Byte Ptr(border:Byte Ptr)
	Function bmx_openxlsx_xlborder_top:Byte Ptr(border:Byte Ptr)
	Function bmx_openxlsx_xlborder_bottom:Byte Ptr(border:Byte Ptr)
	Function bmx_openxlsx_xlborder_diagonal:Byte Ptr(border:Byte Ptr)
	Function bmx_openxlsx_xlborder_vertical:Byte Ptr(border:Byte Ptr)
	Function bmx_openxlsx_xlborder_horizontal:Byte Ptr(border:Byte Ptr)
	Function bmx_openxlsx_xlborder_setdiagonalup:Int(border:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlborder_setdiagonaldown:Int(border:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlborder_setoutline:Int(border:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlborder_setline:Int(border:Byte Ptr, lineType:EXLLineType, lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double)
	Function bmx_openxlsx_xlborder_setleft:Int(border:Byte Ptr, lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double)
	Function bmx_openxlsx_xlborder_setright:Int(border:Byte Ptr, lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double)
	Function bmx_openxlsx_xlborder_settop:Int(border:Byte Ptr, lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double)
	Function bmx_openxlsx_xlborder_setbottom:Int(border:Byte Ptr, lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double)
	Function bmx_openxlsx_xlborder_setdiagonal:Int(border:Byte Ptr, lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double)
	Function bmx_openxlsx_xlborder_setvertical:Int(border:Byte Ptr, lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double)
	Function bmx_openxlsx_xlborder_sethorizontal:Int(border:Byte Ptr, lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double)
	Function bmx_openxlsx_xlborder_summary:String(border:Byte Ptr)

	Function bmx_openxlsx_xlline_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlline_style:EXLLineStyle(line:Byte Ptr)
	Function bmx_openxlsx_xlline_color:Byte Ptr(line:Byte Ptr)
	Function bmx_openxlsx_xlline_summary:String(line:Byte Ptr)

	Function bmx_openxlsx_xldatabarcolor_free(handle:Byte Ptr)
	Function bmx_openxlsx_xldatabarcolor_rgb:SColor8(databarColor:Byte Ptr)
	Function bmx_openxlsx_xldatabarcolor_tint:Double(databarColor:Byte Ptr)
	Function bmx_openxlsx_xldatabarcolor_automatic:Int(databarColor:Byte Ptr)
	Function bmx_openxlsx_xldatabarcolor_indexed:UInt(databarColor:Byte Ptr)
	Function bmx_openxlsx_xldatabarcolor_theme:UInt(databarColor:Byte Ptr)
	Function bmx_openxlsx_xldatabarcolor_setrgb:Int(databarColor:Byte Ptr, newColor:SColor8)
	Function bmx_openxlsx_xldatabarcolor_setautomatic:Int(databarColor:Byte Ptr, set:Int)
	Function bmx_openxlsx_xldatabarcolor_setindexed:Int(databarColor:Byte Ptr, newIndex:UInt)
	Function bmx_openxlsx_xldatabarcolor_settheme:Int(databarColor:Byte Ptr, newTheme:UInt)
	Function bmx_openxlsx_xldatabarcolor_settint:Int(databarColor:Byte Ptr, newTint:Double)
	Function bmx_openxlsx_xldatabarcolor_summary:String(databarColor:Byte Ptr)

	Function bmx_openxlsx_xlcellformats_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcellformats_count:Size_T(cellFormats:Byte Ptr)
	Function bmx_openxlsx_xlcellformats_cellformatbyindex:Byte Ptr(cellFormats:Byte Ptr, index:Size_T)
	Function bmx_openxlsx_xlcellformats_create:Size_T(cellFormats:Byte Ptr, copyFrom:Byte Ptr)

	Function bmx_openxlsx_xlcellformat_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_numberformatid:UInt(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_fontindex:Size_T(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_fillindex:Size_T(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_borderindex:Size_T(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_xfid:Size_T(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_applynumberformat:Int(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_applyfont:Int(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_applyfill:Int(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_applyborder:Int(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_applyalignment:Int(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_applyprotection:Int(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_quoteprefix:Int(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_pivotbutton:Int(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_locked:Int(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_hidden:Int(cellFormat:Byte Ptr)
	Function bmx_openxlsx_xlcellformat_alignment:Byte Ptr(cellFormat:Byte Ptr, createIfMissing:Int)
	Function bmx_openxlsx_xlcellformat_setnumberformatid:Int(cellFormat:Byte Ptr, newNumFmtId:UInt)
	Function bmx_openxlsx_xlcellformat_setfontindex:Int(cellFormat:Byte Ptr, newFontIndex:Size_T)
	Function bmx_openxlsx_xlcellformat_setfillindex:Int(cellFormat:Byte Ptr, newFillIndex:Size_T)
	Function bmx_openxlsx_xlcellformat_setborderindex:Int(cellFormat:Byte Ptr, newBorderIndex:Size_T)
	Function bmx_openxlsx_xlcellformat_setxfid:Int(cellFormat:Byte Ptr, newXfId:Size_T)
	Function bmx_openxlsx_xlcellformat_setapplynumberformat:Int(cellFormat:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellformat_setapplyfont:Int(cellFormat:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellformat_setapplyfill:Int(cellFormat:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellformat_setapplyborder:Int(cellFormat:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellformat_setapplyalignment:Int(cellFormat:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellformat_setapplyprotection:Int(cellFormat:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellformat_setquoteprefix:Int(cellFormat:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellformat_setpivotbutton:Int(cellFormat:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellformat_setlocked:Int(cellFormat:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellformat_sethidden:Int(cellFormat:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellformat_summary:String(cellFormat:Byte Ptr)

	Function bmx_openxlsx_xlalignment_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlalignment_horizontal:EXLAlignmentStyle(alignment:Byte Ptr)
	Function bmx_openxlsx_xlalignment_vertical:EXLAlignmentStyle(alignment:Byte Ptr)
	Function bmx_openxlsx_xlalignment_textrotation:Short(alignment:Byte Ptr)
	Function bmx_openxlsx_xlalignment_wraptext:Int(alignment:Byte Ptr)
	Function bmx_openxlsx_xlalignment_indent:UInt(alignment:Byte Ptr)
	Function bmx_openxlsx_xlalignment_relativeindent:Int(alignment:Byte Ptr)
	Function bmx_openxlsx_xlalignment_justifylastline:Int(alignment:Byte Ptr)
	Function bmx_openxlsx_xlalignment_shrinktofit:Int(alignment:Byte Ptr)
	Function bmx_openxlsx_xlalignment_readingorder:UInt(alignment:Byte Ptr)
	Function bmx_openxlsx_xlalignment_sethorizontal:Int(alignment:Byte Ptr, newStyle:EXLAlignmentStyle)
	Function bmx_openxlsx_xlalignment_setvertical:Int(alignment:Byte Ptr, newStyle:EXLAlignmentStyle)
	Function bmx_openxlsx_xlalignment_settextrotation:Int(alignment:Byte Ptr, rotation:Short)
	Function bmx_openxlsx_xlalignment_setwraptext:Int(alignment:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlalignment_setindent:Int(alignment:Byte Ptr, newIndent:UInt)
	Function bmx_openxlsx_xlalignment_setrelativeindent:Int(alignment:Byte Ptr, newIndent:Int)
	Function bmx_openxlsx_xlalignment_setjustifylastline:Int(alignment:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlalignment_setshrinktofit:Int(alignment:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlalignment_setreadingorder:Int(alignment:Byte Ptr, newReadingOrder:UInt)
	Function bmx_openxlsx_xlalignment_summary:String(alignment:Byte Ptr)

	Function bmx_openxlsx_xlcellstyles_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcellstyles_count:Size_T(cellStyles:Byte Ptr)
	Function bmx_openxlsx_xlcellstyles_cellstylebyindex:Byte Ptr(cellStyles:Byte Ptr, index:Size_T)
	Function bmx_openxlsx_xlcellstyles_create:Size_T(cellStyles:Byte Ptr, copyFrom:Byte Ptr)

	Function bmx_openxlsx_xlcellstyle_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcellstyle_empty:Int(cellStyle:Byte Ptr)
	Function bmx_openxlsx_xlcellstyle_name:String(cellStyle:Byte Ptr)
	Function bmx_openxlsx_xlcellstyle_xfid:Size_T(cellStyle:Byte Ptr)
	Function bmx_openxlsx_xlcellstyle_builtinid:UInt(cellStyle:Byte Ptr)
	Function bmx_openxlsx_xlcellstyle_outlinestyle:UInt(cellStyle:Byte Ptr)
	Function bmx_openxlsx_xlcellstyle_hidden:Int(cellStyle:Byte Ptr)
	Function bmx_openxlsx_xlcellstyle_custombuiltin:Int(cellStyle:Byte Ptr)
	Function bmx_openxlsx_xlcellstyle_setname:Int(cellStyle:Byte Ptr, newName:String)
	Function bmx_openxlsx_xlcellstyle_setxfid:Int(cellStyle:Byte Ptr, newXfId:Size_T)
	Function bmx_openxlsx_xlcellstyle_setbuiltinid:Int(cellStyle:Byte Ptr, newBuiltinId:UInt)
	Function bmx_openxlsx_xlcellstyle_setoutlinestyle:Int(cellStyle:Byte Ptr, newOutlineStyle:UInt)
	Function bmx_openxlsx_xlcellstyle_sethidden:Int(cellStyle:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellstyle_setcustombuiltin:Int(cellStyle:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcellstyle_summary:String(cellStyle:Byte Ptr)

	Function bmx_openxlsx_xlnumberformats_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlnumberformats_count:Size_T(numberFormats:Byte Ptr)
	Function bmx_openxlsx_xlnumberformats_numberformatbyindex:Byte Ptr(numberFormats:Byte Ptr, index:Size_T)
	Function bmx_openxlsx_xlnumberformats_numberformatbyid:Byte Ptr(numberFormats:Byte Ptr, numFmtId:UInt)
	Function bmx_openxlsx_xlnumberformats_numberformatidfromindex:UInt(numberFormats:Byte Ptr, index:Size_T)
	Function bmx_openxlsx_xlnumberformats_create:Size_T(numberFormats:Byte Ptr, copyFrom:Byte Ptr)

	Function bmx_openxlsx_xlnumberformat_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlnumberformat_numberformatid:UInt(numberFormat:Byte Ptr)
	Function bmx_openxlsx_xlnumberformat_formatcode:String(numberFormat:Byte Ptr)
	Function bmx_openxlsx_xlnumberformat_setnumberformatid:Int(numberFormat:Byte Ptr, newNumberFormatId:UInt)
	Function bmx_openxlsx_xlnumberformat_setformatcode:Int(numberFormat:Byte Ptr, newFormatCode:String)
	Function bmx_openxlsx_xlnumberformat_summary:String(numberFormat:Byte Ptr)

	Function bmx_openxlsx_xlconditionalformats_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlconditionalformats_count:Size_T(conditionalFormats:Byte Ptr)
	Function bmx_openxlsx_xlconditionalformats_conditionalformatbyindex:Byte Ptr(conditionalFormats:Byte Ptr, index:Size_T)
	Function bmx_openxlsx_xlconditionalformats_create:Size_T(conditionalFormats:Byte Ptr, copyFrom:Byte Ptr)

	Function bmx_openxlsx_xlconditionalformat_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlconditionalformat_empty:Int(conditionalFormat:Byte Ptr)
	Function bmx_openxlsx_xlconditionalformat_sqref:String(conditionalFormat:Byte Ptr)
	Function bmx_openxlsx_xlconditionalformat_cfrules:Byte Ptr(conditionalFormat:Byte Ptr)
	Function bmx_openxlsx_xlconditionalformat_setsqref:Int(conditionalFormat:Byte Ptr, newSqref:String)

	Function bmx_openxlsx_xlcfrules_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcfrules_empty:Int(cfRulesPtr:Byte Ptr)
	Function bmx_openxlsx_xlcfrules_maxpriorityvalue:Short(cfRulesPtr:Byte Ptr)
	Function bmx_openxlsx_xlcfrules_setpriority:Int(cfRulesPtr:Byte Ptr, cfRuleIndex:Size_T, newPriority:Short)
	Function bmx_openxlsx_xlcfrules_renumberpriorities(cfRulesPtr:Byte Ptr, increment:Short)
	Function bmx_openxlsx_xlcfrules_count:Size_T(cfRulesPtr:Byte Ptr)
	Function bmx_openxlsx_xlcfrules_cfrulebyindex:Byte Ptr(cfRulesPtr:Byte Ptr, index:Size_T)
	Function bmx_openxlsx_xlcfrules_create:Size_T(cfRulesPtr:Byte Ptr, copyFrom:Byte Ptr)

	Function bmx_openxlsx_xlcfrule_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_empty:Int(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_formula:String(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_type:EXLCfType(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_dxfid:Size_T(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_priority:Short(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_stopiftrue:Int(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_aboveaverage:Int(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_percent:Int(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_bottom:Int(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_operator:EXLCfOperator(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_text:String(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_timeperiod:EXLCfTimePeriod(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_rank:Short(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_stddev:Int(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_equalaverage:Int(cfRule:Byte Ptr)
	Function bmx_openxlsx_xlcfrule_settype:Int(cfRule:Byte Ptr, newType:EXLCfType)
	Function bmx_openxlsx_xlcfrule_setdxfid:Int(cfRule:Byte Ptr, newDxfId:Size_T)
	Function bmx_openxlsx_xlcfrule_setstopiftrue:Int(cfRule:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcfrule_setaboveaverage:Int(cfRule:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcfrule_setpercent:Int(cfRule:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcfrule_setbottom:Int(cfRule:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcfrule_setoperator:Int(cfRule:Byte Ptr, newOperator:EXLCfOperator)
	Function bmx_openxlsx_xlcfrule_settext:Int(cfRule:Byte Ptr, newText:String)
	Function bmx_openxlsx_xlcfrule_settimeperiod:Int(cfRule:Byte Ptr, newTimePeriod:EXLCfTimePeriod)
	Function bmx_openxlsx_xlcfrule_setrank:Int(cfRule:Byte Ptr, newRank:Short)
	Function bmx_openxlsx_xlcfrule_setstddev:Int(cfRule:Byte Ptr, set:Int)
	Function bmx_openxlsx_xlcfrule_setequalaverage:Int(cfRule:Byte Ptr, set:Int)

	Function bmx_openxlsx_xlgradientstops_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlgradientstops_count:Size_T(gradientStops:Byte Ptr)
	Function bmx_openxlsx_xlgradientstops_stopbyindex:Byte Ptr(gradientStops:Byte Ptr, index:Size_T)
	Function bmx_openxlsx_xlgradientstops_create:Size_T(gradientStops:Byte Ptr, copyFrom:Byte Ptr)

	Function bmx_openxlsx_xlgradientstop_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlgradientstop_color:Byte Ptr(gradientStop:Byte Ptr)
	Function bmx_openxlsx_xlgradientstop_position:Double(gradientStop:Byte Ptr)
	Function bmx_openxlsx_xlgradientstop_setposition:Int(gradientStop:Byte Ptr, newPosition:Double)
	Function bmx_openxlsx_xlgradientstop_summary:String(gradientStop:Byte Ptr)
	
End Extern

Const XLDefaultFontColor:String = "FF000000"
Const XLDefaultFontSize:UInt = 11
Const XLDefaultFontName:String = "Arial"
Const XLForceFillType:Int = True
Const XLDeleteProperty:UInt = $ffffffff
Const XLCreateIfMissing:Int = True

Rem
bbdoc: The maximum number of columns in an XLSX worksheet.
End Rem
Const XLSX_MAX_COLS:Short = 16384
Rem
bbdoc: The maximum number of rows in an XLSX worksheet.
End Rem
Const XLSX_MAX_ROWS:UInt = 1048576

Enum EXLValueType
	ValueType_Empty
	ValueType_Boolean
	ValueType_Integer
	ValueType_Float
	ValueType_Error
	ValueType_String
End Enum

Enum EXLSheetType
	Worksheet
	Chartsheet
	Dialogsheet
	Macrosheet
End Enum

Enum EXLSheetState
	Visible
	Hidden
	VeryHidden
End Enum

Enum EXLProperty
	Title
	Subject
	Creator
	Keywords
	Description
	LastModifiedBy
	LastPrinted
	CreationDate
	ModificationDate
	Category
	Application
	DocSecurity
	ScaleCrop
	Manager
	Company
	LinksUpToDate
	SharedDoc
	HyperlinkBase
	HyperlinksChanged
	AppVersion
End Enum

Enum EXLUnderlineStyle:Byte
	XLUnderlineNone    = 0
	XLUnderlineSingle  = 1
	XLUnderlineDouble  = 2
	XLUnderlineInvalid = 255
End Enum

Enum EXLFontSchemeStyle:Byte
	XLFontSchemeNone    =   0
	XLFontSchemeMajor   =   1
	XLFontSchemeMinor   =   2
	XLFontSchemeInvalid = 255
End Enum

Enum EXLVerticalAlignRunStyle:Byte
	XLBaseline                =   0
	XLSubscript               =   1
	XLSuperscript             =   2
	XLVerticalAlignRunInvalid = 255
End Enum

Enum EXLFillType:Byte
	XLGradientFill     =   0
	XLPatternFill      =   1
	XLFillTypeInvalid  = 255
End Enum

Enum EXLGradientType:Byte
	XLGradientLinear      =   0
	XLGradientPath        =   1
	XLGradientTypeInvalid = 255
End Enum

Enum EXLPatternType:Byte
	XLPatternNone            =   0
	XLPatternSolid           =   1
	XLPatternMediumGray      =   2
	XLPatternDarkGray        =   3
	XLPatternLightGray       =   4
	XLPatternDarkHorizontal  =   5
	XLPatternDarkVertical    =   6
	XLPatternDarkDown        =   7
	XLPatternDarkUp          =   8
	XLPatternDarkGrid        =   9
	XLPatternDarkTrellis     =  10
	XLPatternLightHorizontal =  11
	XLPatternLightVertical   =  12
	XLPatternLightDown       =  13
	XLPatternLightUp         =  14
	XLPatternLightGrid       =  15
	XLPatternLightTrellis    =  16
	XLPatternGray125         =  17
	XLPatternGray0625        =  18
	XLPatternTypeInvalid     = 255
End Enum

Enum EXLLineType:Byte
	XLLineLeft       =   0
	XLLineRight      =   1
	XLLineTop        =   2
	XLLineBottom     =   3
	XLLineDiagonal   =   4
	XLLineVertical   =   5
	XLLineHorizontal =   6
	XLLineInvalid    = 255
End Enum

Enum EXLLineStyle:Byte
	XLLineStyleNone             =   0
	XLLineStyleThin             =   1
	XLLineStyleMedium           =   2
	XLLineStyleDashed           =   3
	XLLineStyleDotted           =   4
	XLLineStyleThick            =   5
	XLLineStyleDouble           =   6
	XLLineStyleHair             =   7
	XLLineStyleMediumDashed     =   8
	XLLineStyleDashDot          =   9
	XLLineStyleMediumDashDot    =  10
	XLLineStyleDashDotDot       =  11
	XLLineStyleMediumDashDotDot =  12
	XLLineStyleSlantDashDot     =  13
	XLLineStyleInvalid          = 255
End Enum

Enum EXLAlignmentStyle:Byte
	XLAlignGeneral          =   0
	XLAlignLeft             =   1
	XLAlignRight            =   2
	XLAlignCenter           =   3
	XLAlignTop              =   4
	XLAlignBottom           =   5
	XLAlignFill             =   6
	XLAlignJustify          =   7
	XLAlignCenterContinuous =   8
	XLAlignDistributed      =   9
End Enum

Enum EXLCfType:Byte
	Expression        =   0
	CellIs            =   1
	ColorScale        =   2
	DataBar           =   3
	IconSet           =   4
	Top10             =   5
	UniqueValues      =   6
	DuplicateValues   =   7
	ContainsText      =   8
	NotContainsText   =   9
	BeginsWith        =  10
	EndsWith          =  11
	ContainsBlanks    =  12
	NotContainsBlanks =  13
	ContainsErrors    =  14
	NotContainsErrors =  15
	TimePeriod        =  16
	AboveAverage      =  17
	Invalid           = 255
End Enum

Enum EXLCfOperator:Byte
	LessThan           =   0
	LessThanOrEqual    =   1
	Equal              =   2
	NotEqual           =   3
	GreaterThanOrEqual =   4
	GreaterThan        =   5
	Between            =   6
	NotBetween         =   7
	ContainsText       =   8
	NotContains        =   9
	BeginsWith         =  10
	EndsWith           =  11
	Invalid            = 255
End Enum

Enum EXLCfTimePeriod:Byte
	Today     =   0
	Yesterday =   1
	Tomorrow  =   2
	Last7Days =   3
	ThisMonth =   4
	LastMonth =   5
	NextMonth =   6
	ThisWeek  =   7
	LastWeek  =   8
	NextWeek  =   9
	Invalid   = 255
End Enum
