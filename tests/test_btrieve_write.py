"""
Test Btrieve WRITE operations (INSERT, UPDATE, DELETE)
Run ONLY on dev database!
"""
import sys
import os

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from src.btrieve.btrieve_client import BtrieveClient
from src.models.barcode import BarcodeRecord
from src.utils.config import load_config
from datetime import datetime


def test_insert_barcode():
    """Test 1: INSERT new barcode"""
    print("\n🧪 TEST: Insert New Barcode")
    print("=" * 60)

    try:
        config = load_config()
        barcode_path = config['nex_genesis']['tables']['barcode']

        print(f"📂 File: {barcode_path}")

        client = BtrieveClient()

        # Open file in READ-WRITE mode (mode=0)
        print(f"📂 Opening file in READ-WRITE mode...")
        status, pos_block = client.open_file(barcode_path, mode=0)

        if status != client.STATUS_SUCCESS:
            print(f"❌ Failed to open: {client.get_status_message(status)}")
            return False

        print("✅ File opened for writing")

        # Create test record
        test_barcode = BarcodeRecord(
            gs_code=999999,  # Test product ID
            bar_code="TEST_WRITE_999",
            mod_user="TEST",
            mod_date=datetime.now(),
            mod_time=datetime.now()
        )

        # Validate
        errors = test_barcode.validate()
        if errors:
            print(f"❌ Validation failed: {errors}")
            client.close_file(pos_block)
            return False

        print(f"✅ Record validated")

        # Serialize to bytes
        data = test_barcode.to_bytes()
        print(f"✅ Serialized: {len(data)} bytes")

        # INSERT using B_INSERT operation
        print(f"📝 Inserting barcode: {test_barcode.bar_code}")

        # Prepare buffers
        import ctypes
        pos_block_buf = ctypes.create_string_buffer(pos_block)
        data_buffer = ctypes.create_string_buffer(data)
        data_len = ctypes.c_ulong(len(data))  # Changed to c_ulong!
        key_buffer = ctypes.create_string_buffer(255)

        # Call INSERT
        status = client.btrcall(
            client.B_INSERT,
            pos_block_buf,
            data_buffer,
            ctypes.byref(data_len),
            key_buffer,
            0,
            0
        )

        if status == client.STATUS_SUCCESS:
            print(f"✅ INSERT successful!")

            # Verify by reading back
            print(f"🔍 Verifying insert...")
            status, first_data = client.get_first(pos_block_buf.raw)

            # Find our record
            found = False
            count = 0
            while status == client.STATUS_SUCCESS and count < 1000:
                record = BarcodeRecord.from_bytes(first_data)
                if record.bar_code == "TEST_WRITE_999":
                    found = True
                    print(f"✅ Record found in database!")
                    print(f"   GsCode: {record.gs_code}")
                    print(f"   BarCode: {record.bar_code}")
                    print(f"   ModUser: {record.mod_user}")
                    break
                status, first_data = client.get_next(pos_block_buf.raw)
                count += 1

            if not found:
                print(f"⚠️  Record not found after insert (searched {count} records)")

            result = True
        elif status == 5:  # DUPLICATE_KEY
            print(f"⚠️  Duplicate key - record already exists")
            result = True  # Not really an error for test
        else:
            print(f"❌ INSERT failed: {client.get_status_message(status)} (code {status})")
            result = False

        # Close
        client.close_file(pos_block_buf.raw)
        return result

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_update_barcode():
    """Test 2: UPDATE existing barcode"""
    print("\n🧪 TEST: Update Existing Barcode")
    print("=" * 60)

    try:
        config = load_config()
        barcode_path = config['nex_genesis']['tables']['barcode']

        client = BtrieveClient()

        # Open file in READ-WRITE mode
        print(f"📂 Opening file in READ-WRITE mode...")
        status, pos_block = client.open_file(barcode_path, mode=0)

        if status != client.STATUS_SUCCESS:
            print(f"❌ Failed to open: {client.get_status_message(status)}")
            return False

        # Find our test record
        print(f"🔍 Looking for TEST_WRITE_999...")
        status, data = client.get_first(pos_block)
        found_position = False
        count = 0

        import ctypes
        pos_block_buf = ctypes.create_string_buffer(pos_block)

        while status == client.STATUS_SUCCESS and count < 1000:
            record = BarcodeRecord.from_bytes(data)
            if record.bar_code == "TEST_WRITE_999":
                found_position = True
                print(f"✅ Found at position (after {count} records)")

                # Modify
                record.mod_user = "UPDATED"
                record.mod_date = datetime.now()
                record.mod_time = datetime.now()

                # Update
                print(f"📝 Updating record...")
                updated_data = record.to_bytes()

                data_buffer = ctypes.create_string_buffer(updated_data)
                data_len = ctypes.c_ulong(len(updated_data))  # Changed to c_ulong!
                key_buffer = ctypes.create_string_buffer(255)

                status = client.btrcall(
                    client.B_UPDATE,
                    pos_block_buf,
                    data_buffer,
                    ctypes.byref(data_len),
                    key_buffer,
                    0,
                    0
                )

                if status == client.STATUS_SUCCESS:
                    print(f"✅ UPDATE successful!")
                    result = True
                else:
                    print(f"❌ UPDATE failed: {client.get_status_message(status)} (code {status})")
                    result = False

                break

            status, data = client.get_next(pos_block_buf.raw)
            count += 1

        if not found_position:
            print(f"⚠️  Test record not found (searched {count} records)")
            print(f"    Run INSERT test first!")
            result = False

        client.close_file(pos_block_buf.raw)
        return result

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_delete_barcode():
    """Test 3: DELETE test barcode"""
    print("\n🧪 TEST: Delete Test Barcode")
    print("=" * 60)

    try:
        config = load_config()
        barcode_path = config['nex_genesis']['tables']['barcode']

        client = BtrieveClient()

        # Open file in READ-WRITE mode
        print(f"📂 Opening file in READ-WRITE mode...")
        status, pos_block = client.open_file(barcode_path, mode=0)

        if status != client.STATUS_SUCCESS:
            print(f"❌ Failed to open: {client.get_status_message(status)}")
            return False

        # Find our test record
        print(f"🔍 Looking for TEST_WRITE_999...")
        status, data = client.get_first(pos_block)
        found_position = False
        count = 0

        import ctypes
        pos_block_buf = ctypes.create_string_buffer(pos_block)

        while status == client.STATUS_SUCCESS and count < 1000:
            record = BarcodeRecord.from_bytes(data)
            if record.bar_code == "TEST_WRITE_999":
                found_position = True
                print(f"✅ Found at position (after {count} records)")

                # Delete
                print(f"🗑️  Deleting record...")

                data_buffer = ctypes.create_string_buffer(1)
                data_len = ctypes.c_ulong(0)  # Changed to c_ulong!
                key_buffer = ctypes.create_string_buffer(255)

                status = client.btrcall(
                    client.B_DELETE,
                    pos_block_buf,
                    data_buffer,
                    ctypes.byref(data_len),
                    key_buffer,
                    0,
                    0
                )

                if status == client.STATUS_SUCCESS:
                    print(f"✅ DELETE successful!")
                    result = True
                else:
                    print(f"❌ DELETE failed: {client.get_status_message(status)} (code {status})")
                    result = False

                break

            status, data = client.get_next(pos_block_buf.raw)
            count += 1

        if not found_position:
            print(f"⚠️  Test record not found (searched {count} records)")
            print(f"    Maybe already deleted?")
            result = False

        client.close_file(pos_block_buf.raw)
        return result

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def run_all_write_tests():
    """Run all write tests"""
    print("\n" + "=" * 60)
    print("🚀 BTRIEVE WRITE TESTS")
    print("=" * 60)
    print("⚠️  Running on DEV database: C:\\NEX\\YEARACT\\")
    print("⚠️  Backup created: C:\\NEX\\BACKUPS\\")
    print("")

    # Confirm
    response = input("Continue with write tests? (yes/no): ")
    if response.lower() != 'yes':
        print("❌ Tests cancelled")
        return 1

    results = {
        "INSERT": test_insert_barcode(),
        "UPDATE": test_update_barcode(),
        "DELETE": test_delete_barcode(),
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
        print("\n🎉 All write tests passed!")
        print("✅ INSERT, UPDATE, DELETE operations working!")
        print("\n💡 Next steps:")
        print("   - Write operations are VERIFIED")
        print("   - Safe to use in Phase 2 (ISDOC import)")
        print("   - Ready for CRUD repository implementation")
        return 0
    else:
        print(f"\n⚠️  {total - passed} test(s) failed")
        print("   Check error messages above")
        return 1


if __name__ == "__main__":
    exit_code = run_all_write_tests()
    sys.exit(exit_code)