# Commit and Push Instructions

**Location:** `docs/COMMIT_AND_PUSH.md`

---

## 📝 Commit Message

```
feat(btrieve): Add Python Btrieve client with 32-bit support

Task 1.7b - Python Btrieve Setup (70% complete, blocked on DLL)

### Added
- Python Btrieve client wrapper (ctypes-based)
- YAML configuration system for database paths
- 3-level testing framework (basic, file, data)
- 32-bit Python requirement and installation guides
- DLL diagnostics and debugging tools
- Database structure documentation (STORES/DIALS)
- requirements-minimal.txt for development

### Core Features
- src/btrieve/btrieve_client.py - Btrieve API wrapper
- src/utils/config.py - Configuration loader
- config/database.yaml - Database configuration
- tests/test_btrieve_*.py - Test suites (3 levels)
- scripts/check_python_version.py - Python checker
- scripts/debug_dll_loading.py - DLL diagnostics

### Documentation
- docs/NEX_DATABASE_STRUCTURE.md - DB schema
- docs/TESTING_GUIDE.md - Testing procedures
- docs/PERVASIVE_DLL_INFO.md - DLL details
- docs/PYTHON_VERSION_REQUIREMENTS.md - 32-bit requirement
- docs/INSTALL_32BIT_PYTHON.md - Installation guide
- docs/BTRIEVE_BRIDGE_SERVICE.md - Future 64-bit solution
- docs/session/2025-10-22_session.md - Session notes
- README_32BIT_PYTHON.md - Quick start

### Database Structure Corrections
- Fixed: STORES (not STKDAT) for stock management
- Fixed: DIALS (not STKDAT) for reference tables
- Fixed: PAB00000.BTR (not PAB.00000.BTR)
- Fixed: TSH/TSI naming (TSHA-001.BTR format)

### Technical Decisions
- 32-bit Python REQUIRED (Pervasive PSQL v11 is 32-bit)
- ctypes direct DLL access (not SWIG)
- requirements-minimal.txt (avoids Visual C++ Build Tools)
- Split manifests (docs, bdf, delphi)

### Known Issues
- BLOCKED: wxqlcall.dll in external-dlls/ is not valid PE file
- Need to source correct Pervasive PSQL v11 DLLs
- httptools requires Visual C++ Build Tools (deferred)

### Progress
- Phase 1: 70% (7/10 tasks, Task 1.7 at 70%)
- Task 1.7b blocked on DLL loading issue
- All infrastructure ready for Btrieve operations

### Next Steps
1. Find correct wxqlcall.dll from Pervasive installation
2. Complete Task 1.7 testing
3. Proceed to Task 1.8 (Database schema)

Files: 24 new, 3 updated
LOC: ~4500 lines (code + docs)
Time: 6 hours
```

---

## 🚀 Git Commands

### 1. Stage všetky nové súbory

```powershell
# V PyCharm: Commit tool (Ctrl+K)
# Alebo v termináli:

cd C:\Development\nex-genesis-server

# Add všetky nové súbory
git add config/database.yaml
git add src/btrieve/
git add src/utils/
git add tests/test_btrieve_*.py
git add scripts/check_python_version.py
git add scripts/debug_dll_loading.py
git add docs/NEX_DATABASE_STRUCTURE.md
git add docs/TESTING_GUIDE.md
git add docs/PERVASIVE_DLL_INFO.md
git add docs/PYTHON_VERSION_REQUIREMENTS.md
git add docs/INSTALL_32BIT_PYTHON.md
git add docs/BTRIEVE_BRIDGE_SERVICE.md
git add docs/session/2025-10-22_session.md
git add docs/session/README.md
git add README_32BIT_PYTHON.md
git add requirements-minimal.txt

# Updated files
git add requirements.txt
git add CHANGELOG.md
git add docs/FULL_PROJECT_CONTEXT.md
```

### 2. Commit (v PyCharm alebo CLI)

**V PyCharm:**
```
1. Ctrl+K (Commit window)
2. Select all new/modified files
3. Paste commit message (from above)
4. Klikni "Commit and Push"
```

**V CLI:**
```powershell
git commit -m "feat(btrieve): Add Python Btrieve client with 32-bit support

Task 1.7b - Python Btrieve Setup (70% complete)

Added Python Btrieve wrapper, config system, testing framework,
and comprehensive documentation. Blocked on DLL loading issue.

See docs/session/2025-10-22_session.md for details."
```

### 3. Push na GitHub

```powershell
git push origin main
```

**Alebo v PyCharm:**
```
Ctrl+Shift+K (Push dialog)
→ Push
```

---

## ✅ Verifikácia

Po push, over na GitHub:

```
https://github.com/rauschiccsk/nex-genesis-server

Skontroluj:
✅ Všetky nové súbory sú tam
✅ CHANGELOG.md aktualizovaný
✅ docs/ directory má nové súbory
✅ Commit message je čitateľný
```

---

## 📋 Checklist pred push

- [ ] Všetky súbory staged
- [ ] Commit message skopírovaný
- [ ] Commit vytvorený
- [ ] Push na GitHub
- [ ] Verifikácia na GitHub web
- [ ] docs/SESSION_SUMMARY_2025-10-22.md pushed
- [ ] CHANGELOG.md updated

---

## 🔄 Pre nový chat

**Štart nového chatu:**

```
Načítaj project context:
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

Pozri session summary:
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/session/2025-10-22_session.md

AKTUÁLNY STAV:
- Task 1.7b: 70% complete, blocked on DLL issue
- Potrebujeme nájsť správne wxqlcall.dll
- Všetko ostatné pripravené a funguje

ĎALŠÍ KROK:
Vyriešiť DLL loading issue a dokončiť Task 1.7
```

---

## 💡 Tips

### Git v PyCharm
- `Ctrl+K` - Commit
- `Ctrl+Shift+K` - Push
- `Alt+9` - Version Control tool window

### Ignore files
Už v `.gitignore`:
- venv32/
- __pycache__/
- *.pyc
- .pytest_cache/

### Branch strategy
- `main` - stable code
- Feature branches pre veľké features (optional)

---

**Ready to commit and push! 🚀**