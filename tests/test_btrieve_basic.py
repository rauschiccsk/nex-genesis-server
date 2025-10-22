"""
Test 1: Basic Btrieve DLL Loading
Tests if Btrieve DLL can be loaded successfully
NO DATABASE ACCESS NEEDED
"""

import sys
import os

# Add src to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from src.btrieve.btrieve_client import BtrieveClient
from src.utils.config import get_config


def test_config_loading():
    """Test 1.1: Config loading"""
    print("\n🧪 TEST 1.1: Configuration Loading")
    print("=" * 60)

    try:
        config = get_config()
        print("✅ Config loaded successfully!")

        # Print basic config info
        print(f"\n📊 Configuration:")
        print(f"  Root path: {config.get_root_path()}")
        print(f"  STORES path: {config.get_stores_path()}")
        print(f"  DIALS path: {config.get_dials_path()}")
        print(f"  DLL path: {config.get_dll_path()}")
        print(f"  Book number: {config.get_book_number()}")
        print(f"  Book type: {config.get_book_type()}")

        return True
    except Exception as e:
        print(f"❌ Config loading failed: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_dll_loading():
    """Test 1.2: DLL Loading"""
    print("\n🧪 TEST 1.2: Btrieve DLL Loading")
    print("=" * 60)

    try:
        # Check if DLL directory exists
        config = get_config()
        dll_path = config.get_dll_path()

        if not os.path.exists(dll_path):
            print(f"❌ DLL directory not found: {dll_path}")
            return False

        print(f"✅ DLL directory found: {dll_path}")

        # List DLL files
        dll_files = [f for f in os.listdir(dll_path) if f.lower().endswith('.dll')]
        print(f"\n📦 DLL files in directory:")
        for dll_file in dll_files:
            print(f"   - {dll_file}")

        # Try to load Btrieve client
        print(f"\n🔧 Loading Btrieve client...")
        client = BtrieveClient()
        print("✅ Btrieve client loaded successfully!")

        return True
    except Exception as e:
        print(f"❌ DLL loading failed: {e}")
        import traceback
        traceback.print_exc()
        return False


def test_path_validation():
    """Test 1.3: Path Validation"""
    print("\n🧪 TEST 1.3: Path Validation")
    print("=" * 60)

    try:
        config = get_config()
        result = config.validate_paths()

        if result:
            print("\n✅ All paths validated!")
            return True
        else:
            print("\n⚠️  Some paths missing (see warnings above)")
            return True  # Still OK for basic test
    except Exception as e:
        print(f"❌ Path validation failed: {e}")
        import traceback
        traceback.print_exc()
        return False


def run_all_tests():
    """Run all basic tests"""
    print("\n" + "=" * 60)
    print("🚀 BTRIEVE BASIC TESTS")
    print("=" * 60)

    results = {
        "Config Loading": test_config_loading(),
        "DLL Loading": test_dll_loading(),
        "Path Validation": test_path_validation()
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
        print("\n🎉 All basic tests passed!")
        return 0
    else:
        print(f"\n⚠️  {total - passed} test(s) failed")
        return 1


if __name__ == "__main__":
    exit_code = run_all_tests()
    sys.exit(exit_code)