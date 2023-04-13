import codecs
import os
import re

def generate_test_files(encoding, output_dir):

    if re.match(r'^cp\d+', encoding):
        prefix = re.sub(r'^cp', 'windows_', encoding)
    else:
        prefix = encoding

    encoded_filename = os.path.join(output_dir, f"{prefix}_encoded.txt")
    utf8_filename = os.path.join(output_dir, f"{prefix}_utf8.txt")

    encoded_chars = bytearray()
    utf8_chars = bytearray()

    for i in range(0x20, 0x100):
        try:
            char = bytes([i])
            utf8_char = codecs.decode(char, encoding).encode('utf-8')
            encoded_chars.extend(char)
            utf8_chars.extend(utf8_char)
        except UnicodeDecodeError:
            pass

    with open(encoded_filename, 'wb') as encoded_file:
        encoded_file.write(encoded_chars)

    with open(utf8_filename, 'wb') as utf8_file:
        utf8_file.write(utf8_chars)

def main():
    encodings = ['iso_8859_1', 'iso_8859_2', 'iso_8859_5', 'iso_8859_6', 'iso_8859_7', 'iso_8859_8', 'iso_8859_9', 'iso_8859_15', 'cp1252', 'cp1251', 'cp1250', 'cp1254', 'cp1253', 'cp1257', 'cp1255', 'cp1256']
    output_dir = 'test_data'

    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    for encoding in encodings:
        generate_test_files(encoding, output_dir)

if __name__ == "__main__":
    main()
