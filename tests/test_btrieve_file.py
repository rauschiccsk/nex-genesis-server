# tests/test_btrieve_file.py
"""
Level 2: Btrieve File Opening Tests

Tests:
- Open GSCAT.BTR file
- Verify position block
- Close file
"""

import sys
import os
from pathlib import Path

# Add src to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from src.btrieve.btrieve_client import BtrieveClient
from src.utils.config import load_config


def print_section(title):
    print("\n" + "=" * 60)
    print(title)
    print("=" * 60)


def test_file_opening():
    """Test opening and closing Btrieve files"""

    print_section("🚀 BTRIEVE FILE OPENING TESTS")

    # Load config
    config_path = Path(__file__).parent.parent / "config" / "database.yaml"
    config = load_config(str(config_path))

    # DEBUG: Print config structure
    print("\n🔍 DEBUG: Config structure:")
    import json
    print(json.dumps(config, indent=2, default=str))

    # Create client
    print("\n🔧 Initializing Btrieve client...")
    client = BtrieveClient(str(config_path))
    print("✅ Client initialized!")

    # Test 1: Open GSCAT.BTR
    print_section("🧪 TEST 2.1: Open GSCAT.BTR")

    # Fix: Access config correctly based on its structure
    if 'database' in config:
        stores_path = config['database']['stores_path']
    else:
        # Fallback: maybe it's flat structure
        stores_path = config.get('stores_path', config.get('path', 'C:\\NEX\\YEARACT\\STORES'))

    gscat_path = Path(stores_path) / "GSCAT.BTR"
    print(f"📁 File: {gscat_path}")

    if not gscat_path.exists():
        print(f"❌ File not found: {gscat_path}")
        return False

    print(f"✅ File exists ({gscat_path.stat().st_size:,} bytes)")

    # Open file
    print("\n🔓 Opening file...")
    try:
        status, pos_block = client.open_file(str(gscat_path))

        if status == BtrieveClient.STATUS_SUCCESS:
            print(f"✅ File opened successfully!")
            print(f"📦 Position block: {len(pos_block)} bytes")
            print(f"🔑 Status: {client.get_status_message(status)}")

            # Close file
            print_section("🧪 TEST 2.2: Close GSCAT.BTR")
            print("🔒 Closing file...")
            close_status = client.close_file(pos_block)

            if close_status == BtrieveClient.STATUS_SUCCESS:
                print("✅ File closed successfully!")
                print(f"🔑 Status: {client.get_status_message(close_status)}")
                return True
            else:
                print(f"❌ Failed to close file!")
                print(f"🔑 Status: {client.get_status_message(close_status)} ({close_status})")
                return False
        else:
            print(f"❌ Failed to open file!")
            print(f"🔑 Status: {client.get_status_message(status)} ({status})")
            return False

    except Exception as e:
        print(f"❌ Exception: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_multiple_files():
    """Test opening multiple files"""

    print_section("🧪 TEST 2.3: Open Multiple Files")

    # Load config
    config_path = Path(__file__).parent.parent / "config" / "database.yaml"
    config = load_config(str(config_path))

    client = BtrieveClient(str(config_path))

    # Fix: Access config correctly
    if 'database' in config:
        stores_path = config['database']['stores_path']
    else:
        stores_path = config.get('stores_path', 'C:\\NEX\\YEARACT\\STORES')

    # Files to test
    test_files = [
        ("GSCAT", Path(stores_path) / "GSCAT.BTR"),
        ("BARCODE", Path(stores_path) / "BARCODE.BTR"),
        ("MGLST", Path(stores_path) / "MGLST.BTR"),
    ]

    results = []

    for name, filepath in test_files:
        print(f"\n📁 Testing {name}: {filepath}")

        if not filepath.exists():
            print(f"   ⚠️  File not found, skipping")
            continue

        try:
            status, pos_block = client.open_file(str(filepath))

            if status == BtrieveClient.STATUS_SUCCESS:
                print(f"   ✅ Opened successfully")

                # Close immediately
                close_status = client.close_file(pos_block)
                if close_status == BtrieveClient.STATUS_SUCCESS:
                    print(f"   ✅ Closed successfully")
                    results.append(True)
                else:
                    print(f"   ❌ Failed to close: {client.get_status_message(close_status)}")
                    results.append(False)
            else:
                print(f"   ❌ Failed to open: {client.get_status_message(status)}")
                results.append(False)

        except Exception as e:
            print(f"   ❌ Exception: {e}")
            results.append(False)

    return all(results) if results else False


def main():
    """Run all file opening tests"""

    print_section("🚀 BTRIEVE FILE OPENING TESTS")

    tests = [
        ("Single File Open/Close", test_file_opening),
        ("Multiple Files", test_multiple_files),
    ]

    results = {}

    for name, test_func in tests:
        try:
            results[name] = test_func()
        except Exception as e:
            print(f"\n❌ Test '{name}' crashed: {e}")
            import traceback
            traceback.print_exc()
            results[name] = False

    # Summary
    print_section("📊 TEST SUMMARY")

    for name, passed in results.items():
        status = "✅ PASSED" if passed else "❌ FAILED"
        print(f"{name}: {status}")

    total = len(results)
    passed = sum(1 for r in results.values() if r)

    print(f"\nTotal: {passed}/{total} tests passed")

    if passed == total:
        print("\n🎉 All file opening tests passed!")
        return True
    else:
        print(f"\n⚠️  {total - passed} test(s) failed")
        return False


if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)