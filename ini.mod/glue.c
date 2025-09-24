/*
  Copyright (c) 2022-2025 Bruce A Henderson
 
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
#define INI_IMPLEMENTATION
#include "ini.h"

#include "brl.mod/blitz.mod/blitz.h"


BBString * bmx_ini_section_name(ini_t const * ini, int section) {
    char * n = ini_section_name(ini, section);
    if (n) {
        return bbStringFromUTF8String(n);
    } else {
        return &bbEmptyString;
    }
}

void bmx_ini_section_name_set(ini_t const * ini, int section, BBString * name) {
    char * n = (char*)bbStringToUTF8String(name);
    ini_section_name_set(ini, section, n, 0);
    bbMemFree(n);
}

int bmx_ini_find_section(ini_t const * ini, BBString * name) {
    char * n = (char*)bbStringToUTF8String(name);
    int index = ini_find_section(ini, n, 0);
    bbMemFree(n);
    return index;
}

int bmx_ini_section_add(ini_t const * ini, BBString * name) {
    char * n = (char*)bbStringToUTF8String(name);
    int index = ini_section_add(ini, n, 0);
    bbMemFree(n);
    return index;
}

BBString * bmx_ini_property_name(ini_t const * ini, int section, int property) {
   char * n = ini_property_name(ini, section, property);
    if (n) {
        return bbStringFromUTF8String(n);
    } else {
        return &bbEmptyString;
    }
}

BBString * bmx_ini_property_value(ini_t const * ini, int section, int property) {
    char * n = ini_property_value(ini, section, property);
    if (n) {
        return bbStringFromUTF8String(n);
    } else {
        return &bbEmptyString;
    }
}

void bmx_ini_property_add(ini_t const * ini, int section, BBString * name, BBString * value) {
    char * n = (char*)bbStringToUTF8String(name);
    char * v = (char*)bbStringToUTF8String(value);
    ini_property_add(ini, section, n, 0, v, 0);
    bbMemFree(v);
    bbMemFree(n);
}

void bmx_ini_property_value_set(ini_t const * ini, int section, int property, BBString * value) {
    char * v = (char*)bbStringToUTF8String(value);
    ini_property_value_set(ini, section, property, v, 0);
    bbMemFree(v);
}

void bmx_ini_property_name_set(ini_t const * ini, int section, int property, BBString * name) {
    char * n = (char*)bbStringToUTF8String(name);
    ini_property_name_set(ini, section, property, n, 0);
    bbMemFree(n);
}
