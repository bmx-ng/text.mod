/*
  Copyright (c) 2023 Bruce A Henderson
  
  This software is provided 'as-is', without any express or implied
  warranty. In no event will the authors be held liable for any damages
  arising from the use of this software.
  
  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:
  
  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
*/ 
#include "hpdf.h"
#include "brl.mod/blitz.mod/blitz.h"

BBObject * text_pdf_TPDFException__create(BBUINT errorNo, BBUINT detailNo);
void text_pdf_TPDFDoc__setLastError(BBObject * error);


void bmx_pdf_HPDF_Error_Handler(HPDF_STATUS error_no, HPDF_STATUS detail_no, void * user_data) {
    BBObject * ex = text_pdf_TPDFException__create(error_no, detail_no);
    text_pdf_TPDFDoc__setLastError(ex);
}

HPDF_Doc bmx_pdf_HPDF_New() {
    return HPDF_New(bmx_pdf_HPDF_Error_Handler, NULL);
}
