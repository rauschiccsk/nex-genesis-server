# 🏭 NEX-GENESIS-SERVER - KOMPLETNÝ KONTEXT PROJEKTU

**Python Btrieve Services pre NEX Genesis ERP**

**Posledná aktualizácia:** 2025-10-21  
**Verzia:** 0.2.0  
**Stav:** Počiatočné Plánovanie

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
**Aktuálna Fáza:** Počiatočné Plánovanie

### Prehľad
- **Aktívna Fáza:** Phase 1 - Setup & Stratégia
- **Progress Phase 1:** 60% (6/10 taskov)
- **Celkový Progress:** 15% (Phase 1 aktívna)
- **Aktívny Task:** Task 1.7 - Python Btrieve Setup
- **Ďalší Milestone:** Phase 1 Complete (2025-10-28)

### Phase Progress
```
Phase 1: Setup & Stratégia    [████████████░░░░░░░░] 60%
Phase 2: Core Development     [░░░░░░░░░░░░░░░░░░░░]  0%
Phase 3: Integration          [░░░░░░░░░░░░░░░░░░░░]  0%
Phase 4: Testing & Deploy     [░░░░░░░░░░░░░░░░░░░░]  0%
```

### Velocity
- **Tasks hotové tento týždeň:** 6
- **Priemerný čas na task:** ~45 minút
- **Produktivita:** Vysoká 🚀
- **Odhadované dokončenie Phase 1:** 2025-10-28

---

## 🎯 PREHĽAD PROJEKTU

### Základné Informácie

- **Názov projektu:** NEX Genesis Server
- **Účel:** Python services s direct Btrieve access pre NEX Genesis ERP
- **Tech Stack:** Python 3.8+ + Btrieve 2 API
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
- Python 3.8+ s ctypes/SWIG pre Btrieve API
- Direct prístup k .dat súborom
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
**NEX Genesis Server** - Python services s Btrieve 2 API, ktoré:
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

### Inšpirácia
- **supplier_invoice_loader** - Python FastAPI integrácia
- **project-generator** - Dokumentačná štruktúra (single-file context)
- **NEX Genesis** - Existujúce Btrieve patterns

---

## 🗂️ ARCHITEKTÚRA SYSTÉMU

### Tech Stack
```yaml
Jazyk: Python 3.8+
Databáza: Pervasive SQL (Btrieve)
DB Access: Direct Btrieve 2 API (ctypes/SWIG)
HTTP Server: FastAPI / Flask
XML Parser: lxml / xml.etree
Konfigurácia: YAML / ENV files
Testovanie: pytest
IDE Python: PyCharm
Git: PyCharm integrated Git
SDK: Pervasive PSQL v11 SDK
Build Tool: SWIG (pre C wrappers)
```

### Závislosti
- **Pervasive PSQL v11 SDK** - Btrieve 2 API
- **SWIG** - Wrapper generator (C → Python)
- **ctypes** - Direct DLL calls
- **lxml** - XML parsing
- **FastAPI/Flask** - HTTP server
- **pydantic** - Data validation
- **pytest** - Testing

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
               │ Btrieve 2 API
               │ Direct file access
               ▼
┌─────────────────────────────────────┐
│  NEX Genesis Database               │
│  (Pervasive Btrieve)                │
│                                     │
│  ├─ GSCAT.dat  (Produkty)           │
│  ├─ BARCODE.dat (Čiarové kódy)      │
│  ├─ MGLST.dat  (Skupiny)            │
│  ├─ PAB.dat    (Partneri)           │
│  ├─ TSH.dat    (Dodacie listy hdr)  │
│  └─ TSI.dat    (Dodacie listy itm)  │
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
│  ├─ btrieve_client.py (Wrapper)
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
  ↑ N:1
GSCAT (Produkty)
```

### Tabuľka: GSCAT (Produktový katalóg)

```python
# Z gscat.bdf
class GSCATRecord:
    GsCode: int          # PRIMARY KEY - Tovarové číslo
    Name: str(50)        # Názov produktu
    MglstCode: int       # FK → MGLST (skupina)
    Unit: str(10)        # Merná jednotka
    Price: Decimal       # Predajná cena
    PurchasePrice: Decimal  # Nákupná cena
    VatRate: Decimal     # Sadzba DPH
    Active: bool         # Aktívny produkt
    ModUser: str(8)      # Audit - používateľ
    ModDate: date        # Audit - dátum
    ModTime: time        # Audit - čas
```

### Tabuľka: BARCODE (Čiarové kódy)

```python
# Z barcode.bdf
class BARCODERecord:
    GsCode: int          # FK → GSCAT
    BarCode: str(15)     # PRIMARY KEY - EAN/Code128/QR
    ModUser: str(8)      # Audit
    ModDate: date        # Audit
    ModTime: time        # Audit
```

**Indexy:**
- `ixGsCode`: GsCode (vyhľadávanie podľa produktu)
- `ixBarCode`: BarCode (vyhľadávanie podľa čiarového kódu)
- `ixGsBc`: GsCode + BarCode (unique constraint)

### Tabuľka: TSH (Dodacie listy - header)

```python
# Z tsh.bdf
class TSHRecord:
    DocNumber: str(20)   # PRIMARY KEY - Číslo dokladu
    DocDate: date        # Dátum dokladu
    PabCode: int         # FK → PAB (dodávateľ)
    TotalAmount: Decimal # Celková suma
    VatAmount: Decimal   # Suma DPH
    Currency: str(3)     # Mena (EUR)
    Note: str(255)       # Poznámka
    ModUser: str(8)      # Audit
    ModDate: date        # Audit
    ModTime: time        # Audit
```

### Tabuľka: TSI (Dodacie listy - items)

```python
# Z tsi.bdf
class TSIRecord:
    DocNumber: str(20)   # FK → TSH
    LineNumber: int      # Poradové číslo riadku
    GsCode: int          # FK → GSCAT
    Quantity: Decimal    # Množstvo
    Price: Decimal       # Jednotková cena
    VatRate: Decimal     # Sadzba DPH
    Amount: Decimal      # Suma bez DPH
    VatAmount: Decimal   # Suma DPH
    TotalAmount: Decimal # Suma s DPH
```

**Composite PK:** DocNumber + LineNumber

### Tabuľka: PAB (Obchodní partneri)

```python
# Z pab.bdf
class PABRecord:
    PabCode: int         # PRIMARY KEY - Kód partnera
    Name: str(100)       # Názov firmy
    ICO: str(12)         # IČO
    DIC: str(12)         # DIČ
    Street: str(100)     # Ulica
    City: str(50)        # Mesto
    PostalCode: str(10)  # PSČ
    Country: str(3)      # Krajina (SK)
    IsSupplier: bool     # Je dodávateľ
    IsCustomer: bool     # Je odberateľ
    ModUser: str(8)      # Audit
    ModDate: date        # Audit
    ModTime: time        # Audit
```

### Tabuľka: MGLST (Tovarové skupiny)

```python
# Z mglst.bdf
class MGLSTRecord:
    MglstCode: int       # PRIMARY KEY - Kód skupiny
    Name: str(50)        # Názov skupiny
    ParentCode: int      # FK → MGLST (hierarchia)
    Level: int           # Úroveň v hierarchii
    Active: bool         # Aktívna skupina
```

---

## 📁 ŠTRUKTÚRA PROJEKTU

```
c:\Development\nex-genesis-server/
│
├─ docs/                                    
│  ├─ FULL_PROJECT_CONTEXT.md            # Tento súbor
│  ├─ CHANGELOG.md                        # Version history
│  ├─ README.md                           # Manifest dokumentácia
│  └─ architecture/
│     ├─ btrieve-access.md               # Btrieve API usage
│     ├─ database-schema.md              # TBD
│     └─ isdoc-mapping.md                # TBD
│
├─ database-schema/                       # ⭐ NEW
│  ├─ barcode.bdf                        # Čiarové kódy
│  ├─ gscat.bdf                          # Produktový katalóg
│  ├─ mglst.bdf                          # Tovarové skupiny
│  ├─ pab.bdf                            # Obchodní partneri
│  ├─ tsh.bdf                            # Dodacie listy header
│  ├─ tsi.bdf                            # Dodacie listy items
│  └─ README.md                          # Dokumentácia
│
├─ delphi-sources/                        # Reference ⭐ NEW
│  ├─ BtrApi32.pas                       # Btrieve API
│  ├─ BtrConst.pas                       # Constants
│  ├─ BtrHand.pas                        # Handler
│  ├─ BtrStruct.pas                      # Structures
│  ├─ BtrTable.pas                       # Table wrapper
│  ├─ BtrTools.pas                       # Utilities
│  ├─ SqlApi32.pas                       # SQL API
│  └─ README.md                          # Dokumentácia
│
├─ external-dlls/                         # ⭐ NEW
│  ├─ wdbnames.dll                       # Pervasive
│  ├─ wdbnm32.dll                        # Pervasive
│  ├─ wssql32.dll                        # Pervasive
│  ├─ wxqlcall.dll                       # Pervasive
│  └─ README.md                          # Dokumentácia
│
├─ src/
│  ├─ btrieve/                           # Btrieve wrapper
│  │  ├─ __init__.py
│  │  ├─ btrieve_client.py               # Main wrapper
│  │  ├─ record_layouts.py               # Python structs
│  │  └─ operations.py                   # CRUD operations
│  │
│  ├─ services/                          # Business logic
│  │  ├─ __init__.py
│  │  ├─ product_service.py              # GSCAT operations
│  │  ├─ barcode_service.py              # BARCODE operations
│  │  ├─ delivery_note_service.py        # TSH/TSI operations
│  │  └─ supplier_service.py             # PAB operations
│  │
│  ├─ parsers/                           # XML/ISDOC
│  │  ├─ __init__.py
│  │  ├─ isdoc_parser.py
│  │  └─ xml_validator.py
│  │
│  ├─ api/                               # FastAPI/Flask
│  │  ├─ __init__.py
│  │  ├─ main.py
│  │  └─ endpoints.py
│  │
│  └─ utils/
│     ├─ __init__.py
│     ├─ config.py
│     └─ logger.py
│
├─ tests/                                # Test data
│  ├─ test_btrieve_client.py
│  ├─ test_product_service.py
│  ├─ test_isdoc_parser.py
│  ├─ fixtures/
│  │  └─ sample_isdoc.xml
│  └─ data/
│     └─ test_records.json
│
├─ config/                                  
│  ├─ config.yaml.template
│  └─ database.yaml.template
│
├─ scripts/                                 
│  ├─ generate_project_access.py         # Manifest generator
│  ├─ generate_bdf_manifest.py           # BDF helper
│  └─ create_directory_structure.py
│
├─ .gitignore
├─ README.md
├─ CHANGELOG.md
├─ requirements.txt                      # Python deps
└─ setup.py                              # Package setup
```

---

## 📋 PROJECT FILE ACCESS MANIFESTS

**Problém:** Jeden veľký JSON súbor (20k+ riadkov) spôsobuje token limit problémy.  
**Riešenie:** Rozdelené manifesty na špecifické účely.

### Štruktúra Manifestov

```
docs/
├─ project_file_access_docs.json      # 📚 Documentation
├─ project_file_access_bdf.json       # 🗄️ Database schemas
└─ project_file_access_delphi.json    # 🔧 Delphi reference
```

### Použitie

#### 1️⃣ Pre Claude (Dokumentácia) - DEFAULT
```
URL: https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_docs.json

Obsahuje:
- docs/ (všetka dokumentácia)
- FULL_PROJECT_CONTEXT.md
- CHANGELOG.md
- architecture/ dokumenty

Veľkosť: ~100 riadkov
Use case: Default pre prácu s Claude na projektovej dokumentácii
```

#### 2️⃣ Pre Database Schema (BDF súbory)
```
URL: https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_bdf.json

Obsahuje:
- database-schema/ (všetky .bdf súbory)
- Databázové schémy
- README s dokumentáciou

Veľkosť: ~50 riadkov
Use case: Keď Claude potrebuje analyzovať databázovú schému
```

#### 3️⃣ Pre Delphi Reference
```
URL: https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_delphi.json

Obsahuje:
- delphi-sources/ (Btrieve wrappery)
- BtrTable.pas, BtrApi32.pas, atď.

Veľkosť: ~70 riadkov
Use case: Keď Claude potrebuje referenciu Delphi Btrieve patterns
```

### Generovanie Manifestov

```powershell
# Generuj všetky manifesty naraz
python scripts/generate_project_access.py

# Output:
# ✅ project_file_access_docs.json    (~100 riadkov)
# ✅ project_file_access_bdf.json     (~50 riadkov)
# ✅ project_file_access_delphi.json  (~70 riadkov)
```

### Workflow Pre Nový Chat s Claude

#### Variant A: Len Dokumentácia (Odporúčané) ⭐
```
1. Pošli Claude URL:
   https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

2. Ak potrebuje konkrétne súbory, pošli aj:
   https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_docs.json
```

#### Variant B: + Database Schema
```
1. FULL_PROJECT_CONTEXT.md (ako vyššie)
2. project_file_access_docs.json (dokumentácia)
3. project_file_access_bdf.json (len keď analyzuješ schému)
```

#### Variant C: + Delphi Reference
```
1. FULL_PROJECT_CONTEXT.md
2. project_file_access_docs.json
3. project_file_access_delphi.json (len keď potrebuješ Btrieve patterns)
```

### Výhody Rozdeleného Prístupu

✅ **Menšie súbory** - Každý manifest má < 500 riadkov  
✅ **Rýchlejšie načítanie** - Claude načíta len potrebné súbory  
✅ **Nižšia spotreba tokenov** - Nemusíš načítať celý projekt  
✅ **Lepšia organizácia** - Jasné rozdelenie podľa účelu  
✅ **Škálovateľné** - Pridaj nové manifesty podľa potreby  

### Kedy Refresh Manifesty

⚠️ **VŽDY po:**
- Pridaní nového dokumentu do docs/
- Pridaní novej .bdf schémy do database-schema/
- Pridaní Delphi reference do delphi-sources/
- Na konci každej session

```powershell
python scripts/generate_project_access.py
git add docs/project_file_access_*.json
git commit -m "chore: refresh project file access manifests"
```

---

**Kompletná príručka:** `docs/README.md`

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
- ✅ Základné súbory (.gitignore, README.md, requirements.txt)

#### ✅ Task 1.2 - Dokumentácia setup (2025-10-21)
**Status:** HOTOVO  
**Trvanie:** ~1h  

**Vytvorené:**
- ✅ `docs/FULL_PROJECT_CONTEXT.md` - Tento súbor
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
- ✅ Force push na GitHub
- ✅ Repository live

#### ✅ Task 1.5 - Databázový prístup dokumentácia (2025-10-21)
**Status:** HOTOVO  
**Trvanie:** ~2h  

**Vytvorené:**
- ✅ Komplexná analýza NEX Genesis Btrieve patterns
- ✅ 5-vrstvová architektúra zdokumentovaná
- ✅ Design patterns identifikované
- ✅ Best practices definované
- ✅ Split manifests implementované

**Kľúčové Poznatky:**
- NEX Genesis používa vlastný wrapper pattern pre Pervasive SQL
- Type-safe properties namiesto FieldByName()
- Automatické prepínanie indexov cez Locate methods
- Rozdelené manifesty riešia token limit problémy

#### ✅ Task 1.6 - Cleanup a reorganizácia (2025-10-21)
**Status:** HOTOVO  
**Completed:** 2025-10-21  
**Time spent:** 3 hodiny

**Dokončené:**
- ✅ Pridané **reálne .bdf súbory** z NEX Genesis
  - barcode.bdf, gscat.bdf, mglst.bdf, pab.bdf, tsh.bdf, tsi.bdf
- ✅ Pridané **NEX Genesis Btrieve wrappery**
  - BtrApi32.pas, BtrConst.pas, BtrHand.pas, BtrStruct.pas, BtrTable.pas, BtrTools.pas, SqlApi32.pas
- ✅ Pridané **Pervasive DLLs**
  - wdbnames.dll, wdbnm32.dll, wssql32.dll, wxqlcall.dll
- ✅ Vytvorené **README súbory**
  - database-schema/README.md
  - delphi-sources/README.md
  - external-dlls/README.md
  - docs/README.md
- ✅ Vytvorený **CHANGELOG.md** (version tracking)
- ✅ Nové **JSON manifesty**
  - project_file_access_delphi.json
  - project_file_access_bdf.json
  - project_file_access_docs.json
- ✅ Aktualizovaný **generate_project_access.py** (multi-extension support)
- ✅ Pridaný **generate_bdf_manifest.py** (helper script)
- ✅ Aktualizovaný **FULL_PROJECT_CONTEXT.md** na v0.2.0
- ✅ Aktualizovaný **README.md** (Python focus)
- ✅ Aktualizovaný **.gitignore** (Python specific)

**Strategické rozhodnutie:**
- 🎯 Pivot na **Pure Python Btrieve** prístup namiesto Delphi mikroslužby

**Nová štruktúra:**
```
nex-genesis-server/
├─ database-schema/     # 6 .bdf súborov
├─ delphi-sources/      # 7 Btrieve wrapperov
├─ external-dlls/       # 4 Pervasive DLLs
└─ docs/               # Aktualizovaná dokumentácia
```

---

### Aktívny Task 🔄

#### 🔄 Task 1.7 - Python Btrieve Setup
**Status:** IN PROGRESS  
**Started:** 2025-10-21  
**Priority:** HIGH  
**Estimate:** 4 hodiny  
**Dependencies:** Task 1.6 ✅

**Cieľ:**
Vytvoriť Python wrapper pre prístup k Btrieve databázam.

**Kroky:**
- [✅] Install SWIG (Simplified Wrapper and Interface Generator)
- [ ] Download Pervasive PSQL v11 SDK
- [ ] Setup C++ compiler (Visual Studio Build Tools)
- [ ] Build Python Btrieve wrapper (ctypes/SWIG)
- [ ] Test basic operations (Open, Read, Close)
- [ ] Create test script pre GSCAT.bdf
- [ ] Document setup process

**Deliverables:**
- `src/btrieve/btrieve_client.py` - Python wrapper
- `tests/test_btrieve_client.py` - Basic tests
- `docs/architecture/btrieve-access.md` - Setup guide

**Technical notes:**
- Pervasive PSQL v11 (existujúca verzia na serveri)
- SWIG pre C → Python binding
- ctypes pre direct DLL calls
- Visual Studio Build Tools 2019+
- Test na GSCAT.dat (produktový katalóg)

---

### Plánované Tasky 📅

#### Task 1.8 - Databázová schéma dokumentácia
**Priority:** HIGH | **Dependencies:** Task 1.7 | **Estimated:** 4h

**Plán:**
- Analyzovať všetkých 6 .bdf súborov
- Vytvoriť Python record layouts
- Zdokumentovať fieldy a indexy
- Vytvoriť ER diagram
- Dokumentovať relationships

#### Task 1.9 - Python record layouts
**Priority:** HIGH | **Dependencies:** Task 1.8 | **Estimated:** 3h

**Plán:**
- Vytvoriť Python dataclasses pre každú tabuľku
- Implementovať serialization/deserialization
- Validácia dát
- Type hints

#### Task 1.10 - ISDOC XML mapping
**Priority:** MEDIUM | **Dependencies:** Tasks 1.8-1.9 | **Estimated:** 2h

**Plán:**
- Mapovať ISDOC → GSCAT
- Mapovať ISDOC → BARCODE
- Mapovať ISDOC → TSH/TSI
- Mapovať ISDOC → PAB

---

## 🎉 NEDÁVNE ÚSPECHY

### 2025-10-21
- ✅ **Task 1.1-1.6 COMPLETE** - Projektová infraštruktúra a databázová schéma! 🎉
- ✅ **GitHub repository live**
- ✅ **Strategický pivot na Python Btrieve**
- ✅ **Reálne .bdf súbory** z NEX Genesis
- ✅ **Btrieve wrappery** (Delphi reference)
- ✅ **Pervasive DLLs** pripravené
- ✅ **Split manifests** implementované
- ✅ **CHANGELOG** tracking zavedený
- ✅ **6 taskov dokončených za 1 deň!** 🚀

---

## 🚧 AKTUÁLNE BLOKERY

**Žiadne aktuálne blokery!** ✅

Všetky závislosti pre Task 1.7 sú splnené.  
Môžeme pokračovať s Python Btrieve Setup.

---

## 📊 PHASE 2-4 (Plánované)

### PHASE 2: Core Development
**Status:** Čaká na Phase 1 | **Priority:** HIGH

- [ ] 2.1 - BtrieveClient wrapper implementation
- [ ] 2.2 - Python record layouts (dataclasses)
- [ ] 2.3 - ISDOC XML parser
- [ ] 2.4 - ProductService implementation (GSCAT)
- [ ] 2.5 - BarcodeService implementation (BARCODE)
- [ ] 2.6 - DeliveryNoteService implementation (TSH/TSI)
- [ ] 2.7 - SupplierService implementation (PAB)
- [ ] 2.8 - FastAPI/Flask setup
- [ ] 2.9 - Configuration management
- [ ] 2.10 - Error handling & logging

### PHASE 3: Integration & Testing
**Status:** Čaká na Phase 2 | **Priority:** MEDIUM

- [ ] 3.1 - Unit tests (pytest)
- [ ] 3.2 - Integration tests
- [ ] 3.3 - Testing s sample data
- [ ] 3.4 - Testing na NEX Genesis test database
- [ ] 3.5 - Performance testing
- [ ] 3.6 - Integrácia so supplier_invoice_loader
- [ ] 3.7 - End-to-end testing

### PHASE 4: Deployment
**Status:** Čaká na Phase 3 | **Priority:** MEDIUM

- [ ] 4.1 - Deployment na production server
- [ ] 4.2 - Monitoring setup
- [ ] 4.3 - Backup stratégia
- [ ] 4.4 - User dokumentácia
- [ ] 4.5 - Production testing
- [ ] 4.6 - Go-live

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
  "version": "0.2.0"
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

## 📝 KONFIGURÁCIA

### config.yaml (Template)
```yaml
server:
  port: 8000
  host: localhost
  workers: 4

database:
  type: btrieve
  path: "G:\\NEX\\Data"
  backup_path: "G:\\NEX\\Backup"
  
btrieve:
  sdk_path: "C:\\Program Files\\Pervasive PSQL v11\\bin"
  dll_path: ".\\external-dlls"
  page_size: 4096
  
paths:
  log_path: "C:\\Logs\\NEXGenesisServer"
  temp_path: "C:\\Temp\\NEXGenesisServer"

logging:
  level: INFO
  max_file_size: 10MB
  backup_count: 5
```

---

## ⚠️ KRITICKÉ PRIPOMIENKY

### Pre každý nový chat:
1. 🔥 Používateľ pošle URL na FULL_PROJECT_CONTEXT.md
2. 🔥 Claude načíta tento dokument (VŠETKO je tu)
3. 🔥 Claude odpovie: "✅ Projekt načítaný. Čo robíme?"
4. 🔥 ŽIADNE ďalšie súbory, ŽIADNE varovania
5. 🔥 Jednoducho a jasne
6. 🔥 KOMUNIKUJ PO SLOVENSKY

### Git pravidlá:
- ✅ Commit často, malé zmeny
- ✅ Opisné commit správy
- ✅ Test pred commitom
- ✅ Pull pred push
- ✅ Feature branches pre nové features

### Development Environment:
- **IDE:** PyCharm
- **Python:** 3.8+
- **Git:** Commit a push z PyCharm
- **Commit messages:** Claude poskytuje len čistý text message (bez `git commit -m`), používateľ ho skopíruje do PyCharm

### Kódovacie štandardy:
- ✅ PEP 8 (Python style guide)
- ✅ Type hints (typing module)
- ✅ Docstrings (Google style)
- ✅ Komentáre v slovenčine pre business logiku
- ✅ Angličtina pre technické komentáre
- ✅ Proper error handling (try..except..finally)
- ✅ Unit tests pre všetky funkcie
- ✅ VŽDY validuj vstupné dáta

### 🚨 PROJECT_FILE_ACCESS MANIFESTS REFRESH:
- ✅ **KEĎ VYTVORÍŠ NOVÝ SÚBOR → Vždy pripomeň refresh manifestov**
- ✅ Na konci každej session
- ✅ Po pridaní novej dokumentácie
- ✅ Po pridaní novej .bdf schémy
- ✅ Po pridaní Python súboru
- ✅ Jednoduchá pripomienka: **"⚠️ Nezabudni refreshnúť project manifests: `python scripts/generate_project_access.py`"**

### 🗄️ BTRIEVE ACCESS PRAVIDLÁ:
- ✅ **VŽDY používaj BtrieveClient wrapper**
- ✅ **VŽDY validuj record layout pred write**
- ✅ **VŽDY používaj index pre search**
- ✅ **VŽDY close file po operácii**
- ✅ **VŽDY handle Btrieve errors gracefully**
- ✅ **VŽDY log všetky DB operácie**
- ✅ **VŽDY backup pred write operáciami**
- ❌ **NIKDY nepristupuj k .dat súborom priamo** - používaj wrapper!

---

## ✅ KRITÉRIÁ ÚSPECHU

### Phase 1 Complete:
- ✅ NEX Genesis .bdf schémy na GitHub ✅
- ✅ Btrieve wrappery (reference) ✅
- ✅ Pervasive DLLs pripravené ✅
- 🔄 Python Btrieve wrapper funkčný (In Progress - Task 1.7)
- 📋 Databázová schéma zdokumentovaná (Planned - Task 1.8)
- 📋 Python record layouts vytvorené (Planned - Task 1.9)
- 📋 ISDOC mapping špecifikované (Planned - Task 1.10)
- ✅ Development environment ready ✅

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
- **Databáza:** Pervasive SQL (Btrieve)
- **Lokácia:** Customer server (MAGERSTAV)

---

## 🔜 ĎALŠIE KROKY

### Ihneď (Tento týždeň):
1. 🔄 Dokončiť Task 1.7 - Python Btrieve Setup
2. 📋 Task 1.8 - Databázová schéma dokumentácia
3. 📋 Task 1.9 - Python record layouts
4. 📋 Task 1.10 - ISDOC XML mapping

### Krátkodobé (Budúci 2 týždne):
1. Dokončiť Phase 1
2. Implementovať BtrieveClient wrapper
3. Vytvoriť ProductService
4. Zostaviť prvú mikroslužbu
5. Testovať s sample dátami

### Dlhodobé (Budúci mesiac):
1. Dokončiť všetky services
2. Integration testing
3. Integrácia so supplier_invoice_loader
4. Production deployment

---

## 🤖 FINAL REMINDER FOR CLAUDE

**You have loaded FULL_PROJECT_CONTEXT.md**

This document contains **EVERYTHING:**
- ✅ Complete project vision and goals
- ✅ **Current status, progress, and active tasks** (AKTUÁLNY STAV section)
- ✅ Full architecture and tech stack
- ✅ **NEX Genesis database schema** (6 real .bdf files)
- ✅ **Split manifests structure** (optimized for token usage)
- ✅ All 4 phases and development plan
- ✅ Project structure
- ✅ Git workflow and commit conventions
- ✅ Technical decisions
- ✅ **Btrieve access rules and patterns** (CRITICAL!)

**Simply respond:**
```
✅ Projekt načítaný. Čo robíme?
```

**BTRIEVE ACCESS REMINDER:**
```
When working with Btrieve:
✅ Use BtrieveClient wrapper
✅ Validate record layout
✅ Use indexes for search
✅ Close files after operations
✅ Handle errors gracefully
✅ Log all DB operations
✅ Backup before writes
❌ NO direct .dat file access!
```

**MANIFEST REMINDER:**
```
For new chats:
1. Load FULL_PROJECT_CONTEXT.md (this file)
2. Load project_file_access_docs.json (documentation only)
3. Load other manifests ONLY when needed:
   - bdf.json - when analyzing database schema
   - delphi.json - when checking Btrieve patterns
   
Never load all manifests at once! (token limit)
```

**WORKFLOW REMINDER:**
```
After creating ANY new file in the project:
⚠️ Remind user: "Nezabudni refreshnúť project manifests: python scripts/generate_project_access.py"

After completing any task:
⚠️ Remind user: "Nezabudni updatnúť FULL_PROJECT_CONTEXT.md (sekcia AKTUÁLNY STAV)"

This ensures single-file context always stays current.
```

---

**Verzia Dokumentu:** 0.2.0  
**Vytvorené:** 2025-10-21  
**Posledná Aktualizácia:** 2025-10-21 (Python Btrieve pivot + Real database schema)  
**Stav:** Aktívny Vývoj - Phase 1 (60% complete)

🏭 **Vytvárame Python Btrieve services! Jeden súbor = kompletný kontext.** ✨