/*
  Copyright (c) 2023 Bruce A Henderson
 
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
#include "md4c.h"
#include "brl.mod/blitz.mod/blitz.h"


int text_markdown_TMarkdown__EnterBlock(BBObject * obj, MD_BLOCKTYPE type, void * detail);
int text_markdown_TMarkdown__LeaveBlock(BBObject * obj, MD_BLOCKTYPE type, void * detail);
int text_markdown_TMarkdown__EnterSpan(BBObject * obj, MD_SPANTYPE type, void * detail);
int text_markdown_TMarkdown__LeaveSpan(BBObject * obj, MD_SPANTYPE type, void * detail);
int text_markdown_TMarkdown__Text(BBObject * obj, MD_TEXTTYPE type, BBString * text);
void text_markdown_TMarkdown__HtmlOutput(const MD_CHAR * txt, MD_SIZE size, BBObject * ob );

int bmx_md_cb_enter_block(MD_BLOCKTYPE type, void* detail, void* userdata) {
    return text_markdown_TMarkdown__EnterBlock((BBObject *)userdata, type, detail);
}

int bmx_md_cb_leave_block(MD_BLOCKTYPE type, void* detail, void* userdata) {
    return text_markdown_TMarkdown__LeaveBlock((BBObject *)userdata, type, detail);
}

int bmx_md_cb_enter_span(MD_SPANTYPE type, void* detail, void* userdata) {
    return text_markdown_TMarkdown__EnterSpan((BBObject *)userdata, type, detail);
}

int bmx_md_cb_leave_span(MD_SPANTYPE type, void* detail, void* userdata) {
    return text_markdown_TMarkdown__LeaveSpan((BBObject *)userdata, type, detail);
}

int bmx_md_cb_text(MD_TEXTTYPE type, const MD_CHAR* text, MD_SIZE size, void* userdata) {
    BBString * txt = bbStringFromUTF8Bytes((unsigned char*)text, size);
    return text_markdown_TMarkdown__Text((BBObject *)userdata, type, txt);
}

void bmx_md_cb_html_output(const MD_CHAR * txt, MD_SIZE size, void * userdata) {
    text_markdown_TMarkdown__HtmlOutput(txt, size, (BBObject*)userdata);
}

int bmx_md_parse(BBObject * obj, BBString * txt, int flags) {

    MD_PARSER parser = {
        1,
        flags,
        bmx_md_cb_enter_block,
        bmx_md_cb_leave_block,
        bmx_md_cb_enter_span,
        bmx_md_cb_leave_span,
        bmx_md_cb_text,
        0,
        0
    };

    char * t = bbStringToUTF8String(txt);
    MD_SIZE size = strlen(t);

    int res = md_parse(t, size, &parser, obj);

    bbMemFree(t);

    return res;
}

int bmx_md_html(BBString * text, BBObject * output, int parserFlags, int rendererFlags, int depth, char * ph) {

    MD_TOC_OPTIONS tocOptions = {
        depth,
        ph
    };

    char * t = bbStringToUTF8String(text);
    MD_SIZE size = strlen(t);

    int res = md_html(t, size, bmx_md_cb_html_output, output, parserFlags, rendererFlags, &tocOptions);

    bbMemFree(t);

    return res;
}

int bmx_md_blockul_istight(MD_BLOCK_UL_DETAIL * detail) {
    return detail->is_tight;
}

int bmx_md_blockul_mark(MD_BLOCK_UL_DETAIL * detail) {
    return detail->mark;
}

unsigned int bmx_md_blockol_start(MD_BLOCK_OL_DETAIL * detail) {
    return detail->start;
}

int bmx_md_blockol_istight(MD_BLOCK_OL_DETAIL * detail) {
    return detail->is_tight;
}

int bmx_md_blockol_markdelimiter(MD_BLOCK_OL_DETAIL * detail) {
    return detail->mark_delimiter;
}

int bmx_md_blockli_istask(MD_BLOCK_LI_DETAIL * detail) {
    return detail->is_task;
}

int bmx_md_blockli_taskmark(MD_BLOCK_LI_DETAIL * detail) {
    return detail->task_mark;
}

unsigned int bmx_md_blockli_taskmarkoffset(MD_BLOCK_LI_DETAIL * detail) {
    return detail->task_mark_offset;
}

unsigned int bmx_md_blockh_level(MD_BLOCK_H_DETAIL * detail) {
    return detail->level;
}

MD_ATTRIBUTE bmx_md_blockh_identifier(MD_BLOCK_H_DETAIL * detail) {
    return detail->identifier;
}

MD_ATTRIBUTE bmx_md_blockcode_info(MD_BLOCK_CODE_DETAIL * detail) {
    return detail->info;
}

MD_ATTRIBUTE bmx_md_blockcode_lang(MD_BLOCK_CODE_DETAIL * detail) {
    return detail->lang;
}

int bmx_md_blockcode_fencechar(MD_BLOCK_CODE_DETAIL * detail) {
    return detail->fence_char;
}

unsigned int bmx_md_blocktable_colcount(MD_BLOCK_TABLE_DETAIL * detail) {
    return detail->col_count;
}

unsigned int bmx_md_blocktable_headrowcount(MD_BLOCK_TABLE_DETAIL * detail) {
    return detail->head_row_count;
}

unsigned int bmx_md_blocktable_bodyrowcount(MD_BLOCK_TABLE_DETAIL * detail) {
    return detail->body_row_count;
}

MD_ALIGN bmx_md_blocktd_align(MD_BLOCK_TD_DETAIL * detail) {
    return detail->align;
}

MD_ATTRIBUTE bmx_md_spana_href(MD_SPAN_A_DETAIL * detail) {
    return detail->href;
}

MD_ATTRIBUTE bmx_md_spana_title(MD_SPAN_A_DETAIL * detail) {
    return detail->title;
}

MD_ATTRIBUTE bmx_md_spanimg_src(MD_SPAN_IMG_DETAIL * detail) {
    return detail->src;
}

MD_ATTRIBUTE bmx_md_spanimg_title(MD_SPAN_IMG_DETAIL * detail) {
    return detail->title;
}

MD_ATTRIBUTE bmx_md_spanwikilink_target(MD_SPAN_WIKILINK_DETAIL * detail) {
    return detail->target;
}
