/*
  Copyright (c) 2024 Bruce A Henderson
 
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

#include <hb-ft.h>
#include "brl.mod/blitz.mod/blitz.h"

#define SMALLCAPSFONT 0x100
#define ALLSMALLCAPSFONT 0x200
#define LIGATURESFONT 0x400
#define DISCRETIONARY_LIGATURESFONT 0x800
#define OLDSTYLEFIGURESFONT 0x1000
#define TABULARFIGURESFONT 0x2000
#define FRACTIONSFONT 0x4000
#define SUPERSCRIPTFONT 0x8000
#define SUBSCRIPTFONT 0x10000
#define SWASHESFONT 0x20000
#define STYLISTICALTERNATESFONT 0x40000
#define CONTEXTUALALTERNATESFONT 0x80000
#define HISTORICALFORMSFONT 0x100000
#define DENOMINATORSFONT 0x200000
#define NUMERATORFONT 0x400000
#define LININGFIGURESFONT 0x800000
#define SCIENTIFICINFERIORSFONT 0x1000000
#define PROPORTIONALFIGURESFONT 0x2000000
#define KERNFONT 0x4000000
#define ZEROFONT 0x8000000

struct {
        int flag;
        hb_feature_t feature;
} style_features[] = {
        {LIGATURESFONT, {HB_TAG('l', 'i', 'g', 'a'), 1, 0, (unsigned int)-1}},
        {DISCRETIONARY_LIGATURESFONT, {HB_TAG('d', 'l', 'i', 'g'), 1, 0, (unsigned int)-1}},
        {SMALLCAPSFONT, {HB_TAG('s', 'm', 'c', 'p'), 1, 0, (unsigned int)-1}},
        {ALLSMALLCAPSFONT, {HB_TAG('c', '2', 's', 'c'), 1, 0, (unsigned int)-1}},
        {OLDSTYLEFIGURESFONT, {HB_TAG('o', 'n', 'u', 'm'), 1, 0, (unsigned int)-1}},
        {TABULARFIGURESFONT, {HB_TAG('t', 'n', 'u', 'm'), 1, 0, (unsigned int)-1}},
        {FRACTIONSFONT, {HB_TAG('f', 'r', 'a', 'c'), 1, 0, (unsigned int)-1}},
        {SUPERSCRIPTFONT, {HB_TAG('s', 'u', 'p', 's'), 1, 0, (unsigned int)-1}},
        {SUBSCRIPTFONT, {HB_TAG('s', 'u', 'b', 's'), 1, 0, (unsigned int)-1}},
        {SWASHESFONT, {HB_TAG('s', 'w', 's', 'h'), 1, 0, (unsigned int)-1}},
        {STYLISTICALTERNATESFONT, {HB_TAG('s', 'a', 'l', 't'), 1, 0, (unsigned int)-1}},
        {CONTEXTUALALTERNATESFONT, {HB_TAG('c', 'a', 'l', 't'), 1, 0, (unsigned int)-1}},
        {HISTORICALFORMSFONT, {HB_TAG('h', 'i', 's', 't'), 1, 0, (unsigned int)-1}},
        {DENOMINATORSFONT, {HB_TAG('d', 'n', 'o', 'm'), 1, 0, (unsigned int)-1}},
        {NUMERATORFONT, {HB_TAG('n', 'u', 'm', 'r'), 1, 0, (unsigned int)-1}},
        {LININGFIGURESFONT, {HB_TAG('l', 'n', 'u', 'm'), 1, 0, (unsigned int)-1}},
        {SCIENTIFICINFERIORSFONT, {HB_TAG('s', 'i', 'n', 'f'), 1, 0, (unsigned int)-1}},
        {PROPORTIONALFIGURESFONT, {HB_TAG('p', 'n', 'u', 'm'), 1, 0, (unsigned int)-1}},
        {KERNFONT, {HB_TAG('k', 'e', 'r', 'n'), 1, 0, (unsigned int)-1}},
        {ZEROFONT, {HB_TAG('z', 'e', 'r', 'o'), 1, 0, (unsigned int)-1}}
};
static int num_styles = sizeof(style_features) / sizeof(style_features[0]);

typedef struct {
    int glyphIndex;
    int x_advance;
    int y_advance;
    int x_offset;
    int y_offset;
} MaxGlyphInfo;

hb_font_t * bmx_hb_ft_font_create(FT_Face ft_face) {
    return hb_ft_font_create(ft_face, NULL);
}

void bmx_hb_ft_font_destroy(hb_font_t * font) {
    hb_font_destroy(font);
}

hb_feature_t * bmx_hb_ft_font_features( int style, int * length ) {
    int count = 0;

    for (int i = 0; i < num_styles; ++i) {
        if (style & style_features[i].flag) {
            ++count;
        }
    }

    // If no styles are enabled, return NULL
    if (count == 0) {
        *length = 0;
        return NULL;
    }

    // Allocate memory for the features array
    hb_feature_t* features = (hb_feature_t*)malloc(count * sizeof(hb_feature_t));
    if (!features) {
        *length = 0;
        return NULL;
    }

    // Populate the features array with the enabled features
    int index = 0;
    for (int i = 0; i < num_styles; ++i) {
        if (style & style_features[i].flag) {
            features[index++] = style_features[i].feature;
        }
    }

    *length = count;
    return features;
}

hb_buffer_t * bmx_hb_buffer_create() {
    hb_buffer_t * buffer = hb_buffer_create();
    return buffer;
}

void bmx_hb_buffer_destroy(hb_buffer_t * buffer) {
    hb_buffer_destroy(buffer);
}

void bmx_hb_features_destroy(hb_feature_t * features) {
    free(features);
}

void bmx_hb_buffer_calc_glyph_info(hb_font_t * font, hb_buffer_t * buffer, hb_feature_t * features, int featuresLength, int character, MaxGlyphInfo * glyphInfo) {
    hb_buffer_clear_contents(buffer);
    hb_buffer_set_content_type(buffer, HB_BUFFER_CONTENT_TYPE_UNICODE);
    hb_buffer_add(buffer, character, 0);
    hb_buffer_guess_segment_properties(buffer);

    hb_shape(font, buffer, featuresLength > 0 ? features : NULL, featuresLength);

    hb_glyph_info_t * infos = hb_buffer_get_glyph_infos(buffer, NULL);
    hb_glyph_position_t * positions = hb_buffer_get_glyph_positions(buffer, NULL);

    glyphInfo->glyphIndex = infos[0].codepoint;
    glyphInfo->x_advance = positions[0].x_advance;
    glyphInfo->y_advance = positions[0].y_advance;
    glyphInfo->x_offset = positions[0].x_offset;
    glyphInfo->y_offset = positions[0].y_offset;
}

static void bmx_hb_prepare_run(hb_font_t *font, hb_buffer_t *buffer, hb_feature_t *features, int featuresLength, BBString *text, int first, int runLength, int rtl, int script, BBString *language) {
	hb_buffer_reset(buffer);
	hb_buffer_set_content_type(buffer, HB_BUFFER_CONTENT_TYPE_UNICODE);
	hb_buffer_add_utf16(buffer, text->buf, text->length, first, runLength);
	if (rtl >= 0) hb_buffer_set_direction(buffer, rtl ? HB_DIRECTION_RTL : HB_DIRECTION_LTR);
	if (script) hb_buffer_set_script(buffer, hb_script_from_iso15924_tag((hb_tag_t)script));
	if (language && language->length) {
		char *value = (char *)bbStringToUTF8String(language);
		hb_buffer_set_language(buffer, hb_language_from_string(value, -1));
		bbMemFree(value);
	}
	hb_buffer_set_flags(buffer, (first == 0 ? HB_BUFFER_FLAG_BOT : 0) |
		(first + runLength == text->length ? HB_BUFFER_FLAG_EOT : 0));
	hb_buffer_guess_segment_properties(buffer);

	hb_shape(font, buffer, featuresLength > 0 ? features : NULL, featuresLength);
}

MaxGlyphInfo * bmx_hb_buffer_calc_run_info(hb_font_t * font, hb_buffer_t * buffer, hb_feature_t * features, int featuresLength, BBString * text, int * length, int first, int runLength, int rtl, int script, BBString *language) {
	bmx_hb_prepare_run(font, buffer, features, featuresLength, text, first, runLength, rtl, script, language);

	int count = hb_buffer_get_length(buffer);
	hb_glyph_info_t * infos = hb_buffer_get_glyph_infos(buffer, NULL);
	hb_glyph_position_t * positions = hb_buffer_get_glyph_positions(buffer, NULL);

	*length = count;
	MaxGlyphInfo * glyphInfo = (MaxGlyphInfo*)malloc(count * sizeof(MaxGlyphInfo));

	for (int i = 0; i < count; ++i) {
		glyphInfo[i].glyphIndex = infos[i].codepoint;
		glyphInfo[i].x_advance = positions[i].x_advance;
		glyphInfo[i].y_advance = positions[i].y_advance;
		glyphInfo[i].x_offset = positions[i].x_offset;
		glyphInfo[i].y_offset = positions[i].y_offset;
	}

	return glyphInfo;
}

MaxGlyphInfo * bmx_hb_buffer_calc_glyphs_info(hb_font_t *font, hb_buffer_t *buffer,
		hb_feature_t *features, int featuresLength, BBString *text, int *length) {
	return bmx_hb_buffer_calc_run_info(font, buffer, features, featuresLength, text,
		length, 0, text->length, -1, 0, NULL);
}

void bmx_hb_buffer_calc_glyphs_info_destroy(MaxGlyphInfo * glyphInfo) {
    free(glyphInfo);
}

/* Optional cluster-edge carets. Existing glyph ABI remains unchanged.
 * Positions are in shaping units, like x_advance; the caller scales them.
 * Only horizontal runs with monotone source clusters are supported.
 */
int bmx_hb_buffer_run_carets(hb_font_t *font, hb_buffer_t *buffer,
		hb_feature_t *features, int featuresLength, BBString *text,
		float *output, unsigned char *valid, int first, int runLength, int requestedRTL, int script, BBString *language) {
	bmx_hb_prepare_run(font, buffer, features, featuresLength, text,
		first, runLength, requestedRTL, script, language);
	hb_direction_t direction = hb_buffer_get_direction(buffer);
	if (!HB_DIRECTION_IS_HORIZONTAL(direction)) return 0;
	unsigned int count = hb_buffer_get_length(buffer);
	hb_glyph_info_t *infos = hb_buffer_get_glyph_infos(buffer, NULL);
	hb_glyph_position_t *positions = hb_buffer_get_glyph_positions(buffer, NULL);
	int rtl = direction == HB_DIRECTION_RTL;
	float pen = 0;
	unsigned int previous = rtl ? runLength : 0;
	for (unsigned int i = 0; i < count;) {
		unsigned int cluster = infos[i].cluster - first;
		if (cluster >= (unsigned int)runLength ||
			(rtl ? cluster > previous : cluster < previous)) return 0;
		float start = pen;
		do {
			pen += positions[i].x_advance;
			++i;
		} while (i < count && infos[i].cluster == cluster + first);
		output[cluster] = rtl ? pen : start;
		valid[cluster] = 1;
		previous = cluster;
	}
	output[runLength] = rtl ? 0 : pen;
	valid[runLength] = 1;
	if (!count) { output[0] = 0; valid[0] = 1; }
	return 1;
}

int bmx_hb_buffer_caret_positions(hb_font_t *font, hb_buffer_t *buffer,
		hb_feature_t *features, int featuresLength, BBString *text, float *output, unsigned char *valid) {
	return bmx_hb_buffer_run_carets(font, buffer, features, featuresLength, text,
		output, valid, 0, text->length, -1, 0, NULL);
}

/* Read cluster metadata from the most recently shaped buffer without reshaping. */
int bmx_hb_buffer_glyph_cluster(hb_buffer_t *buffer, int index) {
	unsigned int count;
	hb_glyph_info_t *info = hb_buffer_get_glyph_infos(buffer, &count);
	return index >= 0 && (unsigned int)index < count ? (int)info[index].cluster : -1;
}

int bmx_hb_buffer_is_rtl(hb_buffer_t *buffer) {
	return hb_buffer_get_direction(buffer) == HB_DIRECTION_RTL;
}
