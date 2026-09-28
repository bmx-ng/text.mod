# Text.Boundaries

A lightweight, graphics-independent interface for optional Unicode boundary
providers. It includes no Unicode tables or native implementation. Import
`Text.Unibreak` to register the bundled libunibreak provider.

`TTextBoundaryProvider.Analyze` returns `TTextBoundaries`: line, word and grapheme
maps. Each requested array has `text.Length + 1` entries indexed by UTF-16 string offsets. See
Text.Unibreak's README for the shared boundary contract. Applications/providers
should treat returned maps as read-only.

The optional third argument, `maps`, defaults to `ETextBoundaryMaps.All`.
Combine `ETextBoundaryMaps.Line`, `ETextBoundaryMaps.Word` and
`ETextBoundaryMaps.Grapheme` with `|` to select just the maps you need:

```blitzmax
Local maps:ETextBoundaryMaps = ETextBoundaryMaps.Line | ETextBoundaryMaps.Grapheme
Local result:TTextBoundaries = GetTextBoundaryProvider().Analyze(text, "", maps)
```

Unrequested fields remain `Null`; providers must skip their allocation and
analysis. Passing `ETextBoundaryMaps.None` requests no maps. Requested maps still have one entry
for an empty string. Map-selection flags are separate from the boundary-status
values stored in the arrays. Custom providers must accept the optional `maps`
argument and honour the selection.

Register providers during module/application initialization, before concurrent
preparation begins. Registration is not synchronized. Passing Null unregisters
the current provider. Consumers should capture a provider and its analysis during
preparation; existing prepared text must not depend on subsequent registration.

`ETextBreakMode.Auto`, `ETextBreakMode.Basic` and `ETextBreakMode.Unicode` are consumer policy
values: automatic selection, explicit basic fallback, or required Unicode
support. A consumer requesting Unicode must report an unavailable provider
rather than silently falling back.

Licence: zlib/libpng; see the notice in `boundaries.bmx`.
