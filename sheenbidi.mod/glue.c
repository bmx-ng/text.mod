/* Copyright (c) 2026 Bruce A Henderson. zlib/libpng licence; see sheenbidi.bmx. */
#include "blitz.h"
#include <SheenBidi/SheenBidi.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
	SBParagraphRef paragraph;
	SBAlgorithmRef algorithm;
	uint16_t *text;
	uint32_t *scripts;
} BmxSheen;
typedef struct {
	int first, last, level, script;
} BmxSheenRun;

void bmx_sheen_free(BmxSheen *handle) {
	if (!handle) return;
	if (handle->paragraph) SBParagraphRelease(handle->paragraph);
	if (handle->algorithm) SBAlgorithmRelease(handle->algorithm);
	free(handle->scripts);
	free(handle->text);
	free(handle);
}

BmxSheen *bmx_sheen_create(BBString *text, int direction, int *baseLevel) {
	BmxSheen *handle = calloc(1, sizeof(*handle));
	if (!handle) return NULL;
	handle->text = malloc((size_t)text->length * sizeof(uint16_t));
	handle->scripts = calloc((size_t)text->length, sizeof(uint32_t));
	if (!handle->text || !handle->scripts) goto failed;
	memcpy(handle->text, text->buf, (size_t)text->length * sizeof(uint16_t));
	SBCodepointSequence sequence = {SBStringEncodingUTF16, handle->text, text->length};
	handle->algorithm = SBAlgorithmCreate(&sequence);
	if (!handle->algorithm) goto failed;
	SBLevel level = direction == 2 ? 0 : direction == 3 ? 1 : SBLevelDefaultLTR;
	handle->paragraph = SBAlgorithmCreateParagraph(handle->algorithm, 0, text->length, level);
	if (!handle->paragraph || SBParagraphGetLength(handle->paragraph) != (SBUInteger)text->length) goto failed;
	*baseLevel = SBParagraphGetBaseLevel(handle->paragraph);
	SBScriptLocatorRef locator = SBScriptLocatorCreate();
	if (!locator) goto failed;
	SBScriptLocatorLoadCodepoints(locator, &sequence);
	while (SBScriptLocatorMoveNext(locator)) {
		const SBScriptAgent *agent = SBScriptLocatorGetAgent(locator);
		uint32_t script = SBScriptGetUnicodeTag(agent->script);
		for (SBUInteger i = agent->offset; i < agent->offset + agent->length; ++i) handle->scripts[i] = script;
	}
	SBScriptLocatorRelease(locator);
	return handle;
failed:
	bmx_sheen_free(handle);
	return NULL;
}

BmxSheenRun *bmx_sheen_line(BmxSheen *handle, int first, int length, int *count) {
	*count = 0;
	SBLineRef line = SBParagraphCreateLine(handle->paragraph, first, length);
	if (!line) return NULL;
	/* At most one script/level run per UTF-16 unit. */
	BmxSheenRun *result = malloc((size_t)length * sizeof(*result));
	if (!result) { SBLineRelease(line); return NULL; }
	const SBRun *runs = SBLineGetRunsPtr(line);
	SBUInteger runCount = SBLineGetRunCount(line);
	for (SBUInteger i = 0; i < runCount; ++i) {
		int start = (int)runs[i].offset, end = start + (int)runs[i].length;
		while (start < end) {
			int a, b;
			if (runs[i].level & 1) {
				b = end; a = b - 1;
				while (a > start && handle->scripts[a - 1] == handle->scripts[b - 1]) --a;
				end = a;
			} else {
				a = start; b = a + 1;
				while (b < end && handle->scripts[b] == handle->scripts[a]) ++b;
				start = b;
			}
			BmxSheenRun *run = &result[(*count)++];
			run->first = a - first; run->last = b - first;
			run->level = runs[i].level; run->script = (int)handle->scripts[a];
		}
	}
	SBLineRelease(line);
	return result;
}
void bmx_sheen_run(BmxSheenRun *runs, int index, int *first, int *last, int *level, int *script) {
	*first = runs[index].first; *last = runs[index].last;
	*level = runs[index].level; *script = runs[index].script;
}
void bmx_sheen_runs_free(BmxSheenRun *runs) { free(runs); }
