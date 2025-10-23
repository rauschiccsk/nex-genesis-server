"""
Test GSCAT Model Parsing

Tests parsing of real GSCAT.BTR records into GSCATRecord dataclass.

Prerequisites:
- 32-bit Python
- Btrieve DLL loaded
- NEX Genesis database accessible at C:\\NEX\\YEARACT\\STORES\\GSCAT.BTR

Run:
    python tests/test_gscat_parsing.py
"""

import sys
import os
from pathlib import Path

# Add src to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from src.btrieve.btrieve_client import BtrieveClient
from src.models import GSCATRecord, parse_gscat_record
from src.utils.config import load_config


def test_gscat_parsing():
    """Test GSCAT record parsing with real database data"""

    print("=" * 70)
    print("🧪 TEST: GSCAT Model Parsing")
    print("=" * 70)
    print()

    # Load config
    config_path = Path(__file__).parent.parent / "config" / "database.yaml"
    print(f"📁 Loading config: {config_path}")

    if not config_path.exists():
        print(f"❌ Config file not found: {config_path}")
        return False

    config = load_config(str(config_path))

    # Get GSCAT path
    gscat_path = config['nex_genesis']['tables']['gscat']
    print(f"📁 GSCAT path: {gscat_path}")
    print()

    # Check if file exists
    if not Path(gscat_path).exists():
        print(f"❌ GSCAT.BTR not found: {gscat_path}")
        print("   Make sure NEX Genesis database is accessible")
        return False

    # Initialize Btrieve client
    print("🔧 Initializing Btrieve client...")
    try:
        client = BtrieveClient()
        print("✅ Btrieve client initialized")
        print()
    except Exception as e:
        print(f"❌ Failed to initialize Btrieve client: {e}")
        return False

    # Open GSCAT file
    print(f"📖 Opening GSCAT.BTR (read-only mode)...")
    try:
        status, pos_block = client.open_file(gscat_path, mode=-2)

        if status != BtrieveClient.STATUS_SUCCESS:
            print(f"❌ Failed to open GSCAT.BTR: {client.get_status_message(status)}")
            return False

        print("✅ GSCAT.BTR opened successfully")
        print()
    except Exception as e:
        print(f"❌ Exception opening GSCAT.BTR: {e}")
        return False

    # Read and parse records
    print("=" * 70)
    print("📊 Reading and Parsing GSCAT Records")
    print("=" * 70)
    print()

    try:
        # Get first record
        status, raw_bytes = client.get_first(pos_block, key_num=0)

        if status != BtrieveClient.STATUS_SUCCESS:
            print(f"❌ Failed to read first record: {client.get_status_message(status)}")
            client.close_file(pos_block)
            return False

        print(f"✅ First record read: {len(raw_bytes)} bytes")
        print()

        # Parse record
        print("🔍 Parsing first record...")
        print("-" * 70)

        try:
            record = parse_gscat_record(raw_bytes)

            print(f"✅ Record parsed successfully!")
            print()
            print("📋 Parsed Data:")
            print(f"   GsCode:      {record.GsCode}")
            print(f"   GsName:      '{record.GsName}'")
            print(f"   GsName2:     '{record.GsName2}'")
            print(f"   GsEAN:       '{record.GsEAN}'")
            print(f"   MglstCode:   {record.MglstCode}")
            print(f"   GsPrice:     {record.GsPrice} €")
            print(f"   GsVatRate:   {record.GsVatRate} %")
            print(f"   Price+VAT:   {record.price_with_vat} €")
            print()

            # Validation
            print("✓ Validation:")
            if record.is_valid():
                print("   ✅ Record is valid")
            else:
                print("   ⚠️  Record has validation errors:")
                for error in record.validate():
                    print(f"      - {error}")
            print()

            # String representation
            print(f"✓ String repr: {record}")
            print()

            # Dict export
            print("✓ Dictionary export (sample):")
            record_dict = record.to_dict()
            for key in ['gs_code', 'gs_name', 'gs_price', 'price_with_vat', 'stock_status']:
                print(f"   {key}: {record_dict.get(key)}")
            print()

        except Exception as e:
            print(f"❌ Failed to parse record: {e}")
            import traceback
            traceback.print_exc()
            client.close_file(pos_block)
            return False

        # Try reading more records
        print("=" * 70)
        print("📊 Reading Additional Records")
        print("=" * 70)
        print()

        records_read = 1
        max_records = 5

        while records_read < max_records:
            status, raw_bytes = client.get_next(pos_block)

            if status == 9:  # End of file
                print(f"✅ End of file reached after {records_read} records")
                break

            if status != BtrieveClient.STATUS_SUCCESS:
                print(f"⚠️  Stop at record {records_read + 1}: {client.get_status_message(status)}")
                break

            try:
                record = parse_gscat_record(raw_bytes)
                records_read += 1

                print(f"✅ Record {records_read}:")
                print(f"   GsCode: {record.GsCode:6d} | Name: {record.GsName[:40]}")

            except Exception as e:
                print(f"❌ Failed to parse record {records_read + 1}: {e}")
                break

        print()
        print(f"📊 Successfully parsed {records_read} records")
        print()

    except Exception as e:
        print(f"❌ Exception during reading: {e}")
        import traceback
        traceback.print_exc()
        client.close_file(pos_block)
        return False

    # Close file
    print("🔒 Closing GSCAT.BTR...")
    try:
        status = client.close_file(pos_block)
        if status == BtrieveClient.STATUS_SUCCESS:
            print("✅ GSCAT.BTR closed successfully")
        else:
            print(f"⚠️  Close returned status: {client.get_status_message(status)}")
    except Exception as e:
        print(f"❌ Exception closing file: {e}")

    print()
    print("=" * 70)
    print("✅ TEST COMPLETED SUCCESSFULLY")
    print("=" * 70)
    return True


def test_manual_record_creation():
    """Test manual creation of GSCAT record"""

    print()
    print("=" * 70)
    print("🧪 TEST: Manual GSCAT Record Creation")
    print("=" * 70)
    print()

    from src.models import create_gscat_record
    from decimal import Decimal

    # Create test record
    record = create_gscat_record(
        gs_code=999,
        gs_name="Test Product - Opto-elektronický systém",
        mglst_code=5,
        gs_price=1250.50,
        gs_vat_rate=20.0,
        GsEAN="8594000123456",
        GsCatalog="TEST-001",
        GsStock=Decimal('15.5'),
    )

    print("✅ Record created:")
    print(f"   {record}")
    print()

    print("📋 Properties:")
    print(f"   Price with VAT: {record.price_with_vat} €")
    print(f"   Stock status:   {record.stock_status}")
    print()

    # Validation
    if record.is_valid():
        print("✅ Record is valid")
    else:
        print("❌ Record has errors:")
        for error in record.validate():
            print(f"   - {error}")

    print()
    return True


if __name__ == '__main__':
    print()
    print("🚀 NEX Genesis Server - GSCAT Model Parsing Tests")
    print()

    success = True

    # Test 1: Real database parsing
    try:
        if not test_gscat_parsing():
            success = False
    except Exception as e:
        print(f"❌ Test failed with exception: {e}")
        import traceback

        traceback.print_exc()
        success = False

    # Test 2: Manual creation
    try:
        if not test_manual_record_creation():
            success = False
    except Exception as e:
        print(f"❌ Manual creation test failed: {e}")
        import traceback

        traceback.print_exc()
        success = False

    print()
    if success:
        print("=" * 70)
        print("✅ ALL TESTS PASSED")
        print("=" * 70)
        sys.exit(0)
    else:
        print("=" * 70)
        print("❌ SOME TESTS FAILED")
        print("=" * 70)
        sys.exit(1)