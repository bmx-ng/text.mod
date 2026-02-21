/*
  Copyright (c) 2026 Bruce A Henderson

  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
  - Redistributions of source code must retain the above copyright
    notice, this list of conditions and the following disclaimer.
  - Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
  - Neither the name of the author nor the
    names of any contributors may be used to endorse or promote products
    derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
#include "brl.mod/blitz.mod/blitz.h"
#include "OpenXLSX.hpp"

class MaxXLDocument;
class MaxXLWorkbook;
class MaxXLWorkSheet;
class MaxXLCell;
class MaxXLCellReference;
class MaxXLCellRange;
class MaxXLCellRangeIterator;
class MaxXLRow;
class MaxXLRowRange;
class MaxXLRowIterator;
class MaxXLRowDataRange;
class MaxXLRowDataIterator;
class MaxXLColumn;

extern "C" {

	struct SColor8 {
		uint8_t b;
		uint8_t g;
		uint8_t r;
		uint8_t a;
	} typedef SColor8;

	BBObject * text_xlsx_TXLException__Create(BBString * err);
	BBObject * text_xlsx_TXLRuntimeError__Create(BBString * err);
	BBObject * text_xlsx_TXLValueTypeError__Create(BBString * err);
	BBObject * text_xlsx_TXLCellAddressError__Create(BBString * err);
	BBObject * text_xlsx_TXLInputError__Create(BBString * err);
	BBObject * text_xlsx_TXLPropertyError__Create(BBString * err);

	MaxXLDocument * bmx_openxlsx_xldocument_new();
	void bmx_openxlsx_xldocument_free(MaxXLDocument * doc);
	void bmx_openxlsx_xldocument_open(MaxXLDocument * doc, BBString * filename);
	void bmx_openxlsx_xldocument_create(MaxXLDocument * doc, BBString * filename, int forceOverwrite);
	MaxXLWorkbook * bmx_openxlsx_xldocument_workbook(MaxXLDocument * doc);
	void bmx_openxlsx_xldocument_save(MaxXLDocument * doc);
	void bmx_openxlsx_xldocument_saveas(MaxXLDocument * doc, BBString * filename, int forceOverwrite);
	void bmx_openxlsx_xldocument_close(MaxXLDocument * doc);
	BBString * bmx_openxlsx_xldocument_name(MaxXLDocument * doc);
	BBString * bmx_openxlsx_xldocument_path(MaxXLDocument * doc);
	BBString * bmx_openxlsx_xldocument_property(MaxXLDocument * doc, int property);
	void bmx_openxlsx_xldocument_setproperty(MaxXLDocument * doc, int property, BBString * value);
	void bmx_openxlsx_xldocument_deleteproperty(MaxXLDocument * doc, int property);
	int bmx_openxlsx_xldocument_isopen(MaxXLDocument * doc);

	MaxXLWorkSheet * bmx_openxlsx_xlworkbook_worksheet(MaxXLWorkbook * workbook, BBString * name);
	void bmx_openxlsx_xlworkbook_free(MaxXLWorkbook * workbook);
	BBArray * bmx_openxlsx_xlworkbook_worksheetnames(MaxXLWorkbook * workbook);
	void bmx_openxlsx_xlworkbook_addworksheet(MaxXLWorkbook * workbook, BBString * name);
	void bmx_openxlsx_xlworkbook_deletesheet(MaxXLWorkbook * workbook, BBString * name);
	void bmx_openxlsx_xlworkbook_clonesheet(MaxXLWorkbook * workbook, BBString * name, BBString * newName);
	void bmx_openxlsx_xlworkbook_setsheetindex(MaxXLWorkbook * workbook, BBString * name, unsigned int index);
	unsigned int bmx_openxlsx_xlworkbook_indexofsheet(MaxXLWorkbook * workbook, BBString * name);
	int bmx_openxlsx_xlworkbook_typeofsheet(MaxXLWorkbook * workbook, BBString * name);
	int bmx_openxlsx_xlworkbook_typeofsheetbyindex(MaxXLWorkbook * workbook, unsigned int index);
	int bmx_openxlsx_xlworkbook_worksheetexists(MaxXLWorkbook * workbook, BBString * name);

	void bmx_openxlsx_xlworksheet_free(MaxXLWorkSheet * worksheet);
	MaxXLCell * bmx_openxlsx_xlworksheet_cell(MaxXLWorkSheet * worksheet, BBString * cellRef);
	MaxXLCell * bmx_openxlsx_xlworksheet_cell_ref(MaxXLWorkSheet * worksheet, MaxXLCellReference * cellRef);
	int bmx_openxlsx_xlworksheet_visibility(MaxXLWorkSheet * worksheet);
	void bmx_openxlsx_xlworksheet_setvisibility(MaxXLWorkSheet * worksheet, int state);
	SColor8 bmx_openxlsx_xlworksheet_color(MaxXLWorkSheet * worksheet);
	void bmx_openxlsx_xlworksheet_setcolor(MaxXLWorkSheet * worksheet, SColor8 color);
	unsigned short bmx_openxlsx_xlworksheet_index(MaxXLWorkSheet * worksheet);
	void bmx_openxlsx_xlworksheet_setindex(MaxXLWorkSheet * worksheet, unsigned short index);
	BBString * bmx_openxlsx_xlworksheet_name(MaxXLWorkSheet * worksheet);
	void bmx_openxlsx_xlworksheet_setname(MaxXLWorkSheet * worksheet, BBString * name);
	int bmx_openxlsx_xlworksheet_isselected(MaxXLWorkSheet * worksheet);
	void bmx_openxlsx_xlworksheet_setselected(MaxXLWorkSheet * worksheet, int selected);
	int bmx_openxlsx_xlworksheet_isactive(MaxXLWorkSheet * worksheet);
	void bmx_openxlsx_xlworksheet_setactive(MaxXLWorkSheet * worksheet);
	void bmx_openxlsx_xlworksheet_clone(MaxXLWorkSheet * worksheet, BBString * newName);
	MaxXLCellRange * bmx_openxlsx_xlworksheet_range(MaxXLWorkSheet * worksheet);
	MaxXLCellRange * bmx_openxlsx_xlworksheet_range_str(MaxXLWorkSheet * worksheet, BBString * topLeft, BBString * bottomRight);
	MaxXLCellRange * bmx_openxlsx_xlworksheet_range_ref(MaxXLWorkSheet * worksheet, MaxXLCellReference * topLeft, MaxXLCellReference * bottomRight);
	MaxXLRow * bmx_openxlsx_xlworksheet_row(MaxXLWorkSheet * worksheet, unsigned int rowNumber);
	MaxXLRowRange * bmx_openxlsx_xlworksheet_rows(MaxXLWorkSheet * worksheet);
	MaxXLRowRange * bmx_openxlsx_xlworksheet_rows_count(MaxXLWorkSheet * worksheet, unsigned int rowCount);
	MaxXLRowRange * bmx_openxlsx_xlworksheet_rows_range(MaxXLWorkSheet * worksheet, unsigned int firstRow, unsigned int lastRow);
	MaxXLColumn * bmx_openxlsx_xlworksheet_column(MaxXLWorkSheet * worksheet, unsigned short columnNumber);
	MaxXLColumn * bmx_openxlsx_xlworksheet_column_str(MaxXLWorkSheet * worksheet, BBString * columnRef);
	MaxXLCell * bmx_openxlsx_xlworksheet_lastcell(MaxXLWorkSheet * worksheet);
	unsigned short bmx_openxlsx_xlworksheet_columncount(MaxXLWorkSheet * worksheet);
	unsigned int bmx_openxlsx_xlworksheet_rowcount(MaxXLWorkSheet * worksheet);
	void bmx_openxlsx_xlworksheet_deleterow(MaxXLWorkSheet * worksheet, unsigned int rowNumber);
	void bmx_openxlsx_xlworksheet_updatesheetname(MaxXLWorkSheet * worksheet, BBString * oldName, BBString * newName);
	int bmx_openxlsx_xlworksheet_protectsheet(MaxXLWorkSheet * worksheet, int set);
	int bmx_openxlsx_xlworksheet_protectobjects(MaxXLWorkSheet * worksheet, int set);
	int bmx_openxlsx_xlworksheet_protectscenarios(MaxXLWorkSheet * worksheet, int set);
	int bmx_openxlsx_xlworksheet_allowinsertcolumns(MaxXLWorkSheet * worksheet, int set);
	int bmx_openxlsx_xlworksheet_allowinsertrows(MaxXLWorkSheet * worksheet, int set);
	int bmx_openxlsx_xlworksheet_allowdeletecolumns(MaxXLWorkSheet * worksheet, int set);
	int bmx_openxlsx_xlworksheet_allowdeleterows(MaxXLWorkSheet * worksheet, int set);
	int bmx_openxlsx_xlworksheet_allowselectlockedcells(MaxXLWorkSheet * worksheet, int set);
	int bmx_openxlsx_xlworksheet_allowselectunlockedcells(MaxXLWorkSheet * worksheet, int set);
	int bmx_openxlsx_xlworksheet_setpasswordhash(MaxXLWorkSheet * worksheet, BBString * hash);
	int bmx_openxlsx_xlworksheet_setpassword(MaxXLWorkSheet * worksheet, BBString * password);
	int bmx_openxlsx_xlworksheet_clearpassword(MaxXLWorkSheet * worksheet);
	int bmx_openxlsx_xlworksheet_clearsheetprotection(MaxXLWorkSheet * worksheet);
	int bmx_openxlsx_xlworksheet_sheetprotected(MaxXLWorkSheet * worksheet);
	int bmx_openxlsx_xlworksheet_objectsprotected(MaxXLWorkSheet * worksheet);
	int bmx_openxlsx_xlworksheet_scenariosprotected(MaxXLWorkSheet * worksheet);
	int bmx_openxlsx_xlworksheet_insertcolumnsallowed(MaxXLWorkSheet * worksheet);
	int bmx_openxlsx_xlworksheet_insertrowsallowed(MaxXLWorkSheet * worksheet);
	int bmx_openxlsx_xlworksheet_deletecolumnsallowed(MaxXLWorkSheet * worksheet);
	int bmx_openxlsx_xlworksheet_deleterowsallowed(MaxXLWorkSheet * worksheet);
	int bmx_openxlsx_xlworksheet_selectlockedcellsallowed(MaxXLWorkSheet * worksheet);
	int bmx_openxlsx_xlworksheet_selectunlockedcellsallowed(MaxXLWorkSheet * worksheet);
	BBString * bmx_openxlsx_xlworksheet_passwordhash(MaxXLWorkSheet * worksheet);
	int bmx_openxlsx_xlworksheet_passwordisset(MaxXLWorkSheet * worksheet);
	void bmx_openxlsx_xlworksheet_mergecells(MaxXLWorkSheet * worksheet, MaxXLCellRange * range, int emptyHiddenCells);
	void bmx_openxlsx_xlworksheet_mergecells_str(MaxXLWorkSheet * worksheet, BBString * range, int emptyHiddenCells);
	void bmx_openxlsx_xlworksheet_unmergecells(MaxXLWorkSheet * worksheet, MaxXLCellRange * range);
	void bmx_openxlsx_xlworksheet_unmergecells_str(MaxXLWorkSheet * worksheet, BBString * range);

	void bmx_openxlsx_xlcell_free(MaxXLCell * cell);
	void bmx_openxlsx_xlcell_setvalue_double(MaxXLCell * cell, double value);
	void bmx_openxlsx_xlcell_setvalue_long(MaxXLCell * cell, BBLONG value);
	void bmx_openxlsx_xlcell_setvalue_ulong(MaxXLCell * cell, BBULONG value);
	void bmx_openxlsx_xlcell_setvalue_string(MaxXLCell * cell, BBString * value);
	void bmx_openxlsx_xlcell_setvalue_bool(MaxXLCell * cell, int value);
	double bmx_openxlsx_xlcell_getvalue_double(MaxXLCell * cell);
	BBLONG bmx_openxlsx_xlcell_getvalue_long(MaxXLCell * cell);
	BBULONG bmx_openxlsx_xlcell_getvalue_ulong(MaxXLCell * cell);
	BBString * bmx_openxlsx_xlcell_getvalue_string(MaxXLCell * cell);
	int bmx_openxlsx_xlcell_getvalue_bool(MaxXLCell * cell);
	BBString * bmx_openxlsx_xlcell_typeasstring(MaxXLCell * cell);
	int bmx_openxlsx_xlcell_type(MaxXLCell * cell);
	void bmx_openxlsx_xlcell_setvalue_cell(MaxXLCell * cell, MaxXLCell * value);
	int bmx_openxlsx_xlcell_hasformula(MaxXLCell * cell);
	BBString * bmx_openxlsx_xlcell_formula(MaxXLCell * cell);
	void bmx_openxlsx_xlcell_setformula(MaxXLCell * cell, BBString * formula);
	void bmx_openxlsx_xlcell_clearformula(MaxXLCell * cell);
	int bmx_openxlsx_xlcell_empty(MaxXLCell * cell);
	int bmx_openxlsx_xlcell_valuetype(MaxXLCell * cell);

	MaxXLCellReference * bmx_openxlsx_xlcellreference_new_celladdress(BBString * cellAddress);
	MaxXLCellReference * bmx_openxlsx_xlcellreference_new_rowcolumn(unsigned int row, unsigned short column);
	MaxXLCellReference * bmx_openxlsx_xlcellreference_new_rowcolumn_str(unsigned int row, BBString * column);
	void bmx_openxlsx_xlcellreference_free(MaxXLCellReference * cellReference);
	unsigned int bmx_openxlsx_xlcellreference_row(MaxXLCellReference * cellReference);
	void bmx_openxlsx_xlcellreference_setrow(MaxXLCellReference * cellReference, unsigned int row);
	unsigned short bmx_openxlsx_xlcellreference_column(MaxXLCellReference * cellReference);
	void bmx_openxlsx_xlcellreference_setcolumn(MaxXLCellReference * cellReference, unsigned short column);
	void bmx_openxlsx_xlcellreference_setrowcolumn(MaxXLCellReference * cellReference, unsigned int row, unsigned short column);
	BBString * bmx_openxlsx_xlcellreference_address(MaxXLCellReference * cellReference);
	void bmx_openxlsx_xlcellreference_setaddress(MaxXLCellReference * cellReference, BBString * address);

	void bmx_openxlsx_xlcellrange_free(MaxXLCellRange * cellRange);
	BBString * bmx_openxlsx_xlcellrange_address(MaxXLCellRange * cellRange);
	MaxXLCellReference * bmx_openxlsx_xlcellrange_topleft(MaxXLCellRange * cellRange);
	MaxXLCellReference * bmx_openxlsx_xlcellrange_bottomright(MaxXLCellRange * cellRange);
	unsigned int bmx_openxlsx_xlcellrange_numrows(MaxXLCellRange * cellRange);
	unsigned short bmx_openxlsx_xlcellrange_numcolumns(MaxXLCellRange * cellRange);
	MaxXLCellRangeIterator * bmx_openxlsx_xlcellrange_iterator(MaxXLCellRange * cellRange);
	BBULONG bmx_openxlsx_xlcellrange_distance(MaxXLCellRange * cellRange);

	void bmx_openxlsx_xlcellrange_iterator_free(MaxXLCellRangeIterator * iter);
	int bmx_openxlsx_xlcellrange_iterator_hasnext(MaxXLCellRangeIterator * iter);
	MaxXLCell * bmx_openxlsx_xlcellrange_iterator_next(MaxXLCellRangeIterator * iter);

	void bmx_openxlsx_xlrow_free(MaxXLRow * row);
	int bmx_openxlsx_xlrow_empty(MaxXLRow * row);
	float bmx_openxlsx_xlrow_height(MaxXLRow * row);
	void bmx_openxlsx_xlrow_setheight(MaxXLRow * row, float height);
	float bmx_openxlsx_xlrow_descent(MaxXLRow * row);
	void bmx_openxlsx_xlrow_setdescent(MaxXLRow * row, float descent);
	int bmx_openxlsx_xlrow_ishidden(MaxXLRow * row);
	void bmx_openxlsx_xlrow_sethidden(MaxXLRow * row, int state);
	unsigned int bmx_openxlsx_xlrow_rownumber(MaxXLRow * row);
	unsigned short bmx_openxlsx_xlrow_cellcount(MaxXLRow * row);
	MaxXLRowDataRange * bmx_openxlsx_xlrow_cells(MaxXLRow * row);
	MaxXLRowDataRange * bmx_openxlsx_xlrow_cells_count(MaxXLRow * row, unsigned short cellCount);
	MaxXLRowDataRange * bmx_openxlsx_xlrow_cells_range(MaxXLRow * row, unsigned short firstCell, unsigned short lastCell);

	void bmx_openxlsx_xlrowrange_free(MaxXLRowRange * rowRange);
	unsigned int bmx_openxlsx_xlrowrange_rowcount(MaxXLRowRange * rowRange);
	MaxXLRowIterator * bmx_openxlsx_xlrowrange_iterator(MaxXLRowRange * rowRange);

	void bmx_openxlsx_xlrowrange_iterator_free(MaxXLRowIterator * iter);
	int bmx_openxlsx_xlrowrange_iterator_hasnext(MaxXLRowIterator * iter);
	MaxXLRow * bmx_openxlsx_xlrowrange_iterator_next(MaxXLRowIterator * iter);

	void bmx_openxlsx_xlrowdatarange_free(MaxXLRowDataRange * rowDataRange);
	MaxXLRowDataIterator * bmx_openxlsx_xlrowdatarange_iterator(MaxXLRowDataRange * rowDataRange);

	void bmx_openxlsx_xlrowdatarange_iterator_free(MaxXLRowDataIterator * iter);
	int bmx_openxlsx_xlrowdatarange_iterator_hasnext(MaxXLRowDataIterator * iter);
	MaxXLCell * bmx_openxlsx_xlrowdatarange_iterator_next(MaxXLRowDataIterator * iter);

	void bmx_openxlsx_xlcolumn_free(MaxXLColumn * column);
	float bmx_openxlsx_xlcolumn_width(MaxXLColumn * column);
	void bmx_openxlsx_xlcolumn_setwidth(MaxXLColumn * column, float width);
	int bmx_openxlsx_xlcolumn_ishidden(MaxXLColumn * column);
	void bmx_openxlsx_xlcolumn_sethidden(MaxXLColumn * column, int state);
}

///////////////////////////////////////////////////////////

static inline std::string toStdString(BBString * str) {
	char* c = (char*)bbStringToUTF8String(str);
	std::string result(c);
	bbMemFree(c);
	return result;
}

static inline BBString * fromStdString(const std::string& str) {
	if (str.empty()) {
		return &bbEmptyString;
	}
	return bbStringFromUTF8String((unsigned char*)str.c_str());
}

static inline BBString * fromStdStringView(const std::string_view& str) {
	if (str.empty()) {
		return &bbEmptyString;
	}
	printf("fromStdStringView: str = '%.*s'\n", (int)str.size(), str.data());
	return bbStringFromUTF8String((unsigned char*)str.data());
}

///////////////////////////////////////////////////////////

static inline void throwXLException(const OpenXLSX::XLException& e) {
	BBString * err = fromStdString(e.what());
	bbExThrow(text_xlsx_TXLException__Create(err));
}

static inline void throwXLRuntimeError(const std::runtime_error& e) {
	BBString * err = fromStdString(e.what());
	bbExThrow(text_xlsx_TXLRuntimeError__Create(err));
}

static inline void throwXLValueTypeError(const OpenXLSX::XLValueTypeError& e) {
	BBString * err = fromStdString(e.what());
	bbExThrow(text_xlsx_TXLValueTypeError__Create(err));
}

static inline void throwXLCellAddressError(const OpenXLSX::XLCellAddressError& e) {
	BBString * err = fromStdString(e.what());
	bbExThrow(text_xlsx_TXLCellAddressError__Create(err));
}

static inline void throwXLInputError(const OpenXLSX::XLInputError& e) {
	BBString * err = fromStdString(e.what());
	bbExThrow(text_xlsx_TXLInputError__Create(err));
}

static inline void throwXLPropertyError(const OpenXLSX::XLPropertyError& e) {
	BBString * err = fromStdString(e.what());
	bbExThrow(text_xlsx_TXLPropertyError__Create(err));
}

///////////////////////////////////////////////////////////

class MaxXLCellReference
{
public:
	MaxXLCellReference(OpenXLSX::XLCellReference ref) : ref(ref) {
	}

	unsigned int row() const {
		return ref.row();
	}

	void setRow(unsigned int row) {
		ref.setRow(row);
	}

	unsigned short column() const {
		return ref.column();
	}

	void setColumn(unsigned short column) {
		ref.setColumn(column);
	}

	void setRowAndColumn(unsigned int row, unsigned short column) {
		ref.setRowAndColumn(row, column);
	}

	BBString * address() const {
		return fromStdString(ref.address());
	}

	void setAddress(BBString * address) {
		std::string addr = toStdString(address);
		ref.setAddress(addr);
	}

	OpenXLSX::XLCellReference ref;
};

///////////////////////////////////////////////////////////

class MaxXLCell
{
public:

	MaxXLCell(OpenXLSX::XLCell cell) : cell(cell) {
	}

	void setValueDouble(double value) {
		cell.value().set(value);
	}

	void setValueLong(BBLONG value) {
		cell.value().set(value);
	}

	void setValueULong(BBULONG value) {
		cell.value().set(value);
	}

	void setValueString(BBString * value) {
		std::string str = toStdString(value);
		cell.value().set(str);
	}

	void setValueBool(int value) {
		cell.value().set((bool)value);
	}

	double getValueDouble() const {
		try
		{
			return cell.value().get<double>();
		}
		catch(const OpenXLSX::XLValueTypeError& e)
		{
			throwXLValueTypeError(e);
		}
		return 0.0;
	}

	BBLONG getValueLong() const {
		try
		{
			return cell.value().get<int64_t>();
		}
		catch(const OpenXLSX::XLValueTypeError& e)
		{
			throwXLValueTypeError(e);
		}
		return 0;
	}

	BBULONG getValueULong() const {
		try
		{
			return cell.value().get<uint64_t>();
		}
		catch(const OpenXLSX::XLValueTypeError& e)
		{
			throwXLValueTypeError(e);
		}
		return 0;
	}

	BBString * getValueString() const {
		try
		{
			std::string str = cell.value().get<std::string>();
			return fromStdString(str);
		}
		catch(const OpenXLSX::XLValueTypeError& e)
		{
			throwXLValueTypeError(e);
		}
		return &bbEmptyString;
	}

	int getValueBool() const {
		try
		{
			return cell.value().get<bool>() ? 1 : 0;
		}
		catch(const OpenXLSX::XLValueTypeError& e)
		{
			throwXLValueTypeError(e);
		}
		return 0;
	}

	BBString * typeAsString() const {
		return fromStdString(cell.value().typeAsString());
	}

	void setValueCell(MaxXLCell * value) {
		cell.value() = value->cell.value();
	}

	int hasFormula() const {
		return cell.hasFormula() ? 1 : 0;
	}

	BBString * formula() const {
		if ( cell.hasFormula() ) {
			std::string f = cell.formula();
			return fromStdString(f);
		}
		return &bbEmptyString;
	}

	void setFormula(BBString * formula) {
		std::string f = toStdString(formula);
		cell.formula() = f;
	}

	void clearFormula() {
		cell.formula().clear();
	}

	int empty() const {
		return cell.empty() ? 1 : 0;
	}

	int type() const {
		return (int)cell.value().type();
	}

	OpenXLSX::XLCell cell;
};

///////////////////////////////////////////////////////////

class MaxXLCellRangeIterator
{
public:
	MaxXLCellRangeIterator(OpenXLSX::XLCellRange range) : iter(range.begin()), end(range.end()) {
	}

	int hasNext() const {
		return iter != end ? 1 : 0;
	}

	MaxXLCell * next() {
		if (iter == end) {
			return nullptr;
		}
		auto cell = *iter;
		++iter;
		return new MaxXLCell(cell);
	}

	OpenXLSX::XLCellIterator iter;
	OpenXLSX::XLCellIterator end;
};

///////////////////////////////////////////////////////////

class MaxXLCellRange
{
public:
	MaxXLCellRange(OpenXLSX::XLCellRange range) : range(range) {
	}

	BBString * address() const {
		return fromStdString(range.address());
	}

	MaxXLCellReference * topLeft() const {
		return new MaxXLCellReference(range.topLeft());
	}

	MaxXLCellReference * bottomRight() const {
		return new MaxXLCellReference(range.bottomRight());
	}

	unsigned int numRows() const {
		return range.numRows();
	}

	unsigned short numColumns() const {
		return range.numColumns();
	}

	MaxXLCellRangeIterator * iterator() {
		return new MaxXLCellRangeIterator(range);
	}

	BBULONG distance() const {
		return std::distance(range.begin(), range.end());
	}

	OpenXLSX::XLCellRange range;
};

///////////////////////////////////////////////////////////

class MaxXLRowDataIterator
{
public:
	MaxXLRowDataIterator(OpenXLSX::XLRowDataRange range) : iter(range.begin()), end(range.end()) {
	}

	int hasNext() const {
		return iter != end ? 1 : 0;
	}

	MaxXLCell * next() {
		if (iter == end) {
			return nullptr;
		}
		auto cell = *iter;
		++iter;
		return new MaxXLCell(cell);
	}

	OpenXLSX::XLRowDataIterator iter;
	OpenXLSX::XLRowDataIterator end;
};

///////////////////////////////////////////////////////////

class MaxXLRowDataRange
{
public:
	MaxXLRowDataRange(OpenXLSX::XLRowDataRange range) : range(range) {
	}

	MaxXLRowDataIterator * iterator() {
		return new MaxXLRowDataIterator(range);
	}

	OpenXLSX::XLRowDataRange range;
};

///////////////////////////////////////////////////////////

class MaxXLRow
{
public:
	MaxXLRow(OpenXLSX::XLRow row) : row(row) {
	}

	int empty() const {
		return row.empty() ? 1 : 0;
	}

	float height() const {
		return (float)row.height();
	}

	void setHeight(float height) {
		row.setHeight(height);
	}

	float descent() const {
		return row.descent();
	}

	void setDescent(float descent) {
		row.setDescent(descent);
	}

	int isHidden() const {
		return row.isHidden() ? 1 : 0;
	}

	void setHidden(int state) {
		row.setHidden((bool)state);
	}

	unsigned int rowNumber() const {
		return row.rowNumber();
	}

	unsigned short cellCount() const {
		return row.cellCount();
	}

	MaxXLRowDataRange * cells() {
		return new MaxXLRowDataRange(row.cells());
	}

	MaxXLRowDataRange * cells(unsigned short cellCount) {
		return new MaxXLRowDataRange(row.cells(cellCount));
	}

	MaxXLRowDataRange * cells(unsigned short firstCell, unsigned short lastCell) {
		return new MaxXLRowDataRange(row.cells(firstCell, lastCell));
	}

	OpenXLSX::XLRow row;
};

///////////////////////////////////////////////////////////

class MaxXLRowIterator
{
public:
	MaxXLRowIterator(OpenXLSX::XLRowRange range) : iter(range.begin()), end(range.end()) {
	}

	int hasNext() const {
		return iter != end ? 1 : 0;
	}

	MaxXLRow * next() {
		if (iter == end) {
			return nullptr;
		}
		auto row = *iter;
		++iter;
		return new MaxXLRow(row);
	}

	OpenXLSX::XLRowIterator iter;
	OpenXLSX::XLRowIterator end;
};

///////////////////////////////////////////////////////////

class MaxXLRowRange
{
public:
	MaxXLRowRange(OpenXLSX::XLRowRange range) : range(range) {
	}

	unsigned int rowCount() const {
		return range.rowCount();
	}

	MaxXLRowIterator * iterator() {
		return new MaxXLRowIterator(range);
	}

	OpenXLSX::XLRowRange range;
};

///////////////////////////////////////////////////////////

class MaxXLColumn
{
public:
	MaxXLColumn(OpenXLSX::XLColumn column) : column(column) {
	}

	float width() const {
		return column.width();
	}

	void setWidth(float width) {
		column.setWidth(width);
	}

	int isHidden() const {
		return column.isHidden() ? 1 : 0;
	}

	void setHidden(int state) {
		column.setHidden((bool)state);
	}

	OpenXLSX::XLColumn column;
};

///////////////////////////////////////////////////////////

class MaxXLWorkSheet
{
public:

	MaxXLWorkSheet(OpenXLSX::XLWorksheet worksheet) : worksheet(worksheet) {
	}

	MaxXLCell * cell(BBString * cellRef) {
		std::string ref = toStdString(cellRef);
		return new MaxXLCell(worksheet.cell(ref));
	}

	MaxXLCell * cell(MaxXLCellReference * cellRef) {
		return new MaxXLCell(worksheet.cell(cellRef->ref));
	}

	int visibility() const {
		return (int)worksheet.visibility();
	}

	void setVisibility(int state) {
		worksheet.setVisibility((OpenXLSX::XLSheetState)state);
	}

	SColor8 color() const {
		OpenXLSX::XLColor c = worksheet.color();
		return SColor8{c.blue(), c.green(), c.red(), c.alpha()};
	}

	void setColor(SColor8 color) {
		worksheet.setColor(OpenXLSX::XLColor(color.a, color.r, color.g, color.b));
	}

	unsigned short index() const {
		return worksheet.index();
	}

	void setIndex(unsigned short index) {
		worksheet.setIndex(index);
	}

	BBString * name() const {
		return fromStdString(worksheet.name());
	}

	void setName(BBString * name) {
		std::string n = toStdString(name);
		worksheet.setName(n);
	}

	int isSelected() const {
		return (int)worksheet.isSelected();
	}

	void setSelected(int selected) {
		worksheet.setSelected((bool)selected);
	}

	int isActive() const {
		return (int)worksheet.isActive();
	}

	void setActive() {
		worksheet.setActive();
	}

	void clone(BBString * newName) {
		std::string nn = toStdString(newName);
		worksheet.clone(nn);
	}

	MaxXLCellRange * range() {
		return new MaxXLCellRange(worksheet.range());
	}

	MaxXLCellRange * range(BBString * topLeft, BBString * bottomRight) {
		std::string tl = toStdString(topLeft);
		std::string br = toStdString(bottomRight);
		return new MaxXLCellRange(worksheet.range(tl, br));
	}

	MaxXLCellRange * range(MaxXLCellReference * topLeft, MaxXLCellReference * bottomRight) {
		return new MaxXLCellRange(worksheet.range(topLeft->ref, bottomRight->ref));
	}

	MaxXLRow * row(unsigned int rowNumber) {
		return new MaxXLRow(worksheet.row(rowNumber));
	}

	MaxXLRowRange * rows() {
		return new MaxXLRowRange(worksheet.rows());
	}

	MaxXLRowRange * rows(unsigned int rowCount) {
		return new MaxXLRowRange(worksheet.rows(rowCount));
	}

	MaxXLRowRange * rows(unsigned int firstRow, unsigned int lastRow) {
		return new MaxXLRowRange(worksheet.rows(firstRow, lastRow));
	}

	MaxXLColumn * column(unsigned short columnNumber) {
		return new MaxXLColumn(worksheet.column(columnNumber));
	}

	MaxXLColumn * column(BBString * columnRef) {
		std::string cr = toStdString(columnRef);
		return new MaxXLColumn(worksheet.column(cr));
	}

	MaxXLCell * lastCell() {
		return new MaxXLCell(worksheet.cell(worksheet.lastCell()));
	}

	unsigned short columnCount() const {
		return worksheet.columnCount();
	}

	unsigned int rowCount() const {
		return worksheet.rowCount();
	}

	void deleteRow(unsigned int rowNumber) {
		worksheet.deleteRow(rowNumber);
	}

	void updateSheetName(BBString * oldName, BBString * newName) {
		std::string on = toStdString(oldName);
		std::string nn = toStdString(newName);
		worksheet.updateSheetName(on, nn);
	}

	int protectSheet(int set) {
		return worksheet.protectSheet((bool)set) ? 1 : 0;
	}

	int protectObjects(int set) {
		return worksheet.protectObjects((bool)set) ? 1 : 0;
	}

	int protectScenarios(int set) {
		return worksheet.protectScenarios((bool)set) ? 1 : 0;
	}

	int allowInsertColumns(int set) {
		return worksheet.allowInsertColumns((bool)set) ? 1 : 0;
	}

	int allowInsertRows(int set) {
		return worksheet.allowInsertRows((bool)set) ? 1 : 0;
	}

	int allowDeleteColumns(int set) {
		return worksheet.allowDeleteColumns((bool)set) ? 1 : 0;
	}

	int allowDeleteRows(int set) {
		return worksheet.allowDeleteRows((bool)set) ? 1 : 0;
	}

	int allowSelectLockedCells(int set) {
		return worksheet.allowSelectLockedCells((bool)set) ? 1 : 0;
	}

	int allowSelectUnlockedCells(int set) {
		return worksheet.allowSelectUnlockedCells((bool)set) ? 1 : 0;
	}

	int setPasswordHash(BBString * hash) {
		std::string h = toStdString(hash);
		return worksheet.setPasswordHash(h) ? 1 : 0;
	}

	int setPassword(BBString * password) {
		std::string p = toStdString(password);
		return worksheet.setPassword(p) ? 1 : 0;
	}

	int clearPassword() {
		return worksheet.clearPassword() ? 1 : 0;
	}

	int clearSheetProtection() {
		return worksheet.clearSheetProtection() ? 1 : 0;
	}

	int sheetProtected() {
		return worksheet.sheetProtected() ? 1 : 0;
	}

	int objectsProtected() {
		return worksheet.objectsProtected() ? 1 : 0;
	}

	int scenariosProtected() {
		return worksheet.scenariosProtected() ? 1 : 0;
	}

	int insertColumnsAllowed() {
		return worksheet.insertColumnsAllowed() ? 1 : 0;
	}

	int insertRowsAllowed() {
		return worksheet.insertRowsAllowed() ? 1 : 0;
	}

	int deleteColumnsAllowed() {
		return worksheet.deleteColumnsAllowed() ? 1 : 0;
	}

	int deleteRowsAllowed() {
		return worksheet.deleteRowsAllowed() ? 1 : 0;
	}

	int selectLockedCellsAllowed() {
		return worksheet.selectLockedCellsAllowed() ? 1 : 0;
	}

	int selectUnlockedCellsAllowed() {
		return worksheet.selectUnlockedCellsAllowed() ? 1 : 0;
	}

	BBString * passwordHash() {
		return fromStdString(worksheet.passwordHash());
	}

	int passwordIsSet() {
		return worksheet.passwordIsSet() ? 1 : 0;
	}

	void mergeCells(MaxXLCellRange * range, int emptyHiddenCells) {
		worksheet.mergeCells(range->range, (bool)emptyHiddenCells);
	}

	void mergeCells(BBString * range, int emptyHiddenCells) {
		std::string r = toStdString(range);
		worksheet.mergeCells(r, (bool)emptyHiddenCells);
	}

	void unmergeCells(MaxXLCellRange * range) {
		worksheet.unmergeCells(range->range);
	}

	void unmergeCells(BBString * range) {
		std::string r = toStdString(range);
		worksheet.unmergeCells(r);
	}

	OpenXLSX::XLWorksheet worksheet;
};

///////////////////////////////////////////////////////////

class MaxXLWorkbook
{
public:

	MaxXLWorkbook(OpenXLSX::XLWorkbook workbook) : workbook(workbook) {
	}

	OpenXLSX::XLWorkbook workbook;

	MaxXLWorkSheet * worksheet(BBString* name) {
		try
		{
			std::string n = toStdString(name);
			MaxXLWorkSheet * sheet = new MaxXLWorkSheet(workbook.worksheet(n));
			return sheet;
		}
		catch (const OpenXLSX::XLInputError& e)
		{
			throwXLInputError(e);
		}
	}

	void addWorksheet(BBString* name) {
		try
		{
			std::string n = toStdString(name);
			workbook.addWorksheet(n);
		}
		catch (const OpenXLSX::XLInputError& e)
		{
			throwXLInputError(e);
		}
	}

	void deleteSheet(BBString* name) {
		try
		{
			std::string n = toStdString(name);
			workbook.deleteSheet(n);
		}
		catch (const OpenXLSX::XLInputError& e)
		{
			throwXLInputError(e);
		}
	}

	void cloneSheet(BBString* name, BBString* newName) {
		try
		{
			std::string n = toStdString(name);
			std::string nn = toStdString(newName);
			workbook.cloneSheet(n, nn);
		}
		catch (const OpenXLSX::XLInputError& e)
		{
			throwXLInputError(e);
		}
	}

	void setSheetIndex(BBString* name, unsigned int index) {
		try
		{
			std::string n = toStdString(name);
			workbook.setSheetIndex(n, index);
		}
		catch (const OpenXLSX::XLInputError& e)
		{
			throwXLInputError(e);
		}
	}

	unsigned int indexOfSheet(BBString* name) {
		try
		{
			std::string n = toStdString(name);
			return workbook.indexOfSheet(n);
		}
		catch (const OpenXLSX::XLInputError& e)
		{
			throwXLInputError(e);
		}
		return 0;
	}

	int typeOfSheet(BBString* name) {
		try
		{
			std::string n = toStdString(name);
			return (int)workbook.typeOfSheet(n);
		}
		catch (const OpenXLSX::XLInputError& e)
		{
			throwXLInputError(e);
		}
		return 0;
	}

	int typeOfSheetByIndex(unsigned int index) {
		try
		{
			return (int)workbook.typeOfSheet(index);
		}
		catch (const OpenXLSX::XLInputError& e)
		{
			throwXLInputError(e);
		}
		return 0;
	}

	int worksheetExists(BBString* name) {
		try
		{
			std::string n = toStdString(name);
			return workbook.worksheetExists(n) ? 1 : 0;
		}
		catch (const OpenXLSX::XLInputError& e)
		{
			throwXLInputError(e);
		}
		return 0;
	}
};

///////////////////////////////////////////////////////////

class MaxXLDocument
{
public:
	MaxXLDocument() {
		doc = new OpenXLSX::XLDocument();
	}

	~MaxXLDocument() {
		delete doc;
	}

	MaxXLWorkbook * workbook() {
		return new MaxXLWorkbook(doc->workbook());
	}

	void open(BBString* filename) {
		std::string n = toStdString(filename);
		try {
			doc->open(n);
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		catch (const std::runtime_error& e)
		{
			throwXLRuntimeError(e);
		}
	}

	void create(BBString* filename, int forceOverwrite) {
		std::string n = toStdString(filename);
		try {
			doc->create(n, (bool)forceOverwrite);
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		catch (const std::runtime_error& e)
		{
			throwXLRuntimeError(e);
		}
	}

	void save() {
		try {
			doc->save();
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		catch (const std::runtime_error& e)
		{
			throwXLRuntimeError(e);
		}
	}

	void saveAs(BBString* filename, int forceOverwrite) {
		std::string n = toStdString(filename);
		try {
			doc->saveAs(n, (bool)forceOverwrite);
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		catch (const std::runtime_error& e)
		{
			throwXLRuntimeError(e);
		}
	}

	void close() {
		doc->close();
	}

	BBString * name() {
		return fromStdString(doc->name());
	}

	BBString * path() {
		return fromStdString(doc->path());
	}

	BBString * property(int property) {
		return fromStdString(doc->property((OpenXLSX::XLProperty)property));
	}

	void setProperty(int property, BBString * value) {
		try {
			doc->setProperty((OpenXLSX::XLProperty)property, toStdString(value));
		}
		catch (const OpenXLSX::XLPropertyError& e)
		{
			throwXLPropertyError(e);
		}
	}

	void deleteProperty(int property) {
		doc->deleteProperty((OpenXLSX::XLProperty)property);
	}

	int isOpen() {
		return doc->isOpen() ? 1 : 0;
	}

	OpenXLSX::XLDocument * doc;
};

///////////////////////////////////////////////////////////

MaxXLDocument * bmx_openxlsx_xldocument_new() {
	return new MaxXLDocument();
}

void bmx_openxlsx_xldocument_free(MaxXLDocument * doc) {
	delete doc;
}

MaxXLWorkbook * bmx_openxlsx_xldocument_workbook(MaxXLDocument * doc) {
	return doc->workbook();
}

void bmx_openxlsx_xldocument_open(MaxXLDocument * doc, BBString * filename) {
	doc->open(filename);
}

void bmx_openxlsx_xldocument_create(MaxXLDocument * doc, BBString * filename, int forceOverwrite) {
	doc->create(filename, forceOverwrite);
}

void bmx_openxlsx_xldocument_save(MaxXLDocument * doc) {
	doc->save();
}

void bmx_openxlsx_xldocument_saveas(MaxXLDocument * doc, BBString * filename, int forceOverwrite) {
	doc->saveAs(filename, forceOverwrite);
}

void bmx_openxlsx_xldocument_close(MaxXLDocument * doc) {
	doc->close();
}

BBString * bmx_openxlsx_xldocument_name(MaxXLDocument * doc) {
	return doc->name();
}

BBString * bmx_openxlsx_xldocument_path(MaxXLDocument * doc) {
	return doc->path();
}

BBString * bmx_openxlsx_xldocument_property(MaxXLDocument * doc, int property) {
	return doc->property(property);
}

void bmx_openxlsx_xldocument_setproperty(MaxXLDocument * doc, int property, BBString * value) {
	doc->setProperty(property, value);
}

void bmx_openxlsx_xldocument_deleteproperty(MaxXLDocument * doc, int property) {
	doc->deleteProperty(property);
}

int bmx_openxlsx_xldocument_isopen(MaxXLDocument * doc) {
	doc->isOpen();
}

///////////////////////////////////////////////////////////

MaxXLWorkSheet * bmx_openxlsx_xlworkbook_worksheet(MaxXLWorkbook * workbook, BBString * name) {
	return workbook->worksheet(name);
}

void bmx_openxlsx_xlworkbook_free(MaxXLWorkbook * workbook) {
	delete workbook;
}

BBArray * bmx_openxlsx_xlworkbook_worksheetnames(MaxXLWorkbook * workbook) {
	std::vector<std::string> names = workbook->workbook.sheetNames();

	if(names.empty()) {
		return &bbEmptyArray;
	}

	BBArray * arr = bbArrayNew1D("$", names.size());
	BBString **p=(BBString**)BBARRAYDATA( arr,1 );

	for (size_t i = 0; i < names.size(); ++i) {
		p[i] = fromStdString(names[i]);
	}
	return arr;
}

void bmx_openxlsx_xlworkbook_addworksheet(MaxXLWorkbook * workbook, BBString * name) {
	workbook->addWorksheet(name);
}

void bmx_openxlsx_xlworkbook_deletesheet(MaxXLWorkbook * workbook, BBString * name) {
	workbook->deleteSheet(name);
}

void bmx_openxlsx_xlworkbook_clonesheet(MaxXLWorkbook * workbook, BBString * name, BBString * newName) {
	workbook->cloneSheet(name, newName);
}

void bmx_openxlsx_xlworkbook_setsheetindex(MaxXLWorkbook * workbook, BBString * name, unsigned int index) {
	workbook->setSheetIndex(name, index);
}

unsigned int bmx_openxlsx_xlworkbook_indexofsheet(MaxXLWorkbook * workbook, BBString * name) {
	return workbook->indexOfSheet(name);
}

int bmx_openxlsx_xlworkbook_typeofsheet(MaxXLWorkbook * workbook, BBString * name) {
	return workbook->typeOfSheet(name);
}

int bmx_openxlsx_xlworkbook_typeofsheetbyindex(MaxXLWorkbook * workbook, unsigned int index) {
	return workbook->typeOfSheetByIndex(index);
}

int bmx_openxlsx_xlworkbook_worksheetexists(MaxXLWorkbook * workbook, BBString * name) {
	return workbook->worksheetExists(name);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlworksheet_free(MaxXLWorkSheet * worksheet) {
	delete worksheet;
}

MaxXLCell * bmx_openxlsx_xlworksheet_cell(MaxXLWorkSheet * worksheet, BBString * cellRef) {
	return worksheet->cell(cellRef);
}

MaxXLCell * bmx_openxlsx_xlworksheet_cell_ref(MaxXLWorkSheet * worksheet, MaxXLCellReference * cellRef) {
	return worksheet->cell(cellRef);
}

int bmx_openxlsx_xlworksheet_visibility(MaxXLWorkSheet * worksheet) {
	return worksheet->visibility();
}

void bmx_openxlsx_xlworksheet_setvisibility(MaxXLWorkSheet * worksheet, int state) {
	worksheet->setVisibility(state);
}

SColor8 bmx_openxlsx_xlworksheet_color(MaxXLWorkSheet * worksheet) {
	return worksheet->color();
}

void bmx_openxlsx_xlworksheet_setcolor(MaxXLWorkSheet * worksheet, SColor8 color) {
	worksheet->setColor(color);
}

unsigned short bmx_openxlsx_xlworksheet_index(MaxXLWorkSheet * worksheet) {
	return worksheet->index();
}

void bmx_openxlsx_xlworksheet_setindex(MaxXLWorkSheet * worksheet, unsigned short index) {
	worksheet->setIndex(index);
}

BBString * bmx_openxlsx_xlworksheet_name(MaxXLWorkSheet * worksheet) {
	return worksheet->name();
}

void bmx_openxlsx_xlworksheet_setname(MaxXLWorkSheet * worksheet, BBString * name) {
	worksheet->setName(name);
}

int bmx_openxlsx_xlworksheet_isselected(MaxXLWorkSheet * worksheet) {
	return worksheet->isSelected();
}

void bmx_openxlsx_xlworksheet_setselected(MaxXLWorkSheet * worksheet, int selected) {
	worksheet->setSelected(selected);
}

int bmx_openxlsx_xlworksheet_isactive(MaxXLWorkSheet * worksheet) {
	return worksheet->isActive();
}

void bmx_openxlsx_xlworksheet_setactive(MaxXLWorkSheet * worksheet) {
	worksheet->setActive();
}

void bmx_openxlsx_xlworksheet_clone(MaxXLWorkSheet * worksheet, BBString * newName) {
	worksheet->clone(newName);
}

MaxXLCellRange * bmx_openxlsx_xlworksheet_range(MaxXLWorkSheet * worksheet) {
	return worksheet->range();
}

MaxXLCellRange * bmx_openxlsx_xlworksheet_range_str(MaxXLWorkSheet * worksheet, BBString * topLeft, BBString * bottomRight) {
	return worksheet->range(topLeft, bottomRight);
}

MaxXLCellRange * bmx_openxlsx_xlworksheet_range_ref(MaxXLWorkSheet * worksheet, MaxXLCellReference * topLeft, MaxXLCellReference * bottomRight) {
	return worksheet->range(topLeft, bottomRight);
}

MaxXLRow * bmx_openxlsx_xlworksheet_row(MaxXLWorkSheet * worksheet, unsigned int rowNumber) {
	return worksheet->row(rowNumber);
}

MaxXLRowRange * bmx_openxlsx_xlworksheet_rows(MaxXLWorkSheet * worksheet) {
	return worksheet->rows();
}

MaxXLRowRange * bmx_openxlsx_xlworksheet_rows_count(MaxXLWorkSheet * worksheet, unsigned int rowCount) {
	return worksheet->rows(rowCount);
}

MaxXLRowRange * bmx_openxlsx_xlworksheet_rows_range(MaxXLWorkSheet * worksheet, unsigned int firstRow, unsigned int lastRow) {
	return worksheet->rows(firstRow, lastRow);
}

MaxXLColumn * bmx_openxlsx_xlworksheet_column(MaxXLWorkSheet * worksheet, unsigned short columnNumber) {
	return worksheet->column(columnNumber);
}

MaxXLColumn * bmx_openxlsx_xlworksheet_column_str(MaxXLWorkSheet * worksheet, BBString * columnRef) {
	return worksheet->column(columnRef);
}

MaxXLCell * bmx_openxlsx_xlworksheet_lastcell(MaxXLWorkSheet * worksheet) {
	return worksheet->lastCell();
}

unsigned short bmx_openxlsx_xlworksheet_columncount(MaxXLWorkSheet * worksheet) {
	return worksheet->columnCount();
}

unsigned int bmx_openxlsx_xlworksheet_rowcount(MaxXLWorkSheet * worksheet) {
	return worksheet->rowCount();
}

void bmx_openxlsx_xlworksheet_deleterow(MaxXLWorkSheet * worksheet, unsigned int rowNumber) {
	worksheet->deleteRow(rowNumber);
}

void bmx_openxlsx_xlworksheet_updatesheetname(MaxXLWorkSheet * worksheet, BBString * oldName, BBString * newName) {
	worksheet->updateSheetName(oldName, newName);
}

int bmx_openxlsx_xlworksheet_protectsheet(MaxXLWorkSheet * worksheet, int set) {
	return worksheet->protectSheet(set);
}

int bmx_openxlsx_xlworksheet_protectobjects(MaxXLWorkSheet * worksheet, int set) {
	return worksheet->protectObjects(set);
}

int bmx_openxlsx_xlworksheet_protectscenarios(MaxXLWorkSheet * worksheet, int set) {
	return worksheet->protectScenarios(set);
}

int bmx_openxlsx_xlworksheet_allowinsertcolumns(MaxXLWorkSheet * worksheet, int set) {
	return worksheet->allowInsertColumns(set);
}

int bmx_openxlsx_xlworksheet_allowinsertrows(MaxXLWorkSheet * worksheet, int set) {
	return worksheet->allowInsertRows(set);
}

int bmx_openxlsx_xlworksheet_allowdeletecolumns(MaxXLWorkSheet * worksheet, int set) {
	return worksheet->allowDeleteColumns(set);
}

int bmx_openxlsx_xlworksheet_allowdeleterows(MaxXLWorkSheet * worksheet, int set) {
	return worksheet->allowDeleteRows(set);
}

int bmx_openxlsx_xlworksheet_allowselectlockedcells(MaxXLWorkSheet * worksheet, int set) {
	return worksheet->allowSelectLockedCells(set);
}

int bmx_openxlsx_xlworksheet_allowselectunlockedcells(MaxXLWorkSheet * worksheet, int set) {
	return worksheet->allowSelectUnlockedCells(set);
}

int bmx_openxlsx_xlworksheet_setpasswordhash(MaxXLWorkSheet * worksheet, BBString * hash) {
	return worksheet->setPasswordHash(hash);
}

int bmx_openxlsx_xlworksheet_setpassword(MaxXLWorkSheet * worksheet, BBString * password) {
	return worksheet->setPassword(password);
}

int bmx_openxlsx_xlworksheet_clearpassword(MaxXLWorkSheet * worksheet) {
	return worksheet->clearPassword();
}

int bmx_openxlsx_xlworksheet_clearsheetprotection(MaxXLWorkSheet * worksheet) {
	return worksheet->clearSheetProtection();
}

int bmx_openxlsx_xlworksheet_sheetprotected(MaxXLWorkSheet * worksheet) {
	return worksheet->sheetProtected();
}

int bmx_openxlsx_xlworksheet_objectsprotected(MaxXLWorkSheet * worksheet) {
	return worksheet->objectsProtected();
}

int bmx_openxlsx_xlworksheet_scenariosprotected(MaxXLWorkSheet * worksheet) {
	return worksheet->scenariosProtected();
}

int bmx_openxlsx_xlworksheet_insertcolumnsallowed(MaxXLWorkSheet * worksheet) {
	return worksheet->insertColumnsAllowed();
}

int bmx_openxlsx_xlworksheet_insertrowsallowed(MaxXLWorkSheet * worksheet) {
	return worksheet->insertRowsAllowed();
}

int bmx_openxlsx_xlworksheet_deletecolumnsallowed(MaxXLWorkSheet * worksheet) {
	return worksheet->deleteColumnsAllowed();
}

int bmx_openxlsx_xlworksheet_deleterowsallowed(MaxXLWorkSheet * worksheet) {
	return worksheet->deleteRowsAllowed();
}

int bmx_openxlsx_xlworksheet_selectlockedcellsallowed(MaxXLWorkSheet * worksheet) {
	return worksheet->selectLockedCellsAllowed();
}

int bmx_openxlsx_xlworksheet_selectunlockedcellsallowed(MaxXLWorkSheet * worksheet) {
	return worksheet->selectUnlockedCellsAllowed();
}

BBString * bmx_openxlsx_xlworksheet_passwordhash(MaxXLWorkSheet * worksheet) {
	return worksheet->passwordHash();
}

int bmx_openxlsx_xlworksheet_passwordisset(MaxXLWorkSheet * worksheet) {
	return worksheet->passwordIsSet();
}

void bmx_openxlsx_xlworksheet_mergecells(MaxXLWorkSheet * worksheet, MaxXLCellRange * range, int emptyHiddenCells) {
	worksheet->mergeCells(range, emptyHiddenCells);
}

void bmx_openxlsx_xlworksheet_mergecells_str(MaxXLWorkSheet * worksheet, BBString * range, int emptyHiddenCells) {
	worksheet->mergeCells(range, emptyHiddenCells);
}

void bmx_openxlsx_xlworksheet_unmergecells(MaxXLWorkSheet * worksheet, MaxXLCellRange * range) {
	worksheet->unmergeCells(range);
}

void bmx_openxlsx_xlworksheet_unmergecells_str(MaxXLWorkSheet * worksheet, BBString * range) {
	worksheet->unmergeCells(range);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlcell_free(MaxXLCell * cell) {
	delete cell;
}

void bmx_openxlsx_xlcell_setvalue_double(MaxXLCell * cell, double value) {
	cell->setValueDouble(value);
}

void bmx_openxlsx_xlcell_setvalue_long(MaxXLCell * cell, BBLONG value) {
	cell->setValueLong(value);
}

void bmx_openxlsx_xlcell_setvalue_ulong(MaxXLCell * cell, BBULONG value) {
	cell->setValueULong(value);
}

void bmx_openxlsx_xlcell_setvalue_string(MaxXLCell * cell, BBString * value) {
	cell->setValueString(value);
}

void bmx_openxlsx_xlcell_setvalue_bool(MaxXLCell * cell, int value) {
	cell->setValueBool(value);
}

double bmx_openxlsx_xlcell_getvalue_double(MaxXLCell * cell) {
	return cell->getValueDouble();
}

BBLONG bmx_openxlsx_xlcell_getvalue_long(MaxXLCell * cell) {
	return cell->getValueLong();
}

BBULONG bmx_openxlsx_xlcell_getvalue_ulong(MaxXLCell * cell) {
	return cell->getValueULong();
}

BBString * bmx_openxlsx_xlcell_getvalue_string(MaxXLCell * cell) {
	return cell->getValueString();
}

int bmx_openxlsx_xlcell_getvalue_bool(MaxXLCell * cell) {
	return cell->getValueBool();
}

BBString * bmx_openxlsx_xlcell_typeasstring(MaxXLCell * cell) {
	return cell->typeAsString();
}

int bmx_openxlsx_xlcell_type(MaxXLCell * cell) {
	return (int)cell->cell.value().type();
}

void bmx_openxlsx_xlcell_setvalue_cell(MaxXLCell * cell, MaxXLCell * value) {
	cell->setValueCell(value);
}

int bmx_openxlsx_xlcell_hasformula(MaxXLCell * cell) {
	return cell->hasFormula();
}

BBString * bmx_openxlsx_xlcell_formula(MaxXLCell * cell) {
	return cell->formula();
}

void bmx_openxlsx_xlcell_setformula(MaxXLCell * cell, BBString * formula) {
	cell->setFormula(formula);
}

void bmx_openxlsx_xlcell_clearformula(MaxXLCell * cell) {
	cell->clearFormula();
}

int bmx_openxlsx_xlcell_empty(MaxXLCell * cell) {
	return cell->empty();
}

int bmx_openxlsx_xlcell_valuetype(MaxXLCell * cell) {
	return cell->type();
}

///////////////////////////////////////////////////////////

MaxXLCellReference * bmx_openxlsx_xlcellreference_new_celladdress(BBString * cellAddress) {
	std::string addr = toStdString(cellAddress);
	return new MaxXLCellReference(OpenXLSX::XLCellReference(addr));
}

MaxXLCellReference * bmx_openxlsx_xlcellreference_new_rowcolumn(unsigned int row, unsigned short column) {
	return new MaxXLCellReference(OpenXLSX::XLCellReference(row, column));
}

MaxXLCellReference * bmx_openxlsx_xlcellreference_new_rowcolumn_str(unsigned int row, BBString * column) {
	std::string col = toStdString(column);
	return new MaxXLCellReference(OpenXLSX::XLCellReference(row, col));
}

void bmx_openxlsx_xlcellreference_free(MaxXLCellReference * cellReference) {
	delete cellReference;
}

unsigned int bmx_openxlsx_xlcellreference_row(MaxXLCellReference * cellReference) {
	return cellReference->row();
}

void bmx_openxlsx_xlcellreference_setrow(MaxXLCellReference * cellReference, unsigned int row) {
	cellReference->setRow(row);
}

unsigned short bmx_openxlsx_xlcellreference_column(MaxXLCellReference * cellReference) {
	return cellReference->column();
}

void bmx_openxlsx_xlcellreference_setcolumn(MaxXLCellReference * cellReference, unsigned short column) {
	cellReference->setColumn(column);
}

void bmx_openxlsx_xlcellreference_setrowcolumn(MaxXLCellReference * cellReference, unsigned int row, unsigned short column) {
	cellReference->setRowAndColumn(row, column);
}

BBString * bmx_openxlsx_xlcellreference_address(MaxXLCellReference * cellReference) {
	return cellReference->address();
}

void bmx_openxlsx_xlcellreference_setaddress(MaxXLCellReference * cellReference, BBString * address) {
	cellReference->setAddress(address);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlcellrange_free(MaxXLCellRange * cellRange) {
	delete cellRange;
}

BBString * bmx_openxlsx_xlcellrange_address(MaxXLCellRange * cellRange) {
	return cellRange->address();
}

MaxXLCellReference * bmx_openxlsx_xlcellrange_topleft(MaxXLCellRange * cellRange) {
	return cellRange->topLeft();
}

MaxXLCellReference * bmx_openxlsx_xlcellrange_bottomright(MaxXLCellRange * cellRange) {
	return cellRange->bottomRight();
}

unsigned int bmx_openxlsx_xlcellrange_numrows(MaxXLCellRange * cellRange) {
	return cellRange->numRows();
}
unsigned short bmx_openxlsx_xlcellrange_numcolumns(MaxXLCellRange * cellRange) {
	return cellRange->numColumns();
}

MaxXLCellRangeIterator * bmx_openxlsx_xlcellrange_iterator(MaxXLCellRange * cellRange) {
	return cellRange->iterator();
}

BBULONG bmx_openxlsx_xlcellrange_distance(MaxXLCellRange * cellRange) {
	return cellRange->distance();
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlcellrange_iterator_free(MaxXLCellRangeIterator * iter) {
	delete iter;
}

int bmx_openxlsx_xlcellrange_iterator_hasnext(MaxXLCellRangeIterator * iter) {
	return iter->hasNext();
}
MaxXLCell * bmx_openxlsx_xlcellrange_iterator_next(MaxXLCellRangeIterator * iter) {
	return iter->next();
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlrow_free(MaxXLRow * row) {
	delete row;
}

int bmx_openxlsx_xlrow_empty(MaxXLRow * row) {
	return row->empty();
}

float bmx_openxlsx_xlrow_height(MaxXLRow * row) {
	return row->height();
}

void bmx_openxlsx_xlrow_setheight(MaxXLRow * row, float height) {
	row->setHeight(height);
}

float bmx_openxlsx_xlrow_descent(MaxXLRow * row) {
	return row->descent();
}

void bmx_openxlsx_xlrow_setdescent(MaxXLRow * row, float descent) {
	row->setDescent(descent);
}

int bmx_openxlsx_xlrow_ishidden(MaxXLRow * row) {
	return row->isHidden();
}

void bmx_openxlsx_xlrow_sethidden(MaxXLRow * row, int state) {
	row->setHidden(state);
}

unsigned int bmx_openxlsx_xlrow_rownumber(MaxXLRow * row) {
	return row->rowNumber();
}

unsigned short bmx_openxlsx_xlrow_cellcount(MaxXLRow * row) {
	return row->cellCount();
}

MaxXLRowDataRange * bmx_openxlsx_xlrow_cells(MaxXLRow * row) {
	return row->cells();
}

MaxXLRowDataRange * bmx_openxlsx_xlrow_cells_count(MaxXLRow * row, unsigned short cellCount) {
	return row->cells(cellCount);
}

MaxXLRowDataRange * bmx_openxlsx_xlrow_cells_range(MaxXLRow * row, unsigned short firstCell, unsigned short lastCell) {
	return row->cells(firstCell, lastCell);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlrowrange_free(MaxXLRowRange * rowRange) {
	delete rowRange;
}

unsigned int bmx_openxlsx_xlrowrange_rowcount(MaxXLRowRange * rowRange) {
	return rowRange->rowCount();
}

MaxXLRowIterator * bmx_openxlsx_xlrowrange_iterator(MaxXLRowRange * rowRange) {
	return rowRange->iterator();
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlrowrange_iterator_free(MaxXLRowIterator * iter) {
	delete iter;
}

int bmx_openxlsx_xlrowrange_iterator_hasnext(MaxXLRowIterator * iter) {
	return iter->hasNext();
}

MaxXLRow * bmx_openxlsx_xlrowrange_iterator_next(MaxXLRowIterator * iter) {
	return iter->next();
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlrowdatarange_free(MaxXLRowDataRange * rowDataRange) {
	delete rowDataRange;
}

MaxXLRowDataIterator * bmx_openxlsx_xlrowdatarange_iterator(MaxXLRowDataRange * rowDataRange) {
	return rowDataRange->iterator();
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlrowdatarange_iterator_free(MaxXLRowDataIterator * iter) {
	delete iter;
}

int bmx_openxlsx_xlrowdatarange_iterator_hasnext(MaxXLRowDataIterator * iter) {
	return iter->hasNext();
}

MaxXLCell * bmx_openxlsx_xlrowdatarange_iterator_next(MaxXLRowDataIterator * iter) {
	return iter->next();
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlcolumn_free(MaxXLColumn * column) {
	delete column;
}

float bmx_openxlsx_xlcolumn_width(MaxXLColumn * column) {
	return column->width();
}

void bmx_openxlsx_xlcolumn_setwidth(MaxXLColumn * column, float width) {
	column->setWidth(width);
}

int bmx_openxlsx_xlcolumn_ishidden(MaxXLColumn * column) {
	return column->isHidden();
}

void bmx_openxlsx_xlcolumn_sethidden(MaxXLColumn * column, int state) {
	column->setHidden(state);
}
