"""
Debug GSCAT Module Import

Verifies that the updated gscat.py module is loaded correctly.
"""

import sys
from pathlib import Path

# Add src to path
sys.path.insert(0, str(Path(__file__).parent.parent))

print("=" * 70)
print("🔍 GSCAT Module Debug")
print("=" * 70)
print()

# Import module
print("📦 Importing gscat module...")
try:
    from src.models import gscat

    print("✅ Module imported successfully")
except Exception as e:
    print(f"❌ Failed to import: {e}")
    sys.exit(1)

print()

# Check for read_pascal_string function
print("🔍 Checking for read_pascal_string function...")
if hasattr(gscat, 'parse_gscat_record'):
    print("✅ parse_gscat_record function exists")

    # Check source code
    import inspect

    source = inspect.getsource(gscat.parse_gscat_record)

    if 'read_pascal_string' in source:
        print("✅ read_pascal_string is used in parse_gscat_record")
        print()
        print("First 500 chars of parse_gscat_record source:")
        print("-" * 70)
        print(source[:500])
        print("...")
    else:
        print("❌ read_pascal_string NOT FOUND in parse_gscat_record")
        print("⚠️  You are using the OLD version!")
        print()
        print("First 500 chars of parse_gscat_record source:")
        print("-" * 70)
        print(source[:500])
        print("...")
else:
    print("❌ parse_gscat_record function NOT FOUND")

print()
print("-" * 70)

# Check module file location
print()
print("📁 Module file location:")
print(f"   {gscat.__file__}")
print()

# Check if __pycache__ exists
pycache_dir = Path(gscat.__file__).parent / "__pycache__"
if pycache_dir.exists():
    print("⚠️  __pycache__ directory exists:")
    print(f"   {pycache_dir}")
    print()
    print("   Cached files:")
    for cached_file in pycache_dir.glob("gscat*.pyc"):
        print(f"   - {cached_file.name}")
    print()
    print("💡 Recommendation: Delete __pycache__ and try again")
    print("   Command: rm -r src/models/__pycache__")
else:
    print("✅ No __pycache__ directory found")

print()
print("=" * 70)
print("🔍 GSCAT_FIELD_MAP Check")
print("=" * 70)
print()

# Check GSCAT_FIELD_MAP
if hasattr(gscat, 'GSCAT_FIELD_MAP'):
    field_map = gscat.GSCAT_FIELD_MAP
    print(f"✅ GSCAT_FIELD_MAP exists with {len(field_map)} entries")
    print()
    print("First 10 entries:")
    print("-" * 70)
    for offset in sorted(field_map.keys())[:10]:
        field_name, field_type, field_size = field_map[offset]
        print(f"  Offset {offset:3d}: {field_name:15s} {field_type:12s} ({field_size} bytes)")

    print()

    # Check if using pstring types
    has_pstring = any('pstring' in str(v[1]) for v in field_map.values())
    if has_pstring:
        print("✅ GSCAT_FIELD_MAP uses 'pstring' types (NEW VERSION)")
    else:
        print("❌ GSCAT_FIELD_MAP uses old 'string' types (OLD VERSION)")
        print("⚠️  You need to update the file!")
else:
    print("❌ GSCAT_FIELD_MAP NOT FOUND")

print()
print("=" * 70)

# Final verdict
print()
print("📊 Verdict:")
print("-" * 70)

source = inspect.getsource(gscat.parse_gscat_record)
has_pascal = 'read_pascal_string' in source
field_map = gscat.GSCAT_FIELD_MAP if hasattr(gscat, 'GSCAT_FIELD_MAP') else {}
has_pstring = any('pstring' in str(v[1]) for v in field_map.values())

if has_pascal and has_pstring:
    print("✅ NEW VERSION - You have the updated gscat.py!")
    print("   If test still fails, try:")
    print("   1. Delete __pycache__: rm -r src/models/__pycache__")
    print("   2. Restart Python: exit and re-run test")
elif has_pascal or has_pstring:
    print("⚠️  PARTIAL UPDATE - Module is partially updated")
    print("   Some parts are new, some are old.")
    print("   Copy the ENTIRE artifact content again.")
else:
    print("❌ OLD VERSION - You have the old gscat.py!")
    print("   The file was NOT updated correctly.")
    print("   Steps:")
    print("   1. Open artifact 'gscat.py - GSCAT Product Catalog Model'")
    print("   2. Copy ALL content (Ctrl+A, Ctrl+C)")
    print("   3. Replace src/models/gscat.py completely")
    print("   4. Delete __pycache__: rm -r src/models/__pycache__")
    print("   5. Run this debug script again")

print()