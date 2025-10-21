# 📋 Project File Access Manifests - Používateľská Príručka

**Projekt:** NEX Genesis Server  
**Účel:** Optimalizované manifesty pre prácu s Claude AI  
**Verzia:** 2.0 (Split manifests)

---

## 🎯 Prečo Rozdelené Manifesty?

**Problém:**
- Pôvodný `project_file_access.json` mal 20 000+ riadkov
- Spotreboval príliš veľa tokenov v Claude
- Pomalé načítanie
- Obsahoval zbytočné súbory pre konkrétne úlohy

**Riešenie:**
- Rozdelenie na 4 špecializované manifesty
- Každý manifest obsahuje len relevantné súbory
- Rýchlejšie načítanie, menšia spotreba tokenov

---

## 📦 Dostupné Manifesty

### 1️⃣ CONTEXT Manifest (Pre Claude - Dokumentácia)

**Súbor:** `project_file_access_CONTEXT.json`  
**Veľkosť:** ~500 riadkov  
**GitHub URL:**
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_CONTEXT.json
```

**Obsahuje:**
```
docs/
├── FULL_PROJECT_CONTEXT.md          # Kompletný kontext projektu
├── MASTER_CONTEXT.md                # Rýchla referencia
├── SYSTEM_PROMPT_DATABASE.md        # Database patterns
├── architecture/
│   └── database-access-pattern.md   # NEX Genesis DB prístup
└── sessions/                        # Session notes
```

**Použitie:**
```markdown
Keď pracuješ s Claude na:
- Projektovej dokumentácii
- Plánovaní features
- Aktualizácii dokumentov
- Všeobecnej práci bez analýzy kódu

→ Toto je DEFAULT manifest pre väčšinu úloh!
```

---

### 2️⃣ DELPHI Manifest (Delphi Source Codes)

**Súbor:** `project_file_access_delphi.json`  
**Veľkosť:** ~15 000 riadkov  
**GitHub URL:**
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_delphi.json
```

**Obsahuje:**
```
delphi-sources/
├── DataTables/
│   ├── bBARCODE.pas      # Auto-generované wrappery
│   ├── hBARCODE.pas      # Business logic handlers
│   └── NexBtrTable.pas   # Low-level Pervasive engine
├── Common/
├── DataModules/
├── Libraries/
├── Business/
└── UI/
```

**Použitie:**
```markdown
Keď pracuješ s Claude na:
- Analýze NEX Genesis patterns
- Pochopení databázového prístupu
- Generovaní nových h*.pas handlers
- Reverse engineering existujúceho kódu

→ Načítaj len keď potrebuješ analyzovať Delphi kód!
```

---

### 3️⃣ OUTPUT Manifest (Generované Mikroslužby)

**Súbor:** `project_file_access_output.json`  
**Veľkosť:** ~100 riadkov  
**GitHub URL:**
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_output.json
```

**Obsahuje:**
```
output/
├── NEXGenesisServer.dpr     # Main project
├── ProductService.pas       # Product mikroslužba
├── WarehouseService.pas     # Warehouse mikroslužba
├── ISDOCParser.pas          # XML parser
├── HTTPServer.pas           # REST API server
└── Config.pas               # Configuration
```

**Použitie:**
```markdown
Keď pracuješ s Claude na:
- Vygenerovaných mikroslužbách
- Debugging REST API
- Refactoring services
- Testing mikroslužieb

→ Načítaj len keď pracuješ s output/ adresárom!
```

---

### 4️⃣ TEMPLATES Manifest (Templates & Scripts)

**Súbor:** `project_file_access_templates.json`  
**Veľkosť:** ~50 riadkov  
**GitHub URL:**
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_templates.json
```

**Obsahuje:**
```
templates/
├── service_template.pas
├── h_table_handler_template.pas
└── endpoint_template.pas

scripts/
├── generate_project_access.py
└── analyze_delphi_code.py

config/
├── server_config.ini.template
└── database_config.ini.template
```

**Použitie:**
```markdown
Keď pracuješ s Claude na:
- Code generation z templates
- Vytváraní nových služieb
- Scripting úlohách
- Configuration setup

→ Načítaj len keď generuješ nový kód!
```

---

### 📋 INDEX Manifest (Prehľad)

**Súbor:** `project_file_access_INDEX.json`  
**Veľkosť:** ~50 riadkov  
**GitHub URL:**
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_INDEX.json
```

**Obsahuje:**
```json
{
  "manifests": {
    "context": { "file": "...", "description": "...", "use_case": "..." },
    "delphi": { "file": "...", "description": "...", "use_case": "..." },
    "output": { "file": "...", "description": "...", "use_case": "..." },
    "templates": { "file": "...", "description": "...", "use_case": "..." }
  }
}
```

**Použitie:**
```markdown
Keď nie si istý, ktorý manifest načítať:
1. Načítaj INDEX manifest
2. Prečítaj si use_cases
3. Načítaj správny manifest

→ Toto je "katalóg" všetkých manifestov!
```

---

## 🚀 Quick Start Workflows

### Workflow 1: Nový Chat - Dokumentácia (Most Common)

```markdown
1. Otvor nový Claude chat
2. Pošli URL:
   https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

3. (Optional) Ak Claude potrebuje konkrétne súbory:
   https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_CONTEXT.json

✅ Done! Claude má prístup k celej dokumentácii.
```

### Workflow 2: Analýza Delphi Kódu

```markdown
1. Pošli FULL_PROJECT_CONTEXT.md (ako vyššie)
2. Pošli CONTEXT manifest (dokumentácia)
3. Pošli DELPHI manifest:
   https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_delphi.json

✅ Claude má prístup k dokumentácii + Delphi kódom.
```

### Workflow 3: Code Generation

```markdown
1. Pošli FULL_PROJECT_CONTEXT.md
2. Pošli CONTEXT manifest
3. Pošli TEMPLATES manifest:
   https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_templates.json

✅ Claude môže generovať kód z templates.
```

### Workflow 4: Full Project Access (Zriedkavé)

```markdown
1. Pošli FULL_PROJECT_CONTEXT.md
2. Pošli INDEX manifest
3. Načítaj len tie manifesty, ktoré skutočne potrebuješ

⚠️ Neodporúčam načítať všetky manifesty naraz! (token limit)
```

---

## 🔄 Generovanie Manifestov

### Kedy Regenerovať?

⚠️ **VŽDY po:**
- Pridaní nového .md súboru do docs/
- Pridaní nového .pas súboru do delphi-sources/
- Vytvorení template v templates/
- Vygenerovaní mikroslužby do output/
- Commit pred push na GitHub

### Ako Regenerovať?

```powershell
# V PyCharm alebo CMD
cd c:\Development\nex-genesis-server
python scripts\generate_project_access.py
```

**Output:**
```
===================================================================
🏭 NEX-GENESIS-SERVER - Project File Access Generator (SPLIT)
===================================================================

1️⃣  CONTEXT Manifest (for Claude)
   📁 Scanning docs/...
   ✅ Found 12 files in docs/
   ✅ Generated: project_file_access_CONTEXT.json
   📊 Total files: 12

2️⃣  DELPHI Manifest
   📁 Scanning delphi-sources/...
   ✅ Found 237 files in delphi-sources/
   ✅ Generated: project_file_access_delphi.json
   📊 Total files: 237

3️⃣  OUTPUT Manifest
   📁 Scanning output/...
   ✅ Found 8 files in output/
   ✅ Generated: project_file_access_output.json
   📊 Total files: 8

4️⃣  TEMPLATES Manifest
   📁 Scanning templates/...
   ✅ Found 5 files in templates/
   ✅ Generated: project_file_access_templates.json
   📊 Total files: 5

✅ ALL MANIFESTS GENERATED SUCCESSFULLY!
```

### Commit Po Regenerácii

```powershell
# V PyCharm Git panel
git add docs/project_file_access_*.json
git commit -m "chore: refresh project file access manifests"
git push
```

---

## 📊 Porovnanie: Pred vs. Po

### PRED (Monolitický súbor)
```
❌ project_file_access.json
   - 20 000+ riadkov
   - 500 KB+
   - Všetko v jednom súbore
   - Token limit problémy
   - Pomalé načítanie
```

### PO (Rozdelené manifesty)
```
✅ project_file_access_CONTEXT.json    (~500 riadkov)
✅ project_file_access_delphi.json     (~15000 riadkov)
✅ project_file_access_output.json     (~100 riadkov)
✅ project_file_access_templates.json  (~50 riadkov)
✅ project_file_access_INDEX.json      (~50 riadkov)

Benefits:
+ Optimálna spotreba tokenov
+ Rýchlejšie načítanie
+ Lepšia organizácia
+ Flexibilné použitie
```

---

## 💡 Best Practices

### ✅ DO:
- Vždy začni s CONTEXT manifestom (dokumentácia)
- Načítaj len manifesty, ktoré potrebuješ
- Regeneruj manifesty po pridaní súborov
- Commit manifesty do Git

### ❌ DON'T:
- Nenačítaj všetky manifesty naraz (token limit!)
- Nezabúdaj regenerovať po zmenách
- Neupravuj JSON súbory manuálne (použite script!)

---

## 🆘 Troubleshooting

### Problém: "Manifest súbor nie je aktuálny"
**Riešenie:**
```powershell
python scripts\generate_project_access.py
git add docs/project_file_access_*.json
git commit -m "chore: refresh manifests"
git push
```

### Problém: "Claude hovorí, že súbor neexistuje"
**Riešenie:**
1. Skontroluj či súbor existuje v správnom adresári
2. Regeneruj manifesty
3. Skontroluj GitHub či sú manifesty pushnuté

### Problém: "Token limit exceeded"
**Riešenie:**
- Nenačítaj všetky manifesty naraz!
- Použij len CONTEXT manifest pre dokumentáciu
- Načítaj DELPHI manifest len keď analyzuješ kód

---

## 📞 Support

**Otázky?** Pozri:
- `docs/FULL_PROJECT_CONTEXT.md` - Kompletný kontext projektu
- `docs/architecture/database-access-pattern.md` - Database patterns
- GitHub Issues: https://github.com/rauschiccsk/nex-genesis-server/issues

---

**Verzia:** 2.0  
**Vytvorené:** 2025-10-21  
**Projekt:** NEX Genesis Server  
**Autor:** ICC (rauschiccsk)

🏭 **Optimalizované manifesty pre efektívnu prácu s Claude AI!** ✨