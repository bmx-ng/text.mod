/*
 * Copyright (c) 2026 Bruce A Henderson
 *
 * This software is provided 'as-is', without any express or implied warranty.
 * In no event will the authors be held liable for any damages arising from
 * the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 *
 */
#include "brl.mod/blitz.mod/blitz.h"
#include "linebreak.h"
#include "wordbreak.h"
#include "graphemebreak.h"

void bmx_unibreak_init(void) {
	init_linebreak();
	init_wordbreak();
	init_graphemebreak();
}

void bmx_unibreak_boundaries(BBString *text, BBString *language, BBINT kind, unsigned char *output) {
	const size_t length = (size_t)text->length;
	char *lang = language->length ? (char *)bbStringToUTF8String(language) : NULL;
	/* libunibreak marks AFTER each code unit; public arrays index boundaries. */
	if (kind == 0) {
		output[0] = 0;
		set_linebreaks_utf16(text->buf, length, lang, (char *)(output + 1));
		for (size_t i = 1; i <= length; ++i) {
			unsigned char value = output[i];
			output[i] = value == LINEBREAK_MUSTBREAK ? 2 :
				(value == LINEBREAK_ALLOWBREAK || value == LINEBREAK_INDETERMINATE ? 1 : 0);
		}
		if (length && output[length] == 0) output[length] = 1;
	} else {
		output[0] = 1;
		if (kind == 1) set_wordbreaks_utf16(text->buf, length, lang, (char *)(output + 1));
		else set_graphemebreaks_utf16(text->buf, length, lang, (char *)(output + 1));
		for (size_t i = 1; i <= length; ++i) output[i] = output[i] == 0;
		output[length] = 1;
	}
	if (lang) bbMemFree(lang);
}
