# 🏭 NEX-GENESIS-SERVER - KOMPLETNÝ KONTEXT PROJEKTU

**Delphi 6 Mikroslužby pre NEX Genesis ERP**

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
- **Aktívna Fáza:** Phase 1 - Setup & Analýza
- **Progress Phase 1:** 50% (5/10 taskov)
- **Celkový Progress:** 12.5% (Phase 1 aktívna)
- **Aktívny Task:** Task 1.6 - Analýza NEX Genesis patterns
- **Ďalší Milestone:** Phase 1 Complete (2025-10-28)

### Phase Progress
```
Phase 1: Setup & Analýza    [██████████░░░░░░░░░░] 50%
Phase 2: Core Development   [░░░░░░░░░░░░░░░░░░░░]  0%
Phase 3: Agent Development  [░░░░░░░░░░░░░░░░░░░░]  0%
Phase 4: Integration        [░░░░░░░░░░░░░░░░░░░░]  0%
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
- **Účel:** REST API mikroslužby v Delphi 6 pre NEX Genesis ERP
- **Čas generovania kódu:** Agent-driven (TBD)
- **Vývojár:** ICC (Innovation & Consulting Center)
- **Developer:** rauschiccsk
- **Lokalizácia:** Komárno, SK
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server

### Vízia Projektu

Vytvoriť **programovacieho agenta**, ktorý vie:
- ✅ Analyzovať NEX Genesis source kódy (Delphi 6)
- ✅ Generovať nové mikroslužby v Delphi 6
- ✅ Dodržiavať NEX Genesis patterns a conventions
- ✅ Vytvárať REST API endpointy pre import faktúr

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
- ✅ Integrujú sa s NEX Genesis databázou (Pervasive)

### Workflow
```
supplier_invoice_loader (Python/FastAPI)
    ↓
ISDOC XML
    ↓
REST API (Delphi 6 Server)
    ↓
1. Check/Add Products
2. Create Warehouse Receipt
    ↓
NEX Genesis Database (Pervasive)
```

### Inšpirácia
- **supplier_invoice_loader** - Python FastAPI integrácia
- **project-generator** - Dokumentačná štruktúra (single-file context)
- **NEX Genesis** - Existujúce Delphi 6 patterns

---

## 🏗️ ARCHITEKTÚRA SYSTÉMU

### Tech Stack
```yaml
Jazyk: Delphi 6 (Object Pascal)
Databáza: Pervasive SQL
DB Access: NEX Genesis vlastný pattern (bBARCODE.pas + hBARCODE.pas)
HTTP Server: Indy / Synapse
XML Parser: MSXML / OmniXML
Konfigurácia: INI súbory
Testovanie: DUnit (optional)
IDE Delphi: Delphi 6 Professional
IDE Python: PyCharm
Git: PyCharm integrated Git
```

### Závislosti
- **Indy Components** - HTTP Server
- **Synapse** - Alternatívna HTTP knižnica
- **MSXML** - XML parsing
- **NexBtrTable.pas** - Custom Pervasive database engine
- **Database components** - NEX Genesis vlastné wrappery

### Architektúra
```
┌─────────────────────────────────┐
│  supplier_invoice_loader        │
│  (Python FastAPI)               │
│  Generuje ISDOC XML             │
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
│  ├─ Produktový Katalóg          │
│  ├─ Skladové Príjemky           │
│  ├─ Dodávatelia                 │
│  └─ Číslovanie Dokladov         │
└─────────────────────────────────┘
```

### Mikroslužby Architektúra

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

## 🗄️ NEX GENESIS DATABÁZOVÝ PRÍSTUP

**⚠️ KRITICKY DÔLEŽITÉ pre mikroslužby!**

NEX Genesis používa **vlastný 5-vrstvový systém** pre prístup k Pervasive SQL databáze.  
**Detailná dokumentácia:** `docs/architecture/database-access-pattern.md`

### Hierarchia Prístupu

```
┌─────────────────────────────────────────────────────┐
│ LAYER 1: Fyzická databáza                          │
│ BARCODE.BTR (Pervasive SQL súbor)                  │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ LAYER 2: Definičný súbor (Metadata)                │
│ BARCODE.bdf                                         │
│ - Field definitions (GsCode, BarCode, ModUser...)  │
│ - Index definitions (GsCode, BarCode, composite)    │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ LAYER 3: Low-level database engine                 │
│ NexBtrTable.pas (TNexBtrTable)                      │
│ - Priamy prístup k Pervasive SQL                    │
│ - FieldByName() access                              │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ LAYER 4: AUTO-GENERATED WRAPPER                    │
│ bBARCODE.pas (TBarcodeBtr)                          │
│ - Type-safe properties                              │
│ - Index constants                                   │
│ - Locate/Nearest methods                            │
│ ⚠️ REGENERUJE SA pri zmene .bdf!                    │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ LAYER 5: BUSINESS LOGIC HANDLER                    │
│ hBARCODE.pas (TBarcodeHnd)                          │
│ - Custom business methods                           │
│ - Validácie                                         │
│ ✅ NEREGENERUJE SA - ručne udržiavaný!              │
└─────────────────────────────────────────────────────┘
```

### Príklad Použitia

```pascal
var
  BarcodeHnd: TBarcodeHnd;
begin
  BarcodeHnd := TBarcodeHnd.Create;
  try
    // ✅ Type-safe prístup k poliam (properties, nie FieldByName!)
    if BarcodeHnd.LocateGsCode(12345) then
    begin
      ShowMessage(BarcodeHnd.BarCode);  // Property!
    end;
    
    // ✅ Custom business method (z hBARCODE.pas)
    BarcodeHnd.Del(12345);  // Vymaže všetky barcodes pre produkt
    
    // ✅ Insert s audit fields
    BarcodeHnd.Insert;
    BarcodeHnd.GsCode := 12345;
    BarcodeHnd.BarCode := '8594000123456';
    BarcodeHnd.ModUser := 'API';
    BarcodeHnd.ModDate := Now;
    BarcodeHnd.ModTime := Now;
    BarcodeHnd.Post;
  finally
    BarcodeHnd.Free;
  end;
end;
```

### Kľúčové Pravidlá

#### 1. **VŽDY používaj wrapper properties**, NIE FieldByName()
```pascal
// ❌ ZLE
Table.oBtrTable.FieldByName('GsCode').AsInteger := 123;

// ✅ SPRÁVNE
Table.GsCode := 123;
```

#### 2. **Business logic LEN v h*.pas**, NIE v b*.pas
- `b*.pas` - Auto-generovaný, REGENERUJE SA
- `h*.pas` - Ručný, PREŽIJE regeneráciu

#### 3. **VŽDY používaj Locate methods** pre vyhľadávanie
```pascal
// ❌ ZLE - full table scan
Table.First;
while not Table.Eof do
begin
  if Table.GsCode = 123 then Break;
  Table.Next;
end;

// ✅ SPRÁVNE - index-based search
if Table.LocateGsCode(123) then
  // Found!
```

#### 4. **VŽDY update audit polia**
```pascal
Table.ModUser := 'API';
Table.ModDate := Now;
Table.ModTime := Now;
```

#### 5. **VŽDY Free objects** v finally bloku
```pascal
TableHnd := TTableHnd.Create;
try
  // práca
finally
  TableHnd.Free;
end;
```

### Príklad: BARCODE Tabuľka

#### Definičný súbor (BARCODE.bdf):
```delphi
BARCODE.BTR cPrealloc+cFree10   ;Druhotné identifikačné kódy

// Fields
GsCode     longint      ;Tovarové číslo (PLU)
BarCode    Str15        ;Druhotný identifikačný kód
ModUser    Str8         ;Užívateľ
ModDate    DateType     ;Dátum úpravy
ModTime    TimeType     ;Čas úpravy

// Indexes
IND GsCode=GsCode       ;Index podľa produktu
IND BarCode=BarCode     ;Index podľa čiarového kódu
IND GsCode,BarCode=GsBc ;Composite index (unique)
```

#### Auto-generovaný wrapper (bBARCODE.pas):
```pascal
type
  TBarcodeBtr = class(TComponent)
  public
    // Locate methods (automatické prepínanie indexov)
    function LocateGsCode(pGsCode:longint):boolean;
    function LocateBarCode(pBarCode:Str15):boolean;
    function LocateGsBc(pGsCode:longint; pBarCode:Str15):boolean;
    
    // CRUD operations
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    
  published
    // Type-safe properties
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;
```

#### Business logic handler (hBARCODE.pas):
```pascal
type
  TBarcodeHnd = class(TBarcodeBtr)
  public
    // Custom method: Vymaže všetky barcodes pre produkt
    procedure Del(pGsCode:longint);
  end;

implementation

procedure TBarcodeHnd.Del(pGsCode:longint);
begin
  While LocateGsCode(pGsCode) do Delete;
end;
```

### Index Management

```pascal
const
  ixGsCode = 'GsCode';    // Index podľa produktu
  ixBarCode = 'BarCode';  // Index podľa čiarového kódu
  ixGsBc = 'GsBc';        // Composite (GsCode + BarCode)

// Použitie:
BarcodeHnd.LocateGsCode(123);     // Automaticky prepne na ixGsCode
BarcodeHnd.LocateBarCode('EAN');  // Automaticky prepne na ixBarCode
BarcodeHnd.LocateGsBc(123, 'EAN'); // Composite lookup
```

### Pre NEX-Genesis-Server Mikroslužby

✅ **Používaj h*.pas handlers** pre všetky databázové operácie  
✅ **Wrap do try..finally** blokov  
✅ **Log všetky DB operácie**  
✅ **Validuj vstupné dáta** pred Insert/Post  
✅ **Používaj Locate methods** namiesto SQL queries  
✅ **Update audit polia** (ModUser, ModDate, ModTime)  

### Design Patterns Použité

- **Wrapper Pattern** - TNexBtrTable → TBarcodeBtr
- **Template Method** - Post() virtual pre override
- **Facade Pattern** - Simplified high-level API
- **Repository Pattern** - TBarcodeHnd ako repository

---

**Kompletná dokumentácia:** `docs/architecture/database-access-pattern.md`  
**Template pre h*.pas:** `templates/h_table_handler_template.pas`  
**System prompt:** `docs/SYSTEM_PROMPT_DATABASE.md`

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
│   ├── SYSTEM_PROMPT_DATABASE.md          # Database patterns pre Claude
│   ├── PROJECT_MANIFESTS_README.md        # Používateľská príručka manifestov
│   ├── project_file_access_INDEX.json     # 📋 Katalóg manifestov
│   ├── project_file_access_CONTEXT.json   # 🤖 Pre Claude (dokumentácia)
│   ├── project_file_access_delphi.json    # 🔧 Delphi sources
│   ├── project_file_access_output.json    # 📦 Generované mikroslužby
│   ├── project_file_access_templates.json # 📝 Templates a scripts
│   ├── architecture/
│   │   ├── database-access-pattern.md     # ✨ NEX Genesis DB prístup
│   │   ├── database-schema.md             # TBD
│   │   ├── api-endpoints.md               # TBD
│   │   └── isdoc-mapping.md               # TBD
│   └── sessions/
│       └── 2025-10-21-initial-setup.md
│
├── delphi-sources/                         # NEX Genesis source kódy
│   ├── Common/
│   ├── DataModules/
│   ├── DataTables/
│   │   ├── bBARCODE.pas                   # Auto-generovaný wrapper
│   │   ├── hBARCODE.pas                   # Business logic handler
│   │   └── NexBtrTable.pas                # Low-level Pervasive engine
│   ├── Libraries/
│   ├── Packages/
│   ├── Business/
│   └── UI/
│
├── output/                                 # Vygenerované mikroslužby
│   ├── NEXGenesisServer.dpr
│   ├── ProductService.pas
│   ├── WarehouseService.pas
│   ├── SupplierService.pas
│   ├── ISDOCParser.pas
│   ├── HTTPServer.pas
│   ├── DatabaseAccess.pas
│   └── Config.pas
│
├── templates/                              # Code templates pre agenta
│   ├── service_template.pas
│   ├── endpoint_template.pas
│   ├── database_access_template.pas
│   └── h_table_handler_template.pas       # ✨ Template pre h*.pas
│
├── tests/                                  # Test data
│   ├── sample_isdoc.xml
│   └── test_requests.http
│
├── config/                                  
│   ├── server_config.ini.template
│   └── database_config.ini.template
│
├── scripts/                                 
│   ├── generate_project_access.py         # Generovanie manifestov (SPLIT)
│   └── analyze_delphi_code.py             # Analýza NEX patterns
│
├── .gitignore
├── README.md
└── requirements.txt                        # Python tools
```

---

## 📋 PROJECT FILE ACCESS MANIFESTS

**Problém:** Jeden veľký JSON súbor (20k+ riadkov) spôsobuje token limit problémy.  
**Riešenie:** Rozdelené manifesty na špecifické účely.

### Štruktúra Manifestov

```
docs/
├── project_file_access_INDEX.json       # 📋 Main index (odkazy na všetky)
├── project_file_access_CONTEXT.json     # 🤖 Pre Claude (len docs/)
├── project_file_access_delphi.json      # 🔧 Delphi sources
├── project_file_access_output.json      # 📦 Generované mikroslužby
└── project_file_access_templates.json   # 📝 Templates a scripts
```

### Použitie

#### 1️⃣ Pre Claude (Dokumentácia) - DEFAULT
```
URL: https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_CONTEXT.json

Obsahuje:
- docs/ (všetka dokumentácia)
- FULL_PROJECT_CONTEXT.md
- architecture/ dokumenty
- session notes

Veľkosť: ~500 riadkov
Use case: Default pre prácu s Claude na projektovej dokumentácii
```

#### 2️⃣ Pre Analýzu Delphi Kódu
```
URL: https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_delphi.json

Obsahuje:
- delphi-sources/ (všetky .pas, .dfm, .dpr súbory)
- NEX Genesis patterns
- Database handlers (b*.pas, h*.pas)

Veľkosť: ~15 000 riadkov
Use case: Keď Claude potrebuje analyzovať NEX Genesis kód
```

#### 3️⃣ Pre Generovaný Kód
```
URL: https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_output.json

Obsahuje:
- output/ (vygenerované mikroslužby)
- REST API implementácie
- Services

Veľkosť: ~100 riadkov
Use case: Keď Claude pracuje s generovanými mikroslužbami
```

#### 4️⃣ Pre Templates a Scripts
```
URL: https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_templates.json

Obsahuje:
- templates/ (code templates)
- scripts/ (Python utility scripts)
- config/ (configuration templates)

Veľkosť: ~50 riadkov
Use case: Keď Claude generuje nový kód z templates
```

#### 📋 Main Index (Prehľad)
```
URL: https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_INDEX.json

Obsahuje:
- Odkazy na všetky manifesty
- Popis jednotlivých manifestov
- Use cases

Veľkosť: ~50 riadkov
Use case: Zistiť, ktorý manifest načítať
```

### Generovanie Manifestov

```powershell
# Generuj všetky manifesty naraz
python scripts/generate_project_access.py

# Output:
# ✅ project_file_access_CONTEXT.json    (~500 riadkov)
# ✅ project_file_access_delphi.json     (~15000 riadkov)
# ✅ project_file_access_output.json     (~100 riadkov)
# ✅ project_file_access_templates.json  (~50 riadkov)
# ✅ project_file_access_INDEX.json      (~50 riadkov)
```

### Workflow Pre Nový Chat s Claude

#### Variant A: Len Dokumentácia (Odporúčané) ⭐
```
1. Pošli Claude URL:
   https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

2. Ak potrebuje konkrétne súbory, pošli aj:
   https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_CONTEXT.json
```

#### Variant B: + Delphi Analýza
```
1. FULL_PROJECT_CONTEXT.md (ako vyššie)
2. project_file_access_CONTEXT.json (dokumentácia)
3. project_file_access_delphi.json (len keď analyzuješ Delphi kód)
```

#### Variant C: Všetko (Len ak naozaj treba)
```
1. FULL_PROJECT_CONTEXT.md
2. project_file_access_INDEX.json (ukáže všetky dostupné manifesty)
3. Načítaj len tie manifesty, ktoré potrebuješ
```

### Výhody Rozdeleného Prístupu

✅ **Menšie súbory** - Každý manifest má < 5000 riadkov (okrem delphi)  
✅ **Rýchlejšie načítanie** - Claude načíta len potrebné súbory  
✅ **Nižšia spotreba tokenov** - Nemusíš načítať celý projekt  
✅ **Lepšia organizácia** - Jasné rozdelenie podľa účelu  
✅ **Škálovateľné** - Pridaj nové manifesty podľa potreby  

### Kedy Refresh Manifesty

⚠️ **VŽDY po:**
- Pridaní nového dokumentu do docs/
- Pridaní nového .pas súboru do delphi-sources/
- Vytvorení nového template
- Vygenerovaní mikroslužby do output/
- Na konci každej session

```powershell
python scripts/generate_project_access.py
git add docs/project_file_access_*.json
git commit -m "chore: refresh project file access manifests"
```

---

**Kompletná príručka:** `docs/PROJECT_MANIFESTS_README.md`  
**Poznámka:** Stará `project_file_access.json` (monolitický súbor) už nepoužívame.

---

## 📋 PHASE 1: Setup & Analýza

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
- ✅ `scripts/generate_project_access.py` (SPLIT version)
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
- ✅ `docs/architecture/database-access-pattern.md` (5000+ words)
- ✅ `templates/h_table_handler_template.pas`
- ✅ `docs/SYSTEM_PROMPT_DATABASE.md`
- ✅ `docs/PROJECT_MANIFESTS_README.md`
- ✅ Kompletná analýza hBARCODE.pas a bBARCODE.pas
- ✅ 5-vrstvová architektúra zdokumentovaná
- ✅ Design patterns identifikované
- ✅ Best practices definované
- ✅ Real-world examples pre mikroslužby
- ✅ Split manifests implementované

**Kľúčové Poznatky:**
- NEX Genesis používa vlastný wrapper pattern pre Pervasive SQL
- b*.pas súbory sa auto-generujú z .bdf definícií
- h*.pas súbory obsahujú business logic a prežívajú regeneráciu
- Type-safe properties namiesto FieldByName()
- Automatické prepínanie indexov cez Locate methods
- Rozdelené manifesty riešia token limit problémy

---

### Aktívny Task 🔄

#### 🔄 Task 1.6 - Analýza NEX Genesis patterns
**Status:** READY TO START  
**Priority:** HIGH  
**Dependencies:** Task 1.5 DONE ✅  
**Estimated:** 3h

**Plán:**
- [ ] Analyzovať produktovú tabuľku (b/h PRODUCT.pas)
- [ ] Analyzovať skladovú tabuľku (b/h STOCK.pas)
- [ ] Analyzovať tabuľku príjemiek (b/h RECEIPT.pas)
- [ ] Identifikovať common patterns v Business modules
- [ ] Zdokumentovať naming conventions
- [ ] Zdokumentovať error handling patterns
- [ ] Vytvoriť pattern library pre agent

---

### Plánované Tasky 📅

#### Task 1.7 - ISDOC XML mapping
**Priority:** HIGH | **Dependencies:** Task 1.6 | **Estimated:** 2h

#### Task 1.8 - API endpoints špecifikácia
**Priority:** MEDIUM | **Dependencies:** Tasks 1.6-1.7 | **Estimated:** 2h

#### Task 1.9 - Vygenerovanie project_file_access manifests
**Priority:** MEDIUM | **Dependencies:** Task 1.6 | **Estimated:** 30min

#### Task 1.10 - Finalizácia Phase 1
**Priority:** MEDIUM | **Dependencies:** Tasks 1.6-1.9 | **Estimated:** 1h

---

## 🎉 NEDÁVNE ÚSPECHY

### 2025-10-21
- ✅ **Task 1.1-1.5 COMPLETE** - Projektová infraštruktúra a databázová dokumentácia! 🎉
- ✅ **GitHub repository live**
- ✅ **Kompletná databázová architektúra zdokumentovaná**
- ✅ **Templates pre code generation pripravené**
- ✅ **Split manifests implementované** (riešenie token limit problémov)
- ✅ **5 taskov dokončených za 4 hodiny!** 🚀
- ✅ **Database access pattern - 5000+ words dokumentácia**

---

## 🚧 AKTUÁLNE BLOKERY

**Žiadne aktuálne blokery!** ✅

Všetky závislosti pre Task 1.6 sú splnené.  
Môžeme pokračovať s analýzou NEX Genesis patterns.

---

## 📊 PHASE 2-4 (Plánované)

### PHASE 2: Core Development
**Status:** Čaká na Phase 1 | **Priority:** HIGH

- [ ] 2.1 - Database access layer implementation
- [ ] 2.2 - ISDOC XML parser
- [ ] 2.3 - ProductService implementation (using h*.pas pattern)
- [ ] 2.4 - WarehouseService implementation (using h*.pas pattern)
- [ ] 2.5 - SupplierService implementation (using h*.pas pattern)
- [ ] 2.6 - HTTP Server setup
- [ ] 2.7 - Configuration management
- [ ] 2.8 - Error handling & logging
- [ ] 2.9 - Testing s sample data
- [ ] 2.10 - Integration testing

### PHASE 3: Agent Development 🤖
**Status:** Čaká na Phase 2 | **Priority:** MEDIUM

- [ ] 3.1 - Agent architektúra design
- [ ] 3.2 - Code analysis module
- [ ] 3.3 - Code generation module (using templates)
- [ ] 3.4 - Template system enhancement
- [ ] 3.5 - Validácia & testing
- [ ] 3.6 - Agent CLI/API
- [ ] 3.7 - Generovanie dokumentácie

### PHASE 4: Integrácia & Deployment
**Status:** Čaká na Phase 3 | **Priority:** MEDIUM

- [ ] 4.1 - Integrácia so supplier_invoice_loader
- [ ] 4.2 - End-to-end testing
- [ ] 4.3 - Performance optimization
- [ ] 4.4 - Deployment na production server
- [ ] 4.5 - Monitoring setup
- [ ] 4.6 - User dokumentácia

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
  "productId": 12345,
  "name": "Produkt XYZ"
}
```

---

## 🗄️ DATABÁZOVÁ SCHÉMA

### Poznámky k databáze
- **Database:** Pervasive SQL
- **Access method:** NEX Genesis vlastný pattern (h*.pas + b*.pas)
- **Connection:** Via NexBtrTable.pas
- **Tables:** Analyzované v docs/architecture/database-access-pattern.md

### Analyzované Tabuľky

#### BARCODE.BTR
```
Fields:
  GsCode   : longint   (Tovarové číslo - PRIMARY KEY v PRODUCT)
  BarCode  : Str15     (Čiarový kód - EAN, Code128, QR, custom)
  ModUser  : Str8      (Užívateľ - audit)
  ModDate  : DateType  (Dátum úpravy - audit)
  ModTime  : TimeType  (Čas úpravy - audit)

Indexes:
  ixGsCode  : GsCode              (Vyhľadávanie podľa produktu)
  ixBarCode : BarCode             (Vyhľadávanie podľa čiarového kódu)
  ixGsBc    : GsCode + BarCode    (Composite unique constraint)

Handler: hBARCODE.pas (TBarcodeHnd)
  - Del(pGsCode) : Vymaže všetky barcodes pre produkt
  
Wrapper: bBARCODE.pas (TBarcodeBtr)
  - Auto-generovaný z BARCODE.bdf
  - Type-safe properties
  - Locate/Nearest methods
```

### Potrebné Tabuľky (TBD - Task 1.6)
- **PRODUCT** - Produktový katalóg
- **STOCK** - Skladové zásoby
- **RECEIPT** - Skladové príjemky
- **RECEIPT_ITEMS** - Položky príjemiek
- **SUPPLIER** - Dodávatelia

---

## 🔄 ISDOC XML → NEX Genesis Mapping

### Invoice Header Mapping (TBD - Task 1.7)
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
        <n>             → Supplier Name
      </PartyName>
    </Party>
  </AccountingSupplierParty>
```

### Invoice Lines Mapping (TBD - Task 1.7)
```xml
<InvoiceLine>
  <ID>                     → Line number
  <InvoicedQuantity>       → Quantity
  <LineExtensionAmount>    → TotalPrice
  <Item>
    <n>                 → Product Name
    <SellersItemIdentification>
      <ID>                 → Product Code / BarCode
    </SellersItemIdentification>
  </Item>
  <Price>
    <PriceAmount>          → UnitPrice
  </Price>
</InvoiceLine>
```

---

## 🤖 PROGRAMOVACÍ AGENT DESIGN

### Agent Úlohy
1. **Analyzovať NEX Genesis source kódy**
   - Identifikovať database access patterns (✅ DONE - Task 1.5)
   - Nájsť existujúce business logic
   - Extrahovať common units/functions

2. **Generovať Delphi 6 mikroslužby**
   - ProductService (using TProductHnd)
   - WarehouseService (using TReceiptHnd)
   - ISDOCParser
   - HTTPServer

3. **Dodržiavať NEX Genesis patterns**
   - Database access cez h*.pas handlers (✅ documented)
   - Type-safe properties
   - Locate methods pre vyhľadávanie
   - Error handling
   - Logging

### Agent Architektúra (Návrh)

```
┌─────────────────────────────────┐
│  Claude API (Reasoning Layer)   │
│  - Rozumie úlohe                │
│  - Analyzuje NEX patterns       │
│  - Navrhne riešenie             │
│  - Generuje Delphi kód          │
└──────────────┬──────────────────┘
               │
               ▼
┌─────────────────────────────────┐
│  Python Wrapper (Execution)     │
│  - Prístup k GitHub             │
│  - Code templates               │
│  - Syntax validácia             │
│  - Git operácie                 │
└─────────────────────────────────┘
```

### Templates Pre Agent

✅ **h_table_handler_template.pas** - Template pre h*.pas súbory  
🔄 **service_template.pas** - Template pre mikroslužby (TBD)  
🔄 **endpoint_template.pas** - Template pre REST endpoints (TBD)  

---

## 🔐 KONFIGURÁCIA

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
Path=c:\NEX\Data\
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
- ✅ Opisné commit správy
- ✅ Test pred commitom
- ✅ Pull pred push
- ✅ Feature branches pre nové features

### Development Environment:
- **IDE:** PyCharm (pre Python scripty)
- **Delphi IDE:** Delphi 6 Professional
- **Git:** Commit a push z PyCharm
- **Commit messages:** Claude poskytuje len čistý text message (bez `git commit -m`), užívateľ ho skopíruje do PyCharm

### Kódovacie štandardy:
- ✅ Používaj NEX Genesis naming conventions
- ✅ Database access LEN cez h*.pas handlers
- ✅ Type-safe properties, NIE FieldByName()
- ✅ Locate methods pre vyhľadávanie
- ✅ Komentáre v slovenčine pre business logiku
- ✅ Angličtina pre technické komentáre
- ✅ Proper error handling (try..except..finally)
- ✅ Memory management (Free objects v finally!)
- ✅ VŽDY update ModUser, ModDate, ModTime

### 🚨 PROJECT_FILE_ACCESS MANIFESTS REFRESH:
- ✅ **KEĎ VYTVORÍŠ NOVÝ SÚBOR → Vždy pripomeň refresh manifestov**
- ✅ Na konci každej session
- ✅ Po pridaní novej dokumentácie
- ✅ Po vytvorení nového .pas súboru
- ✅ Po vygenerovaní mikroslužby
- ✅ Jednoduchá pripomienka: **"⚠️ Nezabudni refreshnúť project manifests: `python scripts/generate_project_access.py`"**

### 🗄️ DATABASE ACCESS PRAVIDLÁ:
- ✅ **VŽDY používaj h*.pas handlers** (TBarcodeHnd, TProductHnd...)
- ✅ **VŽDY používaj type-safe properties** (Table.GsCode, NIE FieldByName('GsCode'))
- ✅ **VŽDY používaj Locate methods** (LocateGsCode, NIE full table scan)
- ✅ **VŽDY wrap do try..finally** (Free objects!)
- ✅ **VŽDY update audit fields** (ModUser, ModDate, ModTime)
- ✅ **Business logic LEN v h*.pas**, NIE v b*.pas
- ❌ **NIKDY nepoužívaj SQL queries** - používaj h*.pas handlers!

---

## ✅ KRITÉRIÁ ÚSPECHU

### Phase 1 Complete:
- ✅ NEX Genesis source kódy na GitHub (Partial - BARCODE done)
- ✅ Databázový prístup pattern zdokumentovaný ✅
- ✅ Split manifests implementované ✅
- 🔄 Databázová schéma zdokumentovaná (In Progress - Task 1.6)
- 🔄 ISDOC mapping kompletný (Planned - Task 1.7)
- 🔄 API endpoints špecifikované (Planned - Task 1.8)
- ✅ Development environment ready ✅
- ✅ Templates pre code generation ✅

### MVP (Minimum Viable Product):
- ✅ Jeden endpoint: POST /api/invoice/import
- ✅ Parsuje ISDOC XML
- ✅ Vytvára produkty ak chýbajú (using TProductHnd)
- ✅ Vytvára skladovú príjemku (using TReceiptHnd)
- ✅ Funguje s reálnou NEX databázou
- ✅ Základný error handling

### V1.0 Production Ready:
- ✅ Všetky plánované endpointy
- ✅ Kompletný error handling
- ✅ Logging a monitoring
- ✅ Integrácia so supplier_invoice_loader
- ✅ Agent vie generovať nové služby
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
- **Databáza:** Pervasive SQL (vlastný access pattern)
- **Lokácia:** Customer server (MAGERSTAV)

---

## 📝 ĎALŠIE KROKY

### Ihneď (Tento týždeň):
1. ✅ Zdokumentovať database access pattern ✅
2. ✅ Implementovať split manifests ✅
3. 🔄 Analyzovať ďalšie NEX Genesis patterns (Task 1.6)
4. 🔄 Zdokumentovať produktovú tabuľku
5. 🔄 Zdokumentovať skladové tabuľky
6. 🔄 Vytvoriť ISDOC mapping špecifikáciu (Task 1.7)

### Krátkodoba (Budúci 2 týždne):
1. Dokončiť Phase 1
2. Implementovať database access layer (using h*.pas handlers)
3. Vytvoriť ISDOC parser
4. Zostrojiť prvú mikroslužbu (ProductService)
5. Testovať s sample dátami

### Dlhodobé (Budúci mesiac):
1. Dokončiť všetky mikroslužby
2. Vyvinúť programovacieho agenta
3. Integration testing
4. Production deployment

---

## 🤖 FINAL REMINDER FOR CLAUDE

**You have loaded FULL_PROJECT_CONTEXT.md**

This document contains **EVERYTHING:**
- ✅ Complete project vision and goals
- ✅ **Current status, progress, and active tasks** (AKTUÁLNY STAV section)
- ✅ Full architecture and tech stack
- ✅ **NEX Genesis database access pattern** (5-layer architecture)
- ✅ **Split manifests structure** (optimized for token usage)
- ✅ All 4 phases and development plan
- ✅ Project structure
- ✅ Git workflow and commit conventions
- ✅ Technical decisions
- ✅ **Database access rules and patterns** (CRITICAL!)

**Simply respond:**
```
✅ Projekt načítaný. Čo robíme?
```

**DATABASE ACCESS REMINDER:**
```
When generating Delphi code:
✅ Use h*.pas handlers (TBarcodeHnd, TProductHnd...)
✅ Use type-safe properties (Table.GsCode)
✅ Use Locate methods (LocateGsCode)
✅ Wrap in try..finally
✅ Update audit fields (ModUser, ModDate, ModTime)
❌ NO SQL queries - use handlers!
❌ NO FieldByName() - use properties!
❌ NO full table scans - use Locate!
```

**MANIFEST REMINDER:**
```
For new chats:
1. Load FULL_PROJECT_CONTEXT.md (this file)
2. Load project_file_access_CONTEXT.json (documentation only)
3. Load other manifests ONLY when needed:
   - delphi.json - when analyzing Delphi code
   - templates.json - when generating code
   - output.json - when working with generated services
   
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
**Posledná Aktualizácia:** 2025-10-21 (Database access pattern + Split manifests)  
**Stav:** Aktívny Vývoj - Phase 1 (50% complete)

🏭 **Vytvárame Delphi mikroslužby! Jeden súbor = kompletný kontext.** ✨