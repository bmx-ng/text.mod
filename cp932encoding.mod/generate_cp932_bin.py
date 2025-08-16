# generate_cp932_bin.py
import codecs, struct

REPLACEMENT = 0xFFFD
table = [REPLACEMENT] * 65536

# Fill only valid double-byte pairs; singles are handled in BlitzMax logic.
for lead in range(0x81, 0xA0):
    for trail in list(range(0x40, 0x7F)) + list(range(0x80, 0xFD)):
        if trail == 0x7F:
            continue
        b = bytes([lead, trail])
        try:
            u = b.decode('cp932')
        except UnicodeDecodeError:
            continue
        if len(u) == 1:
            cp = ord(u)
            # store in little-endian short
            table[(lead << 8) | trail] = cp

for lead in range(0xE0, 0xFD):
    for trail in list(range(0x40, 0x7F)) + list(range(0x80, 0xFD)):
        if trail == 0x7F:
            continue
        b = bytes([lead, trail])
        try:
            u = b.decode('cp932')
        except UnicodeDecodeError:
            continue
        if len(u) == 1:
            table[(lead << 8) | trail] = ord(u)

with open("cp932.bin", "wb") as f:
    for cp in table:
        f.write(struct.pack("<H", cp))
