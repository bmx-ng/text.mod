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

Rem
bbdoc: Text/Xlsx
about: A module for reading and writing Excel .xlsx files, based on the OpenXLSX library. 
Provides classes for working with Excel documents, workbooks, worksheets, cells and ranges, as well as styles and formatting.
End Rem
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


Rem
bbdoc: Encapsulates the concept of an excel file.
about: It is different from the #TXLWorkbook, in that an #TXLDocument holds an #TXLWorkbook 
together with its metadata, as well as methods for opening, closing and saving the document
End Rem
Type TXLDocument

	Field docPtr:Byte Ptr

	Method New()
		docPtr = bmx_openxlsx_xldocument_new()
	End Method

	Rem
	bbdoc: Gets the underlying workbook object.
	End Rem
	Method Workbook:TXLWorkbook()
		Return TXLWorkbook._Create(bmx_openxlsx_xldocument_workbook(docPtr))
	End Method

	Rem
	bbdoc: Attempts to open an existing document with the specified @filename.
	End Rem
	Method Open(filename:String)
		bmx_openxlsx_xldocument_open(docPtr, filename)
	End Method

	Rem
	bbdoc: Creates a new document with the specified filename.
	about: If @forceOverwrite is non-zero, any existing file with the same name will be overwritten.
	End Rem
	Method Create(filename:String, forceOverwrite:Int)
		bmx_openxlsx_xldocument_create(docPtr, filename, forceOverwrite)
	End Method

	Rem
	bbdoc: Saves the current document using the current filename, overwriting the existing file.
	about: May throw a #TXLException or #TXLRuntimeError.
	End Rem
	Method Save()
		bmx_openxlsx_xldocument_save(docPtr)
	End Method

	Rem
	bbdoc: Saves the document with a new name.
	about: If a file exists with that name, it will be overwritten if @forceOverwrite is non-zero, otherwise an error will be raised.
	May throw a #TXLException or #TXLRuntimeError.
	End Rem
	Method SaveAs(filename:String, forceOverwrite:Int)
		bmx_openxlsx_xldocument_saveas(docPtr, filename, forceOverwrite)
	End Method

	Rem
	bbdoc: Closes the current document.
	End Rem
	Method Close()
		bmx_openxlsx_xldocument_close(docPtr)
	End Method

	Rem
	bbdoc: Determines if the document is currently open.
	End Rem
	Method IsOpen:Int()
		Return bmx_openxlsx_xldocument_isopen(docPtr)
	End Method

	Rem
	bbdoc: Gets the filename of the current document, e.g. "spreadsheet.xlsx".
	End Rem
	Method Name:String()
		Return bmx_openxlsx_xldocument_name(docPtr)
	End Method

	Rem
	bbdoc: Gets the full path of the current document, e.g. "drive/blah/spreadsheet.xlsx"
	End Rem
	Method Path:String()
		Return bmx_openxlsx_xldocument_path(docPtr)
	End Method

	Rem
	bbdoc: Gets the value of a document property, e.g. Title, Author, etc.
	End Rem
	Method Property:String(prop:EXLProperty)
		Return bmx_openxlsx_xldocument_property(docPtr, prop)
	End Method

	Rem
	bbdoc: Sets the value of a document property, e.g. Title, Author, etc.
	End Rem
	Method SetProperty(prop:EXLProperty, value:String)
		bmx_openxlsx_xldocument_setproperty(docPtr, prop, value)
	End Method

	Rem
	bbdoc: Deletes a document property, e.g. Title, Author, etc.
	End Rem
	Method DeleteProperty(prop:EXLProperty)
		bmx_openxlsx_xldocument_deleteproperty(docPtr, prop)
	End Method

	Rem
	bbdoc: Gets the styles collection for the document, which can be used to create and manage cell styles.
	End Rem
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

Rem
bbdoc: Represents a workbook within an Excel document.
about: A workbook contains one or more worksheets, as well as methods for managing those worksheets.
End Rem
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

	Rem
	bbdoc: Adds a new worksheet with the specified @name to the workbook.
	End Rem
	Method AddWorksheet(name:String)
		bmx_openxlsx_xlworkbook_addworksheet(workbookPtr, name)
	End Method

	Rem
	bbdoc: Deletes the worksheet with the specified @name from the workbook.
	End Rem
	Method DeleteSheet(name:String)
		bmx_openxlsx_xlworkbook_deletesheet(workbookPtr, name)
	End Method

	Rem
	bbdoc: Clones the worksheet with the specified @name and gives the new worksheet the specified @newName.
	End Rem
	Method CloneSheet(name:String, newName:String)
		bmx_openxlsx_xlworkbook_clonesheet(workbookPtr, name, newName)
	End Method

	Rem
	bbdoc: Sets the index of the sheet with the specified @name to the specified @index.
	End Rem
	Method SetSheetIndex(name:String, index:UInt)
		bmx_openxlsx_xlworkbook_setsheetindex(workbookPtr, name, index)
	End Method

	Rem
	bbdoc: Gets the index of the sheet with the specified @name.
	End Rem
	Method IndexOfSheet:UInt(name:String)
		Return bmx_openxlsx_xlworkbook_indexofsheet(workbookPtr, name)
	End Method

	Rem
	bbdoc: Gets the type of the sheet with the specified @name.
	End Rem
	Method TypeOfSheet:EXLSheetType(name:String)
		Return bmx_openxlsx_xlworkbook_typeofsheet(workbookPtr, name)
	End Method

	Rem
	bbdoc: Gets the type of the sheet with the specified @index.
	End Rem
	Method TypeOfSheet:EXLSheetType(index:UInt)
		Return bmx_openxlsx_xlworkbook_typeofsheetbyindex(workbookPtr, index)
	End Method

	Rem
	bbdoc: Determines if a sheet with the specified @name exists in the workbook.
	End Rem
	Method WorksheetExists:Int(name:String)
		Return bmx_openxlsx_xlworkbook_worksheetexists(workbookPtr, name)
	End Method

	Rem
	bbdoc: Gets the worksheet with the specified @name.
	End Rem
	Method Worksheet:TXLWorkSheet(name:String)
		Return TXLWorkSheet._Create(bmx_openxlsx_xlworkbook_worksheet_str(workbookPtr, name))
	End Method

	Rem
	bbdoc: Gets the worksheet with the specified @index.
	End Rem
	Method Worksheet:TXLWorkSheet(index:Short)
		Return TXLWorkSheet._Create(bmx_openxlsx_xlworkbook_worksheet(workbookPtr, index))
	End Method

	Rem
	bbdoc: Gets an array of the names of all worksheets in the workbook.
	End Rem
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

Rem
bbdoc: Represents a worksheet within a workbook.
End Rem
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

	Rem
	bbdoc: Gets the cell with the specified @name, e.g. "A1", "B2", etc.
	End Rem
	Method Cell:TXLCell(name:String)
		Return TXLCell._Create(bmx_openxlsx_xlworksheet_cell(worksheetPtr, name))
	End Method

	Rem
	bbdoc: Gets the cell with the specified @reference.
	End Rem
	Method Cell:TXLCell(reference:TXLCellReference)
		Return TXLCell._Create(bmx_openxlsx_xlworksheet_cell_ref(worksheetPtr, reference.referencePtr))
	End Method

	Rem
	bbdoc: Gets the visibility state of the worksheet.
	End Rem
	Method Visibility:EXLSheetState()
		Return bmx_openxlsx_xlworksheet_visibility(worksheetPtr)
	End Method

	Rem
	bbdoc: Sets the visibility state of the worksheet.
	End Rem
	Method SetVisibility(state:EXLSheetState)
		bmx_openxlsx_xlworksheet_setvisibility(worksheetPtr, state)
	End Method

	Rem
	bbdoc: Gets the tab color of the worksheet as an #SColor8 value.
	End Rem
	Method Color:SColor8()
		Return bmx_openxlsx_xlworksheet_color(worksheetPtr)
	End Method

	Rem
	bbdoc: Sets the tab color of the worksheet using an #SColor8 value.
	End Rem
	Method SetColor(color:SColor8)
		bmx_openxlsx_xlworksheet_setcolor(worksheetPtr, color)
	End Method

	Rem
	bbdoc: Gets the index of the worksheet within the workbook.
	End Rem
	Method Index:Short()
		Return bmx_openxlsx_xlworksheet_index(worksheetPtr)
	End Method

	Rem
	bbdoc: Sets the index of the worksheet within the workbook.
	End Rem
	Method SetIndex(index:Short)
		bmx_openxlsx_xlworksheet_setindex(worksheetPtr, index)
	End Method

	Rem
	bbdoc: Gets the name of the worksheet.
	End Rem
	Method Name:String()
		Return bmx_openxlsx_xlworksheet_name(worksheetPtr)
	End Method

	Rem
	bbdoc: Sets the name of the worksheet.
	End Rem
	Method SetName(name:String)
		bmx_openxlsx_xlworksheet_setname(worksheetPtr, name)
	End Method

	Rem
	bbdoc: Determines if the worksheet is selected.
	End Rem
	Method IsSelected:Int()
		Return bmx_openxlsx_xlworksheet_isselected(worksheetPtr)
	End Method

	Rem
	bbdoc: Sets the selection state of the worksheet.
	End Rem
	Method SetSelected(selected:Int)
		bmx_openxlsx_xlworksheet_setselected(worksheetPtr, selected)
	End Method

	Rem
	bbdoc: Determines if the worksheet is the active sheet in the workbook.
	End Rem
	Method IsActive:Int()
		Return bmx_openxlsx_xlworksheet_isactive(worksheetPtr)
	End Method

	Rem
	bbdoc: Sets the worksheet as the active sheet in the workbook.
	End Rem
	Method SetActive()
		bmx_openxlsx_xlworksheet_setactive(worksheetPtr)
	End Method

	Rem
	bbdoc: Clones the worksheet with a new name.
	End Rem
	Method Clone(newName:String)
		bmx_openxlsx_xlworksheet_clone(worksheetPtr, newName)
	End Method

	Rem
	bbdoc: Gets the range of cells that contain data in the worksheet.
	End Rem
	Method Range:TXLCellRange()
		Return TXLCellRange._Create(bmx_openxlsx_xlworksheet_range(worksheetPtr))
	End Method

	Rem
	bbdoc: Gets the range of cells with the specified top-left and bottom-right corners.
	End Rem
	Method Range:TXLCellRange(topLeft:String, bottomRight:String)
		Return TXLCellRange._Create(bmx_openxlsx_xlworksheet_range_str(worksheetPtr, topLeft, bottomRight))
	End Method

	Rem
	bbdoc: Gets the range of cells with the specified top-left and bottom-right corners.
	End Rem
	Method Range:TXLCellRange(topLeft:TXLCellReference, bottomRight:TXLCellReference)
		Return TXLCellRange._Create(bmx_openxlsx_xlworksheet_range_ref(worksheetPtr, topLeft.referencePtr, bottomRight.referencePtr))
	End Method

	Rem
	bbdoc: Gets the range of cells with the specified range reference.
	End Rem
	Method Range:TXLCellRange(rangeReference:String)
		Return TXLCellRange._Create(bmx_openxlsx_xlworksheet_range_refstr(worksheetPtr, rangeReference))
	End Method

	Rem
	bbdoc: Gets the row with the specified row number.
	End Rem
	Method Row:TXLRow(rowNumber:UInt)
		Return TXLRow._Create(bmx_openxlsx_xlworksheet_row(worksheetPtr, rowNumber))
	End Method

	Rem
	bbdoc: Gets the range of rows in the worksheet.
	End Rem
	Method Rows:TXLRowRange()
		Return TXLRowRange._Create(bmx_openxlsx_xlworksheet_rows(worksheetPtr))
	End Method

	Rem
	bbdoc: Gets the range of rows with the specified row count.
	End Rem
	Method Rows:TXLRowRange(rowCount:UInt)
		Return TXLRowRange._Create(bmx_openxlsx_xlworksheet_rows_count(worksheetPtr, rowCount))
	End Method

	Rem
	bbdoc: Gets the range of rows with the specified first and last row.
	End Rem
	Method Rows:TXLRowRange(firstRow:UInt, lastRow:UInt)
		Return TXLRowRange._Create(bmx_openxlsx_xlworksheet_rows_range(worksheetPtr, firstRow, lastRow))
	End Method

	Rem
	bbdoc: Gets the column with the specified column number.
	End Rem
	Method Column:TXLColumn(columnNumber:Short)
		Return TXLColumn._Create(bmx_openxlsx_xlworksheet_column(worksheetPtr, columnNumber))
	End Method

	Rem
	bbdoc: Gets the column with the specified column reference.
	End Rem
	Method Column:TXLColumn(columnRef:String)
		Return TXLColumn._Create(bmx_openxlsx_xlworksheet_column_str(worksheetPtr, columnRef))
	End Method

	Rem
	bbdoc: Gets the last cell in the worksheet.
	End Rem
	Method LastCell:TXLCell()
		Return TXLCell._Create(bmx_openxlsx_xlworksheet_lastcell(worksheetPtr))
	End Method

	Rem
	bbdoc: Gets the number of columns in the worksheet.
	End Rem
	Method ColumnCount:Short()
		Return bmx_openxlsx_xlworksheet_columncount(worksheetPtr)
	End Method

	Rem
	bbdoc: Gets the number of rows in the worksheet.
	End Rem
	Method RowCount:UInt()
		Return bmx_openxlsx_xlworksheet_rowcount(worksheetPtr)
	End Method

	Rem
	bbdoc: Deletes the row with the specified @rowNumber from the worksheet.
	End Rem
	Method DeleteRow(rowNumber:UInt)
		bmx_openxlsx_xlworksheet_deleterow(worksheetPtr, rowNumber)
	End Method

	Rem
	bbdoc: Updates the name of the worksheet.
	End Rem
	Method UpdateSheetName(oldName:String, newName:String)
		bmx_openxlsx_xlworksheet_updatesheetname(worksheetPtr, oldName, newName)
	End Method

	Rem
	bbdoc: Enables or disables sheet protection.
	End Rem
	Method ProtectSheet:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_protectsheet(worksheetPtr, set)
	End Method

	Rem
	bbdoc: Enables or disables protection of objects on the sheet.
	End Rem
	Method ProtectObjects:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_protectobjects(worksheetPtr, set)
	End Method

	Rem
	bbdoc: Enables or disables protection of scenarios on the sheet.
	End Rem
	Method ProtectScenarios:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_protectscenarios(worksheetPtr, set)
	End Method

	Rem
	bbdoc: Enables or disables the ability to insert columns on the sheet.
	End Rem
	Method AllowInsertColumns:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowinsertcolumns(worksheetPtr, set)
	End Method

	Rem
	bbdoc: Enables or disables the ability to insert rows on the sheet.
	End Rem
	Method AllowInsertRows:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowinsertrows(worksheetPtr, set)
	End Method

	Rem
	bbdoc: Enables or disables the ability to delete columns on the sheet.
	End Rem
	Method AllowDeleteColumns:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowdeletecolumns(worksheetPtr, set)
	End Method

	Rem
	bbdoc: Enables or disables the ability to delete rows on the sheet.
	End Rem
	Method AllowDeleteRows:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowdeleterows(worksheetPtr, set)
	End Method

	Rem
	bbdoc: Enables or disables the ability to select locked cells on the sheet.
	End Rem
	Method AllowSelectLockedCells:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowselectlockedcells(worksheetPtr, set)
	End Method

	Rem
	bbdoc: Enables or disables the ability to select unlocked cells on the sheet.
	End Rem
	Method AllowSelectUnlockedCells:Int(set:Int = True)
		Return bmx_openxlsx_xlworksheet_allowselectunlockedcells(worksheetPtr, set)
	End Method

	Rem
	bbdoc: Denies the ability to insert columns on the sheet.
	End Rem
	Method DenyInsertColumns:Int()
		Return AllowInsertColumns(False)
	End Method

	Rem
	bbdoc: Denies the ability to insert rows on the sheet.
	End Rem
	Method DenyInsertRows:Int()
		Return AllowInsertRows(False)
	End Method

	Rem
	bbdoc: Denies the ability to delete columns on the sheet.
	End Rem
	Method DenyDeleteColumns:Int()
		Return AllowDeleteColumns(False)
	End Method

	Rem
	bbdoc: Denies the ability to delete rows on the sheet.
	End Rem
	Method DenyDeleteRows:Int()
		Return AllowDeleteRows(False)
	End Method

	Rem
	bbdoc: Denies the ability to select locked cells on the sheet.
	End Rem
	Method DenySelectLockedCells:Int()
		Return AllowSelectLockedCells(False)
	End Method

	Rem
	bbdoc: Denies the ability to select unlocked cells on the sheet.
	End Rem
	Method DenySelectUnlockedCells:Int()
		Return AllowSelectUnlockedCells(False)
	End Method

	Rem
	bbdoc: Sets the password hash for the worksheet.
	End Rem
	Method SetPasswordHash:Int(hash:String)
		Return bmx_openxlsx_xlworksheet_setpasswordhash(worksheetPtr, hash)
	End Method

	Rem
	bbdoc: Sets the password for the worksheet.
	End Rem
	Method SetPassword:Int(password:String)
		Return bmx_openxlsx_xlworksheet_setpassword(worksheetPtr, password)
	End Method

	Rem
	bbdoc: Clears the password for the worksheet.
	End Rem
	Method ClearPassword:Int()
		Return bmx_openxlsx_xlworksheet_clearpassword(worksheetPtr)
	End Method

	Rem
	bbdoc: Clears all protection from the worksheet.
	End Rem
	Method ClearSheetProtection:Int()
		Return bmx_openxlsx_xlworksheet_clearsheetprotection(worksheetPtr)
	End Method

	Rem
	bbdoc: Checks if the worksheet is protected.
	End Rem
	Method SheetProtected:Int()
		Return bmx_openxlsx_xlworksheet_sheetprotected(worksheetPtr)
	End Method

	Rem
	bbdoc: Checks if the objects on the worksheet are protected.
	End Rem
	Method ObjectsProtected:Int()
		Return bmx_openxlsx_xlworksheet_objectsprotected(worksheetPtr)
	End Method

	Rem
	bbdoc: Checks if the scenarios on the worksheet are protected.
	End Rem
	Method ScenariosProtected:Int()
		Return bmx_openxlsx_xlworksheet_scenariosprotected(worksheetPtr)
	End Method

	Rem
	bbdoc: Checks if inserting columns is allowed on the sheet.
	End Rem
	Method InsertColumnsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_insertcolumnsallowed(worksheetPtr)
	End Method

	Rem
	bbdoc: Checks if inserting rows is allowed on the sheet.
	End Rem
	Method InsertRowsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_insertrowsallowed(worksheetPtr)
	End Method

	Rem
	bbdoc: Checks if deleting columns is allowed on the sheet.
	End Rem
	Method DeleteColumnsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_deletecolumnsallowed(worksheetPtr)
	End Method

	Rem
	bbdoc: Checks if deleting rows is allowed on the sheet.
	End Rem
	Method DeleteRowsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_deleterowsallowed(worksheetPtr)
	End Method

	Rem
	bbdoc: Checks if selecting locked cells is allowed on the sheet.
	End Rem
	Method SelectLockedCellsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_selectlockedcellsallowed(worksheetPtr)
	End Method

	Rem
	bbdoc: Checks if selecting unlocked cells is allowed on the sheet.
	End Rem
	Method SelectUnlockedCellsAllowed:Int()
		Return bmx_openxlsx_xlworksheet_selectunlockedcellsallowed(worksheetPtr)
	End Method

	Rem
	bbdoc: Gets the password hash for the worksheet.
	End Rem
	Method PasswordHash:String()
		Return bmx_openxlsx_xlworksheet_passwordhash(worksheetPtr)
	End Method

	Rem
	bbdoc: Checks if a password is set for the worksheet.
	End Rem
	Method PasswordIsSet:Int()
		Return bmx_openxlsx_xlworksheet_passwordisset(worksheetPtr)
	End Method

	Rem
	bbdoc: Merges the specified range of cells into a single cell.
	End Rem
	Method MergeCells(range:TXLCellRange, emptyHiddenCells:Int = False)
		bmx_openxlsx_xlworksheet_mergecells(worksheetPtr, range.rangePtr, emptyHiddenCells)
	End Method

	Rem
	bbdoc: Merges the specified range of cells into a single cell.
	End Rem
	Method MergeCells(rangeReference:String, emptyHiddenCells:Int = False)
		bmx_openxlsx_xlworksheet_mergecells_str(worksheetPtr, rangeReference, emptyHiddenCells)
	End Method

	Rem
	bbdoc: Unmerges the specified range of cells.
	End Rem
	Method UnmergeCells(rangeToUnmerge:TXLCellRange)
		bmx_openxlsx_xlworksheet_unmergecells(worksheetPtr, rangeToUnmerge.rangePtr)
	End Method

	Rem
	bbdoc: Unmerges the specified range of cells.
	End Rem
	Method UnmergeCells(rangeReference:String)
		bmx_openxlsx_xlworksheet_unmergecells_str(worksheetPtr, rangeReference)
	End Method

	Rem
	bbdoc: Gets the format index for the specified column.
	End Rem
	Method GetColumnFormat:Size_T(column:Short)
		Return bmx_openxlsx_xlworksheet_getcolumnformat(worksheetPtr, column)
	End Method

	Rem
	bbdoc: Gets the format index for the specified column.
	End Rem
	Method GetColumnFormat:Size_T(columnRef:String)
		Return bmx_openxlsx_xlworksheet_getcolumnformat_str(worksheetPtr, columnRef)
	End Method

	Rem
	bbdoc: Sets the format index for the specified column.
	End Rem
	Method SetColumnFormat(column:Short, cellFormatIndex:Size_T)
		bmx_openxlsx_xlworksheet_setcolumnformat(worksheetPtr, column, cellFormatIndex)
	End Method

	Rem
	bbdoc: Sets the format index for the specified column.
	End Rem
	Method SetColumnFormat(columnRef:String, cellFormatIndex:Size_T)
		bmx_openxlsx_xlworksheet_setcolumnformat_str(worksheetPtr, columnRef, cellFormatIndex)
	End Method

	Rem
	bbdoc: Gets the format index for the specified row.
	End Rem
	Method GetRowFormat:Size_T(row:UInt)
		Return bmx_openxlsx_xlworksheet_getrowformat(worksheetPtr, row)
	End Method

	Rem
	bbdoc: Sets the format index for the specified row.
	End Rem
	Method SetRowFormat(row:UInt, cellFormatIndex:Size_T)
		bmx_openxlsx_xlworksheet_setrowformat(worksheetPtr, row, cellFormatIndex)
	End Method

	Rem
	bbdoc: Gets the conditional formats for the worksheet.
	End Rem
	Method ConditionalFormats:TXLConditionalFormats()
		Return TXLConditionalFormats._Create(bmx_openxlsx_xlworksheet_conditionalformats(worksheetPtr))
	End Method

	Method Delete()
		If worksheetPtr Then
			bmx_openxlsx_xlworksheet_free(worksheetPtr)
			worksheetPtr = Null
		End If
	End Method
End Type

Rem
bbdoc: Encapsulates the concept of a cell range, i.e. a square area (or subset) of cells in a spreadsheet.
End Rem
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

	Rem
	bbdoc: Gets an iterator for the cells in the range.
	End Rem
	Method GetIterator:IIterator<TXLCell>() Override
		Return TXLCellRangeIterator._Create(Self, bmx_openxlsx_xlcellrange_iterator(rangePtr))
	End Method

	Rem
	bbdoc: Gets the string reference that corresponds to the represented cell range.
	End Rem
	Method Address:String()
		Return bmx_openxlsx_xlcellrange_address(rangePtr)
	End Method

	Rem
	bbdoc: Gets the top-left cell reference of the range.
	End Rem
	Method TopLeft:TXLCellReference()
		Return TXLCellReference._Create(bmx_openxlsx_xlcellrange_topleft(rangePtr))
	End Method

	Rem
	bbdoc: Gets the bottom-right cell reference of the range.
	End Rem
	Method BottomRight:TXLCellReference()
		Return TXLCellReference._Create(bmx_openxlsx_xlcellrange_bottomright(rangePtr))
	End Method

	Rem
	bbdoc: Gets the number of rows in the range.
	End Rem
	Method NumRows:UInt()
		Return bmx_openxlsx_xlcellrange_numrows(rangePtr)
	End Method

	Rem
	bbdoc: Gets the number of columns in the range.
	End Rem
	Method NumColumns:Short()
		Return bmx_openxlsx_xlcellrange_numcolumns(rangePtr)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #Float value.
	End Rem
	Method SetValue(value:Float)
		bmx_openxlsx_xlcellrange_setvalue_double(rangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #Float value.
	End Rem
	Method SetValueFloat(value:Float)
		bmx_openxlsx_xlcellrange_setvalue_double(rangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #Double value.
	End Rem
	Method SetValue(value:Double)
		bmx_openxlsx_xlcellrange_setvalue_double(rangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #Double value.
	End Rem
	Method SetValueDouble(value:Double)
		bmx_openxlsx_xlcellrange_setvalue_double(rangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #Int value.
	End Rem
	Method SetValue(value:Int)
		bmx_openxlsx_xlcellrange_setvalue_long(rangePtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #Int value.
	End Rem
	Method SetValueInt(value:Int)
		bmx_openxlsx_xlcellrange_setvalue_long(rangePtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #Long value.
	End Rem
	Method SetValue(value:Long)
		bmx_openxlsx_xlcellrange_setvalue_long(rangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #Long value.
	End Rem
	Method SetValueLong(value:Long)
		bmx_openxlsx_xlcellrange_setvalue_long(rangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #UInt value
	End Rem
	Method SetValue(value:UInt)
		bmx_openxlsx_xlcellrange_setvalue_long(rangePtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #UInt value
	End Rem
	Method SetValueUInt(value:UInt)
		bmx_openxlsx_xlcellrange_setvalue_long(rangePtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #ULong value
	End Rem
	Method SetValue(value:ULong)
		bmx_openxlsx_xlcellrange_setvalue_ulong(rangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #ULong value
	End Rem
	Method SetValueULong(value:ULong)
		bmx_openxlsx_xlcellrange_setvalue_ulong(rangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #String value
	End Rem
	Method SetValue(value:String)
		bmx_openxlsx_xlcellrange_setvalue_string(rangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #String value
	End Rem
	Method SetValueString(value:String)
		bmx_openxlsx_xlcellrange_setvalue_string(rangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the range to the specified #Int value, where non-zero is treated as #True and zero is treated as #False.
	End Rem
	Method SetValueBool(value:Int)
		bmx_openxlsx_xlcellrange_setvalue_bool(rangePtr, value)
	End Method

	Rem
	bbdoc: Sets the cell format for all cells in the range to the specified format index.
	End Rem
	Method SetFormat:Int(formatIndex:Size_T)
		bmx_openxlsx_xlcellrange_setformat(rangePtr, formatIndex)
	End Method

	Rem
	bbdoc: Gets the distance (number of cells) in the range.
	End Rem
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

Rem
bbdoc: An iterator for iterating over the cells in a #TXLCellRange.
End Rem
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

	Rem
	bbdoc: Gets the current cell in the iteration.
	End Rem
	Method Current:TXLCell() Override
		Return _current
	End Method

	Rem
	bbdoc: Advances the iterator to the next cell in the range, returning #True if there is a next cell or #False if the end of the range has been reached.
	End Rem
	Method MoveNext:Int() Override
		If bmx_openxlsx_xlcellrange_iterator_hasnext(_iteratorPtr) Then
			_current = TXLCell._Create(bmx_openxlsx_xlcellrange_iterator_next(_iteratorPtr))
			Return True
		End If
		_current = Null
		Return False
	End Method

	Rem
	bbdoc: Closes the iterator and releases any associated resources.
	End Rem
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

Rem
bbdoc: Represents a single cell in a worksheet, encapsulating the properties and behaviours of a spreadsheet cell.
End Rem
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

	Rem
	bbdoc: Determines if the cell is empty (i.e. has no value).
	End Rem
	Method Empty:Int()
		Return bmx_openxlsx_xlcell_empty(cellPtr)
	End Method

	Rem
	bbdoc: Gets the type of value stored in the cell.
	End Rem
	Method ValueType:EXLValueType()
		Return bmx_openxlsx_xlcell_valuetype(cellPtr)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #Float value.
	End Rem
	Method SetValue(value:Float)
		bmx_openxlsx_xlcell_setvalue_double(cellPtr, value)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #Float value.
	End Rem
	Method SetValueFloat(value:Float)
		bmx_openxlsx_xlcell_setvalue_double(cellPtr, value)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #Double value.
	End Rem
	Method SetValue(value:Double)
		bmx_openxlsx_xlcell_setvalue_double(cellPtr, value)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #Double value.
	End Rem
	Method SetValueDouble(value:Double)
		bmx_openxlsx_xlcell_setvalue_double(cellPtr, value)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #Int value.
	End Rem
	Method SetValue(value:Int)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #Int value.
	End Rem
	Method SetValueInt(value:Int)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #Long value.
	End Rem
	Method SetValue(value:Long)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, value)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #Long value.
	End Rem
	Method SetValueLong(value:Long)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, value)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #UInt value
	End Rem
	Method SetValue(value:UInt)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #UInt value
	End Rem
	Method SetValueUInt(value:UInt)
		bmx_openxlsx_xlcell_setvalue_long(cellPtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #ULong value
	End Rem
	Method SetValue(value:ULong)
		bmx_openxlsx_xlcell_setvalue_ulong(cellPtr, value)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #ULong value
	End Rem
	Method SetValueULong(value:ULong)
		bmx_openxlsx_xlcell_setvalue_ulong(cellPtr, value)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #String value
	End Rem
	Method SetValue(value:String)
		bmx_openxlsx_xlcell_setvalue_string(cellPtr, value)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #String value
	End Rem
	Method SetValueString(value:String)
		bmx_openxlsx_xlcell_setvalue_string(cellPtr, value)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the specified #Int value, where non-zero is treated as #True and zero is treated as #False.
	End Rem
	Method SetValueBool(value:Int)
		bmx_openxlsx_xlcell_setvalue_bool(cellPtr, value)
	End Method

	Rem
	bbdoc: Sets the value of the cell to the value of another @cell.
	End Rem
	Method SetValue(cell:TXLCell)
		bmx_openxlsx_xlcell_setvalue_cell(cellPtr, cell.cellPtr)
	End Method

	Rem
	bbdoc: Gets the value of the cell as a #Double.
	about: If the cell contains a value that cannot be represented as a #Double, this method will throw an TXLValueTypeError.
	End Rem
	Method GetValueDouble:Double()
		Return bmx_openxlsx_xlcell_getvalue_double(cellPtr)
	End Method

	Rem
	bbdoc: Gets the value of the cell as a #Long.
	about: If the cell contains a value that cannot be represented as a #Long, this method will throw an TXLValueTypeError.
	End Rem
	Method GetValueLong:Long()
		Return bmx_openxlsx_xlcell_getvalue_long(cellPtr)
	End Method

	Rem
	bbdoc: Gets the value of the cell as a #ULong.
	about: If the cell contains a value that cannot be represented as a #ULong, this method will throw an TXLValueTypeError.
	End Rem
	Method GetValueULong:ULong()
		Return bmx_openxlsx_xlcell_getvalue_ulong(cellPtr)
	End Method

	Rem
	bbdoc: Gets the value of the cell as a #String.
	End Rem
	Method GetValueString:String()
		Return bmx_openxlsx_xlcell_getvalue_string(cellPtr)
	End Method

	Rem
	bbdoc: Gets the value of the cell as a #Int, where non-zero is treated as #True and zero is treated as #False.
	about: If the cell contains a value that cannot be represented as a #Int, this method will throw an TXLValueTypeError.
	End Rem
	Method GetValueBool:Int()
		Return bmx_openxlsx_xlcell_getvalue_bool(cellPtr)
	End Method

	Rem
	bbdoc: Gets the type of the value stored in the cell as a string.
	End Rem
	Method TypeAsString:String()
		Return bmx_openxlsx_xlcell_typeasstring(cellPtr)
	End Method

	Rem
	bbdoc: Determines if the cell contains a formula.
	End Rem
	Method HasFormula:Int()
		Return bmx_openxlsx_xlcell_hasformula(cellPtr)
	End Method

	Rem
	bbdoc: Gets the formula stored in the cell as a string.
	End Rem
	Method Formula:String()
		Return bmx_openxlsx_xlcell_formula(cellPtr)
	End Method

	Rem
	bbdoc: Sets the formula for the cell.
	about: The formula should be provided as a string in the same format as it would be entered into Excel, e.g. "=SUM(A1:A10)".
	End Rem
	Method SetFormula(formula:String)
		bmx_openxlsx_xlcell_setformula(cellPtr, formula)
	End Method

	Rem
	bbdoc: Clears the formula from the cell, if one exists.
	about: This will not clear the value from the cell, so if the cell had a formula that evaluated to a value, the value will remain in the cell after calling this method.
	End Rem
	Method ClearFormula()
		bmx_openxlsx_xlcell_clearformula(cellPtr)
	End Method

	Rem
	bbdoc: Gets the format index for the cell.
	about: The format index corresponds to a cell format defined in the workbook's styles.
	End Rem
	Method CellFormat:Size_T()
		Return bmx_openxlsx_xlcell_cellformat(cellPtr)
	End Method

	Rem
	bbdoc: Sets the format index for the cell.
	about: The format index corresponds to a cell format defined in the workbook's styles.
	End Rem
	Method SetCellFormat:Int(cellFormatIndex:Size_T)
		Return bmx_openxlsx_xlcell_setcellformat(cellPtr, cellFormatIndex)
	End Method
	
	Method Delete()
		If cellPtr Then
			bmx_openxlsx_xlcell_free(cellPtr)
			cellPtr = Null
		End If
	End Method
End Type

Rem
bbdoc: Represents a reference to a single cell in a worksheet.
about: This is used to specify the location of a cell, e.g. as the top-left or bottom-right corner of a cell range.
It does not represent an actual cell and does not have any value or formatting properties.
End Rem
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

	Rem
	bbdoc: Creates a new cell reference from the specified cell address string, e.g. "A1".
	End Rem
	Method New(cellAddress:String)
		referencePtr = bmx_openxlsx_xlcellreference_new_celladdress(cellAddress)
	End Method

	Rem
	bbdoc: Creates a new cell reference from the specified row and column numbers.
	about: Row numbers are 1-based, so the first row is row 1. Column numbers are also 1-based, so the first column is column 1 (which corresponds to column "A").
	End Rem
	Method New(row:UInt, column:Short)
		referencePtr = bmx_openxlsx_xlcellreference_new_rowcolumn(row, column)
	End Method

	Rem
	bbdoc: Creates a new cell reference from the specified row number and column reference string.
	about: Row numbers are 1-based, so the first row is row 1. The column reference should be a string in the same format as Excel column references, e.g. "A", "B", ..., "Z", "AA", etc.
	End Rem
	Method New(row:UInt, column:String)
		referencePtr = bmx_openxlsx_xlcellreference_new_rowcolumn_str(row, column)
	End Method

	Rem
	bbdoc: Gets the row number of the cell reference.
	about: Row numbers are 1-based, so the first row is row 1.
	End Rem
	Method Row:UInt()
		Return bmx_openxlsx_xlcellreference_row(referencePtr)
	End Method

	Rem
	bbdoc: Sets the row number of the cell reference.
	about: Row numbers are 1-based, so the first row is row 1.
	End Rem
	Method SetRow(row:UInt)
		bmx_openxlsx_xlcellreference_setrow(referencePtr, row)
	End Method

	Rem
	bbdoc: Gets the column number of the cell reference.
	about: Column numbers are 1-based, so the first column is column 1 (which corresponds to column "A").
	End Rem
	Method Column:Short()
		Return bmx_openxlsx_xlcellreference_column(referencePtr)
	End Method

	Rem
	bbdoc: Sets the column number of the cell reference.
	about: Column numbers are 1-based, so the first column is column 1 (which corresponds to column "A").
	End Rem
	Method SetColumn(column:Short)
		bmx_openxlsx_xlcellreference_setcolumn(referencePtr, column)
	End Method

	Rem
	bbdoc: Sets the row and column numbers of the cell reference.
	about: Row numbers are 1-based, so the first row is row 1. Column numbers are also 1-based, so the first column is column 1 (which corresponds to column "A").
	End Rem
	Method SetRowAndColumn(row:UInt, column:Short)
		bmx_openxlsx_xlcellreference_setrowcolumn(referencePtr, row, column)
	End Method

	Rem
	bbdoc: Gets the address of the cell reference, e.g. "A1".
	End Rem
	Method Address:String()
		Return bmx_openxlsx_xlcellreference_address(referencePtr)
	End Method

	Rem
	bbdoc: Sets the cell reference using the specified cell address string, e.g. "A1".
	End Rem
	Method SetAddress(address:String)
		bmx_openxlsx_xlcellreference_setaddress(referencePtr, address)
	End Method

	Rem
	bbdoc: Converts a row number to its corresponding Excel row reference string, e.g. 1 -> "1", 2 -> "2", etc.
	End Rem
	Function RowAsString:String(row:UInt)
		Return bmx_openxlsx_xlcellreference_rowasstring(row)
	End Function

	Rem
	bbdoc: Converts a row reference string to its corresponding row number, e.g. "1" -> 1, "2" -> 2, etc.
	End Rem
	Function RowAsNumber:UInt(row:String)
		Return bmx_openxlsx_xlcellreference_rowasnumber(row)
	End Function

	Rem
	bbdoc: Converts a column number to its corresponding Excel column reference string, e.g. 1 -> "A", 2 -> "B", ..., 26 -> "Z", 27 -> "AA", etc.
	End Rem
	Function ColumnAsString:String(column:Short)
		Return bmx_openxlsx_xlcellreference_columnasstring(column)
	End Function

	Rem
	bbdoc: Converts a column reference string to its corresponding column number, e.g. "A" -> 1, "B" -> 2, ..., "Z" -> 26, "AA" -> 27, etc.
	End Rem
	Function ColumnAsNumber:Short(column:String)
		Return bmx_openxlsx_xlcellreference_columnasnumber(column)
	End Function

	Method Delete()
		If referencePtr Then
			bmx_openxlsx_xlcellreference_free(referencePtr)
			referencePtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents a single row in a worksheet, encapsulating the properties and behaviours of a spreadsheet row.
End Rem
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

	Rem
	bbdoc: Determines if the row is empty (i.e. has no cells with values).
	End Rem
	Method Empty:Int()
		Return bmx_openxlsx_xlrow_empty(rowPtr)
	End Method

	Rem
	bbdoc: Gets the height of the row in points.
	End Rem
	Method Height:Float()
		Return bmx_openxlsx_xlrow_height(rowPtr)
	End Method

	Rem
	bbdoc: Sets the height of the row in points.
	about: The height of the row is measured in points, where 1 point is equal to 1/72 of an inch.
	The default row height in Excel is typically around 15 points, but this can vary based on the font and size used in the cells.
	Setting the height to 0 will auto-size the row based on the content of the cells in the row.
	End Rem
	Method SetHeight(height:Float)
		bmx_openxlsx_xlrow_setheight(rowPtr, height)
	End Method

	Rem
	bbdoc: Gets the descent of the row in points.
	about: The descent of a row is the distance from the baseline to the bottom of the tallest cell in the row.
	It is used to determine the spacing between rows when the row height is set to auto-size (i.e. height of 0).
	The descent is measured in points, where 1 point is equal to 1/72 of an inch.
	End Rem
	Method Descent:Float()
		Return bmx_openxlsx_xlrow_descent(rowPtr)
	End Method

	Rem
	bbdoc: Sets the descent of the row in points.
	about: The descent of a row is the distance from the baseline to the bottom of the tallest cell in the row.
	It is used to determine the spacing between rows when the row height is set to auto-size (i.e. height of 0).
	The descent is measured in points, where 1 point is equal to 1/72 of an inch.
	End Rem
	Method SetDescent(descent:Float)
		bmx_openxlsx_xlrow_setdescent(rowPtr, descent)
	End Method

	Rem
	bbdoc: Checks if the row is hidden.
	End Rem
	Method IsHidden:Int()
		Return bmx_openxlsx_xlrow_ishidden(rowPtr)
	End Method

	Rem
	bbdoc: Sets the hidden state of the row.
	about: Setting the state to #True will hide the row, while setting it to #False will make the row visible.
	End Rem
	Method SetHidden(state:Int)
		bmx_openxlsx_xlrow_sethidden(rowPtr, state)
	End Method

	Rem
	bbdoc: Gets the row number of the row.
	about: Row numbers are 1-based, so the first row is row 1.
	End Rem
	Method RowNumber:UInt()
		Return bmx_openxlsx_xlrow_rownumber(rowPtr)
	End Method

	Rem
	bbdoc: Gets the number of cells in the row that contain values.
	End Rem
	Method CellCount:Short()
		Return bmx_openxlsx_xlrow_cellcount(rowPtr)
	End Method

	Rem
	bbdoc: Gets a range representing the cells in the row that contain values.
	End Rem
	Method Cells:TXLRowDataRange()
		Return TXLRowDataRange._Create(bmx_openxlsx_xlrow_cells(rowPtr))
	End Method

	Rem
	bbdoc: Gets a range representing the first #cellCount cells in the row that contain values.
	End Rem
	Method Cells:TXLRowDataRange(cellCount:Short)
		Return TXLRowDataRange._Create(bmx_openxlsx_xlrow_cells_count(rowPtr, cellCount))
	End Method

	Rem
	bbdoc: Gets a range representing the cells in the row from the specified first cell to the specified last cell, inclusive.
	about: Cell numbers are 1-based, so the first cell in the row is cell 1 (which corresponds to column "A").
	End Rem
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

Rem
bbdoc: Represents a range of rows in a worksheet.
End Rem
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

	Rem
	bbdoc: Gets the number of rows in the range.
	End Rem
	Method RowCount:UInt()
		Return bmx_openxlsx_xlrowrange_rowcount(rowRangePtr)
	End Method

	Rem
	bbdoc: Gets an iterator for the rows in the range.
	End Rem
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

Rem
bbdoc: An iterator for iterating over the rows in a #TXLRowRange.
End Rem
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

	Rem
	bbdoc: Gets the current row in the iteration.
	End Rem
	Method Current:TXLRow() Override
		Return _current
	End Method

	Rem
	bbdoc: Advances the iterator to the next row in the range, returning #True if there is a next row or #False if the end of the range has been reached.
	End Rem
	Method MoveNext:Int() Override
		If bmx_openxlsx_xlrowrange_iterator_hasnext(_iteratorPtr) Then
			_current = TXLRow._Create(bmx_openxlsx_xlrowrange_iterator_next(_iteratorPtr))
			Return True
		End If
		_current = Null
		Return False
	End Method

	Rem
	bbdoc: Closes the iterator and releases any associated resources.
	End Rem
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

Rem
bbdoc: Encapsulates an iterator, for iterating over the cells in a row of a #TXLRowDataRange.
End Rem
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

	Rem
	bbdoc: Gets the current cell in the iteration.
	End Rem
	Method Current:TXLCell() Override
		Return _current
	End Method

	Rem
	bbdoc: Advances the iterator to the next cell in the row, returning #True if there is a next cell or #False if the end of the row has been reached.
	End Rem
	Method MoveNext:Int() Override
		If bmx_openxlsx_xlrowdatarange_iterator_hasnext(_iteratorPtr) Then
			_current = TXLCell._Create(bmx_openxlsx_xlrowdatarange_iterator_next(_iteratorPtr))
			Return True
		End If
		_current = Null
		Return False
	End Method

	Rem
	bbdoc: Closes the iterator and releases any associated resources.
	End Rem
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

Rem
bbdoc: Represents a range of cells in a row.
End Rem
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

	Rem
	bbdoc: Get an iterator for the cells in the row data range.
	End Rem
	Method GetIterator:IIterator<TXLCell>() Override
		Return TXLRowDataIterator._Create(Self, bmx_openxlsx_xlrowdatarange_iterator(rowDataRangePtr))
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #Float value.
	End Rem
	Method SetValue(value:Float)
		bmx_openxlsx_xlrowdatarange_setvalue_double(rowDataRangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #Float value.
	End Rem
	Method SetValueFloat(value:Float)
		bmx_openxlsx_xlrowdatarange_setvalue_double(rowDataRangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #Double value.
	End Rem
	Method SetValue(value:Double)
		bmx_openxlsx_xlrowdatarange_setvalue_double(rowDataRangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #Double value.
	End Rem
	Method SetValueDouble(value:Double)
		bmx_openxlsx_xlrowdatarange_setvalue_double(rowDataRangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #Int value.
	End Rem
	Method SetValue(value:Int)
		bmx_openxlsx_xlrowdatarange_setvalue_long(rowDataRangePtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #Int value.
	End Rem
	Method SetValueInt(value:Int)
		bmx_openxlsx_xlrowdatarange_setvalue_long(rowDataRangePtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #Long value.
	End Rem
	Method SetValue(value:Long)
		bmx_openxlsx_xlrowdatarange_setvalue_long(rowDataRangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #Long value.
	End Rem
	Method SetValueLong(value:Long)
		bmx_openxlsx_xlrowdatarange_setvalue_long(rowDataRangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #UInt value
	End Rem
	Method SetValue(value:UInt)
		bmx_openxlsx_xlrowdatarange_setvalue_long(rowDataRangePtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #UInt value
	End Rem
	Method SetValueUInt(value:UInt)
		bmx_openxlsx_xlrowdatarange_setvalue_long(rowDataRangePtr, Long(value))
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #ULong value
	End Rem
	Method SetValue(value:ULong)
		bmx_openxlsx_xlrowdatarange_setvalue_ulong(rowDataRangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #ULong value
	End Rem
	Method SetValueULong(value:ULong)
		bmx_openxlsx_xlrowdatarange_setvalue_ulong(rowDataRangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #String value
	End Rem
	Method SetValue(value:String)
		bmx_openxlsx_xlrowdatarange_setvalue_string(rowDataRangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #String value
	End Rem
	Method SetValueString(value:String)
		bmx_openxlsx_xlrowdatarange_setvalue_string(rowDataRangePtr, value)
	End Method

	Rem
	bbdoc: Sets the value of all cells in the row data range to the specified #Int value, where non-zero is treated as #True and zero is treated as #False.
	End Rem
	Method SetValueBool(value:Int)
		bmx_openxlsx_xlrowdatarange_setvalue_bool(rowDataRangePtr, value)
	End Method

	Method Delete()
		If rowDataRangePtr Then
			bmx_openxlsx_xlrowdatarange_free(rowDataRangePtr)
			rowDataRangePtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents a single column in a worksheet, encapsulating the properties and behaviours of a spreadsheet column.
End Rem
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

	Rem
	bbdoc: Gets the width of the column.
	End Rem
	Method Width:Float()
		Return bmx_openxlsx_xlcolumn_width(columnPtr)
	End Method

	Rem
	bbdoc: Sets the width of the column.
	End Rem
	Method SetWidth(width:Float)
		bmx_openxlsx_xlcolumn_setwidth(columnPtr, width)
	End Method

	Rem
	bbdoc: Checks if the column is hidden.
	End Rem
	Method IsHidden:Int()
		Return bmx_openxlsx_xlcolumn_ishidden(columnPtr)
	End Method

	Rem
	bbdoc: Sets the hidden state of the column.
	about: Setting the state to #True will hide the column, while setting it to #False will make the column visible.
	End Rem
	Method SetHidden(state:Int)
		bmx_openxlsx_xlcolumn_sethidden(columnPtr, state)
	End Method

	Rem
	bbdoc: Gets the array index for the style assigned to the column.
	End Rem
	Method Format:Size_T()
		Return bmx_openxlsx_xlcolumn_format(columnPtr)
	End Method

	Rem
	bbdoc: Sets the array index for the style assigned to the column.
	about: The format index corresponds to a cell format defined in the workbook's styles.
	End Rem
	Method SetFormat:Int(cellFormatIndex:Size_T)
		Return bmx_openxlsx_xlcolumn_setformat(columnPtr, cellFormatIndex)
	End Method

	Method Delete()
		If columnPtr Then
			bmx_openxlsx_xlcolumn_free(columnPtr)
			columnPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents the styles used in a workbook, including fonts, fills, borders, cell formats, cell styles, and number formats.
End Rem
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

	Rem
	bbdoc: Gets the fonts used in the workbook.
	End Rem
	Method Fonts:TXLFonts()
		Return TXLFonts._Create(bmx_openxlsx_xlstyles_fonts(stylesPtr))
	End Method

	Rem
	bbdoc: Gets the fills used in the workbook.
	End Rem
	Method Fills:TXLFills()
		Return TXLFills._Create(bmx_openxlsx_xlstyles_fills(stylesPtr))
	End Method

	Rem
	bbdoc: Gets the borders used in the workbook.
	End Rem
	Method Borders:TXLBorders()
		Return TXLBorders._Create(bmx_openxlsx_xlstyles_borders(stylesPtr))
	End Method

	Rem
	bbdoc: Gets the cell formats used in the workbook.
	End Rem
	Method CellFormats:TXLCellFormats()
		Return TXLCellFormats._Create(bmx_openxlsx_xlstyles_cellformats(stylesPtr))
	End Method

	Rem
	bbdoc: Gets the cell styles used in the workbook.
	End Rem
	Method CellStyles:TXLCellStyles()
		Return TXLCellStyles._Create(bmx_openxlsx_xlstyles_cellstyles(stylesPtr))
	End Method

	Rem
	bbdoc: Gets the number formats used in the workbook.
	End Rem
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

Rem
bbdoc: Represents the fonts used in a workbook, allowing access to individual fonts and the ability to create new fonts.
End Rem
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

	Rem
	bbdoc: Gets the number of fonts defined in the workbook.
	End Rem
	Method Count:Size_T()
		Return bmx_openxlsx_xlfonts_count(fontsPtr)
	End Method

	Rem
	bbdoc: Gets the font at the specified index.
	about: Font indices are 0-based, so the first font is at index 0. The font at index 0 is the default font for the workbook,
	and is used for any cells that do not have a specific font assigned to them.
	End Rem
	Method FontByIndex:TXLFont(index:Size_T)
		Return TXLFont._Create(bmx_openxlsx_xlfonts_fontbyindex(fontsPtr, index))
	End Method

	Rem
	bbdoc: Gets the font at the specified index.
	about: Font indices are 0-based, so the first font is at index 0. The font at index 0 is the default font for the workbook,
	and is used for any cells that do not have a specific font assigned to them.
	End Rem
	Method Operator[]:TXLFont(index:Size_T)
		Return FontByIndex(index)
	End Method

	Rem
	bbdoc: Creates a new font in the workbook, optionally copying the properties of an existing font.
	about: If the copyFrom parameter is provided, the new font will be created with the same properties as the specified font.
	If @copyFrom is not provided or is Null, the new font will be created with default properties.
	End Rem
	Method Create:Size_T(copyFrom:TXLFont = Null)
		If copyFrom Then
			Return bmx_openxlsx_xlfonts_create(fontsPtr, copyFrom.fontPtr)
		Else
			Return bmx_openxlsx_xlfonts_create(fontsPtr, Null)
		End If
	End Method

	Method Delete()
		If fontsPtr Then
			bmx_openxlsx_xlfonts_free(fontsPtr)
			fontsPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents a single font in a workbook, allowing access to its properties and the ability to modify them.
End Rem
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

	Rem
	bbdoc: Gets the name of the font, e.g. "Calibri".
	End Rem
	Method FontName:String()
		Return bmx_openxlsx_xlfont_fontname(fontPtr)
	End Method

	Rem
	bbdoc: Gets the character set of the font.
	about: The character set is represented as a numeric code that corresponds to a specific character encoding used by the font.
	End Rem
	Method FontCharset:Size_T()
		Return bmx_openxlsx_xlfont_fontcharset(fontPtr)
	End Method

	Rem
	bbdoc: Gets the font family of the font.
	about: The font family is represented as a numeric code that corresponds to a specific font family used by the font.
	End Rem
	Method FontFamily:Size_T()
		Return bmx_openxlsx_xlfont_fontfamily(fontPtr)
	End Method

	Rem
	bbdoc: Gets the size of the font in points.
	End Rem
	Method FontSize:Size_T()
		Return bmx_openxlsx_xlfont_fontsize(fontPtr)
	End Method

	Rem
	bbdoc: Gets the color of the font as an #SColor8 value.
	End Rem
	Method FontColor:SColor8()
		Return bmx_openxlsx_xlfont_fontcolor(fontPtr)
	End Method

	Rem
	bbdoc: Checks if the font is bold.
	End Rem
	Method Bold:Int()
		Return bmx_openxlsx_xlfont_bold(fontPtr)
	End Method

	Rem
	bbdoc: Checks if the font is italic.
	End Rem
	Method Italic:Int()
		Return bmx_openxlsx_xlfont_italic(fontPtr)
	End Method

	Rem
	bbdoc: Checks if the font has strikethrough applied.
	End Rem
	Method Strikethrough:Int()
		Return bmx_openxlsx_xlfont_strikethrough(fontPtr)
	End Method

	Rem
	bbdoc: Gets the underline style of the font.
	about: The underline style is represented as an #EXLUnderlineStyle value.
	End Rem
	Method Underline:EXLUnderlineStyle()
		Return bmx_openxlsx_xlfont_underline(fontPtr)
	End Method

	Rem
	bbdoc: Gets the font scheme of the font.
	about: The font scheme is represented as an #EXLFontSchemeStyle value, which indicates the intended use of the font in the
	context of the workbook's theme (e.g. whether it is meant for headings, body text, etc.).
	End Rem
	Method Scheme:EXLFontSchemeStyle()
		Return bmx_openxlsx_xlfont_scheme(fontPtr)
	End Method

	Rem
	bbdoc: Gets the vertical alignment of the font when used in a run of text.
	about: The vertical alignment is represented as an #EXLVerticalAlignRunStyle value, which indicates how the text should be
	vertically aligned relative to the baseline (e.g. normal, superscript, subscript).
	End Rem
	Method VertAlign:EXLVerticalAlignRunStyle()
		Return bmx_openxlsx_xlfont_vertalign(fontPtr)
	End Method

	Rem
	bbdoc: Checks if the font has an outline.
	about: An outline font is a font that is drawn with an outline around the characters, rather than being filled in. This can create a hollow or "stroked" appearance for the text.
	End Rem
	Method Outline:Int()
		Return bmx_openxlsx_xlfont_outline(fontPtr)
	End Method

	Rem
	bbdoc: Checks if the font has a shadow.
	about: A shadow font is a font that is drawn with a shadow effect, which can create a sense of depth or make the text stand out more on the page.
	End Rem
	Method Shadow:Int()
		Return bmx_openxlsx_xlfont_shadow(fontPtr)
	End Method

	Rem
	bbdoc: Checks if the font is condensed.
	about: A condensed font is a font that has a narrower width than a regular font, which can allow more characters to fit in a given space.
	Condensed fonts are often used for headings or other situations where space is limited.
	End Rem
	Method Condense:Int()
		Return bmx_openxlsx_xlfont_condense(fontPtr)
	End Method

	Rem
	bbdoc: Sets the name of the font, e.g. "Calibri".
	returns: #True if the font name was successfully set, or #False if an error occurred (e.g. if the specified font name is not valid or not supported).
	End Rem
	Method SetFontName:Int(newName:String)
		Return bmx_openxlsx_xlfont_setfontname(fontPtr, newName)
	End Method

	Rem
	bbdoc: Sets the character set of the font.
	returns: #True if the font character set was successfully set, or #False if an error occurred (e.g. if the specified character set code is not valid or not supported).
	about: The character set is represented as a numeric code that corresponds to a specific character encoding used by the font.
	End Rem
	Method SetFontCharset:Int(newCharset:Size_T)
		Return bmx_openxlsx_xlfont_setfontcharset(fontPtr, newCharset)
	End Method

	Rem
	bbdoc: Sets the font family of the font.
	returns: #True if the font family was successfully set, or #False if an error occurred (e.g. if the specified font family code is not valid or not supported).
	about: The font family is represented as a numeric code that corresponds to a specific font family used by the font.
	End Rem
	Method SetFontFamily:Int(newFamily:Size_T)
		Return bmx_openxlsx_xlfont_setfontfamily(fontPtr, newFamily)
	End Method

	Rem
	bbdoc: Sets the size of the font in points.
	returns: #True if the font size was successfully set, or #False if an error occurred (e.g. if the specified font size is not valid).
	End Rem
	Method SetFontSize:Int(newSize:Size_T)
		Return bmx_openxlsx_xlfont_setfontsize(fontPtr, newSize)
	End Method

	Rem
	bbdoc: Sets the color of the font as an #SColor8 value.
	returns: #True if the font color was successfully set, or #False if an error occurred (e.g. if the specified color value is not valid).
	End Rem
	Method SetFontColor:Int(newColor:SColor8)
		Return bmx_openxlsx_xlfont_setfontcolor(fontPtr, newColor)
	End Method

	Rem
	bbdoc: Sets whether the font is bold.
	returns: #True if the font bold property was successfully set, or #False if an error occurred.
	about: Setting the value to #True will make the font bold, while setting it to #False will make it not bold.
	By default, the set parameter is #True, so calling SetBold() without any arguments will make the font bold.
	End Rem
	Method SetBold:Int(set:Int = True)
		Return bmx_openxlsx_xlfont_setbold(fontPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the font is italic.
	returns: #True if the font italic property was successfully set, or #False if an error occurred.
	about: Setting the value to #True will make the font italic, while setting it to #False will make it not italic.
	By default, the set parameter is #True, so calling SetItalic() without any arguments will make the font italic.
	End Rem
	Method SetItalic:Int(set:Int = True)
		Return bmx_openxlsx_xlfont_setitalic(fontPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the font has strikethrough applied.
	returns: #True if the font strikethrough property was successfully set, or #False if an error occurred.
	about: Setting the value to #True will apply strikethrough to the font, while setting it to #False will remove any strikethrough from the font.
	By default, the set parameter is #True, so calling SetStrikethrough() without any arguments will apply strikethrough to the font.
	End Rem
	Method SetStrikethrough:Int(set:Int = True)
		Return bmx_openxlsx_xlfont_setstrikethrough(fontPtr, set)
	End Method

	Rem
	bbdoc: Sets the underline style of the font.
	returns: #True if the font underline style was successfully set, or #False if an error occurred (e.g. if the specified underline style value is not valid).
	about: The underline style is represented as an #EXLUnderlineStyle value, which indicates the type of underline to apply to the font (e.g. single, double, etc.).
	By default, the underline style is set to #EXLUnderlineStyle.XLUnderlineSingle, which applies a single underline to the font.
	To remove any underline from the font, you can set the underline style to #EXLUnderlineStyle.XLUnderlineNone.
	End Rem
	Method SetUnderline:Int(underline:EXLUnderlineStyle = EXLUnderlineStyle.XLUnderlineSingle)
		Return bmx_openxlsx_xlfont_setunderline(fontPtr, underline)
	End Method

	Rem
	bbdoc: Sets the font scheme of the font.
	returns: #True if the font scheme was successfully set, or #False if an error occurred (e.g. if the specified font scheme value is not valid).
	about: The font scheme is represented as an #EXLFontSchemeStyle value, which indicates the intended use of the font in the context of the workbook's theme (e.g. whether it is meant for headings, body text, etc.).
	By default, the font scheme is set to #EXLFontSchemeStyle.XLFontSchemeNone, which indicates that the font is not associated with any particular scheme in the workbook's theme.
	To associate the font with a specific scheme in the workbook's theme, you can set the font scheme to one of the other values in the #EXLFontSchemeStyle enumeration (e.g. #EXLFontSchemeStyle.XLFontSchemeMajor, #EXLFontSchemeStyle.XLFontSchemeMinor, etc.).
	End Rem
	Method SetScheme:Int(scheme:EXLFontSchemeStyle)
		Return bmx_openxlsx_xlfont_setscheme(fontPtr, scheme)
	End Method

	Rem
	bbdoc: Sets the vertical alignment of the font when used in a run of text.
	returns: #True if the font vertical alignment was successfully set, or #False if an error occurred (e.g. if the specified vertical alignment value is not valid).
	about: The vertical alignment is represented as an #EXLVerticalAlignRunStyle value, which indicates how the text should be vertically aligned relative to the baseline (e.g. normal, superscript, subscript).
	By default, the vertical alignment is set to #EXLVerticalAlignRunStyle.XLVerticalAlignRunStyleNone, which indicates normal vertical alignment with no special formatting.
	End Rem
	Method SetVertAlign:Int(vertAlign:EXLVerticalAlignRunStyle)
		Return bmx_openxlsx_xlfont_setvertalign(fontPtr, vertAlign)
	End Method

	Rem
	bbdoc: Sets whether the font has an outline.
	returns: #True if the font outline property was successfully set, or #False if an error occurred.
	about: Setting the value to #True will make the font an outline font, while setting it to #False will make it a regular font.
	By default, the set parameter is #True, so calling SetOutline() without any arguments will make the font an outline font.
	End Rem
	Method SetOutline:Int(set:Int = True)
		Return bmx_openxlsx_xlfont_setoutline(fontPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the font has a shadow.
	returns: #True if the font shadow property was successfully set, or #False if an error occurred.
	about: Setting the value to #True will apply a shadow effect to the font, while setting it to #False will remove any shadow effect from the font.
	By default, the set parameter is #True, so calling SetShadow() without any arguments will apply a shadow effect to the font.
	End Rem
	Method SetShadow:Int(set:Int = True)
		Return bmx_openxlsx_xlfont_setshadow(fontPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the font is condensed.
	returns: #True if the font condensed property was successfully set, or #False if an error occurred.
	about: Setting the value to #True will make the font condensed, while setting it to #False will make it a regular width font.
	By default, the set parameter is #True, so calling SetCondense() without any arguments will make the font condensed.
	End Rem
	Method SetCondense:Int(set:Int = True)
		Return bmx_openxlsx_xlfont_setcondense(fontPtr, set)
	End Method

	Rem
	bbdoc: Gets a string summarizing the properties of the font, which can be useful for debugging or logging purposes.
	End Rem
	Method Summary:String()
		Return bmx_openxlsx_xlfont_summary(fontPtr)
	End Method

	Method Delete()
		If fontPtr Then
			bmx_openxlsx_xlfont_free(fontPtr)
			fontPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents the fills used in a workbook, allowing access to individual fills and the ability to create new fills.
End Rem
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

	Rem
	bbdoc: Gets the number of fills defined in the workbook.
	End Rem
	Method Count:Size_T()
		Return bmx_openxlsx_xlfills_count(fillsPtr)
	End Method

	Rem
	bbdoc: Gets the fill at the specified index.
	about: Fill indices are 0-based, so the first fill is at index 0. The fill at index 0 is the default fill for the workbook,
	and is used for any cells that do not have a specific fill assigned to them.
	End Rem
	Method FillByIndex:TXLFill(index:Size_T)
		Return TXLFill._Create(bmx_openxlsx_xlfills_fillbyindex(fillsPtr, index))
	End Method

	Rem
	bbdoc: Gets the fill at the specified index.
	about: Fill indices are 0-based, so the first fill is at index 0. The fill at index 0 is the default fill for the workbook,
	and is used for any cells that do not have a specific fill assigned to them.
	End Rem
	Method Operator[]:TXLFill(index:Size_T)
		Return FillByIndex(index)
	End Method

	Rem
	bbdoc: Creates a new fill in the workbook, optionally copying the properties of an existing fill.
	about: If the copyFrom parameter is provided, the new fill will be created with the same properties as the specified fill.
	If @copyFrom is not provided or is Null, the new fill will be created with default properties.
	End Rem
	Method Create:Size_T(copyFrom:TXLFill = Null)
		If copyFrom Then
			Return bmx_openxlsx_xlfills_create(fillsPtr, copyFrom.fillPtr)
		Else
			Return bmx_openxlsx_xlfills_create(fillsPtr, Null)
		End If
	End Method

	Method Delete()
		If fillsPtr Then
			bmx_openxlsx_xlfills_free(fillsPtr)
			fillsPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents a single fill in a workbook, allowing access to its properties and the ability to modify them.
End Rem
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

	Rem
	bbdoc: Gets the type of the fill, which indicates whether it is a solid fill, a gradient fill, a pattern fill, etc.
	about: The fill type is represented as an #EXLFillType value, which can be used to determine which properties of the fill
	are relevant and how the fill should be rendered in the workbook.
	End Rem
	Method FillType:EXLFillType()
		Return bmx_openxlsx_xlfill_filltype(fillPtr)
	End Method

	Rem
	bbdoc: Sets the type of the fill, which indicates whether it is a solid fill, a gradient fill, a pattern fill, etc.
	about: The fill type is represented as an #EXLFillType value, which can be used to determine which properties of the fill are relevant and how the fill should be rendered in the workbook.
	By default, the fill type is set to #EXLFillType.XLFillNone, which indicates that the fill is not applied to the cell. 
	Use @force to change the fill type even if the fill already has properties set that are not compatible with the new fill type.
	End Rem
	Method SetFillType:Int(fillType:EXLFillType, force:Int = False)
		Return bmx_openxlsx_xlfill_setfilltype(fillPtr, fillType, force)
	End Method

	Rem
	bbdoc: Gets the gradient type of the fill, which indicates the direction or style of the gradient if the fill is a gradient fill.
	about: The gradient type is represented as an #EXLGradientType value, which can be used to determine how the gradient should be rendered in
	the workbook (e.g. linear, radial, etc.).
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient, and may not be applicable for other fill types.
	End Rem
	Method GradientType:EXLGradientType()
		Return bmx_openxlsx_xlfill_gradienttype(fillPtr)
	End Method

	Rem
	bbdoc: Gets the degree of the gradient fill, which indicates the angle of the gradient if the fill is a linear gradient.
	about: The degree is represented as a double value, where 0 degrees represents a gradient that goes from left to right, 90 degrees represents a gradient that goes from top to bottom, and so on.
	End Rem
	Method Degree:Double()
		Return bmx_openxlsx_xlfill_degree(fillPtr)
	End Method

	Rem
	bbdoc: Gets the left position of the gradient fill, which indicates the starting point of the gradient if the fill is a linear gradient.
	about: The left position is represented as a double value between 0 and 1, where 0 represents the left edge of the cell and 1 represents the right edge of the cell.
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient and the gradient type is set to #EXLGradientType.XLGradientLinear.
	End Rem
	Method Left:Double()
		Return bmx_openxlsx_xlfill_left(fillPtr)
	End Method

	Rem
	bbdoc: Gets the right position of the gradient fill, which indicates the ending point of the gradient if the fill is a linear gradient.
	about: The right position is represented as a double value between 0 and 1, where 0 represents the left edge of the cell and 1 represents the right edge of the cell.
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient and the gradient type is set to #EXLGradientType.XLGradientLinear.
	End Rem
	Method Right:Double()
		Return bmx_openxlsx_xlfill_right(fillPtr)
	End Method

	Rem
	bbdoc: Gets the top position of the gradient fill, which indicates the starting point of the gradient if the fill is a linear gradient.
	about: The top position is represented as a double value between 0 and 1, where 0 represents the top edge of the cell and 1 represents the bottom edge of the cell.
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient and the gradient type is set to #EXLGradientType.XLGradientLinear.
	End Rem
	Method Top:Double()
		Return bmx_openxlsx_xlfill_top(fillPtr)
	End Method

	Rem
	bbdoc: Gets the bottom position of the gradient fill, which indicates the ending point of the gradient if the fill is a linear gradient.
	about: The bottom position is represented as a double value between 0 and 1, where 0 represents the top edge of the cell and 1 represents the bottom edge of the cell.
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient and the gradient type is set to #EXLGradientType.XLGradientLinear.
	End Rem
	Method Bottom:Double()
		Return bmx_openxlsx_xlfill_bottom(fillPtr)
	End Method

	Rem
	bbdoc: Gets the gradient stops of the fill, which represent the individual colors and positions that make up the gradient if the fill is a gradient fill.
	about: The gradient stops are represented as a #TXLGradientStops object, which provides access to the individual gradient stops and their properties.
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient, and may not be applicable for other fill types.
	End Rem
	Method Stops:TXLGradientStops()
		Return TXLGradientStops._Create(bmx_openxlsx_xlfill_stops(fillPtr))
	End Method

	Rem
	bbdoc: Gets the pattern type of the fill, which indicates the style of the pattern if the fill is a pattern fill.
	about: The pattern type is represented as an #EXLPatternType value, which can be used to determine how the pattern should be rendered in the workbook (e.g. solid, stripes, dots, etc.).
	This property is only relevant if the fill type is set to #EXLFillType.XLFillPattern, and may not be applicable for other fill types.
	End Rem
	Method PatternType:EXLPatternType()
		Return bmx_openxlsx_xlfill_patterntype(fillPtr)
	End Method

	Rem
	bbdoc: Gets the color of the fill as an #SColor8 value.
	End Rem
	Method Color:SColor8()
		Return bmx_openxlsx_xlfill_color(fillPtr)
	End Method

	Rem
	bbdoc: Gets the background color of the fill as an #SColor8 value.
	End Rem
	Method BackgroundColor:SColor8()
		Return bmx_openxlsx_xlfill_backgroundcolor(fillPtr)
	End Method

	Rem
	bbdoc: Sets the gradient type of the fill, which indicates the direction or style of the gradient if the fill is a gradient fill.
	about: The gradient type is represented as an #EXLGradientType value, which can be used to determine how the gradient should be rendered in the workbook (e.g. linear, radial, etc.).
	By default, the gradient type is set to #EXLGradientType.XLGradientLinear, which indicates a linear gradient. To change the gradient type to a different style, you can set it to one of the other values in the #EXLGradientType enumeration (e.g. #EXLGradientType.XLGradientRadial, #EXLGradientType.XLGradientRectangular, etc.).
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient, and may not be applicable for other fill types.
	End Rem
	Method SetGradientType:Int(newType:EXLGradientType)
		Return bmx_openxlsx_xlfill_setgradienttype(fillPtr, newType)
	End Method

	Rem
	bbdoc: Sets the degree of the gradient fill, which indicates the angle of the gradient if the fill is a linear gradient.
	returns: #True if the degree was successfully set, or #False if the degree value is out of the valid range (0 to 360 degrees).
	about: The degree is represented as a double value, where 0 degrees represents a gradient that goes from left to right, 90 degrees represents a gradient that goes from top to bottom, and so on.
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient and the gradient type is set to #EXLGradientType.XLGradientLinear.
	End Rem
	Method SetDegree:Int(newDegree:Double)
		Return bmx_openxlsx_xlfill_setdegree(fillPtr, newDegree)
	End Method

	Rem
	bbdoc: Sets the left position of the gradient fill, which indicates the starting point of the gradient if the fill is a linear gradient.
	returns: #True if the left position was successfully set, or #False if the left position value is out of the valid range (0 to 1).
	about: The left position is represented as a double value between 0 and 1, where 0 represents the left edge of the cell and 1 represents the right edge of the cell.
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient and the gradient type is set to #EXLGradientType.XLGradientLinear.
	End Rem
	Method SetLeft:Int(newLeft:Double)
		Return bmx_openxlsx_xlfill_setleft(fillPtr, newLeft)
	End Method

	Rem
	bbdoc: Sets the right position of the gradient fill, which indicates the ending point of the gradient if the fill is a linear gradient.
	returns: #True if the right position was successfully set, or #False if the right position value is out of the valid range (0 to 1).
	about: The right position is represented as a double value between 0 and 1, where 0 represents the left edge of the cell and 1 represents the right edge of the cell.
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient and the gradient type is set to #EXLGradientType.XLGradientLinear.
	End Rem
	Method SetRight:Int(newRight:Double)
		Return bmx_openxlsx_xlfill_setright(fillPtr, newRight)
	End Method

	Rem
	bbdoc: Sets the top position of the gradient fill, which indicates the starting point of the gradient if the fill is a linear gradient.
	returns: #True if the top position was successfully set, or #False if the top position value is out of the valid range (0 to 1).
	about: The top position is represented as a double value between 0 and 1, where 0 represents the top edge of the cell and 1 represents the bottom edge of the cell.
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient and the gradient type is set to #EXLGradientType.XLGradientLinear.
	End Rem
	Method SetTop:Int(newTop:Double)
		Return bmx_openxlsx_xlfill_settop(fillPtr, newTop)
	End Method

	Rem
	bbdoc: Sets the bottom position of the gradient fill, which indicates the ending point of the gradient if the fill is a linear gradient.
	returns: #True if the bottom position was successfully set, or #False if the bottom position value is out of the valid range (0 to 1).
	about: The bottom position is represented as a double value between 0 and 1, where 0 represents the top edge of the cell and 1 represents the bottom edge of the cell.
	This property is only relevant if the fill type is set to #EXLFillType.XLFillGradient and the gradient type is set to #EXLGradientType.XLGradientLinear.
	End Rem
	Method SetBottom:Int(newBottom:Double)
		Return bmx_openxlsx_xlfill_setbottom(fillPtr, newBottom)
	End Method

	Rem
	bbdoc: Sets the pattern type of the fill, which indicates the style of the pattern if the fill is a pattern fill.
	returns: #True if the pattern type was successfully set, or #False if the pattern type value is not a valid #EXLPatternType or if the fill type is not set to #EXLFillType.XLFillPattern.
	about: The pattern type is represented as an #EXLPatternType value, which can be used to determine how the pattern should be rendered in the workbook (e.g. solid, stripes, dots, etc.).
	This property is only relevant if the fill type is set to #EXLFillType.XLFillPattern, and may not be applicable for other fill types.
	End Rem
	Method SetPatternType:Int(newPatternType:EXLPatternType)
		Return bmx_openxlsx_xlfill_setpatterntype(fillPtr, newPatternType)
	End Method

	Rem
	bbdoc: Sets the color of the fill as an #SColor8 value.
	returns: #True if the color was successfully set, or #False if the color value is not a valid #SColor8 or if the fill type is not compatible with setting a color (e.g. if the fill type is set to #EXLFillType.XLFillNone).
	End Rem
	Method SetColor:Int(newColor:SColor8)
		Return bmx_openxlsx_xlfill_setcolor(fillPtr, newColor)
	End Method

	Rem
	bbdoc: Sets the background color of the fill as an #SColor8 value.
	returns: #True if the background color was successfully set, or #False if the color value is not a valid #SColor8 or if the fill type is not compatible with setting a background color (e.g. if the fill type is set to #EXLFillType.XLFillNone).
	End Rem
	Method SetBackgroundColor:Int(newColor:SColor8)
		Return bmx_openxlsx_xlfill_setbackgroundcolor(fillPtr, newColor)
	End Method

	Rem
	bbdoc: Gets a string summarizing the properties of the fill, which can be useful for debugging or logging purposes.
	End Rem
	Method Summary:String()
		Return bmx_openxlsx_xlfill_summary(fillPtr)
	End Method

	Method Delete()
		If fillPtr Then
			bmx_openxlsx_xlfill_free(fillPtr)
			fillPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents the gradient stops used in a gradient fill, allowing access to individual gradient stops and the ability to create new gradient stops.
End Rem
Type TXLGradientStops

	Field stopsPtr:Byte Ptr

	Function _Create:TXLGradientStops(stopsPtr:Byte Ptr)
		If stopsPtr Then
			Local stops:TXLGradientStops = New TXLGradientStops()
			stops.stopsPtr = stopsPtr
			Return stops
		End If
		Return Null
	End Function

	Rem
	bbdoc: Gets the number of gradient stops defined in the gradient fill.
	End Rem
	Method Count:Size_T()
		Return bmx_openxlsx_xlgradientstops_count(stopsPtr)
	End Method

	Rem
	bbdoc: Gets the gradient stop at the specified index.
	about: Gradient stop indices are 0-based, so the first gradient stop is at index 0. The properties of the gradient stop (e.g. color, position) can be accessed and modified using the returned #TXLGradientStop object.
	End Rem
	Method StopByIndex:TXLGradientStop(index:Size_T)
		Return TXLGradientStop._Create(bmx_openxlsx_xlgradientstops_stopbyindex(stopsPtr, index))
	End Method

	Rem
	bbdoc: Gets the gradient stop at the specified index.
	about: Gradient stop indices are 0-based, so the first gradient stop is at index 0. The properties of the gradient stop (e.g. color, position) can be accessed and modified using the returned #TXLGradientStop object.
	End Rem
	Method Operator[]:TXLGradientStop(index:Size_T)
		Return StopByIndex(index)
	End Method

	Rem
	bbdoc: Creates a new gradient stop in the gradient fill, optionally copying the properties of an existing gradient stop.
	about: If the copyFrom parameter is provided, the new gradient stop will be created with the same properties as the specified gradient stop. If @copyFrom is not provided or is Null, the new gradient stop will be created with default properties (e.g. a default color and position).
	End Rem
	Method Create:Size_T(copyFrom:TXLGradientStop = Null)
		If copyFrom Then
			Return bmx_openxlsx_xlgradientstops_create(stopsPtr, copyFrom.stopPtr)
		Else
			Return bmx_openxlsx_xlgradientstops_create(stopsPtr, Null)
		End If
	End Method

	Method Delete()
		If stopsPtr Then
			bmx_openxlsx_xlgradientstops_free(stopsPtr)
			stopsPtr = Null
		End If
	End Method
End Type

Rem
bbdoc: Represents a single gradient stop within a gradient fill, allowing access to its properties such as color and position.
End Rem
Type TXLGradientStop

	Field stopPtr:Byte Ptr

	Function _Create:TXLGradientStop(stopPtr:Byte Ptr)
		If stopPtr Then
			Local stop:TXLGradientStop = New TXLGradientStop()
			stop.stopPtr = stopPtr
			Return stop
		End If
		Return Null
	End Function

	Rem
	bbdoc: Gets the color of the gradient stop as an #SColor8 value.
	End Rem
	Method Color:TXLDataBarColor()
		Return TXLDataBarColor._Create(bmx_openxlsx_xlgradientstop_color(stopPtr))
	End Method

	Rem
	bbdoc: Gets the position of the gradient stop, which indicates where the color of the stop is applied within the gradient.
	about: The position is represented as a double value between 0 and 1, where 0 represents the start of the gradient and 1
	represents the end of the gradient. The position determines how the colors of the gradient stops are blended together to
	create the overall gradient effect in the fill.
	End Rem
	Method Position:Double()
		Return bmx_openxlsx_xlgradientstop_position(stopPtr)
	End Method

	Rem
	bbdoc: Sets the position of the gradient stop, which indicates where the color of the stop is applied within the gradient.
	returns: #True if the position was successfully set, or #False if the position value is out of the valid range (0 to 1).
	about: The position is represented as a double value between 0 and 1, where 0 represents the start of the gradient and 1 represents the end of the gradient. The position determines how the colors of the gradient stops are blended together to create the overall gradient effect in the fill.
	End Rem
	Method SetPosition:Int(newPosition:Double)
		Return bmx_openxlsx_xlgradientstop_setposition(stopPtr, newPosition)
	End Method

	Rem
	bbdoc: Gets a string summarizing the properties of the gradient stop, which can be useful for debugging or logging purposes.
	End Rem
	Method Summary:String()
		Return bmx_openxlsx_xlgradientstop_summary(stopPtr)
	End Method

	Method Delete()
		If stopPtr Then
			bmx_openxlsx_xlgradientstop_free(stopPtr)
			stopPtr = Null
		End If
	End Method
End Type

Rem
bbdoc: Represents the borders used in a workbook, allowing access to individual borders and the ability to create new borders.
End Rem
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

	Rem
	bbdoc: Gets the number of borders defined in the workbook.
	End Rem
	Method Count:Size_T()
		Return bmx_openxlsx_xlborders_count(bordersPtr)
	End Method

	Rem
	bbdoc: Gets the border at the specified index.
	about: Border indices are 0-based, so the first border is at index 0. The properties of the border (e.g. line style, color) can be accessed and modified using the returned #TXLBorder object.
	End Rem
	Method BorderByIndex:TXLBorder(index:Size_T)
		Return TXLBorder._Create(bmx_openxlsx_xlborders_borderbyindex(bordersPtr, index))
	End Method

	Rem
	bbdoc: Gets the border at the specified index.
	about: Border indices are 0-based, so the first border is at index 0. The properties of the border (e.g. line style, color) can be accessed and modified using the returned #TXLBorder object.
	End Rem
	Method Operator[]:TXLBorder(index:Size_T)
		Return BorderByIndex(index)
	End Method

	Rem
	bbdoc: Creates a new border in the workbook, optionally copying the properties of an existing border.
	about: If the copyFrom parameter is provided, the new border will be created with the same properties as the specified border. If @copyFrom is not provided or is Null, the new border will be created with default properties (e.g. a default line style and color).
	End Rem
	Method Create:Size_T(copyFrom:TXLBorder = Null)
		If copyFrom Then
			Return bmx_openxlsx_xlborders_create(bordersPtr, copyFrom.borderPtr)
		Else
			Return bmx_openxlsx_xlborders_create(bordersPtr, Null)
		End If
	End Method

	Method Delete()
		If bordersPtr Then
			bmx_openxlsx_xlborders_free(bordersPtr)
			bordersPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents a border in a workbook, allowing access to its properties and the ability to modify them.
End Rem
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

	Rem
	bbdoc: Gets whether the diagonal up property of the border is set, which indicates whether a diagonal line is drawn from the top-left corner to the bottom-right corner of the cell.
	about: If the diagonal up property is set to #True, a diagonal line will be drawn from the top-left corner to the bottom-right corner of the cell. If it is set to #False, no diagonal line will be drawn in that direction.
	End Rem
	Method DiagonalUp:Int()
		Return bmx_openxlsx_xlborder_diagonalup(borderPtr)
	End Method

	Rem
	bbdoc: Gets whether the diagonal down property of the border is set, which indicates whether a diagonal line is drawn from the top-right corner to the bottom-left corner of the cell.
	about: If the diagonal down property is set to #True, a diagonal line will be drawn from the top-right corner to the bottom-left corner of the cell.
	If it is set to #False, no diagonal line will be drawn in that direction.
	End Rem
	Method DiagonalDown:Int()
		Return bmx_openxlsx_xlborder_diagonaldown(borderPtr)
	End Method

	Rem
	bbdoc: Gets whether the outline property of the border is set, which indicates whether an outline is drawn around the cell.
	about: If the outline property is set to #True, an outline will be drawn around the cell using the line style and color of the border.
	If it is set to #False, no outline will be drawn around the cell.
	End Rem
	Method Outline:Int()
		Return bmx_openxlsx_xlborder_outline(borderPtr)
	End Method

	Rem
	bbdoc: Gets the line style and color of the left border of the cell as a #TXLLine object.
	about: The left border refers to the vertical border on the left side of the cell. The properties of the left border (e.g. line style, color)
	can be accessed and modified using the returned #TXLLine object.
	End Rem
	Method Left:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_left(borderPtr))
	End Method

	Rem
	bbdoc: Gets the line style and color of the right border of the cell as a #TXLLine object.
	about: The right border refers to the vertical border on the right side of the cell. The properties of the right border (e.g. line style, color)
	can be accessed and modified using the returned #TXLLine object.
	End Rem
	Method Right:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_right(borderPtr))
	End Method

	Rem
	bbdoc: Gets the line style and color of the top border of the cell as a #TXLLine object.
	about: The top border refers to the horizontal border on the top side of the cell. The properties of the top border (e.g. line style, color)
	can be accessed and modified using the returned #TXLLine object.
	End Rem
	Method Top:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_top(borderPtr))
	End Method

	Rem
	bbdoc: Gets the line style and color of the bottom border of the cell as a #TXLLine object.
	about: The bottom border refers to the horizontal border on the bottom side of the cell. The properties of the bottom border (e.g. line style, color)
	can be accessed and modified using the returned #TXLLine object.
	End Rem
	Method Bottom:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_bottom(borderPtr))
	End Method

	Rem
	bbdoc: Gets the line style and color of the diagonal border of the cell as a #TXLLine object.
	about: The diagonal border refers to the diagonal line that can be drawn across the cell, either from the top-left corner to the bottom-right corner
	(diagonal up) or from the top-right corner to the bottom-left corner (diagonal down). The properties of the diagonal border (e.g. line style, color)
	can be accessed and modified using the returned #TXLLine object.
	Note that the diagonal border is only visible if either the diagonal up or diagonal down property of the border is set to #True.
	End Rem
	Method Diagonal:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_diagonal(borderPtr))
	End Method

	Rem
	bbdoc: Gets the line style and color of the vertical border of the cell as a #TXLLine object.
	about: The vertical border refers to the vertical lines that can be drawn on either side of the cell (left and right). The properties of the vertical
	border (e.g. line style, color) can be accessed and modified using the returned #TXLLine object.
	Note that the vertical border is only visible if the outline property of the border is set to #True.
	End Rem
	Method Vertical:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_vertical(borderPtr))
	End Method

	Rem
	bbdoc: Gets the line style and color of the horizontal border of the cell as a #TXLLine object.
	about: The horizontal border refers to the horizontal lines that can be drawn on either side of the cell (top and bottom). The properties of the
	horizontal border (e.g. line style, color) can be accessed and modified using the returned #TXLLine object.
	Note that the horizontal border is only visible if the outline property of the border is set to #True.
	End Rem
	Method Horizontal:TXLLine()
		Return TXLLine._Create(bmx_openxlsx_xlborder_horizontal(borderPtr))
	End Method

	Rem
	bbdoc: Sets the diagonal up property of the border, which indicates whether a diagonal line is drawn from the top-left corner to the bottom-right corner of the cell.
	returns: #True if the diagonal up property was successfully set, or #False if the set value is not a valid boolean (e.g. not 0 or 1).
	about: If the diagonal up property is set to #True, a diagonal line will be drawn from the top-left corner to the bottom-right corner of the cell. If it is set to #False, no diagonal line will be drawn in that direction.
	End Rem
	Method SetDiagonalUp:Int(set:Int = True)
		Return bmx_openxlsx_xlborder_setdiagonalup(borderPtr, set)
	End Method

	Rem
	bbdoc: Sets the diagonal down property of the border, which indicates whether a diagonal line is drawn from the top-right corner to the bottom-left corner of the cell.
	returns: #True if the diagonal down property was successfully set, or #False if the set value is not a valid boolean (e.g. not 0 or 1).
	about: If the diagonal down property is set to #True, a diagonal line will be drawn from the top-right corner to the bottom-left corner of the cell. If it is set to #False, no diagonal line will be drawn in that direction.
	End Rem
	Method SetDiagonalDown:Int(set:Int = True)
		Return bmx_openxlsx_xlborder_setdiagonaldown(borderPtr, set)
	End Method

	Rem
	bbdoc: Sets the outline property of the border, which indicates whether an outline is drawn around the cell.
	returns: #True if the outline property was successfully set, or #False if the set value is not a valid boolean (e.g. not 0 or 1).
	about: If the outline property is set to #True, an outline will be drawn around the cell using the line style and color of the border. If it is set to #False, no outline will be drawn around the cell.
	End Rem
	Method SetOutline:Int(set:Int = True)
		Return bmx_openxlsx_xlborder_setoutline(borderPtr, set)
	End Method

	Rem
	bbdoc: Sets the line style, color, and tint of a specific border type of the cell.
	returns: #True if the line properties were successfully set, or #False on error.
	about: The line type is specified using an #EXLLineType value, which indicates which border of the cell to modify (e.g. left, right, top,
	bottom, diagonal, vertical, horizontal). The line style is specified using an #EXLLineStyle value, which indicates the style of the line
	(e.g. solid, dashed, dotted, etc.). The line color is specified as an #SColor8 value, which represents the color of the line. The line tint is
	specified as a double value between -1 and 1, where negative values represent a darker tint and positive values represent a lighter tint. This
	method allows you to set the line properties for any of the borders of the cell in a single call, rather than having to set each border individually.
	End Rem
	Method SetLine:Int(lineType:EXLLineType, lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setline(borderPtr, lineType, lineStyle, lineColor, lineTint)
	End Method

	Rem
	bbdoc: Sets the line style, color, and tint of the left border of the cell.
	returns: #True if the line properties were successfully set, or #False on error.
	about: The line style is specified using an #EXLLineStyle value, which indicates the style of the line (e.g. solid, dashed, dotted, etc.).
	The line color is specified as an #SColor8 value, which represents the color of the line. The line tint is specified as a double value
	between -1 and 1, where negative values represent a darker tint and positive values represent a lighter tint. This method allows you to
	set the line properties for the left border of the cell directly, without having to specify the line type as in the SetLine method.
	End Rem
	Method SetLeft:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setleft(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Rem
	bbdoc: Sets the line style, color, and tint of the right border of the cell.
	returns: #True if the line properties were successfully set, or #False on error.
	about: The line style is specified using an #EXLLineStyle value, which indicates the style of the line (e.g. solid, dashed, dotted, etc.).
	The line color is specified as an #SColor8 value, which represents the color of the line. The line tint is specified as a double value
	between -1 and 1, where negative values represent a darker tint and positive values represent a lighter tint. This method allows you to
	set the line properties for the right border of the cell directly, without having to specify the line type as in the SetLine method.
	End Rem
	Method SetRight:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setright(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Rem
	bbdoc: Sets the line style, color, and tint of the top border of the cell.
	returns: #True if the line properties were successfully set, or #False on error.
	about: The line style is specified using an #EXLLineStyle value, which indicates the style of the line (e.g. solid, dashed, dotted, etc.).
	The line color is specified as an #SColor8 value, which represents the color of the line. The line tint is specified as a double value
	between -1 and 1, where negative values represent a darker tint and positive values represent a lighter tint. This method allows you to
	set the line properties for the top border of the cell directly, without having to specify the line type as in the SetLine method.
	End Rem
	Method SetTop:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_settop(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Rem
	bbdoc: Sets the line style, color, and tint of the bottom border of the cell.
	returns: #True if the line properties were successfully set, or #False on error.
	about: The line style is specified using an #EXLLineStyle value, which indicates the style of the line (e.g. solid, dashed, dotted, etc.).
	The line color is specified as an #SColor8 value, which represents the color of the line. The line tint is specified as a double value
	between -1 and 1, where negative values represent a darker tint and positive values represent a lighter tint. This method allows you to
	set the line properties for the bottom border of the cell directly, without having to specify the line type as in the SetLine method.
	End Rem
	Method SetBottom:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setbottom(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Rem
	bbdoc: Sets the line style, color, and tint of the diagonal border of the cell.
	returns: #True if the line properties were successfully set, or #False on error.
	about: The line style is specified using an #EXLLineStyle value, which indicates the style of the line (e.g. solid, dashed, dotted, etc.).
	The line color is specified as an #SColor8 value, which represents the color of the line. The line tint is specified as a double value between -1 and 1,
	where negative values represent a darker tint and positive values represent a lighter tint. This method allows you to set the line properties for the
	diagonal border of the cell directly, without having to specify the line type as in the SetLine method.
	Note that the diagonal border is only visible if either the diagonal up or diagonal down property of the border is set to #True.
	End Rem
	Method SetDiagonal:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setdiagonal(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Rem
	bbdoc: Sets the line style, color, and tint of the vertical border of the cell.
	returns: #True if the line properties were successfully set, or #False on error.
	about: The line style is specified using an #EXLLineStyle value, which indicates the style of the line (e.g. solid, dashed, dotted, etc.).
	The line color is specified as an #SColor8 value, which represents the color of the line. The line tint is specified as a double value
	between -1 and 1, where negative values represent a darker tint and positive values represent a lighter tint. This method allows you to set
	the line properties for the vertical border of the cell directly, without having to specify the line type as in the SetLine method.
	Note that the vertical border is only visible if the outline property of the border is set to #True.
	End Rem
	Method SetVertical:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_setvertical(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Rem
	bbdoc: Sets the line style, color, and tint of the horizontal border of the cell.
	returns: #True if the line properties were successfully set, or #False on error.
	about: The line style is specified using an #EXLLineStyle value, which indicates the style of the line (e.g. solid, dashed, dotted, etc.).
	The line color is specified as an #SColor8 value, which represents the color of the line. The line tint is specified as a double value
	between -1 and 1, where negative values represent a darker tint and positive values represent a lighter tint. This method allows you to
	set the line properties for the horizontal border of the cell directly, without having to specify the line type as in the SetLine method.
	Note that the horizontal border is only visible if the outline property of the border is set to #True.
	End Rem
	Method SetHorizontal:Int(lineStyle:EXLLineStyle, lineColor:SColor8, lineTint:Double = 0.0)
		Return bmx_openxlsx_xlborder_sethorizontal(borderPtr, lineStyle, lineColor, lineTint)
	End Method

	Rem
	bbdoc: Gets a string summarizing the properties of the border, which can be useful for debugging or logging purposes.
	End Rem
	Method Summary:String()
		Return bmx_openxlsx_xlborder_summary(borderPtr)
	End Method

	Method Delete()
		If borderPtr Then
			bmx_openxlsx_xlborder_free(borderPtr)
			borderPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents a line used in borders, allowing access to its style and color properties.
End Rem
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

	Rem
	bbdoc: Gets the line style of the line, which indicates the style of the border line (e.g. solid, dashed, dotted, etc.).
	End Rem
	Method Style:EXLLineStyle()
		Return bmx_openxlsx_xlline_style(linePtr)
	End Method

	Rem
	bbdoc: Gets the color of the line as a #TXLDataBarColor object, which allows access to the color properties of the line.
	End Rem
	Method Color:TXLDataBarColor()
		Return TXLDataBarColor._Create(bmx_openxlsx_xlline_color(linePtr))
	End Method

	Rem
	bbdoc: Gets a string summarizing the properties of the line, which can be useful for debugging or logging purposes.
	End Rem
	Method Summary:String()
		Return bmx_openxlsx_xlline_summary(linePtr)
	End Method

	Method Delete()
		If linePtr Then
			bmx_openxlsx_xlline_free(linePtr)
			linePtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents the color used in data bars, allowing access to its properties and the ability to modify them.
End Rem
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

	Rem
	bbdoc: Gets the RGB color value of the data bar color as an #SColor8 value.
	End Rem
	Method Rgb:SColor8()
		Return bmx_openxlsx_xldatabarcolor_rgb(colorPtr)
	End Method

	Rem
	bbdoc: Gets the tint of the data bar color, which indicates how much the color is lightened or darkened.
	about: The tint is represented as a double value between -1 and 1, where negative values represent a darker tint and positive values represent a
	lighter tint. A tint of 0 means no change to the color, while a tint of -1 would make the color completely black and a tint of 1 would make the
	color completely white. The tint can be used to create variations of the base color for different data bars, allowing for visual differentiation
	while maintaining a consistent color scheme.
	End Rem
	Method Tint:Double()
		Return bmx_openxlsx_xldatabarcolor_tint(colorPtr)
	End Method

	Rem
	bbdoc: Gets whether the data bar color is set to automatic, which indicates whether the color is determined automatically based on the theme or other factors.
	about: If the data bar color is set to automatic, the actual color used for the data bars will be determined automatically based on the theme or
	other factors in the workbook. If it is set to #False, the color will be determined by the RGB value or theme index specified for the data bar color.
	This property allows for dynamic coloring of data bars based on the overall design of the workbook, while still allowing for manual color
	specification if desired.
	End Rem
	Method Automatic:Int()
		Return bmx_openxlsx_xldatabarcolor_automatic(colorPtr)
	End Method

	Rem
	bbdoc: Gets the indexed color value of the data bar color, which indicates the index of the color in the workbook's color palette.
	about: The indexed color value is an unsigned integer that represents the index of the color in the workbook's color palette. This allows for
	referencing colors that are defined in the palette, which can be useful for maintaining consistency with the colors used in the workbook. The
	actual color corresponding to the indexed color value can be determined by looking up the color in the workbook's color palette using the index.
	End Rem
	Method Indexed:UInt()
		Return bmx_openxlsx_xldatabarcolor_indexed(colorPtr)
	End Method

	Rem
	bbdoc: Gets the theme color value of the data bar color, which indicates the index of the color in the workbook's theme.
	about: The theme color value is an unsigned integer that represents the index of the color in the workbook's theme. This allows for
	referencing colors that are defined in the theme, which can be useful for maintaining consistency with the overall design of the workbook.
	The actual color corresponding to the theme color value can be determined by looking up the color in the workbook's theme using the index.
	Using theme colors allows for dynamic coloring that can adapt to changes in the theme, ensuring that the data bars remain visually consistent
	with the rest of the workbook.
	End Rem
	Method Theme:UInt()
		Return bmx_openxlsx_xldatabarcolor_theme(colorPtr)
	End Method

	Rem
	bbdoc: Sets the RGB color value of the data bar color using an #SColor8 value.
	returns: #True if the RGB color value was successfully set, or #False on error.
	about: The RGB color value is specified as an #SColor8 value, which represents the color of the data bars. Setting the RGB color value
	allows for precise control over the color used for the data bars, independent of the theme or color palette. When the RGB color value is set,
	it will override any theme or indexed color settings for the data bar color, ensuring that the specified color is used for the data bars
	regardless of the workbook's theme or color palette.
	End Rem
	Method SetRgb:Int(newColor:SColor8)
		Return bmx_openxlsx_xldatabarcolor_setrgb(colorPtr, newColor)
	End Method

	Rem
	bbdoc: Sets the RGB color value of the data bar color using an #SColor8 value.
	returns: #True if the RGB color value was successfully set, or #False on error.
	about: The RGB color value is specified as an #SColor8 value, which represents the color of the data bars. Setting the RGB color value
	allows for precise control over the color used for the data bars, independent of the theme or color palette. When the RGB color value is
	set, it will override any theme or indexed color settings for the data bar color, ensuring that the specified color is used for the data
	bars regardless of the workbook's theme or color palette.
	End Rem
	Method Set:Int(newColor:SColor8)
		Return SetRgb(newColor)
	End Method

	Rem
	bbdoc: Sets the tint of the data bar color, which indicates how much the color is lightened or darkened.
	returns: #True if the tint was successfully set, or #False if the tint value is out of the valid range (e.g. less than -1 or greater than 1).
	about: The tint is represented as a double value between -1 and 1, where negative values represent a darker tint and positive values represent a
	lighter tint. A tint of 0 means no change to the color, while a tint of -1 would make the color completely black and a tint of 1 would make the
	color completely white. The tint can be used to create variations of the base color for different data bars, allowing for visual differentiation
	while maintaining a consistent color scheme.
	End Rem
	Method SetTInt:Int(newTint:Double)
		Return bmx_openxlsx_xldatabarcolor_settint(colorPtr, newTint)
	End Method

	Rem
	bbdoc: Sets whether the data bar color is set to automatic, which indicates whether the color is determined automatically based on the theme or other factors.
	returns: #True if the automatic property was successfully set, or #False if the set value is not a valid boolean (e.g. not 0 or 1).
	about: If the data bar color is set to automatic, the actual color used for the data bars will be determined automatically based on the
	theme or other factors in the workbook. If it is set to #False, the color will be determined by the RGB value or theme index specified for
	the data bar color. This property allows for dynamic coloring of data bars based on the overall design of the workbook, while still allowing
	for manual color specification if desired.
	End Rem
	Method SetAutomatic:Int(set:Int = True)
		Return bmx_openxlsx_xldatabarcolor_setautomatic(colorPtr, set)
	End Method

	Rem
	bbdoc: Sets the indexed color value of the data bar color, which indicates the index of the color in the workbook's color palette.
	returns: #True if the indexed color value was successfully set, or #False on error.
	about: The indexed color value is an unsigned integer that represents the index of the color in the workbook's color palette. This allows for
	referencing colors that are defined in the palette, which can be useful for maintaining consistency with the colors used in the workbook. The
	actual color corresponding to the indexed color value can be determined by looking up the color in the workbook's color palette using the index.
	Setting the indexed color value will override any RGB or theme color settings for the data bar color, ensuring that the color from the palette is
	used for the data bars regardless of other color settings.
	End Rem
	Method SetIndexed:Int(newIndex:UInt)
		Return bmx_openxlsx_xldatabarcolor_setindexed(colorPtr, newIndex)
	End Method

	Rem
	bbdoc: Sets the theme color value of the data bar color, which indicates the index of the color in the workbook's theme.
	returns: #True if the theme color value was successfully set, or #False on error.
	about: The theme color value is an unsigned integer that represents the index of the color in the workbook's theme. This allows for referencing
	colors that are defined in the theme, which can be useful for maintaining consistency with the overall design of the workbook. The actual color
	corresponding to the theme color value can be determined by looking up the color in the workbook's theme using the index. Using theme colors
	allows for dynamic coloring that can adapt to changes in the theme, ensuring that the data bars remain visually consistent with the rest of the
	workbook. Setting the theme color value will override any RGB or indexed color settings for the data bar color, ensuring that the color
	from the theme is used for the data bars regardless of other color settings.
	End Rem
	Method SetTheme:Int(newTheme:UInt)
		Return bmx_openxlsx_xldatabarcolor_settheme(colorPtr, newTheme)
	End Method

	Rem
	bbdoc: Gets a string summarizing the properties of the data bar color, which can be useful for debugging or logging purposes.
	End Rem
	Method Summary:String()
		Return bmx_openxlsx_xldatabarcolor_summary(colorPtr)
	End Method

	Method Delete()
		If colorPtr Then
			bmx_openxlsx_xldatabarcolor_free(colorPtr)
			colorPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents the collection of cell formats in a workbook, allowing access to individual cell formats and the ability to create new ones.
End Rem
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

	Rem
	bbdoc: Gets the number of cell formats in the collection, which indicates how many different cell formats are defined in the workbook.
	End Rem
	Method Count:Size_T()
		Return bmx_openxlsx_xlcellformats_count(cellFormatsPtr)
	End Method

	Rem
	bbdoc: Gets a cell format from the collection by its index, which allows access to the properties of that cell format.
	about: The index is a zero-based unsigned integer that indicates the position of the cell format in the collection. The first cell
	format has an index of 0, the second has an index of 1, and so on. Accessing a cell format by index allows you to retrieve the
	properties of that cell format, such as its number format, font index, fill index, border index, and other formatting attributes.
	This can be useful for inspecting the existing cell formats in the workbook or for modifying them as needed.
	End Rem
	Method CellFormatByIndex:TXLCellFormat(index:Size_T)
		Return TXLCellFormat._Create(bmx_openxlsx_xlcellformats_cellformatbyindex(cellFormatsPtr, index))
	End Method

	Rem
	bbdoc: Gets a cell format from the collection by its index using the operator[], which allows access to the properties of that cell format.
	about: The index is a zero-based unsigned integer that indicates the position of the cell format in the collection. The first cell
	format has an index of 0, the second has an index of 1, and so on. Accessing a cell format by index allows you to retrieve the
	properties of that cell format, such as its number format, font index, fill index, border index, and other formatting attributes.
	This can be useful for inspecting the existing cell formats in the workbook or for modifying them as needed.
	End Rem
	Method Operator[]:TXLCellFormat(index:Size_T)
		Return CellFormatByIndex(index)
	End Method

	Rem
	bbdoc: Creates a new cell format in the collection, optionally copying the properties from an existing cell format.
	about: If the @copyFrom parameter is provided with an existing cell format, the new cell format will be created with the same properties as
	the copyFrom cell format. If copyFrom is not provided (i.e. Null), a new cell format will be created with default properties.
	End Rem
	Method Create:Size_T(copyFrom:TXLCellFormat = Null)
		If copyFrom Then
			Return bmx_openxlsx_xlcellformats_create(cellFormatsPtr, copyFrom.cellFormatPtr)
		Else
			Return bmx_openxlsx_xlcellformats_create(cellFormatsPtr, Null)
		End If
	End Method

	Method Delete()
		If cellFormatsPtr Then
			bmx_openxlsx_xlcellformats_free(cellFormatsPtr)
			cellFormatsPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents a cell format, allowing access to its properties such as number format, font index, fill index, border index, and other formatting attributes.
End Rem
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

	Rem
	bbdoc: Gets the number format ID of the cell format, which indicates the number format applied to cells using this format.
	about: The number format ID is an unsigned integer that corresponds to a specific number format defined in the workbook.
	End Rem
	Method NumberFormatId:UInt()
		Return bmx_openxlsx_xlcellformat_numberformatid(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets the font index of the cell format, which indicates the font applied to cells using this format.
	End Rem
	Method FontIndex:Size_T()
		Return bmx_openxlsx_xlcellformat_fontindex(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets the fill index of the cell format, which indicates the fill pattern and color applied to cells using this format.
	End Rem
	Method FillIndex:Size_T()
		Return bmx_openxlsx_xlcellformat_fillindex(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets the border index of the cell format, which indicates the border style and color applied to cells using this format.
	End Rem
	Method BorderIndex:Size_T()
		Return bmx_openxlsx_xlcellformat_borderindex(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets the XF ID of the cell format, which is an internal identifier used by Excel to manage cell formats.
	End Rem
	Method XfId:Size_T()
		Return bmx_openxlsx_xlcellformat_xfid(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets whether the number format of the cell format is applied, which indicates whether the number format should be applied to cells using this format.
	about: If the apply number format property is set to #True, the number format specified by the number format ID will be applied to cells
	using this format. If it is set to #False, the number format will not be applied, and cells using this format will not have any specific number formatting.
	End Rem
	Method ApplyNumberFormat:Int()
		Return bmx_openxlsx_xlcellformat_applynumberformat(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets whether the font of the cell format is applied, which indicates whether the font should be applied to cells using this format.
	about: If the apply font property is set to #True, the font specified by the font index will be applied to cells using this format.
	If it is set to #False, the font will not be applied, and cells using this format will not have any specific font formatting.
	End Rem
	Method ApplyFont:Int()
		Return bmx_openxlsx_xlcellformat_applyfont(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets whether the fill of the cell format is applied, which indicates whether the fill pattern and color should be applied to cells using this format.
	about: If the apply fill property is set to #True, the fill pattern and color specified by the fill index will be applied to cells using this format.
	If it is set to #False, the fill will not be applied, and cells using this format will not have any specific fill formatting.
	End Rem
	Method ApplyFill:Int()
		Return bmx_openxlsx_xlcellformat_applyfill(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets whether the border of the cell format is applied, which indicates whether the border style and color should be applied to cells using this format.
	about: If the apply border property is set to #True, the border style and color specified by the border index will be applied to cells
	using this format. If it is set to #False, the border will not be applied, and cells using this format will not have any specific border formatting.
	End Rem
	Method ApplyBorder:Int()
		Return bmx_openxlsx_xlcellformat_applyborder(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets whether the alignment of the cell format is applied, which indicates whether the alignment properties should be applied to cells using this format.
	about: If the apply alignment property is set to #True, the alignment properties (such as horizontal and vertical alignment, text rotation,
	wrap text, etc.) will be applied to cells using this format. If it is set to #False, the alignment properties will not be applied, and cells
	using this format will not have any specific alignment formatting.
	End Rem
	Method ApplyAlignment:Int()
		Return bmx_openxlsx_xlcellformat_applyalignment(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets whether the protection of the cell format is applied, which indicates whether the protection properties should be applied to cells using this format.
	about: If the apply protection property is set to #True, the protection properties (such as locked and hidden) will be applied to cells
	using this format. If it is set to #False, the protection properties will not be applied, and cells using this format will not have any
	specific protection formatting.
	End Rem
	Method ApplyProtection:Int()
		Return bmx_openxlsx_xlcellformat_applyprotection(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets whether the quote prefix of the cell format is applied, which indicates whether the quote prefix property should be applied to cells using this format.
	about: If the quote prefix property is set to #True, the quote prefix will be applied to cells using this format.
	The quote prefix is a special property in Excel that indicates whether a cell's value should be treated as text, even if it looks like a
	number or a formula. If the quote prefix is set to #True, Excel will treat the cell's value as text, which can be useful for preserving
	leading zeros or preventing automatic conversion of values. If the quote prefix is set to #False, the cell's value will be treated according
	to its content, which means that if it looks like a number, it will be treated as a number, and if it looks like a formula, it will be
	treated as a formula.
	End Rem
	Method QuotePrefix:Int()
		Return bmx_openxlsx_xlcellformat_quoteprefix(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets whether the pivot button of the cell format is applied, which indicates whether the pivot button property should be applied to cells using this format.
	about: If the pivot button property is set to #True, the pivot button will be applied to cells using this format. The pivot button is a
	special property in Excel that indicates whether a cell should display a pivot button when it is part of a pivot table. If the pivot
	button is set to #True, cells using this format that are part of a pivot table will display a pivot button, which allows users to
	easily access pivot table options and features. If the pivot button is set to #False, cells using this format will not display a pivot button,
	even if they are part of a pivot table.
	End Rem
	Method PivotButton:Int()
		Return bmx_openxlsx_xlcellformat_pivotbutton(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets whether the locked property of the cell format is applied, which indicates whether the locked property should be applied to cells using this format.
	about: If the locked property is set to #True, cells using this format will be locked when the worksheet is protected. This means that users
	will not be able to edit the contents of cells using this format unless the worksheet protection is removed or modified to allow editing of
	locked cells. If the locked property is set to #False, cells using this format will not be locked when the worksheet is protected, allowing
	users to edit the contents of those cells even when the worksheet is protected. The locked property is an important aspect of cell protection
	in Excel, as it allows you to control which cells can be edited when the worksheet is protected.
	End Rem
	Method Locked:Int()
		Return bmx_openxlsx_xlcellformat_locked(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets whether the hidden property of the cell format is applied, which indicates whether the hidden property should be applied to cells using this format.
	about: If the hidden property is set to #True, cells using this format will be hidden when the worksheet is protected. This means that
	users will not be able to see the contents of cells using this format unless the worksheet protection is removed or modified to allow
	viewing of hidden cells. If the hidden property is set to #False, cells using this format will not be hidden when the worksheet is
	protected, allowing users to see the contents of those cells even when the worksheet is protected. The hidden property is an important
	aspect of cell protection in Excel, as it allows you to control which cells can be viewed when the worksheet is protected.
	End Rem
	Method Hidden:Int()
		Return bmx_openxlsx_xlcellformat_hidden(cellFormatPtr)
	End Method

	Rem
	bbdoc: Gets the alignment properties of the cell format as a #TXLAlignment object, which allows access to the alignment properties such as horizontal and vertical alignment, text rotation, wrap text, etc.
	about: The alignment properties of the cell format include horizontal and vertical alignment, text rotation, wrap text, indent, relative
	indent, justify last line, shrink to fit, and reading order.
	These properties control how the content of cells using this format is aligned and displayed. The #TXLAlignment object returned by
	this method provides access to these alignment properties, allowing you to inspect and modify them as needed. If the cell format does
	not have alignment properties defined, this method may return Null.
	End Rem
	Method Alignment:TXLAlignment(createIfMissing:Int = False)
		Return TXLAlignment._Create(bmx_openxlsx_xlcellformat_alignment(cellFormatPtr, createIfMissing))
	End Method

	Rem
	bbdoc: Sets the number format ID of the cell format, which indicates the number format to be applied to cells using this format.
	returns: #True if the number format ID was successfully set, or #False on error.
	about: The number format ID is an unsigned integer that corresponds to a specific number format defined in the workbook. Setting the
	number format ID allows you to specify the number format that should be applied to cells using this format. The number format can
	control how numeric values are displayed in Excel, such as the number of decimal places, the use of thousand separators, the display
	of negative numbers, and the formatting of dates and times.
	End Rem
	Method SetNumberFormatId:Int(newNumFormatId:UInt)
		Return bmx_openxlsx_xlcellformat_setnumberformatid(cellFormatPtr, newNumFormatId)
	End Method

	Rem
	bbdoc: Sets the font index of the cell format, which indicates the font to be applied to cells using this format.
	returns: #True if the font index was successfully set, or #False on error.
	about: The font index is an unsigned integer that corresponds to a specific font defined in the workbook. Setting the font index allows
	you to specify the font that should be applied to cells using this format. The font can control the appearance of text in Excel, such as
	the font family, size, color, bold, italic, underline, and other font attributes.
	End Rem
	Method SetFontIndex:Int(newFontIndex:Size_T)
		Return bmx_openxlsx_xlcellformat_setfontindex(cellFormatPtr, newFontIndex)
	End Method

	Rem
	bbdoc: Sets the fill index of the cell format, which indicates the fill pattern and color to be applied to cells using this format.
	returns: #True if the fill index was successfully set, or #False on error.
	about: The fill index is an unsigned integer that corresponds to a specific fill pattern and color defined in the workbook. Setting the
	fill index allows you to specify the fill pattern and color that should be applied to cells using this format. The fill can control the
	background appearance of cells in Excel, such as solid fills, gradient fills, pattern fills, and the colors used for those fills.
	End Rem
	Method SetFillIndex:Int(newFillIndex:Size_T)
		Return bmx_openxlsx_xlcellformat_setfillindex(cellFormatPtr, newFillIndex)
	End Method

	Rem
	bbdoc: Sets the border index of the cell format, which indicates the border style and color to be applied to cells using this format.
	returns: #True if the border index was successfully set, or #False on error.
	about: The border index is an unsigned integer that corresponds to a specific border style and color defined in the workbook. Setting the border
	index allows you to specify the border style and color that should be applied to cells using this format. The border can control the appearance
	of cell borders in Excel, such as the line style (solid, dashed, dotted, etc.) and the color of the borders.
	End Rem
	Method SetBorderIndex:Int(newBorderIndex:Size_T)
		Return bmx_openxlsx_xlcellformat_setborderindex(cellFormatPtr, newBorderIndex)
	End Method

	Rem
	bbdoc: Sets the XF ID of the cell format, which is an internal identifier used by Excel to manage cell formats.
	returns: #True if the XF ID was successfully set, or #False on error.
	about: The XF ID is an unsigned integer that serves as an internal identifier for cell formats in Excel. Setting the XF ID allows you
	to specify the internal identifier for this cell format, which can be useful for managing and referencing cell formats within the workbook.
	The XF ID is used by Excel to keep track of cell formats and their properties, and it can be important for ensuring that the correct cell
	format is applied to cells in the workbook.
	End Rem
	Method SetXfId:Int(newXfId:Size_T)
		Return bmx_openxlsx_xlcellformat_setxfid(cellFormatPtr, newXfId)
	End Method

	Rem
	bbdoc: Sets whether the number format of the cell format is applied, which indicates whether the number format should be applied to cells using this format.
	returns: #True if the apply number format property was successfully set, or #False on error.
	about: If the apply number format property is set to #True, the number format specified by the number format ID will be applied to cells
	using this format. If it is set to #False, the number format will not be applied, and cells using this format will not have any specific
	number formatting.
	End Rem
	Method SetApplyNumberFormat:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplynumberformat(cellFormatPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the font of the cell format is applied, which indicates whether the font should be applied to cells using this format.
	returns: #True if the apply font property was successfully set, or #False on error.
	about: If the apply font property is set to #True, the font specified by the font index will be applied to cells using this format. If
	it is set to #False, the font will not be applied, and cells using this format will not have any specific font formatting.
	End Rem
	Method SetApplyFont:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplyfont(cellFormatPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the fill of the cell format is applied, which indicates whether the fill pattern and color should be applied to cells using this format.
	returns: #True if the apply fill property was successfully set, or #False on error.
	about: If the apply fill property is set to #True, the fill pattern and color specified by the fill index will be applied to cells using 
	this format. If it is set to #False, the fill will not be applied, and cells using this format will not have any specific fill formatting.
	End Rem
	Method SetApplyFill:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplyfill(cellFormatPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the border of the cell format is applied, which indicates whether the border style and color should be applied to cells using this format.
	returns: #True if the apply border property was successfully set, or #False on error.
	about: If the apply border property is set to #True, the border style and color specified by the border index will be applied to cells
	using this format. If it is set to #False, the border will not be applied, and cells using this format will not have any specific border
	formatting.
	End Rem
	Method SetApplyBorder:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplyborder(cellFormatPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the alignment of the cell format is applied, which indicates whether the alignment properties should be applied to cells using this format.
	returns: #True if the apply alignment property was successfully set, or #False on error.
	about: If the apply alignment property is set to #True, the alignment properties (such as horizontal and vertical alignment,
	text rotation, wrap text, etc.) will be applied to cells using this format. If it is set to #False, the alignment properties will
	not be applied, and cells using this format will not have any specific alignment formatting.
	End Rem
	Method SetApplyAlignment:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplyalignment(cellFormatPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the protection of the cell format is applied, which indicates whether the protection properties should be applied to cells using this format.
	returns: #True if the apply protection property was successfully set, or #False on error.
	about: If the apply protection property is set to #True, the protection properties (such as locked and hidden) will be applied to cells using
	this format. If it is set to #False, the protection properties will not be applied, and cells using this format will not have any specific
	protection formatting.
	End Rem
	Method SetApplyProtection:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setapplyprotection(cellFormatPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the quote prefix of the cell format is applied, which indicates whether the quote prefix property should be applied to cells using this format.
	returns: #True if the quote prefix property was successfully set, or #False on error.
	about: If the quote prefix property is set to #True, the quote prefix will be applied to cells using this format. The quote prefix is a
	special property in Excel that indicates whether a cell's value should be treated as text, even if it looks like a number or a formula.
	If the quote prefix is set to #True, Excel will treat the cell's value as text, which can be useful for preserving leading zeros or preventing
	automatic conversion of values. If the quote prefix is set to #False, the cell's value will be treated according to its content, which
	means that if it looks like a number, it will be treated as a number, and if it looks like a formula, it will be treated as a formula.
	End Rem
	Method SetQuotePrefix:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setquoteprefix(cellFormatPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the pivot button of the cell format is applied, which indicates whether the pivot button property should be applied to cells using this format.
	returns: #True if the pivot button property was successfully set, or #False on error.
	about: If the pivot button property is set to #True, the pivot button will be applied to cells using this format. The pivot button is a
	special property in Excel that indicates whether a cell should display a pivot button when it is part of a pivot table. If the pivot button
	is set to #True, cells using this format that are part of a pivot table will display a pivot button, which allows users to easily access pivot
	table options and features. If the pivot button is set to #False, cells using this format will not display a pivot button, even if they
	are part of a pivot table.
	End Rem
	Method SetPivotButton:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setpivotbutton(cellFormatPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the locked property of the cell format is applied, which indicates whether the locked property should be applied to cells using this format.
	returns: #True if the locked property was successfully set, or #False on error.
	about: If the locked property is set to #True, cells using this format will be locked when the worksheet is protected. This means that
	users will not be able to edit the contents of cells using this format unless the worksheet protection is removed or modified to allow
	editing of locked cells. If the locked property is set to #False, cells using this format will not be locked when the worksheet is
	protected, allowing users to edit the contents of those cells even when the worksheet is protected.
	End Rem
	Method SetLocked:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_setlocked(cellFormatPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the hidden property of the cell format is applied, which indicates whether the hidden property should be applied to cells using this format.
	returns: #True if the hidden property was successfully set, or #False on error.
	about: If the hidden property is set to #True, cells using this format will be hidden when the worksheet is protected. This means that
	users will not be able to see the contents of cells using this format unless the worksheet protection is removed or modified to allow
	viewing of hidden cells. If the hidden property is set to #False, cells using this format will not be hidden when the worksheet is protected,
	allowing users to see the contents of those cells even when the worksheet is protected.
	End Rem
	Method SetHidden:Int(set:Int = True)
		Return bmx_openxlsx_xlcellformat_sethidden(cellFormatPtr, set)
	End Method

	Rem
	bbdoc: Gets a string summarizing the properties of the cell format, which can be useful for debugging or logging purposes.
	End Rem
	Method Summary:String()
		Return bmx_openxlsx_xlcellformat_summary(cellFormatPtr)
	End Method

	Method Delete()
		If cellFormatPtr Then
			bmx_openxlsx_xlcellformat_free(cellFormatPtr)
			cellFormatPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents the alignment properties of a cell format, allowing access to properties such as horizontal and vertical alignment, text rotation, wrap text, etc.
End Rem
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

	Rem
	bbdoc: Gets the horizontal alignment style, which indicates how the content of cells using this alignment is horizontally aligned.
	End Rem
	Method Horizontal:EXLAlignmentStyle()
		Return bmx_openxlsx_xlalignment_horizontal(alignmentPtr)
	End Method

	Rem
	bbdoc: Gets the vertical alignment style, which indicates how the content of cells using this alignment is vertically aligned.
	End Rem
	Method Vertical:EXLAlignmentStyle()
		Return bmx_openxlsx_xlalignment_vertical(alignmentPtr)
	End Method

	Rem
	bbdoc: Gets the text rotation in degrees, which indicates the angle at which the text in cells using this alignment is rotated.
	about: The text rotation is measured in degrees, where 0 degrees means no rotation.
	End Rem
	Method TextRotation:Short()
		Return bmx_openxlsx_xlalignment_textrotation(alignmentPtr)
	End Method

	Rem
	bbdoc: Gets whether the wrap text property is enabled, which indicates whether the text in cells using this alignment should wrap to fit within the cell.
	about: If the wrap text property is enabled (#True), the text in cells using this alignment will wrap to fit within the cell, allowing for multiple lines of text. If it is disabled (#False), the text will not wrap and will instead overflow into adjacent cells if it exceeds the width of the cell.
	End Rem
	Method WrapText:Int()
		Return bmx_openxlsx_xlalignment_wraptext(alignmentPtr)
	End Method

	Rem
	bbdoc: Gets the indent level, which indicates the number of indent levels applied to the content of cells using this alignment.
	about: The indent level is an unsigned integer that represents the number of indent levels applied to the content of cells using this
	alignment. Each indent level typically corresponds to a certain amount of indentation (e.g., 1 indent level might correspond to 3 spaces). The indent property is used to create a visual hierarchy in the content of cells, such as when creating an outline or grouping related items together. The maximum indent level may depend on the version of Excel and the specific implementation, but it is generally a small integer value.
	End Rem
	Method Indent:UInt()
		Return bmx_openxlsx_xlalignment_indent(alignmentPtr)
	End Method

	Rem
	bbdoc: Gets the relative indent level, which indicates the number of relative indent levels applied to the content of cells using this alignment.
	about: The relative indent level is an integer that represents the number of relative indent levels applied to the content of cells using this
	alignment. Relative indent is a feature in Excel that allows for additional indentation based on the outline level of the row. It is often used
	in conjunction with the indent property to create a more complex hierarchy in the content of cells. The relative indent level can be positive or
	negative, where positive values indicate additional indentation and negative values indicate reduced indentation relative to the base indent level.
	End Rem
	Method RelativeIndent:Int()
		Return bmx_openxlsx_xlalignment_relativeindent(alignmentPtr)
	End Method

	Rem
	bbdoc: Gets whether the justify last line property is enabled, which indicates whether the last line of text in cells using this alignment should be justified.
	about: If the justify last line property is enabled (#True), the last line of text in cells using this alignment will be justified,
	meaning that it will be stretched to align with both the left and right edges of the cell. If it is disabled (#False), the last line
	of text will not be justified and will instead be aligned according to the horizontal alignment setting (e.g., left, center, right).
	End Rem
	Method JustifyLastLine:Int()
		Return bmx_openxlsx_xlalignment_justifylastline(alignmentPtr)
	End Method

	Rem
	bbdoc: Gets whether the shrink to fit property is enabled, which indicates whether the text in cells using this alignment should be shrunk to fit within the cell.
	about: If the shrink to fit property is enabled (#True), the text in cells using this alignment will be automatically shrunk in size
	to fit within the cell if it exceeds the cell's width. If it is disabled (#False), the text will not be shrunk and will instead
	overflow into adjacent cells if it exceeds the width of the cell. The shrink to fit property can be useful for ensuring that all
	text is visible within a cell without changing the column width, but it can also make the text smaller and harder to read if there is a lot of content.
	End Rem
	Method ShrinkToFit:Int()
		Return bmx_openxlsx_xlalignment_shrinktofit(alignmentPtr)
	End Method

	Rem
	bbdoc: Gets the reading order, which indicates the reading order of text in cells using this alignment.
	about: The reading order is an unsigned integer that indicates the reading order of text in cells using this alignment. The reading order can
	be used to specify the direction in which text is read, such as left-to-right (LTR) or right-to-left (RTL). Common values for reading order
	include 0 for left-to-right and 1 for right-to-left, but the specific values may depend on the implementation and the version of Excel. The
	reading order property is important for supporting languages that are read in different directions, such as Arabic or Hebrew, and it helps
	ensure that the text is displayed correctly according to the intended reading direction.
	End Rem
	Method ReadingOrder:UInt()
		Return bmx_openxlsx_xlalignment_readingorder(alignmentPtr)
	End Method

	Rem
	bbdoc: Sets the horizontal alignment style, which indicates how the content of cells using this alignment is horizontally aligned.
	returns: #True if the horizontal alignment style was successfully set, or #False on error.
	about: The horizontal alignment style is an enumeration that specifies how the content of cells using this alignment is
	horizontally aligned. Common horizontal alignment styles include left, center, right, fill, justify, center continuous,
	and distributed. Setting the horizontal alignment style allows you to control the horizontal positioning of cell content in Excel.
	End Rem
	Method SetHorizontal:Int(newStyle:EXLAlignmentStyle)
		Return bmx_openxlsx_xlalignment_sethorizontal(alignmentPtr, newStyle)
	End Method

	Rem
	bbdoc: Sets the vertical alignment style, which indicates how the content of cells using this alignment is vertically aligned.
	returns: #True if the vertical alignment style was successfully set, or #False on error.
	about: The vertical alignment style is an enumeration that specifies how the content of cells using this alignment is vertically aligned.
	Common vertical alignment styles include top, center, bottom, justify, and distributed. Setting the vertical alignment style allows you 
	to control the vertical positioning of cell content in Excel.
	End Rem
	Method SetVertical:Int(newStyle:EXLAlignmentStyle)
		Return bmx_openxlsx_xlalignment_setvertical(alignmentPtr, newStyle)
	End Method

	Rem
	bbdoc: Sets the text rotation in degrees, which indicates the angle at which the text in cells using this alignment is rotated.
	returns: #True if the text rotation was successfully set, or #False on error.
	about: The text rotation is measured in degrees, where 0 degrees means no rotation.
	End Rem
	Method SetTextRotation:Int(rotation:Short)
		Return bmx_openxlsx_xlalignment_settextrotation(alignmentPtr, rotation)
	End Method

	Rem
	bbdoc: Sets whether the wrap text property is enabled, which indicates whether the text in cells using this alignment should wrap to fit within the cell.
	returns: #True if the wrap text property was successfully set, or #False on error.
	about: If the wrap text property is enabled (#True), the text in cells using this alignment will wrap to fit within the cell,
	allowing for multiple lines of text. If it is disabled (#False), the text will not wrap and will instead overflow into adjacent cells if it
	exceeds the width of the cell.
	End Rem
	Method SetWrapText:Int(set:Int = True)
		Return bmx_openxlsx_xlalignment_setwraptext(alignmentPtr, set)
	End Method

	Rem
	bbdoc: Sets the indent level, which indicates the number of indent levels applied to the content of cells using this alignment.
	returns: #True if the indent level was successfully set, or #False on error.
	about: The indent level is an unsigned integer that represents the number of indent levels applied to the content of cells using this alignment. Each indent level typically corresponds to a certain amount of indentation (e.g., 1 indent level might correspond to 3 spaces). The indent property is used to create a visual hierarchy in the content of cells, such as when creating an outline or grouping related items together. The maximum indent level may depend on the version of Excel and the specific implementation, but it is generally a small integer value.
	End Rem
	Method SetIndent:Int(newIndent:UInt)
		Return bmx_openxlsx_xlalignment_setindent(alignmentPtr, newIndent)
	End Method

	Rem
	bbdoc: Sets the relative indent level, which indicates the number of relative indent levels applied to the content of cells using this alignment.
	returns: #True if the relative indent level was successfully set, or #False on error.
	about: The relative indent level is an integer that represents the number of relative indent levels applied to the content of cells using
	this alignment. Relative indent is a feature in Excel that allows for additional indentation based on the outline level of the row. It
	is often used in conjunction with the indent property to create a more complex hierarchy in the content of cells. The relative indent
	level can be positive or negative, where positive values indicate additional indentation and negative values indicate reduced indentation
	relative to the base indent level.
	End Rem
	Method SetRelativeIndent:Int(newIndent:Int)
		Return bmx_openxlsx_xlalignment_setrelativeindent(alignmentPtr, newIndent)
	End Method

	Rem
	bbdoc: Sets whether the justify last line property is enabled, which indicates whether the last line of text in cells using this alignment should be justified.
	returns: #True if the justify last line property was successfully set, or #False on error.
	about: If the justify last line property is enabled (#True), the last line of text in cells using this alignment will be justified,
	meaning that it will be stretched to align with both the left and right edges of the cell. If it is disabled (#False), the last line
	of text will not be justified and will instead be aligned according to the horizontal alignment setting (e.g., left, center, right).
	End Rem
	Method SetJustifyLastLine:Int(set:Int = True)
		Return bmx_openxlsx_xlalignment_setjustifylastline(alignmentPtr, set)
	End Method

	Rem
	bbdoc: Sets whether the shrink to fit property is enabled, which indicates whether the text in cells using this alignment should be shrunk to fit within the cell.
	returns: #True if the shrink to fit property was successfully set, or #False on error.
	about: If the shrink to fit property is enabled (#True), the text in cells using this alignment will be automatically shrunk in size
	to fit within the cell if it exceeds the cell's width. If it is disabled (#False), the text will not be shrunk and will instead
	overflow into adjacent cells if it exceeds the width of the cell. The shrink to fit property can be useful for ensuring that all
	text is visible within a cell without changing the column width, but it can also make the text smaller and harder to read if there is a lot of content.
	End Rem
	Method SetShrinkToFit:Int(set:Int = True)
		Return bmx_openxlsx_xlalignment_setshrinktofit(alignmentPtr, set)
	End Method

	Rem
	bbdoc: Sets the reading order, which indicates the reading order of text in cells using this alignment.
	returns: #True if the reading order was successfully set, or #False on error.
	about: The reading order is an unsigned integer that indicates the reading order of text in cells using this alignment. The reading
	order can be used to specify the direction in which text is read, such as left-to-right (LTR) or right-to-left (RTL). Common values
	for reading order include 0 for left-to-right and 1 for right-to-left, but the specific values may depend on the implementation
	and the version of Excel. The reading order property is important for supporting languages that are read in different directions,
	such as Arabic or Hebrew, and it helps ensure that the text is displayed correctly according to the intended reading direction.
	End Rem
	Method SetReadingOrder:Int(newReadingOrder:UInt)
		Return bmx_openxlsx_xlalignment_setreadingorder(alignmentPtr, newReadingOrder)
	End Method

	Rem
	bbdoc: Gets a string summarizing the properties of the alignment, which can be useful for debugging or logging purposes.
	End Rem
	Method Summary:String()
		Return bmx_openxlsx_xlalignment_summary(alignmentPtr)
	End Method

	Method Delete()
		If alignmentPtr Then
			bmx_openxlsx_xlalignment_free(alignmentPtr)
			alignmentPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents the collection of cell styles in a workbook, allowing access to individual cell styles and management of the collection.
End Rem
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

	Rem
	bbdoc: Gets the number of cell styles in the collection, which indicates how many cell styles are defined in the workbook.
	End Rem
	Method Count:Size_T()
		Return bmx_openxlsx_xlcellstyles_count(cellStylesPtr)
	End Method

	Rem
	bbdoc: Gets a cell style by its index in the collection, which allows access to the properties of that cell style.
	about: The index is a zero-based unsigned integer that specifies the position of the cell style in the collection.
	The first cell style has an index of 0, the second has an index of 1, and so on. If the index is out of range (greater than
	or equal to the count of cell styles), this method may return Null or result in an error.
	End Rem
	Method CellStyleByIndex:TXLCellStyle(index:Size_T)
		Return TXLCellStyle._Create(bmx_openxlsx_xlcellstyles_cellstylebyindex(cellStylesPtr, index))
	End Method

	Rem
	bbdoc: Gets a cell style by its name, which allows access to the properties of that cell style.
	about: The name is a string that specifies the name of the cell style. Cell styles in Excel can have unique names that identify them.
	If a cell style with the specified name exists in the collection, this method will return it. If no cell style with the specified
	name exists, this method may return Null or result in an error.
	End Rem
	Method Operator[]:TXLCellStyle(index:Size_T)
		Return CellStyleByIndex(index)
	End Method

	Rem
	bbdoc: Creates a new cell style in the collection, optionally copying properties from an existing cell style.
	returns: The index of the newly created cell style in the collection, or an error code on failure.
	about: If the copyFrom parameter is provided and is a valid cell style, the new cell style will be created with the same
	properties as the copyFrom cell style. If copyFrom is Null, a new cell style will be created with default properties.
	The method returns the index of the newly created cell style in the collection, which can be used to access it later. If there
		is an error during creation (e.g., if the collection has reached its maximum capacity), the method may return an error code or throw an exception.
	End Rem
	Method Create:Size_T(copyFrom:TXLCellStyle = Null)
		If copyFrom Then
			Return bmx_openxlsx_xlcellstyles_create(cellStylesPtr, copyFrom.cellStylePtr)
		Else
			Return bmx_openxlsx_xlcellstyles_create(cellStylesPtr, Null)
		End If
	End Method

	Method Delete()
		If cellStylesPtr Then
			bmx_openxlsx_xlcellstyles_free(cellStylesPtr)
			cellStylesPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents an individual cell style in a workbook, allowing access to its properties and management of the cell style.
End Rem
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

	Rem
	bbdoc: Gets whether the cell style is empty, which indicates whether the cell style has no properties defined.
	about: An empty cell style is one that has no properties defined, meaning it does not have any specific formatting or attributes.
	If the cell style is empty, it may be treated as a default or base style in Excel, and cells using this style may not have any specific
	formatting applied to them. If the cell style is not empty, it means that it has specific properties defined that can be applied to cells using this style.
	End Rem
	Method Empty:Int()
		Return bmx_openxlsx_xlcellstyle_empty(cellStylePtr)
	End Method

	Rem
	bbdoc: Gets the name of the cell style, which is a string that identifies the cell style in the workbook.
	End Rem
	Method Name:String()
		Return bmx_openxlsx_xlcellstyle_name(cellStylePtr)
	End Method

	Rem
	bbdoc: Gets the XF ID of the cell style, which is an internal identifier used by Excel to manage cell styles.
	End Rem
	Method XfId:Size_T()
		Return bmx_openxlsx_xlcellstyle_xfid(cellStylePtr)
	End Method

	Rem
	bbdoc: Gets the built-in ID of the cell style, which indicates whether the cell style is a built-in style provided by Excel.
	about: The built-in ID is an unsigned integer that indicates whether the cell style is a built-in style provided by Excel.
	Built-in styles have predefined properties and are identified by specific IDs. If the built-in ID is 0, it typically means
	that the cell style is not a built-in style and may have custom properties defined by the user. If the built-in ID is a non-zero value,
	it indicates that the cell style is a built-in style, and the specific value corresponds to a particular built-in style (e.g., Normal, Heading 1, etc.).
	End Rem
	Method BuiltinId:UInt()
		Return bmx_openxlsx_xlcellstyle_builtinid(cellStylePtr)
	End Method

	Rem
	bbdoc: Gets the outline style of the cell style, which indicates whether the cell style is an outline style used for grouping rows or columns in Excel.
	about: The outline style is an unsigned integer that indicates whether the cell style is an outline style used for grouping rows or
	columns in Excel. Outline styles are special cell styles that can be applied to rows or columns to indicate that they are part of
	an outline group. If the outline style is 0, it typically means that the cell style is not an outline style. If the outline style
	is a non-zero value, it indicates that the cell style is an outline style, and the specific value may correspond to a particular
	outline style defined in the workbook.
	End Rem
	Method OutlineStyle:UInt()
		Return bmx_openxlsx_xlcellstyle_outlinestyle(cellStylePtr)
	End Method

	Rem
	bbdoc: Gets whether the cell style is hidden, which indicates whether the cell style is hidden from the user interface in Excel.
	about: If the cell style is hidden, it means that it will not be visible in the user interface of Excel, such as in the cell style gallery.
	Hidden cell styles can still be applied to cells, but they may not be easily accessible for users to select or modify. If the hidden
	property is #True, the cell style is hidden; if it is #False, the cell style is visible in the user interface.
	End Rem
	Method Hidden:Int()
		Return bmx_openxlsx_xlcellstyle_hidden(cellStylePtr)
	End Method

	Rem
	bbdoc: Gets whether the cell style is a custom built-in style, which indicates whether the cell style is a built-in style that has been customized by the user.
	about: A custom built-in style is a built-in style that has been modified by the user to have different properties than the original
	built-in style. If the custom built-in property is #True, it means that the cell style is a built-in style that has been customized.
	If it is #False, it means that the cell style is either a non-built-in style or a built-in style that has not been customized.
	End Rem
	Method CustomBuiltin:Int()
		Return bmx_openxlsx_xlcellstyle_custombuiltin(cellStylePtr)
	End Method

	Rem
	bbdoc: Sets the name of the cell style, which is a string that identifies the cell style in the workbook.
	returns: #True if the name was successfully set, or #False on error.
	about: The name of the cell style is a string that identifies the cell style in the workbook. Setting the name allows you to give
	the cell style a meaningful identifier that can be used to reference it in the user interface or in code. The name must be
	unique among cell styles in the workbook, and it should not conflict with the names of built-in styles. If the name is
	successfully set, the method returns #True; if there is an error (e.g., if the name is not unique or is invalid), it returns #False.
	End Rem
	Method SetName:Int(newName:String)
		Return bmx_openxlsx_xlcellstyle_setname(cellStylePtr, newName)
	End Method

	Rem
	bbdoc: Sets the XF ID of the cell style, which is an internal identifier used by Excel to manage cell styles.
	returns: #True if the XF ID was successfully set, or #False on error.
	about: The XF ID is an internal identifier used by Excel to manage cell styles. It is typically a zero-based index that refers
	to an entry in the XF (eXtended Format) table of the workbook. Setting the XF ID allows you to associate the cell style with
	a specific set of formatting properties defined in the XF table. If the XF ID is successfully set, the method returns #True;
	if there is an error (e.g., if the XF ID is out of range), it returns #False.
	End Rem
	Method SetXfId:Int(newXfId:Size_T)
		Return bmx_openxlsx_xlcellstyle_setxfid(cellStylePtr, newXfId)
	End Method

	Rem
	bbdoc: Sets the built-in ID of the cell style, which indicates whether the cell style is a built-in style provided by Excel.
	returns: #True if the built-in ID was successfully set, or #False on error.
	about: The built-in ID is an unsigned integer that indicates whether the cell style is a built-in style provided by Excel.
	Built-in styles have predefined properties and are identified by specific IDs. If the built-in ID is set to 0, it typically means
	that the cell style is not a built-in style and may have custom properties defined by the user. If the built-in ID
	is set to a non-zero value, it indicates that the cell style is a built-in style, and the specific value corresponds
	to a particular built-in style (e.g., Normal, Heading 1, etc.). Setting the built-in ID allows you to quickly apply a
	predefined set of properties to the cell style based on the built-in style it represents. If the built-in ID is successfully set,
	the method returns #True; if there is an error (e.g., if the built-in ID is invalid), it returns #False.
	End Rem
	Method SetBuiltinId:Int(newBuiltinId:UInt)
		Return bmx_openxlsx_xlcellstyle_setbuiltinid(cellStylePtr, newBuiltinId)
	End Method

	Rem
	bbdoc: Sets the outline style of the cell style, which indicates whether the cell style is an outline style used for grouping rows or columns in Excel.
	returns: #True if the outline style was successfully set, or #False on error.
	about: The outline style is an unsigned integer that indicates whether the cell style is an outline style used for grouping
	rows or columns in Excel. Outline styles are special cell styles that can be applied to rows or columns to indicate that they
	are part of an outline group. If the outline style is set to 0, it typically means that the cell style is not an outline style.
	If the outline style is set to a non-zero value, it indicates that the cell style is an outline style, and the specific value
	may correspond to a particular outline style defined in the workbook. Setting the outline style allows you to designate the
	cell style as an outline style, which can affect how it is used in grouping and outlining features in Excel. If the outline
	style is successfully set, the method returns #True; if there is an error (e.g., if the outline style value is invalid), it returns #False.
	End Rem
	Method SetOutlineStyle:Int(newOutlineStyle:UInt)
		Return bmx_openxlsx_xlcellstyle_setoutlinestyle(cellStylePtr, newOutlineStyle)
	End Method

	Rem
	bbdoc: Sets whether the cell style is hidden, which indicates whether the cell style is hidden from the user interface in Excel.
	returns: #True if the hidden property was successfully set, or #False on error.
	about: If the cell style is hidden, it means that it will not be visible in the user interface of Excel, such as in the cell style gallery.
	Hidden cell styles can still be applied to cells, but they may not be easily accessible for users to select or modify.
	If the hidden property is set to #True, the cell style is hidden; if it is set to #False, the cell style is visible in
	the user interface. Setting the hidden property allows you to control whether the cell style is exposed to users in Excel,
	which can be useful for managing styles that are meant to be used programmatically or for internal purposes without cluttering the user interface.
	End Rem
	Method SetHidden:Int(set:Int = True)
		Return bmx_openxlsx_xlcellstyle_sethidden(cellStylePtr, set)
	End Method

	Rem
	bbdoc: Sets whether the cell style is a custom built-in style, which indicates whether the cell style is a built-in style that has been customized by the user.
	returns: #True if the custom built-in property was successfully set, or #False on error.
	about: A custom built-in style is a built-in style that has been modified by the user to have different properties than the original
	built-in style. If the custom built-in property is set to #True, it means that the cell style is a built-in style that has been customized.
	If it is set to #False, it means that the cell style is either a non-built-in style or a built-in style that has not been customized.
	Setting the custom built-in property allows you to indicate whether the cell style is a customized version of a built-in style, which
	can affect how it is displayed and used in Excel. If the custom built-in property is successfully set, the method returns #True; if
		there is an error (e.g., if the cell style cannot be set as a custom built-in), it returns #False.
	End Rem
	Method SetCustomBuiltin:Int(set:Int = True)
		Return bmx_openxlsx_xlcellstyle_setcustombuiltin(cellStylePtr, set)
	End Method

	Rem
	bbdoc: Gets a string summarizing the properties of the cell style, which can be useful for debugging or logging purposes.
	End Rem
	Method Summary:String()
		Return bmx_openxlsx_xlcellstyle_summary(cellStylePtr)
	End Method

	Method Delete()
		If cellStylePtr Then
			bmx_openxlsx_xlcellstyle_free(cellStylePtr)
			cellStylePtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents the collection of number formats in a workbook, allowing access to individual number formats and management of the collection.
End Rem
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

	Rem
	bbdoc: Gets the number of number formats in the collection, which indicates how many number formats are defined in the workbook.
	End Rem
	Method Count:Size_T()
		Return bmx_openxlsx_xlnumberformats_count(numberFormatsPtr)
	End Method

	Rem
	bbdoc: Gets a number format by its index in the collection, which allows access to the properties of that number format.
	about: The index is a zero-based unsigned integer that specifies the position of the number format in the collection.
	The first number format has an index of 0, the second has an index of 1, and so on. If the index is out of range (greater than
	or equal to the count of number formats), this method may return Null or result in an error.
	End Rem
	Method NumberFormatByIndex:TXLNumberFormat(index:Size_T)
		Return TXLNumberFormat._Create(bmx_openxlsx_xlnumberformats_numberformatbyindex(numberFormatsPtr, index))
	End Method

	Rem
	bbdoc: Gets a number format by its ID, which allows access to the properties of that number format.
	about: The number format ID is an unsigned integer that uniquely identifies a number format in the workbook. Number
	formats can have specific IDs that correspond to built-in formats or custom formats defined by the user. If a number
	format with the specified ID exists in the collection, this method will return it. If no number format with the specified
	ID exists, this method may return Null or result in an error.
	End Rem
	Method NumberFormatById:TXLNumberFormat(numFormatId:UInt)
		Return TXLNumberFormat._Create(bmx_openxlsx_xlnumberformats_numberformatbyid(numberFormatsPtr, numFormatId))
	End Method

	Rem
	bbdoc: Gets the number format ID of a number format by its index in the collection, which allows you to retrieve the ID associated with a number format at a specific position in the collection.
	about: The number format ID is an unsigned integer that uniquely identifies a number format in the workbook.
	By providing the index of a number format in the collection, you can retrieve its associated ID. If the index is out of range
	(greater than or equal to the count of number formats), this method may return an error code or an invalid ID.
	End Rem
	Method NumberFormatIdFromIndex:UInt(index:Size_T)
		Return bmx_openxlsx_xlnumberformats_numberformatidfromindex(numberFormatsPtr, index)
	End Method

	Rem
	bbdoc: Gets a number format by its index in the collection using the operator[], which allows for convenient access to number formats in the collection.
	End Rem
	Method Operator[]:TXLNumberFormat(index:Size_T)
		Return NumberFormatByIndex(index)
	End Method

	Rem
	bbdoc: Creates a new number format in the collection, optionally copying properties from an existing number format.
	returns: The index of the newly created number format in the collection, or an error code on failure.
	about: If the copyFrom parameter is provided and is a valid number format, the new number format will be created with the same
	properties as the copyFrom number format. If copyFrom is Null, a new number format will be created with default properties. The
	method returns the index of the newly created number format in the collection, which can be used to access it later. If there is
		an error during creation (e.g., if the collection has reached its maximum capacity), the method may return an error code or throw an exception.
	End Rem
	Method Create:Size_T(copyFrom:TXLNumberFormat = Null)
		If copyFrom Then
			Return bmx_openxlsx_xlnumberformats_create(numberFormatsPtr, copyFrom.numberFormatPtr)
		Else
			Return bmx_openxlsx_xlnumberformats_create(numberFormatsPtr, Null)
		End If
	End Method

	Method Delete()
		If numberFormatsPtr Then
			bmx_openxlsx_xlnumberformats_free(numberFormatsPtr)
			numberFormatsPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents an individual number format in a workbook, allowing access to its properties and management of the number format.
End Rem
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

	Rem
	bbdoc: Gets the number format ID, which is an unsigned integer that uniquely identifies the number format in the workbook.
	End Rem
	Method NumberFormatId:UInt()
		Return bmx_openxlsx_xlnumberformat_numberformatid(numberFormatPtr)
	End Method

	Rem
	bbdoc: Gets the format code, which is a string that defines the formatting pattern for the number format.
	End Rem
	Method FormatCode:String()
		Return bmx_openxlsx_xlnumberformat_formatcode(numberFormatPtr)
	End Method

	Rem
	bbdoc: Sets the number format ID, which is an unsigned integer that uniquely identifies the number format in the workbook.
	returns: #True if the number format ID was successfully set, or #False on error.
	about: The number format ID is an unsigned integer that uniquely identifies the number format in the workbook. Setting the
	number format ID allows you to associate this number format with a specific ID, which can be used to reference it in
	the collection of number formats. If the number format ID is successfully set, the method returns #True; if there
		is an error (e.g., if the number format ID is invalid or already in use), it returns #False.
	End Rem
	Method SetNumberFormatId:Int(newNumberFormatId:UInt)
		Return bmx_openxlsx_xlnumberformat_setnumberformatid(numberFormatPtr, newNumberFormatId)
	End Method

	Rem
	bbdoc: Sets the format code, which is a string that defines the formatting pattern for the number format.
	returns: #True if the format code was successfully set, or #False on error.
	about: The format code is a string that defines the formatting pattern for the number format. It specifies how numbers
	should be displayed in cells using this number format. Format codes can include placeholders for digits, decimal points,
	thousand separators, currency symbols, date and time components, and more. Setting the format code allows you to customize
	how numbers are formatted in Excel. If the format code is successfully set, the method returns #True; if there is an error (e.g.,
	if the format code is invalid), it returns #False.
	End Rem
	Method SetFormatCode:Int(newFormatCode:String)
		Return bmx_openxlsx_xlnumberformat_setformatcode(numberFormatPtr, newFormatCode)
	End Method

	Rem
	bbdoc: Gets a string summarizing the properties of the number format, which can be useful for debugging or logging purposes.
	End Rem
	Method Summary:String()
		Return bmx_openxlsx_xlnumberformat_summary(numberFormatPtr)
	End Method

	Method Delete()
		If numberFormatPtr Then
			bmx_openxlsx_xlnumberformat_free(numberFormatPtr)
			numberFormatPtr = Null
		End If
	End Method

End Type

Type TXLConditionalFormats

	Field conditionalFormatsPtr:Byte Ptr

	Function _Create:TXLConditionalFormats(conditionalFormatsPtr:Byte Ptr)
		If conditionalFormatsPtr Then
			Local conditionalFormats:TXLConditionalFormats = New TXLConditionalFormats()
			conditionalFormats.conditionalFormatsPtr = conditionalFormatsPtr
			Return conditionalFormats
		End If
		Return Null
	End Function

	Method Count:Size_T()
		Return bmx_openxlsx_xlconditionalformats_count(conditionalFormatsPtr)
	End Method

	Method ConditionalFormatByIndex:TXLConditionalFormat(index:Size_T)
		Return TXLConditionalFormat._Create(bmx_openxlsx_xlconditionalformats_conditionalformatbyindex(conditionalFormatsPtr, index))
	End Method

	Method Operator[]:TXLConditionalFormat(index:Size_T)
		Return ConditionalFormatByIndex(index)
	End Method

	Method Create:Size_T(copyFrom:TXLConditionalFormat = Null)
		If copyFrom Then
			Return bmx_openxlsx_xlconditionalformats_create(conditionalFormatsPtr, copyFrom.conditionalFormatPtr)
		Else
			Return bmx_openxlsx_xlconditionalformats_create(conditionalFormatsPtr, Null)
		End If
	End Method

	Method Delete()
		If conditionalFormatsPtr Then
			bmx_openxlsx_xlconditionalformats_free(conditionalFormatsPtr)
			conditionalFormatsPtr = Null
		End If
	End Method
End Type

Rem
bbdoc: Represents an individual conditional format in a workbook, allowing access to its properties and management of the conditional format.
End Rem
Type TXLConditionalFormat

	Field conditionalFormatPtr:Byte Ptr

	Function _Create:TXLConditionalFormat(conditionalFormatPtr:Byte Ptr)
		If conditionalFormatPtr Then
			Local conditionalFormat:TXLConditionalFormat = New TXLConditionalFormat()
			conditionalFormat.conditionalFormatPtr = conditionalFormatPtr
			Return conditionalFormat
		End If
		Return Null
	End Function

	Rem
	bbdoc: Gets whether the conditional format is empty, which indicates whether the conditional format has no properties defined.
	about: An empty conditional format is one that has no properties defined, meaning it does not have any specific
	formatting rules or attributes. If the conditional format is empty, it may not have any effect when applied to cells,
	as it does not define any conditions or formatting to apply. If the conditional format is not empty, it means that it has
	specific properties defined that can be applied to cells based on certain conditions.
	End Rem
	Method Empty:Int()
		Return bmx_openxlsx_xlconditionalformat_empty(conditionalFormatPtr)
	End Method

	Rem
	bbdoc: Gets the sqref, which is a string that represents the cell or range of cells to which the conditional format applies.
	End Rem
	Method Sqref:String()
		Return bmx_openxlsx_xlconditionalformat_sqref(conditionalFormatPtr)
	End Method

	Rem
	bbdoc: Gets the collection of conditional formatting rules associated with this conditional format, which defines
	the specific conditions and formatting to apply to cells that meet those conditions.
	End Rem
	Method CfRules:TXLCfRules()
		Return TXLCfRules._Create(bmx_openxlsx_xlconditionalformat_cfrules(conditionalFormatPtr))
	End Method

	Rem
	bbdoc: Sets the sqref, which is a string that represents the cell or range of cells to which the conditional format applies.
	returns: #True if the sqref was successfully set, or #False on error.
	about: The sqref is a string that represents the cell or range of cells to which the conditional format applies.
	It is typically in the format of an Excel range reference (e.g., "A1", "B2:C5", "Sheet1!A1:B10"). Setting the sqref allows
	you to specify which cells the conditional format should be applied to. If the sqref is successfully set, the method returns #True; if there is an error (e.g., if the sqref is invalid), it returns #False.
	End Rem
	Method SetSqref:Int(newSqref:String)
		Return bmx_openxlsx_xlconditionalformat_setsqref(conditionalFormatPtr, newSqref)
	End Method

	Method Delete()
		If conditionalFormatPtr Then
			bmx_openxlsx_xlconditionalformat_free(conditionalFormatPtr)
			conditionalFormatPtr = Null
		End If
	End Method

End Type

Rem
bbdoc: Represents a collection of conditional formatting rules associated with a conditional format, allowing access to individual rules and management of the collection.
End Rem
Type TXLCfRules

	Field cfRulesPtr:Byte Ptr

	Function _Create:TXLCfRules(cfRulesPtr:Byte Ptr)
		If cfRulesPtr Then
			Local cfRules:TXLCfRules = New TXLCfRules()
			cfRules.cfRulesPtr = cfRulesPtr
			Return cfRules
		End If
		Return Null
	End Function

	Rem
	bbdoc: Gets whether the collection of conditional formatting rules is empty, which indicates whether there are no rules defined in the collection.
	End Rem
	Method Empty:Int()
		Return bmx_openxlsx_xlcfrules_empty(cfRulesPtr)
	End Method

	Rem
	bbdoc: Gets the maximum priority value among the conditional formatting rules in the collection, which indicates the highest priority level assigned to any rule in the collection.
	about: The maximum priority value is a short integer that indicates the highest priority level assigned to any conditional
	formatting rule in the collection. In Excel, conditional formatting rules are evaluated in order of their priority, with lower
	numbers having higher priority. The maximum priority value can be used to determine the range of valid priority values for new
	rules added to the collection, ensuring that new rules can be assigned a priority that is higher than existing rules if needed.
	If the collection is empty, the maximum priority value may be 0 or a default value, depending on the implementation.
	End Rem
	Method MaxPriorityValue:Short()
		Return bmx_openxlsx_xlcfrules_maxpriorityvalue(cfRulesPtr)
	End Method

	Rem
	bbdoc: Sets the priority of a conditional formatting rule at a specific index in the collection, which determines the order in which the rules are evaluated.
	returns: #True if the priority was successfully set, or #False on error.
	about: The priority of a conditional formatting rule determines the order in which the rules are evaluated when applied
	to cells. In Excel, rules with lower priority values are evaluated before those with higher values. Setting the priority
	of a rule allows you to control the sequence of rule evaluation, which can affect how formatting is applied when multiple
	rules apply to the same cells. The cfRuleIndex parameter specifies the index of the rule in the collection for which to set the priority, and newPriority is the new priority value to assign to that rule. If the priority is successfully set, the method returns #True; if there is an error (e.g., if the index is out of range or the priority value is invalid), it returns #False.
	End Rem
	Method SetPriority:Int(cfRuleIndex:Size_T, newPriority:Short)
		Return bmx_openxlsx_xlcfrules_setpriority(cfRulesPtr, cfRuleIndex, newPriority)
	End Method

	Rem
	bbdoc: Renumbers the priorities of all conditional formatting rules in the collection by incrementing their priority values by a specified increment, which can be used to adjust the order of rule evaluation.
	End Rem
	Method RenumberPriorities(increment:Short = 1)
		bmx_openxlsx_xlcfrules_renumberpriorities(cfRulesPtr, increment)
	End Method

	Rem
	bbdoc: Gets the number of conditional formatting rules in the collection, which indicates how many rules are defined for the conditional format.
	End Rem
	Method Count:Size_T()
		Return bmx_openxlsx_xlcfrules_count(cfRulesPtr)
	End Method

	Rem
	bbdoc: Gets a conditional formatting rule by its index in the collection, which allows access to the properties of that rule.
	about: The index is a zero-based unsigned integer that specifies the position of the conditional formatting rule in the collection.
	The first rule has an index of 0, the second has an index of 1, and so on. If the index is out of range (greater than or equal to the
	count of rules), this method may return Null or result in an error.
	End Rem
	Method CfRuleByIndex:TXLCfRule(index:Size_T)
		Return TXLCfRule._Create(bmx_openxlsx_xlcfrules_cfrulebyindex(cfRulesPtr, index))
	End Method

	Rem
	bbdoc: Gets a conditional formatting rule by its index in the collection, which allows access to the properties of that rule.
	about: The index is a zero-based unsigned integer that specifies the position of the conditional formatting rule in the collection.
	The first rule has an index of 0, the second has an index of 1, and so on. If the index is out of range (greater than or equal to the
	count of rules), this method may return Null or result in an error.
	End Rem
	Method Operator[]:TXLCfRule(index:Size_T)
		Return CfRuleByIndex(index)
	End Method

	Rem
	bbdoc: Creates a new conditional formatting rule in the collection, optionally copying properties from an existing rule.
	returns: The index of the newly created rule in the collection, or an error code on failure.
	about: If the copyFrom parameter is provided and is a valid conditional formatting rule, the new rule will be created with the
	same properties as the copyFrom rule. If copyFrom is Null, a new rule will be created with default properties. The method
	returns the index of the newly created rule in the collection, which can be used to access it later. If there is an error
	during creation (e.g., if the collection has reached its maximum capacity), the method may return an error code or throw an exception.
	End Rem
	Method Create:Size_T(copyFrom:TXLCfRule = Null)
		If copyFrom Then
			Return bmx_openxlsx_xlcfrules_create(cfRulesPtr, copyFrom.cfRulePtr)
		Else
			Return bmx_openxlsx_xlcfrules_create(cfRulesPtr, Null)
		End If
	End Method

	Method Delete()
		If cfRulesPtr Then
			bmx_openxlsx_xlcfrules_free(cfRulesPtr)
			cfRulesPtr = Null
		End If
	End Method
End Type

Rem
bbdoc: Represents an individual conditional formatting rule in a collection of rules, allowing access to its properties and management of the rule.
End Rem
Type TXLCfRule

	Field cfRulePtr:Byte Ptr

	Function _Create:TXLCfRule(cfRulePtr:Byte Ptr)
		If cfRulePtr Then
			Local cfRule:TXLCfRule = New TXLCfRule()
			cfRule.cfRulePtr = cfRulePtr
			Return cfRule
		End If
		Return Null
	End Function

	Rem
	bbdoc: Gets whether the conditional formatting rule is empty, which indicates whether the rule has no properties defined.
	about: An empty conditional formatting rule is one that has no properties defined, meaning it does not have any specific
	conditions or formatting attributes. If the rule is empty, it may not have any effect when applied to cells, as it does not
	define any conditions or formatting to apply. If the rule is not empty, it means that it has specific properties defined that
	can be applied to cells based on certain conditions.
	End Rem
	Method Empty:Int()
		Return bmx_openxlsx_xlcfrule_empty(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets the formula associated with the conditional formatting rule, which is a string that defines the condition under which the formatting should be applied.
	End Rem
	Method Formula:String()
		Return bmx_openxlsx_xlcfrule_formula(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets the type of the conditional formatting rule, which indicates the specific type of conditional formatting being applied (e.g., cell value, expression, color scale, etc.).
	about: The type of the conditional formatting rule is an enumeration that indicates the specific type of conditional formatting being applied.
	End Rem
	Method CfType:EXLCfType()
		Return bmx_openxlsx_xlcfrule_type(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets the DXF ID associated with the conditional formatting rule, which is an internal identifier that references a specific set of formatting properties defined in the workbook.
	about: The DXF ID is an internal identifier that references a specific set of formatting properties defined in the workbook.
	End Rem
	Method DxfId:Size_T()
		Return bmx_openxlsx_xlcfrule_dxfid(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets the priority of the conditional formatting rule, which determines the order in which the rule is evaluated relative to other rules.
	about: The priority of a conditional formatting rule determines the order in which the rules are evaluated when applied to cells.
	In Excel, rules with lower priority values are evaluated before those with higher values. The priority is a short integer that
	indicates the level of priority assigned to the rule, with lower numbers having higher priority.
	End Rem
	Method Priority:Short()
		Return bmx_openxlsx_xlcfrule_priority(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets whether the conditional formatting rule has the "Stop If True" property set, which indicates whether Excel should stop evaluating subsequent rules if this rule evaluates to true.
	about: If the "Stop If True" property is set for a conditional formatting rule, it means that if this rule evaluates to true for a cell,
	Excel will stop evaluating any subsequent conditional formatting rules for that cell. This can be used to create mutually exclusive rules,
	where only the first rule that evaluates to true will apply its formatting, and any rules that follow it will be ignored for that
	cell. If the "Stop If True" property is not set, Excel will continue to evaluate subsequent rules even if this rule evaluates to true.
	End Rem
	Method StopIfTrue:Int()
		Return bmx_openxlsx_xlcfrule_stopiftrue(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets whether the conditional formatting rule has the "Above Average" property set, which indicates whether the rule applies to cells with values above the average of a range.
	about: If the "Above Average" property is set for a conditional formatting rule, it means that the rule applies to cells with
	values above the average of a specified range. This type of rule is often used to highlight values that are above the average
	in a dataset. If the "Above Average" property is not set, the rule does not specifically target values above the average and
	may apply to cells based on other conditions defined in the rule.
	End Rem
	Method AboveAverage:Int()
		Return bmx_openxlsx_xlcfrule_aboveaverage(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets whether the conditional formatting rule has the "Percent" property set, which indicates whether the rule applies to a certain percentage of values in a range.
	about: If the "Percent" property is set for a conditional formatting rule, it means that the rule applies to a certain percentage
	of values in a specified range. This type of rule is often used to highlight the top or bottom percentage of values in a dataset.
	The specific percentage is typically defined in the rule's properties. If the "Percent" property is not set, the rule does not
	specifically target a percentage of values and may apply to cells based on other conditions defined in the rule.
	End Rem
	Method Percent:Int()
		Return bmx_openxlsx_xlcfrule_percent(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets whether the conditional formatting rule has the "Bottom" property set, which indicates whether the rule applies to a certain number of lowest values in a range.
	about: If the "Bottom" property is set for a conditional formatting rule, it means that the rule applies to a certain number of
	lowest values in a specified range. This type of rule is often used to highlight the bottom N values in a dataset, where N is
	defined in the rule's properties. If the "Bottom" property is not set, the rule does not specifically target the lowest values
	and may apply to cells based on other conditions defined in the rule.
	End Rem
	Method Bottom:Int()
		Return bmx_openxlsx_xlcfrule_bottom(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets the operator of the conditional formatting rule, which indicates the specific comparison operator used in the rule (e.g., equal to, greater than, between, etc.).
	about: The operator of the conditional formatting rule is an enumeration that indicates the specific comparison operator used
	in the rule. This operator defines how the rule evaluates the condition for applying formatting to cells. For example, if the
	rule is of type "Cell Value", the operator might specify whether the rule applies to cells that are equal to a certain value,
	greater than a certain value, between two values, etc. The operator is an important property of the rule that determines how
	it evaluates conditions against cell values.
	End Rem
	Method RuleOperator:EXLCfOperator()
		Return bmx_openxlsx_xlcfrule_operator(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets the text associated with the conditional formatting rule, which may be used for rules that involve text comparisons (e.g., contains text, does not contain text, etc.).
	about: The text property of a conditional formatting rule is a string that may be used for rules that involve text comparisons.
	For example, if the rule is of type "Contains Text", the text property would specify the substring that the rule checks for
	in cell values. If the rule is of type "Does Not Contain Text", the text property would specify the substring that the
	rule checks for absence of in cell values. The text property is relevant for certain types of rules that involve text
	conditions, and it may be empty or not applicable for other types of rules that do not involve text comparisons.
	End Rem
	Method Text:String()
		Return bmx_openxlsx_xlcfrule_text(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets the time period associated with the conditional formatting rule, which may be used for rules that involve date comparisons (e.g., last 7 days, next month, etc.).
	about: The time period property of a conditional formatting rule is an enumeration that may be used for rules that involve date comparisons.
	For example, if the rule is of type "Last 7 Days", the time period property would indicate that the rule applies to cells with dates
		that fall within the last 7 days. If the rule is of type "Next Month", the time period property would indicate that the rule
		applies to cells with dates that fall within the next month. The time period property is relevant for certain types
		of rules that involve date conditions, and it may be not applicable for other types of rules that do not involve date comparisons.
	End Rem
	Method TimePeriod:EXLCfTimePeriod()
		Return bmx_openxlsx_xlcfrule_timeperiod(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets the rank associated with the conditional formatting rule, which may be used for rules that involve ranking values (e.g., top 10 items, bottom 5 items, etc.).
	about: The rank property of a conditional formatting rule is a short integer that may be used for rules that involve ranking values.
	For example, if the rule is of type "Top 10 Items", the rank property would indicate that the rule applies to the top 10 ranked
		values in a specified range. If the rule is of type "Bottom 5 Items", the rank property would indicate that the rule
		applies to the bottom 5 ranked values in a specified range. The rank property is relevant for certain types of rules that
		involve ranking conditions, and it may be not applicable for other types of rules that do not involve ranking values.
	End Rem
	Method Rank:Short()
		Return bmx_openxlsx_xlcfrule_rank(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets whether the conditional formatting rule has the "StdDev" property set, which indicates whether the rule applies to values that are a certain number of standard deviations from the mean.
	about: If the "StdDev" property is set for a conditional formatting rule, it means that the rule applies to values that are a
	certain number of standard deviations from the mean of a specified range. This type of rule is often used to highlight values
	that are significantly different from the average in a dataset. The specific number of standard deviations is typically defined
	in the rule's properties. If the "StdDev" property is not set, the rule does not specifically target values based on standard
	deviations and may apply to cells based on other conditions defined in the rule.
	End Rem
	Method StdDev:Int()
		Return bmx_openxlsx_xlcfrule_stddev(cfRulePtr)
	End Method

	Rem
	bbdoc: Gets whether the conditional formatting rule has the "Equal Average" property set, which indicates whether the rule applies to values that are equal to the average of a range.
	about: If the "Equal Average" property is set for a conditional formatting rule, it means that the rule applies to values
	that are equal to the average of a specified range. This type of rule is often used to highlight values that are exactly
	equal to the average in a dataset. If the "Equal Average" property is not set, the rule does not specifically target values
	equal to the average and may apply to cells based on other conditions defined in the rule.
	End Rem
	Method EqualAverage:Int()
		Return bmx_openxlsx_xlcfrule_equalaverage(cfRulePtr)
	End Method

	Rem
	bbdoc: Sets the type of the conditional formatting rule, which indicates the specific type of conditional formatting being applied (e.g., cell value, expression, color scale, etc.).
	returns: #True if the type was successfully set, or #False on error.
	about: The type of the conditional formatting rule is an enumeration that indicates the specific type of conditional formatting being applied.
	Setting the type of the rule allows you to define what kind of condition the rule evaluates and how it applies formatting to cells. For example,
	if you set the type to "Cell Value", you can then specify conditions based on cell values. If you set the type to "Color Scale", the rule would
	apply a color gradient based on cell values. If the type is successfully set, the method returns #True; if there is an error (e.g., if the
	type is invalid), it returns #False.
	End Rem
	Method SetType:Int(newType:EXLCfType)
		Return bmx_openxlsx_xlcfrule_settype(cfRulePtr, newType)
	End Method

	Rem
	bbdoc: Sets the formula associated with the conditional formatting rule, which is a string that defines the condition under which the formatting should be applied.
	returns: #True if the formula was successfully set, or #False on error.
	about: The formula for a conditional formatting rule is a string that defines the condition under which the formatting should be
	applied to cells. The formula is typically an Excel formula that evaluates to true or false for each cell the rule applies to.
	Setting the formula allows you to specify complex conditions for when the formatting should be applied. If the formula is successfully
	set, the method returns #True; if there is an error (e.g., if the formula is invalid), it returns #False.
	End Rem
	Method SetFormula:Int(newFormula:String)
	Method SetDxfId:Int(newDxfId:Size_T)
		Return bmx_openxlsx_xlcfrule_setdxfid(cfRulePtr, newDxfId)
	End Method

	Rem
	bbdoc: Sets the "Stop If True" property of the conditional formatting rule, which indicates whether Excel should stop evaluating subsequent rules if this rule evaluates to true.
	returns: #True if the property was successfully set, or #False on error.
	about: Setting the "Stop If True" property for a conditional formatting rule allows you to control the evaluation of rules when
	multiple rules apply to the same cells. If this property is set to #True, it means that if this rule evaluates to true for a cell,
	Excel will stop evaluating any subsequent conditional formatting rules for that cell. This can be used to create mutually exclusive
	rules, where only the first rule that evaluates to true will apply its formatting, and any rules that follow it will be ignored for
	that cell. If the property is successfully set, the method returns #True; if there is an error (e.g., if the rule is invalid), it returns #False.
	End Rem
	Method SetStopIfTrue:Int(set:Int = True)
		Return bmx_openxlsx_xlcfrule_setstopiftrue(cfRulePtr, set)
	End Method

	Rem
	bbdoc: Sets the "Above Average" property of the conditional formatting rule, which indicates whether the rule applies to cells with values above the average of a range.
	returns: #True if the property was successfully set, or #False on error.
	about: Setting the "Above Average" property for a conditional formatting rule allows you to specify that the rule applies to cells
	with values above the average of a specified range. This type of rule is often used to highlight values that are above the average
	in a dataset. If the property is successfully set, the method returns #True; if there is an error (e.g., if the rule is invalid), it returns #False.
	End Rem
	Method SetAboveAverage:Int(set:Int = True)
		Return bmx_openxlsx_xlcfrule_setaboveaverage(cfRulePtr, set)
	End Method

	Rem
	bbdoc: Sets the "Percent" property of the conditional formatting rule, which indicates whether the rule applies to a certain percentage of values in a range.
	returns: #True if the property was successfully set, or #False on error.
	about: Setting the "Percent" property for a conditional formatting rule allows you to specify that the rule applies to a certain percentage
	of values in a specified range. This type of rule is often used to highlight the top or bottom percentage of values in a dataset. The
	specific percentage is typically defined in the rule's properties. If the property is successfully set, the method returns #True;
	if there is an error (e.g., if the rule is invalid), it returns #False.
	End Rem
	Method SetPercent:Int(set:Int = True)
		Return bmx_openxlsx_xlcfrule_setpercent(cfRulePtr, set)
	End Method

	Rem
	bbdoc: Sets the "Bottom" property of the conditional formatting rule, which indicates whether the rule applies to a certain number of lowest values in a range.
	returns: #True if the property was successfully set, or #False on error.
	about: Setting the "Bottom" property for a conditional formatting rule allows you to specify that the rule applies to a certain
	number of lowest values in a specified range. This type of rule is often used to highlight the bottom N values in a dataset,
	where N is defined in the rule's properties. If the property is successfully set, the method returns #True; if there is an error (e.g., if the rule is invalid), it returns #False.
	End Rem
	Method SetBottom:Int(set:Int = True)
		Return bmx_openxlsx_xlcfrule_setbottom(cfRulePtr, set)
	End Method

	Rem
	bbdoc: Sets the operator for the conditional formatting rule, which determines how the rule evaluates the cell values.
	returns: #True if the operator was successfully set, or #False on error.
	about: Setting the operator for a conditional formatting rule allows you to define how the rule evaluates the cell values.
	The operator can be one of several predefined types, such as equal to, not equal to, greater than, less than, etc.
	If the operator is successfully set, the method returns #True; if there is an error (e.g., if the rule is invalid), it returns #False.
	End Rem
	Method SetRuleOperator:Int(newOperator:EXLCfOperator)
		Return bmx_openxlsx_xlcfrule_setoperator(cfRulePtr, newOperator)
	End Method

	Rem
	bbdoc: Sets the text for the conditional formatting rule, which may be used for rules that involve text comparisons (e.g., contains text, does not contain text, etc.).
	returns: #True if the text was successfully set, or #False on error.
	about: Setting the text for a conditional formatting rule allows you to specify the substring that the rule checks for in cell
	values when the rule involves text comparisons. For example, if the rule is of type "Contains Text", the text property would
	specify the substring that the rule checks for in cell values. If the rule is of type "Does Not Contain Text", the text property
	would specify the substring that the rule checks for absence of in cell values. If the text is successfully set, the method
	returns #True; if there is an error (e.g., if the rule is invalid), it returns #False.
	End Rem
	Method SetText:Int(newText:String)
		Return bmx_openxlsx_xlcfrule_settext(cfRulePtr, newText)
	End Method

	Rem
	bbdoc: Sets the time period for the conditional formatting rule, which may be used for rules that involve date comparisons (e.g., last 7 days, next month, etc.).
	returns: #True if the time period was successfully set, or #False on error.
	about: Setting the time period for a conditional formatting rule allows you to specify the date range that the rule
	applies to when the rule involves date comparisons. For example, if the rule is of type "Last 7 Days", the time period
	property would indicate that the rule applies to cells with dates that fall within the last 7 days. If the rule is of
	type "Next Month", the time period property would indicate that the rule applies to cells with dates that fall within the
	next month. If the time period is successfully set, the method returns #True; if there is an error (e.g., if the rule is invalid), it returns #False.
	End Rem
	Method SetTimePeriod:Int(newTimePeriod:EXLCfTimePeriod)
		Return bmx_openxlsx_xlcfrule_settimeperiod(cfRulePtr, newTimePeriod)
	End Method

	Rem
	bbdoc: Sets the rank for the conditional formatting rule, which may be used for rules that involve ranking values (e.g., top 10 items, bottom 5 items, etc.).
	returns: #True if the rank was successfully set, or #False on error.
	about: Setting the rank for a conditional formatting rule allows you to specify the number of top or bottom ranked values
	that the rule applies to when the rule involves ranking conditions. For example, if the rule is of type "Top 10 Items", the
	rank property would indicate that the rule applies to the top 10 ranked values in a specified range. If the rule is of type
	"Bottom 5 Items", the rank property would indicate that the rule applies to the bottom 5 ranked values in a specified range.
	If the rank is successfully set, the method returns #True; if there is an error (e.g., if the rule is invalid), it returns #False.
	End Rem
	Method SetRank:Int(newRank:Short)
		Return bmx_openxlsx_xlcfrule_setrank(cfRulePtr, newRank)
	End Method

	Rem
	bbdoc: Sets the "StdDev" property for the conditional formatting rule, which indicates whether the rule applies to values that are a certain number of standard deviations from the mean.
	returns: #True if the property was successfully set, or #False on error.
	about: Setting the "StdDev" property for a conditional formatting rule allows you to specify that the rule applies to values that are a
	certain number of standard deviations from the mean of a specified range. This type of rule is often used to highlight values that are
	significantly different from the average in a dataset. The specific number of standard deviations is typically defined in the rule's properties.
	If the property is successfully set, the method returns #True; if there is an error (e.g., if the rule is invalid), it returns #False.
	End Rem
	Method SetStdDev:Int(set:Int = True)
		Return bmx_openxlsx_xlcfrule_setstddev(cfRulePtr, set)
	End Method

	Rem
	bbdoc: Sets the "Equal Average" property for the conditional formatting rule, which indicates whether the rule applies to values that are equal to the average of a range.
	returns: #True if the property was successfully set, or #False on error.
	about: Setting the "Equal Average" property for a conditional formatting rule allows you to specify that the rule applies to values that
	are equal to the average of a specified range. This type of rule is often used to highlight values that are exactly equal to the average
	in a dataset. If the property is successfully set, the method returns #True; if there is an error (e.g., if the rule is invalid), it returns #False.
	End Rem
	Method SetEqualAverage:Int(set:Int = True)
		Return bmx_openxlsx_xlcfrule_setequalaverage(cfRulePtr, set)
	End Method

	Method Delete()
		If cfRulePtr Then
			bmx_openxlsx_xlcfrule_free(cfRulePtr)
			cfRulePtr = Null
		End If
	End Method

End Type

' exceptions

Rem
bbdoc: Represents a general exception that can occur in the context of the TXL classes, allowing for error handling and reporting of issues that may arise during operations.
End Rem
Type TXLException Extends TRuntimeException

	Function _Create:TXLException(message:String) { nomangle }
		Local ex:TXLException = New TXLException()
		ex.error = message
		Return ex
	End Function

End Type

Rem
bbdoc: Represents a runtime error that can occur during the execution of operations in the context of the TXL classes, allowing for error handling and reporting of issues that may arise during runtime.
End Rem
Type TXLRuntimeError Extends TRuntimeException

	Function _Create:TXLRuntimeError(message:String) { nomangle }
		Local ex:TXLRuntimeError = New TXLRuntimeError()
		ex.error = message
		Return ex
	End Function

End Type

Rem
bbdoc: Represents a value type error that can occur in the context of the TXL classes, allowing for error handling and reporting of issues related to invalid value types.
End Rem
Type TXLValueTypeError Extends TRuntimeException

	Function _Create:TXLValueTypeError(message:String) { nomangle }
		Local ex:TXLValueTypeError = New TXLValueTypeError()
		ex.error = message
		Return ex
	End Function

End Type

Rem
bbdoc: Represents an error related to cell addresses that can occur in the context of the TXL classes, allowing for error handling and reporting of issues related to invalid cell addresses.
End Rem
Type TXLCellAddressError Extends TRuntimeException

	Function _Create:TXLCellAddressError(message:String) { nomangle }
		Local ex:TXLCellAddressError = New TXLCellAddressError()
		ex.error = message
		Return ex
	End Function

End Type

Rem
bbdoc: Represents an error related to input data that can occur in the context of the TXL classes, allowing for error handling and reporting of issues related to invalid input.
End Rem
Type TXLInputError Extends TRuntimeException

	Function _Create:TXLInputError(message:String) { nomangle }
		Local ex:TXLInputError = New TXLInputError()
		ex.error = message
		Return ex
	End Function

End Type

Rem
bbdoc: Represents an error related to properties that can occur in the context of the TXL classes, allowing for error handling and reporting of issues related to invalid properties or property values.
End Rem
Type TXLPropertyError Extends TRuntimeException

	Function _Create:TXLPropertyError(message:String) { nomangle }
		Local ex:TXLPropertyError = New TXLPropertyError()
		ex.error = message
		Return ex
	End Function

End Type
