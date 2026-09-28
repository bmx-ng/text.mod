# Text.Unibreak

Unicode line, word and extended-grapheme boundaries for BlitzMax, built directly
from bundled libunibreak sources and Unicode 17.0 tables. No system library or
runtime data download is required. See `VENDORING.md` for the pinned revision.

```blitzmax
Import Text.Unibreak
Local boundaries:Byte[] = UnibreakLineBreaks("one two")
' boundaries[4] is an allowed line break, before the t in two.
```

`UnibreakLineBreaks`, `UnibreakWordBreaks` and `UnibreakGraphemeBreaks` accept a
String and an optional libunibreak language tag. Results have `text.Length + 1`
entries. Indices are UTF-16 string offsets, not UTF-8 bytes or code-point counts.
The entry at offset N describes a boundary *before* text[N]. The **index** is
the offset; its **byte value** is just a small status flag. For example,
`boundaries[100000] = TEXT_BOUNDARY_ALLOWED` marks offset 100,000 using the
byte value 1. Offsets are not restricted to the range of a byte. Offsets inside a
valid surrogate pair are never boundaries. Supply well-formed Unicode strings;
ill-formed surrogate sequences are not a supported text interchange format.
Embedded NULs are processed using the String's length.

Line results use `TEXT_BOUNDARY_NONE`, `TEXT_BOUNDARY_ALLOWED` and
`TEXT_BOUNDARY_MANDATORY`. Offset zero is not a line break. The end of nonempty
text is allowed unless a mandatory break already exists there. Word/grapheme
results are Boolean, including True at the start and end of the string (also
for empty strings). For empty text the sole line-break entry is NONE.

Importing the module registers a `TUnibreakProvider` with `Text.Boundaries`.
Consumers may query `UnicodeTextBoundariesAvailable()` or call
`GetTextBoundaryProvider().Analyze(text, language)` for all three boundary maps.
Pass a third argument to select only the maps needed, for example:

```blitzmax
Local maps:ETextBoundaryMaps = ETextBoundaryMaps.Line | ETextBoundaryMaps.Grapheme
Local result:TTextBoundaries = GetTextBoundaryProvider().Analyze("one two", "", maps)
' result.wordBreaks is Null: no word map was allocated or calculated.
```

The default is `ETextBoundaryMaps.All`; `ETextBoundaryMaps.None` requests no maps. The individual
`UnibreakLineBreaks`, `UnibreakWordBreaks` and `UnibreakGraphemeBreaks` functions
continue to allocate and calculate only their own map.

The interface module itself contains no native boundary implementation and has
no dependency on this module or Max2D.

This is boundary analysis, not glyph shaping, bidi processing, font fallback,
layout, dictionary-based segmentation or automatic hyphenation. Language tags
select libunibreak's supported tailoring; they do not load language dictionaries.

## Layout and testing conventions

- `unibreak.bmx`: public API, metadata and provider registration.
- `common.bmx`: native declarations and dependencies.
- `source.bmx`: explicit source imports.
- `glue.c`: BlitzMax String / boundary-offset conversion.
- `libunibreak/`: unmodified third-party source, generated tables and fixtures.
- `tests/test.bmx`: BRL.MaxUnit binding tests; `examples/boundaries.bmx`: usage.

Upstream conformance can be reproduced from `libunibreak/src` by compiling
`tests.c` together with the nine library C files listed in `source.bmx`, then
running that executable with `l`, `w` and `g` respectively. Keep the working
directory there so it can read the bundled Unicode test fixtures.

On macOS the pinned revision passed all 19,338 line, 1,944 word and 766 grapheme
fixtures, with no skips. Binding tests additionally cover UTF-16 surrogate pairs,
combining marks, emoji ZWJ sequences, CRLF, NBSP, word joiners, empty strings,
embedded NULs and provider registration.

Bindings and upstream code use the zlib/libpng licence; generated Unicode data is covered by the retained notices
and `UNICODE-LICENSE.txt`.
