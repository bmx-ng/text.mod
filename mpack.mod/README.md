# Text.MPack

`Text.MPack` is a low-level MessagePack reader and writer for BlitzMax. It
wraps the vendored MPack 1.1.1 tag/expect API and is designed for both trusted
application data and bounded decoding of untrusted input.

## Storage modes

- Stream readers and writers use an internal 8 KiB buffer. Short writes,
  negative reads, and BlitzMax stream exceptions become `error_io`.
- A reader over `Byte[]` is zero-copy and keeps the array alive until the
  reader is freed.
- A fixed `Byte[]` writer never grows. Running out of capacity becomes
  `error_too_big`.
- `TMPackWriter.CreateGrowable()` owns a C buffer while encoding. Its
  `Finish(error)` method transfers the result into a BlitzMax `Byte[]` and
  destroys the writer.

Always call `Free()` on ordinary readers and writers and check the returned
`EMPackError`. `Delete()` is a safety net, but it cannot report an error to the
caller. Container tracking remains enabled in release builds, so incomplete or
over-filled maps, arrays, strings, binary values, and extensions are detected.

## Input limits

`TMPackLimits` defaults to 8 MiB strings, 64 MiB binary/extension values, one
million elements per container, and a nesting depth of 64. Pass stricter limits
when the document format permits them. `Discard()` applies the same limits
recursively.

`ReadBytesInPlace()` avoids a copy, but its pointer is temporary: consume it
before the next reader operation and keep the reader (and its source array or
stream buffer) alive.

## Supported MessagePack features

The public API covers nil, booleans, signed and unsigned numbers, floats,
UTF-8 strings (including embedded NUL characters), binary data, arrays, maps,
extension values, timestamps, raw pre-encoded objects, chunked compound data,
peeking, skipping, and error inspection/injection. MPack's allocating tree/node
API is deliberately compiled out; callers decode incrementally instead.

Use `Write(value:String)` or `WriteString(value:String)` for native BlitzMax
strings. `WriteStringBytes(Byte Ptr, count)` accepts an existing UTF-8 buffer
without first constructing a `Byte[]`; its byte count is always explicit.

See `tests/test.bmx` for complete examples and `VENDORING.md` for provenance and
compile-time configuration.
