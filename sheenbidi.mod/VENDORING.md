# SheenBidi

Source: https://github.com/Tehreer/SheenBidi
Release: **v3.0.0**, Unicode **17.0.0**.
Archive: https://github.com/Tehreer/SheenBidi/archive/refs/tags/v3.0.0.tar.gz
Archive SHA-256: `86c56014034739ba39a24c23eb00323b0bf6f737354f665786015fca842af786`.

`SheenBidi/Headers`, `Source`, `Tests`, `Tools`, `Makefile`, `LICENSE` and
`README.md` are copied unchanged from the release. Generated Unicode tables
and upstream conformance fixtures are included. Our wrapper is zlib/libpng;
SheenBidi is Apache-2.0, with upstream notices retained. Unicode data terms are
also included in `UNICODE-LICENSE.txt`.

`source.bmx` compiles the unity source with `SB_CONFIG_UNITY`. Experimental text
editing APIs are not enabled. No system installation, dynamic loading or runtime
download is required. The C glue owns a copy of UTF-16 text for the native
paragraph's lifetime; GC never supplies an unrooted string buffer to retained C
objects. Finalization releases the paragraph, algorithm and text/script storage.

On update, run upstream `make check` in a disposable copy of the source tree and
build/run `tests/bidi.bmx`. Also run Max2D's bidi tests, real-font render tests and
allocation benchmark. The bundled upstream suite passed on macOS ARM64 during
integration, including Unicode bidi conformance, bracket, property and API tests.

The BlitzMax provider binding tests also passed on Ubuntu 25.10 ARM64 and Windows
11 ARM64 running x64 executables under Parallels (2026-09-25). These are binding
and Max2D integration checks; the full upstream suite was run on macOS.
