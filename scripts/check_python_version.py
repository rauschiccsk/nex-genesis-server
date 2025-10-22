"""
Check Python version for Btrieve compatibility
NEX Genesis requires 32-bit Python for wxqlcall.dll
"""

import sys
import platform

def check_python_version():
    """Check if Python is 32-bit (required for Btrieve DLL)"""

    print("\n" + "=" * 60)
    print("🐍 PYTHON VERSION CHECK")
    print("=" * 60)

    # Python version
    version = sys.version
    print(f"\nPython version: {version}")

    # Architecture
    arch = platform.architecture()
    bits = arch[0]
    linkage = arch[1]

    print(f"Architecture: {bits} ({linkage})")
    print(f"Machine: {platform.machine()}")
    print(f"Platform: {platform.platform()}")

    # Check if 32-bit
    is_32bit = bits == '32bit'

    print("\n" + "=" * 60)
    if is_32bit:
        print("✅ COMPATIBLE")
        print("=" * 60)
        print("✅ Python is 32-bit")
        print("✅ Can load wxqlcall.dll (Pervasive PSQL v11)")
        print("✅ NEX Genesis Btrieve client will work")
        return True
    else:
        print("❌ INCOMPATIBLE")
        print("=" * 60)
        print("❌ Python is 64-bit")
        print("❌ Cannot load wxqlcall.dll (32-bit DLL)")
        print("❌ NEX Genesis Btrieve client will NOT work")
        print("\n⚠️  SOLUTION:")
        print("   1. Install 32-bit Python from python.org")
        print("   2. Look for: 'Windows installer (32-bit)'")
        print("   3. Reinstall project dependencies")
        return False

if __name__ == "__main__":
    is_compatible = check_python_version()
    sys.exit(0 if is_compatible else 1)