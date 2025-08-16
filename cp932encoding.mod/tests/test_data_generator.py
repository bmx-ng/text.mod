import codecs
import os
import re

def _iter_cp932_printable_sequences():
    """
    Yield (encoded_bytes, unicode_char) for every printable CP932 character.
    Includes:
      - single-byte: 0x20–0x7E, 0xA1–0xDF
      - double-byte: lead 0x81–0x9F, 0xE0–0xFC
                     trail 0x40–0x7E, 0x80–0xFC (excluding 0x7F)
    Invalid pairs are skipped; only .isprintable() chars are kept.
    """
    # Single-byte ranges
    single_ranges = list(range(0x20, 0x7F)) + list(range(0xA1, 0xE0))
    for b in single_ranges:
        raw = bytes([b])
        try:
            ch = raw.decode('cp932')
        except UnicodeDecodeError:
            continue
        if ch.isprintable():
            yield (raw, ch)

    # Double-byte ranges
    lead_bytes = list(range(0x81, 0xA0)) + list(range(0xE0, 0xFD))
    trail_bytes = list(range(0x40, 0x7F)) + list(range(0x80, 0xFD))
    for lead in lead_bytes:
        for trail in trail_bytes:
            if trail == 0x7F:
                continue
            raw = bytes([lead, trail])
            try:
                ch = raw.decode('cp932')
            except UnicodeDecodeError:
                continue
            if ch.isprintable():
                yield (raw, ch)

def generate_test_files(encoding, output_dir, columns=None):
    """
    Write two files:
      - <prefix>_encoded.txt : bytes in the source encoding (cp932 or 8-bit)
      - <prefix>_utf8.txt    : corresponding UTF-8 bytes

    If columns is provided (e.g., 64), insert '\n' after every N characters
    in both files to create a readable page-like grid.
    """
    if re.match(r'^cp\d+', encoding):
        prefix = re.sub(r'^cp', 'windows_', encoding)
    else:
        prefix = encoding

    encoded_filename = os.path.join(output_dir, f"{prefix}_encoded.txt")
    utf8_filename = os.path.join(output_dir, f"{prefix}_utf8.txt")

    encoded_bytes = bytearray()
    utf8_bytes = bytearray()
    count_in_row = 0

    def _append_pair(raw_bytes, utf8_chunk):
        nonlocal count_in_row
        encoded_bytes.extend(raw_bytes)
        utf8_bytes.extend(utf8_chunk)
        if columns:
            count_in_row += 1
            if count_in_row >= columns:
                encoded_bytes.extend(b'\n')
                utf8_bytes.extend(b'\n')
                count_in_row = 0

    if encoding.lower() == 'cp932':
        # Enumerate all printable CP932 characters (1- and 2-byte)
        for raw, ch in _iter_cp932_printable_sequences():
            _append_pair(raw, ch.encode('utf-8'))
    else:
        # Existing 8-bit behavior
        for i in range(0x20, 0x100):
            raw = bytes([i])
            try:
                utf8_chunk = codecs.decode(raw, encoding).encode('utf-8')
            except UnicodeDecodeError:
                continue
            _append_pair(raw, utf8_chunk)

    with open(encoded_filename, 'wb') as f_enc:
        f_enc.write(encoded_bytes)
    with open(utf8_filename, 'wb') as f_utf8:
        f_utf8.write(utf8_bytes)

def main():
    encodings = [
        'cp932'
    ]
    output_dir = 'test_data'
    os.makedirs(output_dir, exist_ok=True)

    # If you want a grid, set columns to something like 64; otherwise leave None.
    for enc in encodings:
        generate_test_files(enc, output_dir, columns=64 if enc == 'cp932' else None)

if __name__ == "__main__":
    main()
