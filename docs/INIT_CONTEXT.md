# NEX-GENESIS-SERVER - INIT CONTEXT

**Quick Start Initialization File**  
**Version:** 1.4.0  
**Date:** 2025-10-23  
**Language:** SLOVENČINA

---

## CRITICAL INSTRUCTIONS FOR CLAUDE

### 1. Language & Communication
- **VŽDY komunikuj PO SLOVENSKY**
- Slovenčina je primárny jazyk projektu
- Technické termíny môžu byť anglicky
- **Token info na konci KAŽDEJ odpovede:**
```
  Token usage: X / 190,000 tokens used (Y.Y%) | Z remaining
```

### 2. FILE LOADING - CRITICAL RULE 🛑

**Ak nemôžeš načítať súbor z project_file_access.json:**

```
🛑 STOP - FILE LOADING FAILED

Súbor: [názov súboru]
URL: [raw_url z manifestu]
Problém: [popis - napr. GitHub cache, permissions, etc]

AKCIA POTREBNÁ:
1. User musí regenerovať manifest: python scripts/generate_project_access.py
2. User musí commitnúť a pushnúť zmeny
3. User musí restartovať chat s novým cache version

NEPOKRAČUJEM bez prístupu k aktuálnym súborom!
```

**NIKDY:**
- ❌ Nevymýšľaj workaroundy (cache busting, alternative URLs)
- ❌ Nepokračuj s prácou na základe starých/cached dát
- ❌ Neproš používateľa o manuálne URLs

**VŽDY:**
- ✅ STOP immediately ak file loading fails
- ✅ Informuj používateľa o presnom probléme
- ✅ Poskytni konkrétne kroky na fix

### 3. Automatic Initialization Sequence

**Po načítaní INIT_CONTEXT.md + project_file_access.json, AUTOMATICKY načítaj:**

```
1. docs/sessions/ → Nájdi najnovšiu session (YYYY-MM-DD_session.md)
2. Načítaj najnovšiu session → Aktuálny stav, progress, next steps
3. AK ZLYHÁ NAČÍTANIE → STOP podľa pravidla #2
```

**Potom odpovedz:**
```
Projekt načítaný. 

Aktuálny stav:
[Zhrnutie z najnovšej session - progress, dokončené tasky]

Posledná session: [dátum]
[Kľúčové body z session notes]

Ďalší krok:
[Next steps z session notes]

Čo robíme?
```

**DÔLEŽITÉ:** 
- Načítaj **latest session** AUTOMATICKY pri inicializácii
- AK ZLYHÁ → použiť pravidlo 🛑 STOP
- Nezobrazuj XMLy ani raw content
- Len čisté zhrnutie v slovenčine
- Krátko a jasne

### 4. File Access via Manifest

S `project_file_access.json` máš prístup k ~73 súborom.

**Každý súbor má:**
```json
{
  "path": "docs/sessions/2025-10-23_session.md",
  "raw_url": "https://raw.githubusercontent.com/.../file.md?v=TIMESTAMP",
  "size": 11836,
  "category": "documentation"
}
```

**Keď potrebuješ konkrétny súbor:**
1. Nájdi ho v `project_file_access.json`
2. Použiž `raw_url` (s cache version parametrom)
3. AK ZLYHÁ → 🛑 STOP
4. Nekopíruj celé súbory - referencuj ich

**Cache Version:**
- Každá URL obsahuje `?v=TIMESTAMP` parameter
- Zabezpečuje fresh content z GitHubu
- User regeneruje manifest po každom push

### 5. Key Documents (načítaj len podľa potreby)
- **Kompletný kontext:** `docs/FULL_PROJECT_CONTEXT.md` (34KB)
- **Database štruktúra:** `docs/NEX_DATABASE_STRUCTURE.md`
- **Btrieve patterns:** `docs/architecture/database-access-pattern.md`
- **Testing guide:** `docs/TESTING_GUIDE.md`

---

## PROJEKT INFO

### Základné údaje
- **Názov:** NEX Genesis Server
- **Účel:** Python services s priamym Btrieve prístupom pre NEX Genesis ERP
- **Tech Stack:** Python 3.8+ (32-bit) + Pervasive PSQL v11 + Btrieve API
- **Developer:** ICC (rauschiccsk)
- **Location:** Komárno, SK
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server

### Aktuálny stav -> Načítaj z session notes!
```
NEČÍTAJ TENTO HARDCODED STAV!
VŽDY načítaj najnovšiu session z docs/sessions/
Session notes sú single source of truth
AK ZLYHÁ NAČÍTANIE → 🛑 STOP
```

---

## DATABASE STRUCTURE

### NEX Genesis Database
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

### Kľúčové tabuľky
- **GSCAT** - Produktový katalóg (master)
- **BARCODE** - Čiarové kódy produktov
- **PAB** - Dodávatelia/odberatelia
- **TSH/TSI** - Dodacie listy

---

## TECH STACK

### Core Technologies
- **Python:** 3.8+ (32-bit required!)
- **Database:** Pervasive PSQL v11 (Btrieve)
- **DLL Access:** ctypes (direct approach)
- **Config:** YAML
- **Testing:** pytest

### Critical Files
- `src/btrieve/btrieve_client.py` - Btrieve wrapper
- `src/utils/config.py` - Config loader
- `config/database.yaml` - Database configuration
- `tests/test_btrieve_*.py` - Testing suite

### Pervasive DLL Paths (Priority Order)
```
1. C:\Program Files (x86)\Pervasive Software\PSQL\bin  <- ACTIVE
2. C:\PVSW\bin
3. external-dlls/
4. C:\Windows\SysWOW64
```

---

## CRITICAL REMINDERS

### VŽDY:
- Komunikuj PO SLOVENSKY
- Načítaj latest session pri inicializácii
- **AK ZLYHÁ FILE LOADING → 🛑 STOP**
- Buď konkrétny a actionable  
- Používaj emojis pre clarity (v odpovediach, NIE v INIT_CONTEXT.md)
- Odkazuj na súbory cez manifest
- Validuj všetky zmeny

### NIKDY:
- Nekopíruj celé súbory do odpovede
- Nemení jazyk na angličtinu
- Nepridávaj zbytočné vysvetlenia
- Nenavrhuj zmeny bez schválenia
- Nepoužívaj hardcoded stav z INIT_CONTEXT.md
- **NEPOKRAČUJ ak nemôžeš načítať súbory**
- **NEVYMÝŠĽAJ workaroundy pre file loading issues**

### Pri každom vytvorení súboru:
```
Nezabudni:
1. Commitnúť zmeny
2. Pushnúť na GitHub  
3. Regenerovať manifest: python scripts/generate_project_access.py
4. Updatnúť session notes (end of session)
```

---

## KONTAKT

- **Developer:** ICC (rausch@icc.sk)
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server
- **Location:** Komárno, SK

---

## QUICK LINKS

- **Aktuálny stav:** `docs/sessions/` NAJNOVŠIA SESSION = SINGLE SOURCE OF TRUTH!
- **Full Context:** `docs/FULL_PROJECT_CONTEXT.md` (načítaj len ak nutné)
- **DB Structure:** `docs/NEX_DATABASE_STRUCTURE.md`
- **Testing:** `docs/TESTING_GUIDE.md`
- **Manifest:** `docs/project_file_access.json`

---

## INITIALIZATION CHECKLIST

**Claude musí urobiť pri každom novom chate:**

```
1. Načítaj INIT_CONTEXT.md (tento súbor)
2. Načítaj project_file_access.json
3. Nájdi najnovšiu session v docs/sessions/
4. Načítaj najnovšiu session <- KRITICKÉ!
   → AK ZLYHÁ: 🛑 STOP a informuj usera
5. Zhrň aktuálny stav (z session)
6. Zhrň poslednú session (kľúčové body)
7. Identifikuj ďalší krok (next steps)
8. Odpovedz PO SLOVENSKY s prehľadom
```

**Výstupný formát:**
```
Projekt načítaný. 

Aktuálny stav:
- Progress: [z session]
- Dokončené tasky: [z session]
- Aktuálny task: [z session]

Posledná session: [dátum]
- [kľúčové body z session]

Ďalší krok:
- [next steps z session]

Čo robíme?
```

---

## Session Notes Structure

**Každá session obsahuje:**
- Dokončené tasky (čo sa urobilo)
- Vytvorené/updatnuté súbory
- Technické rozhodnutia
- Progress update
- Next steps
- Files to commit
- Achievements

**Session naming:** `docs/sessions/YYYY-MM-DD_session.md`

---

## TROUBLESHOOTING

### Problem: Nemôžem načítať súbor z manifestu

**Symptómy:**
- web_fetch vracia starý cached obsah
- Súbor bol updatnutý na GitHube ale vidím starú verziu
- Error pri načítaní súboru

**Riešenie:**
```bash
# User musí:
1. cd C:\Development\nex-genesis-server
2. python scripts/generate_project_access.py
3. git add docs/project_file_access.json
4. git commit -m "Regenerated manifest with fresh cache version"
5. git push
6. Reštartovať Claude chat s novými URLs
```

**Claude:**
- 🛑 STOP immediately
- Informuj usera o presnom probléme
- Poskytni kroky vyššie
- NEPOKRAČUJ s prácou

---

**REMEMBER:** 
- **AUTOMATICKY načítaj latest session**
- **AK ZLYHÁ FILE LOADING → 🛑 STOP**
- **Nekopíruj XML/JSON** - len zhrnutie
- **Komunikuj PO SLOVENSKY**
- **Buď konkrétny**
- **Session notes = single source of truth**