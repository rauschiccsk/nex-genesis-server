"""
Repository Tests
Tests for high-level repository operations

Run with: pytest tests/test_repositories.py -v
"""

import sys
import os

sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from src.repositories import BarcodeRepository, GSCATRepository, PABRepository
from decimal import Decimal


def test_barcode_repository_basic():
    """Test basic barcode repository operations"""
    print("\n🧪 TEST: Barcode Repository - Basic Operations")
    print("=" * 60)

    with BarcodeRepository() as repo:
        # Test count
        count = repo.count()
        print(f"✅ Total barcodes: {count}")
        assert count >= 0, "Count should be non-negative"

        # Test get_first
        first = repo.get_first()
        if first:
            print(f"✅ First barcode: {first.bar_code} (GsCode: {first.gs_code})")
            assert first.gs_code > 0, "GsCode should be positive"
            assert len(first.bar_code) > 0, "BarCode should not be empty"
        else:
            print("⚠️  No barcodes in table (empty)")

        return True


def test_barcode_repository_search():
    """Test barcode search operations"""
    print("\n🧪 TEST: Barcode Repository - Search Operations")
    print("=" * 60)

    with BarcodeRepository() as repo:
        # Get first barcode
        first = repo.get_first()
        if not first:
            print("⚠️  Table empty, skipping search tests")
            return True

        # Test find by barcode
        found = repo.find_by_barcode(first.bar_code)
        assert found is not None, "Should find barcode that exists"
        assert found.bar_code == first.bar_code, "Found barcode should match"
        print(f"✅ Found barcode: {found.bar_code}")

        # Test find by gs_code
        barcodes = repo.find_by_gs_code(first.gs_code)
        assert len(barcodes) > 0, "Should find at least one barcode"
        print(f"✅ Product {first.gs_code} has {len(barcodes)} barcode(s)")

        # Test existence
        exists = repo.exists_barcode(first.bar_code)
        assert exists, "Barcode should exist"
        print(f"✅ Barcode exists: {exists}")

        # Test get product code
        gs_code = repo.get_product_code(first.bar_code)
        assert gs_code == first.gs_code, "Product code should match"
        print(f"✅ Product code: {gs_code}")

        return True


def test_barcode_repository_statistics():
    """Test barcode statistics"""
    print("\n🧪 TEST: Barcode Repository - Statistics")
    print("=" * 60)

    with BarcodeRepository() as repo:
        stats = repo.get_statistics()

        print(f"📊 Statistics:")
        print(f"  Total barcodes: {stats['total_barcodes']}")
        print(f"  Unique products: {stats['unique_products']}")
        print(f"  Avg per product: {stats['avg_barcodes_per_product']:.2f}")
        print(f"  Max per product: {stats['max_barcodes_per_product']}")

        assert stats['total_barcodes'] >= 0, "Total should be non-negative"
        assert stats['unique_products'] >= 0, "Unique products should be non-negative"

        if stats['duplicates'] > 0:
            print(f"⚠️  Found {stats['duplicates']} duplicate barcodes")

        return True


def test_gscat_repository_basic():
    """Test basic GSCAT repository operations"""
    print("\n🧪 TEST: GSCAT Repository - Basic Operations")
    print("=" * 60)

    with GSCATRepository() as repo:
        # Test count
        count = repo.count()
        print(f"✅ Total products: {count}")
        assert count >= 0, "Count should be non-negative"

        # Test get_first
        first = repo.get_first()
        if first:
            print(f"✅ First product: {first.gs_name} (GsCode: {first.gs_code})")
            assert first.gs_code > 0, "GsCode should be positive"
            assert len(first.gs_name) > 0, "Name should not be empty"

            # Test validation
            errors = first.validate()
            if errors:
                print(f"⚠️  Validation errors: {errors}")
            else:
                print(f"✅ Record is valid")
        else:
            print("⚠️  No products in table (empty)")

        return True


def test_gscat_repository_search():
    """Test GSCAT search operations"""
    print("\n🧪 TEST: GSCAT Repository - Search Operations")
    print("=" * 60)

    with GSCATRepository() as repo:
        # Get first product
        first = repo.get_first()
        if not first:
            print("⚠️  Table empty, skipping search tests")
            return True

        # Test find by gs_code
        found = repo.find_by_gs_code(first.gs_code)
        assert found is not None, "Should find product that exists"
        assert found.gs_code == first.gs_code, "Found product should match"
        print(f"✅ Found product: {found.gs_name}")

        # Test search by name (partial)
        if len(first.gs_name) > 3:
            search_term = first.gs_name[:3]
            results = repo.search_by_name(search_term)
            print(f"✅ Search '{search_term}': {len(results)} result(s)")

        # Test get active
        active = repo.get_active_products()
        print(f"✅ Active products: {len(active)}")

        # Test get product info
        info = repo.get_product_info(first.gs_code)
        assert info is not None, "Should get product info"
        print(f"✅ Product info retrieved")
        print(f"  Name: {info['name']}")
        print(f"  Price: {info['price_sell']} EUR")
        print(f"  Stock: {info['stock_current']} {info['unit']}")

        return True


def test_gscat_repository_statistics():
    """Test GSCAT statistics"""
    print("\n🧪 TEST: GSCAT Repository - Statistics")
    print("=" * 60)

    with GSCATRepository() as repo:
        stats = repo.get_statistics()

        print(f"📊 Product Statistics:")
        print(f"  Total products: {stats['total_products']}")
        print(f"  Active: {stats['active_products']}")
        print(f"  Discontinued: {stats['discontinued_products']}")
        print(f"  Categories: {stats['categories_used']}")
        print(f"  Low stock: {stats['low_stock_count']}")
        print(f"  Avg price: {stats['price_avg']:.2f} EUR")
        print(f"  Price range: {stats['price_min']:.2f} - {stats['price_max']:.2f} EUR")

        assert stats['total_products'] >= 0, "Total should be non-negative"

        # Test stock value calculation
        value = repo.calculate_total_stock_value()
        print(f"\n💰 Stock Value:")
        print(f"  Buy value: {value['total_buy_value']:.2f} EUR")
        print(f"  Sell value: {value['total_sell_value']:.2f} EUR")
        print(f"  Profit: {value['potential_profit']:.2f} EUR")
        print(f"  Margin: {value['profit_margin_percent']:.1f}%")

        return True


def test_pab_repository_basic():
    """Test basic PAB repository operations"""
    print("\n🧪 TEST: PAB Repository - Basic Operations")
    print("=" * 60)

    with PABRepository() as repo:
        # Test count
        count = repo.count()
        print(f"✅ Total partners: {count}")
        assert count >= 0, "Count should be non-negative"

        # Test get_first
        first = repo.get_first()
        if first:
            print(f"✅ First partner: {first.get_full_name()} (PabCode: {first.pab_code})")
            assert first.pab_code > 0, "PabCode should be positive"
            assert len(first.name1) > 0, "Name should not be empty"
        else:
            print("⚠️  No partners in table (empty)")

        return True


def test_pab_repository_search():
    """Test PAB search operations"""
    print("\n🧪 TEST: PAB Repository - Search Operations")
    print("=" * 60)

    with PABRepository() as repo:
        # Get first partner
        first = repo.get_first()
        if not first:
            print("⚠️  Table empty, skipping search tests")
            return True

        # Test find by pab_code
        found = repo.find_by_pab_code(first.pab_code)
        assert found is not None, "Should find partner that exists"
        assert found.pab_code == first.pab_code, "Found partner should match"
        print(f"✅ Found partner: {found.get_full_name()}")

        # Test search by name (partial)
        if len(first.name1) > 3:
            search_term = first.name1[:3]
            results = repo.search_by_name(search_term)
            print(f"✅ Search '{search_term}': {len(results)} result(s)")

        # Test get suppliers
        suppliers = repo.get_suppliers()
        print(f"✅ Suppliers: {len(suppliers)}")

        # Test get customers
        customers = repo.get_customers()
        print(f"✅ Customers: {len(customers)}")

        # Test get partner info
        info = repo.get_partner_info(first.pab_code)
        assert info is not None, "Should get partner info"
        print(f"✅ Partner info retrieved")
        print(f"  Name: {info['name']}")
        print(f"  Type: {info['type']}")
        print(f"  Email: {info['email']}")

        return True


def test_pab_repository_statistics():
    """Test PAB statistics"""
    print("\n🧪 TEST: PAB Repository - Statistics")
    print("=" * 60)

    with PABRepository() as repo:
        stats = repo.get_statistics()

        print(f"📊 Partner Statistics:")
        print(f"  Total partners: {stats['total_partners']}")
        print(f"  Active: {stats['active_partners']}")
        print(f"  Suppliers: {stats['suppliers']}")
        print(f"  Customers: {stats['customers']}")
        print(f"  Both: {stats['both_supplier_and_customer']}")
        print(f"  VAT payers: {stats['vat_payers']}")

        if stats['top_cities']:
            print(f"\n🏙️  Top cities:")
            for city, count in stats['top_cities']:
                print(f"    {city}: {count}")

        assert stats['total_partners'] >= 0, "Total should be non-negative"

        return True


def run_all_tests():
    """Run all repository tests"""
    print("\n" + "=" * 60)
    print("🚀 REPOSITORY TESTS")
    print("=" * 60)

    tests = [
        ("Barcode Basic", test_barcode_repository_basic),
        ("Barcode Search", test_barcode_repository_search),
        ("Barcode Statistics", test_barcode_repository_statistics),
        ("GSCAT Basic", test_gscat_repository_basic),
        ("GSCAT Search", test_gscat_repository_search),
        ("GSCAT Statistics", test_gscat_repository_statistics),
        ("PAB Basic", test_pab_repository_basic),
        ("PAB Search", test_pab_repository_search),
        ("PAB Statistics", test_pab_repository_statistics),
    ]

    results = {}

    for name, test_func in tests:
        try:
            result = test_func()
            results[name] = result
        except Exception as e:
            print(f"\n❌ Test failed: {e}")
            import traceback
            traceback.print_exc()
            results[name] = False

    # Summary
    print("\n" + "=" * 60)
    print("📊 TEST SUMMARY")
    print("=" * 60)

    passed = sum(results.values())
    total = len(results)

    for name, result in results.items():
        status = "✅ PASSED" if result else "❌ FAILED"
        print(f"{name}: {status}")

    print(f"\nTotal: {passed}/{total} tests passed")

    if passed == total:
        print("\n🎉 All repository tests passed!")
        return 0
    else:
        print(f"\n⚠️  {total - passed} test(s) failed")
        return 1


if __name__ == "__main__":
    exit_code = run_all_tests()
    sys.exit(exit_code)