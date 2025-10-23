"""
GSCAT Record Hex Dump Analyzer

Načíta prvých N recordov z GSCAT.BTR a zobrazí ich hex dump.
Pomáha identifikovať field boundaries a offsety.

Usage:
    python scripts/analyze_gscat_hex.py
"""

import sys
import struct
from pathlib import Path

# Add src to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from src.btrieve.btrieve_client import BtrieveClient
from src.utils.config import load_config


def hex_dump_with_markers(data: bytes, markers: dict = None) -> None:
    """
    Print hex dump with field markers

    Args:
        data: Raw bytes
        markers: Dict of {offset: 'field_name'}
    """
    print("-" * 100)

    for i in range(0, len(data), 16):
        # Hex part
        hex_str = ' '.join(f'{b:02x}' for b in data[i:i + 16])
        hex_str = hex_str.ljust(48)

        # ASCII part
        ascii_str = ''.join(
            chr(b) if 32 <= b <= 126 else '.'
            for b in data[i:i + 16]
        )

        # Offset
        offset_str = f'{i:04d}'

        # Check for markers
        marker_str = ''
        if markers:
            for offset, name in markers.items():
                if i <= offset < i + 16:
                    marker_str = f' <- {name}'
                    break

        print(f'{offset_str}: {hex_str} {ascii_str}{marker_str}')

    print("-" * 100)


def analyze_field_at_offset(data: bytes, offset: int, field_type: str, name: str) -> None:
    """Analyze and display field value at given offset"""

    print(f"\n📍 {name} at offset {offset}:")

    if field_type == 'int32':
        if offset + 4 <= len(data):
            value = struct.unpack('<i', data[offset:offset + 4])[0]
            print(f"   INT32: {value}")
            print(f"   Hex:   {data[offset:offset + 4].hex()}")

    elif field_type == 'float64':
        if offset + 8 <= len(data):
            value = struct.unpack('<d', data[offset:offset + 8])[0]
            print(f"   FLOAT64: {value}")
            print(f"   Hex:     {data[offset:offset + 8].hex()}")

    elif field_type.startswith('string'):
        # Extract length from 'string80', 'string20', etc.
        length = int(field_type.replace('string', ''))
        if offset + length <= len(data):
            # Try different encodings
            raw = data[offset:offset + length]

            # CP852 (Czech/Slovak)
            try:
                text_cp852 = raw.decode('cp852', errors='ignore').rstrip('\x00 ')
                print(f"   STRING (CP852):  '{text_cp852}'")
            except:
                pass

            # Windows-1250
            try:
                text_1250 = raw.decode('windows-1250', errors='ignore').rstrip('\x00 ')
                print(f"   STRING (Win1250): '{text_1250}'")
            except:
                pass

            # ASCII
            try:
                text_ascii = raw.decode('ascii', errors='ignore').rstrip('\x00 ')
                print(f"   STRING (ASCII):   '{text_ascii}'")
            except:
                pass

            print(f"   Raw hex: {raw[:20].hex()}..." if len(raw) > 20 else f"   Raw hex: {raw.hex()}")


def main():
    print()
    print("=" * 100)
    print("🔍 GSCAT Record Hex Dump Analyzer")
    print("=" * 100)
    print()

    # Load config
    config_path = Path(__file__).parent.parent / "config" / "database.yaml"
    if not config_path.exists():
        print(f"❌ Config not found: {config_path}")
        return

    config = load_config(str(config_path))
    gscat_path = config['nex_genesis']['tables']['gscat']

    print(f"📁 GSCAT path: {gscat_path}")
    print()

    # Initialize client
    client = BtrieveClient()

    # Open file
    status, pos_block = client.open_file(gscat_path, mode=-2)
    if status != 0:
        print(f"❌ Failed to open GSCAT.BTR")
        return

    print("✅ GSCAT.BTR opened")
    print()

    # Read first record
    status, raw_bytes = client.get_first(pos_block)

    if status != 0:
        print(f"❌ Failed to read first record")
        client.close_file(pos_block)
        return

    print(f"✅ First record read: {len(raw_bytes)} bytes")
    print()

    # Field markers (known/suspected positions)
    markers = {
        0: 'GsCode (INT32)',
        4: 'GsName? (STRING)',
        84: 'GsName2? (STRING)',
        164: 'GsEAN? (STRING)',
        184: 'GsCatalog? (STRING)',
        204: 'MglstCode? (INT32)',
        208: 'GsPrice? (FLOAT64)',
        216: 'GsVatRate? (FLOAT64)',
    }

    # Show hex dump
    print("=" * 100)
    print("📊 RECORD #1 - Full Hex Dump with Markers")
    print("=" * 100)
    hex_dump_with_markers(raw_bytes, markers)
    print()

    # Analyze known fields
    print("=" * 100)
    print("🔍 Field Analysis")
    print("=" * 100)

    analyze_field_at_offset(raw_bytes, 0, 'int32', 'GsCode')
    analyze_field_at_offset(raw_bytes, 4, 'string80', 'GsName (suspected)')
    analyze_field_at_offset(raw_bytes, 84, 'string80', 'GsName2 (suspected)')
    analyze_field_at_offset(raw_bytes, 164, 'string20', 'GsEAN (suspected)')
    analyze_field_at_offset(raw_bytes, 184, 'string20', 'GsCatalog (suspected)')
    analyze_field_at_offset(raw_bytes, 204, 'int32', 'MglstCode (suspected)')
    analyze_field_at_offset(raw_bytes, 208, 'float64', 'GsPrice (suspected)')
    analyze_field_at_offset(raw_bytes, 216, 'float64', 'GsVatRate (suspected)')

    print()

    # Read more records for comparison
    print("=" * 100)
    print("📊 ADDITIONAL RECORDS (first 100 bytes each)")
    print("=" * 100)
    print()

    for i in range(2, 6):  # Records 2-5
        status, raw_bytes = client.get_next(pos_block)

        if status != 0:
            break

        print(f"RECORD #{i}:")
        print(f"GsCode: {struct.unpack('<i', raw_bytes[0:4])[0]}")

        # Show just first 100 bytes
        hex_dump_with_markers(raw_bytes[:100])

        # Try to decode name at offset 4
        name_bytes = raw_bytes[4:84]
        name_cp852 = name_bytes.decode('cp852', errors='ignore').rstrip('\x00 ')
        print(f"Name at offset 4 (CP852): '{name_cp852}'")
        print()

    # Close
    client.close_file(pos_block)

    print()
    print("=" * 100)
    print("✅ Analysis Complete")
    print("=" * 100)
    print()
    print("Next steps:")
    print("  1. Review hex dump and field values")
    print("  2. Identify correct field boundaries")
    print("  3. Update GSCAT_FIELD_MAP in src/models/gscat.py")
    print("  4. Re-run test_gscat_parsing.py to verify")
    print()


if __name__ == '__main__':
    main()