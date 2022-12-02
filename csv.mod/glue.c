/*
  Copyright (c) 2022 Bruce A Henderson
 
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
*/ 

#include "brl.mod/blitz.mod/blitz.h"

#include <stdlib.h>
#include "zsv.h"

extern size_t text_csv_TCsvParser__ReadStream(void * data, size_t n, size_t size, void * obj);

struct zsv_opts * bmx_csv_opts_new(BBObject * obj) {
    struct zsv_opts * opts = (struct zsv_opts *)calloc(1, sizeof(struct zsv_opts));
    opts->ctx = obj;
    opts->read = text_csv_TCsvParser__ReadStream;
    opts->stream = obj;
    return opts;
}

void bmx_csv_opts_free(struct zsv_opts * opts) {
    free(opts);
}

void bmx_csv_opts_set_options(struct zsv_opts * opts, BBUINT maxColumns, int delimiter, int noQuotes, char * insertHeaderRow, BBUINT headerSpan, BBUINT rowsToIgnore, BBUINT keepEmptyHeaderRows) {
    opts->max_columns = maxColumns;
    opts->delimiter = (char)delimiter;
    opts->no_quotes = (char)noQuotes;
    opts->insert_header_row = insertHeaderRow;
    opts->header_span = headerSpan;
    opts->rows_to_ignore = rowsToIgnore;
    opts->keep_empty_header_rows = keepEmptyHeaderRows;
}
