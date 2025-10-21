# 🏭 NEX-GENESIS-SERVER - KOMPLETNÝ KONTEXT PROJEKTU

**Delphi 6 Mikroslužby pre NEX Genesis ERP**

**Posledná aktualizácia:** 2025-10-21  
**Verzia:** 0.1.0  
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
- **Progress Phase 1:** 40% (4/10 taskov)
- **Celkový Progress:** 10% (Phase 1 aktívna)
- **Aktívny Task:** Task 1.5 - Databázová schéma dokumentácia
- **Ďalší Milestone:** Phase 1 Complete (2025-10-28)

### Phase Progress
```
Phase 1: Setup & Analýza    [████████░░░░░░░░░░░░] 40%
Phase 2: Core Development   [░░░░░░░░░░░░░░░░░░░░]  0%
Phase 3: Agent Development  [░░░░░░░░░░░░░░░░░░░░]  0%
Phase 4: Integration        [░░░░░░░░░░░░░░░░░░░░]  0%
```

### Velocity
- **Tasks hotové tento týždeň:** 4
- **Priemerný čas na task:** ~30 minút
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
DB Access: BDE / ODBC / Native
HTTP Server: Indy / Synapse
XML Parser: MSXML / OmniXML
Konfigurácia: INI súbory
Testovanie: DUnit (optional)
IDE: Delphi 6 Professional
```

### Závislos ti
- **Indy Components** - HTTP Server
- **Synapse** - Alternatívna HTTP knižnica
- **MSXML** - XML parsing
- **Database components** - BDE alebo custom Pervasive drivers

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

## 📁 ŠTRUKTÚRA PROJEKTU

```
c:\Development\nex-genesis-server/
│
├── docs/                                    
│   ├── FULL_PROJECT_CONTEXT.md            # Tento súbor
│   ├── MASTER_CONTEXT.md                  # Rýchla referencia
│   ├── QUICK_START.md                     # Quick start guide
│   ├── SYSTEM_PROMPT.md                   # Claude inštrukcie
│   ├── project_file_access.json           # Vygenerovaný manifest
│   ├── architecture/
│   │   ├── database-schema.md
│   │   ├── api-endpoints.md
│   │   └── isdoc-mapping.md
│   └── sessions/
│       └── 2025-10-21-initial-setup.md
│
├── delphi-sources/                         # NEX Genesis source kódy
│   ├── Common/
│   ├── Database/
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
│   └── database_access_template.pas
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
│   ├── generate_project_access.py         # Generovanie manifestu
│   └── analyze_delphi_code.py             # Analýza NEX patterns
│
├── .gitignore
├── README.md
└── requirements.txt                        # Python tools
```

---

## 📋 PHASE 1: Setup & Analýza (Aktuálne)

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

---

### Aktívny Task 🔄

#### 🔄 Task 1.5 - Databázová schéma dokumentácia
**Status:** BLOKOVANÉ  
**Priority:** CRITICAL  
**Blocker:** Potrebujeme NEX Genesis source kódy

**Plán:**
- [ ] Upload NEX Genesis source kódov do delphi-sources/
- [ ] Analyzovať databázové tabuľky
- [ ] Zdokumentovať schému v docs/architecture/database-schema.md
- [ ] Identifikovať kľúčové tabuľky pre mikroslužby

**Dependencies:** NEX Genesis source kódy

---

### Plánované Tasky 📅

#### Task 1.6 - Analýza NEX Genesis patterns
**Priority:** HIGH | **Dependencies:** Task 1.5 | **Estimated:** 3h

#### Task 1.7 - ISDOC XML mapping
**Priority:** HIGH | **Dependencies:** Task 1.5 | **Estimated:** 2h

#### Task 1.8 - API endpoints špecifikácia
**Priority:** MEDIUM | **Dependencies:** Tasks 1.6-1.7 | **Estimated:** 2h

#### Task 1.9 - Vygenerovanie project_file_access.json
**Priority:** MEDIUM | **Dependencies:** Task 1.5 | **Estimated:** 30min

#### Task 1.10 - Finalizácia Phase 1
**Priority:** MEDIUM | **Dependencies:** Tasks 1.5-1.9 | **Estimated:** 1h

---

## 🎉 NEDÁVNE ÚSPECHY

### 2025-10-21
- ✅ **Task 1.1-1.4 COMPLETE** - Projektová infraštruktúra vytvorená! 🎉
- ✅ **GitHub repository live**
- ✅ **Dokumentačná štruktúra hotová**
- ✅ **Scripts pre generovanie manifestu**
- ✅ **4 tasky dokončené za 2 hodiny!** 🚀

---

## 🚧 AKTUÁLNE BLOKERY

### CRITICAL - Potrebujeme NEX Genesis Source Kódy ❗
**Task:** 1.5 - Databázová schéma dokumentácia

**Čo potrebujeme:**
1. NEX Genesis .pas, .dpr, .dfm súbory
2. Databázové tabuľky info
3. Connection settings
4. Existujúce patterns

**Ako pokračovať:**
```powershell
# 1. Skopíruj NEX Genesis source kódy do:
c:\Development\nex-genesis-server\delphi-sources\

# 2. Spusti analýzu:
python scripts/analyze_delphi_code.py

# 3. Vygeneruj manifest:
python scripts/generate_project_access.py
```

---

## 📊 PHASE 2-4 (Plánované)

### PHASE 2: Core Development
**Status:** Čaká na Phase 1 | **Priority:** HIGH

- [ ] 2.1 - Database access layer
- [ ] 2.2 - ISDOC XML parser
- [ ] 2.3 - ProductService implementation
- [ ] 2.4 - WarehouseService implementation
- [ ] 2.5 - SupplierService implementation
- [ ] 2.6 - HTTP Server setup
- [ ] 2.7 - Configuration management
- [ ] 2.8 - Error handling & logging
- [ ] 2.9 - Testing s sample data
- [ ] 2.10 - Integration testing

### PHASE 3: Agent Development 🤖
**Status:** Čaká na Phase 2 | **Priority:** MEDIUM

- [ ] 3.1 - Agent architektúra design
- [ ] 3.2 - Code analysis module
- [ ] 3.3 - Code generation module
- [ ] 3.4 - Template system
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

## 🗄️ DATABÁZOVÁ SCHÉMA (TBD)

### Poznámky k databáze
- **Database:** Pervasive SQL
- **Access method:** TBD (BDE / ODBC / Native)
- **Connection string:** TBD
- **Tables:** **POTREBUJEME OD NEX GENESIS**

### Kľúčové tabuľky (Očakávané)

```sql
-- Products (Produktový katalóg)
Table: ??? 
Fields: TBD

-- WarehouseReceipts (Header)
Table: ???
Fields: TBD

-- WarehouseReceiptItems (Items)
Table: ???
Fields: TBD

-- Suppliers (Dodávatelia)
Table: ???
Fields: TBD
```

**⚠️ Táto sekcia bude doplnená po analýze NEX Genesis kódov**

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

## 🤖 PROGRAMOVACÍ AGENT DESIGN

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

### Kódovacie štandardy:
- ✅ Používaj NEX Genesis naming conventions
- ✅ Komentáre v slovenčine pre business logiku
- ✅ Angličtina pre technické komentáre
- ✅ Proper error handling (try..except..finally)
- ✅ Memory management (Free objects!)

### 🚨 PROJECT_FILE_ACCESS.JSON REFRESH:
- ✅ **KEĎ VYTVORÍŠ NOVÝ SÚBOR → Vždy pripomeň refresh project_file_access.json**
- ✅ Na konci každej session
- ✅ Po pridaní novej dokumentácie
- ✅ Po vytvorení nového .pas súboru
- ✅ Jednoduchá pripomienka: **"⚠️ Nezabudni refreshnúť project_file_access.json"**

---

## ✅ KRITÉRIÁ ÚSPECHU

### Phase 1 Complete:
- ✅ NEX Genesis source kódy na GitHub
- ✅ Databázová schéma zdokumentovaná
- ✅ ISDOC mapping kompletný
- ✅ API endpoints špecifikované
- ✅ Development environment ready

### MVP (Minimum Viable Product):
- ✅ Jeden endpoint: POST /api/invoice/import
- ✅ Parsuje ISDOC XML
- ✅ Vytvára produkty ak chýbajú
- ✅ Vytvára skladovú príjemku
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
- **Databáza:** Pervasive SQL
- **Lokácia:** Customer server (MAGERSTAV)

---

## 📝 ĎALŠIE KROKY

### Ihneď (Tento týždeň):
1. Upload NEX Genesis source kódov do delphi-sources/
2. Spustiť `generate_project_access.py`
3. Zdokumentovať databázovú schému
4. Vytvoriť ISDOC mapping špecifikáciu

### Krátkodoba (Budúci 2 týždne):
1. Implementovať database access layer
2. Vytvoriť ISDOC parser
3. Zostrojiť prvú mikroslužbu (ProductService)
4. Testovať s sample dátami

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
- ✅ All 4 phases and development plan
- ✅ Project structure
- ✅ Git workflow and commit conventions
- ✅ Technical decisions

**Simply respond:**
```
✅ Projekt načítaný. Čo robíme?
```

**WORKFLOW REMINDER:**
```
After creating ANY new file in the project:
⚠️ Remind user: "Nezabudni refreshnúť project_file_access.json"

After completing any task:
⚠️ Remind user: "Nezabudni updatnúť FULL_PROJECT_CONTEXT.md (sekcia AKTUÁLNY STAV)"

This ensures single-file context always stays current.
```

---

**Verzia Dokumentu:** 0.1.0  
**Vytvorené:** 2025-10-21  
**Posledná Aktualizácia:** 2025-10-21  
**Stav:** Aktívny Vývoj - Phase 1

🏭 **Vytvárame Delphi mikroslužby! Jeden súbor = kompletný kontext.** ✨