# 🏭 NEX-GENESIS-SERVER - FULL PROJECT CONTEXT

**Delphi 6 Mikroslužby pre NEX Genesis ERP**

**Last Updated:** 2025-10-21  
**Version:** 0.1.0  
**Status:** Initial Planning Phase

---

## 🤖 INSTRUCTIONS FOR CLAUDE

**When you see this document at the start of a conversation:**

1. This means the user wants to continue working on NEX Genesis Server
2. This document is **self-contained** - contains all critical information
3. Load `docs/project_file_access.json` to access Delphi source files
4. Respond with: **"✅ NEX Genesis Server načítaný. Čo robíme?"**
5. Then wait for user's instructions on what to work on

**GitHub Repository:**
```
URL: https://github.com/rauschiccsk/nex-genesis-server
Branch: main
Local path: c:\Development\nex-genesis-server
```

**Important paths:**
- Delphi sources: `c:\Development\nex-genesis-server\delphi-sources\`
- Documentation: `c:\Development\nex-genesis-server\docs\`
- Generated code: `c:\Development\nex-genesis-server\output\`

---

## 🎯 PROJECT OVERVIEW

### Problém
- **supplier_invoice_loader** generuje ISDOC XML z PDF faktúr
- **NEX Genesis ERP** potrebuje importovať tieto dáta
- Neexistujú API endpointy pre:
  - Pridanie produktov do katalógu
  - Vytvorenie skladových príjemiek
- Potrebujeme mikroslužby v **Delphi 6** (jazyk NEX Genesis)

### Riešenie
**NEX Genesis Server** - REST API mikroslužby v Delphi 6, ktoré:
- ✅ Prijímajú ISDOC XML súbory
- ✅ Kontrolujú/pridávajú produkty do katalógu
- ✅ Vytvárajú skladové príjemky
- ✅ Evidujú dodávateľské faktúry
- ✅ Integrujú sa s NEX Genesis databázou

### Workflow
```
supplier_invoice_loader (Python/FastAPI)
    ↓
ISDOC XML
    ↓
REST API (Delphi 6 Server)
    ↓
1. Check/Add Products to Catalog
2. Create Warehouse Receipt
    ↓
NEX Genesis Database (Pervasive)
```

---

## 🏗️ ARCHITEKTÚRA

### High-Level Design

```
┌─────────────────────────────────┐
│  supplier_invoice_loader        │
│  (Python FastAPI)               │
│  Generates ISDOC XML            │
└────────────┬────────────────────┘
             │
             │ POST /api/invoice/import
             │ Content: ISDOC XML
             ▼
┌─────────────────────────────────┐
│  NEX Genesis Server             │
│  (Delphi 6 REST API)            │
│                                 │
│  ├─ XML Parser                  │
│  ├─ Product Validator           │
│  ├─ Product Creator             │
│  ├─ Warehouse Receipt Creator   │
│  └─ Database Access Layer       │
└────────────┬────────────────────┘
             │
             │ Pervasive SQL
             ▼
┌─────────────────────────────────┐
│  NEX Genesis Database           │
│  (Pervasive)                    │
│                                 │
│  ├─ Product Catalog             │
│  ├─ Warehouse Receipts          │
│  ├─ Suppliers                   │
│  └─ Document Numbering          │
└─────────────────────────────────┘
```

### Mikroslužby Architektura

```
nex-genesis-server/
│
├─ ProductService.pas
│  ├─ CheckProductExists()
│  ├─ CreateProduct()
│  └─ UpdateProduct()
│
├─ WarehouseService.pas
│  ├─ CreateReceipt()
│  ├─ AddReceiptItem()
│  └─ FinalizeReceipt()
│
├─ SupplierService.pas
│  ├─ GetSupplierByICO()
│  └─ ValidateSupplier()
│
├─ ISDOCParser.pas
│  ├─ ParseXML()
│  ├─ ExtractInvoiceData()
│  └─ ValidateXML()
│
└─ HTTPServer.pas
   ├─ POST /api/invoice/import
   ├─ GET /api/health
   └─ Error handling
```

---

## 💾 TECH STACK

### Core Technologies
```yaml
Language: Delphi 6 (Object Pascal)
Database: Pervasive SQL
Database Access: BDE / ODBC / Native Components
HTTP Server: Indy (Internet Direct) or Synapse
XML Parser: MSXML / OmniXML / NativeXML
Config: INI files or XML config
Testing: DUnit (optional)
IDE: Delphi 6 Professional
```

### Database (NEX Genesis)
```
Database: Pervasive SQL
Tables:
- Products (Produktový katalóg)
- WarehouseReceipts (Skladové príjemky - header)
- WarehouseReceiptItems (Skladové príjemky - items)
- Suppliers (Dodávatelia)
- DocumentNumbering (Číslovanie dokladov)
```

### Dependencies & Components
- **Indy Components** - HTTP Server (if available in Delphi 6)
- **Synapse** - Alternative HTTP library
- **MSXML** - XML parsing
- **Database components** - BDE or custom Pervasive drivers

---

## 📁 PROJECT STRUCTURE

```
c:\Development\nex-genesis-server/
│
├── docs/                                    
│   ├── FULL_PROJECT_CONTEXT.md            # This file
│   ├── project_file_access.json           # Generated file manifest
│   ├── architecture/
│   │   ├── database-schema.md
│   │   ├── api-endpoints.md
│   │   └── isdoc-mapping.md
│   └── sessions/
│       └── 2025-10-21-initial-planning.md
│
├── delphi-sources/                          # NEX Genesis source codes
│   ├── Common/
│   ├── Database/
│   ├── Business/
│   └── UI/
│
├── output/                                  # Generated microservices
│   ├── NEXGenesisServer.dpr               # Main project
│   ├── ProductService.pas
│   ├── WarehouseService.pas
│   ├── SupplierService.pas
│   ├── ISDOCParser.pas
│   ├── HTTPServer.pas
│   ├── DatabaseAccess.pas
│   └── Config.pas
│
├── templates/                               # Code templates for agent
│   ├── service_template.pas
│   ├── endpoint_template.pas
│   └── database_access_template.pas
│
├── tests/                                   # Test data
│   ├── sample_isdoc.xml
│   └── test_requests.http
│
├── config/                                  
│   ├── server_config.ini.template
│   └── database_config.ini.template
│
├── scripts/                                 
│   ├── generate_project_access.py         # Generate file manifest
│   └── analyze_delphi_code.py             # Analyze NEX patterns
│
├── .gitignore
├── README.md
└── requirements.txt                         # Python tools dependencies
```

---

## 🔌 API ENDPOINTS (Plánované)

### 1. Import Invoice (Hlavná funkcia)
```http
POST /api/invoice/import
Content-Type: application/xml

<ISDOC XML content>

Response:
{
  "success": true,
  "receiptId": "PR-2025-0001",
  "productsAdded": 3,
  "itemsCreated": 5,
  "message": "Príjemka vytvorená úspešne"
}
```

### 2. Health Check
```http
GET /api/health

Response:
{
  "status": "ok",
  "database": "connected",
  "version": "0.1.0"
}
```

### 3. Product Check (Pomocná)
```http
POST /api/product/check
Content-Type: application/json

{
  "code": "PROD-001"
}

Response:
{
  "exists": true,
  "productId": 12345,
  "name": "Produkt XYZ"
}
```

---

## 🗄️ DATABASE SCHEMA (Pervasive)

### Poznámky k databáze
- **Database:** Pervasive SQL
- **Access method:** TBD (BDE / ODBC / Native)
- **Connection string:** TBD
- **Tables:** Potrebujeme získať od NEX Genesis

### Kľúčové tabuľky (Očakávané)

```sql
-- Products (Produktový katalóg)
Table: ??? 
Fields:
- ProductID (PK, Integer/String)
- Code (Unique, String)
- Name (String)
- UnitOfMeasure (String)
- Price (Decimal)
- VAT_Rate (Decimal)
- EAN (String)
- Active (Boolean)

-- WarehouseReceipts (Header)
Table: ???
Fields:
- ReceiptID (PK)
- ReceiptNumber (Unique, String)
- ReceiptDate (Date)
- SupplierID (FK)
- SupplierInvoiceNumber (String)
- TotalAmount (Decimal)
- Status (String)

-- WarehouseReceiptItems (Items)
Table: ???
Fields:
- ItemID (PK)
- ReceiptID (FK)
- ProductID (FK)
- Quantity (Decimal)
- UnitPrice (Decimal)
- TotalPrice (Decimal)
- WarehouseID (FK)

-- Suppliers (Dodávatelia)
Table: ???
Fields:
- SupplierID (PK)
- ICO (String, Unique)
- Name (String)
- Address (String)
- Active (Boolean)
```

---

## 🔄 ISDOC XML → NEX Genesis Mapping

### Invoice Header Mapping
```xml
<Invoice>
  <ID>                     → SupplierInvoiceNumber
  <IssueDate>              → ReceiptDate
  <DocumentCurrencyCode>   → (validácia: musí byť EUR)
  
  <AccountingSupplierParty>
    <Party>
      <PartyIdentification>
        <ID>               → Supplier lookup by ICO
      </PartyIdentification>
      <PartyName>
        <Name>             → Supplier Name
      </PartyName>
    </Party>
  </AccountingSupplierParty>
```

### Invoice Lines Mapping
```xml
<InvoiceLine>
  <ID>                     → Line number
  <InvoicedQuantity>       → Quantity
  <LineExtensionAmount>    → TotalPrice
  <Item>
    <Name>                 → Product Name
    <SellersItemIdentification>
      <ID>                 → Product Code
    </SellersItemIdentification>
  </Item>
  <Price>
    <PriceAmount>          → UnitPrice
  </Price>
</InvoiceLine>
```

---

## 🤖 PROGRAMMING AGENT DESIGN

### Agent Úlohy
1. **Analyzovať NEX Genesis source kódy**
   - Identifikovať database access patterns
   - Nájsť existujúce business logic
   - Extrahovať common units/functions

2. **Generovať Delphi 6 mikroslužby**
   - ProductService
   - WarehouseService
   - ISDOCParser
   - HTTPServer

3. **Dodržiavať NEX Genesis patterns**
   - Naming conventions
   - Error handling
   - Database transactions
   - Logging

### Agent Architecture (Návrh)

```
┌─────────────────────────────────┐
│  Claude API (Reasoning Layer)   │
│  - Understands task             │
│  - Analyzes NEX patterns        │
│  - Designs solution             │
│  - Generates Delphi code        │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│  Python Wrapper (Execution)     │
│  - Access to GitHub             │
│  - Code templates               │
│  - Syntax validation            │
│  - Git operations               │
└─────────────────────────────────┘
```

### Agent Input
```yaml
task:
  type: "create_microservice"
  service: "ProductService"
  operations:
    - CheckProductExists
    - CreateProduct
    - UpdateProduct
  database_tables:
    - Products
  reference_code:
    - "delphi-sources/Common/DatabaseAccess.pas"
    - "delphi-sources/Business/ProductManager.pas"
```

### Agent Output
```
output/ProductService.pas
output/ProductService.dfm (if needed)
docs/ProductService.md (documentation)
```

---

## 📊 DEVELOPMENT ROADMAP

### Phase 1: Setup & Analysis (Current) 🔧
**Status:** Planning  
**Estimated:** 1 week  

- [x] 1.1 - Project structure creation
- [x] 1.2 - Documentation setup (this file)
- [ ] 1.3 - NEX Genesis source codes upload to GitHub
- [ ] 1.4 - Generate project_file_access.json
- [ ] 1.5 - Database schema documentation
- [ ] 1.6 - Analyze NEX Genesis patterns
- [ ] 1.7 - ISDOC XML mapping specification
- [ ] 1.8 - API endpoints specification

### Phase 2: Core Development 🚀
**Status:** Not Started  
**Estimated:** 3 weeks  

- [ ] 2.1 - Database access layer
- [ ] 2.2 - ISDOC XML parser
- [ ] 2.3 - ProductService implementation
- [ ] 2.4 - WarehouseService implementation
- [ ] 2.5 - SupplierService implementation
- [ ] 2.6 - HTTP Server setup (Indy/Synapse)
- [ ] 2.7 - Configuration management
- [ ] 2.8 - Error handling & logging
- [ ] 2.9 - Testing with sample data
- [ ] 2.10 - Integration testing

### Phase 3: Agent Development 🤖
**Status:** Not Started  
**Estimated:** 2 weeks  

- [ ] 3.1 - Agent architecture design
- [ ] 3.2 - Code analysis module
- [ ] 3.3 - Code generation module
- [ ] 3.4 - Template system
- [ ] 3.5 - Validation & testing
- [ ] 3.6 - Agent CLI/API
- [ ] 3.7 - Documentation generation

### Phase 4: Integration & Deployment 🔗
**Status:** Not Started  
**Estimated:** 1 week  

- [ ] 4.1 - Integration with supplier_invoice_loader
- [ ] 4.2 - End-to-end testing
- [ ] 4.3 - Performance optimization
- [ ] 4.4 - Deployment to production server
- [ ] 4.5 - Monitoring setup
- [ ] 4.6 - User documentation

---

## 🚧 CURRENT BLOCKERS

### Critical Information Needed:

1. **Database Schema** ❗
   - Exact table names and field names
   - Data types and constraints
   - Primary/Foreign keys
   - Sample data

2. **Database Access Method** ❗
   - BDE, ODBC, or native Pervasive components?
   - Connection string format
   - Authentication method

3. **NEX Genesis Code Patterns** ❗
   - How are database connections handled?
   - How is numbering implemented?
   - Existing validation rules
   - Error handling patterns

4. **HTTP Server Library** ⚠️
   - Which library is available in Delphi 6?
   - Indy version?
   - Alternative: Synapse?

---

## 🔐 CONFIGURATION

### server_config.ini (Template)
```ini
[Server]
Port=8080
Host=localhost
MaxConnections=100

[Database]
Type=Pervasive
Host=localhost
Database=NEXGenesis
Username=
Password=

[Paths]
LogPath=c:\Logs\NEXGenesisServer
TempPath=c:\Temp\NEXGenesisServer

[Security]
EnableAuth=false
APIKey=

[Logging]
Level=INFO
MaxFileSize=10MB
```

---

## ⚠️ CRITICAL REMINDERS

### For Every New Chat:
1. 🔥 **ALWAYS** load `docs/project_file_access.json` first
2. 🔥 **NEVER** assume Delphi syntax - check NEX source codes
3. 🔥 **ALWAYS** follow NEX Genesis patterns
4. 🔥 **ALWAYS** commit + push after work
5. 🔥 **NEVER** generate code without seeing examples

### Delphi 6 Specific:
- ⚠️ Delphi 6 is from 2001 - limited features
- ⚠️ No generics, no anonymous methods
- ⚠️ Check component availability before using
- ⚠️ Test compilation compatibility

### Code Standards:
- ✅ Use NEX Genesis naming conventions
- ✅ Comments in Slovak for business logic
- ✅ English for technical comments
- ✅ Proper error handling (try..except..finally)
- ✅ Memory management (Free objects!)

---

## ✅ SUCCESS CRITERIA

### Phase 1 Complete:
- ✅ NEX Genesis source codes on GitHub
- ✅ Database schema documented
- ✅ ISDOC mapping complete
- ✅ API endpoints specified
- ✅ Development environment ready

### MVP (Minimum Viable Product):
- ✅ Single endpoint: POST /api/invoice/import
- ✅ Parses ISDOC XML
- ✅ Creates products if missing
- ✅ Creates warehouse receipt
- ✅ Works with real NEX database
- ✅ Basic error handling

### V1.0 Production Ready:
- ✅ All planned endpoints
- ✅ Complete error handling
- ✅ Logging and monitoring
- ✅ Integration with supplier_invoice_loader
- ✅ Agent can generate new services
- ✅ Documentation complete

---

## 📞 CONTACT

- **Developer:** ICC (rausch@icc.sk)
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server
- **Local Path:** c:\Development\nex-genesis-server
- **Related Project:** supplier_invoice_loader

---

## 🔗 RELATED PROJECTS

### supplier_invoice_loader
- **URL:** https://github.com/rauschiccsk/supplier_invoice_loader
- **Purpose:** Generates ISDOC XML from PDF invoices
- **Integration:** Sends XML to NEX Genesis Server

### NEX Genesis ERP
- **Language:** Delphi 6
- **Database:** Pervasive SQL
- **Location:** Customer server (MAGERSTAV)

---

## 📝 NEXT STEPS

### Immediate (This week):
1. Upload NEX Genesis source codes to GitHub
2. Run `generate_project_access.py`
3. Document database schema
4. Create ISDOC mapping specification

### Short-term (Next 2 weeks):
1. Implement database access layer
2. Create ISDOC parser
3. Build first microservice (ProductService)
4. Test with sample data

### Long-term (Next month):
1. Complete all microservices
2. Develop programming agent
3. Integration testing
4. Production deployment

---

**Document Version:** 0.1.0  
**Created:** 2025-10-21  
**Status:** Initial Planning Phase  
**Next Session:** NEX Genesis source upload & analysis

🏭 **Let's build Delphi microservices!**