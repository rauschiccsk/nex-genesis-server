# NEX Genesis Server - Project Overview

**Strategic Vision and Goals**

Version: 1.0.0  
Last Updated: 2025-10-23

---

## Basic Information

- **Project Name:** NEX Genesis Server
- **Purpose:** Python services with direct Btrieve access for NEX Genesis ERP
- **Tech Stack:** Python 3.8+ (32-bit) + Pervasive PSQL v11 + Btrieve API
- **Developer:** ICC (Innovation & Consulting Center)
- **GitHub Account:** rauschiccsk
- **Location:** Komárno, SK
- **Repository:** https://github.com/rauschiccsk/nex-genesis-server
- **Local Path:** c:\Development\nex-genesis-server

---

## Project Vision

Create **Python services** that:
- Directly access NEX Genesis Btrieve databases
- Process ISDOC XML from supplier_invoice_loader
- Create delivery notes in NEX Genesis
- Update product catalog
- Manage suppliers

---

## The Problem

**Current Situation:**
- **supplier_invoice_loader** generates ISDOC XML from PDF invoices
- **NEX Genesis ERP** needs to import this data
- No API endpoints exist for:
  - Adding products to catalog
  - Creating delivery notes
  - Managing suppliers
- Need **direct database access** to Btrieve tables

**Pain Points:**
- Manual data entry required
- Time-consuming process
- Error-prone
- No automation between systems

---

## The Solution

**NEX Genesis Server** - Python services with Btrieve API that:
- Accept ISDOC XML files
- Validate and process invoice data
- Check/add products to catalog (GSCAT)
- Create delivery notes (TSH/TSI)
- Manage suppliers (PAB)
- Process barcodes (BARCODE)
- Direct access to Pervasive databases

**Key Benefits:**
- Full automation
- Real-time data integration
- No manual entry
- Error validation
- Audit trail

---

## Strategic Decision (2025-10-21)

**Pure Python Btrieve approach** instead of Delphi microservice

**Why Python over Delphi:**
- Faster development (Python vs Delphi 6)
- Better integration with supplier_invoice_loader
- Modern tools and debugging
- Direct file access (no server needed)
- Easier maintenance
- Rich ecosystem (FastAPI, pytest, etc.)

**Technical Approach:**
- Python 3.8+ (32-bit) with ctypes for Btrieve API
- Direct access to .BTR files
- Use existing .bdf schemas
- Pervasive PSQL v11 SDK

---

## System Workflow

```
supplier_invoice_loader (Python/FastAPI)
    |
    | Generates ISDOC XML from PDF invoices
    v
ISDOC XML File
    |
    | HTTP POST /api/invoice/import
    v
NEX Genesis Server (Python Services)
    |
    | 1. Parse and validate XML
    | 2. Check/add products (GSCAT)
    | 3. Check/add barcodes (BARCODE)
    | 4. Validate supplier (PAB)
    | 5. Create delivery note (TSH/TSI)
    v
NEX Genesis Database (Pervasive Btrieve)
    | .BTR files on disk
    v
NEX Genesis ERP (Delphi 6)
    | Real-time access to updated data
    v
Users see data immediately
```

---

## Key Features

### Phase 1: Core Btrieve Access (CURRENT)
- Python Btrieve client wrapper
- Direct file operations (open, read, close)
- Data reading and parsing
- Configuration management
- Testing framework

**Status:** COMPLETE (Task 1.7 done, 2025-10-22)

### Phase 2: Business Logic (NEXT)
- ISDOC XML parser
- Product validation and creation
- Barcode management
- Delivery note creation
- Supplier validation

**Status:** PLANNED (Tasks 1.8-1.10)

### Phase 3: API Layer (FUTURE)
- FastAPI HTTP server
- REST endpoints
- Request validation
- Error handling
- Logging and monitoring

**Status:** PLANNED (Phase 2)

### Phase 4: Integration (FUTURE)
- supplier_invoice_loader integration
- Automated workflows
- Batch processing
- Backup and recovery
- Production deployment

**Status:** PLANNED (Phase 3)

---

## Success Criteria

### MVP (Minimum Viable Product)
- One endpoint: POST /api/invoice/import
- Parse ISDOC XML
- Create products if missing (GSCAT)
- Create delivery notes (TSH/TSI)
- Works with real NEX database
- Basic error handling

### V1.0 Production Ready
- All planned endpoints working
- Complete error handling
- Logging and monitoring
- Integration with supplier_invoice_loader
- Backup strategy
- Complete documentation
- Production deployment

---

## Related Projects

### supplier_invoice_loader
- **URL:** https://github.com/rauschiccsk/supplier_invoice_loader
- **Purpose:** Generates ISDOC XML from PDF invoices
- **Integration:** Sends XML to NEX Genesis Server
- **Technology:** Python, FastAPI, AI/ML for PDF parsing

### NEX Genesis ERP
- **Language:** Delphi 6
- **Database:** Pervasive PSQL v11 (Btrieve)
- **Location:** Customer server (MAGERSTAV)
- **Purpose:** Main ERP system for business operations

---

## Technology Choices

### Why Python?
- Fast development cycle
- Rich ecosystem (FastAPI, pytest, lxml)
- Better debugging tools
- Easy integration with supplier_invoice_loader
- Modern async/await support
- Strong typing with type hints

### Why 32-bit Python?
- NEX Genesis uses 32-bit Pervasive PSQL v11
- Btrieve DLLs are 32-bit only (w3btrv7.dll)
- Direct DLL loading requires matching architecture
- No 64-bit Btrieve DLLs available

### Why Direct Btrieve Access?
- No API exists in NEX Genesis
- Fastest possible access
- Real-time updates
- No network overhead
- Full control over data

### Why ctypes over SWIG?
- No compilation needed
- Easier development
- Direct control over DLL calls
- Better debugging
- Simpler maintenance

---

## Project Timeline

**2025-10-21:** Project start, strategic decision  
**2025-10-22:** Btrieve client implementation (Task 1.7 complete)  
**2025-10-23:** Documentation restructure, planning Phase 2  
**Next:** Database schema analysis (Task 1.8)

---

## Contact

- **Developer:** ICC (rausch@icc.sk)
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server
- **Location:** Komárno, SK

---

**For current status:** See `docs/sessions/YYYY-MM-DD_session.md` (latest session)