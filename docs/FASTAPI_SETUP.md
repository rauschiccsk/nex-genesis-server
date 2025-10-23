# NEX Genesis Btrieve Bridge API - Setup Guide

## 📋 Obsah

1. [Inštalácia](#inštalácia)
2. [Spustenie servera](#spustenie-servera)
3. [API Endpoints](#api-endpoints)
4. [Testing](#testing)
5. [Integration](#integration)
6. [Deployment](#deployment)

---

## 🔧 Inštalácia

### 1. Aktivuj Python 32-bit virtual environment

```powershell
cd C:\Development\nex-genesis-server
.\venv32\Scripts\activate
```

### 2. Nainštaluj FastAPI dependencies

```powershell
pip install -r requirements.txt
```

**Nové dependencies:**
- `fastapi` - Web framework
- `uvicorn` - ASGI server
- `python-multipart` - File upload support
- `pydantic` - Data validation
- `httpx` - HTTP client (pre testing)

### 3. Overenie inštalácie

```powershell
python -c "import fastapi; print(f'FastAPI: {fastapi.__version__}')"
python -c "import uvicorn; print(f'Uvicorn: {uvicorn.__version__}')"
```

---

## 🚀 Spustenie servera

### Development Mode (auto-reload)

```powershell
python run_api.py --reload
```

**Output:**
```
============================================================
🚀 NEX Genesis Btrieve Bridge API
============================================================
📡 Starting server on http://127.0.0.1:8001
📚 API Docs: http://127.0.0.1:8001/docs
📊 ReDoc: http://127.0.0.1:8001/redoc
💚 Health: http://127.0.0.1:8001/health
🔧 Mode: Development (auto-reload)
============================================================

INFO:     Uvicorn running on http://127.0.0.1:8001 (Press CTRL+C to quit)
INFO:     Started reloader process [12345] using WatchFiles
INFO:     Started server process [67890]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
```

### Production Mode

```powershell
python run_api.py
```

### Custom Port

```powershell
python run_api.py --port 8002
```

---

## 📡 API Endpoints

### Health Check

**GET** `/health`

```bash
curl http://localhost:8001/health
```

**Response:**
```json
{
  "status": "healthy",
  "service": "nex-genesis-btrieve-bridge",
  "version": "1.0.0"
}
```

---

### Invoice Import

**POST** `/api/v1/invoices/import`

Import ISDOC faktúry do NEX Genesis.

**Request Body:**
```json
{
  "invoice_number": "2025001234",
  "invoice_date": "2025-10-23",
  "due_date": "2025-11-23",
  "tax_point_date": "2025-10-23",
  "supplier": {
    "name": "L&Š PLUS s.r.o.",
    "ico": "36531928",
    "dic": "2021891916",
    "ic_dph": "SK2021891916",
    "street": "Továrenská 5",
    "city": "Bratislava",
    "zip": "82109",
    "country": "SK"
  },
  "customer": {
    "name": "MAGERSTAV spol. s r.o.",
    "ico": "31411711",
    "dic": "2020367151",
    "ic_dph": "SK2020367151",
    "street": "Priemyselná 1",
    "city": "Komárno",
    "zip": "94501",
    "country": "SK"
  },
  "items": [
    {
      "line_number": 1,
      "item_code": "12345",
      "item_name": "Cement Portland 42,5 R",
      "quantity": 10.0,
      "unit": "KS",
      "unit_price": 25.50,
      "vat_rate": 20.0,
      "line_total": 255.0,
      "ean": "8590000123456"
    }
  ],
  "total_amount": 306.0,
  "total_vat": 51.0,
  "total_without_vat": 255.0,
  "variable_symbol": "2025001234",
  "note": "Testovacia faktúra"
}
```

**Response (200 OK):**
```json
{
  "status": "success",
  "message": "Invoice imported successfully",
  "supplier_created": false,
  "customer_created": false,
  "products_created": 0,
  "products_updated": 1,
  "barcodes_created": 0,
  "delivery_created": true,
  "supplier_ico": "36531928",
  "customer_ico": "31411711",
  "product_codes": ["12345"],
  "delivery_number": "DL2025001234",
  "errors": [],
  "warnings": ["Product 12345 already exists, updated price"]
}
```

**Response (400 Bad Request) - Validation Error:**
```json
{
  "detail": {
    "message": "Validation failed",
    "errors": [
      {
        "field": "supplier.ico",
        "message": "Supplier IČO is required",
        "value": null
      }
    ]
  }
}
```

---

## 🧪 Testing

### 1. Swagger UI (Interactive Docs)

Otvor v prehliadači:
```
http://localhost:8001/docs
```

**Features:**
- ✅ Try out endpoints interactively
- ✅ See request/response schemas
- ✅ Test validation
- ✅ Download OpenAPI spec

### 2. ReDoc (Alternative Docs)

```
http://localhost:8001/redoc
```

### 3. cURL Testing

**Health Check:**
```bash
curl http://localhost:8001/health
```

**Invoice Import:**
```bash
curl -X POST http://localhost:8001/api/v1/invoices/import \
  -H "Content-Type: application/json" \
  -d @test_invoice.json
```

### 4. Python Testing

```python
import requests

# Health check
response = requests.get("http://localhost:8001/health")
print(response.json())

# Invoice import
invoice_data = {
    "invoice_number": "2025001234",
    "invoice_date": "2025-10-23",
    # ... rest of data
}

response = requests.post(
    "http://localhost:8001/api/v1/invoices/import",
    json=invoice_data
)
print(response.status_code)
print(response.json())
```

---

## 🔗 Integration

### Supplier Invoice Loader Integration

V `supplier_invoice_loader` projekte:

```python
import requests

# Po spracovaní PDF → ISDOC XML
isdoc_data = parse_pdf_to_isdoc(pdf_file)

# Zavolaj Btrieve Bridge API
try:
    response = requests.post(
        "http://localhost:8001/api/v1/invoices/import",
        json=isdoc_data,
        timeout=30
    )
    
    if response.status_code == 200:
        result = response.json()
        print(f"✅ Invoice imported: {result['message']}")
        print(f"   Products: {result['products_created']} created, {result['products_updated']} updated")
        print(f"   Supplier: {result['supplier_ico']}")
        
        if result['warnings']:
            print(f"⚠️  Warnings: {len(result['warnings'])}")
            for warning in result['warnings']:
                print(f"   - {warning}")
    else:
        error = response.json()
        print(f"❌ Import failed: {error['detail']['message']}")
        
except requests.exceptions.Timeout:
    print("❌ Request timeout - Btrieve Bridge not responding")
except requests.exceptions.ConnectionError:
    print("❌ Connection error - Is Btrieve Bridge running?")
except Exception as e:
    print(f"❌ Unexpected error: {e}")
```

---

## 🚀 Deployment

### Windows Service Setup

**TODO:** Phase 2.6 - Production Deployment

Plánované:
- NSSM (Non-Sucking Service Manager)
- Windows Service registration
- Auto-start on boot
- Log rotation
- Monitoring

---

## 📊 Architecture

```
┌─────────────────────────────────────────────────┐
│  FastAPI Application (Port 8001)                │
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌──────────────────────────────────────────┐  │
│  │  Routers                                 │  │
│  │  ├─ /api/v1/invoices/import            │  │
│  │  ├─ /api/v1/partners (TODO)            │  │
│  │  ├─ /api/v1/products (TODO)            │  │
│  │  └─ /api/v1/deliveries (TODO)          │  │
│  └──────────────────────────────────────────┘  │
│                    ▼                            │
│  ┌──────────────────────────────────────────┐  │
│  │  Dependencies (DI)                       │  │
│  │  ├─ BtrieveClient (singleton)           │  │
│  │  ├─ Repositories                        │  │
│  │  │  ├─ GSCATRepository                  │  │
│  │  │  ├─ PABRepository                    │  │
│  │  │  └─ BarcodeRepository                │  │
│  │  └─ ISDOCToNEXMapper                    │  │
│  └──────────────────────────────────────────┘  │
│                    ▼                            │
│  ┌──────────────────────────────────────────┐  │
│  │  Models & Utils                          │  │
│  │  ├─ Pydantic Models (API)               │  │
│  │  ├─ Dataclasses (NEX)                   │  │
│  │  └─ ISDOC Mapper                        │  │
│  └──────────────────────────────────────────┘  │
│                    ▼                            │
│  ┌──────────────────────────────────────────┐  │
│  │  Btrieve Client                          │  │
│  │  └─ wbtrv32.dll operations              │  │
│  └──────────────────────────────────────────┘  │
│                    ▼                            │
└─────────────────────────────────────────────────┘
                     ▼
        ┌────────────────────────┐
        │  NEX Genesis Database  │
        │  ├─ GSCAT.BTR          │
        │  ├─ PAB.BTR            │
        │  ├─ BARCODE.BTR        │
        │  └─ TSH/TSI.BTR        │
        └────────────────────────┘
```

---

## 🐛 Troubleshooting

### Problem: Server won't start

**Error:** `ModuleNotFoundError: No module named 'fastapi'`

**Solution:**
```powershell
.\venv32\Scripts\activate
pip install -r requirements.txt
```

---

### Problem: Btrieve DLL not found

**Error:** `FileNotFoundError: wbtrv32.dll not found`

**Solution:**
Skontroluj `config/database.yaml`:
```yaml
pervasive:
  dll_paths:
    - "C:\\Program Files (x86)\\Pervasive Software\\PSQL\\bin"
    - "C:\\PVSW\\bin"
```

---

### Problem: Port already in use

**Error:** `OSError: [WinError 10048] Only one usage of each socket address`

**Solution:**
```powershell
# Check what's using port 8001
netstat -ano | findstr :8001

# Kill process
taskkill /PID <PID> /F

# Or use different port
python run_api.py --port 8002
```

---

## 📝 Next Steps

**Phase 2.2 - Additional Endpoints:**
- [ ] Partners CRUD (`/api/v1/partners`)
- [ ] Products CRUD (`/api/v1/products`)
- [ ] Deliveries CRUD (`/api/v1/deliveries`)

**Phase 2.3 - TSH/TSI Implementation:**
- [ ] TSHRepository
- [ ] TSIRepository
- [ ] Complete delivery creation in import

**Phase 2.4 - Security:**
- [ ] JWT authentication
- [ ] API keys
- [ ] Rate limiting

---

## 📚 Resources

- **FastAPI Docs:** https://fastapi.tiangolo.com/
- **Uvicorn Docs:** https://www.uvicorn.org/
- **Pydantic Docs:** https://docs.pydantic.dev/

---

**Created:** 2025-10-23  
**Version:** 1.0.0  
**Status:** Phase 2.1 Complete ✅