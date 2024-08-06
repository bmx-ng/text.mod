' Copyright (c) 2024 Bruce A Henderson
' 
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.
' 
SuperStrict

Import "../../pub.mod/freetype.mod/include/*.h"

Import "harfbuzz/src/*.h"

Import "harfbuzz/src/hb-aat-layout.cc"
Import "harfbuzz/src/hb-aat-map.cc"
Import "harfbuzz/src/hb-blob.cc"
Import "harfbuzz/src/hb-buffer-serialize.cc"
Import "harfbuzz/src/hb-buffer-verify.cc"
Import "harfbuzz/src/hb-buffer.cc"
Import "harfbuzz/src/hb-common.cc"
Import "harfbuzz/src/hb-draw.cc"
Import "harfbuzz/src/hb-paint.cc"
Import "harfbuzz/src/hb-paint-extents.cc"
Import "harfbuzz/src/hb-face.cc"
Import "harfbuzz/src/hb-face-builder.cc"
Import "harfbuzz/src/hb-fallback-shape.cc"
Import "harfbuzz/src/hb-font.cc"
Import "harfbuzz/src/hb-map.cc"
Import "harfbuzz/src/hb-number.cc"
Import "harfbuzz/src/hb-ot-cff1-table.cc"
Import "harfbuzz/src/hb-ot-cff2-table.cc"
Import "harfbuzz/src/hb-ot-color.cc"
Import "harfbuzz/src/hb-ot-face.cc"
Import "harfbuzz/src/hb-ot-font.cc"
Import "harfbuzz/src/hb-ot-layout.cc"
Import "harfbuzz/src/hb-ot-map.cc"
Import "harfbuzz/src/hb-ot-math.cc"
Import "harfbuzz/src/hb-ot-meta.cc"
Import "harfbuzz/src/hb-ot-metrics.cc"
Import "harfbuzz/src/hb-ot-name.cc"
Import "harfbuzz/src/hb-ot-shaper-arabic.cc"
Import "harfbuzz/src/hb-ot-shaper-default.cc"
Import "harfbuzz/src/hb-ot-shaper-hangul.cc"
Import "harfbuzz/src/hb-ot-shaper-hebrew.cc"
Import "harfbuzz/src/hb-ot-shaper-indic-table.cc"
Import "harfbuzz/src/hb-ot-shaper-indic.cc"
Import "harfbuzz/src/hb-ot-shaper-khmer.cc"
Import "harfbuzz/src/hb-ot-shaper-myanmar.cc"
Import "harfbuzz/src/hb-ot-shaper-syllabic.cc"
Import "harfbuzz/src/hb-ot-shaper-thai.cc"
Import "harfbuzz/src/hb-ot-shaper-use.cc"
Import "harfbuzz/src/hb-ot-shaper-vowel-constraints.cc"
Import "harfbuzz/src/hb-ot-shape-fallback.cc"
Import "harfbuzz/src/hb-ot-shape-normalize.cc"
Import "harfbuzz/src/hb-ot-shape.cc"
Import "harfbuzz/src/hb-ot-tag.cc"
Import "harfbuzz/src/hb-ot-var.cc"
Import "harfbuzz/src/hb-outline.cc"
Import "harfbuzz/src/hb-set.cc"
Import "harfbuzz/src/hb-shape-plan.cc"
Import "harfbuzz/src/hb-shape.cc"
Import "harfbuzz/src/hb-shaper.cc"
Import "harfbuzz/src/hb-static.cc"
Import "harfbuzz/src/hb-style.cc"
Import "harfbuzz/src/hb-ucd.cc"
Import "harfbuzz/src/hb-unicode.cc"
Import "harfbuzz/src/OT/Var/VARC/VARC.cc"

' freetype
Import "harfbuzz/src/hb-ft.cc"


Import "glue.c"
