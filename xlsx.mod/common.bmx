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

	Function bmx_openxlsx_xlworkbook_worksheet:Byte Ptr(document:Byte Ptr, name:String)
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
	Function bmx_openxlsx_xlcell_empty:Int(cell:Byte Ptr)

	Function bmx_openxlsx_xlcellrange_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_address:String(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_topleft:Byte Ptr(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_bottomright:Byte Ptr(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_numrows:UInt(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_numcolumns:Short(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_iterator:Byte Ptr(cellRange:Byte Ptr)
	Function bmx_openxlsx_xlcellrange_distance:ULong(cellRange:Byte Ptr)

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

	Function bmx_openxlsx_xlrowdatarange_iterator_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlrowdatarange_iterator_hasnext:Int(iterator:Byte Ptr)
	Function bmx_openxlsx_xlrowdatarange_iterator_next:Byte Ptr(iterator:Byte Ptr)

	Function bmx_openxlsx_xlcolumn_free(handle:Byte Ptr)
	Function bmx_openxlsx_xlcolumn_width:Float(column:Byte Ptr)
	Function bmx_openxlsx_xlcolumn_setwidth(column:Byte Ptr, width:Float)
	Function bmx_openxlsx_xlcolumn_ishidden:Int(column:Byte Ptr)
	Function bmx_openxlsx_xlcolumn_sethidden(column:Byte Ptr, state:Int)
End Extern

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
