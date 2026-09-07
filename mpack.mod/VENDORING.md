# MPack vendoring notes

Text.MPack vendors the MPack development snapshot at commit `c9d1820`. Its
`MPACK_VERSION_*` macros still identify the code line as 1.1.1.

- Upstream project: https://github.com/ludocode/mpack
- Upstream commit: `c9d1820`
- Version macros: 1.1.1 (`1.1.1dev` when `MPACK_RELEASE_VERSION` is disabled)
- Upstream licence: MIT; see `mpack/LICENSE`
- Local wrapper licence: MIT

The snapshot was copied from the upstream `develop` branch. The upstream root
metadata files (`.editorconfig`, `.gitattributes`, and `.gitignore`) are retained
alongside it. Text.MPack's wrapper does not patch the vendored C sources.

## Compile-time configuration

The BlitzMax module enables the reader, expect, writer, builder, extension,
read-tracking, and write-tracking APIs. Tracking remains enabled in release
builds. The unused tree/node API and MessagePack v4 compatibility mode are
disabled. The standard C allocator is currently used by MPack itself.
