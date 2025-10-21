# 🏭 NEX Genesis Server

**Python Btrieve Services pre NEX Genesis ERP**

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/)
[![Btrieve](https://img.shields.io/badge/Btrieve-2.0-green.svg)](https://www.actian.com/)
[![Status](https://img.shields.io/badge/Status-In%20Development-yellow.svg)]()

---

## 📖 O Projekte

NEX Genesis Server je **Python mikroslužba**, ktorá poskytuje REST API pre import ISDOC XML faktúr do NEX Genesis ERP systému. Používa **Actian Btrieve 2 API** pre priamy prístup k Btrieve file-based databáze.

### Hlavné Funkcie

- ✅ Import ISDOC XML faktúr
- ✅ Automatické pridávanie produktov do katalógu
- ✅ Vytváranie skladových príjemiek
- ✅ Evidencia dodávateľských faktúr
- ✅ Priamy Btrieve databázový prístup

---

## 🏗️ Architektúra

```
supplier_invoice_loader (Python FastAPI)
    ↓
NEX Genesis Server (Python Btrieve Services)
    ↓
Btrieve 2 API
    ↓
NEX Genesis Database (*.btr files)
```

---

## 🚀 Quick Start

### Požiadavky

- Python 3.8+
- SWIG 3.0.12+
- Visual Studio 2019+ (C++ compiler)
- Actian Btrieve 2 SDK
- NEX Genesis ERP database

### Inštalácia

```bash
# Clone repository
git clone https://github.com/rauschiccsk/nex-genesis-server.git
cd nex-genesis-server

# Install Python dependencies
pip install -r requirements.txt

# Build Btrieve wrapper (see docs/architecture/python-btrieve-setup.md)
cd python
python setup.py build_ext --plat-name="win-amd64"
```

### Konfigurácia

```ini
# config/nex_genesis.ini
[Database]
DataPath=C:\NEX\DATA
Encoding=CP1250

[Btrieve]
ClientVersion=0x4232
```

### Spustenie

```bash
# Run tests
pytest tests/

# Start server (integration with supplier_invoice_loader)
python -m supplier_invoice_loader
```

---

## 📁 Štruktúra Projektu

```
nex-genesis-server/
├── docs/                      # Dokumentácia
├── database-schema/           # .bdf súbory (databázová schéma)
├── python/                    # Python services
│   ├── models/               # Record layouts
│   ├── services/             # Btrieve services
│   └── parsers/              # ISDOC parser
├── btrieve-sdk/              # Btrieve 2 SDK
├── tests/                    # Unit & integration tests
└── config/                   # Konfigurácia
```

---

## 🔌 API Endpoints

### Import Invoice

```http
POST /api/invoice/import-to-nex
Content-Type: application/xml

<ISDOC XML content>
```

**Response:**
```json
{
  "success": true,
  "receiptId": "PR-2025-0001",
  "productsAdded": 3,
  "itemsCreated": 5
}
```

---

## 📚 Dokumentácia

- **[FULL_PROJECT_CONTEXT.md](docs/FULL_PROJECT_CONTEXT.md)** - Kompletný kontext projektu
- **[Python Btrieve Setup](docs/architecture/python-btrieve-setup.md)** - Setup guide
- **[Database Schema](docs/architecture/database-schema.md)** - Databázová schéma
- **[ISDOC Mapping](docs/architecture/isdoc-mapping.md)** - XML → DB mapping

---

## 🛠️ Tech Stack

- **Python 3.8+** - Programming language
- **Btrieve 2 API** - Database access (Actian)
- **SWIG** - Python wrapper generator
- **FastAPI** - REST API framework
- **pytest** - Testing framework

---

## 📊 Status

**Current Phase:** Phase 1 - Setup & Stratégia  
**Progress:** 50%  
**Next Milestone:** Python Btrieve Setup (2025-10-28)

---

## 🤝 Súvisiace Projekty

- **[supplier_invoice_loader](https://github.com/rauschiccsk/supplier_invoice_loader)** - ISDOC XML generator z PDF faktúr
- **NEX Genesis ERP** - Cieľový ERP systém (Delphi 6, Btrieve)

---

## 📞 Kontakt

**Developer:** rauschiccsk  
**Organization:** ICC (Innovation & Consulting Center)  
**Email:** rausch@icc.sk  
**Location:** Komárno, SK

---

## 📄 Licencia

Proprietary - ICC Internal Project

---

## 🙏 Poďakovanie

- **Actian Corporation** - Btrieve 2 API
- **NEX Genesis** - Databázová štruktúra a patterns

---

**Version:** 0.2.0  
**Last Updated:** 2025-10-21  
**Status:** 🚧 In Active Development