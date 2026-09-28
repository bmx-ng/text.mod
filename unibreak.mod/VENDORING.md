# libunibreak

Source: https://github.com/adah1972/libunibreak
Pinned revision: `28a2756b864c343f438cd22537d49d394d4666a5`.
The vendored tree is unmodified, excluding Git metadata. Its generated tables
and conformance fixtures target Unicode 17.0.0. No runtime downloads are used.
`source.bmx` compiles the nine library translation units explicitly; generated
included data files must not be compiled separately. Binding code is zlib/libpng;
upstream code/data notices are retained in `libunibreak/LICENCE` and source files.
Unicode data licence: `UNICODE-LICENSE.txt`, obtained from https://www.unicode.org/license.txt.
On update, run upstream conformance tests and the UTF-16 binding tests.
