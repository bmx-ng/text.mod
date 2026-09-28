# Text.SheenBidi

Optional bidirectional paragraph analysis using bundled SheenBidi 3.0.0 and
Unicode 17.0 data. Importing this module registers a provider with `Text.Bidi`.
It does not import Max2D or a graphics backend.

```blitzmax
Import Text.SheenBidi

Local paragraph:TTextBidiParagraph = GetTextBidiProvider().Analyze("abc אבג 123")
For Local run:TTextBidiRun = EachIn paragraph.Line(0, paragraph.length)
	Print run.first + ":" + run.last + " level=" + run.level
Next
```

`Analyze` accepts one paragraph. `ETextDirection.Auto` detects its base direction
(defaulting to LTR when there is no strong character); `LeftToRight` and
`RightToLeft` explicitly set it. `Disabled` belongs to consumers such as Max2D
and is rejected by direct analysis calls. Empty paragraphs are supported.

`Line(first, length)` applies line-specific whitespace resetting and visual
reordering using the retained paragraph analysis. Results are ordered visually
from left to right. Each run has a half-open logical UTF-16 range **relative to
the requested line**, an embedding level (odd means RTL), and an ISO 15924 script
tag encoded in an Int. Runs are split at script boundaries for shaping; numbers
can have a different embedding level from surrounding RTL text. Supplementary
characters occupy two UTF-16 offsets and are not split between runs.

The original logical text is not reversed or modified. Clients must shape each
run with its direction and script, preserving surrounding context, then place
runs in visual order. Glyph mirroring is the shaper's responsibility. This module
does not draw, select fonts, wrap paragraphs, or build carets. Use well-formed
Unicode; it is not a sanitizer for malformed UTF-16.

Native paragraph data is retained until the result is collected. Returned runs
are independent BlitzMax objects. Registering or removing the default provider
does not invalidate existing results. Register providers during initialization,
before concurrent preparation.

Without importing this module, `Text.Bidi` contains only the provider interface
and registration state, with no SheenBidi code or Unicode tables linked.
