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
#include "toml.hpp"
#include "brl.mod/blitz.mod/blitz.h"


extern "C" {

    struct TomlDate
	{
		uint16_t year;
		uint8_t month;
		uint8_t day;
    };

    struct TomlTime
	{
		uint8_t hour;
		uint8_t minute;
		uint8_t second;
		uint32_t nanosecond;
    };

    struct TomlTimeOffset
	{
		int16_t minutes;
    };

    struct TomlOptionalOffset
    {
        uint8_t hasValue;
        struct TomlTimeOffset offset;
    };

    struct TomlDateTime
	{
		struct TomlDate date;
		struct TomlTime time;
		struct TomlOptionalOffset offset;
    };

    struct TomlSourcePosition
    {
        uint32_t line;
        uint32_t column;
    };

    BBObject * text_toml_TTomlTable__create();
    void text_toml_TTomlTable__Add(BBObject * table, BBString * key, BBObject * value);

    BBObject * text_toml_TTomlArray__create(int size);
    void text_toml_TTomlArray__Set(BBObject * arr, int index, BBObject * value);

    BBObject * text_toml_TTomlString__create(BBString * value);
    BBObject * text_toml_TTomlInteger__create(BBLONG value);
    BBObject * text_toml_TTomlFloatingPoint__create(BBDOUBLE value);
    BBObject * text_toml_TTomlBoolean__create(BBINT value);
    BBObject * text_toml_TTomlDate__create(struct TomlDate value);
    BBObject * text_toml_TTomlTime__create(struct TomlTime value);
    BBObject * text_toml_TTomlDateTime__create(struct TomlDateTime value);

    BBObject * text_toml_common_TTomlSourceRegion__create(struct TomlSourcePosition begin, struct TomlSourcePosition end, BBString * path);
    BBObject * text_toml_TTomlParseError__create(BBString * message, BBObject * region);

    BBObject * bmx_toml_parse_string(BBString * s);

    BBObject * bmx_toml_build_node(toml::node * node);
    BBObject * bmx_toml_build_table(toml::table & table);
    BBObject * bmx_toml_build_array(toml::array & array);
    BBObject * bmx_toml_build_string(toml::value<std::string> & value);
    BBObject * bmx_toml_build_integer(toml::value<int64_t> & value);
    BBObject * bmx_toml_build_floating_point(toml::value<double> & value);
    BBObject * bmx_toml_build_boolean(toml::value<bool> & value);
    BBObject * bmx_toml_build_date(toml::value<toml::date> & value);
    BBObject * bmx_toml_build_time(toml::value<toml::time> & value);
    BBObject * bmx_toml_build_date_time(toml::value<toml::date_time> & value);
}

BBObject * bmx_toml_build_node(toml::node * node) {
    switch (node->type()) {
        case toml::node_type::table: {
            return bmx_toml_build_table(*node->as_table());
        }
        case toml::node_type::array: {
            return bmx_toml_build_array(*node->as_array());
        }
        case toml::node_type::string: {
            return bmx_toml_build_string(*node->as_string());
        }
        case toml::node_type::integer: {
            return bmx_toml_build_integer(*node->as_integer());
        }
        case toml::node_type::floating_point: {
            return bmx_toml_build_floating_point(*node->as_floating_point());
        }
        case toml::node_type::boolean: {
            return bmx_toml_build_boolean(*node->as_boolean());
        }
        case toml::node_type::date: {
            return bmx_toml_build_date(*node->as_date());
        }
        case toml::node_type::time: {
            return bmx_toml_build_time(*node->as_time());
        }
        case toml::node_type::date_time: {
            return bmx_toml_build_date_time(*node->as_date_time());
        }
    }
}

BBObject * bmx_toml_build_table(toml::table & table) {
    BBObject * bmxTable = text_toml_TTomlTable__create();

    for (auto && [key, value] : table) {
		auto k = std::string(key);
		auto node = bmx_toml_build_node(&value);

        auto s = bbStringFromUTF8Bytes((unsigned char*)k.c_str(), k.size());

        text_toml_TTomlTable__Add(bmxTable, s, node);
	}

    return bmxTable;
}

BBObject * bmx_toml_build_array(toml::array & array) {
    size_t size = array.size();
    BBObject * bmxArray = text_toml_TTomlArray__create(size);

    for (size_t i = 0; i < size; i++) {
        auto node = bmx_toml_build_node(array.get(i));
		text_toml_TTomlArray__Set(bmxArray, i, node);
    }

    return bmxArray;
}

BBObject * bmx_toml_build_string(toml::value<std::string> & value) {
    BBString * s = bbStringFromUTF8Bytes((unsigned char*)value->c_str(), value->size());
    return text_toml_TTomlString__create(s);
}

BBObject * bmx_toml_build_integer(toml::value<int64_t> & value) {
    return text_toml_TTomlInteger__create(*value);
}

BBObject * bmx_toml_build_floating_point(toml::value<double> & value) {
    return text_toml_TTomlFloatingPoint__create(*value);
}

BBObject * bmx_toml_build_boolean(toml::value<bool> & value) {
    return text_toml_TTomlBoolean__create(*value);
}

BBObject * bmx_toml_build_date(toml::value<toml::date> & value) {
    struct TomlDate d = {value->year, value->month, value->day};
    return text_toml_TTomlDate__create(d);
}

BBObject * bmx_toml_build_time(toml::value<toml::time> & value) {
    struct TomlTime t = {value->hour, value->minute, value->second, value->nanosecond};
    return text_toml_TTomlTime__create(t);
}

BBObject * bmx_toml_build_date_time(toml::value<toml::date_time> & value) {
    struct TomlDateTime dt = {.date = {value->date.year, value->date.month, value->date.day}, 
                              .time = {value->time.hour, value->time.minute, value->time.second, value->time.nanosecond},
                              .offset = {value->offset.has_value(), {value->offset.has_value() ? value->offset.value().minutes : (int16_t)0}}};
    return text_toml_TTomlDateTime__create(dt);
}

///////////////////////////////////////////////////////////

BBObject * bmx_toml_parse_string(BBString * doc) {
    try {

        char * d = (char*)bbStringToUTF8String(doc);

        std::string cdoc(d);

        bbMemFree(d);

        auto res = toml::parse(cdoc);

        BBObject * table = bmx_toml_build_table(res);

        return table;

    } catch (toml::parse_error & e) {
        auto source = e.source();

        BBString * path;
        if (source.path) {
            path = bbStringFromUTF8Bytes((unsigned char*)source.path->c_str(), source.path->size());
        }
        else {
            path = &bbEmptyString;
        }

        BBObject * region = text_toml_common_TTomlSourceRegion__create({ source.begin.line, source.begin.column }, { source.end.line, source.end.column }, path);

        unsigned char * message = (unsigned char*)e.what();
        BBObject * ex = text_toml_TTomlParseError__create(bbStringFromUTF8String(message), region);

        bbExThrow(ex);
    }

    return &bbNullObject;
}


