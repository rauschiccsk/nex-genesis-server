"""
Btrieve BDF File Analyzer

Analyzuje .bdf súbory a extrahuje field definitions:
- Field offsets
- Field types
- Field sizes
- Field names

Usage:
    python scripts/analyze_bdf.py database-schema/gscat.bdf
"""

import sys
import struct
from pathlib import Path


def hex_dump(data: bytes, offset: int = 0, length: int = 256) -> None:
    """Print hex dump of binary data"""
    print("Hex Dump:")
    print("-" * 70)

    end = min(offset + length, len(data))

    for i in range(offset, end, 16):
        # Hex part
        hex_str = ' '.join(f'{b:02x}' for b in data[i:i + 16])
        hex_str = hex_str.ljust(48)  # Padding

        # ASCII part
        ascii_str = ''.join(
            chr(b) if 32 <= b <= 126 else '.'
            for b in data[i:i + 16]
        )

        print(f'{i:04x}: {hex_str} {ascii_str}')

    print()


def read_string(data: bytes, offset: int, max_len: int = 100) -> tuple[str, int]:
    """
    Read null-terminated string from data
    Returns: (string, bytes_read)
    """
    end = offset
    while end < len(data) and end < offset + max_len and data[end] != 0:
        end += 1

    try:
        text = data[offset:end].decode('ascii', errors='ignore')
    except:
        text = data[offset:end].decode('cp852', errors='ignore')

    return text, end - offset + 1  # +1 for null terminator


def analyze_bdf_structure(filepath: Path) -> dict:
    """
    Analyze Btrieve BDF file structure

    BDF files contain:
    1. File specification (record length, page size, etc.)
    2. Field specifications (name, type, offset, size)
    3. Key specifications (indexes)
    """

    print("=" * 70)
    print(f"📊 Analyzing: {filepath.name}")
    print("=" * 70)
    print()

    # Read file
    with open(filepath, 'rb') as f:
        data = f.read()

    print(f"File size: {len(data)} bytes")
    print()

    # Show hex dump of first part
    hex_dump(data, 0, 256)

    # Try to find field definitions
    # BDF files typically have text strings with field names
    print("=" * 70)
    print("🔍 Searching for Field Names (ASCII strings)")
    print("=" * 70)
    print()

    # Look for consecutive printable ASCII sequences (potential field names)
    current_string = bytearray()
    string_start = 0
    strings_found = []

    for i, byte in enumerate(data):
        if 32 <= byte <= 126:  # Printable ASCII
            if not current_string:
                string_start = i
            current_string.append(byte)
        else:
            if len(current_string) >= 3:  # Minimum 3 chars
                text = current_string.decode('ascii')
                strings_found.append((string_start, text))
            current_string = bytearray()

    # Print first 50 strings
    print("First 50 ASCII strings found:")
    print("-" * 70)
    for i, (offset, text) in enumerate(strings_found[:50]):
        print(f"{offset:5d} (0x{offset:04x}): {text}")

    print()
    print(f"Total strings found: {len(strings_found)}")
    print()

    # Try to detect field pattern
    print("=" * 70)
    print("🔍 Analyzing Potential Field Definitions")
    print("=" * 70)
    print()

    # Btrieve field specs typically have:
    # - Field name (string)
    # - Field type (byte or word)
    # - Field offset (word or dword)
    # - Field size (word or dword)

    # Look for patterns
    fields = []

    for offset, name in strings_found:
        # Check if this looks like a field name
        if len(name) > 2 and len(name) < 30:
            # Look at bytes around this string
            if offset + len(name) + 10 < len(data):

                # Try to read potential field info after the name
                after_name = offset + len(name) + 1  # +1 for null terminator

                # Read next few bytes (potential type, offset, size)
                if after_name + 8 < len(data):
                    potential_type = data[after_name]
                    potential_offset = struct.unpack('<H', data[after_name + 1:after_name + 3])[0]
                    potential_size = struct.unpack('<H', data[after_name + 3:after_name + 5])[0]

                    # Sanity check
                    if potential_offset < 10000 and potential_size < 1000:
                        fields.append({
                            'name': name,
                            'type': potential_type,
                            'offset': potential_offset,
                            'size': potential_size,
                            'bdf_offset': offset
                        })

    if fields:
        print("Potential field definitions found:")
        print("-" * 70)
        print(f"{'Field Name':<20} {'Type':<6} {'Offset':<8} {'Size':<6} {'BDF Pos'}")
        print("-" * 70)

        for field in fields[:30]:  # Show first 30
            print(
                f"{field['name']:<20} {field['type']:<6} {field['offset']:<8} {field['size']:<6} 0x{field['bdf_offset']:04x}")
    else:
        print("⚠️  Could not identify field pattern automatically")

    print()

    # Look for record size indicator
    print("=" * 70)
    print("🔍 Looking for Record Size")
    print("=" * 70)
    print()

    # Record size is often near the beginning
    # Try to find 705 (0x02C1) in first 100 bytes
    target = 705

    for i in range(min(100, len(data) - 1)):
        # Try little-endian word
        word = struct.unpack('<H', data[i:i + 2])[0]
        if word == target:
            print(f"✅ Found {target} at offset {i} (0x{i:04x}) - little-endian word")

        # Try big-endian word
        word = struct.unpack('>H', data[i:i + 2])[0]
        if word == target:
            print(f"✅ Found {target} at offset {i} (0x{i:04x}) - big-endian word")

        # Try dword
        if i + 3 < len(data):
            dword = struct.unpack('<I', data[i:i + 4])[0]
            if dword == target:
                print(f"✅ Found {target} at offset {i} (0x{i:04x}) - little-endian dword")

    print()

    return {
        'size': len(data),
        'strings': strings_found,
        'fields': fields
    }


def main():
    if len(sys.argv) < 2:
        print("Usage: python analyze_bdf.py <path-to-bdf-file>")
        print()
        print("Example:")
        print("  python scripts/analyze_bdf.py database-schema/gscat.bdf")
        sys.exit(1)

    filepath = Path(sys.argv[1])

    if not filepath.exists():
        print(f"❌ File not found: {filepath}")
        sys.exit(1)

    if not filepath.suffix.lower() == '.bdf':
        print(f"⚠️  Warning: File does not have .bdf extension: {filepath}")

    # Analyze
    result = analyze_bdf_structure(filepath)

    print()
    print("=" * 70)
    print("✅ Analysis Complete")
    print("=" * 70)
    print()
    print("Summary:")
    print(f"  File size:     {result['size']} bytes")
    print(f"  Strings found: {len(result['strings'])}")
    print(f"  Potential fields: {len(result['fields'])}")
    print()

    if result['fields']:
        print("Next steps:")
        print("  1. Review field definitions above")
        print("  2. Verify offsets match test data")
        print("  3. Update GSCAT_FIELD_MAP in src/models/gscat.py")
    else:
        print("Next steps:")
        print("  1. Manual hex dump analysis needed")
        print("  2. Compare with Delphi BtrTable.pas")
        print("  3. Use test data to identify field boundaries")


if __name__ == '__main__':
    main()