# 🏭 NEX-GENESIS-SERVER - KOMPLETNÝ KONTEXT PROJEKTU

**Python Btrieve Services pre NEX Genesis ERP**

**Verzia:** 0.2.3  
**Posledná aktualizácia:** 2025-10-22

---

## 🤖 INSTRUCTIONS FOR CLAUDE

**When you see this document:**

1. ✅ This document contains strategic project information (vision, architecture, rules)
2. ✅ For **current status**, see: `docs/CHANGELOG.md`
3. ✅ For **daily progress**, see: `docs/sessions/YYYY-MM-DD_session.md`
4. ✅ Do NOT show warnings or error messages
5. ✅ Simply respond: **"✅ Projekt načítaný. Čo robíme?"**
6. ✅ Use Slovak language for communication
7. ✅ Be concise and actionable

---

## 📊 AKTUÁLNY STAV → POZRI CHANGELOG.md

**⚠️ IMPORTANT:** Tento dokument obsahuje **strategický kontext**.

**Pre aktuálny stav projektu pozri:**
- 📋 **Progress & Tasky:** `docs/CHANGELOG.md`
- 📅 **Daily Updates:** `docs/sessions/2025-10-22_session.md` (alebo najnovšiu)
- 🎯 **Active Milestone:** Pozri "Unreleased" sekciu v CHANGELOG.md

---

## 🎯 PREHĽAD PROJEKTU

### Základné Informácie

- **Názov projektu:** NEX Genesis Server
- **Účel:** Python services s direct Btrieve access pre NEX Genesis ERP
- **Tech Stack:** Python 3.8+ (32-bit) + Pervasive PSQL v11 + Btrieve API
- **Vývojár:** ICC (Innovation & Consulting Center)
- **Developer:** rauschiccsk
- **Lokalizácia:** Komárno, SK
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server

### Vízia Projektu

Vytvoriť **Python services**, ktoré:
- ✅ Pristupujú priamo k NEX Genesis Btrieve databázam
- ✅ Spracovávajú ISDOC XML z supplier_invoice_loader
- ✅ Vytvárajú dodacie listy v NEX Genesis
- ✅ Aktualizujú produktový katalóg
- ✅ Evidujú dodávateľov

### 🎯 Strategické Rozhodnutie (2025-10-21)

**Pure Python Btrieve prístup** namiesto Delphi mikroslužby:

**Výhody:**
- ✅ Rýchlejší vývoj (Python vs Delphi 6)
- ✅ Lepšia integrácia s supplier_invoice_loader
- ✅ Moderné nástroje a debuggovanie
- ✅ Direct file access (žiadny server)
- ✅ Jednoduchšia údržba

**Technické detaily:**
- Python 3.8+ (32-bit) s ctypes pre Btrieve API
- Direct prístup k .BTR súborom
- Využitie existujúcich .bdf schém
- Pervasive PSQL v11 SDK

### Problém
- **supplier_invoice_loader** generuje ISDOC XML z PDF faktúr
- **NEX Genesis ERP** potrebuje importovať tieto dáta
- Neexistujú API endpointy pre:
  - Pridanie produktov do katalógu
  - Vytvorenie dodacích listov
- Potrebujeme **priamy prístup** k Btrieve databázam

### Riešenie
**NEX Genesis Server** - Python services s Btrieve API, ktoré:
- ✅ Prijímajú ISDOC XML súbory
- ✅ Kontrolujú/pridávajú produkty do katalógu (GSCAT)
- ✅ Vytvárajú dodacie listy (TSH/TSI)
- ✅ Evidujú dodávateľov (PAB)
- ✅ Spracovávajú čiarové kódy (BARCODE)
- ✅ Pristupujú priamo k Pervasive databázam

### Workflow
```
supplier_invoice_loader (Python/FastAPI)
    ↓
ISDOC XML
    ↓
Python Btrieve Services
    ↓
1. Check/Add Products (GSCAT)
2. Check/Add Barcodes (BARCODE)
3. Create Delivery Note (TSH/TSI)
    ↓
NEX Genesis Database (Pervasive)
    ↓ (real-time)
NEX Genesis ERP (Delphi 6)
```

---

## 🗂️ ARCHITEKTÚRA SYSTÉMU

### Tech Stack
```yaml
Jazyk: Python 3.8+ (32-bit required!)
Databáza: Pervasive PSQL v11 (Btrieve)
DB Access: Direct Btrieve API (ctypes)
HTTP Server: FastAPI / Flask
XML Parser: lxml / xml.etree
Konfigurácia: YAML
Testovanie: pytest
IDE Python: PyCharm
Git: PyCharm integrated Git
SDK: Pervasive PSQL v11
```

### Závislosti
- **Pervasive PSQL v11** - Btrieve engine
- **ctypes** - Direct DLL calls
- **lxml** - XML parsing
- **FastAPI/Flask** - HTTP server
- **pydantic** - Data validation
- **pytest** - Testing
- **PyYAML** - Configuration

### Architektúra
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

### Services Architektúra

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
│  ├─ btrieve_client.py (Wrapper) ✅
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

## 🗄️ NEX GENESIS DATABÁZOVÁ SCHÉMA

**⚠️ KRITICKY DÔLEŽITÉ!**

Máme **reálne .bdf súbory** z NEX Genesis v `database-schema/`.

### 📁 Database Schema Files

```
database-schema/
├─ barcode.bdf    # Čiarové kódy produktov
├─ gscat.bdf      # Produktový katalóg (master)
├─ mglst.bdf      # Tovarové skupiny
├─ pab.bdf        # Obchodní partneri (dodávatelia)
├─ tsh.bdf        # Dodacie listy (header)
├─ tsi.bdf        # Dodacie listy (items)
└─ README.md      # Dokumentácia schém
```

### Tabuľky a Vzťahy

```
MGLST (Tovarové skupiny)
  ↓ 1:N
GSCAT (Produktový katalóg)
  ↓ 1:N
BARCODE (Čiarové kódy)

PAB (Dodávatelia)
  ↓ 1:N
TSH (Dodacie listy - header)
  ↓ 1:N
TSI (Dodacie listy - items)
  → N:1
GSCAT (Produkty)
```

### Database Location
```
C:\NEX\YEARACT\
├─ STORES\              # Skladové hospodárstvo
│  ├─ GSCAT.BTR         # Produktový katalóg
│  ├─ BARCODE.BTR       # Čiarové kódy
│  ├─ MGLST.BTR         # Tovarové skupiny
│  ├─ TSHA-001.BTR      # Dodacie listy header
│  └─ TSIA-001.BTR      # Dodacie listy items
└─ DIALS\               # Číselníky
   └─ PAB00000.BTR      # Obchodní partneri
```

**Pre detailné schémy pozri:** `docs/NEX_DATABASE_STRUCTURE.md`

---

## 📁 ŠTRUKTÚRA PROJEKTU

```
c:\Development\nex-genesis-server/
│
├─ docs/                                    
│  ├─ FULL_PROJECT_CONTEXT.md            # Tento súbor
│  ├─ CHANGELOG.md                        ⭐ Aktuálny stav!
│  ├─ INIT_CONTEXT.md                     # Quick start
│  ├─ NEX_DATABASE_STRUCTURE.md          # DB schéma
│  ├─ TESTING_GUIDE.md                    # Testing procedures
│  ├─ sessions/
│  │  └─ 2025-10-22_session.md           ⭐ Daily progress!
│  └─ architecture/
│     └─ database-access-pattern.md       # Btrieve patterns
│
├─ database-schema/                       
│  ├─ *.bdf                               # 6 real schema files
│  └─ README.md                           
│
├─ delphi-sources/                        # Reference
│  ├─ *.pas                               # 7 Delphi Btrieve wrappers
│  └─ README.md                           
│
├─ external-dlls/                         # Pervasive DLLs
│  └─ README.md                           
│
├─ src/
│  ├─ btrieve/                            ✅ WORKING!
│  │  ├─ __init__.py
│  │  └─ btrieve_client.py                # Main wrapper
│  │
│  ├─ services/                           # Business logic (TBD)
│  ├─ parsers/                            # XML/ISDOC (TBD)
│  ├─ api/                                # FastAPI (TBD)
│  └─ utils/
│     ├─ __init__.py
│     └─ config.py                        ✅ WORKING!
│
├─ tests/                                 ✅ ALL PASSING!
│  ├─ test_btrieve_basic.py
│  ├─ test_btrieve_file.py
│  ├─ test_btrieve_read.py
│  └─ test_file_opening_variants.py
│
├─ config/
│  └─ database.yaml                       ✅ CONFIGURED!
│
├─ scripts/                                 
│  ├─ generate_project_access.py         
│  └─ create_directory_structure.py
│
├─ .gitignore
├─ README.md
├─ requirements.txt
└─ requirements-minimal.txt
```

---

## 📋 PROJECT FILE ACCESS MANIFESTS

**Problém:** Jeden veľký JSON súbor spôsobuje token limit problémy.  
**Riešenie:** Rozdelené manifesty na špecifické účely.

### Štruktúra Manifestov

```
docs/
├─ project_file_access.json              # ⭐ Unified manifest (všetko)
├─ project_file_access_docs.json         # 📚 Documentation only
├─ project_file_access_bdf.json          # 🗄️ Database schemas
└─ project_file_access_delphi.json       # 🔧 Delphi reference
```

### Použitie

**Pre nový chat s Claude:**
```
1. Pošli URL:
   https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/INIT_CONTEXT.md

2. Alebo pošli:
   https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

3. Claude automaticky načíta CHANGELOG.md a sessions/ pre aktuálny stav
```

### Kedy Refresh Manifesty

⚠️ **VŽDY po:**
- Pridaní nového súboru do projektu
- Na konci každej session

```powershell
python scripts/generate_project_access.py
git add docs/project_file_access*.json
git commit -m "chore: refresh project manifests"
```

---

## 📌 API ENDPOINTS (Plánované)

### 1. Import Invoice (Hlavná funkcia)
```http
POST /api/invoice/import
Content-Type: application/xml

<ISDOC XML content>

Response:
{
  "success": true,
  "deliveryNoteNumber": "DL-2025-0001",
  "productsAdded": 3,
  "itemsCreated": 5,
  "message": "Dodací list vytvorený úspešne"
}
```

### 2. Health Check
```http
GET /api/health

Response:
{
  "status": "ok",
  "database": "connected",
  "version": "0.2.3"
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
  "gsCode": 12345,
  "name": "Produkt XYZ"
}
```

---

## 📄 ISDOC XML → NEX Genesis Mapping

### Invoice Header Mapping (TBD - Task 1.10)
```xml
<Invoice>
  <ID>                     → SupplierInvoiceNumber
  <IssueDate>              → TSH.DocDate
  <DocumentCurrencyCode>   → (validácia: musí byť EUR)
  
  <AccountingSupplierParty>
    <Party>
      <PartyIdentification>
        <ID>               → PAB lookup by ICO
      </PartyIdentification>
      <PartyName>
        <Name>             → PAB.Name
      </PartyName>
    </Party>
  </AccountingSupplierParty>
```

### Invoice Lines Mapping (TBD - Task 1.10)
```xml
<InvoiceLine>
  <ID>                     → TSI.LineNumber
  <InvoicedQuantity>       → TSI.Quantity
  <LineExtensionAmount>    → TSI.Amount
  <Item>
    <Name>                 → GSCAT.Name
    <SellersItemIdentification>
      <ID>                 → BARCODE.BarCode
    </SellersItemIdentification>
  </Item>
  <Price>
    <PriceAmount>          → TSI.Price
  </Price>
</InvoiceLine>
```

---

## 🔧 KONFIGURÁCIA

### database.yaml (Current)
```yaml
nex_genesis:
  root_path: "C:\\NEX"
  yearact_path: "C:\\NEX\\YEARACT"
  
  database:
    stores_path: "C:\\NEX\\YEARACT\\STORES"
    dials_path: "C:\\NEX\\YEARACT\\DIALS"
  
  tables:
    gscat: "C:\\NEX\\YEARACT\\STORES\\GSCAT.BTR"
    barcode: "C:\\NEX\\YEARACT\\STORES\\BARCODE.BTR"
    mglst: "C:\\NEX\\YEARACT\\STORES\\MGLST.BTR"
    pab: "C:\\NEX\\YEARACT\\DIALS\\PAB00000.BTR"
    tsh: "C:\\NEX\\YEARACT\\STORES\\TSHA-{book_number}.BTR"
    tsi: "C:\\NEX\\YEARACT\\STORES\\TSIA-{book_number}.BTR"

btrieve:
  dll_path: "C:\\Program Files (x86)\\Pervasive Software\\PSQL\\bin"

logging:
  enabled: true
  level: "INFO"
  path: "C:\\Logs\\NEXGenesisServer"
```

---

## ⚠️ KRITICKÉ PRIPOMIENKY

### Pre každý nový chat:
1. 🔥 Používateľ pošle URL na INIT_CONTEXT.md alebo FULL_PROJECT_CONTEXT.md
2. 🔥 Claude načíta dokument
3. 🔥 Claude automaticky načíta CHANGELOG.md pre aktuálny stav
4. 🔥 Claude odpovie: "✅ Projekt načítaný. Čo robíme?"
5. 🔥 ŽIADNE ďalšie súbory na začiatku
6. 🔥 KOMUNIKUJ PO SLOVENSKY

### Git pravidlá:
- ✅ Commit často, malé zmeny
- ✅ Opisné commit správy
- ✅ Test pred commitom
- ✅ Pull pred push

### Development Environment:
- **IDE:** PyCharm
- **Python:** 3.8+ (32-bit required!)
- **Git:** Commit a push z PyCharm
- **Venv:** venv32 (32-bit Python)

### Kódovacie štandardy:
- ✅ PEP 8 (Python style guide)
- ✅ Type hints (typing module)
- ✅ Docstrings (Google style)
- ✅ Komentáre v slovenčine pre business logiku
- ✅ Angličtina pre technické komentáre
- ✅ Proper error handling (try..except..finally)
- ✅ Unit tests pre všetky funkcie
- ✅ VŽDY validuj vstupné dáta

### 🚨 BTRIEVE ACCESS PRAVIDLÁ:

**CRITICAL - Based on Delphi btrapi32.pas Analysis:**

#### BTRCALL Signature (FIXED v0.2.3):
```python
btrcall.argtypes = [
    ctypes.c_uint16,                 # operation (WORD)
    ctypes.POINTER(ctypes.c_char),   # posBlock
    ctypes.POINTER(ctypes.c_char),   # dataBuffer
    ctypes.POINTER(ctypes.c_uint32), # dataLen (longInt = 4 bytes!) ⚠️
    ctypes.POINTER(ctypes.c_char),   # keyBuffer
    ctypes.c_uint8,                  # keyLen (BYTE)
    ctypes.c_uint8                   # keyNum (BYTE, unsigned!) ⚠️
]
```

#### Open File Logic (FIXED v0.2.3):
```python
# FILENAME goes in KEY_BUFFER! (not data_buffer!)
data_buffer = ctypes.create_string_buffer(256)  # EMPTY!
data_len = ctypes.c_uint32(0)                   # ZERO!
filename_bytes = filename.encode('ascii') + b'\x00'
key_buffer = ctypes.create_string_buffer(filename_bytes)  # FILENAME HERE!
key_len = 255                                   # Always 255!
```

#### Best Practices:
- ✅ **VŽDY používaj BtrieveClient wrapper**
- ✅ **VŽDY validuj record layout pred write**
- ✅ **VŽDY používaj index pre search**
- ✅ **VŽDY close file po operácii**
- ✅ **VŽDY handle Btrieve errors gracefully**
- ✅ **VŽDY log všetky DB operácie**
- ❌ **NIKDY nepristupuj k .BTR súborom priamo** - používaj wrapper!

### 🗄️ PROJECT_FILE_ACCESS MANIFESTS REFRESH:
- ✅ **KEĎ VYTVORÍŠ NOVÝ SÚBOR → Vždy pripomeň refresh manifestov**
- ✅ Na konci každej session
- ✅ Jednoduchá pripomienka: **"⚠️ Nezabudni refreshnúť project manifests: `python scripts/generate_project_access.py`"**

---

## ✅ KRITÉRIÁ ÚSPECHU

### Phase 1 Complete (Current):
- ✅ NEX Genesis .bdf schémy na GitHub
- ✅ Btrieve wrappery (reference)
- ✅ Pervasive DLLs pripravené
- ✅ Python Btrieve wrapper funkčný ⭐
- ✅ File operations working (open, read, close) ⭐
- ✅ Data reading verified ⭐
- 📋 Databázová schéma zdokumentovaná (Next - Task 1.8)
- 📋 Python record layouts vytvorené (Next - Task 1.9)
- 📋 ISDOC mapping špecifikované (Next - Task 1.10)

### MVP (Minimum Viable Product):
- ✅ Jeden endpoint: POST /api/invoice/import
- ✅ Parsuje ISDOC XML
- ✅ Vytvára produkty ak chýbajú (GSCAT)
- ✅ Vytvára dodacie listy (TSH/TSI)
- ✅ Funguje s reálnou NEX databázou
- ✅ Základný error handling

### V1.0 Production Ready:
- ✅ Všetky plánované endpointy
- ✅ Kompletný error handling
- ✅ Logging a monitoring
- ✅ Integrácia so supplier_invoice_loader
- ✅ Backup stratégia
- ✅ Dokumentácia kompletná

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
- **Integrácia:** Posiela XML na NEX Genesis Server

### NEX Genesis ERP
- **Jazyk:** Delphi 6
- **Databáza:** Pervasive PSQL v11 (Btrieve)
- **Lokácia:** Customer server (MAGERSTAV)

---

## 🤖 FINAL REMINDER FOR CLAUDE

**You have loaded FULL_PROJECT_CONTEXT.md**

This document contains **STRATEGIC INFORMATION:**
- ✅ Complete project vision and goals
- ✅ Full architecture and tech stack
- ✅ NEX Genesis database schema (basic info)
- ✅ Btrieve access rules and patterns (CRITICAL!)
- ✅ Project structure
- ✅ Git workflow and coding standards

**For CURRENT STATUS, see:**
- 📋 **CHANGELOG.md** - Progress, versions, completed tasks
- 📅 **docs/sessions/** - Daily progress and notes

**Simply respond:**
```
✅ Projekt načítaný. Čo robíme?
```

**BTRIEVE ACCESS REMINDER:**
```
Critical fixes in v0.2.3:
✅ dataLen: c_uint32 (4 bytes, not 2!)
✅ keyNum: c_uint8 (unsigned, not signed!)
✅ Filename in KEY_BUFFER (not data_buffer!)
✅ data_buffer EMPTY for open (dataLen = 0)
✅ keyLen = 255 always

When working with Btrieve:
✅ Use BtrieveClient wrapper
✅ Validate record layout
✅ Use indexes for search
✅ Close files after operations
✅ Handle errors gracefully
✅ Log all DB operations
❌ NO direct .BTR file access!
```

**WORKFLOW REMINDER:**
```
After creating ANY new file:
⚠️ "Nezabudni refreshnúť project manifests: python scripts/generate_project_access.py"

After completing any task:
⚠️ "Nezabudni updatnúť CHANGELOG.md"
⚠️ "Nezabudni updatnúť session notes"
```

---

**Verzia Dokumentu:** 0.2.3  
**Vytvorené:** 2025-10-21  
**Posledná Aktualizácia:** 2025-10-22 (Cleaned - Removed outdated status tracking)  

🏭 **Python Btrieve services - Strategický kontext.** ✨

**Pre aktuálny stav → CHANGELOG.md | Pre daily progress → docs/sessions/**