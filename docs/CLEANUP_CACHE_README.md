# Cache Cleanup Utility

Nástroje na vymazanie `__pycache__` adresárov a `.pyc` súborov z projektu.

## 🎯 Použitie

### Rýchle použitie (Windows)

**Option 1: Batch súbor (najjednoduchšie)**
```cmd
cleanup.bat
```
- Double-click alebo spusti z konzoly
- Automaticky aktivuje venv32
- Vyčistí celý projekt

**Option 2: PowerShell**
```powershell
.\cleanup.ps1                 # Základné čistenie
.\cleanup.ps1 -DryRun         # Len zobraz čo by sa vymazalo
.\cleanup.ps1 -Quiet          # Tichý režim
.\cleanup.ps1 -Path src       # Vyčisti len konkrétny adresár
```

### Python script (pokročilé)

**Základné použitie:**
```bash
python scripts/cleanup_pycache.py
```

**Dry run (len zobraz):**
```bash
python scripts/cleanup_pycache.py --dry-run
```

**Tichý režim:**
```bash
python scripts/cleanup_pycache.py --quiet
```

**Konkrétny adresár:**
```bash
python scripts/cleanup_pycache.py C:\Development\nex-genesis-server
python scripts/cleanup_pycache.py src
```

**Help:**
```bash
python scripts/cleanup_pycache.py --help
```

## 📋 Čo sa vymaže?

1. **`__pycache__` adresáre** - rekurzívne všetky v projekte
2. **`.pyc` súbory** - mimo `__pycache__` adresárov
3. **`.pyo` súbory** - optimalizované bytecode

**Čo sa NEVYMAŽE:**
- `venv/`, `venv32/`, `.venv/` - virtual environments sú chránené
- Súbory v iných adresároch (len Python cache)

## 📊 Výstup

```
📁 Adresár: C:\Development\nex-genesis-server
🔍 Nájdené:
   - __pycache__ adresáre: 12
   - .pyc súbory: 3
   - Celková veľkosť: 245.67 KB

🗑️  Mazanie...
  ✅ Vymazaný: src\__pycache__
  ✅ Vymazaný: src\btrieve\__pycache__
  ✅ Vymazaný: src\models\__pycache__
  ...

✨ Hotovo!
   - Vymazané adresáre: 12
   - Vymazané súbory: 3
   - Uvoľnené miesto: 245.67 KB
```

## 🔧 Integrácia do workflow

### Git hooks (optional)

Pridaj do `.git/hooks/pre-commit`:
```bash
#!/bin/bash
python scripts/cleanup_pycache.py --quiet
```

### VS Code Task

Pridaj do `.vscode/tasks.json`:
```json
{
    "label": "Clean Cache",
    "type": "shell",
    "command": "python",
    "args": ["scripts/cleanup_pycache.py"],
    "problemMatcher": []
}
```

### PyCharm External Tool

1. `File → Settings → Tools → External Tools`
2. Add new tool:
   - **Name:** Clean Python Cache
   - **Program:** `python`
   - **Arguments:** `scripts/cleanup_pycache.py`
   - **Working directory:** `$ProjectFileDir$`

## 🚨 Kedy použiť?

**Typické scenáre:**
- ✅ Po prepnutí Python verzií (3.8 ↔ 3.13)
- ✅ Po zmene virtual environments
- ✅ Pri chybách typu "ImportError" alebo "ModuleNotFoundError"
- ✅ Pred testovaním po významných zmenách
- ✅ Pri problémoch s hot-reload
- ✅ Pred vytvorením distribučného balíčka

**Preventívne:**
- 🔄 Raz týždenne (údržba)
- 🔄 Pred každým release
- 🔄 Po git pull (ak niekto commitol .pyc)

## 📝 .gitignore

Uisti sa že máš v `.gitignore`:
```gitignore
# Python Cache
__pycache__/
*.py[cod]
*$py.class
*.so

# Virtual Environments
venv/
venv32/
.venv
```

## 🎯 Best Practices

1. **Spúšťaj pravidelně** - zabraň akumulácii cache súborov
2. **Vždy po prepnutí Python verzie** - kritické!
3. **Pri problémoch s importami** - prvá pomoc
4. **Použiť --dry-run najprv** - overiť čo sa vymaže

## 💡 Technické detaily

**Čo robí script:**
1. Rekurzívne prehľadá projekt od root
2. Nájde všetky `__pycache__` adresáre
3. Nájde všetky `.pyc` súbory mimo `__pycache__`
4. Vypočíta celkovú veľkosť
5. Vymaže všetko (alebo len zobrazí pri --dry-run)
6. Zobrazí štatistiku

**Výkon:**
- Rýchle: ~100ms pre malé projekty
- Bezpečné: skip venv directories
- Verbose: detailné info o každom kroku

## 🐛 Troubleshooting

**Problem:** "Permission denied"
- **Riešenie:** Zavri všetky Python procesy, IDE, atď.

**Problem:** Script nenájde súbory
- **Riešenie:** Spusti z root adresára projektu

**Problem:** Venv32 sa neaktivuje
- **Riešenie:** Spusti manuálne `.\venv32\Scripts\activate` a potom cleanup

---

**Vytvorené:** 2025-10-23  
**Autor:** ICC  
**Projekt:** NEX Genesis Server