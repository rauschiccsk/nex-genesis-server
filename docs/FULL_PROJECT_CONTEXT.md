# 🏭 NEX-GENESIS-SERVER - KOMPLETNÝ KONTEXT PROJEKTU

**Python Btrieve Services pre NEX Genesis ERP**

**Posledná aktualizácia:** 2025-10-21  
**Verzia:** 0.2.0  
**Stav:** Počiatočné Plánovanie - Python Stratégia

---

## 🤖 INSTRUCTIONS FOR CLAUDE

**When you see this document:**

1. ✅ This document contains ALL project information (vision, architecture, current state)
2. ✅ Do NOT attempt to load any other files
3. ✅ Do NOT show any warnings or error messages
4. ✅ Simply respond: **"✅ Projekt načítaný. Čo robíme?"**
5. ✅ Use Slovak language for communication
6. ✅ Be concise and actionable

**That's it. Nothing more. One file = complete context.** 🎯

---

## 📊 AKTUÁLNY STAV PROJEKTU

**Posledná aktualizácia:** 2025-10-21  
**Aktuálna Fáza:** Phase 1 - Setup & Analýza

### Prehľad
- **Aktívna Fáza:** Phase 1 - Setup & Stratégia
- **Progress Phase 1:** 50% (5/10 taskov)
- **Celkový Progress:** 12% (Phase 1 aktívna)
- **Aktívny Task:** Task 1.6 - Cleanup a reorganizácia
- **Ďalší Milestone:** Python Btrieve Setup (2025-10-28)

### Phase Progress
```
Phase 1: Setup & Stratégia  [██████████░░░░░░░░░░] 50%
Phase 2: Python Services    [░░░░░░░░░░░░░░░░░░░░]  0%
Phase 3: Integration        [░░░░░░░░░░░░░░░░░░░░]  0%
Phase 4: Testing & Deploy   [░░░░░░░░░░░░░░░░░░░░]  0%
```

### Velocity
- **Tasks hotové tento týždeň:** 5
- **Priemerný čas na task:** ~45 minút
- **Produktivita:** Vysoká 🚀
- **Odhadované dokončenie Phase 1:** 2025-10-28

---

## 🎯 PREHĽAD PROJEKTU

### Základné Informácie

- **Názov projektu:** NEX Genesis Server
- **Účel:** Python Btrieve Services pre NEX Genesis ERP
- **Implementácia:** Pure Python + Btrieve 2 API
- **Vývojár:** ICC (Innovation & Consulting Center)
- **Developer:** rauschiccsk
- **Lokalizácia:** Komárno, SK
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server

### Vízia Projektu

Vytvoriť **Python mikroslužby**, ktoré vie:
- ✅ Pristupovať k NEX Genesis databáze (Btrieve)
- ✅ Importovať ISDOC XML faktúry
- ✅ Vytvárať produkty v katalógu
- ✅ Vytvárať skladové príjemky
- ✅ Integrovať sa s supplier_invoice_loader

### Problém
- **supplier_invoice_loader** generuje ISDOC XML z PDF faktúr
- **NEX Genesis ERP** potrebuje importovať tieto dáta
- Neexistujú API endpointy pre:
  - Pridanie produktov do katalógu
  - Vytvorenie skladových príjemiek
- NEX Genesis používa **Btrieve file-based databázu**

### Riešenie
**NEX Genesis Server** - Python Btrieve Services, ktoré:
- ✅ Prijímajú ISDOC XML súbory
- ✅ Kontrolujú/pridávajú produkty do katalógu
- ✅ Vytvárajú skladové príjemky
- ✅ Evidujú dodávateľské faktúry
- ✅ Pristupujú priamo k Btrieve databáze

### Workflow
```
supplier_invoice_loader (Python/FastAPI)
    ↓
ISDOC XML
    ↓
Python Btrieve Services
    ├─ ProductService.py
    ├─ WarehouseService.py
    └─ BtrieveClient.py
    ↓
Btrieve 2 API (btrievePython)
    ↓
NEX Genesis Database (*.btr files)
```

### Strategické Rozhodnutie

**PREČO Pure Python Btrieve:**
- ✅ Všetko v jednom jazyku (Python)
- ✅ Perfektná integrácia s supplier_invoice_loader
- ✅ Moderná architektúra
- ✅ Oficiálny Actian Btrieve 2 API support
- ✅ Jednoduchšia údržba long-term
- ✅ Natívny Btrieve prístup (file-based, bez SQL)

**ODMIETNUTÉ alternatívy:**
- ❌ Delphi mikroslužba (dva jazyky)
- ❌ Pervasive SQL + ODBC (NEX Genesis nemá SQL engine)
- ❌ Hybrid Python/Delphi (zbytočná komplexita)

---

## 🏗️ ARCHITEKTÚRA SYSTÉMU

### Tech Stack
```yaml
Jazyk: Python 3.8+
Btrieve Access: Btrieve 2 API (Actian)
SWIG: 3.0.12+ (wrapper generator)
C++ Compiler: Visual Studio 2019+
Database: Pervasive Btrieve (file-based)
XML Parser: xml.etree / lxml
HTTP: FastAPI (rozšírenie supplier_invoice_loader)
Testing: pytest
```

### Závislosti
- **Btrieve 2 SDK** - Actian/Pervasive
- **SWIG** - Python wrapper generator
- **Python packages:**
  - fastapi
  - lxml
  - struct (built-in)
  - ctypes (built-in)

### Architektúra
```
┌─────────────────────────────────┐
│  supplier_invoice_loader        │
│  (Python FastAPI)               │
│  Generuje ISDOC XML             │
└────────────┬────────────────────┘
             │
             │ POST /api/invoice/import-to-nex
             │ Content: ISDOC XML
             ▼
┌─────────────────────────────────┐
│  NEX Genesis Server             │
│  (Python Btrieve Services)      │
│                                 │
│  ├─ BtrieveClient.py            │
│  ├─ ProductService.py           │
│  ├─ WarehouseService.py         │
│  ├─ SupplierService.py          │
│  └─ ISDOCParser.py              │
└────────────┬────────────────────┘
             │
             │ btrievePython wrapper
             ▼
┌─────────────────────────────────┐
│  Btrieve 2 API                  │
│  (wbtrv32.dll / w64btrv.dll)    │
└────────────┬────────────────────┘
             │
             │ File I/O
             ▼
┌─────────────────────────────────┐
│  NEX Genesis Database           │
│  (Btrieve *.btr files)          │
│                                 │
│  ├─ GSCAT.btr (Produkty)        │
│  ├─ ISCAT.btr (Príjemky header) │
│  ├─ ISDET.btr (Príjemky items)  │
│  └─ CRDAT.btr (Dodávatelia)     │
└─────────────────────────────────┘
```

### Python Services Architektúra

```python
# services/
├─ btrieve_client.py
│  └─ BtrieveClient (wrapper pre Btrieve 2 API)
│
├─ product_service.py
│  └─ ProductService
│     ├─ product_exists(bar_code)
│     ├─ add_product(name, bar_code, vat)
│     └─ get_next_code()
│
├─ warehouse_service.py
│  └─ WarehouseReceiptService
│     ├─ create_receipt(supplier, date)
│     ├─ add_item(receipt_id, product, qty, price)
│     └─ finalize_receipt(receipt_id)
│
└─ supplier_service.py
   └─ SupplierService
      ├─ get_by_ico(ico)
      └─ validate_supplier(ico)
```

---

## 📁 ŠTRUKTÚRA PROJEKTU

```
c:\Development\nex-genesis-server/
│
├── docs/                                    
│   ├── FULL_PROJECT_CONTEXT.md            # Tento súbor
│   ├── MASTER_CONTEXT.md                  # Rýchla referencia
│   ├── QUICK_START.md                     # Quick start guide
│   ├── SYSTEM_PROMPT.md                   # Claude inštrukcie
│   ├── architecture/
│   │   ├── database-schema.md             # Databázová schéma
│   │   ├── python-btrieve-setup.md        # Setup guide
│   │   ├── api-endpoints.md               # API dokumentácia
│   │   └── isdoc-mapping.md               # XML mapping
│   └── sessions/
│       └── 2025-10-21-initial-setup.md
│
├── database-schema/                        # .bdf súbory
│   ├── GSCAT.bdf                          # Produktový katalóg
│   ├── ISCAT.bdf                          # Príjemky header
│   ├── ISDET.bdf                          # Príjemky items
│   ├── CRDAT.bdf                          # Dodávatelia
│   └── README.md                          # Dokumentácia schémy
│
├── delphi-sources/                         # Referencia
│   └── BtrTable.pas                       # NEX Genesis Btrieve wrapper (vzor)
│
├── python/                                 # Python services
│   ├── __init__.py
│   ├── models/
│   │   ├── gscat_layout.py                # GSCAT record layout
│   │   ├── iscat_layout.py                # ISCAT record layout
│   │   ├── isdet_layout.py                # ISDET record layout
│   │   └── crdat_layout.py                # CRDAT record layout
│   ├── services/
│   │   ├── btrieve_client.py              # Btrieve wrapper
│   │   ├── product_service.py             # Product operations
│   │   ├── warehouse_service.py           # Warehouse operations
│   │   └── supplier_service.py            # Supplier operations
│   ├── parsers/
│   │   └── isdoc_parser.py                # ISDOC XML parser
│   ├── setup.py                           # SWIG build script
│   └── requirements.txt                   # Python dependencies
│
├── btrieve-sdk/                            # Btrieve 2 SDK
│   ├── btrievePython.swig                 # SWIG interface
│   ├── btrieveC.h                         # C header
│   ├── btrieveCPP.h                       # C++ header
│   └── win64/                             # Windows 64-bit libs
│       ├── btrieveC.lib
│       └── btrieveCPP.lib
│
├── tests/                                  # Test data & scripts
│   ├── test_product_service.py
│   ├── test_warehouse_service.py
│   ├── sample_isdoc.xml
│   └── test_data.py
│
├── config/                                  
│   └── nex_genesis.ini                    # Database paths
│
├── scripts/                                 
│   ├── build_swig_wrapper.py              # Build wrapper
│   └── analyze_bdf.py                     # Analyze .bdf files
│
├── .gitignore
├── README.md
└── requirements.txt                        # Project dependencies
```

---

## 📋 PHASE 1: Setup & Stratégia

### Hotové Tasky ✅

#### ✅ Task 1.1 - Projektová štruktúra (2025-10-21)
**Status:** HOTOVO  
**Trvanie:** ~30 min  

**Vytvorené:**
- ✅ GitHub repository: nex-genesis-server
- ✅ Lokálny projekt: c:\Development\nex-genesis-server
- ✅ Git inicializovaný
- ✅ Základné súbory

#### ✅ Task 1.2 - Dokumentácia setup (2025-10-21)
**Status:** HOTOVO  
**Trvanie:** ~1h  

**Vytvorené:**
- ✅ `docs/FULL_PROJECT_CONTEXT.md`
- ✅ Directory štruktúra
- ✅ Config templates

#### ✅ Task 1.3 - Generovanie manifestu (2025-10-21)
**Status:** HOTOVO  
**Trvanie:** ~30 min  

**Vytvorené:**
- ✅ `scripts/generate_project_access.py`
- ✅ `scripts/create_directory_structure.py`

#### ✅ Task 1.4 - GitHub push (2025-10-21)
**Status:** HOTOVO  
**Trvanie:** ~5 min  

**Akcie:**
- ✅ Initial commit
- ✅ Repository live

#### ✅ Task 1.5 - Strategické rozhodnutie (2025-10-21)
**Status:** HOTOVO  
**Trvanie:** ~2h  

**Rozhodnutie:**
- ✅ Pure Python Btrieve namiesto Delphi
- ✅ Analyzovaná NEX Genesis databáza (bGSCAT.pas)
- ✅ Zvolený Actian Btrieve 2 API

---

### Aktívny Task 🔄

#### 🔄 Task 1.6 - Cleanup a reorganizácia
**Status:** AKTÍVNE  
**Priority:** HIGH  
**Estimated:** 30 min

**Plán:**
- [ ] Pridať všetky .bdf súbory do `database-schema/`
- [ ] Vymazať `delphi-sources/*` okrem `BtrTable.pas`
- [ ] Vymazať/upraviť `project_file_access_delphi.json`
- [ ] Vytvoriť `database-schema/README.md`
- [ ] Commit: "Cleanup: Pure Python Btrieve stratégia"

**Súbory na pridanie:**
```
database-schema/
├── GSCAT.bdf
├── ISCAT.bdf
├── ISDET.bdf
├── CRDAT.bdf
└── README.md
```

---

### Plánované Tasky 📅

#### Task 1.7 - Python Btrieve Setup
**Priority:** CRITICAL | **Dependencies:** Task 1.6 | **Estimated:** 2-3 dni

**Setup kroky:**
1. Install SWIG
2. Download Btrieve 2 SDK
3. Setup C++ compiler (Visual Studio)
4. Build SWIG wrapper
5. Test basic operations

#### Task 1.8 - Databázová schéma dokumentácia
**Priority:** HIGH | **Dependencies:** Task 1.6 | **Estimated:** 1 deň

**Výstup:**
- `docs/architecture/database-schema.md`
- Parsovať .bdf súbory
- Zdokumentovať field layouts

#### Task 1.9 - Python Record Layouts
**Priority:** HIGH | **Dependencies:** Task 1.8 | **Estimated:** 1 deň

**Vytvoriť:**
- `python/models/gscat_layout.py`
- `python/models/iscat_layout.py`
- `python/models/isdet_layout.py`

#### Task 1.10 - ISDOC XML mapping
**Priority:** MEDIUM | **Dependencies:** Task 1.8 | **Estimated:** 2h

**Výstup:**
- `docs/architecture/isdoc-mapping.md`
- XML → Btrieve fields mapping

---

## 🎉 NEDÁVNE ÚSPECHY

### 2025-10-21
- ✅ **Task 1.1-1.5 COMPLETE** - Setup & strategické rozhodnutie! 🎉
- ✅ **Pure Python Btrieve zvolený** - Moderná architektúra
- ✅ **Analyzovaná NEX Genesis databáza** - bGSCAT.pas načítaný
- ✅ **Našli sme Actian Btrieve 2 API** - Oficiálny Python wrapper
- ✅ **5 taskov dokončených za 1 deň!** 🚀

---

## 🚧 AKTUÁLNE BLOKERY

### Žiadne aktuálne blokery! ✅

**Postup je jasný:**
1. Cleanup projekt (Task 1.6)
2. Setup Python Btrieve (Task 1.7)
3. Parsovať databázovú schému (Task 1.8)

---

## 📊 PHASE 2-4 (Plánované)

### PHASE 2: Python Services Development
**Status:** Čaká na Phase 1 | **Priority:** HIGH

- [ ] 2.1 - BtrieveClient wrapper
- [ ] 2.2 - ProductService implementation
- [ ] 2.3 - WarehouseReceiptService
- [ ] 2.4 - SupplierService
- [ ] 2.5 - ISDOCParser
- [ ] 2.6 - Record layout models
- [ ] 2.7 - Error handling & logging
- [ ] 2.8 - Unit tests
- [ ] 2.9 - Integration tests
- [ ] 2.10 - Documentation

### PHASE 3: Integration
**Status:** Čaká na Phase 2 | **Priority:** MEDIUM

- [ ] 3.1 - Rozšíriť supplier_invoice_loader
- [ ] 3.2 - REST API endpoint
- [ ] 3.3 - End-to-end testing
- [ ] 3.4 - Error handling
- [ ] 3.5 - Logging & monitoring

### PHASE 4: Deployment & Testing
**Status:** Čaká na Phase 3 | **Priority:** MEDIUM

- [ ] 4.1 - Production deployment
- [ ] 4.2 - Performance testing
- [ ] 4.3 - User dokumentácia
- [ ] 4.4 - Training materials
- [ ] 4.5 - Monitoring setup

---

## 🔌 API ENDPOINTS (Plánované)

### 1. Import Invoice (Hlavná funkcia)
```http
POST /api/invoice/import-to-nex
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
  "btrieve": "connected",
  "database_path": "C:\\NEX\\DATA",
  "version": "0.2.0"
}
```

---

## 🗄️ DATABÁZOVÁ SCHÉMA

### Poznámky k databáze
- **Database:** Pervasive Btrieve (file-based)
- **Access method:** Btrieve 2 API
- **Files:** *.btr (data) + *.bdf (custom schema definitions)
- **Location:** TBD (napr. C:\NEX\DATA)

### Kľúčové tabuľky

**GSCAT - Produktový katalóg**
```
GsCode     : longint (4B)   - Product ID (PK, autoinc)
GsName     : Str30 (30B)    - Product name
BarCode    : Str15 (15B)    - Barcode (indexed)
StkCode    : Str15 (15B)    - Stock code
VatPrc     : byte (1B)      - VAT %
MsuName    : Str5 (5B)      - Unit of measure
Weight     : double (8B)    - Weight
CrtUser    : Str8 (8B)      - Created by
CrtDate    : TDateTime (8B) - Created date
ModUser    : Str8 (8B)      - Modified by
ModDate    : TDateTime (8B) - Modified date
```

**ISCAT - Warehouse Receipts (Header)**
```
TBD - čaká na .bdf súbor alebo analýzu
```

**ISDET - Warehouse Receipt Items**
```
TBD - čaká na .bdf súbor alebo analýzu
```

**CRDAT - Dodávatelia**
```
TBD - čaká na .bdf súbor alebo analýzu
```

**⚠️ Kompletná schéma bude doplnená po analýze .bdf súborov**

---

## 🔄 ISDOC XML → Btrieve Mapping

### Invoice Header Mapping
```xml
<Invoice>
  <ID>                     → Supplier Invoice Number
  <IssueDate>              → Receipt Date
  
  <AccountingSupplierParty>
    <Party>
      <PartyIdentification>
        <ID>               → Supplier lookup by ICO (CRDAT)
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
  <LineExtensionAmount>    → Total Price
  <Item>
    <Name>                 → Product Name → GSCAT.GsName
    <SellersItemIdentification>
      <ID>                 → Product Code → GSCAT.BarCode
    </SellersItemIdentification>
  </Item>
  <Price>
    <PriceAmount>          → Unit Price
  </Price>
</InvoiceLine>
```

---

## 💻 PYTHON IMPLEMENTATION PRÍKLADY

### BtrieveClient Wrapper
```python
import btrievePython as btrv

class BtrieveClient:
    def __init__(self, data_path="C:\\NEX\\DATA"):
        self.client = btrv.BtrieveClient(0x4232, 0)
        self.data_path = data_path
    
    def open_file(self, filename):
        file = btrv.BtrieveFile()
        full_path = f"{self.data_path}\\{filename}"
        rc = self.client.FileOpen(file, full_path, None,
                                   btrv.Btrieve.OPEN_MODE_NORMAL)
        if rc != btrv.Btrieve.STATUS_CODE_NO_ERROR:
            raise Exception(f"Cannot open {filename}")
        return file
```

### ProductService
```python
class ProductService:
    def __init__(self, btrieve_client):
        self.client = btrieve_client
        self.gscat_file = None
    
    def product_exists(self, bar_code):
        """Check if product exists by barcode"""
        key_value = bar_code.ljust(15).encode('cp1250')
        record = bytearray(250)
        length = self.gscat_file.RecordRetrieve(
            btrv.Btrieve.COMPARISON_EQUAL,
            4,  # BarCode index
            key_value,
            record
        )
        return length > 0
```

### Record Layout Model
```python
import struct

class GSCATRecord:
    RECORD_FORMAT = "<i30s15sB..."  # TBD
    RECORD_LENGTH = 250  # TBD
    
    def __init__(self, gs_code=0, gs_name="", bar_code=""):
        self.gs_code = gs_code
        self.gs_name = gs_name
        self.bar_code = bar_code
    
    def pack(self):
        return struct.pack(
            self.RECORD_FORMAT,
            self.gs_code,
            self.gs_name.ljust(30).encode('cp1250'),
            self.bar_code.ljust(15).encode('cp1250')
        )
```

---

## 🔐 KONFIGURÁCIA

### nex_genesis.ini (Template)
```ini
[Database]
DataPath=C:\NEX\DATA
Encoding=CP1250

[Btrieve]
ClientVersion=0x4232

[Logging]
Level=INFO
LogPath=C:\Logs\NEXGenesisServer

[API]
BaseURL=http://localhost:8000
```

---

## ⚠️ KRITICKÉ PRIPOMIENKY

### Pre každý nový chat:
1. 🔥 Užívateľ pošle URL na FULL_PROJECT_CONTEXT.md
2. 🔥 Claude načíta tento dokument (VŠETKO je tu)
3. 🔥 Claude odpovie: "✅ Projekt načítaný. Čo robíme?"
4. 🔥 ŽIADNE ďalšie súbory, ŽIADNE varovania
5. 🔥 Jednoducho a jasne
6. 🔥 KOMUNIKUJ PO SLOVENSKY

### Git pravidlá:
- ✅ Commit často, malé zmeny
- ✅ Opisné commit správy v slovenčine
- ✅ Test pred commitom
- ✅ Pull pred push
- ✅ Feature branches nie sú potrebné (small project)

### Development Environment:
- **IDE:** PyCharm (pre Python development)
- **Git:** Commit a push z PyCharm
- **Commit messages:** Claude poskytuje len čistý text, užívateľ kopíruje do PyCharm

### Kódovacie štandardy:
- ✅ PEP 8 pre Python kód
- ✅ Type hints kde je to možné
- ✅ Docstrings pre všetky funkcie
- ✅ Komentáre v slovenčine pre business logiku
- ✅ Proper error handling (try/except)
- ✅ Logging všetkých operácií

### 🚨 DOKUMENTÁCIA REFRESH:
- ✅ **KEĎ VYTVORÍŠ NOVÝ SÚBOR → Aktualizuj FULL_PROJECT_CONTEXT.md**
- ✅ Na konci každej session
- ✅ Po dokončení Phase
- ✅ Po strategických rozhodnutiach

---

## ✅ KRITÉRIÁ ÚSPECHU

### Phase 1 Complete:
- ✅ Cleanup projekt (Task 1.6)
- ✅ Python Btrieve setup (Task 1.7)
- ✅ Databázová schéma zdokumentovaná (Task 1.8)
- ✅ Python record layouts vytvorené (Task 1.9)
- ✅ ISDOC mapping kompletný (Task 1.10)

### MVP (Minimum Viable Product):
- ✅ BtrieveClient wrapper funguje
- ✅ ProductService - check/add products
- ✅ WarehouseService - create receipt
- ✅ Integration s supplier_invoice_loader
- ✅ End-to-end test s reálnym ISDOC XML

### V1.0 Production Ready:
- ✅ Všetky services implementované
- ✅ Kompletný error handling
- ✅ Logging a monitoring
- ✅ Unit tests (>80% coverage)
- ✅ Integration tests
- ✅ Production deployment
- ✅ User dokumentácia

---

## 📞 KONTAKT

- **Vývojár:** ICC (rausch@icc.sk)
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server
- **Lokálna Cesta:** c:\Development\nex-genesis-server
- **Súvisiaci Projekt:** supplier_invoice_loader

---

## 🔗 SÚVISIACE PROJEKTY

### supplier_invoice_loader
- **URL:** https://github.com/rauschiccsk/supplier_invoice_loader
- **Účel:** Generuje ISDOC XML z PDF faktúr
- **Integrácia:** Rozšírenie o NEX Genesis import endpoint

### NEX Genesis ERP
- **Jazyk:** Delphi 6
- **Databáza:** Pervasive Btrieve (file-based)
- **Lokácia:** Customer server (MAGERSTAV)

---

## 📝 ĎALŠIE KROKY

### Ihneď (Tento týždeň):
1. ✅ Cleanup projekt (Task 1.6)
2. Setup Python Btrieve environment (Task 1.7)
3. Parsovať .bdf súbory (Task 1.8)
4. Vytvoriť Python record layouts (Task 1.9)

### Krátkodoba (Budúci 2 týždne):
1. Implementovať BtrieveClient wrapper
2. Vytvoriť ProductService
3. Vytvoriť WarehouseService
4. Testovať s sample ISDOC XML

### Dlhodobé (Budúci mesiac):
1. Dokončiť všetky services
2. Integrovať so supplier_invoice_loader
3. End-to-end testing
4. Production deployment

---

## 🤖 FINAL REMINDER FOR CLAUDE

**You have loaded FULL_PROJECT_CONTEXT.md**

This document contains **EVERYTHING:**
- ✅ Complete project vision and goals
- ✅ **Current status, progress, and active tasks** (AKTUÁLNY STAV section)
- ✅ Full Python Btrieve architecture
- ✅ All 4 phases and development plan
- ✅ Project structure
- ✅ Git workflow and commit conventions
- ✅ Technical decisions and rationale

**Simply respond:**
```
✅ Projekt načítaný. Čo robíme?
```

**WORKFLOW REMINDER:**
```
After creating ANY new file in the project:
⚠️ Remind user: "Nezabudni updatnúť FULL_PROJECT_CONTEXT.md (sekcia AKTUÁLNY STAV)"

After completing any task:
⚠️ Update task status in this document

This ensures single-file context always stays current.
```

---

**Verzia Dokumentu:** 0.2.0  
**Vytvorené:** 2025-10-21  
**Posledná Aktualizácia:** 2025-10-21  
**Stav:** Aktívny Vývoj - Phase 1 - Pure Python Btrieve Strategy

🐍 **Vytvárame Python Btrieve mikroslužby! Jeden súbor = kompletný kontext.** ✨