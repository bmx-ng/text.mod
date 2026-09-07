/*
 Copyright (c) 2026 Bruce A Henderson

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
#include <string.h>
#include <limits.h>
#include "mpack/mpack.h"
#include "brl.mod/blitz.mod/blitz.h"

extern int text_mpack_TMPackWriter__Flush(BBObject * obj, char * buffer, size_t count);
extern size_t text_mpack_TMPackReader__Fill(BBObject * obj, char * buffer, size_t count);
extern int text_mpack_TMPackReader__FillFailed(BBObject * obj);

typedef struct bmx_mpack_writer {
    mpack_writer_t writer;
    char *growable_data;
    size_t growable_size;
    int growable;
} bmx_mpack_writer;

static bmx_mpack_writer * bmx_mpack_writer_alloc(void) {
    bmx_mpack_writer * wrapper = (bmx_mpack_writer *)calloc(1, sizeof(bmx_mpack_writer));
    return wrapper;
}


static void bmx_flush_callback(mpack_writer_t* writer, const char* buffer, size_t count) {
    BBObject * obj = (BBObject *)mpack_writer_context(writer);
    if (!text_mpack_TMPackWriter__Flush(obj, (char *)buffer, count)) {
        mpack_writer_flag_error(writer, mpack_error_io);
    }
}

mpack_error_t bmx_mpack_writer_destroy(mpack_writer_t * writer) {
    bmx_mpack_writer * wrapper = (bmx_mpack_writer *)writer;
    mpack_error_t res = mpack_writer_destroy(writer);
    if (wrapper->growable_data)
        MPACK_FREE(wrapper->growable_data);
    free(wrapper);
    return res;
}

mpack_writer_t * bmx_mpack_writer_init(BBObject * obj, void * buffer, int length) {
    bmx_mpack_writer * wrapper = bmx_mpack_writer_alloc();
    if (!wrapper)
        return NULL;
    mpack_writer_t * writer = &wrapper->writer;
    mpack_writer_init(writer, buffer, length);
    mpack_writer_set_context(writer, obj);
    mpack_writer_set_flush(writer, bmx_flush_callback);
    return writer;
}

mpack_writer_t * bmx_mpack_writer_init_memory(void * buffer, size_t length) {
    bmx_mpack_writer * wrapper = bmx_mpack_writer_alloc();
    if (!wrapper)
        return NULL;
    mpack_writer_t * writer = &wrapper->writer;
    mpack_writer_init(writer, (char *)buffer, length);
    return writer;
}

mpack_writer_t * bmx_mpack_writer_init_growable(void) {
    bmx_mpack_writer * wrapper = bmx_mpack_writer_alloc();
    if (!wrapper)
        return NULL;
    wrapper->growable = 1;
    mpack_writer_init_growable(&wrapper->writer, &wrapper->growable_data, &wrapper->growable_size);
    return &wrapper->writer;
}

BBArray * bmx_mpack_writer_destroy_to_array(mpack_writer_t * writer, int * error) {
    bmx_mpack_writer * wrapper = (bmx_mpack_writer *)writer;
    if (!wrapper->growable) {
        mpack_writer_flag_error(writer, mpack_error_bug);
        *error = (int)mpack_writer_destroy(writer);
        free(wrapper);
        return &bbEmptyArray;
    }

    mpack_error_t result = mpack_writer_destroy(writer);
    if (result != mpack_ok || wrapper->growable_size > INT_MAX) {
        if (result == mpack_ok)
            result = mpack_error_too_big;
        if (wrapper->growable_data)
            MPACK_FREE(wrapper->growable_data);
        free(wrapper);
        *error = (int)result;
        return &bbEmptyArray;
    }

    BBArray * array = bbArrayNew1D("b", (int)wrapper->growable_size);
    if (wrapper->growable_size != 0) {
        if (!array || array == &bbEmptyArray) {
            MPACK_FREE(wrapper->growable_data);
            free(wrapper);
            *error = (int)mpack_error_memory;
            return &bbEmptyArray;
        }
        memcpy(BBARRAYDATA(array, array->dims), wrapper->growable_data, wrapper->growable_size);
    }
    if (wrapper->growable_data)
        MPACK_FREE(wrapper->growable_data);
    free(wrapper);
    *error = (int)mpack_ok;
    return array;
}

void bmx_mpack_write_utf8(mpack_writer_t* writer, BBString * txt, uint32_t max_length) {
    size_t len = 0;
    unsigned char * s = bbStringToUTF8StringLen(txt, &len);
    if (!s) {
        mpack_writer_flag_error(writer, mpack_error_memory);
        return;
    }
    if (len > UINT32_MAX || len > max_length) {
        bbMemFree(s);
        mpack_writer_flag_error(writer, mpack_error_too_big);
        return;
    }
    mpack_write_utf8(writer, (const char *)s, (uint32_t)len);
    bbMemFree(s);
}

void bmx_mpack_writer_flag_error(mpack_writer_t * writer, int error) {
    mpack_writer_flag_error(writer, (mpack_error_t)error);
}

///////////////////////////////////////////////////////////

static size_t bmx_fill_callback(mpack_reader_t * reader, char * buffer, size_t count) {
    BBObject * obj = (BBObject *)mpack_reader_context(reader);
    size_t result = text_mpack_TMPackReader__Fill(obj, buffer, count);
    if (text_mpack_TMPackReader__FillFailed(obj))
        mpack_reader_flag_error(reader, mpack_error_io);
    return result;
}

mpack_reader_t * bmx_mpack_reader_init(BBObject * obj, void * buffer, int length) {
    mpack_reader_t * reader = (mpack_reader_t *)malloc(sizeof(mpack_reader_t));
    if (!reader)
        return NULL;
    mpack_reader_init(reader, buffer, length, 0);
    mpack_reader_set_context(reader, obj);
    mpack_reader_set_fill(reader, bmx_fill_callback);
    return reader;
}

mpack_reader_t * bmx_mpack_reader_init_memory(const void * data, size_t length) {
	static const char empty_data = 0;
    mpack_reader_t * reader = (mpack_reader_t *)malloc(sizeof(mpack_reader_t));
    if (!reader)
        return NULL;
	if (!data && length == 0)
		data = &empty_data;
    mpack_reader_init_data(reader, (const char *)data, length);
    return reader;
}

mpack_error_t bmx_mpack_reader_destroy(mpack_reader_t * reader) {
    mpack_error_t res = mpack_reader_destroy(reader);
    free(reader);
    return res;
}

mpack_type_t bmx_mpack_tag_type(mpack_reader_t * reader) {
    mpack_tag_t tag = mpack_peek_tag(reader);
    return mpack_tag_type(&tag);
}

BBString * bmx_mpack_read_utf8(mpack_reader_t * reader, uint32_t maxLength) {
    uint32_t len = mpack_expect_str(reader);
    if (len > maxLength)
        mpack_reader_flag_error(reader, mpack_error_too_big);
    if (mpack_reader_error(reader) != mpack_ok)
        return &bbEmptyString;

    if (len == 0) {
        mpack_done_str(reader);
        return &bbEmptyString;
    }

    unsigned char * t = (unsigned char *)MPACK_MALLOC(len);
    if (!t) {
        mpack_reader_flag_error(reader, mpack_error_memory);
        return &bbEmptyString;
    }
    mpack_read_utf8(reader, (char *)t, len);
    mpack_done_str(reader);
    if (mpack_reader_error(reader) != mpack_ok) {
        MPACK_FREE(t);
        return &bbEmptyString;
    }
    BBString * txt = bbStringFromUTF8Bytes(t, (int)len);
    if (txt == &bbEmptyString)
        mpack_reader_flag_error(reader, mpack_error_memory);
    MPACK_FREE(t);
    return txt;
}

uint32_t bmx_mpack_expect_str_max(mpack_reader_t * reader, uint32_t max_length) {
    uint32_t length = mpack_expect_str(reader);
    if (length > max_length)
        mpack_reader_flag_error(reader, mpack_error_too_big);
    return length;
}

uint32_t bmx_mpack_expect_bin_max(mpack_reader_t * reader, uint32_t max_length) {
    uint32_t length = mpack_expect_bin(reader);
    if (length > max_length)
        mpack_reader_flag_error(reader, mpack_error_too_big);
    return length;
}

uint32_t bmx_mpack_expect_array_max(mpack_reader_t * reader, uint32_t max_count) {
    uint32_t count = mpack_expect_array(reader);
    if (count > max_count)
        mpack_reader_flag_error(reader, mpack_error_too_big);
    return count;
}

uint32_t bmx_mpack_expect_map_max(mpack_reader_t * reader, uint32_t max_count) {
    uint32_t count = mpack_expect_map(reader);
    if (count > max_count)
        mpack_reader_flag_error(reader, mpack_error_too_big);
    return count;
}

uint32_t bmx_mpack_expect_ext(mpack_reader_t * reader, int * type) {
    int8_t ext_type = 0;
    uint32_t length = mpack_expect_ext(reader, &ext_type);
    *type = (int)ext_type;
    return length;
}

void bmx_mpack_read_timestamp(mpack_reader_t * reader, int64_t * seconds, uint32_t * nanoseconds) {
    mpack_timestamp_t timestamp = mpack_expect_timestamp(reader);
    *seconds = timestamp.seconds;
    *nanoseconds = timestamp.nanoseconds;
}

void bmx_mpack_reader_flag_error(mpack_reader_t * reader, int error) {
    mpack_reader_flag_error(reader, (mpack_error_t)error);
}

static void bmx_mpack_discard_one(mpack_reader_t * reader, uint32_t max_container_elements,
        uint32_t max_string_bytes, uint32_t max_binary_bytes, unsigned depth, unsigned max_depth) {
    if (depth > max_depth) {
        mpack_reader_flag_error(reader, mpack_error_too_big);
        return;
    }

    mpack_tag_t tag = mpack_read_tag(reader);
    if (mpack_reader_error(reader) != mpack_ok)
        return;

    switch (mpack_tag_type(&tag)) {
        case mpack_type_str: {
            uint32_t length = mpack_tag_str_length(&tag);
            if (length > max_string_bytes) {
                mpack_reader_flag_error(reader, mpack_error_too_big);
                return;
            }
            mpack_skip_bytes(reader, length);
            mpack_done_str(reader);
            return;
        }
        case mpack_type_bin: {
            uint32_t length = mpack_tag_bin_length(&tag);
            if (length > max_binary_bytes) {
                mpack_reader_flag_error(reader, mpack_error_too_big);
                return;
            }
            mpack_skip_bytes(reader, length);
            mpack_done_bin(reader);
            return;
        }
        case mpack_type_ext: {
            uint32_t length = mpack_tag_ext_length(&tag);
            if (length > max_binary_bytes) {
                mpack_reader_flag_error(reader, mpack_error_too_big);
                return;
            }
            mpack_skip_bytes(reader, length);
            mpack_done_ext(reader);
            return;
        }
        case mpack_type_array: {
            uint32_t count = mpack_tag_array_count(&tag);
            if (count > max_container_elements) {
                mpack_reader_flag_error(reader, mpack_error_too_big);
                return;
            }
            for (uint32_t i = 0; i < count && mpack_reader_error(reader) == mpack_ok; ++i)
                bmx_mpack_discard_one(reader, max_container_elements, max_string_bytes,
                        max_binary_bytes, depth + 1, max_depth);
            mpack_done_array(reader);
            return;
        }
        case mpack_type_map: {
            uint32_t count = mpack_tag_map_count(&tag);
            if (count > max_container_elements) {
                mpack_reader_flag_error(reader, mpack_error_too_big);
                return;
            }
            for (uint32_t i = 0; i < count && mpack_reader_error(reader) == mpack_ok; ++i) {
                bmx_mpack_discard_one(reader, max_container_elements, max_string_bytes,
                        max_binary_bytes, depth + 1, max_depth);
                bmx_mpack_discard_one(reader, max_container_elements, max_string_bytes,
                        max_binary_bytes, depth + 1, max_depth);
            }
            mpack_done_map(reader);
            return;
        }
        default:
            return;
    }
}

void bmx_mpack_discard_limited(mpack_reader_t * reader, uint32_t max_container_elements,
        uint32_t max_string_bytes, uint32_t max_binary_bytes, int max_depth) {
    if (max_depth < 0) {
        mpack_reader_flag_error(reader, mpack_error_too_big);
        return;
    }
    bmx_mpack_discard_one(reader, max_container_elements, max_string_bytes,
            max_binary_bytes, 1, (unsigned)max_depth);
}
