# 🚀 QUICK START - Nový Chat

## Pre pokračovanie projektu v novom chate

**Stačí vložiť JEDNU linku:**

```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md
```

**Claude automaticky:**
1. ✅ Načíta projekt z GitHub
2. ✅ Odpovie: **"✅ Projekt načítaný. Čo robíme?"**
3. ✅ Bude komunikovať PO SLOVENSKY

---

## Potom napíš čo chceš robiť:

**Príklady:**

```
Dnes pracujem na: Phase 1 Task 1.5 - Databázová schéma
```

```
Potrebujem analyzovať NEX Genesis source kódy
```

```
Pokračujeme s generovaním ProductService.pas
```

```
Vytvor ISDOC XML parser
```

---

## Alternatívne (s viac detailmi):

```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

Dnes chcem:
- Analyzovať databázovú schému NEX Genesis
- Zdokumentovať kľúčové tabuľky
- Vytvoriť ISDOC mapping
```

---

## URL pre rýchly prístup:

**Full Context:**
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md
```

**Master Context:**
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/MASTER_CONTEXT.md
```

**Quick Start:**
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/QUICK_START.md
```

---

## Uložené ako záložka (odporúčam):

Vytvor si textový súbor `start-nex-genesis-server.txt` s obsahom:

```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

Dnes pracujem na: 
```

A len copy-paste do nového chatu! 🚀

---

## 🔧 Pre začatie práce na projekte:

### 1. Klonovanie projektu (prvýkrát)
```bash
git clone https://github.com/rauschiccsk/nex-genesis-server.git
cd nex-genesis-server
```

### 2. Setup Python environment
```bash
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Upload NEX Genesis kódov
```bash
# Skopíruj NEX Genesis .pas, .dpr súbory do:
c:\Development\nex-genesis-server\delphi-sources\
```

### 4. Vygeneruj file manifest
```bash
python scripts\generate_project_access.py
```

### 5. Commit & Push
```bash
git add .
git commit -m "docs: Add NEX Genesis sources and manifest"
git push
```

---

## ⚡ Rýchle Príkazy

### Analyzuj Delphi kód
```bash
python scripts\analyze_delphi_code.py
```

### Refresh project manifest
```bash
python scripts\generate_project_access.py
```

### Vytvor directory štruktúru
```bash
python scripts\create_directory_structure.py
```

---

## 🎯 Typické Use Cases

### Začínam nový task
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

Začínam Task 1.5 - Databázová schéma dokumentácia
```

### Pokračujem v rozpracovanom tasku
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

Pokračujem s analýzou NEX Genesis patterns
```

### Generovanie nového kódu
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

Vygeneruj ProductService.pas mikroslužbu podľa NEX patterns
```

### Code review
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/FULL_PROJECT_CONTEXT.md

Skontroluj vygenerovaný HTTPServer.pas súbor
```

---

## 📝 Po dokončení práce

**Vždy:**
1. ✅ Commit zmeny
2. ✅ Update FULL_PROJECT_CONTEXT.md (sekcia AKTUÁLNY STAV)
3. ✅ Refresh project_file_access.json (ak vznikli nové súbory)
4. ✅ Push na GitHub

**Pripomienka od Claude:**
```
⚠️ Nezabudni refreshnúť project_file_access.json
⚠️ Nezabudni updatnúť FULL_PROJECT_CONTEXT.md (sekcia AKTUÁLNY STAV)
```

---

**Projekt:** NEX Genesis Server  
**GitHub:** https://github.com/rauschiccsk/nex-genesis-server  
**Vývojár:** ICC

🏭 **Delphi mikroslužby s AI agentom!**