# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

---

## [0.2.0] - 2025-10-21

### 🎯 Strategické rozhodnutie: Pure Python Btrieve

**Major Change:** Zvolený Pure Python Btrieve prístup namiesto Delphi mikroslužby.

### Added
- ✅ Pridané **reálne .bdf súbory** z NEX Genesis do `database-schema/`
  - barcode.bdf (Čiarové kódy produktov)
  - gscat.bdf (Produktový katalóg)
  - mglst.bdf (Tovarové skupiny)
  - pab.bdf (Obchodní partneri)
  - tsh.bdf (Dodacie listy header)
  - tsi.bdf (Dodacie listy items)
- ✅ Pridané **NEX Genesis Btrieve wrappery** do `delphi-sources/`
  - BtrApi32.pas (Btrieve API)
  - BtrConst.pas (Constants)
  - BtrHand.pas (Handler)
  - BtrStruct.pas (Structures)
  - BtrTable.pas (Table wrapper)
  - BtrTools.pas (Utilities)
  - SqlApi32.pas (SQL API)
- ✅ Pridané **Pervasive DLLs** do `external-dlls/`
  - wdbnames.dll
  - wdbnm32.dll
  - wssql32.dll
  - wxqlcall.dll
- ✅ Vytvorené README súbory:
  - `database-schema/README.md` (dokumentácia .bdf súborov)
  - `delphi-sources/README.md` (dokumentácia Delphi wrapperov)
  - `external-dlls/README.md` (dokumentácia DLLs)
  - `docs/README.md` (manifest dokumentácia)
- ✅ Vytvorený `CHANGELOG.md` (version tracking)
- ✅ Nové JSON manifesty:
  - `project_file_access_delphi.json` (7 Delphi sources)
  - `project_file_access_bdf.json` (6 BDF schemas) ⭐ **NEW**
  - `project_file_access_docs.json` (Documentation) ⭐ **NEW**
- ✅ Aktualizovaný `generate_project_access.py` (multi-extension support)
- ✅ Pridaný `generate_bdf_manifest.py` (helper script)

### Changed
- 🔄 Aktualizovaný `FULL_PROJECT_CONTEXT.md` na v0.2.0
  - Reálna NEX Genesis databázová schéma (TSH/TSI namiesto ISCAT/ISDET)
  - PAB namiesto CRDAT pre partnerov
  - Pridaná BARCODE tabuľka (samostatné čiarové kódy)
  - Pridaná MGLST tabuľka (tovarové skupiny)
  - Aktualizovaná architektúra
  - Pridaná sekcia PROJECT MANIFESTS
  - Aktualizovaná štruktúra projektu (database-schema, delphi-sources, external-dlls)
- 🔄 Aktualizovaný `README.md`
  - Python focus
  - Btrieve 2 API
  - Nová architektúra
- 🔄 Aktualizovaný `.gitignore`
  - Python specifické ignorovanie
  - SWIG generated files
  - Build artifacts
  - External DLLs tracked

### Removed
- ❌ Nič nevymazané - všetko ponechané ako referencia

### Technical
- **Database Schema:** Reálne NEX Genesis tabuľky (6 .bdf súborov)
- **Delphi Reference:** 7 Btrieve wrapper súborov
- **External DLLs:** 4 Pervasive DLL súbory
- **Tech Stack:** Python 3.8+ + Btrieve 2 API
- **Database Access:** Direct Btrieve (file-based)
- **Architecture:** Python microservices

### Database Tables
- **GSCAT** - Produktový katalóg
- **BARCODE** - Čiarové kódy (1:N vzťah s GSCAT)
- **MGLST** - Tovarové skupiny
- **PAB** - Obchodní partneri (dodávatelia)
- **TSH** - Dodacie listy (header)
- **TSI** - Dodacie listy (items)

---

## [0.1.0] - 2025-10-21

### 🚀 Initial Setup

### Added
- ✅ GitHub repository vytvorený
- ✅ Základná projektová štruktúra
- ✅ Dokumentácia:
  - `FULL_PROJECT_CONTEXT.md` v0.1.0
  - `README.md`
  - Adresárová štruktúra
- ✅ Scripts:
  - `generate_project_access.py`
  - `create_directory_structure.py`
- ✅ Config templates
- ✅ `.gitignore`

### Technical
- **Initial Strategy:** Delphi mikroslužba (later changed to Python)
- **Repository:** https://github.com/rauschiccsk/nex-genesis-server
- **Local Path:** c:\Development\nex-genesis-server

---

## Upcoming

### [0.3.0] - Planned
- [ ] Python Btrieve Setup (Task 1.7)
- [ ] Databázová schéma dokumentácia (Task 1.8)
- [ ] Python record layouts (Task 1.9)
- [ ] ISDOC XML mapping (Task 1.10)

### [0.4.0] - Planned (Phase 2)
- [ ] BtrieveClient wrapper implementation
- [ ] ProductService implementation
- [ ] WarehouseReceiptService implementation
- [ ] SupplierService implementation

---

## Version Numbering

- **Major (X.0.0):** Breaking changes, major milestones
- **Minor (0.X.0):** New features, phases complete
- **Patch (0.0.X):** Bug fixes, documentation updates

---

**Current Version:** 0.2.0  
**Current Phase:** Phase 1 - Setup & Stratégia (50% complete)  
**Next Milestone:** Python Btrieve Setup (Task 1.7)