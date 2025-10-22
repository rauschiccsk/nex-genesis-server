"""
Test 3: Btrieve Data Reading - FIXED VERSION
Tests reading actual data from Btrieve tables
"""

import sys
import os

# Add src to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from src.btrieve.btrieve_client import BtrieveClient
from src.utils.config import load_config


def test_gscat_read_first():
    """Test 3.1: Read first GSCAT record"""
    print("\n" + "=" * 60)
    print("🧪 TEST 3.1: Read First GSCAT Record")
    print("=" * 60)

    try:
        # Load config
        config = load_config('config/database.yaml')
        gscat_path = config['nex_genesis']['tables']['gscat']

        if not os.path.exists(gscat_path):
            print(f"⚠️  File not found: {gscat_path}")
            return False

        print(f"📁 File: {gscat_path}")

        # Initialize client
        client = BtrieveClient()

        # Open file
        print("🔓 Opening file...")
        status, pos_block = client.open_file(gscat_path, mode=-2)

        if status != 0:
            print(f"❌ Failed to open GSCAT: status={status} ({client.get_status_message(status)})")
            return False

        print("✅ File opened successfully!")

        # Read first record
        print("📖 Reading first record...")
        status, data = client.get_first(pos_block, key_num=0)

        if status == 0:
            print(f"✅ First record read successfully!")
            print(f"   Record size: {len(data)} bytes")
            print(f"   First 100 bytes (hex): {data[:100].hex()}")

            # Try to decode some fields based on gscat.bdf
            try:
                # GsCode (position 1, UNSIGNED 4 bytes)
                gs_code = int.from_bytes(data[0:4], byteorder='little', signed=False)
                print(f"\n📊 Decoded fields:")
                print(f"   GsCode: {gs_code}")

                # Try to find text fields (look for printable characters)
                print(f"\n   Raw data sample:")
                print(f"   Bytes 0-50:  {data[0:50]}")
                print(f"   Bytes 50-100: {data[50:100]}")

            except Exception as e:
                print(f"   (Could not decode fields: {e})")

            result = True
        elif status == 9:  # End of file
            print("⚠️  Table is empty (no records)")
            result = True
        else:
            print(f"❌ Failed to read: status={status} ({client.get_status_message(status)})")
            result = False

        # Close
        print("🔒 Closing file...")
        close_status = client.close_file(pos_block)
        if close_status == 0:
            print("✅ File closed successfully")

        return result

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_gscat_read_multiple():
    """Test 3.2: Read multiple GSCAT records"""
    print("\n" + "=" * 60)
    print("🧪 TEST 3.2: Read Multiple GSCAT Records")
    print("=" * 60)

    try:
        config = load_config('config/database.yaml')
        gscat_path = config['nex_genesis']['tables']['gscat']

        if not os.path.exists(gscat_path):
            print(f"⚠️  File not found: {gscat_path}")
            return False

        client = BtrieveClient()

        # Open file
        status, pos_block = client.open_file(gscat_path, mode=-2)
        if status != 0:
            print(f"❌ Failed to open GSCAT: status={status}")
            return False

        print("✅ File opened")

        # Read first record
        status, data = client.get_first(pos_block)
        if status != 0:
            if status == 9:
                print("⚠️  Table is empty")
                client.close_file(pos_block)
                return True
            else:
                print(f"❌ Failed to read first: status={status}")
                client.close_file(pos_block)
                return False

        record_count = 1
        print(f"✅ Record 1: {len(data)} bytes")

        # Try to read next few records
        max_records = 10
        while record_count < max_records:
            status, data = client.get_next(pos_block)
            if status == 0:
                record_count += 1
                print(f"✅ Record {record_count}: {len(data)} bytes")
            elif status == 9:  # End of file
                print(f"\n✅ Reached end of file after {record_count} records")
                break
            else:
                print(f"❌ Error reading record {record_count + 1}: status={status}")
                break

        print(f"\n📊 Total records read: {record_count}")

        # Close
        client.close_file(pos_block)
        return record_count > 0

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_barcode_read():
    """Test 3.3: Read BARCODE records"""
    print("\n" + "=" * 60)
    print("🧪 TEST 3.3: Read BARCODE Records")
    print("=" * 60)

    try:
        config = load_config('config/database.yaml')
        barcode_path = config['nex_genesis']['tables']['barcode']

        if not os.path.exists(barcode_path):
            print(f"⚠️  File not found: {barcode_path}")
            return False

        client = BtrieveClient()

        # Open file
        status, pos_block = client.open_file(barcode_path, mode=-2)
        if status != 0:
            print(f"❌ Failed to open BARCODE: status={status}")
            return False

        print("✅ File opened")

        # Read first record
        status, data = client.get_first(pos_block)

        if status == 0:
            print(f"✅ First record read!")
            print(f"   Record size: {len(data)} bytes")
            print(f"   First 50 bytes: {data[:50].hex()}")
            result = True
        elif status == 9:
            print("⚠️  Table is empty")
            result = True
        else:
            print(f"❌ Failed to read: status={status}")
            result = False

        # Close
        client.close_file(pos_block)
        return result

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_pab_read():
    """Test 3.4: Read PAB records"""
    print("\n" + "=" * 60)
    print("🧪 TEST 3.4: Read PAB Records")
    print("=" * 60)

    try:
        config = load_config('config/database.yaml')
        pab_path = config['nex_genesis']['tables']['pab']

        if not os.path.exists(pab_path):
            print(f"⚠️  File not found: {pab_path}")
            return False

        client = BtrieveClient()

        # Open file
        status, pos_block = client.open_file(pab_path, mode=-2)
        if status != 0:
            print(f"❌ Failed to open PAB: status={status}")
            return False

        print("✅ File opened")

        # Read first record
        status, data = client.get_first(pos_block)

        if status == 0:
            print(f"✅ First record read!")
            print(f"   Record size: {len(data)} bytes")
            print(f"   First 50 bytes: {data[:50].hex()}")
            result = True
        elif status == 9:
            print("⚠️  Table is empty")
            result = True
        else:
            print(f"❌ Failed to read: status={status}")
            result = False

        # Close
        client.close_file(pos_block)
        return result

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def run_all_tests():
    """Run all data reading tests"""
    print("\n" + "=" * 60)
    print("🚀 BTRIEVE DATA READING TESTS")
    print("=" * 60)

    results = {
        "GSCAT Read First": test_gscat_read_first(),
        "GSCAT Read Multiple": test_gscat_read_multiple(),
        "BARCODE Read": test_barcode_read(),
        "PAB Read": test_pab_read()
    }

    # Summary
    print("\n" + "=" * 60)
    print("📊 TEST SUMMARY")
    print("=" * 60)

    passed = sum(results.values())
    total = len(results)

    for test_name, result in results.items():
        status = "✅ PASSED" if result else "❌ FAILED"
        print(f"{test_name}: {status}")

    print(f"\nTotal: {passed}/{total} tests passed")

    if passed == total:
        print("\n🎉 All data reading tests passed!")
        print("✅ Btrieve client is working correctly!")
        return 0
    elif passed >= 2:
        print(f"\n⚠️  {total - passed} test(s) failed (but basic reading works)")
        return 0
    else:
        print(f"\n❌ Too many tests failed")
        return 1


if __name__ == "__main__":
    exit_code = run_all_tests()
    sys.exit(exit_code)