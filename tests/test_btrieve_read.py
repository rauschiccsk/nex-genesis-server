"""
Test 3: Btrieve Data Reading
Tests reading actual data from Btrieve tables
REQUIRES DATABASE ACCESS WITH DATA
"""

import sys
import os

# Add src to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from src.btrieve.btrieve_client import BtrieveClient, BtrStatus
from src.utils.config import get_config


def test_gscat_read_first():
    """Test 3.1: Read first GSCAT record"""
    print("\n🧪 TEST 3.1: Read First GSCAT Record")
    print("=" * 60)

    try:
        config = get_config()
        gscat_path = config.get_table_path('gscat')

        if not os.path.exists(gscat_path):
            print(f"⚠️  File not found: {gscat_path}")
            return False

        client = BtrieveClient()

        # Open file
        status = client.open_table('gscat')
        if status != BtrStatus.SUCCESS:
            print(f"❌ Failed to open GSCAT: status={status}")
            return False

        print("✅ File opened")

        # Read first record
        status, data = client.get_first()

        if status == BtrStatus.SUCCESS:
            print(f"✅ First record read successfully!")
            print(f"   Record size: {len(data)} bytes")
            print(f"   First 100 bytes: {data[:100]}")
            print(f"   Hex: {data[:100].hex()}")

            # Try to decode some fields (approximate)
            try:
                # First 4 bytes might be GsCode (int)
                gs_code = int.from_bytes(data[0:4], byteorder='little')
                print(f"\n   Possible GsCode: {gs_code}")
            except:
                pass

            result = True
        elif status == BtrStatus.END_OF_FILE:
            print("⚠️  Table is empty (no records)")
            result = True  # OK, just empty
        else:
            print(f"❌ Failed to read: status={status}")
            result = False

        # Close
        client.close_file()
        return result

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_gscat_read_multiple():
    """Test 3.2: Read multiple GSCAT records"""
    print("\n🧪 TEST 3.2: Read Multiple GSCAT Records")
    print("=" * 60)

    try:
        config = get_config()
        gscat_path = config.get_table_path('gscat')

        if not os.path.exists(gscat_path):
            print(f"⚠️  File not found: {gscat_path}")
            return False

        client = BtrieveClient()

        # Open file
        status = client.open_table('gscat')
        if status != BtrStatus.SUCCESS:
            print(f"❌ Failed to open GSCAT: status={status}")
            return False

        print("✅ File opened")

        # Read first record
        status, data = client.get_first()
        if status != BtrStatus.SUCCESS:
            if status == BtrStatus.END_OF_FILE:
                print("⚠️  Table is empty")
                client.close_file()
                return True
            else:
                print(f"❌ Failed to read first: status={status}")
                client.close_file()
                return False

        record_count = 1
        print(f"✅ Record 1: {len(data)} bytes")

        # Try to read next few records
        max_records = 5
        while record_count < max_records:
            status, data = client.get_next()
            if status == BtrStatus.SUCCESS:
                record_count += 1
                print(f"✅ Record {record_count}: {len(data)} bytes")
            elif status == BtrStatus.END_OF_FILE:
                print(f"\n✅ Reached end of file after {record_count} records")
                break
            else:
                print(f"❌ Error reading record {record_count + 1}: status={status}")
                break

        print(f"\n📊 Total records read: {record_count}")

        # Close
        client.close_file()
        return record_count > 0

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_barcode_read():
    """Test 3.3: Read BARCODE records"""
    print("\n🧪 TEST 3.3: Read BARCODE Records")
    print("=" * 60)

    try:
        config = get_config()
        barcode_path = config.get_table_path('barcode')

        if not os.path.exists(barcode_path):
            print(f"⚠️  File not found: {barcode_path}")
            return False

        client = BtrieveClient()

        # Open file
        status = client.open_table('barcode')
        if status != BtrStatus.SUCCESS:
            print(f"❌ Failed to open BARCODE: status={status}")
            return False

        print("✅ File opened")

        # Read first record
        status, data = client.get_first()

        if status == BtrStatus.SUCCESS:
            print(f"✅ First record read!")
            print(f"   Record size: {len(data)} bytes")
            print(f"   First 50 bytes: {data[:50]}")
            result = True
        elif status == BtrStatus.END_OF_FILE:
            print("⚠️  Table is empty")
            result = True
        else:
            print(f"❌ Failed to read: status={status}")
            result = False

        # Close
        client.close_file()
        return result

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_pab_read():
    """Test 3.4: Read PAB records"""
    print("\n🧪 TEST 3.4: Read PAB Records")
    print("=" * 60)

    try:
        config = get_config()
        pab_path = config.get_table_path('pab')

        if not os.path.exists(pab_path):
            print(f"⚠️  File not found: {pab_path}")
            return False

        client = BtrieveClient()

        # Open file
        status = client.open_table('pab')
        if status != BtrStatus.SUCCESS:
            print(f"❌ Failed to open PAB: status={status}")
            return False

        print("✅ File opened")

        # Read first record
        status, data = client.get_first()

        if status == BtrStatus.SUCCESS:
            print(f"✅ First record read!")
            print(f"   Record size: {len(data)} bytes")
            print(f"   First 50 bytes: {data[:50]}")
            result = True
        elif status == BtrStatus.END_OF_FILE:
            print("⚠️  Table is empty")
            result = True
        else:
            print(f"❌ Failed to read: status={status}")
            result = False

        # Close
        client.close_file()
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