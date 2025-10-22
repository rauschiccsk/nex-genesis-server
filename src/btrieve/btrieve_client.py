"""
NEX Genesis Server - Btrieve Client
Python wrapper pre Pervasive PSQL Btrieve API
"""

import ctypes
from ctypes import *
from enum import IntEnum
from typing import Optional, Tuple
import os
import sys

# Add parent directory to path for imports
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..'))

from src.utils.config import get_config

# =============================================================================
# BTRIEVE OPERATION CODES
# =============================================================================

class BtrOp(IntEnum):
    """Btrieve operation codes"""
    # Basic operations
    OPEN = 0
    CLOSE = 1
    INSERT = 2
    UPDATE = 3
    DELETE = 4

    # Get operations
    GET_EQUAL = 5
    GET_NEXT = 6
    GET_PREVIOUS = 7
    GET_GREATER = 8
    GET_GREATER_EQUAL = 9
    GET_LESS_THAN = 10
    GET_LESS_EQUAL = 11
    GET_FIRST = 12
    GET_LAST = 13

    # Position operations
    GET_DIRECT = 23
    STEP_FIRST = 33
    STEP_LAST = 34
    STEP_NEXT = 24
    STEP_PREVIOUS = 36

    # Other operations
    CREATE = 14
    STAT = 15
    EXTEND = 16
    SET_DIR = 17
    GET_DIR = 18
    BEGIN_TRAN = 19
    END_TRAN = 20
    ABORT_TRAN = 21
    GET_POSITION = 22
    UNLOCK = 27
    RESET = 28
    SET_OWNER = 29
    CLEAR_OWNER = 30
    CREATE_INDEX = 31
    DROP_INDEX = 32
    VERSION = 26
    STOP = 25

# =============================================================================
# BTRIEVE STATUS CODES
# =============================================================================

class BtrStatus(IntEnum):
    """Btrieve status codes"""
    SUCCESS = 0
    INVALID_OPERATION = 1
    IO_ERROR = 2
    FILE_NOT_OPEN = 3
    KEY_NOT_FOUND = 4
    DUPLICATE_KEY = 5
    INVALID_KEY_NUMBER = 6
    DIFFERENT_KEY_NUMBER = 7
    INVALID_POSITIONING = 8
    END_OF_FILE = 9
    MODIFIABLE_KEY_VALUE_ERROR = 10
    FILE_NAME_BAD = 11
    FILE_NOT_FOUND = 12
    EXTENDED_FILE_ERROR = 13
    PERMISSION_ERROR = 14
    ALREADY_OPEN = 15
    CLOSE_ERROR = 16
    DISK_FULL = 17
    INCOMPLETE_ACCEL_ACCESS = 18
    INCOMPLETE_INDEX = 19
    EXPANSION_ERROR = 20
    CLOSE_ERROR_20 = 20
    RECORD_LOCKED = 84
    FILE_LOCKED = 85

# =============================================================================
# BTRIEVE CLIENT CLASS
# =============================================================================

class BtrieveClient:
    """
    Python wrapper pre Btrieve API

    Usage:
        client = BtrieveClient()
        client.open_table('gscat')
        data = client.get_first()
        client.close_file()
    """

    def __init__(self, dll_path: str = None):
        """
        Initialize Btrieve client

        Args:
            dll_path: Path to DLL directory (default: from config)
        """
        self.dll = None
        self.config = get_config()
        self.dll_path = dll_path or self.config.get_dll_path()
        self.pos_block = None
        self.current_table = None
        self.load_dll()

    def load_dll(self):
        """Load Btrieve DLL and setup function signatures"""
        # Try different DLL names (Pervasive PSQL and Btrieve)
        dll_names = [
            "wxqlcall.dll",   # Pervasive PSQL v11 (primary)
            "wbtrv32.dll",    # Btrieve 32-bit
            "w3btrv7.dll",    # Btrieve alternative
            "btrieve.dll"     # Generic Btrieve
        ]

        errors = []
        for dll_name in dll_names:
            dll_file = os.path.join(self.dll_path, dll_name)

            # Check if file exists
            if not os.path.exists(dll_file):
                print(f"⚠️  {dll_name} not found")
                continue

            print(f"🔍 Trying to load: {dll_name}")
            print(f"   Full path: {os.path.abspath(dll_file)}")

            try:
                # Try to load DLL
                self.dll = ctypes.windll.LoadLibrary(dll_file)
                print(f"✅ DLL loaded successfully: {dll_name}")

                # Try to setup API
                self._setup_api()
                print(f"✅ Btrieve API setup complete")
                return

            except OSError as e:
                error_msg = f"OSError loading {dll_name}: {e}"
                print(f"❌ {error_msg}")
                errors.append(error_msg)
                continue
            except Exception as e:
                error_msg = f"Error with {dll_name}: {type(e).__name__}: {e}"
                print(f"❌ {error_msg}")
                errors.append(error_msg)
                continue

        # If we get here, nothing worked
        error_summary = "\n".join(errors) if errors else "No compatible DLL found"
        raise RuntimeError(f"❌ Could not load Btrieve DLL from {self.dll_path}\n\nErrors:\n{error_summary}")

    def _setup_api(self):
        """Define DLL function signatures"""
        # Try different function names
        func_names = ["BTRV", "BtrCall", "BTRVID", "BTRCALL"]

        print(f"🔍 Looking for Btrieve function in DLL...")

        # List all exported functions (if possible)
        try:
            # Try to list exports
            if hasattr(self.dll, '_name'):
                print(f"   DLL name: {self.dll._name}")
        except:
            pass

        for func_name in func_names:
            print(f"   Checking for: {func_name}...", end=" ")
            if hasattr(self.dll, func_name):
                print("✅ FOUND")
                self.btrv_func = getattr(self.dll, func_name)
                self.btrv_func.argtypes = [
                    POINTER(c_ushort),  # operation
                    POINTER(c_char),    # posBlock (128 bytes)
                    POINTER(c_char),    # dataBuffer
                    POINTER(c_ushort),  # dataLength
                    POINTER(c_char),    # keyBuffer
                    c_ubyte,            # keyLength
                    c_byte              # keyNumber
                ]
                self.btrv_func.restype = c_int
                print(f"✅ Using Btrieve function: {func_name}")
                return
            else:
                print("❌ Not found")

        raise RuntimeError(f"❌ Could not find Btrieve function in DLL\nTried: {', '.join(func_names)}")

    def call_btrieve(self, operation: int, data_buffer: bytes = b"",
                     key_buffer: bytes = b"", key_number: int = 0) -> Tuple[int, bytes]:
        """
        Low-level Btrieve call

        Args:
            operation: Btrieve operation code
            data_buffer: Data buffer
            key_buffer: Key buffer
            key_number: Index number

        Returns:
            Tuple of (status_code, result_data)
        """
        # Prepare buffers
        if self.pos_block is None:
            self.pos_block = (c_char * 128)()

        op = c_ushort(operation)
        data_len = c_ushort(len(data_buffer) if data_buffer else 4096)

        if not data_buffer:
            data_buf = (c_char * data_len.value)()
        else:
            data_buf = (c_char * len(data_buffer))(*data_buffer)

        if key_buffer:
            key_buf = (c_char * len(key_buffer))(*key_buffer)
            key_len = c_ubyte(len(key_buffer))
        else:
            key_buf = (c_char * 255)()
            key_len = c_ubyte(0)

        key_num = c_byte(key_number)

        # Call Btrieve
        status = self.btrv_func(
            byref(op),
            self.pos_block,
            data_buf,
            byref(data_len),
            key_buf,
            key_len,
            key_num
        )

        # Return status and data
        result_data = bytes(data_buf[:data_len.value])
        return (status, result_data)

    def open_table(self, table_name: str, owner_name: str = "") -> int:
        """
        Open Btrieve table by name (uses config)

        Args:
            table_name: Table name (gscat, barcode, pab, tsh, tsi, etc.)
            owner_name: Owner name (optional)

        Returns:
            Status code (0 = success)
        """
        # Get table path from config
        table_path = self.config.get_table_path(table_name)
        return self.open_file(table_path)

    def open_file(self, filename: str, owner_name: str = "") -> int:
        """
        Open Btrieve file by path

        Args:
            filename: Full path to .BTR file
            owner_name: Owner name (optional)

        Returns:
            Status code (0 = success)
        """
        # Check if file exists
        if not os.path.exists(filename):
            print(f"❌ File not found: {filename}")
            return BtrStatus.FILE_NOT_FOUND

        # Filename as data buffer
        file_bytes = filename.encode('ascii') + b'\x00'
        status, _ = self.call_btrieve(BtrOp.OPEN, file_bytes)

        if status == BtrStatus.SUCCESS:
            print(f"✅ Opened file: {filename}")
            self.current_table = filename
        else:
            print(f"❌ Failed to open {filename}: status={status}")

        return status

    def close_file(self) -> int:
        """Close currently open file"""
        status, _ = self.call_btrieve(BtrOp.CLOSE)

        if status == BtrStatus.SUCCESS:
            print(f"✅ File closed: {self.current_table}")
            self.pos_block = None
            self.current_table = None
        else:
            print(f"❌ Close failed: status={status}")

        return status

    def get_first(self, key_number: int = 0) -> Tuple[int, bytes]:
        """Get first record"""
        return self.call_btrieve(BtrOp.GET_FIRST, key_number=key_number)

    def get_next(self, key_number: int = 0) -> Tuple[int, bytes]:
        """Get next record"""
        return self.call_btrieve(BtrOp.GET_NEXT, key_number=key_number)

    def get_last(self, key_number: int = 0) -> Tuple[int, bytes]:
        """Get last record"""
        return self.call_btrieve(BtrOp.GET_LAST, key_number=key_number)

    def get_equal(self, key_value: bytes, key_number: int = 0) -> Tuple[int, bytes]:
        """Get record by key value"""
        return self.call_btrieve(BtrOp.GET_EQUAL, key_buffer=key_value, key_number=key_number)

    def insert(self, record_data: bytes) -> int:
        """Insert new record"""
        status, _ = self.call_btrieve(BtrOp.INSERT, record_data)
        return status

    def update(self, record_data: bytes) -> int:
        """Update current record"""
        status, _ = self.call_btrieve(BtrOp.UPDATE, record_data)
        return status

    def delete(self) -> int:
        """Delete current record"""
        status, _ = self.call_btrieve(BtrOp.DELETE)
        return status


# =============================================================================
# USAGE EXAMPLE
# =============================================================================

if __name__ == "__main__":
    # Test Btrieve client
    print("\n🧪 Testing Btrieve Client")
    print("=" * 60)

    try:
        client = BtrieveClient()

        # Test with GSCAT table
        print("\n📊 Testing GSCAT table...")
        status = client.open_table('gscat')

        if status == BtrStatus.SUCCESS:
            # Get first record
            status, data = client.get_first()
            if status == BtrStatus.SUCCESS:
                print(f"✅ First record: {len(data)} bytes")
                print(f"   First 50 bytes: {data[:50]}")
                print(f"   Hex: {data[:50].hex()}")
            else:
                print(f"❌ Failed to read first record: status={status}")

            # Close file
            client.close_file()
        else:
            print(f"❌ Failed to open GSCAT: status={status}")

    except Exception as e:
        print(f"❌ Error: {e}")
        import traceback
        traceback.print_exc()