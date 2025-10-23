# src/btrieve/btrieve_client.py
import ctypes
import os
import struct
from pathlib import Path
from typing import Optional, Tuple


class BtrieveClient:
    """
    Python wrapper pre Pervasive Btrieve API (32-bit)
    Používa w3btrv7.dll alebo wbtrv32.dll
    """

    # Btrieve operation codes
    B_OPEN = 0
    B_CLOSE = 1
    B_INSERT = 2
    B_UPDATE = 3
    B_DELETE = 4
    B_GET_EQUAL = 5
    B_GET_NEXT = 6
    B_GET_PREVIOUS = 7
    B_GET_GREATER = 8
    B_GET_GREATER_OR_EQUAL = 9
    B_GET_LESS = 10
    B_GET_LESS_OR_EQUAL = 11
    B_GET_FIRST = 12
    B_GET_LAST = 13
    B_STEP_NEXT = 24
    B_STEP_PREVIOUS = 35

    # Btrieve status codes
    STATUS_SUCCESS = 0
    STATUS_INVALID_OPERATION = 1
    STATUS_IO_ERROR = 2
    STATUS_FILE_NOT_OPEN = 3
    STATUS_KEY_NOT_FOUND = 4
    STATUS_DUPLICATE_KEY = 5
    STATUS_INVALID_KEY_NUMBER = 6
    STATUS_DIFFERENT_KEY_NUMBER = 7
    STATUS_INVALID_POSITIONING = 8

    def __init__(self, config_path: Optional[str] = None):
        """
        Inicializácia Btrieve klienta

        Args:
            config_path: Cesta ku config súboru (YAML)
        """
        self.dll = None
        self.btrcall = None
        self.database_path = None
        self.config = None

        # Load config if provided
        if config_path:
            from ..utils.config import load_config
            self.config = load_config(config_path)
            if 'nex_genesis' in self.config and 'database' in self.config['nex_genesis']:
                self.database_path = self.config['nex_genesis']['database'].get('stores_path')

        # Inicializuj DLL
        self._load_dll()

    def _load_dll(self) -> None:
        """Načítaj Btrieve DLL a nastav BTRCALL funkciu"""

        # DLL priority list
        dll_names = [
            'w3btrv7.dll',  # Primary - Windows Btrieve API
            'wbtrv32.dll',  # Fallback - 32-bit Btrieve API
        ]

        # Search paths (in priority order)
        search_paths = [
            # 1. Pervasive PSQL installation (v11.30)
            Path(r"C:\Program Files (x86)\Pervasive Software\PSQL\bin"),

            # 2. Old Pervasive installation
            Path(r"C:\PVSW\bin"),

            # 3. Local external-dlls directory
            Path(__file__).parent.parent.parent / 'external-dlls',

            # 4. System directory (Windows\SysWOW64)
            Path(r"C:\Windows\SysWOW64"),
        ]

        # Try each path and DLL combination
        for search_path in search_paths:
            if not search_path.exists():
                continue

            for dll_name in dll_names:
                dll_path = search_path / dll_name

                if not dll_path.exists():
                    continue

                try:
                    # Load DLL
                    self.dll = ctypes.WinDLL(str(dll_path))

                    # Get BTRCALL function
                    try:
                        self.btrcall = self.dll.BTRCALL
                    except AttributeError:
                        # Try lowercase
                        try:
                            self.btrcall = self.dll.btrcall
                        except AttributeError:
                            continue

                    # Configure BTRCALL signature
                    # NOTE: We'll set argtypes dynamically before each call
                    # because READ needs c_uint16 and WRITE needs c_ulong for data_len
                    self.btrcall.restype = ctypes.c_int16  # Status code

                    print(f"✅ Loaded Btrieve DLL: {dll_name} from {search_path}")
                    return

                except Exception as e:
                    # Silent fail, try next DLL
                    continue

        raise RuntimeError(
            "❌ Could not load any Btrieve DLL from any location.\n"
            "Searched paths:\n" +
            "\n".join(f"  - {p}" for p in search_paths if p.exists())
        )

    def _set_argtypes_for_read(self):
        """Set argtypes for READ operations (c_uint16 for data_len)"""
        self.btrcall.argtypes = [
            ctypes.c_uint16,  # operation
            ctypes.POINTER(ctypes.c_char),  # posBlock
            ctypes.POINTER(ctypes.c_char),  # dataBuffer
            ctypes.POINTER(ctypes.c_uint16),  # dataLen - c_uint16 for READ!
            ctypes.POINTER(ctypes.c_char),  # keyBuffer
            ctypes.c_uint8,  # keyLen
            ctypes.c_int8  # keyNum
        ]

    def _set_argtypes_for_write(self):
        """Set argtypes for WRITE operations (c_ulong for data_len)"""
        self.btrcall.argtypes = [
            ctypes.c_uint16,  # operation
            ctypes.POINTER(ctypes.c_char),  # posBlock
            ctypes.POINTER(ctypes.c_char),  # dataBuffer
            ctypes.POINTER(ctypes.c_ulong),  # dataLen - c_ulong for WRITE!
            ctypes.POINTER(ctypes.c_char),  # keyBuffer
            ctypes.c_uint8,  # keyLen
            ctypes.c_int8  # keyNum
        ]

    def open_file(self, filename: str, owner_name: str = "", mode: int = -2) -> Tuple[int, bytes]:
        """
        Otvor Btrieve súbor

        Args:
            filename: Cesta k .dat/.BTR súboru
            owner_name: Owner name (optional)
            mode: Open mode
                  0 = Normal (Read-Write)
                 -1 = Accelerated
                 -2 = Read-only (DEFAULT - safest)
                 -3 = Exclusive

        Returns:
            Tuple[status_code, position_block]
        """
        # Position block (128 bytes)
        pos_block = ctypes.create_string_buffer(128)

        # Data buffer (filename + null terminator)
        filename_bytes = filename.encode('ascii') + b'\x00'
        data_buffer = ctypes.create_string_buffer(filename_bytes)
        data_len = ctypes.c_uint16(len(filename_bytes))  # Use c_uint16 for OPEN

        # Key buffer (owner name or empty)
        if owner_name:
            key_buffer = ctypes.create_string_buffer(owner_name.encode('ascii') + b'\x00')
        else:
            key_buffer = ctypes.create_string_buffer(1)

        # Set argtypes for READ operation
        self._set_argtypes_for_read()

        # Call BTRCALL
        # NOTE: keyNum is used as open mode for B_OPEN operation!
        status = self.btrcall(
            self.B_OPEN,
            pos_block,
            data_buffer,
            ctypes.byref(data_len),
            key_buffer,
            0,  # keyLen (not used for OPEN)
            mode  # keyNum = open mode (-2 = read-only, 0 = read-write)
        )

        return status, pos_block.raw

    def close_file(self, pos_block: bytes) -> int:
        """
        Zavri Btrieve súbor

        Args:
            pos_block: Position block z open_file()

        Returns:
            status_code
        """
        pos_block_buf = ctypes.create_string_buffer(pos_block)
        data_buffer = ctypes.create_string_buffer(1)
        data_len = ctypes.c_uint16(0)  # Use c_uint16 for CLOSE
        key_buffer = ctypes.create_string_buffer(1)

        # Set argtypes for READ operation
        self._set_argtypes_for_read()

        status = self.btrcall(
            self.B_CLOSE,
            pos_block_buf,
            data_buffer,
            ctypes.byref(data_len),
            key_buffer,
            0,
            0
        )

        return status

    def get_first(self, pos_block: bytes, key_num: int = 0) -> Tuple[int, bytes]:
        """
        Načítaj prvý záznam

        Args:
            pos_block: Position block
            key_num: Index number (default: 0)

        Returns:
            Tuple[status_code, data]
        """
        pos_block_buf = ctypes.create_string_buffer(pos_block)
        data_buffer = ctypes.create_string_buffer(4096)  # Max record size
        data_len = ctypes.c_uint16(4096)  # Use c_uint16 for READ operations
        key_buffer = ctypes.create_string_buffer(255)

        # Set argtypes for READ operation
        self._set_argtypes_for_read()

        status = self.btrcall(
            self.B_GET_FIRST,
            pos_block_buf,
            data_buffer,
            ctypes.byref(data_len),
            key_buffer,
            0,
            key_num
        )

        if status == self.STATUS_SUCCESS:
            return status, data_buffer.raw[:data_len.value]
        else:
            return status, b''

    def get_next(self, pos_block: bytes) -> Tuple[int, bytes]:
        """
        Načítaj ďalší záznam

        Args:
            pos_block: Position block

        Returns:
            Tuple[status_code, data]
        """
        pos_block_buf = ctypes.create_string_buffer(pos_block)
        data_buffer = ctypes.create_string_buffer(4096)
        data_len = ctypes.c_uint16(4096)  # Use c_uint16 for READ operations
        key_buffer = ctypes.create_string_buffer(255)

        # Set argtypes for READ operation
        self._set_argtypes_for_read()

        status = self.btrcall(
            self.B_GET_NEXT,
            pos_block_buf,
            data_buffer,
            ctypes.byref(data_len),
            key_buffer,
            0,
            0
        )

        if status == self.STATUS_SUCCESS:
            return status, data_buffer.raw[:data_len.value]
        else:
            return status, b''

    def insert(self, pos_block: bytes, data: bytes) -> int:
        """
        Vlož nový záznam

        Args:
            pos_block: Position block
            data: Data to insert

        Returns:
            status_code
        """
        pos_block_buf = ctypes.create_string_buffer(pos_block)
        data_buffer = ctypes.create_string_buffer(data)
        data_len = ctypes.c_ulong(len(data))
        key_buffer = ctypes.create_string_buffer(255)

        # Set argtypes for WRITE operation
        self._set_argtypes_for_write()

        status = self.btrcall(
            self.B_INSERT,
            pos_block_buf,
            data_buffer,
            ctypes.byref(data_len),
            key_buffer,
            0,
            0
        )

        return status

    def update(self, pos_block: bytes, data: bytes) -> int:
        """
        Aktualizuj aktuálny záznam

        Args:
            pos_block: Position block
            data: Updated data

        Returns:
            status_code
        """
        pos_block_buf = ctypes.create_string_buffer(pos_block)
        data_buffer = ctypes.create_string_buffer(data)
        data_len = ctypes.c_ulong(len(data))
        key_buffer = ctypes.create_string_buffer(255)

        # Set argtypes for WRITE operation
        self._set_argtypes_for_write()

        status = self.btrcall(
            self.B_UPDATE,
            pos_block_buf,
            data_buffer,
            ctypes.byref(data_len),
            key_buffer,
            0,
            0
        )

        return status

    def delete(self, pos_block: bytes) -> int:
        """
        Vymaž aktuálny záznam

        Args:
            pos_block: Position block

        Returns:
            status_code
        """
        pos_block_buf = ctypes.create_string_buffer(pos_block)
        data_buffer = ctypes.create_string_buffer(1)
        data_len = ctypes.c_ulong(0)
        key_buffer = ctypes.create_string_buffer(255)

        # Set argtypes for WRITE operation
        self._set_argtypes_for_write()

        status = self.btrcall(
            self.B_DELETE,
            pos_block_buf,
            data_buffer,
            ctypes.byref(data_len),
            key_buffer,
            0,
            0
        )

        return status

    def get_status_message(self, status_code: int) -> str:
        """
        Konvertuj status code na human-readable správu

        Args:
            status_code: Btrieve status code

        Returns:
            Status message
        """
        messages = {
            0: "SUCCESS",
            1: "INVALID_OPERATION",
            2: "IO_ERROR",
            3: "FILE_NOT_OPEN",
            4: "KEY_NOT_FOUND",
            5: "DUPLICATE_KEY",
            6: "INVALID_KEY_NUMBER",
            7: "DIFFERENT_KEY_NUMBER",
            8: "INVALID_POSITIONING",
        }
        return messages.get(status_code, f"UNKNOWN_ERROR_{status_code}")


# Convenience functions
def open_btrieve_file(filename: str, config_path: Optional[str] = None) -> Tuple[BtrieveClient, bytes]:
    """
    Helper funkcia na otvorenie Btrieve súboru

    Args:
        filename: Cesta k .dat súboru
        config_path: Cesta ku config súboru

    Returns:
        Tuple[client, position_block]
    """
    client = BtrieveClient(config_path)
    status, pos_block = client.open_file(filename)

    if status != BtrieveClient.STATUS_SUCCESS:
        raise RuntimeError(
            f"Failed to open {filename}: {client.get_status_message(status)}"
        )

    return client, pos_block