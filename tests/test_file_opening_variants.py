"""
Standalone test rôznych spôsobov otvárania Btrieve súborov
SPRÁVNA SYNTAX podľa Delphi btrapi32.pas!
"""
import ctypes
import os
import sys

# Btrieve operation codes
B_OPEN = 0
B_CLOSE = 1

# Error code meanings
ERROR_MEANINGS = {
    0: "Success",
    2: "I/O error",
    11: "Invalid filename",
    12: "File not open",
    46: "Access denied",
    84: "Record locked",
}


def load_btrieve_dll():
    """Načítaj Btrieve DLL a BTRCALL funkciu - SPRÁVNA SIGNATURE!"""
    dll_paths = [
        r"C:\Program Files (x86)\Pervasive Software\PSQL\bin\w3btrv7.dll",
        r"C:\PVSW\bin\w3btrv7.dll",
        r"external-dlls\w3btrv7.dll",
    ]

    for dll_path in dll_paths:
        if os.path.exists(dll_path):
            try:
                dll = ctypes.WinDLL(dll_path)

                # Get BTRCALL function
                try:
                    btrcall = dll.BTRCALL
                except AttributeError:
                    try:
                        btrcall = dll.btrcall
                    except AttributeError:
                        continue

                # Configure BTRCALL signature (PRESNE podľa btrapi32.pas!)
                btrcall.argtypes = [
                    ctypes.c_uint16,  # operation (WORD)
                    ctypes.POINTER(ctypes.c_char),  # posBlock (VAR)
                    ctypes.POINTER(ctypes.c_char),  # dataBuffer (VAR)
                    ctypes.POINTER(ctypes.c_uint32),  # dataLen (longInt = 4 bytes!)
                    ctypes.POINTER(ctypes.c_char),  # keyBuffer (VAR)
                    ctypes.c_uint8,  # keyLen (BYTE)
                    ctypes.c_uint8  # keyNum (BYTE, nie signed!)
                ]
                btrcall.restype = ctypes.c_int16  # SMALLINT

                print(f"✅ DLL loaded from: {dll_path}")
                print(f"✅ BTRCALL function configured (correct signature)")
                return btrcall

            except Exception as e:
                print(f"❌ Failed to load {dll_path}: {e}")

    raise RuntimeError("Cannot load Btrieve DLL from any known location")


def test_open_file(btrcall, file_path, mode=-2):
    """Test otvorenia súboru - PRESNE podľa Delphi BtrOpen + BTRV wrapper"""
    try:
        # Position block (128 bytes)
        pos_block = ctypes.create_string_buffer(128)

        # Data buffer je PRÁZDNY! (podľa Delphi BtrOpen)
        data_buffer = ctypes.create_string_buffer(256)
        data_len = ctypes.c_uint32(0)  # longInt (4 bytes), hodnota 0!

        # Key buffer obsahuje FILENAME! (nie data buffer!)
        filename_bytes = file_path.encode('ascii') + b'\x00'
        key_buffer = ctypes.create_string_buffer(filename_bytes)

        # keyLen = 255 (podľa BTRV wrapper)
        key_len = 255

        # Call BTRCALL - PRESNE podľa Delphi!
        status = btrcall(
            B_OPEN,  # operation
            pos_block,  # posBlock
            data_buffer,  # dataBuffer (prázdny!)
            ctypes.byref(data_len),  # dataLen (0!)
            key_buffer,  # keyBuffer (FILENAME!)
            key_len,  # keyLen (255!)
            mode & 0xFF  # keyNum/mode as BYTE
        )

        if status == 0:
            # Success - extract file handle from position block
            handle = ctypes.c_uint16.from_buffer(pos_block).value
            return True, handle, status, pos_block.raw
        else:
            return False, None, status, None

    except Exception as e:
        print(f"      Exception during BTRCALL: {e}")
        import traceback
        traceback.print_exc()
        return False, None, -1, None


def test_close_file(btrcall, pos_block_bytes):
    """Test zatvorenia súboru"""
    try:
        # Position block from open
        pos_block = ctypes.create_string_buffer(pos_block_bytes)

        # Empty buffers for close
        data_buffer = ctypes.create_string_buffer(1)
        data_len = ctypes.c_uint32(0)
        key_buffer = ctypes.create_string_buffer(1)

        status = btrcall(
            B_CLOSE,
            pos_block,
            data_buffer,
            ctypes.byref(data_len),
            key_buffer,
            0,  # keyLen
            0  # keyNum
        )

        return status == 0, status

    except Exception as e:
        print(f"      Exception during close: {e}")
        return False, -1


def main():
    """Main test function"""

    print("=" * 80)
    print("🧪 TEST: Btrieve File Opening - Delphi-Compatible BTRCALL")
    print("=" * 80)

    # Load DLL and get BTRCALL
    try:
        btrcall = load_btrieve_dll()
    except Exception as e:
        print(f"❌ Cannot load DLL: {e}")
        return False

    print()

    # Test cases
    test_cases = [
        ("1. Plná cesta - backslashes", r"C:\NEX\YEARACT\STORES\GSCAT.BTR", -2),
        ("2. Plná cesta - forward slashes", "C:/NEX/YEARACT/STORES/GSCAT.BTR", -2),
        ("3. Len filename", "GSCAT.BTR", -2),
        ("4. Database name (NEX:GSCAT)", "NEX:GSCAT", -2),
        ("5. Database name + .BTR", "NEX:GSCAT.BTR", -2),
        ("6. Database name + path", r"NEX:STORES\GSCAT.BTR", -2),
        ("7. Mode 0 (normal)", r"C:\NEX\YEARACT\STORES\GSCAT.BTR", 0),
        ("8. Mode -1 (accelerated)", r"C:\NEX\YEARACT\STORES\GSCAT.BTR", -1),
        ("9. Uppercase path", r"C:\NEX\YEARACT\STORES\GSCAT.BTR", -2),
        ("10. Lowercase path", r"c:\nex\yearact\stores\gscat.btr", -2),
        ("11. Mixed case", r"C:\Nex\YearAct\Stores\GsCat.btr", -2),
    ]

    results = []

    for i, (name, path, mode) in enumerate(test_cases, 1):
        print(f"📋 Test {i}/{len(test_cases)}: {name}")
        print(f"   Path: {path}")
        print(f"   Mode: {mode}")

        # Check if file exists on disk
        if ":" in path and not path.upper().startswith("NEX:"):
            if os.path.exists(path):
                print(f"   ✅ File exists on disk")
            else:
                print(f"   ⚠️  File not found on disk")

        # Try to open
        success, handle, status, pos_block = test_open_file(btrcall, path, mode)

        if success:
            print(f"   ✅ SUCCESS! Status: {status}, Handle: {handle}")

            # Try to close
            close_ok, close_status = test_close_file(btrcall, pos_block)
            if close_ok:
                print(f"   ✅ File closed successfully (status: {close_status})")
                results.append(("SUCCESS", name, path, mode))
            else:
                print(f"   ⚠️  File opened but close failed (status: {close_status})")
                results.append(("PARTIAL", name, path, mode))
        else:
            error_msg = ERROR_MEANINGS.get(status, "Unknown error")
            print(f"   ❌ FAILED: Status {status} - {error_msg}")
            results.append(("FAILED", name, path, mode, status, error_msg))

        print()

    # Summary
    print("=" * 80)
    print("📊 SUMMARY")
    print("=" * 80)

    success = [r for r in results if r[0] == "SUCCESS"]
    failed = [r for r in results if r[0] == "FAILED"]
    partial = [r for r in results if r[0] == "PARTIAL"]

    print(f"✅ Success: {len(success)}")
    print(f"❌ Failed:  {len(failed)}")
    print(f"⚠️  Partial: {len(partial)}")
    print()

    if success:
        print("✅ ÚSPEŠNÉ TESTY:")
        for r in success:
            _, name, path, mode = r
            print(f"   ✓ {name}")
            print(f"     Path: {path}")
            print(f"     Mode: {mode}")
        print()

    if partial:
        print("⚠️  ČIASTOČNE ÚSPEŠNÉ:")
        for r in partial:
            _, name, path, mode = r
            print(f"   ! {name}")
            print(f"     Path: {path}")
        print()

    if failed:
        print("❌ NEÚSPEŠNÉ TESTY:")
        for r in failed:
            _, name, path, mode, status, msg = r
            print(f"   ✗ {name}")
            print(f"     Path: {path}")
            print(f"     Error: Status {status} - {msg}")
        print()

    print("=" * 80)

    # Recommendations
    if success:
        print("\n💡 ODPORÚČANIA:")
        print(f"   Použite formát z úspešného testu:")
        best = success[0]
        print(f"   Path: {best[2]}")
        print(f"   Mode: {best[3]}")
    elif failed:
        print("\n❌ VŠETKY TESTY ZLYHALI")
        print("   Možné príčiny:")
        print("   1. Pervasive engine nie je správne nakonfigurovaný")
        print("   2. Súbory vyžadujú DDF (Data Dictionary Files)")
        print("   3. Potrebné database name registration")

    return len(success) > 0


if __name__ == "__main__":
    try:
        success = main()
        sys.exit(0 if success else 1)
    except Exception as e:
        print(f"\n❌ Test failed with exception: {e}")
        import traceback

        traceback.print_exc()
        sys.exit(1)