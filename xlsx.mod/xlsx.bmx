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

Module Text.Xlsx

ModuleInfo "Version: 1.00"
ModuleInfo "Author: Bruce A Henderson"
ModuleInfo "License: BSD-3-Clause"
ModuleInfo "OpenXLSX - Copyright (c) 2020, Kenneth Troldal Balslev"
ModuleInfo "Copyright: 2026 Bruce A Henderson"

ModuleInfo "History: 1.00"
ModuleInfo "History: Initial Release"

ModuleInfo "CPP_OPTS: -std=c++17 -fexceptions"
ModuleInfo "CC_OPTS: -DOPENXLSX_STATIC_DEFINE"

Import "common.bmx"


Type TXLDocument

	Field docPtr:Byte Ptr

	Method New()
		docPtr = bmx_openxlsx_xldocument_new()
	End Method

	Method Workbook:TXLWorkbook()
		Return TXLWorkbook._Create(bmx_openxlsx_xldocument_workbook(docPtr))
	End Method

	Method Open(filename:String)
		bmx_openxlsx_xldocument_open(docPtr, filename)
	End Method

	Method Create(filename:String, forceOverwrite:Int)
		bmx_openxlsx_xldocument_create(docPtr, filename, forceOverwrite)
	End Method

	Method Save()
		bmx_openxlsx_xldocument_save(docPtr)
	End Method

	Method SaveAs(filename:String, forceOverwrite:Int)
		bmx_openxlsx_xldocument_saveas(docPtr, filename, forceOverwrite)
	End Method

	Method Close()
		bmx_openxlsx_xldocument_close(docPtr)
	End Method

	Method IsOpen:Int()
		Return bmx_openxlsx_xldocument_isopen(docPtr)
	End Method

	Method Name:String()
		Return bmx_openxlsx_xldocument_name(docPtr)
	End Method

	Method Path:String()
		Return bmx_openxlsx_xldocument_path(docPtr)
	End Method

	Method Property:String(prop:EXLProperty)
		Return bmx_openxlsx_xldocument_property(docPtr, prop)
	End Method

	Method SetProperty(prop:EXLProperty, value:String)
		bmx_openxlsx_xldocument_setproperty(docPtr, prop, value)
	End Method

	Method DeleteProperty(prop:EXLProperty)
		bmx_openxlsx_xldocument_deleteproperty(docPtr, prop)
	End Method

	Method Styles:TXLStyles()
		Return TXLStyles._Create(bmx_openxlsx_xldocument_styles(docPtr))
	End Method

	Method Delete()
		If docPtr Then
			bmx_openxlsx_xldocument_free(docPtr)
			docPtr = Null
		End If
	End Method

End Type

Type TXLWorkbook

	Field workbookPtr:Byte Ptr

	Function _Create:TXLWorkbook(workbookPtr:Byte Ptr)
		If workbookPtr Then
			Local wb:TXLWorkbook = New TXLWorkbook()
			wb.workbookPtr = workbookPtr
			Return wb
		End If
		Return Null
	End Function

	Method AddWorksheet(name:String)
		bmx_openxlsx_xlworkbook_addworksheet(workbookPtr, name)
	End Method

	Method DeleteSheet(name:String)
		bmx_openxlsx_xlworkbook_deletesheet(workbookPtr, name)
	End Method

	Method CloneSheet(name:String, newName:String)
		bmx_openxlsx_xlworkbook_clonesheet(workbookPtr, name, newName)
	End Method

	Method SetSheetIndex(name:String, index:UInt)
		bmx_openxlsx_xlworkbook_setsheetindex(workbookPtr, name, index)
	End Method

	Method IndexOfSheet:UInt(name:String)
		Return bmx_openxlsx_xlworkbook_indexofsheet(workbookPtr, name)
	End Method

	Method TypeOfSheet:EXLSheetType(name:String)
		Return bmx_openxlsx_xlworkbook_typeofsheet(workbookPtr, name)
	End Method

	Method TypeOfSheet:EXLSheetType(index:UInt)
		Return bmx_openxlsx_xlworkbook_typeofsheetbyindex(workbookPtr, index)
	End Method

	Method WorksheetExists:Int(name:String)
		Return bmx_openxlsx_xlworkbook_worksheetexists(workbookPtr, name)
	End Method

	Method Worksheet:TXLWorkSheet(name:String)
		Return TXLWorkSheet._Create(bmx_openxlsx_xlworkbook_worksheet(workbookPtr, name))
	End Method

	Method WorksheetNames:String[]()
		Return bmx_openxlsx_xlworkbook_worksheetnames(workbookPtr)
	End Method

	Method Delete()
		If workbookPtr Then
			bmx_openxlsx_xlworkbook_free(workbookPtr)
			workbookPtr = Null
		End If
	End Method
	
End Type

Type TXLWorkSheet

	Field worksheetPtr:Byte Ptr

	Function _Create:TXLWorkSheet(worksheetPtr:Byte Ptr)
		If worksheetPtr Then
			Local ws:TXLWorkSheet = New TXLWorkSheet()
			ws.worksheetPtr = worksheetPtr
			Return ws
		End If
		Return Null
	End Function

	Method Cell:TXLCell(name:String)
		Return TXLCell._Create(bmx_openxlsx_xlworksheet_cell(worksheetPtr, name))
	End Method

	Method Cell:TXLCell(reference:TXLCellReference)
		Return TXLCell._Create(bmx_openxlsx_xlworksheet_cell_ref(worksheetPtr, reference.referencePtr))
	End Method

	Method Visibility:EXLSheetState()
		Return bmx_openxlsx_xlworksheet_visibility(worksheetPtr)
	End Method

	Method SetVisibility(state:EXLSheetState)
		bmx_openxlsx_xlworksheet_setvisibility(worksheetPtr, state)
	End Method

	Method Color:SColor8()
		Return bmx_openxlsx_xlworksheet_color(worksheetPtr)
	End Method

	Method SetColor(color:SColor8)
		bmx_openxlsx_xlworksheet_setcolor(worksheetPtr, color)
	End Method

	Method Index:Short()
		Return bmx_openxlsx_xlworksheet_index(worksheetPtr)
	End Method

	Method SetIndex(index:Short)
		bmx_openxlsx_xlworksheet_setindex(worksheetPtr, index)
	End Method

	Method Name:String()
		Return bmx_openxlsx_xlworksheet_name(worksheetPtr)
	End Method

	Method SetName(name:String)
		bmx_openxlsx_xlworksheet_setname(worksheetPtr, name)
	End Method

	Method IsSelected:Int()
		Return bmx_openxlsx_xlworksheet_isselected(worksheetPtr)
	End Method

	Method SetSelected(selected:Int)
		bmx_openxlsx_xlworksheet_setselected(worksheetPtr, selected)
	End Method

	Method IsActive:Int()
		Return bmx_openxlsx_xlworksheet_isactive(worksheetPtr)
	End Method

	Method SetActive()
		bmx_openxlsx_xlworksheet_setactive(worksheetPtr)
	End Method

	Method Clone(newName:String)
		bmx_openxlsx_xlworksheet_clone(worksheetPtr, newName)
	End Method

	Method Range:TXLCellRange()
		Return TXLCellRange._Create(bmx_openxlsx_xlworksheet_range(worksheetPtr))
	End Method

	Method Range:TXLCellRange(topLeft:String, bottomRight:String)
		Return TXLCellRange._Create(bmx_openxlsx_xlworksheet_range_str(worksheetPtr, topLeft, bottomRight))
	End Method

	Method Range:TXLCellRange(topLeft:TXLCellReference, bottomRight:TXLCellReference)
		Return TXLCellRange._Create(bmx_openxlsx_xlworksheet_range_ref(worksheetPtr, topLeft.referencePtr, bottomRight.referencePtr))
	End Method

	Method Row:TXLRow(rowNumber:UInt)
		Return TXLRow._Create(bmx_openxlsx_xlworksheet_row(worksheetPtr, rowNumber))
	End Method

	Method Rows:TXLRowRange()
		Return TXLRowRange._Create(bmx_openxlsx_xlworksheet_rows(worksheetPtr))
	End Method

	Method Rows:TXLRowRange(rowCount:UInt)
		Return TXLRowRange._Create(bmx_openxlsx_xlworksheet_rows_count(worksheetPtr, rowCount))
	End Method

	Method Rows:TXLRowRange(firstRow:UInt, lastRow:UInt)
		Return TXLRowRange._Create(bmx_openxlsx_xlworksheet_rows_range(worksheetPtr, firstRow, lastRow))
	End Method

	Method Column:TXLColumn(columnNumber:Short)
		Return TXLColumn._Create(bmx_openxlsx_xlworksheet_column(worksheetPtr, columnNumber))
	End Method

	Method Column:TXLColumn(columnRef:String)
		Return TXLColumn._Create(bmx_openxlsx_xlworksheet_column_str(worksheetPtr, columnRef))
	End Method

	Method LastCell:TXLCell()
		Return TXLCell._Create(bmx_openxlsx_xlworksheet_lastcell(worksheetPtr))
	End Method

	Method ColumnCount:Short()
		Return bmx_openxlsx_xlworksheet_columncount(worksheetPtr)
	End Method

	Method RowCount:UInt()
		Return bmx_openxlsx_xlworksheet_rowcount(worksheetPtr)
	End Method

	Method DeleteRow(rowNumber:UInt)
		bmx_openxlsx_xlworksheet_deleterow(worksheetPtr, rowNumber)
	End Method

	Method UpdateSheetName(oldName:String, newName:String)
		bmx_openxlsx_xlworksheet_updatesheetname(worksheetPtr, oldName, newName)
	End Method

	Method ProtectSheet:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_protectsheet(worksheetPtr, set)
	End Method

	Method ProtectObjects:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_protectobjects(worksheetPtr, set)
	End Method

	Method ProtectScenarios:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_protectscenarios(worksheetPtr, set)
	End Method

	Method AllowInsertColumns:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowinsertcolumns(worksheetPtr, set)
	End Method

	Method AllowInsertRows:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowinsertrows(worksheetPtr, set)
	End Method

	Method AllowDeleteColumns:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowdeletecolumns(worksheetPtr, set)
	End Method

	Method AllowDeleteRows:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowdeleterows(worksheetPtr, set)
	End Method

	Method AllowSelectLockedCells:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowselectlockedcells(worksheetPtr, set)
	End Method

	Method AllowSelectUnlockedCells:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowselectunlockedcells(worksheetPtr, set)
	End Method

	Method DenyInsertColumns:Int()
		Return AllowInsertColumns(False)
	End Method

	Method DenyInsertRows:Int()
		Return AllowInsertRows(False)
	End Method

	Method DenyDeleteColumns:Int()
		Return AllowDeleteColumns(False)
	End Method

	Method DenyDeleteRows:Int()
		Return AllowDeleteRows(False)
	End Method

	Method DenySelectLockedCells:Int()
		Return AllowSelectLockedCells(False)
	End Method

	Method DenySelectUnlockedCells:Int()
		Return AllowSelectUnlockedCells(False)
	End Method

	Method SetPasswordHash:Int(hash:String)
		Return bmx_openxlsx_xlworksheet_setpasswordhash(worksheetPtr, hash)
	End Method

	Method SetPassword:Int(password:String)
		Return bmx_openxlsx_xlworksheet_setpassword(worksheetPtr, password)
	End Method

	Method ClearPassword:Int()
		Return bmx_openxlsx_xlworksheet_clearpassword(worksheetPtr)
	End Method

	Method ClearSheetProtection:Int()
		Return bmx_openxlsx_xlworksheet_clearsheetprotection(worksheetPtr)
	End Method

	Method SheetProtected:Int()
		Return bmx_openxlsx_xlworksheet_sheetprotected(worksheetPtr)
	End Method

	Method ObjectsProtected:Int()
		Return bmx_openxlsx_xlworksheet_objectsprotected(worksheetPtr)
	End Method

	Method ScenariosProtected:Int()
		Return bmx_openxlsx_xlworksheet_scenariosprotected(worksheetPtr)
	End Method

	Method InsertColumnsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_insertcolumnsallowed(worksheetPtr)
	End Method

	Method InsertRowsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_insertrowsallowed(worksheetPtr)
	End Method

	Method DeleteColumnsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_deletecolumnsallowed(worksheetPtr)
	End Method

	Method DeleteRowsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_deleterowsallowed(worksheetPtr)
	End Method

	Method SelectLockedCellsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_selectlockedcellsallowed(worksheetPtr)
	End Method

	Method SelectUnlockedCellsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_selectunlockedcellsallowed(worksheetPtr)
	End Method

	Method PasswordHash:String()
		Return bmx_openxlsx_xlworksheet_passwordhash(worksheetPtr)
	End Method

	Method PasswordIsSet:Int()
		Return bmx_openxlsx_xlworksheet_passwordisset(worksheetPtr)
	End Method

	Method MergeCells(range:TXLCellRange, emptyHiddenCells:Int = False)
		bmx_openxlsx_xlworksheet_mergecells(worksheetPtr, range.rangePtr, emptyHiddenCells)
	End Method

	Method MergeCells(rangeReference:String, emptyHiddenCells:Int = False)
		bmx_openxlsx_xlworksheet_mergecells_str(worksheetPtr, rangeReference, emptyHiddenCells)
	End Method

	Method UnmergeCells(rangeToUnmerge:TXLCellRange)
		bmx_openxlsx_xlworksheet_unmergecells(worksheetPtr, rangeToUnmerge.rangePtr)
	End Method

	Method UnmergeCells(rangeReference:String)
		bmx_openxlsx_xlworksheet_unmergecells_str(worksheetPtr, rangeReference)
	End Method

	Method Delete()
		If worksheetPtr Then
			bmx_openxlsx_xlworksheet_free(worksheetPtr)
			worksheetPtr = Null
		End If
	End Method
End Type

Type TXLCellRange Implements IIterable<TXLCell>

	Field rangePtr:Byte Ptr
	FIeld _distance:ULong

	Function _Create:TXLCellRange(rangePtr:Byte Ptr)
		If rangePtr Then
			Local range:TXLCellRange = New TXLCellRange()
			range.rangePtr = rangePtr
			Return range
		End If
		Return Null
	End Function

	Method GetIterator:IIterator<TXLCell>() Override
		Return TXLCellRangeIterator._Create(Self, bmx_openxlsx_xlcellrange_iterator(rangePtr))
	End Method

	Method Address:String()
		Return bmx_openxlsx_xlcellrange_address(rangePtr)
	End Method

	Method TopLeft:TXLCellReference()
		Return TXLCellReference._Create(bmx_openxlsx_xlcellrange_topleft(rangePtr))
	End Method

	Method BottomRight:TXLCellReference()
		Return TXLCellReference._Create(bmx_openxlsx_xlcellrange_bottomright(rangePtr))
	End Method

	Method NumRows:UInt()
		Return bmx_openxlsx_xlcellrange_numrows(rangePtr)
	End Method

	Method NumColumns:Short()
		Return bmx_openxlsx_xlcellrange_numcolumns(rangePtr)
	End Method

	Method Distance:ULong()
		If _distance Then
			Return _distance
		End If

		_distance = bmx_openxlsx_xlcellrange_distance(rangePtr)
		Return _distance
	End Method

	Method Delete()
		If rangePtr Then
			bmx_openxlsx_xlcellrange_free(rangePtr)
			rangePtr = Null
		End If
	End Method

End Type

Type TXLCellRangeIterator Implements IIterator<TXLCell>, ICloseable

	Field _range:TXLCellRange
	Field _iteratorPtr:Byte Ptr
	Field _current:TXLCell

	Function _Create:TXLCellRangeIterator(range:TXLCellRange, iteratorPtr:Byte Ptr)
		If iteratorPtr Then
			Local iter:TXLCellRangeIterator = New TXLCellRangeIterator()
			iter._iteratorPtr = iteratorPtr
			iter._range = range
			Return iter
		End If
		Return Null
	End Function

	Method Current:TXLCell() Override
		Return _current
	End Method

	Method MoveNext:Int() Override
		If bmx_openxlsx_xlcellrange_iterator_hasnext(_iteratorPtr) Then
			_current = TXLCell._Create(bmx_openxlsx_xlcellrange_iterator_next(_iteratorPtr))
			Return True
		End If
		_current = Null
		Return False
	End Method

	Method Close() Override
		If _iteratorPtr Then
			_range = Null
			bmx_openxlsx_xlcellrange_iterator_free(_iteratorPtr)
			_iteratorPtr = Null
		End If
	End Method

	Method Delete()
		If _iteratorPtr Then
			_range = Null
			bmx_openxlsx_xlcellrange_iterator_free(_iteratorPtr)
			_iteratorPtr = Null
		End If
	End Method

End Type

Type TXLCell

	Field cellPtr:Byte Ptr

	Function _Create:TXLCell(cellPtr:Byte Ptr)
		If cellPtr Then
			Local cell:TXLCell = New TXLCell()
			cell.cellPtr = cellPtr
			Return cell
		End If
		Return Null
	End Function

	Method Empty:Int()
		Return bmx_openxlsx_xlcell_empty(cellPtr)
	End Method

	Method ValueType:EXLValueType()
		Return bmx_openxlsx_xlcell_valuetype(cellPtr)
	End Method

	Method SetValue(value:Float)
		bmx_openxlsx_xlcell_setvalue_double(cellPtr, value)
	End Method

	Method SetValueFloat(value:Float)
		bmx_openxlsx_xlcell_setvalue_double(cellPtr, value)
	End Method

	Method SetValue(value:Double)
		bmx_openxlsx_xlcell_setvalue_double(cellPtr, value)
	End Method

	Method SetValueDouble(value:Double)
		bmx_openxlsx_xlcell_setvalue_double(cellPtr, value)
	End Method

	Method SetValue(value:Int)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, Long(value))
	End Method

	Method SetValueInt(value:Int)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, Long(value))
	End Method

	Method SetValue(value:Long)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, value)
	End Method

	Method SetValueLong(value:Long)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, value)
	End Method

	Method SetValue(value:UInt)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, Long(value))
	End Method

	Method SetValueUInt(value:UInt)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, Long(value))
	End Method

	Method SetValue(value:ULong)
		bmx_openxlsx_xlcell_setvalue_ulong(cellPtr, value)
	End Method

	Method SetValueULong(value:ULong)
		bmx_openxlsx_xlcell_setvalue_ulong(cellPtr, value)
	End Method

	Method SetValue(value:String)
		bmx_openxlsx_xlcell_setvalue_string(cellPtr, value)
	End Method

	Method SetValueString(value:String)
		bmx_openxlsx_xlcell_setvalue_string(cellPtr, value)
	End Method

	Method SetValueBool(value:Int)
		bmx_openxlsx_xlcell_setvalue_bool(cellPtr, value)
	End Method

	Method SetValue(cell:TXLCell)
		bmx_openxlsx_xlcell_setvalue_cell(cellPtr, cell.cellPtr)
	End Method

	Method GetValueDouble:Double()
		Return bmx_openxlsx_xlcell_getvalue_double(cellPtr)
	End Method

	Method GetValueLong:Long()
		Return bmx_openxlsx_xlcell_getvalue_long(cellPtr)
	End Method

	Method GetValueULong:ULong()
		Return bmx_openxlsx_xlcell_getvalue_ulong(cellPtr)
	End Method

	Method GetValueString:String()
		Return bmx_openxlsx_xlcell_getvalue_string(cellPtr)
	End Method

	Method GetValueBool:Int()
		Return bmx_openxlsx_xlcell_getvalue_bool(cellPtr)
	End Method

	Method TypeAsString:String()
		Return bmx_openxlsx_xlcell_typeasstring(cellPtr)
	End Method

	Method HasFormula:Int()
		Return bmx_openxlsx_xlcell_hasformula(cellPtr)
	End Method

	Method Formula:String()
		Return bmx_openxlsx_xlcell_formula(cellPtr)
	End Method

	Method SetFormula(formula:String)
		bmx_openxlsx_xlcell_setformula(cellPtr, formula)
	End Method

	Method ClearFormula()
		bmx_openxlsx_xlcell_clearformula(cellPtr)
	End Method
	
	Method Delete()
		If cellPtr Then
			bmx_openxlsx_xlcell_free(cellPtr)
			cellPtr = Null
		End If
	End Method
End Type

Type TXLCellReference

	Field referencePtr:Byte Ptr

	Function _Create:TXLCellReference(referencePtr:Byte Ptr)
		If referencePtr Then
			Local ref:TXLCellReference = New TXLCellReference()
			ref.referencePtr = referencePtr
			Return ref
		End If
		Return Null
	End Function

	Method New(cellAddress:String)
		referencePtr = bmx_openxlsx_xlcellreference_new_celladdress(cellAddress)
	End Method

	Method New(row:UInt, column:Short)
		referencePtr = bmx_openxlsx_xlcellreference_new_rowcolumn(row, column)
	End Method

	Method New(row:UInt, column:String)
		referencePtr = bmx_openxlsx_xlcellreference_new_rowcolumn_str(row, column)
	End Method

	Method Row:UInt()
		Return bmx_openxlsx_xlcellreference_row(referencePtr)
	End Method

	Method SetRow(row:UInt)
		bmx_openxlsx_xlcellreference_setrow(referencePtr, row)
	End Method

	Method Column:Short()
		Return bmx_openxlsx_xlcellreference_column(referencePtr)
	End Method

	Method SetColumn(column:Short)
		bmx_openxlsx_xlcellreference_setcolumn(referencePtr, column)
	End Method

	Method SetRowAndColumn(row:UInt, column:Short)
		bmx_openxlsx_xlcellreference_setrowcolumn(referencePtr, row, column)
	End Method

	Method Address:String()
		Return bmx_openxlsx_xlcellreference_address(referencePtr)
	End Method

	Method SetAddress(address:String)
		bmx_openxlsx_xlcellreference_setaddress(referencePtr, address)
	End Method

	Method Delete()
		If referencePtr Then
			bmx_openxlsx_xlcellreference_free(referencePtr)
			referencePtr = Null
		End If
	End Method

End Type

Type TXLRow

	Field rowPtr:Byte Ptr

	Function _Create:TXLRow(rowPtr:Byte Ptr)
		If rowPtr Then
			Local row:TXLRow = New TXLRow()
			row.rowPtr = rowPtr
			Return row
		End If
		Return Null
	End Function

	Method Empty:Int()
		Return bmx_openxlsx_xlrow_empty(rowPtr)
	End Method

	Method Height:Float()
		Return bmx_openxlsx_xlrow_height(rowPtr)
	End Method

	Method SetHeight(height:Float)
		bmx_openxlsx_xlrow_setheight(rowPtr, height)
	End Method

	Method Descent:Float()
		Return bmx_openxlsx_xlrow_descent(rowPtr)
	End Method

	Method SetDescent(descent:Float)
		bmx_openxlsx_xlrow_setdescent(rowPtr, descent)
	End Method

	Method IsHidden:Int()
		Return bmx_openxlsx_xlrow_ishidden(rowPtr)
	End Method

	Method SetHidden(state:Int)
		bmx_openxlsx_xlrow_sethidden(rowPtr, state)
	End Method

	Method RowNumber:UInt()
		Return bmx_openxlsx_xlrow_rownumber(rowPtr)
	End Method

	Method CellCount:Short()
		Return bmx_openxlsx_xlrow_cellcount(rowPtr)
	End Method

	Method Cells:TXLRowDataRange()
		Return TXLRowDataRange._Create(bmx_openxlsx_xlrow_cells(rowPtr))
	End Method

	Method Cells:TXLRowDataRange(cellCount:Short)
		Return TXLRowDataRange._Create(bmx_openxlsx_xlrow_cells_count(rowPtr, cellCount))
	End Method

	Method Cells:TXLRowDataRange(firstCell:Short, lastCell:Short)
		Return TXLRowDataRange._Create(bmx_openxlsx_xlrow_cells_range(rowPtr, firstCell, lastCell))
	End Method

	Method Delete()
		If rowPtr Then
			bmx_openxlsx_xlrow_free(rowPtr)
			rowPtr = Null
		End If
	End Method

End Type

Type TXLRowRange Implements IIterable<TXLRow>

	Field rowRangePtr:Byte Ptr

	Function _Create:TXLRowRange(rowRangePtr:Byte Ptr)
		If rowRangePtr Then
			Local range:TXLRowRange = New TXLRowRange()
			range.rowRangePtr = rowRangePtr
			Return range
		End If
		Return Null
	End Function

	Method RowCount:UInt()
		Return bmx_openxlsx_xlrowrange_rowcount(rowRangePtr)
	End Method

	Method GetIterator:IIterator<TXLRow>() Override
		Return TXLRowIterator._Create(Self, bmx_openxlsx_xlrowrange_iterator(rowRangePtr))
	End Method

	Method Delete()
		If rowRangePtr Then
			bmx_openxlsx_xlrowrange_free(rowRangePtr)
			rowRangePtr = Null
		End If
	End Method
End Type

Type TXLRowIterator Implements IIterator<TXLRow>, ICloseable

	Field _rowRange:TXLRowRange
	Field _iteratorPtr:Byte Ptr
	Field _current:TXLRow

	Function _Create:TXLRowIterator(rowRange:TXLRowRange, iteratorPtr:Byte Ptr)
		If iteratorPtr Then
			Local iter:TXLRowIterator = New TXLRowIterator()
			iter._iteratorPtr = iteratorPtr
			iter._rowRange = rowRange
			Return iter
		End If
		Return Null
	End Function

	Method Current:TXLRow() Override
		Return _current
	End Method

	Method MoveNext:Int() Override
		If bmx_openxlsx_xlrowrange_iterator_hasnext(_iteratorPtr) Then
			_current = TXLRow._Create(bmx_openxlsx_xlrowrange_iterator_next(_iteratorPtr))
			Return True
		End If
		_current = Null
		Return False
	End Method

	Method Close() Override
		If _iteratorPtr Then
			_rowRange = Null
			bmx_openxlsx_xlrowrange_iterator_free(_iteratorPtr)
			_iteratorPtr = Null
		End If
	End Method

	Method Delete()
		If _iteratorPtr Then
			_rowRange = Null
			bmx_openxlsx_xlrowrange_iterator_free(_iteratorPtr)
			_iteratorPtr = Null
		End If
	End Method
End Type

Type TXLRowDataIterator Implements IIterator<TXLCell>, ICloseable

	Field _rowDataRange:TXLRowDataRange
	Field _iteratorPtr:Byte Ptr
	Field _current:TXLCell

	Function _Create:TXLRowDataIterator(rowDataRange:TXLRowDataRange, iteratorPtr:Byte Ptr)
		If iteratorPtr Then
			Local iter:TXLRowDataIterator = New TXLRowDataIterator()
			iter._iteratorPtr = iteratorPtr
			iter._rowDataRange = rowDataRange
			Return iter
		End If
		Return Null
	End Function

	Method Current:TXLCell() Override
		Return _current
	End Method

	Method MoveNext:Int() Override
		If bmx_openxlsx_xlrowdatarange_iterator_hasnext(_iteratorPtr) Then
			_current = TXLCell._Create(bmx_openxlsx_xlrowdatarange_iterator_next(_iteratorPtr))
			Return True
		End If
		_current = Null
		Return False
	End Method

	Method Close() Override
		If _iteratorPtr Then
			_rowDataRange = Null
			bmx_openxlsx_xlrowdatarange_iterator_free(_iteratorPtr)
			_iteratorPtr = Null
		End If
	End Method

	Method Delete()
		If _iteratorPtr Then
			_rowDataRange = Null
			bmx_openxlsx_xlrowdatarange_iterator_free(_iteratorPtr)
			_iteratorPtr = Null
		End If
	End Method
End Type

Type TXLRowDataRange Implements IIterable<TXLCell>

	Field rowDataRangePtr:Byte Ptr

	Function _Create:TXLRowDataRange(rowDataRangePtr:Byte Ptr)
		If rowDataRangePtr Then
			Local range:TXLRowDataRange = New TXLRowDataRange()
			range.rowDataRangePtr = rowDataRangePtr
			Return range
		End If
		Return Null
	End Function

	Method GetIterator:IIterator<TXLCell>() Override
		Return TXLRowDataIterator._Create(Self, bmx_openxlsx_xlrowdatarange_iterator(rowDataRangePtr))
	End Method

	Method Delete()
		If rowDataRangePtr Then
			bmx_openxlsx_xlrowdatarange_free(rowDataRangePtr)
			rowDataRangePtr = Null
		End If
	End Method

End Type

Type TXLColumn

	Field columnPtr:Byte Ptr

	Function _Create:TXLColumn(columnPtr:Byte Ptr)
		If columnPtr Then
			Local column:TXLColumn = New TXLColumn()
			column.columnPtr = columnPtr
			Return column
		End If
		Return Null
	End Function

	Method Width:Float()
		Return bmx_openxlsx_xlcolumn_width(columnPtr)
	End Method

	Method SetWidth(width:Float)
		bmx_openxlsx_xlcolumn_setwidth(columnPtr, width)
	End Method

	Method IsHidden:Int()
		Return bmx_openxlsx_xlcolumn_ishidden(columnPtr)
	End Method

	Method SetHidden(state:Int)
		bmx_openxlsx_xlcolumn_sethidden(columnPtr, state)
	End Method

	Method Delete()
		If columnPtr Then
			bmx_openxlsx_xlcolumn_free(columnPtr)
			columnPtr = Null
		End If
	End Method

End Type

Type TXLStyles

	Field stylesPtr:Byte Ptr

	Function _Create:TXLStyles(stylesPtr:Byte Ptr)
		If stylesPtr Then
			Local styles:TXLStyles = New TXLStyles()
			styles.stylesPtr = stylesPtr
			Return styles
		End If
		Return Null
	End Function

	Method Fonts:TXLFonts()
		Return TXLFonts._Create(bmx_openxlsx_xlstyles_fonts(stylesPtr))
	End Method

	Method Fills:TXLFills()
		Return TXLFills._Create(bmx_openxlsx_xlstyles_fills(stylesPtr))
	End Method

	Method Borders:TXLBorders()
		Return TXLBorders._Create(bmx_openxlsx_xlstyles_borders(stylesPtr))
	End Method

	Method CellFormats:TXLCellFormats()
		Return TXLCellFormats._Create(bmx_openxlsx_xlstyles_cellformats(stylesPtr))
	End Method

	Method CellStyles:TXLCellStyles()
		Return TXLCellStyles._Create(bmx_openxlsx_xlstyles_cellstyles(stylesPtr))
	End Method

	Method NumberFormats:TXLNumberFormats()
		Return TXLNumberFormats._Create(bmx_openxlsx_xlstyles_numberformats(stylesPtr))
	End Method

	Method Delete()
		If stylesPtr Then
			bmx_openxlsx_xlstyles_free(stylesPtr)
			stylesPtr = Null
		End If
	End Method
End Type

Type TXLFonts

	Field fontsPtr:Byte Ptr

	Function _Create:TXLFonts(fontsPtr:Byte Ptr)
		If fontsPtr Then
			Local fonts:TXLFonts = New TXLFonts()
			fonts.fontsPtr = fontsPtr
			Return fonts
		End If
		Return Null
	End Function

	Method Count:Size_T()
		Return bmx_openxlsx_xlfonts_count(fontsPtr)
	End Method

	Method FontByIndex:TXLFont(index:Size_T)
		Return TXLFont._Create(bmx_openxlsx_xlfonts_fontbyindex(fontsPtr, index))
	End Method

	Method Operator[]:TXLFont(index:Size_T)
		Return FontByIndex(index)
	End Method

	Method Delete()
		If fontsPtr Then
			bmx_openxlsx_xlfonts_free(fontsPtr)
			fontsPtr = Null
		End If
	End Method

End Type

Type TXLFont

	Field fontPtr:Byte Ptr

	Function _Create:TXLFont(fontPtr:Byte Ptr)
		If fontPtr Then
			Local font:TXLFont = New TXLFont()
			font.fontPtr = fontPtr
			Return font
		End If
		Return Null
	End Function

	Method FontName:String()
		Return bmx_openxlsx_xlfont_fontname(fontPtr)
	End Method

	Method FontCharset:Size_T()
		Return bmx_openxlsx_xlfont_fontcharset(fontPtr)
	End Method

	Method FontFamily:Size_T()
		Return bmx_openxlsx_xlfont_fontfamily(fontPtr)
	End Method

	Method FontSize:Size_T()
		Return bmx_openxlsx_xlfont_fontsize(fontPtr)
	End Method

	Method FontColor:SColor8()
		Return bmx_openxlsx_xlfont_fontcolor(fontPtr)
	End Method

	Method Bold:Int()
		Return bmx_openxlsx_xlfont_bold(fontPtr)
	End Method

	Method Italic:Int()
		Return bmx_openxlsx_xlfont_italic(fontPtr)
	End Method

	Method Strikethrough:Int()
		Return bmx_openxlsx_xlfont_strikethrough(fontPtr)
	End Method

	Method Underline:EXLUnderlineStyle()
		Return bmx_openxlsx_xlfont_underline(fontPtr)
	End Method

	Method Scheme:EXLFontSchemeStyle()
		Return bmx_openxlsx_xlfont_scheme(fontPtr)
	End Method

	Method VertAlign:EXLVerticalAlignRunStyle()
		Return bmx_openxlsx_xlfont_vertalign(fontPtr)
	End Method

	Method Outline:Int()
		Return bmx_openxlsx_xlfont_outline(fontPtr)
	End Method

	Method Shadow:Int()
		Return bmx_openxlsx_xlfont_shadow(fontPtr)
	End Method

	Method Condense:Int()
		Return bmx_openxlsx_xlfont_condense(fontPtr)
	End Method

	Method SetFontName:Int(newName:String)
		Return bmx_openxlsx_xlfont_setfontname(fontPtr, newName)
	End Method

	Method SetFontCharset:Int(newCharset:Size_T)
		Return bmx_openxlsx_xlfont_setfontcharset(fontPtr, newCharset)
	End Method

	Method SetFontFamily:Int(newFamily:Size_T)
		Return bmx_openxlsx_xlfont_setfontfamily(fontPtr, newFamily)
	End Method

	Method SetFontSize:Int(newSize:Size_T)
		Return bmx_openxlsx_xlfont_setfontsize(fontPtr, newSize)
	End Method

	Method SetFontColor:Int(newColor:SColor8)
		Return bmx_openxlsx_xlfont_setfontcolor(fontPtr, newColor)
	End Method

	Method SetBold:Int(set:Int)
		Return bmx_openxlsx_xlfont_setbold(fontPtr, set)
	End Method

	Method SetItalic:Int(set:Int)
		Return bmx_openxlsx_xlfont_setitalic(fontPtr, set)
	End Method

	Method SetStrikethrough:Int(set:Int)
		Return bmx_openxlsx_xlfont_setstrikethrough(fontPtr, set)
	End Method

	Method SetUnderline:Int(underline:EXLUnderlineStyle = EXLUnderlineStyle.XLUnderlineSingle)
		Return bmx_openxlsx_xlfont_setunderline(fontPtr, underline)
	End Method

	Method SetScheme:Int(scheme:EXLFontSchemeStyle)
		Return bmx_openxlsx_xlfont_setscheme(fontPtr, scheme)
	End Method

	Method SetVertAlign:Int(vertAlign:EXLVerticalAlignRunStyle)
		Return bmx_openxlsx_xlfont_setvertalign(fontPtr, vertAlign)
	End Method

	Method SetOutline:Int(set:Int)
		Return bmx_openxlsx_xlfont_setoutline(fontPtr, set)
	End Method

	Method SetShadow:Int(set:Int)
		Return bmx_openxlsx_xlfont_setshadow(fontPtr, set)
	End Method

	Method SetCondense:Int(set:Int)
		Return bmx_openxlsx_xlfont_setcondense(fontPtr, set)
	End Method

	Method Delete()
		If fontPtr Then
			bmx_openxlsx_xlfont_free(fontPtr)
			fontPtr = Null
		End If
	End Method

End Type

Type TXLFills

	Field fillsPtr:Byte Ptr

	Function _Create:TXLFills(fillsPtr:Byte Ptr)
		If fillsPtr Then
			Local fills:TXLFills = New TXLFills()
			fills.fillsPtr = fillsPtr
			Return fills
		End If
		Return Null
	End Function

	Method Count:Size_T()
		Return bmx_openxlsx_xlfills_count(fillsPtr)
	End Method

	Method FillByIndex:TXLFill(index:Size_T)
		Return TXLFill._Create(bmx_openxlsx_xlfills_fillbyindex(fillsPtr, index))
	End Method

	Method Delete()
		If fillsPtr Then
			bmx_openxlsx_xlfills_free(fillsPtr)
			fillsPtr = Null
		End If
	End Method

End Type

Type TXLFill

	Field fillPtr:Byte Ptr

	Function _Create:TXLFill(fillPtr:Byte Ptr)
		If fillPtr Then
			Local fill:TXLFill = New TXLFill()
			fill.fillPtr = fillPtr
			Return fill
		End If
		Return Null
	End Function

	Method FillType:EXLFillType()
		Return bmx_openxlsx_xlfill_filltype(fillPtr)
	End Method

	Method SetFillType:Int(fillType:EXLFillType, force:Int = False)
		Return bmx_openxlsx_xlfill_setfilltype(fillPtr, fillType, force)
	End Method

	Method Delete()
		If fillPtr Then
			bmx_openxlsx_xlfill_free(fillPtr)
			fillPtr = Null
		End If
	End Method

End Type

Type TXLBorders

	Field bordersPtr:Byte Ptr

	Function _Create:TXLBorders(bordersPtr:Byte Ptr)
		If bordersPtr Then
			Local borders:TXLBorders = New TXLBorders()
			borders.bordersPtr = bordersPtr
			Return borders
		End If
		Return Null
	End Function

	Method Count:Size_T()
		Return bmx_openxlsx_xlborders_count(bordersPtr)
	End Method

	Method BorderByIndex:TXLBorder(index:Size_T)
		Return TXLBorder._Create(bmx_openxlsx_xlborders_borderbyindex(bordersPtr, index))
	End Method

	Method Delete()
		If bordersPtr Then
			bmx_openxlsx_xlborders_free(bordersPtr)
			bordersPtr = Null
		End If
	End Method

End Type

Type TXLBorder

	Field borderPtr:Byte Ptr

	Function _Create:TXLBorder(borderPtr:Byte Ptr)
		If borderPtr Then
			Local border:TXLBorder = New TXLBorder()
			border.borderPtr = borderPtr
			Return border
		End If
		Return Null
	End Function

	Method DiagonalUp:Int()
		Return bmx_openxlsx_xlborder_diagonalup(borderPtr)
	End Method

	Method DiagonalDown:Int()
		Return bmx_openxlsx_xlborder_diagonaldown(borderPtr)
	End Method

	Method Outline:Int()
		Return bmx_openxlsx_xlborder_outline(borderPtr)
	End Method

	Method Left:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_left(borderPtr))
	End Method

	Method Right:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_right(borderPtr))
	End Method

	Method Top:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_top(borderPtr))
	End Method

	Method Bottom:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_bottom(borderPtr))
	End Method

	Method Diagonal:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_diagonal(borderPtr))
	End Method

	Method Vertical:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_vertical(borderPtr))
	End Method

	Method Horizontal:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_horizontal(borderPtr))
	End Method

	Method SetDiagonalUp:Int(set:Int = True)
		Return bmx_openxlsx_xlborder_setdiagonalup(borderPtr, set)
	End Method

	Method SetDiagonalDown:Int(set:Int = True)
		Return bmx_openxlsx_xlborder_setdiagonaldown(borderPtr, set)
	End Method

	Method SetOutline:Int(set:Int = True)
		Return bmx_openxlsx_xlborder_setoutline(borderPtr, set)
	End Method

	Method SetLine:Int(lineType:EXLLineType, lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setline(borderPtr, lineType, lineStyle, lineColor, lineTint)
	End Method

	Method SetLeft:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setleft(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Method SetRight:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setright(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Method SetTop:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_settop(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Method SetBottom:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setbottom(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Method SetDiagonal:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setdiagonal(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Method SetVertical:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setvertical(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Method SetHorizontal:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_sethorizontal(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Method Delete()
		If borderPtr Then
			bmx_openxlsx_xlborder_free(borderPtr)
			borderPtr = Null
		End If
	End Method

End Type

Type TXLLine

	Field linePtr:Byte Ptr

	Function _Create:TXLLine(linePtr:Byte Ptr)
		If linePtr Then
			Local line:TXLLine = New TXLLine()
			line.linePtr = linePtr
			Return line
		End If
		Return Null
	End Function

	Method Style:EXLLineStyle()
		Return bmx_openxlsx_xlline_style(linePtr)
	End Method

	Method Color:TXLDataBarColor()
		Return TXLDataBarColor._Create(bmx_openxlsx_xlline_color(linePtr))
	End Method

	Method Delete()
		If linePtr Then
			bmx_openxlsx_xlline_free(linePtr)
			linePtr = Null
		End If
	End Method

End Type

Type TXLDataBarColor

	Field colorPtr:Byte Ptr

	Function _Create:TXLDataBarColor(colorPtr:Byte Ptr)
		If colorPtr Then
			Local color:TXLDataBarColor = New TXLDataBarColor()
			color.colorPtr = colorPtr
			Return color
		End If
		Return Null
	End Function

	Method Rgb:SColor8()
		Return bmx_openxlsx_xldatabarcolor_rgb(colorPtr)
	End Method

	Method Tint:Double()
		Return bmx_openxlsx_xldatabarcolor_tint(colorPtr)
	End Method

	Method Automatic:Int()
		Return bmx_openxlsx_xldatabarcolor_automatic(colorPtr)
	End Method

	Method Indexed:UInt()
		Return bmx_openxlsx_xldatabarcolor_indexed(colorPtr)
	End Method

	Method Theme:UInt()
		Return bmx_openxlsx_xldatabarcolor_theme(colorPtr)
	End Method

	Method SetRgb:Int(newColor:SColor8)
		Return bmx_openxlsx_xldatabarcolor_setrgb(colorPtr, newColor)
	End Method

	Method Set:Int(newColor:SColor8)
		Return SetRgb(newColor)
	End Method

	Method SetAutomatic:Int(set:Int = True)
		Return bmx_openxlsx_xldatabarcolor_setautomatic(colorPtr, set)
	End Method

	Method SetIndexed:Int(newIndex:UInt)
		Return bmx_openxlsx_xldatabarcolor_setindexed(colorPtr, newIndex)
	End Method

	Method SetTheme:Int(newTheme:UInt)
		Return bmx_openxlsx_xldatabarcolor_settheme(colorPtr, newTheme)
	End Method

	Method Delete()
		If colorPtr Then
			bmx_openxlsx_xldatabarcolor_free(colorPtr)
			colorPtr = Null
		End If
	End Method

End Type

Type TXLCellFormats

	Field cellFormatsPtr:Byte Ptr

	Function _Create:TXLCellFormats(cellFormatsPtr:Byte Ptr)
		If cellFormatsPtr Then
			Local cellFormats:TXLCellFormats = New TXLCellFormats()
			cellFormats.cellFormatsPtr = cellFormatsPtr
			Return cellFormats
		End If
		Return Null
	End Function

	Method Count:Size_T()
		Return bmx_openxlsx_xlcellformats_count(cellFormatsPtr)
	End Method

	Method CellFormatByIndex:TXLCellFormat(index:Size_T)
		Return TXLCellFormat._Create(bmx_openxlsx_xlcellformats_cellformatbyindex(cellFormatsPtr, index))
	End Method

	Method Delete()
		If cellFormatsPtr Then
			bmx_openxlsx_xlcellformats_free(cellFormatsPtr)
			cellFormatsPtr = Null
		End If
	End Method

End Type

Type TXLCellFormat

	Field cellFormatPtr:Byte Ptr

	Function _Create:TXLCellFormat(cellFormatPtr:Byte Ptr)
		If cellFormatPtr Then
			Local cellFormat:TXLCellFormat = New TXLCellFormat()
			cellFormat.cellFormatPtr = cellFormatPtr
			Return cellFormat
		End If
		Return Null
	End Function

	Method NumberFormatId:UInt()
		Return bmx_openxlsx_xlcellformat_numberformatid(cellFormatPtr)
	End Method

	Method FontIndex:Size_T()
		Return bmx_openxlsx_xlcellformat_fontindex(cellFormatPtr)
	End Method

	Method FillIndex:Size_T()
		Return bmx_openxlsx_xlcellformat_fillindex(cellFormatPtr)
	End Method

	Method BorderIndex:Size_T()
		Return bmx_openxlsx_xlcellformat_borderindex(cellFormatPtr)
	End Method

	Method XfId:Size_T()
		Return bmx_openxlsx_xlcellformat_xfid(cellFormatPtr)
	End Method

	Method ApplyNumberFormat:Int()
		Return bmx_openxlsx_xlcellformat_applynumberformat(cellFormatPtr)
	End Method

	Method ApplyFont:Int()
		Return bmx_openxlsx_xlcellformat_applyfont(cellFormatPtr)
	End Method

	Method ApplyFill:Int()
		Return bmx_openxlsx_xlcellformat_applyfill(cellFormatPtr)
	End Method

	Method ApplyBorder:Int()
		Return bmx_openxlsx_xlcellformat_applyborder(cellFormatPtr)
	End Method

	Method ApplyAlignment:Int()
		Return bmx_openxlsx_xlcellformat_applyalignment(cellFormatPtr)
	End Method

	Method ApplyProtection:Int()
		Return bmx_openxlsx_xlcellformat_applyprotection(cellFormatPtr)
	End Method

	Method QuotePrefix:Int()
		Return bmx_openxlsx_xlcellformat_quoteprefix(cellFormatPtr)
	End Method

	Method PivotButton:Int()
		Return bmx_openxlsx_xlcellformat_pivotbutton(cellFormatPtr)
	End Method

	Method Locked:Int()
		Return bmx_openxlsx_xlcellformat_locked(cellFormatPtr)
	End Method

	Method Hidden:Int()
		Return bmx_openxlsx_xlcellformat_hidden(cellFormatPtr)
	End Method

	Method Alignment:TXLAlignment(createIfMissing:Int = False)
		Return TXLAlignment._Create(bmx_openxlsx_xlcellformat_alignment(cellFormatPtr, createIfMissing))
	End Method

	Method SetNumberFormatId:Int(newNumFormatId:UInt)
		Return bmx_openxlsx_xlcellformat_setnumberformatid(cellFormatPtr, newNumFormatId)
	End Method

	Method SetFontIndex:Int(newFontIndex:Size_T)
		Return bmx_openxlsx_xlcellformat_setfontindex(cellFormatPtr, newFontIndex)
	End Method

	Method SetFillIndex:Int(newFillIndex:Size_T)
		Return bmx_openxlsx_xlcellformat_setfillindex(cellFormatPtr, newFillIndex)
	End Method

	Method SetBorderIndex:Int(newBorderIndex:Size_T)
		Return bmx_openxlsx_xlcellformat_setborderindex(cellFormatPtr, newBorderIndex)
	End Method

	Method SetXfId:Int(newXfId:Size_T)
		Return bmx_openxlsx_xlcellformat_setxfid(cellFormatPtr, newXfId)
	End Method

	Method SetApplyNumberFormat:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplynumberformat(cellFormatPtr, set)
	End Method

	Method SetApplyFont:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplyfont(cellFormatPtr, set)
	End Method

	Method SetApplyFill:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplyfill(cellFormatPtr, set)
	End Method

	Method SetApplyBorder:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplyborder(cellFormatPtr, set)
	End Method

	Method SetApplyAlignment:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplyalignment(cellFormatPtr, set)
	End Method

	Method SetApplyProtection:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplyprotection(cellFormatPtr, set)
	End Method

	Method SetQuotePrefix:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setquoteprefix(cellFormatPtr, set)
	End Method

	Method SetPivotButton:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setpivotbutton(cellFormatPtr, set)
	End Method

	Method SetLocked:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setlocked(cellFormatPtr, set)
	End Method

	Method SetHidden:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_sethidden(cellFormatPtr, set)
	End Method

	Method Delete()
		If cellFormatPtr Then
			bmx_openxlsx_xlcellformat_free(cellFormatPtr)
			cellFormatPtr = Null
		End If
	End Method

End Type

Type TXLAlignment

	Field alignmentPtr:Byte Ptr

	Function _Create:TXLAlignment(alignmentPtr:Byte Ptr)
		If alignmentPtr Then
			Local alignment:TXLAlignment = New TXLAlignment()
			alignment.alignmentPtr = alignmentPtr
			Return alignment
		End If
		Return Null
	End Function

	Method Horizontal:EXLAlignmentStyle()
		Return bmx_openxlsx_xlalignment_horizontal(alignmentPtr)
	End Method

	Method Vertical:EXLAlignmentStyle()
		Return bmx_openxlsx_xlalignment_vertical(alignmentPtr)
	End Method

	Method TextRotation:Short()
		Return bmx_openxlsx_xlalignment_textrotation(alignmentPtr)
	End Method

	Method WrapText:Int()
		Return bmx_openxlsx_xlalignment_wraptext(alignmentPtr)
	End Method

	Method Indent:UInt()
		Return bmx_openxlsx_xlalignment_indent(alignmentPtr)
	End Method

	Method RelativeIndent:Int()
		Return bmx_openxlsx_xlalignment_relativeindent(alignmentPtr)
	End Method

	Method JustifyLastLine:Int()
		Return bmx_openxlsx_xlalignment_justifylastline(alignmentPtr)
	End Method

	Method ShrinkToFit:Int()
		Return bmx_openxlsx_xlalignment_shrinktofit(alignmentPtr)
	End Method

	Method ReadingOrder:UInt()
		Return bmx_openxlsx_xlalignment_readingorder(alignmentPtr)
	End Method

	Method SetHorizontal:Int(newStyle:EXLAlignmentStyle)
		Return bmx_openxlsx_xlalignment_sethorizontal(alignmentPtr, newStyle)
	End Method

	Method SetVertical:Int(newStyle:EXLAlignmentStyle)
		Return bmx_openxlsx_xlalignment_setvertical(alignmentPtr, newStyle)
	End Method

	Method SetTextRotation:Int(rotation:Short)
		Return bmx_openxlsx_xlalignment_settextrotation(alignmentPtr, rotation)
	End Method

	Method SetWrapText:Int(set:Int = True)
		Return bmx_openxlsx_xlalignment_setwraptext(alignmentPtr, set)
	End Method

	Method SetIndent:Int(newIndent:UInt)
		Return bmx_openxlsx_xlalignment_setindent(alignmentPtr, newIndent)
	End Method

	Method SetRelativeIndent:Int(newIndent:Int)
		Return bmx_openxlsx_xlalignment_setrelativeindent(alignmentPtr, newIndent)
	End Method

	Method SetJustifyLastLine:Int(set:Int = True)
		Return bmx_openxlsx_xlalignment_setjustifylastline(alignmentPtr, set)
	End Method

	Method SetShrinkToFit:Int(set:Int = True)
		Return bmx_openxlsx_xlalignment_setshrinktofit(alignmentPtr, set)
	End Method

	Method SetReadingOrder:Int(newReadingOrder:UInt)
		Return bmx_openxlsx_xlalignment_setreadingorder(alignmentPtr, newReadingOrder)
	End Method

	Method Delete()
		If alignmentPtr Then
			bmx_openxlsx_xlalignment_free(alignmentPtr)
			alignmentPtr = Null
		End If
	End Method

End Type

Type TXLCellStyles

	Field cellStylesPtr:Byte Ptr

	Function _Create:TXLCellStyles(cellStylesPtr:Byte Ptr)
		If cellStylesPtr Then
			Local cellStyles:TXLCellStyles = New TXLCellStyles()
			cellStyles.cellStylesPtr = cellStylesPtr
			Return cellStyles
		End If
		Return Null
	End Function

	Method Count:Size_T()
		Return bmx_openxlsx_xlcellstyles_count(cellStylesPtr)
	End Method

	Method CellStyleByIndex:TXLCellStyle(index:Size_T)
		Return TXLCellStyle._Create(bmx_openxlsx_xlcellstyles_cellstylebyindex(cellStylesPtr, index))
	End Method

	Method Delete()
		If cellStylesPtr Then
			bmx_openxlsx_xlcellstyles_free(cellStylesPtr)
			cellStylesPtr = Null
		End If
	End Method

End Type

Type TXLCellStyle

	Field cellStylePtr:Byte Ptr

	Function _Create:TXLCellStyle(cellStylePtr:Byte Ptr)
		If cellStylePtr Then
			Local cellStyle:TXLCellStyle = New TXLCellStyle()
			cellStyle.cellStylePtr = cellStylePtr
			Return cellStyle
		End If
		Return Null
	End Function

	Method Empty:Int()
		Return bmx_openxlsx_xlcellstyle_empty(cellStylePtr)
	End Method

	Method Name:String()
		Return bmx_openxlsx_xlcellstyle_name(cellStylePtr)
	End Method

	Method XfId:Size_T()
		Return bmx_openxlsx_xlcellstyle_xfid(cellStylePtr)
	End Method

	Method BuiltinId:UInt()
		Return bmx_openxlsx_xlcellstyle_builtinid(cellStylePtr)
	End Method

	Method OutlineStyle:UInt()
		Return bmx_openxlsx_xlcellstyle_outlinestyle(cellStylePtr)
	End Method

	Method Hidden:Int()
		Return bmx_openxlsx_xlcellstyle_hidden(cellStylePtr)
	End Method

	Method CustomBuiltin:Int()
		Return bmx_openxlsx_xlcellstyle_custombuiltin(cellStylePtr)
	End Method

	Method SetName:Int(newName:String)
		Return bmx_openxlsx_xlcellstyle_setname(cellStylePtr, newName)
	End Method

	Method SetXfId:Int(newXfId:Size_T)
		Return bmx_openxlsx_xlcellstyle_setxfid(cellStylePtr, newXfId)
	End Method

	Method SetBuiltinId:Int(newBuiltinId:UInt)
		Return bmx_openxlsx_xlcellstyle_setbuiltinid(cellStylePtr, newBuiltinId)
	End Method

	Method SetOutlineStyle:Int(newOutlineStyle:UInt)
		Return bmx_openxlsx_xlcellstyle_setoutlinestyle(cellStylePtr, newOutlineStyle)
	End Method

	Method SetHidden:Int(set:Int = True)
		Return bmx_openxlsx_xlcellstyle_sethidden(cellStylePtr, set)
	End Method

	Method SetCustomBuiltin:Int(set:Int = True)
		Return bmx_openxlsx_xlcellstyle_setcustombuiltin(cellStylePtr, set)
	End Method

	Method Delete()
		If cellStylePtr Then
			bmx_openxlsx_xlcellstyle_free(cellStylePtr)
			cellStylePtr = Null
		End If
	End Method

End Type

Type TXLNumberFormats

	Field numberFormatsPtr:Byte Ptr

	Function _Create:TXLNumberFormats(numberFormatsPtr:Byte Ptr)
		If numberFormatsPtr Then
			Local numberFormats:TXLNumberFormats = New TXLNumberFormats()
			numberFormats.numberFormatsPtr = numberFormatsPtr
			Return numberFormats
		End If
		Return Null
	End Function

	Method Count:Size_T()
		Return bmx_openxlsx_xlnumberformats_count(numberFormatsPtr)
	End Method

	Method NumberFormatByIndex:TXLNumberFormat(index:Size_T)
		Return TXLNumberFormat._Create(bmx_openxlsx_xlnumberformats_numberformatbyindex(numberFormatsPtr, index))
	End Method

	Method NumberFormatById:TXLNumberFormat(numFormatId:UInt)
		Return TXLNumberFormat._Create(bmx_openxlsx_xlnumberformats_numberformatbyid(numberFormatsPtr, numFormatId))
	End Method

	Method NumberFormatIdFromIndex:UInt(index:Size_T)
		Return bmx_openxlsx_xlnumberformats_numberformatidfromindex(numberFormatsPtr, index)
	End Method

	Method Delete()
		If numberFormatsPtr Then
			bmx_openxlsx_xlnumberformats_free(numberFormatsPtr)
			numberFormatsPtr = Null
		End If
	End Method

End Type

Type TXLNumberFormat

	Field numberFormatPtr:Byte Ptr

	Function _Create:TXLNumberFormat(numberFormatPtr:Byte Ptr)
		If numberFormatPtr Then
			Local numberFormat:TXLNumberFormat = New TXLNumberFormat()
			numberFormat.numberFormatPtr = numberFormatPtr
			Return numberFormat
		End If
		Return Null
	End Function

	Method NumberFormatId:UInt()
		Return bmx_openxlsx_xlnumberformat_numberformatid(numberFormatPtr)
	End Method

	Method FormatCode:String()
		Return bmx_openxlsx_xlnumberformat_formatcode(numberFormatPtr)
	End Method

	Method SetNumberFormatId:Int(newNumberFormatId:UInt)
		Return bmx_openxlsx_xlnumberformat_setnumberformatid(numberFormatPtr, newNumberFormatId)
	End Method

	Method SetFormatCode:Int(newFormatCode:String)
		Return bmx_openxlsx_xlnumberformat_setformatcode(numberFormatPtr, newFormatCode)
	End Method

	Method Delete()
		If numberFormatPtr Then
			bmx_openxlsx_xlnumberformat_free(numberFormatPtr)
			numberFormatPtr = Null
		End If
	End Method

End Type

' exceptions

Type TXLException Extends TRuntimeException

	Function _Create:TXLException(message:String) { nomangle }
		Local ex:TXLException = New TXLException()
		ex.error = message
		Return ex
	End Function

End Type

Type TXLRuntimeError Extends TRuntimeException

	Function _Create:TXLRuntimeError(message:String) { nomangle }
		Local ex:TXLRuntimeError = New TXLRuntimeError()
		ex.error = message
		Return ex
	End Function

End Type

Type TXLValueTypeError Extends TRuntimeException

	Function _Create:TXLValueTypeError(message:String) { nomangle }
		Local ex:TXLValueTypeError = New TXLValueTypeError()
		ex.error = message
		Return ex
	End Function

End Type

Type TXLCellAddressError Extends TRuntimeException

	Function _Create:TXLCellAddressError(message:String) { nomangle }
		Local ex:TXLCellAddressError = New TXLCellAddressError()
		ex.error = message
		Return ex
	End Function

End Type

Type TXLInputError Extends TRuntimeException

	Function _Create:TXLInputError(message:String) { nomangle }
		Local ex:TXLInputError = New TXLInputError()
		ex.error = message
		Return ex
	End Function

End Type

Type TXLPropertyError Extends TRuntimeException

	Function _Create:TXLPropertyError(message:String) { nomangle }
		Local ex:TXLPropertyError = New TXLPropertyError()
		ex.error = message
		Return ex
	End Function

End Type
