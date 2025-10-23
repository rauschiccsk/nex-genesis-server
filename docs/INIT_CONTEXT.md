# 🚀 NEX-GENESIS-SERVER - INIT CONTEXT

**Quick Start Initialization File**  
**Version:** 1.2.0  
**Date:** 2025-10-23  
**Language:** 🇸🇰 SLOVENČINA

---

## 🤖 CRITICAL INSTRUCTIONS FOR CLAUDE

### 1. Language & Communication
- **VŽDY komunikuj PO SLOVENSKY** ✅
- Slovenčina je primárny jazyk projektu
- Technické termíny môžu byť anglicky

### 2. Automatic Initialization Sequence

**Po načítaní INIT_CONTEXT.md + project_file_access.json, AUTOMATICKY načítaj:**

```
1. docs/sessions/ → Nájdi najnovšiu session (YYYY-MM-DD_session.md)
2. Načítaj najnovšiu session → Aktuálny stav, progress, next steps
```

**Potom odpovedz:**
```
✅ Projekt načítaný. 

📊 Aktuálny stav:
[Zhrnutie z najnovšej session - progress, dokončené tasky]

📋 Posledná session: [dátum]
[Kľúčové body z session notes]

🎯 Ďalší krok:
[Next steps z session notes]

Čo robíme?
```

**DÔLEŽITÉ:** 
- Načítaj **latest session** AUTOMATICKY pri inicializácii
- Nezobrazuj XMLy ani raw content
- Len čisté zhrnutie v slovenčine
- Krátko a jasne

### 3. File Access via Manifest
S `project_file_access.json` máš prístup k 47 súborom:
- ✅ Documentation (21 súborov)
- ✅ Database schemas (6 .bdf súborov)  
- ✅ Delphi sources (7 súborov)
- ✅ Configuration (2 súbory - database.yaml)
- ✅ Python sources (11 súborov)

**Keď potrebuješ konkrétny súbor:**
1. Nájdi ho v `project_file_access.json`
2. Použiž `raw_url` na načítanie
3. Nekopíruj celé súbory - referencuj ich

### 4. Key Documents (načítaj len podľa potreby)
- **Kompletný kontext:** `docs/FULL_PROJECT_CONTEXT.md` (34KB)
- **Database štruktúra:** `docs/NEX_DATABASE_STRUCTURE.md`
- **Btrieve patterns:** `docs/architecture/database-access-pattern.md`
- **Testing guide:** `docs/TESTING_GUIDE.md`

---

## 📊 PROJEKT INFO

### Základné údaje
- **Názov:** NEX Genesis Server
- **Účel:** Python services s priamym Btrieve prístupom pre NEX Genesis ERP
- **Tech Stack:** Python 3.8+ (32-bit) + Pervasive PSQL v11 + Btrieve API
- **Developer:** ICC (rauschiccsk)
- **Location:** Komárno, SK
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server

### Aktuálny stav → Načítaj z session notes!
```
⚠️ NEČÍTAJ TENTO HARDCODED STAV!
⚠️ VŽDY načítaj najnovšiu session z docs/sessions/
⚠️ Session notes sú single source of truth
```

---

## 🗄️ DATABASE STRUCTURE

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

## 🔧 TECH STACK

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
1. C:\Program Files (x86)\Pervasive Software\PSQL\bin  ← ACTIVE
2. C:\PVSW\bin
3. external-dlls/
4. C:\Windows\SysWOW64
```

---

## 📋 CRITICAL REMINDERS

### VŽDY:
- ✅ Komunikuj PO SLOVENSKY
- ✅ Načítaj latest session pri inicializácii
- ✅ Buď konkrétný a actionable  
- ✅ Používaj emojis pre clarity
- ✅ Odkazuj na súbory cez manifest
- ✅ Validuj všetky zmeny

### NIKDY:
- ❌ Nekopíruj celé súbory do odpovede
- ❌ Nemení jazyk na angličtinu
- ❌ Nepridávaj zbytočné vysvetlenia
- ❌ Nenavrhuj zmeny bez schválenia
- ❌ Nepoužívaj hardcoded stav z INIT_CONTEXT.md
- ❌ VŽDY čítaj najnovšiu session!

### Pri každom vytvorení súboru:
```
⚠️ Nezabudni:
1. Commitnúť zmeny
2. Pushnúť na GitHub  
3. Refreshnúť project manifest ak potrebné
4. Updatnúť session notes (end of session)
```

---

## 📞 KONTAKT

- **Developer:** ICC (rausch@icc.sk)
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server
- **Location:** Komárno, SK

---

## 🔗 QUICK LINKS

- **Aktuálny stav:** `docs/sessions/` ⚠️ NAJNOVŠIA SESSION = SINGLE SOURCE OF TRUTH!
- **Full Context:** `docs/FULL_PROJECT_CONTEXT.md` (načítaj len ak nutné)
- **DB Structure:** `docs/NEX_DATABASE_STRUCTURE.md`
- **Testing:** `docs/TESTING_GUIDE.md`
- **Manifest:** `docs/project_file_access.json`

---

## 🚀 INITIALIZATION CHECKLIST

**Claude musí urobiť pri každom novom chate:**

```
☐ 1. Načítaj INIT_CONTEXT.md (tento súbor)
☐ 2. Načítaj project_file_access.json
☐ 3. Nájdi najnovšiu session v docs/sessions/
☐ 4. Načítaj najnovšiu session ← KRITICKÉ!
☐ 5. Zhrň aktuálny stav (z session)
☐ 6. Zhrň poslednú session (kľúčové body)
☐ 7. Identifikuj ďalší krok (next steps)
☐ 8. Odpovedz PO SLOVENSKY s prehľadom
```

**Výstupný formát:**
```
✅ Projekt načítaný. 

📊 Aktuálny stav:
- Progress: [z session]
- Dokončené tasky: [z session]
- Aktuálny task: [z session]

📋 Posledná session: [dátum]
- [kľúčové body z session]

🎯 Ďalší krok:
- [next steps z session]

Čo robíme?
```

---

## 📝 Session Notes Structure

**Každá session obsahuje:**
- ✅ Dokončené tasky (čo sa urobilo)
- 📁 Vytvorené/updatnuté súbory
- 🔧 Technické rozhodnutia
- 📊 Progress update
- 🎯 Next steps
- 💾 Files to commit
- 🎉 Achievements

**Session naming:** `docs/sessions/YYYY-MM-DD_session.md`

---

**REMEMBER:** 
- **AUTOMATICKY načítaj latest session**
- **Nekopíruj XML/JSON** - len zhrnutie
- **Komunikuj PO SLOVENSKY**
- **Buď konkrétny**
- **Session notes = single source of truth**

🎯