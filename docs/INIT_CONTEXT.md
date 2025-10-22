# 🚀 NEX-GENESIS-SERVER - INIT CONTEXT

**Quick Start Initialization File**  
**Version:** 1.0.0  
**Date:** 2025-10-22  
**Language:** 🇸🇰 SLOVENČINA

---

## 🤖 CRITICAL INSTRUCTIONS FOR CLAUDE

### 1. Language & Communication
- **VŽDY komunikuj PO SLOVENSKY** ✅
- Slovenčina je primárny jazyk projektu
- Technické termíny môžu byť anglicky

### 2. Initialization Complete
Po načítaní tohto súboru + `project_file_access.json` odpovedz:

```
✅ Projekt načítaný. Čo robíme?
```

**NIČ VIAC!** Žiadne vysvetlenia, žiadne otázky.

### 3. File Access
S `project_file_access.json` máš prístup k:
- ✅ Všetkej dokumentácii (21 súborov)
- ✅ Database schémam (6 .bdf súborov)  
- ✅ Delphi source kódom (7 súborov)
- ✅ Config súborom (database.yaml)
- ✅ Python source kódom (11 súborov)

**Keď potrebuješ konkrétny súbor:**
1. Nájdi ho v `project_file_access.json`
2. Použiž `raw_url` na načítanie
3. Nekopíruj celé súbory - odkazuj na ne

### 4. Key Documents
Pri potrebe načítaj:
- **Kompletný kontext:** `docs/FULL_PROJECT_CONTEXT.md` (34KB - načítaj len ak treba)
- **Database štruktúra:** `docs/NEX_DATABASE_STRUCTURE.md`
- **Btrieve patterns:** `docs/architecture/database-access-pattern.md`
- **Testing guide:** `docs/TESTING_GUIDE.md`
- **Session notes:** `docs/sessions/2025-10-22_session.md`

---

## 📊 PROJEKT INFO

### Základné údaje
- **Názov:** NEX Genesis Server
- **Účel:** Python services s priamym Btrieve prístupom pre NEX Genesis ERP
- **Tech Stack:** Python 3.8+ (32-bit) + Pervasive PSQL v11 + Btrieve API
- **Developer:** ICC (rauschiccsk)
- **Location:** Komárno, SK
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server

### Aktuálny stav
- **Phase:** 1 - Setup & Stratégia  
- **Progress:** 70% (7/10 taskov)
- **Active Task:** Task 1.7 - Python Btrieve Setup (90% complete)
- **Blocker:** Error 11 - Database name registration issue

### Nedávne úspechy
- ✅ DLL loading works (Pervasive PSQL v11.30)
- ✅ Multi-path DLL search implemented
- ✅ Config loading functional
- ✅ 32-bit Python setup complete

---

## 🎯 WORKFLOW

### Pre nový chat (TENTO PROCES):
1. Načítaj `INIT_CONTEXT.md` (tento súbor)
2. Načítaj `project_file_access.json`
3. Odpovedz: **"✅ Projekt načítaný. Čo robíme?"**
4. Pokračuj podľa požiadaviek používateľa

### Počas práce:
- **Komunikuj PO SLOVENSKY** 
- Buď konkrétny a actionable
- Používaj emojis (✅ ❌ 🔄 📋)
- Odkazuj na súbory cez `project_file_access.json`
- Načítaj detailnú dokumentáciu len keď potrebuješ

### Git workflow:
- **Commit messages** - Claude poskytuje čistý text (bez `git commit -m`)
- Používateľ kopíruje do PyCharm Git UI
- Slovenské commit messages OK

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

### Pervasive DLL Paths
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
- ✅ Buď konkrétny a actionable  
- ✅ Používaj emojis pre clarity
- ✅ Odkazuj na súbory cez manifest
- ✅ Validuj všetky zmeny

### NIKDY:
- ❌ Nekopíruj celé súbory do odpovede
- ❌ Nemení jazyk na angličtinu
- ❌ Nepridávaj zbytočné vysvetlenia
- ❌ Nenavrhuj zmeny bez schválenia

### Pri každom vytvorení súboru:
```
⚠️ Nezabudni:
1. Commitnúť zmeny
2. Pushnúť na GitHub  
3. Refreshnúť project manifest ak potrebné
```

---

## 🎯 NEXT STEPS

### Aktuálne priority:
1. **Vyriešiť Error 11** - Database registration v Pervasive
2. Dokončiť Task 1.7 - Python Btrieve Setup
3. Task 1.8 - Database schema dokumentácia
4. Task 1.9 - Python record layouts

### Known Issues:
- **Error 11** - File name invalid (database not registered)
- Pervasive Engine môže potrebovať database registration

---

## 📞 KONTAKT

- **Developer:** ICC (rausch@icc.sk)
- **GitHub:** https://github.com/rauschiccsk/nex-genesis-server
- **Location:** Komárno, SK

---

## 🔗 QUICK LINKS

- **Full Context:** `docs/FULL_PROJECT_CONTEXT.md` (načítaj len ak nutné)
- **DB Structure:** `docs/NEX_DATABASE_STRUCTURE.md`
- **Testing:** `docs/TESTING_GUIDE.md`
- **Latest Session:** `docs/sessions/2025-10-22_session.md`
- **Manifest:** `docs/project_file_access.json`

---

**REMEMBER:** Po načítaní odpovedz len: **"✅ Projekt načítaný. Čo robíme?"**

**NIČ VIAC!** 🎯