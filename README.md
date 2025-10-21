# 🏭 NEX Genesis Server

**Delphi 6 Mikroslužby pre NEX Genesis ERP**

REST API mikroslužby napísané v Delphi 6, ktoré umožňujú import dodávateľských faktúr z ISDOC XML do NEX Genesis databázy.

---

## 🎯 Účel Projektu

**NEX Genesis Server** prijíma ISDOC XML súbory z projektu `supplier_invoice_loader` a automaticky:

- ✅ Kontroluje/pridáva produkty do katalógu
- ✅ Vytvára skladové príjemky
- ✅ Eviduje dodávateľské faktúry
- ✅ Integruje sa s NEX Genesis databázou (Pervasive)

---

## 🏗️ Architektúra

```
supplier_invoice_loader (Python)
         ↓
    ISDOC XML
         ↓
NEX Genesis Server (Delphi 6)
         ↓
NEX Genesis Database (Pervasive)
```

---

## 📁 Štruktúra Projektu

```
nex-genesis-server/
├── docs/                    # Dokumentácia
│   ├── FULL_PROJECT_CONTEXT.md    # 👈 Hlavný dokument
│   └── project_file_access.json
├── delphi-sources/         # NEX Genesis source kódy
├── output/                 # Vygenerované mikroslužby
├── templates/              # Code templates pre agenta
├── config/                 # Konfiguračné súbory
├── scripts/                # Python utility skripty
└── tests/                  # Test data
```

---

## 🚀 Quick Start

### Pre Claude (AI Assistant)

Otvor nový chat a vlož tento raw URL:

```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md
```

Claude načíta celý projekt a je pripravený pracovať.

### Pre vývojára

1. **Clone repository:**
   ```bash
   git clone https://github.com/rauschiccsk/nex-genesis-server.git
   cd nex-genesis-server
   ```

2. **Upload NEX Genesis source kódy:**
   ```bash
   # Skopíruj NEX Genesis source kódy do:
   delphi-sources/
   ```

3. **Vygeneruj file manifest:**
   ```bash
   python scripts/generate_project_access.py
   ```

4. **Commit a push:**
   ```bash
   git add .
   git commit -m "docs: Add NEX Genesis sources and manifest"
   git push
   ```

---

## 📚 Dokumentácia

Kompletná dokumentácia je v jednom súbore:

📄 **[FULL_PROJECT_CONTEXT.md](docs/FULL_PROJECT_CONTEXT.md)**

Tento súbor obsahuje:
- Project overview a workflow
- Architektúru systému
- Tech stack
- API endpoints špecifikáciu
- Database schému
- ISDOC XML mapping
- Development roadmap
- Programming agent design

---

## 🔌 API Endpoints

### Import Invoice (Hlavná funkcia)
```http
POST /api/invoice/import
Content-Type: application/xml

<ISDOC XML content>
```

### Health Check
```http
GET /api/health
```

Detailná špecifikácia: [docs/FULL_PROJECT_CONTEXT.md](docs/FULL_PROJECT_CONTEXT.md)

---

## 💾 Tech Stack

- **Jazyk:** Delphi 6 (Object Pascal)
- **Databáza:** Pervasive SQL
- **HTTP Server:** Indy / Synapse
- **XML Parser:** MSXML / OmniXML
- **Config:** INI files

---

## 🤖 Programming Agent

Tento projekt obsahuje AI programming agenta, ktorý vie:
- Analyzovať NEX Genesis source kódy
- Generovať nové Delphi 6 mikroslužby
- Dodržiavať NEX Genesis patterns a conventions
- Vytvárať dokumentáciu

Viac info: [docs/FULL_PROJECT_CONTEXT.md](docs/FULL_PROJECT_CONTEXT.md#-programming-agent-design)

---

## 🔗 Related Projects

### supplier_invoice_loader
- **URL:** https://github.com/rauschiccsk/supplier_invoice_loader
- **Purpose:** Generuje ISDOC XML z PDF faktúr
- **Integration:** Posiela XML na NEX Genesis Server

---

## 📊 Development Status

**Current Phase:** Initial Planning

Aktuálny stav vývoja: [docs/FULL_PROJECT_CONTEXT.md](docs/FULL_PROJECT_CONTEXT.md#-development-roadmap)

---

## 👨‍💻 Developer

**ICC (rausch@icc.sk)**

- 📂 Local: `c:\Development\nex-genesis-server`
- 🔗 GitHub: https://github.com/rauschiccsk/nex-genesis-server
- 🌐 Company: isnex.ai

---

## 📝 License

Proprietárny software pre zákazníka MAGERSTAV spol. s r.o.

---

## 🆘 Support

Pre technické otázky a support:
- 📧 Email: rausch@icc.sk
- 📄 Documentation: [FULL_PROJECT_CONTEXT.md](docs/FULL_PROJECT_CONTEXT.md)

---

**Status:** 🚧 In Development  
**Version:** 0.1.0  
**Last Updated:** 2025-10-21