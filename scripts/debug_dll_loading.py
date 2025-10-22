"""
Debug DLL Loading
Detailed diagnostics for Btrieve DLL loading issues
"""

import os
import sys
import ctypes
import platform


def check_dll_architecture(dll_path):
    """Check if DLL is 32-bit or 64-bit"""
    try:
        with open(dll_path, 'rb') as f:
            # Read DOS header
            f.seek(0x3C)  # Offset to PE header
            pe_offset = int.from_bytes(f.read(4), 'little')

            # Read PE header
            f.seek(pe_offset)
            pe_sig = f.read(4)
            if pe_sig != b'PE\x00\x00':
                return "Unknown (not PE format)"

            # Read machine type
            machine = int.from_bytes(f.read(2), 'little')

            if machine == 0x14c:
                return "32-bit (i386)"
            elif machine == 0x8664:
                return "64-bit (x64)"
            else:
                return f"Unknown (machine: {hex(machine)})"
    except Exception as e:
        return f"Error: {e}"


def try_load_dll(dll_path):
    """Try to load DLL with detailed error reporting"""
    print(f"\n{'=' * 60}")
    print(f"Testing: {os.path.basename(dll_path)}")
    print(f"{'=' * 60}")

    # Check if file exists
    if not os.path.exists(dll_path):
        print("❌ File does not exist")
        return False

    print(f"✅ File exists")
    print(f"   Path: {os.path.abspath(dll_path)}")
    print(f"   Size: {os.path.getsize(dll_path):,} bytes")

    # Check architecture
    arch = check_dll_architecture(dll_path)
    print(f"   Architecture: {arch}")

    # Check Python architecture
    py_arch = platform.architecture()[0]
    print(f"   Python: {py_arch}")

    if '32' in arch and py_arch == '32bit':
        print("   ✅ Architecture match!")
    elif '64' in arch and py_arch == '64bit':
        print("   ✅ Architecture match!")
    else:
        print(f"   ⚠️  Architecture mismatch! ({arch} vs Python {py_arch})")

    # Try to load
    print(f"\n🔧 Attempting to load DLL...")
    try:
        dll = ctypes.windll.LoadLibrary(dll_path)
        print(f"✅ DLL loaded successfully!")

        # Try to find Btrieve functions
        print(f"\n🔍 Looking for Btrieve functions...")
        func_names = ["BTRV", "BtrCall", "BTRVID", "BTRCALL", "BTRCALLID"]

        found_funcs = []
        for func_name in func_names:
            if hasattr(dll, func_name):
                print(f"   ✅ {func_name} - FOUND")
                found_funcs.append(func_name)
            else:
                print(f"   ❌ {func_name} - not found")

        if found_funcs:
            print(f"\n✅ SUCCESS! Found functions: {', '.join(found_funcs)}")
            return True
        else:
            print(f"\n⚠️  DLL loaded but no Btrieve functions found")
            return False

    except OSError as e:
        print(f"❌ OSError: {e}")

        # Check for common issues
        if "126" in str(e) or "not find" in str(e).lower():
            print("\n💡 This usually means:")
            print("   - DLL has missing dependencies (other DLLs)")
            print("   - DLL architecture doesn't match Python")
            print("\n🔧 Try:")
            print("   1. Install Pervasive PSQL v11 fully")
            print("   2. Copy ALL Pervasive DLLs to external-dlls/")
            print("   3. Check DLL is 32-bit (not 64-bit)")

        return False

    except Exception as e:
        print(f"❌ Error: {type(e).__name__}: {e}")
        return False


def main():
    """Main debug function"""
    print("\n" + "=" * 60)
    print("🔍 BTRIEVE DLL LOADING DEBUG")
    print("=" * 60)

    # Python info
    print(f"\n📊 Python Information:")
    print(f"   Version: {sys.version}")
    print(f"   Architecture: {platform.architecture()[0]}")
    print(f"   Machine: {platform.machine()}")

    # DLL directory
    dll_dir = "external-dlls"
    if not os.path.exists(dll_dir):
        dll_dir = os.path.join("..", "external-dlls")

    if not os.path.exists(dll_dir):
        print(f"\n❌ DLL directory not found: external-dlls/")
        return 1

    print(f"\n📁 DLL Directory: {os.path.abspath(dll_dir)}")

    # List all DLLs
    dll_files = [f for f in os.listdir(dll_dir) if f.lower().endswith('.dll')]
    print(f"   Found {len(dll_files)} DLL files:")
    for dll_file in dll_files:
        print(f"      - {dll_file}")

    # Test each DLL
    results = {}
    for dll_file in dll_files:
        dll_path = os.path.join(dll_dir, dll_file)
        success = try_load_dll(dll_path)
        results[dll_file] = success

    # Summary
    print(f"\n{'=' * 60}")
    print("📊 SUMMARY")
    print(f"{'=' * 60}")

    success_count = sum(results.values())
    total_count = len(results)

    for dll_file, success in results.items():
        status = "✅ SUCCESS" if success else "❌ FAILED"
        print(f"{dll_file}: {status}")

    print(f"\nTotal: {success_count}/{total_count} DLLs loaded successfully")

    if success_count > 0:
        print("\n🎉 At least one DLL works! You can proceed with testing.")
        return 0
    else:
        print("\n❌ No DLLs could be loaded. Check the errors above.")
        print("\n💡 Common solutions:")
        print("   1. Make sure Python is 32-bit")
        print("   2. Install Pervasive PSQL v11 completely")
        print("   3. Copy all Pervasive DLLs to external-dlls/")
        print("   4. Check Windows Event Viewer for DLL loading errors")
        return 1


if __name__ == "__main__":
    sys.exit(main())