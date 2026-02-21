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
ModuleInfo "OPENXLSX - Copyright (c) 2020, Kenneth Troldal Balslev"
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

	Method Name:String()
		Return bmx_openxlsx_xldocument_name(docPtr)
	End Method

	Method Path:String()
		Return bmx_openxlsx_xldocument_path(docPtr)
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
