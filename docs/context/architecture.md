# NEX Genesis Server - Architecture

**Technical Architecture and Components**

Version: 1.0.0  
Last Updated: 2025-10-23

---

## Tech Stack

```yaml
Language: Python 3.8+ (32-bit required!)
Database: Pervasive PSQL v11 (Btrieve)
DB Access: Direct Btrieve API (ctypes)
HTTP Server: FastAPI / Flask
XML Parser: lxml / xml.etree
Configuration: YAML
Testing: pytest
IDE: PyCharm
Git: PyCharm integrated Git
SDK: Pervasive PSQL v11
```

---

## System Architecture

```
┌─────────────────────────────────────┐
│  supplier_invoice_loader            │
│  (Python FastAPI)                   │
│  Generuje ISDOC XML                 │
└──────────────┬──────────────────────┘
               │
               │ POST /api/invoice/import
               │ Content: ISDOC XML
               ▼
┌─────────────────────────────────────┐
│  NEX Genesis Server                 │
│  (Python Services)                  │
│                                     │
│  ├─ XML Parser                      │
│  ├─ Product Validator               │
│  ├─ Product Service (GSCAT)         │
│  ├─ Barcode Service (BARCODE)       │
│  ├─ Delivery Note Service (TSH/TSI) │
│  └─ Btrieve Client Wrapper          │
└──────────────┬──────────────────────┘
               │
               │ Btrieve API (w3btrv7.dll)
               │ Direct file access
               ▼
┌─────────────────────────────────────┐
│  NEX Genesis Database               │
│  (Pervasive Btrieve)                │
│                                     │
│  ├─ GSCAT.BTR  (Produkty)           │
│  ├─ BARCODE.BTR (Čiarové kódy)      │
│  ├─ MGLST.BTR  (Skupiny)            │
│  ├─ PAB00000.BTR (Partneri)         │
│  ├─ TSHA-001.BTR (Dodacie listy hdr)│
│  └─ TSIA-001.BTR (Dodacie listy itm)│
└─────────────────────────────────────┘
```

---

## Component Structure

### Core Components

**1. Btrieve Client (DONE)**
- Direct DLL access via ctypes
- File operations (open, read, write, close)
- Error handling and status codes
- Position block management
- Multi-path DLL search

**2. Services Layer (PLANNED)**
- Product service (GSCAT operations)
- Barcode service (BARCODE operations)
- Delivery note service (TSH/TSI operations)
- Supplier service (PAB operations)

**3. Parsers Layer (PLANNED)**
- ISDOC XML parser
- XML validation
- Data extraction
- Field mapping

**4. API Layer (PLANNED)**
- FastAPI HTTP server
- REST endpoints
- Request/response models
- Authentication (future)

---

## Services Architecture

```
nex-genesis-server/
│
├─ services/
│  ├─ product_service.py
│  │  ├─ check_product_exists()
│  │  ├─ create_product()
│  │  └─ update_product()
│  │
│  ├─ barcode_service.py
│  │  ├─ check_barcode_exists()
│  │  ├─ add_barcode()
│  │  └─ find_product_by_barcode()
│  │
│  ├─ delivery_note_service.py
│  │  ├─ create_delivery_note()
│  │  ├─ add_delivery_item()
│  │  └─ finalize_delivery()
│  │
│  └─ supplier_service.py
│     ├─ get_supplier_by_ico()
│     └─ validate_supplier()
│
├─ btrieve/
│  ├─ btrieve_client.py (Wrapper) - DONE
│  ├─ record_layouts.py (Python structs)
│  └─ operations.py (CRUD)
│
├─ parsers/
│  ├─ isdoc_parser.py
│  └─ xml_validator.py
│
└─ api/
   ├─ main.py (FastAPI app)
   └─ endpoints.py
```

---

## Dependencies

### Core Dependencies
```python
# Btrieve access
ctypes           # Built-in, direct DLL calls

# Configuration
PyYAML >= 6.0    # YAML configuration files

# Testing
pytest >= 7.0    # Unit and integration testing
pytest-cov       # Code coverage

# Code quality
black            # Code formatter
flake8           # Linter
mypy             # Type checker
```

### API Layer Dependencies (Future)
```python
# HTTP server
fastapi >= 0.100.0
uvicorn[standard] >= 0.23.0
pydantic >= 2.0

# XML parsing
lxml >= 4.9.0

# Validation
pydantic >= 2.0
email-validator

# Logging
python-json-logger
```

### Development Dependencies
```python
# IDE support
pylint
autopep8

# Documentation
sphinx
sphinx-rtd-theme
```

---

## API Endpoints (Planned)

### 1. Import Invoice (Main Function)
```http
POST /api/invoice/import
Content-Type: application/xml

<ISDOC XML content>

Response 200 OK:
{
  "success": true,
  "deliveryNoteNumber": "DL-2025-0001",
  "productsAdded": 3,
  "itemsCreated": 5,
  "message": "Dodací list vytvorený úspešne"
}

Response 400 Bad Request:
{
  "success": false,
  "error": "Invalid XML format",
  "details": "..."
}

Response 500 Internal Server Error:
{
  "success": false,
  "error": "Database error",
  "details": "..."
}
```

### 2. Health Check
```http
GET /api/health

Response 200 OK:
{
  "status": "ok",
  "database": "connected",
  "version": "0.3.0",
  "btrieve_dll": "w3btrv7.dll",
  "tables_accessible": 6
}
```

### 3. Product Check (Helper)
```http
POST /api/product/check
Content-Type: application/json

{
  "code": "PROD-001"
}

Response 200 OK:
{
  "exists": true,
  "gsCode": 12345,
  "name": "Produkt XYZ",
  "barcode": "1234567890123"
}
```

### 4. Supplier Check (Helper)
```http
POST /api/supplier/check
Content-Type: application/json

{
  "ico": "12345678"
}

Response 200 OK:
{
  "exists": true,
  "pabCode": 5,
  "name": "ICC s.r.o.",
  "verified": true
}
```

---

## Data Flow

### Invoice Import Flow

```
1. Receive ISDOC XML
   │
   ├─> Parse XML
   │   └─> Validate structure
   │
   ├─> Extract supplier info
   │   ├─> Check supplier exists (PAB)
   │   └─> Validate ICO
   │
   ├─> For each invoice line:
   │   │
   │   ├─> Extract product info
   │   │   ├─> Check product exists (GSCAT)
   │   │   └─> If not: Create product
   │   │
   │   ├─> Check barcode (BARCODE)
   │   │   └─> If not: Add barcode
   │   │
   │   └─> Prepare delivery item
   │
   ├─> Create delivery note header (TSH)
   │   ├─> Generate document number
   │   ├─> Set supplier (PAB reference)
   │   └─> Set date and currency
   │
   ├─> Add delivery items (TSI)
   │   ├─> For each line: Insert record
   │   └─> Link to GSCAT products
   │
   └─> Return success response
       └─> Include delivery note number
```

---

## Error Handling Strategy

### Error Categories

**1. Validation Errors (400)**
- Invalid XML format
- Missing required fields
- Invalid data types
- Business rule violations

**2. Database Errors (500)**
- Btrieve operation failed
- File access denied
- Record lock timeout
- Disk full

**3. Integration Errors (502)**
- External service unavailable
- Network timeout
- Invalid response format

### Error Response Format
```json
{
  "success": false,
  "error_code": "ERR_BTRIEVE_001",
  "error_message": "Failed to open GSCAT.BTR",
  "details": {
    "btrieve_status": 11,
    "operation": "OPEN",
    "file": "C:\\NEX\\YEARACT\\STORES\\GSCAT.BTR"
  },
  "timestamp": "2025-10-23T10:30:45Z",
  "request_id": "req_abc123"
}
```

---

## Performance Considerations

### Optimization Strategies

**1. Connection Pooling**
- Reuse Btrieve file handles
- Keep frequently accessed files open
- Close inactive files after timeout

**2. Caching**
- Cache product lookups
- Cache supplier information
- TTL-based invalidation

**3. Batch Operations**
- Group multiple inserts
- Minimize file open/close cycles
- Use transactions where possible

**4. Async Processing**
- Queue large imports
- Background processing for heavy operations
- Return immediate response with job ID

---

## Security Considerations

### Current (MVP)
- File-level access control (OS)
- No authentication (local network only)
- Basic input validation

### Future (Production)
- API key authentication
- JWT tokens
- Rate limiting
- Request logging
- Audit trail
- Encrypted configuration

---

## Monitoring and Logging

### Logging Strategy

**Log Levels:**
- **DEBUG:** Detailed Btrieve operations
- **INFO:** Successful operations, major steps
- **WARNING:** Recoverable errors, performance issues
- **ERROR:** Failed operations, exceptions
- **CRITICAL:** System failures, data corruption

**Log Format:**
```json
{
  "timestamp": "2025-10-23T10:30:45Z",
  "level": "INFO",
  "component": "product_service",
  "operation": "create_product",
  "message": "Product created successfully",
  "data": {
    "gsCode": 12345,
    "name": "New Product"
  }
}
```

### Metrics (Future)
- Request rate
- Response time
- Error rate
- Database operation duration
- Queue depth

---

## Testing Strategy

### Test Levels

**1. Unit Tests**
- Individual functions
- Mock Btrieve calls
- Test data validation
- Error handling

**2. Integration Tests**
- Real database operations
- Full workflow tests
- ISDOC parsing
- End-to-end scenarios

**3. Performance Tests**
- Load testing
- Stress testing
- Concurrent operations
- Resource usage

---

**For current status:** See `docs/sessions/YYYY-MM-DD_session.md` (latest session)