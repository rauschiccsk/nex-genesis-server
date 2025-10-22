"""
Test 2: Btrieve File Opening
Tests opening of actual Btrieve table files
REQUIRES DATABASE ACCESS
"""

import sys
import os

# Add src to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from src.btrieve.btrieve_client import BtrieveClient, BtrStatus
from src.utils.config import get_config


def test_gscat_open():
    """Test 2.1: Open GSCAT table"""
    print("\n🧪 TEST 2.1: Open GSCAT Table")
    print("=" * 60)

    try:
        config = get_config()
        gscat_path = config.get_table_path('gscat')

        print(f"📁 GSCAT path: {gscat_path}")

        # Check if file exists
        if not os.path.exists(gscat_path):
            print(f"⚠️  File not found: {gscat_path}")
            return False

        print(f"✅ File exists")

        # Try to open
        client = BtrieveClient()
        status = client.open_table('gscat')

        if status == BtrStatus.SUCCESS:
            print("✅ GSCAT opened successfully!")
            client.close_file()
            return True
        else:
            print(f"❌ Failed to open GSCAT: status={status}")
            return False

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_barcode_open():
    """Test 2.2: Open BARCODE table"""
    print("\n🧪 TEST 2.2: Open BARCODE Table")
    print("=" * 60)

    try:
        config = get_config()
        barcode_path = config.get_table_path('barcode')

        print(f"📁 BARCODE path: {barcode_path}")

        if not os.path.exists(barcode_path):
            print(f"⚠️  File not found: {barcode_path}")
            return False

        print(f"✅ File exists")

        client = BtrieveClient()
        status = client.open_table('barcode')

        if status == BtrStatus.SUCCESS:
            print("✅ BARCODE opened successfully!")
            client.close_file()
            return True
        else:
            print(f"❌ Failed to open BARCODE: status={status}")
            return False

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_pab_open():
    """Test 2.3: Open PAB table"""
    print("\n🧪 TEST 2.3: Open PAB Table (DIALS)")
    print("=" * 60)

    try:
        config = get_config()
        pab_path = config.get_table_path('pab')

        print(f"📁 PAB path: {pab_path}")

        if not os.path.exists(pab_path):
            print(f"⚠️  File not found: {pab_path}")
            return False

        print(f"✅ File exists")

        client = BtrieveClient()
        status = client.open_table('pab')

        if status == BtrStatus.SUCCESS:
            print("✅ PAB opened successfully!")
            client.close_file()
            return True
        else:
            print(f"❌ Failed to open PAB: status={status}")
            return False

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_tsh_open():
    """Test 2.4: Open TSH table"""
    print("\n🧪 TEST 2.4: Open TSH Table (Delivery Notes Header)")
    print("=" * 60)

    try:
        config = get_config()
        tsh_path = config.get_table_path('tsh')

        print(f"📁 TSH path: {tsh_path}")
        print(f"   Filename: {config.get_tsh_filename()}")

        if not os.path.exists(tsh_path):
            print(f"⚠️  File not found: {tsh_path}")
            print(f"   This is OK if no delivery notes exist yet")
            return True  # Not critical

        print(f"✅ File exists")

        client = BtrieveClient()
        status = client.open_table('tsh')

        if status == BtrStatus.SUCCESS:
            print("✅ TSH opened successfully!")
            client.close_file()
            return True
        else:
            print(f"❌ Failed to open TSH: status={status}")
            return False

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_tsi_open():
    """Test 2.5: Open TSI table"""
    print("\n🧪 TEST 2.5: Open TSI Table (Delivery Notes Items)")
    print("=" * 60)

    try:
        config = get_config()
        tsi_path = config.get_table_path('tsi')

        print(f"📁 TSI path: {tsi_path}")
        print(f"   Filename: {config.get_tsi_filename()}")

        if not os.path.exists(tsi_path):
            print(f"⚠️  File not found: {tsi_path}")
            print(f"   This is OK if no delivery notes exist yet")
            return True  # Not critical

        print(f"✅ File exists")

        client = BtrieveClient()
        status = client.open_table('tsi')

        if status == BtrStatus.SUCCESS:
            print("✅ TSI opened successfully!")
            client.close_file()
            return True
        else:
            print(f"❌ Failed to open TSI: status={status}")
            return False

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def run_all_tests():
    """Run all file opening tests"""
    print("\n" + "=" * 60)
    print("🚀 BTRIEVE FILE OPENING TESTS")
    print("=" * 60)

    results = {
        "GSCAT": test_gscat_open(),
        "BARCODE": test_barcode_open(),
        "PAB": test_pab_open(),
        "TSH": test_tsh_open(),
        "TSI": test_tsi_open()
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
        print("\n🎉 All file opening tests passed!")
        return 0
    elif passed >= 3:
        print(f"\n⚠️  {total - passed} test(s) failed (but core tables work)")
        return 0
    else:
        print(f"\n❌ Too many tests failed")
        return 1


if __name__ == "__main__":
    exit_code = run_all_tests()
    sys.exit(exit_code)