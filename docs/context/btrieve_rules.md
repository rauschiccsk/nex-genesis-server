# NEX Genesis Server - Btrieve Access Rules

**CRITICAL RULES FOR BTRIEVE API ACCESS**

Version: 1.0.0  
Last Updated: 2025-10-23

**WARNING: Read this entire document before working with Btrieve operations!**

---

## CRITICAL: BTRCALL Signature

Based on analysis of Delphi btrapi32.pas and working implementation.

### Correct Signature (v0.2.3 - WORKING)

```python
btrcall.argtypes = [
    ctypes.c_uint16,                 # operation (WORD)
    ctypes.POINTER(ctypes.c_char),   # posBlock
    ctypes.POINTER(ctypes.c_char),   # dataBuffer
    ctypes.POINTER(ctypes.c_uint32), # dataLen (4 bytes!) - CRITICAL
    ctypes.POINTER(ctypes.c_char),   # keyBuffer
    ctypes.c_uint8,                  # keyLen (BYTE)
    ctypes.c_uint8                   # keyNum (BYTE, unsigned!) - CRITICAL
]

btrcall.restype = ctypes.c_int16     # Return: status code
```

### What Changed from Earlier Versions

**CRITICAL FIX 1: dataLen Type**
```python
# WRONG (v0.2.1-v0.2.2):
ctypes.POINTER(ctypes.c_uint16)  # 2 bytes - FAILS!

# CORRECT (v0.2.3+):
ctypes.POINTER(ctypes.c_uint32)  # 4 bytes - WORKS!
```

**Reason:** Delphi `longInt` = 4 bytes (int32), not 2 bytes  
**Impact:** Without this fix, file opening fails with Error 11

**CRITICAL FIX 2: keyNum Type**
```python
# WRONG:
ctypes.c_int8  # Signed byte

# CORRECT:
ctypes.c_uint8  # Unsigned byte (BYTE type)
```

**Reason:** Btrieve key numbers are unsigned  
**Impact:** Negative values cause undefined behavior

---

## CRITICAL: Open File Operation

### Correct Pattern (WORKING)

```python
def open_file(self, filename: str, mode: int = -2) -> bytes:
    """Open Btrieve file.
    
    Args:
        filename: Full path to .BTR file
        mode: -1 (normal), -2 (read-only), -3 (accelerated)
    
    Returns:
        Position block (128 bytes)
    """
    # 1. Create empty data buffer (CRITICAL!)
    data_buffer = ctypes.create_string_buffer(256)
    data_len = ctypes.c_uint32(0)  # MUST be 0 for open!
    
    # 2. Put filename in key buffer (CRITICAL!)
    filename_bytes = filename.encode('ascii') + b'\x00'
    key_buffer = ctypes.create_string_buffer(filename_bytes)
    key_len = 255  # Always 255 for open
    
    # 3. Create position block
    pos_block = ctypes.create_string_buffer(128)
    
    # 4. Call BTRCALL with operation 0 (OPEN)
    status = self.btrcall(
        0,                              # B_OPEN
        pos_block,
        data_buffer,                    # Empty!
        ctypes.byref(data_len),        # Zero!
        key_buffer,                     # Filename here!
        key_len,
        abs(mode)
    )
    
    if status != 0:
        raise BtrieveError(f"Open failed: status {status}")
    
    return pos_block.raw
```

### Key Points for Open Operation

**1. Data Buffer MUST be EMPTY**
```python
# CORRECT:
data_buffer = ctypes.create_string_buffer(256)
data_len = ctypes.c_uint32(0)  # Zero length

# WRONG:
data_buffer = ctypes.create_string_buffer(filename_bytes)
data_len = ctypes.c_uint32(len(filename_bytes))
```

**2. Filename goes in KEY BUFFER**
```python
# CORRECT:
key_buffer = ctypes.create_string_buffer(filename.encode('ascii') + b'\x00')

# WRONG:
data_buffer = ctypes.create_string_buffer(filename.encode('ascii'))
```

**3. Key Length is always 255**
```python
key_len = 255  # Fixed value for open
```

**4. Key Number (last parameter) is the open mode**
```python
# Mode values:
-1  # Normal mode
-2  # Read-only mode (recommended for queries)
-3  # Accelerated mode
```

---

## Btrieve Operations

### Operation Codes

```python
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
B_CREATE = 14
B_STAT = 15
B_EXTEND = 16
B_SET_DIR = 17
B_GET_DIR = 18
B_BEGIN_TRANSACTION = 19
B_END_TRANSACTION = 20
B_ABORT_TRANSACTION = 21
B_GET_POSITION = 22
B_GET_DIRECT = 23
B_STEP_NEXT = 24
B_STOP = 25
B_VERSION = 26
```

### Common Operations

**Get First Record:**
```python
def get_first(self, pos_block: bytes, key_num: int = 0) -> tuple[int, bytes]:
    """Get first record using specified key.
    
    Args:
        pos_block: Position block from open_file
        key_num: Key/index number (0 = primary key)
        
    Returns:
        (status, record_data)
    """
    data_buffer = ctypes.create_string_buffer(2048)
    data_len = ctypes.c_uint32(2048)
    key_buffer = ctypes.create_string_buffer(255)
    pos_block_buf = ctypes.create_string_buffer(pos_block)
    
    status = self.btrcall(
        12,  # B_GET_FIRST
        pos_block_buf,
        data_buffer,
        ctypes.byref(data_len),
        key_buffer,
        255,
        key_num
    )
    
    return status, data_buffer.raw[:data_len.value] if status == 0 else b''
```

**Get Next Record:**
```python
def get_next(self, pos_block: bytes) -> tuple[int, bytes]:
    """Get next record in current sequence."""
    data_buffer = ctypes.create_string_buffer(2048)
    data_len = ctypes.c_uint32(2048)
    key_buffer = ctypes.create_string_buffer(255)
    pos_block_buf = ctypes.create_string_buffer(pos_block)
    
    status = self.btrcall(
        6,  # B_GET_NEXT
        pos_block_buf,
        data_buffer,
        ctypes.byref(data_len),
        key_buffer,
        255,
        0
    )
    
    return status, data_buffer.raw[:data_len.value] if status == 0 else b''
```

**Get Equal (Search):**
```python
def get_equal(self, pos_block: bytes, key_value: bytes, key_num: int = 0) -> tuple[int, bytes]:
    """Search for record with specific key value.
    
    Args:
        pos_block: Position block
        key_value: Key value to search (packed binary)
        key_num: Key number to use
        
    Returns:
        (status, record_data)
    """
    data_buffer = ctypes.create_string_buffer(2048)
    data_len = ctypes.c_uint32(2048)
    key_buffer = ctypes.create_string_buffer(key_value)
    pos_block_buf = ctypes.create_string_buffer(pos_block)
    
    status = self.btrcall(
        5,  # B_GET_EQUAL
        pos_block_buf,
        data_buffer,
        ctypes.byref(data_len),
        key_buffer,
        len(key_value),
        key_num
    )
    
    return status, data_buffer.raw[:data_len.value] if status == 0 else b''
```

**Close File:**
```python
def close_file(self, pos_block: bytes) -> int:
    """Close Btrieve file.
    
    Always call this, even on errors!
    Use in finally block.
    """
    data_buffer = ctypes.create_string_buffer(256)
    data_len = ctypes.c_uint32(0)
    key_buffer = ctypes.create_string_buffer(255)
    pos_block_buf = ctypes.create_string_buffer(pos_block)
    
    status = self.btrcall(
        1,  # B_CLOSE
        pos_block_buf,
        data_buffer,
        ctypes.byref(data_len),
        key_buffer,
        255,
        0
    )
    
    return status
```

---

## Status Codes

### Success
```python
0  # Operation successful
```

### Common Errors
```python
2   # I/O error
3   # File not open
4   # Key value not found
5   # Duplicate key
6   # Invalid key number
8   # End of file
9   # Modifiable key value error
11  # File name invalid
12  # File not found
18  # Disk full
20  # Record manager inactive
46  # Access denied (file locked)
84  # Record in use (locked)
```

### Error Handling

```python
class BtrieveError(Exception):
    """Btrieve operation error."""
    
    def __init__(self, message: str, status_code: int = None):
        self.status_code = status_code
        super().__init__(message)

def check_status(status: int, operation: str) -> None:
    """Check Btrieve status code and raise if error."""
    if status == 0:
        return
    
    error_messages = {
        2: "I/O error",
        3: "File not open",
        4: "Key value not found",
        8: "End of file",
        11: "File name invalid",
        12: "File not found",
        46: "Access denied",
        84: "Record locked"
    }
    
    message = error_messages.get(status, f"Unknown error {status}")
    raise BtrieveError(f"{operation} failed: {message}", status)
```

---

## Best Practices

### 1. Always Use BtrieveClient Wrapper

**DO:**
```python
from src.btrieve.btrieve_client import BtrieveClient

client = BtrieveClient()
pos_block = client.open_file(file_path)
try:
    status, data = client.get_first(pos_block)
    # Process data
finally:
    client.close_file(pos_block)
```

**DON'T:**
```python
# Don't access Btrieve DLL directly!
btrcall = ctypes.CDLL('w3btrv7.dll').BTRCALL
# This will fail without proper setup
```

### 2. Always Close Files

**Use try-finally:**
```python
pos_block = client.open_file(file_path)
try:
    # All operations here
    data = read_records(pos_block)
    return data
finally:
    # Always close, even on error
    client.close_file(pos_block)
```

### 3. Validate Record Layout Before Write

```python
def validate_record(record: dict, layout: RecordLayout) -> None:
    """Validate record before writing to Btrieve."""
    for field in layout.fields:
        if field.required and field.name not in record:
            raise ValueError(f"Missing required field: {field.name}")
        
        if field.name in record:
            value = record[field.name]
            if field.max_length and len(str(value)) > field.max_length:
                raise ValueError(f"Field {field.name} exceeds max length")
```

### 4. Use Indexes for Search

```python
# GOOD: Use index for search
key_value = struct.pack('i', gs_code)  # Pack as integer
status, data = client.get_equal(pos_block, key_value, key_num=0)

# BAD: Sequential search
status, data = client.get_first(pos_block)
while status == 0:
    if parse_gs_code(data) == gs_code:
        break
    status, data = client.get_next(pos_block)
```

### 5. Handle Encoding Properly

```python
# Writing strings
name = "Produkt XYZ"
name_encoded = name.encode('cp1250').ljust(50, b'\x00')  # Fixed length

# Reading strings
name_bytes = data[offset:offset+50]
name = name_bytes.rstrip(b'\x00').decode('cp1250')
```

### 6. Log All Database Operations

```python
import logging

logger = logging.getLogger(__name__)

def open_file(self, filename: str) -> bytes:
    logger.debug(f"Opening file: {filename}")
    try:
        pos_block = self._do_open(filename)
        logger.info(f"File opened successfully: {filename}")
        return pos_block
    except BtrieveError as e:
        logger.error(f"Failed to open {filename}: {e}")
        raise
```

---

## Common Pitfalls

### Pitfall 1: Wrong dataLen Type

**Problem:**
```python
data_len = ctypes.c_uint16(0)  # 2 bytes - WRONG!
```

**Solution:**
```python
data_len = ctypes.c_uint32(0)  # 4 bytes - CORRECT!
```

### Pitfall 2: Filename in Wrong Buffer

**Problem:**
```python
data_buffer = ctypes.create_string_buffer(filename.encode())  # WRONG!
```

**Solution:**
```python
key_buffer = ctypes.create_string_buffer(filename.encode())  # CORRECT!
```

### Pitfall 3: Not Closing Files

**Problem:**
```python
pos_block = client.open_file(file_path)
data = client.read_data(pos_block)
return data  # File never closed!
```

**Solution:**
```python
pos_block = client.open_file(file_path)
try:
    data = client.read_data(pos_block)
    return data
finally:
    client.close_file(pos_block)  # Always close!
```

### Pitfall 4: Buffer Too Small

**Problem:**
```python
data_buffer = ctypes.create_string_buffer(100)  # Too small!
```

**Solution:**
```python
data_buffer = ctypes.create_string_buffer(2048)  # Large enough
```

### Pitfall 5: Not Handling End of File

**Problem:**
```python
while True:
    status, data = client.get_next(pos_block)
    process(data)  # Infinite loop if EOF not checked!
```

**Solution:**
```python
while True:
    status, data = client.get_next(pos_block)
    if status == 8:  # End of file
        break
    if status != 0:
        raise BtrieveError(f"Read failed: {status}")
    process(data)
```

---

## Testing Btrieve Operations

### Test Pattern

```python
def test_gscat_read():
    """Test reading from GSCAT table."""
    # Arrange
    client = BtrieveClient()
    config = get_config()
    file_path = config.get_table_path('gscat')
    
    # Act
    pos_block = client.open_file(file_path, mode=-2)
    try:
        status, data = client.get_first(pos_block, key_num=0)
        
        # Assert
        assert status == 0, f"Get first failed: {status}"
        assert len(data) > 0, "No data returned"
        
        # Decode and verify
        gs_code = struct.unpack('i', data[0:4])[0]
        assert gs_code > 0, "Invalid GsCode"
        
    finally:
        client.close_file(pos_block)
```

---

## DLL Loading

### Multi-Path Search

BtrieveClient tries multiple locations:

```python
dll_paths = [
    "C:\\Program Files (x86)\\Pervasive Software\\PSQL\\bin",  # Primary
    "C:\\PVSW\\bin",                                           # Legacy
    "external-dlls/",                                          # Local
    "C:\\Windows\\SysWOW64"                                    # System
]
```

### Current Working DLL

**File:** w3btrv7.dll  
**Size:** 32,072 bytes  
**Version:** 2013  
**Location:** `C:\Program Files (x86)\Pervasive Software\PSQL\bin`

---

## Summary of Critical Rules

1. **dataLen is 4 bytes** (c_uint32, not c_uint16)
2. **keyNum is unsigned** (c_uint8, not c_int8)
3. **Filename goes in key_buffer** (not data_buffer)
4. **data_buffer is empty for open** (dataLen = 0)
5. **keyLen is 255 for open** (fixed value)
6. **Always close files** (use try-finally)
7. **Use BtrieveClient wrapper** (don't access DLL directly)
8. **Validate record layouts** (before write)
9. **Use indexes for search** (don't scan sequentially)
10. **Handle encoding properly** (cp1250 for Czech/Slovak)
11. **Log all operations** (for debugging)
12. **Check status codes** (handle errors gracefully)

---

**REMEMBER: These rules are based on working implementation (v0.2.3)**  
**Any deviation may cause errors!**

**For current status:** See `docs/sessions/YYYY-MM-DD_session.md` (latest session)  
**For implementation:** See `src/btrieve/btrieve_client.py`