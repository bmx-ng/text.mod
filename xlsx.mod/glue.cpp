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
class MaxXLStyles;
class MaxXLFonts;
class MaxXLNumberFormats;
class MaxXLFills;
class MaxXLBorders;
class MaxXLCellFormats;
class MaxXLCellStyles;
class MaxXLFont;
class MaxXLFill;
class MaxXLBorder;
class MaxXLLine;
class MaxXLDataBarColor;
class MaxXLCellFormat;
class MaxXLAlignment;
class MaxXLCellStyle;
class MaxXLNumberFormat;

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
	MaxXLStyles * bmx_openxlsx_xldocument_styles(MaxXLDocument * doc);

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

	void bmx_openxlsx_xlstyles_free(MaxXLStyles * styles);
	MaxXLFonts * bmx_openxlsx_xlstyles_fonts(MaxXLStyles * styles);
	MaxXLFills * bmx_openxlsx_xlstyles_fills(MaxXLStyles * styles);
	MaxXLBorders * bmx_openxlsx_xlstyles_borders(MaxXLStyles * styles);
	MaxXLCellFormats * bmx_openxlsx_xlstyles_cellformats(MaxXLStyles * styles);
	MaxXLCellStyles * bmx_openxlsx_xlstyles_cellstyles(MaxXLStyles * styles);
	MaxXLNumberFormats * bmx_openxlsx_xlstyles_numberformats(MaxXLStyles * styles);

	void bmx_openxlsx_xlfonts_free(MaxXLFonts * fonts);
	size_t bmx_openxlsx_xlfonts_count(MaxXLFonts * fonts);
	MaxXLFont * bmx_openxlsx_xlfonts_fontbyindex(MaxXLFonts * fonts, size_t index);

	void bmx_openxlsx_xlfont_free(MaxXLFont * font);
	BBString * bmx_openxlsx_xlfont_fontname(MaxXLFont * font);
	size_t bmx_openxlsx_xlfont_fontcharset(MaxXLFont * font);
	size_t bmx_openxlsx_xlfont_fontfamily(MaxXLFont * font);
	size_t bmx_openxlsx_xlfont_fontsize(MaxXLFont * font);
	SColor8 bmx_openxlsx_xlfont_fontcolor(MaxXLFont * font);
	int bmx_openxlsx_xlfont_bold(MaxXLFont * font);
	int bmx_openxlsx_xlfont_italic(MaxXLFont * font);
	int bmx_openxlsx_xlfont_strikethrough(MaxXLFont * font);
	int bmx_openxlsx_xlfont_underline(MaxXLFont * font);
	int bmx_openxlsx_xlfont_scheme(MaxXLFont * font);
	int bmx_openxlsx_xlfont_vertalign(MaxXLFont * font);
	int bmx_openxlsx_xlfont_outline(MaxXLFont * font);
	int bmx_openxlsx_xlfont_shadow(MaxXLFont * font);
	int bmx_openxlsx_xlfont_condense(MaxXLFont * font);
	int bmx_openxlsx_xlfont_setfontname(MaxXLFont * font, BBString * newName);
	int bmx_openxlsx_xlfont_setfontcharset(MaxXLFont * font, size_t newCharset);
	int bmx_openxlsx_xlfont_setfontfamily(MaxXLFont * font, size_t newFamily);
	int bmx_openxlsx_xlfont_setfontsize(MaxXLFont * font, size_t newSize);
	int bmx_openxlsx_xlfont_setfontcolor(MaxXLFont * font, SColor8 newColor);
	int bmx_openxlsx_xlfont_setbold(MaxXLFont * font, int set);
	int bmx_openxlsx_xlfont_setitalic(MaxXLFont * font, int set);
	int bmx_openxlsx_xlfont_setstrikethrough(MaxXLFont * font, int set);
	int bmx_openxlsx_xlfont_setunderline(MaxXLFont * font, int underline);
	int bmx_openxlsx_xlfont_setscheme(MaxXLFont * font, int scheme);
	int bmx_openxlsx_xlfont_setvertalign(MaxXLFont * font, int vertAlign);
	int bmx_openxlsx_xlfont_setoutline(MaxXLFont * font, int set);
	int bmx_openxlsx_xlfont_setshadow(MaxXLFont * font, int set);
	int bmx_openxlsx_xlfont_setcondense(MaxXLFont * font, int set);

	void bmx_openxlsx_xlfills_free(MaxXLFills * fills);
	size_t bmx_openxlsx_xlfills_count(MaxXLFills * fills);
	MaxXLFill * bmx_openxlsx_xlfills_fillbyindex(MaxXLFills * fills, size_t index);

	void bmx_openxlsx_xlfill_free(MaxXLFill * fill);
	int bmx_openxlsx_xlfill_filltype(MaxXLFill * fill);
	int bmx_openxlsx_xlfill_setfilltype(MaxXLFill * fill, uint8_t fillType, int force);

	void bmx_openxlsx_xlborders_free(MaxXLBorders * borders);
	size_t bmx_openxlsx_xlborders_count(MaxXLBorders * borders);
	MaxXLBorder * bmx_openxlsx_xlborders_borderbyindex(MaxXLBorders * borders, size_t index);

	void bmx_openxlsx_xlborder_free(MaxXLBorder * border);
	int bmx_openxlsx_xlborder_diagonalup(MaxXLBorder * border);
	int bmx_openxlsx_xlborder_diagonaldown(MaxXLBorder * border);
	int bmx_openxlsx_xlborder_outline(MaxXLBorder * border);
	MaxXLLine * bmx_openxlsx_xlborder_left(MaxXLBorder * border);
	MaxXLLine * bmx_openxlsx_xlborder_right(MaxXLBorder * border);
	MaxXLLine * bmx_openxlsx_xlborder_top(MaxXLBorder * border);
	MaxXLLine * bmx_openxlsx_xlborder_bottom(MaxXLBorder * border);
	MaxXLLine * bmx_openxlsx_xlborder_diagonal(MaxXLBorder * border);
	MaxXLLine * bmx_openxlsx_xlborder_vertical(MaxXLBorder * border);
	MaxXLLine * bmx_openxlsx_xlborder_horizontal(MaxXLBorder * border);
	int bmx_openxlsx_xlborder_setdiagonalup(MaxXLBorder * border, int set);
	int bmx_openxlsx_xlborder_setdiagonaldown(MaxXLBorder * border, int set);
	int bmx_openxlsx_xlborder_setoutline(MaxXLBorder * border, int set);
	int bmx_openxlsx_xlborder_setline(MaxXLBorder * border, uint8_t lineType, uint8_t lineStyle, SColor8 lineColor, double lineTint);
	int bmx_openxlsx_xlborder_setleft(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint);
	int bmx_openxlsx_xlborder_setright(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint);
	int bmx_openxlsx_xlborder_settop(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint);
	int bmx_openxlsx_xlborder_setbottom(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint);
	int bmx_openxlsx_xlborder_setdiagonal(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint);
	int bmx_openxlsx_xlborder_setvertical(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint);
	int bmx_openxlsx_xlborder_sethorizontal(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint);

	void bmx_openxlsx_xlline_free(MaxXLLine * line);
	uint8_t bmx_openxlsx_xlline_style(MaxXLLine * line);
	MaxXLDataBarColor * bmx_openxlsx_xlline_color(MaxXLLine * line);

	void bmx_openxlsx_xldatabarcolor_free(MaxXLDataBarColor * color);
	SColor8 bmx_openxlsx_xldatabarcolor_rgb(MaxXLDataBarColor * databarColor);
	double bmx_openxlsx_xldatabarcolor_tint(MaxXLDataBarColor * databarColor);
	int bmx_openxlsx_xldatabarcolor_automatic(MaxXLDataBarColor * databarColor);
	unsigned int bmx_openxlsx_xldatabarcolor_indexed(MaxXLDataBarColor * databarColor);
	unsigned int bmx_openxlsx_xldatabarcolor_theme(MaxXLDataBarColor * databarColor);
	int bmx_openxlsx_xldatabarcolor_setrgb(MaxXLDataBarColor * databarColor, SColor8 newColor);
	int bmx_openxlsx_xldatabarcolor_setautomatic(MaxXLDataBarColor * databarColor, int set);
	int bmx_openxlsx_xldatabarcolor_setindexed(MaxXLDataBarColor * databarColor, unsigned int newIndex);
	int bmx_openxlsx_xldatabarcolor_settheme(MaxXLDataBarColor * databarColor, unsigned int newTheme);

	void bmx_openxlsx_xlcellformats_free(MaxXLCellFormats * cellFormats);
	size_t bmx_openxlsx_xlcellformats_count(MaxXLCellFormats * cellFormats);
	MaxXLCellFormat * bmx_openxlsx_xlcellformats_cellformatbyindex(MaxXLCellFormats * cellFormats, size_t index);

	void bmx_openxlsx_xlcellformat_free(MaxXLCellFormat * cellFormat);
	unsigned int bmx_openxlsx_xlcellformat_numberformatid(MaxXLCellFormat * cellFormat);
	size_t bmx_openxlsx_xlcellformat_fontindex(MaxXLCellFormat * cellFormat);
	size_t bmx_openxlsx_xlcellformat_fillindex(MaxXLCellFormat * cellFormat);
	size_t bmx_openxlsx_xlcellformat_borderindex(MaxXLCellFormat * cellFormat);
	size_t bmx_openxlsx_xlcellformat_xfid(MaxXLCellFormat * cellFormat);
	int bmx_openxlsx_xlcellformat_applynumberformat(MaxXLCellFormat * cellFormat);
	int bmx_openxlsx_xlcellformat_applyfont(MaxXLCellFormat * cellFormat);
	int bmx_openxlsx_xlcellformat_applyfill(MaxXLCellFormat * cellFormat);
	int bmx_openxlsx_xlcellformat_applyborder(MaxXLCellFormat * cellFormat);
	int bmx_openxlsx_xlcellformat_applyalignment(MaxXLCellFormat * cellFormat);
	int bmx_openxlsx_xlcellformat_applyprotection(MaxXLCellFormat * cellFormat);
	int bmx_openxlsx_xlcellformat_quoteprefix(MaxXLCellFormat * cellFormat);
	int bmx_openxlsx_xlcellformat_pivotbutton(MaxXLCellFormat * cellFormat);
	int bmx_openxlsx_xlcellformat_locked(MaxXLCellFormat * cellFormat);
	int bmx_openxlsx_xlcellformat_hidden(MaxXLCellFormat * cellFormat);
	MaxXLAlignment * bmx_openxlsx_xlcellformat_alignment(MaxXLCellFormat * cellFormat, int createIfMissing);
	int bmx_openxlsx_xlcellformat_setnumberformatid(MaxXLCellFormat * cellFormat, unsigned int newNumFmtId);
	int bmx_openxlsx_xlcellformat_setfontindex(MaxXLCellFormat * cellFormat, size_t newFontIndex);
	int bmx_openxlsx_xlcellformat_setfillindex(MaxXLCellFormat * cellFormat, size_t newFillIndex);
	int bmx_openxlsx_xlcellformat_setborderindex(MaxXLCellFormat * cellFormat, size_t newBorderIndex);
	int bmx_openxlsx_xlcellformat_setxfid(MaxXLCellFormat * cellFormat, size_t newXfId);
	int bmx_openxlsx_xlcellformat_setapplynumberformat(MaxXLCellFormat * cellFormat, int set);
	int bmx_openxlsx_xlcellformat_setapplyfont(MaxXLCellFormat * cellFormat, int set);
	int bmx_openxlsx_xlcellformat_setapplyfill(MaxXLCellFormat * cellFormat, int set);
	int bmx_openxlsx_xlcellformat_setapplyborder(MaxXLCellFormat * cellFormat, int set);
	int bmx_openxlsx_xlcellformat_setapplyalignment(MaxXLCellFormat * cellFormat, int set);
	int bmx_openxlsx_xlcellformat_setapplyprotection(MaxXLCellFormat * cellFormat, int set);
	int bmx_openxlsx_xlcellformat_setquoteprefix(MaxXLCellFormat * cellFormat, int set);
	int bmx_openxlsx_xlcellformat_setpivotbutton(MaxXLCellFormat * cellFormat, int set);
	int bmx_openxlsx_xlcellformat_setlocked(MaxXLCellFormat * cellFormat, int set);
	int bmx_openxlsx_xlcellformat_sethidden(MaxXLCellFormat * cellFormat, int set);

	void bmx_openxlsx_xlalignment_free(MaxXLAlignment * alignment);
	uint8_t bmx_openxlsx_xlalignment_horizontal(MaxXLAlignment * alignment);
	uint8_t bmx_openxlsx_xlalignment_vertical(MaxXLAlignment * alignment);
	unsigned short bmx_openxlsx_xlalignment_textrotation(MaxXLAlignment * alignment);
	int bmx_openxlsx_xlalignment_wraptext(MaxXLAlignment * alignment);
	unsigned int bmx_openxlsx_xlalignment_indent(MaxXLAlignment * alignment);
	int bmx_openxlsx_xlalignment_relativeindent(MaxXLAlignment * alignment);
	int bmx_openxlsx_xlalignment_justifylastline(MaxXLAlignment * alignment);
	int bmx_openxlsx_xlalignment_shrinktofit(MaxXLAlignment * alignment);
	unsigned int bmx_openxlsx_xlalignment_readingorder(MaxXLAlignment * alignment);
	int bmx_openxlsx_xlalignment_sethorizontal(MaxXLAlignment * alignment, uint8_t newStyle);
	int bmx_openxlsx_xlalignment_setvertical(MaxXLAlignment * alignment, uint8_t newStyle);
	int bmx_openxlsx_xlalignment_settextrotation(MaxXLAlignment * alignment, unsigned short rotation);
	int bmx_openxlsx_xlalignment_setwraptext(MaxXLAlignment * alignment, int set);
	int bmx_openxlsx_xlalignment_setindent(MaxXLAlignment * alignment, unsigned int newIndent);
	int bmx_openxlsx_xlalignment_setrelativeindent(MaxXLAlignment * alignment, int newIndent);
	int bmx_openxlsx_xlalignment_setjustifylastline(MaxXLAlignment * alignment, int set);
	int bmx_openxlsx_xlalignment_setshrinktofit(MaxXLAlignment * alignment, int set);
	int bmx_openxlsx_xlalignment_setreadingorder(MaxXLAlignment * alignment, unsigned int newReadingOrder);

	void bmx_openxlsx_xlcellstyles_free(MaxXLCellStyles * cellStyles);
	size_t bmx_openxlsx_xlcellstyles_count(MaxXLCellStyles * cellStyles);
	MaxXLCellStyle * bmx_openxlsx_xlcellstyles_cellstylebyindex(MaxXLCellStyles * cellStyles, size_t index);

	void bmx_openxlsx_xlcellstyle_free(MaxXLCellStyle * cellStyle);
	int bmx_openxlsx_xlcellstyle_empty(MaxXLCellStyle * cellStyle);
	BBString * bmx_openxlsx_xlcellstyle_name(MaxXLCellStyle * cellStyle);
	size_t bmx_openxlsx_xlcellstyle_xfid(MaxXLCellStyle * cellStyle);
	unsigned int bmx_openxlsx_xlcellstyle_builtinid(MaxXLCellStyle * cellStyle);
	unsigned int bmx_openxlsx_xlcellstyle_outlinestyle(MaxXLCellStyle * cellStyle);
	int bmx_openxlsx_xlcellstyle_hidden(MaxXLCellStyle * cellStyle);
	int bmx_openxlsx_xlcellstyle_custombuiltin(MaxXLCellStyle * cellStyle);
	int bmx_openxlsx_xlcellstyle_setname(MaxXLCellStyle * cellStyle, BBString * newName);
	int bmx_openxlsx_xlcellstyle_setxfid(MaxXLCellStyle * cellStyle, size_t newXfId);
	int bmx_openxlsx_xlcellstyle_setbuiltinid(MaxXLCellStyle * cellStyle, unsigned int newBuiltinId);
	int bmx_openxlsx_xlcellstyle_setoutlinestyle(MaxXLCellStyle * cellStyle, unsigned int newOutlineStyle);
	int bmx_openxlsx_xlcellstyle_sethidden(MaxXLCellStyle * cellStyle, int set);
	int bmx_openxlsx_xlcellstyle_setcustombuiltin(MaxXLCellStyle * cellStyle, int set);

	void bmx_openxlsx_xlnumberformats_free(MaxXLNumberFormats * numberFormats);
	size_t bmx_openxlsx_xlnumberformats_count(MaxXLNumberFormats * numberFormats);
	MaxXLNumberFormat * bmx_openxlsx_xlnumberformats_numberformatbyindex(MaxXLNumberFormats * numberFormats, size_t index);
	MaxXLNumberFormat * bmx_openxlsx_xlnumberformats_numberformatbyid(MaxXLNumberFormats * numberFormats, unsigned int numFmtId);
	unsigned int bmx_openxlsx_xlnumberformats_numberformatidfromindex(MaxXLNumberFormats * numberFormats, size_t index);

	void bmx_openxlsx_xlnumberformat_free(MaxXLNumberFormat * numberFormat);
	unsigned int bmx_openxlsx_xlnumberformat_numberformatid(MaxXLNumberFormat * numberFormat);
	BBString * bmx_openxlsx_xlnumberformat_formatcode(MaxXLNumberFormat * numberFormat);
	int bmx_openxlsx_xlnumberformat_setnumberformatid(MaxXLNumberFormat * numberFormat, unsigned int newNumberFormatId);
	int bmx_openxlsx_xlnumberformat_setformatcode(MaxXLNumberFormat * numberFormat, BBString * newFormatCode);
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

class MaxXLFont
{
public:
	MaxXLFont(OpenXLSX::XLFont font) : font(font) {
	}

	BBString * fontName() const {
		return fromStdString(font.fontName());
	}

	size_t fontCharset() const {
		return font.fontCharset();
	}

	size_t fontFamily() const {
		return font.fontFamily();
	}

	size_t fontSize() const {
		return font.fontSize();
	}

	SColor8 fontColor() const {
		OpenXLSX::XLColor c = font.fontColor();
		return SColor8{c.blue(), c.green(), c.red(), c.alpha()};
	}

	int bold() const {
		return font.bold() ? 1 : 0;
	}

	int italic() const {
		return font.italic() ? 1 : 0;
	}

	int strikethrough() const {
		return font.strikethrough() ? 1 : 0;
	}

	int underline() const {
		return (int)font.underline();
	}

	int scheme() const {
		return (int)font.scheme();
	}

	int vertAlign() const {
		return (int)font.vertAlign();
	}

	int outline() const {
		return font.outline() ? 1 : 0;
	}

	int shadow() const {
		return font.shadow() ? 1 : 0;
	}

	int condense() const {
		return font.condense() ? 1 : 0;
	}

	int setFontName(BBString * newName) {
		std::string n = toStdString(newName);
		return font.setFontName(n) ? 1 : 0;
	}

	int setFontCharset(size_t newCharset) {
		return font.setFontCharset(newCharset) ? 1 : 0;
	}

	int setFontFamily(size_t newFamily) {
		return font.setFontFamily(newFamily) ? 1 : 0;
	}

	int setFontSize(size_t newSize) {
		return font.setFontSize(newSize) ? 1 : 0;
	}

	int setFontColor(SColor8 newColor) {
		return font.setFontColor(OpenXLSX::XLColor(newColor.a, newColor.r, newColor.g, newColor.b)) ? 1 : 0;
	}

	int setBold(int set) {
		return font.setBold((bool)set) ? 1 : 0;
	}

	int setItalic(int set) {
		return font.setItalic((bool)set) ? 1 : 0;
	}

	int setStrikethrough(int set) {
		return font.setStrikethrough((bool)set) ? 1 : 0;
	}

	int setUnderline(int underline) {
		return font.setUnderline((OpenXLSX::XLUnderlineStyle)underline) ? 1 : 0;
	}

	int setScheme(int scheme) {
		return font.setScheme((OpenXLSX::XLFontSchemeStyle)scheme) ? 1 : 0;
	}

	int setVertAlign(int vertAlign) {
		return font.setVertAlign((OpenXLSX::XLVerticalAlignRunStyle)vertAlign) ? 1 : 0;
	}

	int setOutline(int set) {
		return font.setOutline((bool)set) ? 1 : 0;
	}

	int setShadow(int set) {
		return font.setShadow((bool)set) ? 1 : 0;
	}

	int setCondense(int set) {
		return font.setCondense((bool)set) ? 1 : 0;
	}

	OpenXLSX::XLFont font;
};

///////////////////////////////////////////////////////////

class MaxXLFonts
{
public:
	MaxXLFonts(OpenXLSX::XLFonts& fonts) : fonts(fonts) {
	}

	size_t count() const {
		return fonts.count();
	}

	MaxXLFont * fontByIndex(size_t index) {
		try {
			return new MaxXLFont(fonts.fontByIndex(index));
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		return nullptr;
	}

	OpenXLSX::XLFonts & fonts;
};

///////////////////////////////////////////////////////////

class MaxXLNumberFormat
{
public:
	MaxXLNumberFormat(OpenXLSX::XLNumberFormat numberFormat) : numberFormat(numberFormat) {
	}

	unsigned int numberFormatId() const {
		return numberFormat.numberFormatId();
	}

	BBString * formatCode() const {
		return fromStdString(numberFormat.formatCode());
	}

	int setNumberFormatId(unsigned int newNumberFormatId) {
		return numberFormat.setNumberFormatId(newNumberFormatId) ? 1 : 0;
	}

	int setFormatCode(BBString * newFormatCode) {
		std::string fc = toStdString(newFormatCode);
		return numberFormat.setFormatCode(fc) ? 1 : 0;
	}

	OpenXLSX::XLNumberFormat numberFormat;
};

///////////////////////////////////////////////////////////

class MaxXLNumberFormats
{
public:
	MaxXLNumberFormats(OpenXLSX::XLNumberFormats& numberFormats) : numberFormats(numberFormats) {
	}

	size_t count() const {
		return numberFormats.count();
	}

	MaxXLNumberFormat * numberFormatByIndex(size_t index) {
		try {
			return new MaxXLNumberFormat(numberFormats.numberFormatByIndex(index));
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		return nullptr;
	}

	MaxXLNumberFormat * numberFormatById(unsigned int numFmtId) {
		try {
			return new MaxXLNumberFormat(numberFormats.numberFormatById(numFmtId));
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		return nullptr;
	}

	unsigned int numberFormatIdFromIndex(size_t index) {
		try {
			return numberFormats.numberFormatIdFromIndex(index);
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		return 0;
	}

	OpenXLSX::XLNumberFormats & numberFormats;
};

///////////////////////////////////////////////////////////

class MaxXLFill
{
public:
	MaxXLFill(OpenXLSX::XLFill fill) : fill(fill) {
	}

	int fillType() const {
		return (int)fill.fillType();
	}

	int setFillType(uint8_t fillType, int force) {
		return fill.setFillType((OpenXLSX::XLFillType)fillType, (bool)force) ? 1 : 0;
	}

	OpenXLSX::XLFill fill;
};

///////////////////////////////////////////////////////////

class MaxXLFills
{
public:
	MaxXLFills(OpenXLSX::XLFills& fills) : fills(fills) {
	}

	size_t count() const {
		return fills.count();
	}

	MaxXLFill * fillByIndex(size_t index) {
		try {
			return new MaxXLFill(fills.fillByIndex(index));
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		return nullptr;
	}

	OpenXLSX::XLFills & fills;
};

///////////////////////////////////////////////////////////

class MaxXLDataBarColor
{
public:
	MaxXLDataBarColor(OpenXLSX::XLDataBarColor color) : color(color) {
	}

	SColor8 rgb() const {
		OpenXLSX::XLColor c = color.rgb();
		return SColor8{c.blue(), c.green(), c.red(), c.alpha()};
	}

	double tint() const {
		return color.tint();
	}

	int automatic() const {
		return color.automatic() ? 1 : 0;
	}

	unsigned int indexed() const {
		return color.indexed();
	}

	unsigned int theme() const {
		return color.theme();
	}

	int setRgb(SColor8 newColor) {
		return color.setRgb(OpenXLSX::XLColor(newColor.a, newColor.r, newColor.g, newColor.b)) ? 1 : 0;
	}

	int set(SColor8 newColor) {
		return color.set(OpenXLSX::XLColor(newColor.a, newColor.r, newColor.g, newColor.b)) ? 1 : 0;
	}

	int setTint(double newTint) {
		return color.setTint(newTint) ? 1 : 0;
	}

	int setAutomatic(int set) {
		return color.setAutomatic((bool)set) ? 1 : 0;
	}

	int setIndexed(unsigned int newIndexed) {
		return color.setIndexed(newIndexed) ? 1 : 0;
	}

	int setTheme(unsigned int newTheme) {
		return color.setTheme(newTheme) ? 1 : 0;
	}

	OpenXLSX::XLDataBarColor color;
};

///////////////////////////////////////////////////////////

class MaxXLLine
{
public:
	MaxXLLine(OpenXLSX::XLLine line) : line(line) {
	}

	int style() const {
		return (int)line.style();
	}

	MaxXLDataBarColor * color() {
		return new MaxXLDataBarColor(line.color());
	}

	OpenXLSX::XLLine line;
};

///////////////////////////////////////////////////////////

class MaxXLBorder
{
public:
	MaxXLBorder(OpenXLSX::XLBorder border) : border(border) {
	}

	int diagonalUp() const {
		return border.diagonalUp() ? 1 : 0;
	}

	int diagonalDown() const {
		return border.diagonalDown() ? 1 : 0;
	}

	int outline() const {
		return border.outline() ? 1 : 0;
	}

	MaxXLLine * left() {
		return new MaxXLLine(border.left());
	}

	MaxXLLine * right() {
		return new MaxXLLine(border.right());
	}

	MaxXLLine * top() {
		return new MaxXLLine(border.top());
	}

	MaxXLLine * bottom() {
		return new MaxXLLine(border.bottom());
	}

	MaxXLLine * diagonal() {
		return new MaxXLLine(border.diagonal());
	}

	MaxXLLine * vertical() {
		return new MaxXLLine(border.vertical());
	}

	MaxXLLine * horizontal() {
		return new MaxXLLine(border.horizontal());
	}

	int setDiagonalUp(int set) {
		return border.setDiagonalUp((bool)set) ? 1 : 0;
	}

	int setDiagonalDown(int set) {
		return border.setDiagonalDown((bool)set) ? 1 : 0;
	}

	int setOutline(int set) {
		return border.setOutline((bool)set) ? 1 : 0;
	}

	int setLine(uint8_t lineType, uint8_t lineStyle, SColor8 lineColor, double lineTint) {
		OpenXLSX::XLColor lc(lineColor.a, lineColor.r, lineColor.g, lineColor.b);
		return border.setLine((OpenXLSX::XLLineType)lineType, (OpenXLSX::XLLineStyle)lineStyle, lc, lineTint) ? 1 : 0;
	}

	int setLeft(uint8_t lineStyle, SColor8 lineColor, double lineTint) {
		OpenXLSX::XLColor lc(lineColor.a, lineColor.r, lineColor.g, lineColor.b);
		return border.setLeft((OpenXLSX::XLLineStyle)lineStyle, lc, lineTint) ? 1 : 0;
	}

	int setRight(uint8_t lineStyle, SColor8 lineColor, double lineTint) {
		OpenXLSX::XLColor lc(lineColor.a, lineColor.r, lineColor.g, lineColor.b);
		return border.setRight((OpenXLSX::XLLineStyle)lineStyle, lc, lineTint) ? 1 : 0;
	}

	int setTop(uint8_t lineStyle, SColor8 lineColor, double lineTint) {
		OpenXLSX::XLColor lc(lineColor.a, lineColor.r, lineColor.g, lineColor.b);
		return border.setTop((OpenXLSX::XLLineStyle)lineStyle, lc, lineTint) ? 1 : 0;
	}

	int setBottom(uint8_t lineStyle, SColor8 lineColor, double lineTint) {
		OpenXLSX::XLColor lc(lineColor.a, lineColor.r, lineColor.g, lineColor.b);
		return border.setBottom((OpenXLSX::XLLineStyle)lineStyle, lc, lineTint) ? 1 : 0;
	}

	int setDiagonal(uint8_t lineStyle, SColor8 lineColor, double lineTint) {
		OpenXLSX::XLColor lc(lineColor.a, lineColor.r, lineColor.g, lineColor.b);
		return border.setDiagonal((OpenXLSX::XLLineStyle)lineStyle, lc, lineTint) ? 1 : 0;
	}

	int setVertical(uint8_t lineStyle, SColor8 lineColor, double lineTint) {
		OpenXLSX::XLColor lc(lineColor.a, lineColor.r, lineColor.g, lineColor.b);
		return border.setVertical((OpenXLSX::XLLineStyle)lineStyle, lc, lineTint) ? 1 : 0;
	}

	int setHorizontal(uint8_t lineStyle, SColor8 lineColor, double lineTint) {
		OpenXLSX::XLColor lc(lineColor.a, lineColor.r, lineColor.g, lineColor.b);
		return border.setHorizontal((OpenXLSX::XLLineStyle)lineStyle, lc, lineTint) ? 1 : 0;
	}

	OpenXLSX::XLBorder border;
};

///////////////////////////////////////////////////////////

class MaxXLBorders
{
public:
	MaxXLBorders(OpenXLSX::XLBorders& borders) : borders(borders) {
	}

	size_t count() const {
		return borders.count();
	}

	MaxXLBorder * borderByIndex(size_t index) {
		try {
			return new MaxXLBorder(borders.borderByIndex(index));
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		return nullptr;
	}

	OpenXLSX::XLBorders & borders;
};

///////////////////////////////////////////////////////////

class MaxXLAlignment
{
public:
	MaxXLAlignment(OpenXLSX::XLAlignment alignment) : alignment(alignment) {
	}

	uint8_t horizontal() const {
		return (uint8_t)alignment.horizontal();
	}

	uint8_t vertical() const {
		return (uint8_t)alignment.vertical();
	}

	unsigned short textRotation() const {
		return alignment.textRotation();
	}

	int wrapText() const {
		return alignment.wrapText() ? 1 : 0;
	}

	unsigned int indent() const {
		return alignment.indent();
	}

	int relativeIndent() const {
		return alignment.relativeIndent() ? 1 : 0;
	}

	int justifyLastLine() const {
		return alignment.justifyLastLine() ? 1 : 0;
	}

	int shrinkToFit() const {
		return alignment.shrinkToFit() ? 1 : 0;
	}

	unsigned int readingOrder() const {
		return alignment.readingOrder();
	}

	int setHorizontal(uint8_t newStyle) {
		return alignment.setHorizontal((OpenXLSX::XLAlignmentStyle)newStyle) ? 1 : 0;
	}

	int setVertical(uint8_t newStyle) {
		return alignment.setVertical((OpenXLSX::XLAlignmentStyle)newStyle) ? 1 : 0;
	}

	int setTextRotation(unsigned short rotation) {
		return alignment.setTextRotation(rotation) ? 1 : 0;
	}

	int setWrapText(int set) {
		return alignment.setWrapText((bool)set) ? 1 : 0;
	}

	int setIndent(unsigned int newIndent) {
		return alignment.setIndent(newIndent) ? 1 : 0;
	}

	int setRelativeIndent(int newIndent) {
		return alignment.setRelativeIndent((bool)newIndent) ? 1 : 0;
	}

	int setJustifyLastLine(int set) {
		return alignment.setJustifyLastLine((bool)set) ? 1 : 0;
	}

	int setShrinkToFit(int set) {
		return alignment.setShrinkToFit((bool)set) ? 1 : 0;
	}

	int setReadingOrder(unsigned int newReadingOrder) {
		return alignment.setReadingOrder(newReadingOrder) ? 1 : 0;
	}

	OpenXLSX::XLAlignment alignment;
};

///////////////////////////////////////////////////////////

class MaxXLCellFormat
{
public:
	MaxXLCellFormat(OpenXLSX::XLCellFormat cellFormat) : cellFormat(cellFormat) {
	}

	unsigned int numberFormatId() const {
		return cellFormat.numberFormatId();
	}

	size_t fontIndex() const {
		return cellFormat.fontIndex();
	}

	size_t fillIndex() const {
		return cellFormat.fillIndex();
	}

	size_t borderIndex() const {
		return cellFormat.borderIndex();
	}

	size_t xfId() const {
		return cellFormat.xfId();
	}

	int applyNumberFormat() const {
		return cellFormat.applyNumberFormat() ? 1 : 0;
	}

	int applyFont() const {
		return cellFormat.applyFont() ? 1 : 0;
	}

	int applyFill() const {
		return cellFormat.applyFill() ? 1 : 0;
	}

	int applyBorder() const {
		return cellFormat.applyBorder() ? 1 : 0;
	}

	int applyAlignment() const {
		return cellFormat.applyAlignment() ? 1 : 0;
	}

	int applyProtection() const {
		return cellFormat.applyProtection() ? 1 : 0;
	}

	int quotePrefix() const {
		return cellFormat.quotePrefix() ? 1 : 0;
	}

	int pivotButton() const {
		return cellFormat.pivotButton() ? 1 : 0;
	}

	int locked() const {
		return cellFormat.locked() ? 1 : 0;
	}

	int hidden() const {
		return cellFormat.hidden() ? 1 : 0;
	}

	MaxXLAlignment * alignment(int createIfMissing) {
		return new MaxXLAlignment(cellFormat.alignment((bool)createIfMissing));
	}

	int setNumberFormatId(unsigned int newNumFmtId) {
		return cellFormat.setNumberFormatId(newNumFmtId) ? 1 : 0;
	}

	int setFontIndex(size_t newFontIndex) {
		return cellFormat.setFontIndex((OpenXLSX::XLStyleIndex)newFontIndex) ? 1 : 0;
	}

	int setFillIndex(size_t newFillIndex) {
		return cellFormat.setFillIndex((OpenXLSX::XLStyleIndex)newFillIndex) ? 1 : 0;
	}

	int setBorderIndex(size_t newBorderIndex) {
		return cellFormat.setBorderIndex((OpenXLSX::XLStyleIndex)newBorderIndex) ? 1 : 0;
	}

	int setXfId(size_t newXfId) {
		return cellFormat.setXfId(newXfId) ? 1 : 0;
	}

	int setApplyNumberFormat(int set) {
		return cellFormat.setApplyNumberFormat((bool)set) ? 1 : 0;
	}

	int setApplyFont(int set) {
		return cellFormat.setApplyFont((bool)set) ? 1 : 0;
	}

	int setApplyFill(int set) {
		return cellFormat.setApplyFill((bool)set) ? 1 : 0;
	}

	int setApplyBorder(int set) {
		return cellFormat.setApplyBorder((bool)set) ? 1 : 0;
	}

	int setApplyAlignment(int set) {
		return cellFormat.setApplyAlignment((bool)set) ? 1 : 0;
	}

	int setApplyProtection(int set) {
		return cellFormat.setApplyProtection((bool)set) ? 1 : 0;
	}

	int setQuotePrefix(int set) {
		return cellFormat.setQuotePrefix((bool)set) ? 1 : 0;
	}

	int setPivotButton(int set) {
		return cellFormat.setPivotButton((bool)set) ? 1 : 0;
	}

	int setLocked(int set) {
		return cellFormat.setLocked((bool)set) ? 1 : 0;
	}

	int setHidden(int set) {
		return cellFormat.setHidden((bool)set) ? 1 : 0;
	}

	OpenXLSX::XLCellFormat cellFormat;
};

///////////////////////////////////////////////////////////

class MaxXLCellFormats
{
public:
	MaxXLCellFormats(OpenXLSX::XLCellFormats& cellFormats) : cellFormats(cellFormats) {
	}

	size_t count() const {
		return cellFormats.count();
	}

	MaxXLCellFormat * cellFormatByIndex(size_t index) {
		try {
			return new MaxXLCellFormat(cellFormats.cellFormatByIndex(index));
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		return nullptr;
	}

	OpenXLSX::XLCellFormats & cellFormats;
};

///////////////////////////////////////////////////////////

class MaxXLCellStyle
{
public:
	MaxXLCellStyle(OpenXLSX::XLCellStyle cellStyle) : cellStyle(cellStyle) {
	}

	int empty() const {
		return cellStyle.empty() ? 1 : 0;
	}

	BBString * name() const {
		return fromStdString(cellStyle.name());
	}

	size_t xfId() const {
		return (size_t)cellStyle.xfId();
	}

	unsigned int builtinId() const {
		return cellStyle.builtinId();
	}

	unsigned int outlineStyle() const {
		return cellStyle.outlineStyle();
	}

	int hidden() const {
		return cellStyle.hidden() ? 1 : 0;
	}

	int customBuiltin() const {
		return cellStyle.customBuiltin() ? 1 : 0;
	}

	int setName(BBString * newName) {
		std::string n = toStdString(newName);
		return cellStyle.setName(n) ? 1 : 0;
	}

	int setXfId(size_t newXfId) {
		return cellStyle.setXfId(newXfId) ? 1 : 0;
	}

	int setBuiltinId(unsigned int newBuiltinId) {
		return cellStyle.setBuiltinId(newBuiltinId) ? 1 : 0;
	}

	int setOutlineStyle(unsigned int newOutlineStyle) {
		return cellStyle.setOutlineStyle(newOutlineStyle) ? 1 : 0;
	}

	int setHidden(int set) {
		return cellStyle.setHidden((bool)set) ? 1 : 0;
	}

	int setCustomBuiltin(int set) {
		return cellStyle.setCustomBuiltin((bool)set) ? 1 : 0;
	}

	OpenXLSX::XLCellStyle cellStyle;
};

///////////////////////////////////////////////////////////

class MaxXLCellStyles
{
public:
	MaxXLCellStyles(OpenXLSX::XLCellStyles& cellStyles) : cellStyles(cellStyles) {
	}

	size_t count() const {
		return cellStyles.count();
	}

	MaxXLCellStyle * cellStyleByIndex(size_t index) {
		try {
			return new MaxXLCellStyle(cellStyles.cellStyleByIndex(index));
		}
		catch (const OpenXLSX::XLException& e)
		{
			throwXLException(e);
		}
		return nullptr;
	}

	OpenXLSX::XLCellStyles & cellStyles;
};

///////////////////////////////////////////////////////////

class MaxXLStyles
{
public:
	MaxXLStyles(OpenXLSX::XLStyles& styles) : styles(styles) {
	}

	MaxXLFonts * fonts() {
		return new MaxXLFonts(styles.fonts());
	}

	MaxXLNumberFormats * numberFormats() {
		return new MaxXLNumberFormats(styles.numberFormats());
	}

	MaxXLFills * fills() {
		return new MaxXLFills(styles.fills());
	}

	MaxXLBorders * borders() {
		return new MaxXLBorders(styles.borders());
	}

	MaxXLCellFormats * cellFormats() {
		return new MaxXLCellFormats(styles.cellFormats());
	}

	MaxXLCellStyles * cellStyles() {
		return new MaxXLCellStyles(styles.cellStyles());
	}

	OpenXLSX::XLStyles & styles;
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

	MaxXLStyles * styles() {
		return new MaxXLStyles(doc->styles());
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

MaxXLStyles * bmx_openxlsx_xldocument_styles(MaxXLDocument * doc) {
	return doc->styles();
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

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlstyles_free(MaxXLStyles * styles) {
	delete styles;
}

MaxXLFonts * bmx_openxlsx_xlstyles_fonts(MaxXLStyles * styles) {
	return styles->fonts();
}

MaxXLFills * bmx_openxlsx_xlstyles_fills(MaxXLStyles * styles) {
	return styles->fills();
}

MaxXLBorders * bmx_openxlsx_xlstyles_borders(MaxXLStyles * styles) {
	return styles->borders();
}

MaxXLCellFormats * bmx_openxlsx_xlstyles_cellformats(MaxXLStyles * styles) {
	return styles->cellFormats();
}

MaxXLCellStyles * bmx_openxlsx_xlstyles_cellstyles(MaxXLStyles * styles) {
	return styles->cellStyles();
}

MaxXLNumberFormats * bmx_openxlsx_xlstyles_numberformats(MaxXLStyles * styles) {
	return styles->numberFormats();
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlfonts_free(MaxXLFonts * fonts) {
	delete fonts;
}

size_t bmx_openxlsx_xlfonts_count(MaxXLFonts * fonts) {
	return fonts->count();
}

MaxXLFont * bmx_openxlsx_xlfonts_fontbyindex(MaxXLFonts * fonts, size_t index) {
	return fonts->fontByIndex(index);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlfont_free(MaxXLFont * font) {
	delete font;
}

BBString * bmx_openxlsx_xlfont_fontname(MaxXLFont * font) {
	return font->fontName();
}

size_t bmx_openxlsx_xlfont_fontcharset(MaxXLFont * font) {
	return font->fontCharset();
}

size_t bmx_openxlsx_xlfont_fontfamily(MaxXLFont * font) {
	return font->fontFamily();
}

size_t bmx_openxlsx_xlfont_fontsize(MaxXLFont * font) {
	return font->fontSize();
}

SColor8 bmx_openxlsx_xlfont_fontcolor(MaxXLFont * font) {
	return font->fontColor();
}

int bmx_openxlsx_xlfont_bold(MaxXLFont * font) {
	return font->bold();
}

int bmx_openxlsx_xlfont_italic(MaxXLFont * font) {
	return font->italic();
}

int bmx_openxlsx_xlfont_strikethrough(MaxXLFont * font) {
	return font->strikethrough();
}

int bmx_openxlsx_xlfont_underline(MaxXLFont * font) {
	return font->underline();
}

int bmx_openxlsx_xlfont_scheme(MaxXLFont * font) {
	return font->scheme();
}

int bmx_openxlsx_xlfont_vertalign(MaxXLFont * font) {
	return font->vertAlign();
}

int bmx_openxlsx_xlfont_outline(MaxXLFont * font) {
	return font->outline();
}

int bmx_openxlsx_xlfont_shadow(MaxXLFont * font) {
	return font->shadow();
}

int bmx_openxlsx_xlfont_condense(MaxXLFont * font) {
	return font->condense();
}

int bmx_openxlsx_xlfont_setfontname(MaxXLFont * font, BBString * newName) {
	return font->setFontName(newName);
}

int bmx_openxlsx_xlfont_setfontcharset(MaxXLFont * font, size_t newCharset) {
	return font->setFontCharset(newCharset);
}

int bmx_openxlsx_xlfont_setfontfamily(MaxXLFont * font, size_t newFamily) {
	return font->setFontFamily(newFamily);
}

int bmx_openxlsx_xlfont_setfontsize(MaxXLFont * font, size_t newSize) {
	return font->setFontSize(newSize);
}

int bmx_openxlsx_xlfont_setfontcolor(MaxXLFont * font, SColor8 newColor) {
	return font->setFontColor(newColor);
}

int bmx_openxlsx_xlfont_setbold(MaxXLFont * font, int set) {
	return font->setBold(set);
}

int bmx_openxlsx_xlfont_setitalic(MaxXLFont * font, int set) {
	return font->setItalic(set);
}

int bmx_openxlsx_xlfont_setstrikethrough(MaxXLFont * font, int set) {
	return font->setStrikethrough(set);
}

int bmx_openxlsx_xlfont_setunderline(MaxXLFont * font, int underline) {
	return font->setUnderline(underline);
}

int bmx_openxlsx_xlfont_setscheme(MaxXLFont * font, int scheme) {
	return font->setScheme(scheme);
}

int bmx_openxlsx_xlfont_setvertalign(MaxXLFont * font, int vertAlign) {
	return font->setVertAlign(vertAlign);
}

int bmx_openxlsx_xlfont_setoutline(MaxXLFont * font, int set) {
	return font->setOutline(set);
}

int bmx_openxlsx_xlfont_setshadow(MaxXLFont * font, int set) {
	return font->setShadow(set);
}

int bmx_openxlsx_xlfont_setcondense(MaxXLFont * font, int set) {
	return font->setCondense(set);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlfills_free(MaxXLFills * fills) {
	delete fills;
}

size_t bmx_openxlsx_xlfills_count(MaxXLFills * fills) {
	return fills->count();
}

MaxXLFill * bmx_openxlsx_xlfills_fillbyindex(MaxXLFills * fills, size_t index) {
	return fills->fillByIndex(index);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlfill_free(MaxXLFill * fill) {
	delete fill;
}

int bmx_openxlsx_xlfill_filltype(MaxXLFill * fill) {
	return fill->fillType();
}

int bmx_openxlsx_xlfill_setfilltype(MaxXLFill * fill, uint8_t fillType, int force) {
	return fill->setFillType(fillType, force);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlborders_free(MaxXLBorders * borders) {
	delete borders;
}

size_t bmx_openxlsx_xlborders_count(MaxXLBorders * borders) {
	return borders->count();
}

MaxXLBorder * bmx_openxlsx_xlborders_borderbyindex(MaxXLBorders * borders, size_t index) {
	return borders->borderByIndex(index);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlborder_free(MaxXLBorder * border) {
	delete border;
}

int bmx_openxlsx_xlborder_diagonalup(MaxXLBorder * border) {
	return border->diagonalUp();
}

int bmx_openxlsx_xlborder_diagonaldown(MaxXLBorder * border) {
	return border->diagonalDown();
}

int bmx_openxlsx_xlborder_outline(MaxXLBorder * border) {
	return border->outline();
}

MaxXLLine * bmx_openxlsx_xlborder_left(MaxXLBorder * border) {
	return border->left();
}

MaxXLLine * bmx_openxlsx_xlborder_right(MaxXLBorder * border) {
	return border->right();
}

MaxXLLine * bmx_openxlsx_xlborder_top(MaxXLBorder * border) {
	return border->top();
}

MaxXLLine * bmx_openxlsx_xlborder_bottom(MaxXLBorder * border) {
	return border->bottom();
}

MaxXLLine * bmx_openxlsx_xlborder_diagonal(MaxXLBorder * border) {
	return border->diagonal();
}

MaxXLLine * bmx_openxlsx_xlborder_vertical(MaxXLBorder * border) {
	return border->vertical();
}

MaxXLLine * bmx_openxlsx_xlborder_horizontal(MaxXLBorder * border) {
	return border->horizontal();
}

int bmx_openxlsx_xlborder_setdiagonalup(MaxXLBorder * border, int set) {
	return border->setDiagonalUp(set);
}

int bmx_openxlsx_xlborder_setdiagonaldown(MaxXLBorder * border, int set) {
	return border->setDiagonalDown(set);
}

int bmx_openxlsx_xlborder_setoutline(MaxXLBorder * border, int set) {
	return border->setOutline(set);
}

int bmx_openxlsx_xlborder_setline(MaxXLBorder * border, uint8_t lineType, uint8_t lineStyle, SColor8 lineColor, double lineTint) {
	return border->setLine(lineType, lineStyle, lineColor, lineTint);
}

int bmx_openxlsx_xlborder_setleft(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint) {
	return border->setLeft(lineStyle, lineColor, lineTint);
}

int bmx_openxlsx_xlborder_setright(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint) {
	return border->setRight(lineStyle, lineColor, lineTint);
}

int bmx_openxlsx_xlborder_settop(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint) {
	return border->setTop(lineStyle, lineColor, lineTint);
}

int bmx_openxlsx_xlborder_setbottom(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint) {
	return border->setBottom(lineStyle, lineColor, lineTint);
}

int bmx_openxlsx_xlborder_setdiagonal(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint) {
	return border->setDiagonal(lineStyle, lineColor, lineTint);
}

int bmx_openxlsx_xlborder_setvertical(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint) {
	return border->setVertical(lineStyle, lineColor, lineTint);
}

int bmx_openxlsx_xlborder_sethorizontal(MaxXLBorder * border, uint8_t lineStyle, SColor8 lineColor, double lineTint) {
	return border->setHorizontal(lineStyle, lineColor, lineTint);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlline_free(MaxXLLine * line) {
	delete line;
}

uint8_t bmx_openxlsx_xlline_style(MaxXLLine * line) {
	return line->style();
}

MaxXLDataBarColor * bmx_openxlsx_xlline_color(MaxXLLine * line) {
	return line->color();
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xldatabarcolor_free(MaxXLDataBarColor * color) {
	delete color;
}

SColor8 bmx_openxlsx_xldatabarcolor_rgb(MaxXLDataBarColor * databarColor) {
	return databarColor->rgb();
}

double bmx_openxlsx_xldatabarcolor_tint(MaxXLDataBarColor * databarColor) {
	return databarColor->tint();
}

int bmx_openxlsx_xldatabarcolor_automatic(MaxXLDataBarColor * databarColor) {
	return databarColor->automatic();
}

unsigned int bmx_openxlsx_xldatabarcolor_indexed(MaxXLDataBarColor * databarColor) {
	return databarColor->indexed();
}

unsigned int bmx_openxlsx_xldatabarcolor_theme(MaxXLDataBarColor * databarColor) {
	return databarColor->theme();
}

int bmx_openxlsx_xldatabarcolor_setrgb(MaxXLDataBarColor * databarColor, SColor8 newColor) {
	return databarColor->setRgb(newColor);
}

int bmx_openxlsx_xldatabarcolor_setautomatic(MaxXLDataBarColor * databarColor, int set) {
	return databarColor->setAutomatic(set);
}

int bmx_openxlsx_xldatabarcolor_setindexed(MaxXLDataBarColor * databarColor, unsigned int newIndex) {
	return databarColor->setIndexed(newIndex);
}

int bmx_openxlsx_xldatabarcolor_settheme(MaxXLDataBarColor * databarColor, unsigned int newTheme) {
	return databarColor->setTheme(newTheme);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlcellformats_free(MaxXLCellFormats * cellFormats) {
	delete cellFormats;
}

size_t bmx_openxlsx_xlcellformats_count(MaxXLCellFormats * cellFormats) {
	return cellFormats->count();
}

MaxXLCellFormat * bmx_openxlsx_xlcellformats_cellformatbyindex(MaxXLCellFormats * cellFormats, size_t index) {
	return cellFormats->cellFormatByIndex(index);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlcellformat_free(MaxXLCellFormat * cellFormat) {
	delete cellFormat;
}

unsigned int bmx_openxlsx_xlcellformat_numberformatid(MaxXLCellFormat * cellFormat) {
	return cellFormat->numberFormatId();
}

size_t bmx_openxlsx_xlcellformat_fontindex(MaxXLCellFormat * cellFormat) {
	return cellFormat->fontIndex();
}

size_t bmx_openxlsx_xlcellformat_fillindex(MaxXLCellFormat * cellFormat) {
	return cellFormat->fillIndex();
}

size_t bmx_openxlsx_xlcellformat_borderindex(MaxXLCellFormat * cellFormat) {
	return cellFormat->borderIndex();
}

size_t bmx_openxlsx_xlcellformat_xfid(MaxXLCellFormat * cellFormat) {
	return cellFormat->xfId();
}

int bmx_openxlsx_xlcellformat_applynumberformat(MaxXLCellFormat * cellFormat) {
	return cellFormat->applyNumberFormat();
}

int bmx_openxlsx_xlcellformat_applyfont(MaxXLCellFormat * cellFormat) {
	return cellFormat->applyFont();
}

int bmx_openxlsx_xlcellformat_applyfill(MaxXLCellFormat * cellFormat) {
	return cellFormat->applyFill();
}

int bmx_openxlsx_xlcellformat_applyborder(MaxXLCellFormat * cellFormat) {
	return cellFormat->applyBorder();
}

int bmx_openxlsx_xlcellformat_applyalignment(MaxXLCellFormat * cellFormat) {
	return cellFormat->applyAlignment();
}

int bmx_openxlsx_xlcellformat_applyprotection(MaxXLCellFormat * cellFormat) {
	return cellFormat->applyProtection();
}

int bmx_openxlsx_xlcellformat_quoteprefix(MaxXLCellFormat * cellFormat) {
	return cellFormat->quotePrefix();
}

int bmx_openxlsx_xlcellformat_pivotbutton(MaxXLCellFormat * cellFormat) {
	return cellFormat->pivotButton();
}

int bmx_openxlsx_xlcellformat_locked(MaxXLCellFormat * cellFormat) {
	return cellFormat->locked();
}

int bmx_openxlsx_xlcellformat_hidden(MaxXLCellFormat * cellFormat) {
	return cellFormat->hidden();
}

MaxXLAlignment * bmx_openxlsx_xlcellformat_alignment(MaxXLCellFormat * cellFormat, int createIfMissing) {
	return cellFormat->alignment(createIfMissing);
}

int bmx_openxlsx_xlcellformat_setnumberformatid(MaxXLCellFormat * cellFormat, unsigned int newNumFmtId) {
	return cellFormat->setNumberFormatId(newNumFmtId);
}

int bmx_openxlsx_xlcellformat_setfontindex(MaxXLCellFormat * cellFormat, size_t newFontIndex) {
	return cellFormat->setFontIndex(newFontIndex);
}

int bmx_openxlsx_xlcellformat_setfillindex(MaxXLCellFormat * cellFormat, size_t newFillIndex) {
	return cellFormat->setFillIndex(newFillIndex);
}

int bmx_openxlsx_xlcellformat_setborderindex(MaxXLCellFormat * cellFormat, size_t newBorderIndex) {
	return cellFormat->setBorderIndex(newBorderIndex);
}

int bmx_openxlsx_xlcellformat_setxfid(MaxXLCellFormat * cellFormat, size_t newXfId) {
	return cellFormat->setXfId(newXfId);
}

int bmx_openxlsx_xlcellformat_setapplynumberformat(MaxXLCellFormat * cellFormat, int set) {
	return cellFormat->setApplyNumberFormat(set);
}

int bmx_openxlsx_xlcellformat_setapplyfont(MaxXLCellFormat * cellFormat, int set) {
	return cellFormat->setApplyFont(set);
}

int bmx_openxlsx_xlcellformat_setapplyfill(MaxXLCellFormat * cellFormat, int set) {
	return cellFormat->setApplyFill(set);
}

int bmx_openxlsx_xlcellformat_setapplyborder(MaxXLCellFormat * cellFormat, int set) {
	return cellFormat->setApplyBorder(set);
}

int bmx_openxlsx_xlcellformat_setapplyalignment(MaxXLCellFormat * cellFormat, int set) {
	return cellFormat->setApplyAlignment(set);
}

int bmx_openxlsx_xlcellformat_setapplyprotection(MaxXLCellFormat * cellFormat, int set) {
	return cellFormat->setApplyProtection(set);
}

int bmx_openxlsx_xlcellformat_setquoteprefix(MaxXLCellFormat * cellFormat, int set) {
	return cellFormat->setQuotePrefix(set);
}

int bmx_openxlsx_xlcellformat_setpivotbutton(MaxXLCellFormat * cellFormat, int set) {
	return cellFormat->setPivotButton(set);
}

int bmx_openxlsx_xlcellformat_setlocked(MaxXLCellFormat * cellFormat, int set) {
	return cellFormat->setLocked(set);
}

int bmx_openxlsx_xlcellformat_sethidden(MaxXLCellFormat * cellFormat, int set) {
	return cellFormat->setHidden(set);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlalignment_free(MaxXLAlignment * alignment) {
	delete alignment;
}

uint8_t bmx_openxlsx_xlalignment_horizontal(MaxXLAlignment * alignment) {
	return alignment->horizontal();
}

uint8_t bmx_openxlsx_xlalignment_vertical(MaxXLAlignment * alignment) {
	return alignment->vertical();
}

unsigned short bmx_openxlsx_xlalignment_textrotation(MaxXLAlignment * alignment) {
	return alignment->textRotation();
}

int bmx_openxlsx_xlalignment_wraptext(MaxXLAlignment * alignment) {
	return alignment->wrapText();
}

unsigned int bmx_openxlsx_xlalignment_indent(MaxXLAlignment * alignment) {
	return alignment->indent();
}

int bmx_openxlsx_xlalignment_relativeindent(MaxXLAlignment * alignment) {
	return alignment->relativeIndent();
}

int bmx_openxlsx_xlalignment_justifylastline(MaxXLAlignment * alignment) {
	return alignment->justifyLastLine();
}

int bmx_openxlsx_xlalignment_shrinktofit(MaxXLAlignment * alignment) {
	return alignment->shrinkToFit();
}

unsigned int bmx_openxlsx_xlalignment_readingorder(MaxXLAlignment * alignment) {
	return alignment->readingOrder();
}

int bmx_openxlsx_xlalignment_sethorizontal(MaxXLAlignment * alignment, uint8_t newStyle) {
	return alignment->setHorizontal(newStyle);
}

int bmx_openxlsx_xlalignment_setvertical(MaxXLAlignment * alignment, uint8_t newStyle) {
	return alignment->setVertical(newStyle);
}

int bmx_openxlsx_xlalignment_settextrotation(MaxXLAlignment * alignment, unsigned short rotation) {
	return alignment->setTextRotation(rotation);
}

int bmx_openxlsx_xlalignment_setwraptext(MaxXLAlignment * alignment, int set) {
	return alignment->setWrapText(set);
}

int bmx_openxlsx_xlalignment_setindent(MaxXLAlignment * alignment, unsigned int newIndent) {
	return alignment->setIndent(newIndent);
}

int bmx_openxlsx_xlalignment_setrelativeindent(MaxXLAlignment * alignment, int newIndent) {
	return alignment->setRelativeIndent(newIndent);
}

int bmx_openxlsx_xlalignment_setjustifylastline(MaxXLAlignment * alignment, int set) {
	return alignment->setJustifyLastLine(set);
}

int bmx_openxlsx_xlalignment_setshrinktofit(MaxXLAlignment * alignment, int set) {
	return alignment->setShrinkToFit(set);
}

int bmx_openxlsx_xlalignment_setreadingorder(MaxXLAlignment * alignment, unsigned int newReadingOrder) {
	return alignment->setReadingOrder(newReadingOrder);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlcellstyles_free(MaxXLCellStyles * cellStyles) {
	delete cellStyles;
}

size_t bmx_openxlsx_xlcellstyles_count(MaxXLCellStyles * cellStyles) {
	return cellStyles->count();
}

MaxXLCellStyle * bmx_openxlsx_xlcellstyles_cellstylebyindex(MaxXLCellStyles * cellStyles, size_t index) {
	return cellStyles->cellStyleByIndex(index);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlcellstyle_free(MaxXLCellStyle * cellStyle) {
	delete cellStyle;
}

int bmx_openxlsx_xlcellstyle_empty(MaxXLCellStyle * cellStyle) {
	return cellStyle->empty();
}

BBString * bmx_openxlsx_xlcellstyle_name(MaxXLCellStyle * cellStyle) {
	return cellStyle->name();
}

size_t bmx_openxlsx_xlcellstyle_xfid(MaxXLCellStyle * cellStyle) {
	return cellStyle->xfId();
}

unsigned int bmx_openxlsx_xlcellstyle_builtinid(MaxXLCellStyle * cellStyle) {
	return cellStyle->builtinId();
}

unsigned int bmx_openxlsx_xlcellstyle_outlinestyle(MaxXLCellStyle * cellStyle) {
	return cellStyle->outlineStyle();
}

int bmx_openxlsx_xlcellstyle_hidden(MaxXLCellStyle * cellStyle) {
	return cellStyle->hidden();
}

int bmx_openxlsx_xlcellstyle_custombuiltin(MaxXLCellStyle * cellStyle) {
	return cellStyle->customBuiltin();
}

int bmx_openxlsx_xlcellstyle_setname(MaxXLCellStyle * cellStyle, BBString * newName) {
	return cellStyle->setName(newName);
}

int bmx_openxlsx_xlcellstyle_setxfid(MaxXLCellStyle * cellStyle, size_t newXfId) {
	return cellStyle->setXfId(newXfId);
}

int bmx_openxlsx_xlcellstyle_setbuiltinid(MaxXLCellStyle * cellStyle, unsigned int newBuiltinId) {
	return cellStyle->setBuiltinId(newBuiltinId);
}

int bmx_openxlsx_xlcellstyle_setoutlinestyle(MaxXLCellStyle * cellStyle, unsigned int newOutlineStyle) {
	return cellStyle->setOutlineStyle(newOutlineStyle);
}

int bmx_openxlsx_xlcellstyle_sethidden(MaxXLCellStyle * cellStyle, int set) {
	return cellStyle->setHidden(set);
}

int bmx_openxlsx_xlcellstyle_setcustombuiltin(MaxXLCellStyle * cellStyle, int set) {
	return cellStyle->setCustomBuiltin(set);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlnumberformats_free(MaxXLNumberFormats * numberFormats) {
	delete numberFormats;
}

size_t bmx_openxlsx_xlnumberformats_count(MaxXLNumberFormats * numberFormats) {
	return numberFormats->count();
}

MaxXLNumberFormat * bmx_openxlsx_xlnumberformats_numberformatbyindex(MaxXLNumberFormats * numberFormats, size_t index) {
	return numberFormats->numberFormatByIndex(index);
}

MaxXLNumberFormat * bmx_openxlsx_xlnumberformats_numberformatbyid(MaxXLNumberFormats * numberFormats, unsigned int numFmtId) {
	return numberFormats->numberFormatById(numFmtId);
}

unsigned int bmx_openxlsx_xlnumberformats_numberformatidfromindex(MaxXLNumberFormats * numberFormats, size_t index) {
	return numberFormats->numberFormatIdFromIndex(index);
}

///////////////////////////////////////////////////////////

void bmx_openxlsx_xlnumberformat_free(MaxXLNumberFormat * numberFormat) {
	delete numberFormat;
}

unsigned int bmx_openxlsx_xlnumberformat_numberformatid(MaxXLNumberFormat * numberFormat) {
	return numberFormat->numberFormatId();
}

BBString * bmx_openxlsx_xlnumberformat_formatcode(MaxXLNumberFormat * numberFormat) {
	return numberFormat->formatCode();
}

int bmx_openxlsx_xlnumberformat_setnumberformatid(MaxXLNumberFormat * numberFormat, unsigned int newNumberFormatId) {
	return numberFormat->setNumberFormatId(newNumberFormatId);
}

int bmx_openxlsx_xlnumberformat_setformatcode(MaxXLNumberFormat * numberFormat, BBString * newFormatCode) {
	return numberFormat->setFormatCode(newFormatCode);
}
