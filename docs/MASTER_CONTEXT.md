# 🏭 NEX GENESIS SERVER - MASTER KONTEXT

**Rýchly Referenčný Návod**

---

## 🎯 Čo je to?

**Delphi 6 REST API mikroslužby** pre NEX Genesis ERP, ktoré importujú dodávateľské faktúry z ISDOC XML:
- ✅ Kontrola/pridanie produktov do katalógu
- ✅ Vytvorenie skladových príjemiek
- ✅ Integrácia s Pervasive databázou
- ✅ Programovací agent pre generovanie kódu

**Rieši:** Manuálne zadávanie faktúr → Automatický import z XML

---

## 🚀 Rýchly Štart

```bash
# 1. Klonovanie
git clone https://github.com/rauschiccsk/nex-genesis-server.git
cd nex-genesis-server

# 2. Upload NEX Genesis source kódov
# Skopíruj .pas, .dpr súbory do: delphi-sources/

# 3. Vygeneruj manifest
python scripts/generate_project_access.py

# 4. Commit & Push
git add .
git commit -m "docs: Add NEX Genesis sources"
git push
```

---

## 📋 Kľúčové Súbory

| Súbor | Účel | Umiestnenie |
|------|---------|----------|
| **FULL_PROJECT_CONTEXT.md** | Kompletná dokumentácia | `docs/` |
| **MASTER_CONTEXT.md** | Rýchla referencia | `docs/` |
| **QUICK_START.md** | Návod na začiatok | `docs/` |
| **SYSTEM_PROMPT.md** | Claude inštrukcie | `docs/` |
| **project_file_access.json** | Manifest súborov | `docs/` |
| **generate_project_access.py** | Script na manifest | `scripts/` |

---

## 💾 Tech Stack

```yaml
Jazyk: Delphi 6 (Object Pascal)
Databáza: Pervasive SQL
HTTP Server: Indy / Synapse
XML Parser: MSXML / OmniXML
Konfigurácia: INI files
Python Tools: Scripts pre analýzu
```

---

## 🏗️ Architektúra

```
supplier_invoice_loader → ISDOC XML → Delphi REST API → NEX Database
         (Python)                     (Delphi 6)         (Pervasive)
```

---

## 📊 Stav Vývoja

**Aktuálna Fáza:** Phase 1 - Setup & Analýza  
**Progress:** ~40%  
**Ďalej:** Databázová schéma, NEX patterns analýza

**Phases:**
1. **Setup & Analýza** 🔧 (Aktuálne) - 1 týždeň
2. **Core Development** 🚀 - 3 týždne
3. **Agent Development** 🤖 - 2 týždne
4. **Integrácia** 🔗 - 1 týždeň

---

## 📁 Vygenerovaná Štruktúra

```
nex-genesis-server/
├── docs/                   # Dokumentácia
│   └── FULL_PROJECT_CONTEXT.md
├── delphi-sources/         # NEX Genesis kódy
├── output/                 # Vygenerované mikroslužby
│   ├── ProductService.pas
│   ├── WarehouseService.pas
│   └── HTTPServer.pas
├── templates/              # Code templates
├── config/                 # Konfiguračné INI
└── scripts/                # Python utility
```

---

## 🎯 Kritériá Úspechu

**MVP:**
- ✅ Endpoint: POST /api/invoice/import
- ✅ Parsuje ISDOC XML
- ✅ Vytvára produkty ak chýbajú
- ✅ Vytvára skladové príjemky
- ✅ Funguje s reálnou databázou

---

## 🔌 API Endpoints (Plánované)

### Import Invoice
```http
POST /api/invoice/import
Content-Type: application/xml

<ISDOC XML>

Response: { "success": true, "receiptId": "PR-2025-0001" }
```

### Health Check
```http
GET /api/health

Response: { "status": "ok", "database": "connected" }
```

---

## 🤖 Programovací Agent

Agent bude:
- Analyzovať NEX Genesis patterns
- Generovať Delphi 6 mikroslužby
- Dodržiavať NEX coding standards
- Vytvárať dokumentáciu

---

## 🔧 Bežné Úlohy

### Začni Vývojovú Session
1. Načítaj project context
2. Over FULL_PROJECT_CONTEXT.md (AKTUÁLNY STAV)
3. Vyber task na ktorom pracuješ

### Analyzuj NEX Kódy
```bash
python scripts/analyze_delphi_code.py
```

### Vygeneruj Manifest
```bash
python scripts/generate_project_access.py
```

### Refresh po zmenách
```bash
# Po pridaní nových súborov:
python scripts/generate_project_access.py
git add docs/project_file_access.json
git commit -m "docs: Update file access manifest"
```

---

## 📞 Zdroje

- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server
- **Lokálne:** c:\Development\nex-genesis-server
- **Context URL:** https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md
- **Vývojár:** ICC (rausch@icc.sk)

---

## 🔗 Súvisiace Projekty

- **supplier_invoice_loader** - Generuje ISDOC XML
- **NEX Genesis ERP** - Cieľový systém
- **project-generator** - Dokumentačná inšpirácia

---

## 🚧 Aktuálne Blokery

**CRITICAL:** Potrebujeme NEX Genesis source kódy!

1. Upload do `delphi-sources/`
2. Spustiť analýzu
3. Dokumentovať databázu
4. Pokračovať s vývojom

---

**Verzia:** 0.1.0  
**Aktualizované:** 2025-10-21  
**Stav:** Aktívny Vývoj - Phase 1

🏭 **Delphi mikroslužby. Agent-driven development.**