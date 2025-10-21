# 📚 Project Documentation

Tento adresár obsahuje všetku projektovú dokumentáciu pre **NEX Genesis Server**.

---

## 📋 Hlavné dokumenty

### FULL_PROJECT_CONTEXT.md
**Hlavný kontext projektu** - obsahuje VŠETKO:
- Aktuálny stav projektu
- Architektúra
- Phase plány
- Technické rozhodnutia
- Databázová schéma
- API endpoints

**💡 Pre Claude:** Vždy načítaj tento súbor na začiatku chatu!

**URL:** https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

---

### MASTER_CONTEXT.md
**Rýchla referencia** - skrátená verzia FULL_PROJECT_CONTEXT.md

---

### QUICK_START.md
**Quick start guide** - ako začať s projektom

---

### SYSTEM_PROMPT.md
**Claude inštrukcie** - ako Claude má interagovať s projektom

---

## 📊 Project Manifests (JSON)

Manifesty poskytujú strukturovaný prístup k projektovým súborom cez GitHub raw URLs.

### project_file_access_delphi.json
**Účel:** Delphi referenčné súbory  
**URL:** https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_delphi.json

**Obsahuje:**
- `delphi-sources/BtrApi32.pas` - Btrieve API wrapper
- `delphi-sources/BtrConst.pas` - Btrieve constants
- `delphi-sources/BtrHand.pas` - Btrieve handler
- `delphi-sources/BtrStruct.pas` - Btrieve structures
- `delphi-sources/BtrTable.pas` - Btrieve table wrapper
- `delphi-sources/BtrTools.pas` - Btrieve utilities
- `delphi-sources/SqlApi32.pas` - SQL API wrapper

**Použitie:**
```python
import requests
manifest = requests.get(manifest_url).json()
for file in manifest['files']:
    print(f"File: {file['name']}")
    print(f"URL: {file['raw_url']}")
```

---

### project_file_access_bdf.json
**Účel:** Databázové schémy (.bdf súbory)  
**URL:** https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_bdf.json

**Obsahuje:**
- `database-schema/GSCAT.bdf` - Produktový katalóg
- `database-schema/ISCAT.bdf` - Skladové príjemky (header)
- `database-schema/ISDET.bdf` - Skladové príjemky (items)
- `database-schema/CRDAT.bdf` - Dodávatelia

**Použitie:**
```bash
# Načítaj manifest
curl https://raw.githubusercontent.com/.../project_file_access_bdf.json

# Stiahnuť konkrétny .bdf súbor
curl https://raw.githubusercontent.com/.../database-schema/GSCAT.bdf -o GSCAT.bdf
```

---

### project_file_access_docs.json
**Účel:** Dokumentačné súbory (.md)  
**URL:** https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_docs.json

**Obsahuje:**
- Všetky .md súbory z `docs/`
- Všetky .md súbory z `docs/architecture/`
- Všetky .md súbory z `docs/sessions/`

---

## 🔄 Generovanie manifests

Manifesty sa generujú automaticky pomocou Python scriptu:

```bash
cd c:\Development\nex-genesis-server\scripts
python generate_project_access.py
```

**Výstup:**
```
✅ Manifest vytvorený: docs/project_file_access_delphi.json
   📊 Počet súborov: 1
   
✅ Manifest vytvorený: docs/project_file_access_bdf.json
   📊 Počet súborov: 4
   
✅ Manifest vytvorený: docs/project_file_access_docs.json
   📊 Počet súborov: 8+
```

**Kedy regenerovať:**
- ✅ Po pridaní nových .bdf súborov
- ✅ Po pridaní novej dokumentácie
- ✅ Po aktualizácii Delphi referenčných súborov
- ✅ Pred push na GitHub

---

## 📁 Adresárová štruktúra

```
docs/
├── README.md                           # Tento súbor
├── FULL_PROJECT_CONTEXT.md             # Hlavný kontext
├── MASTER_CONTEXT.md                   # Rýchla referencia
├── QUICK_START.md                      # Quick start
├── SYSTEM_PROMPT.md                    # Claude inštrukcie
├── project_file_access_delphi.json     # Delphi manifest
├── project_file_access_bdf.json        # BDF manifest
├── project_file_access_docs.json       # Docs manifest
├── architecture/                       # Technická dokumentácia
│   ├── database-schema.md             # Databázová schéma
│   ├── python-btrieve-setup.md        # Btrieve setup guide
│   ├── api-endpoints.md               # API dokumentácia
│   └── isdoc-mapping.md               # ISDOC → DB mapping
└── sessions/                           # Development sessions
    └── 2025-10-21-initial-setup.md    # Session notes
```

---

## 🎯 Best Practices

### Pre Claude AI:
1. **Vždy začni načítaním FULL_PROJECT_CONTEXT.md**
2. Všetky informácie sú v jednom súbore
3. Nemusíš načítavať iné súbory
4. Komunikuj po slovensky

### Pre vývojárov:
1. **Aktualizuj FULL_PROJECT_CONTEXT.md** po každej zmene
2. **Regeneruj manifesty** pred commitom
3. **Dokumentuj rozhodnutia** v sessions/
4. **Používaj slovenčinu** v dokumentácii

---

## 🔗 Quick Links

- **GitHub Repository:** https://github.com/rauschiccsk/nex-genesis-server
- **Main Context:** [FULL_PROJECT_CONTEXT.md](FULL_PROJECT_CONTEXT.md)
- **Database Schema:** [architecture/database-schema.md](architecture/database-schema.md)
- **Related Project:** [supplier_invoice_loader](https://github.com/rauschiccsk/supplier_invoice_loader)

---

## 📝 Changelog

### 2025-10-21
- ✅ Vytvorená adresárová štruktúra
- ✅ Pridané JSON manifesty (delphi, bdf, docs)
- ✅ Aktualizovaný FULL_PROJECT_CONTEXT.md na v0.2.0
- ✅ Strategické rozhodnutie: Pure Python Btrieve

---

**Last Updated:** 2025-10-21  
**Version:** 0.2.0  
**Status:** 🚧 Active Development