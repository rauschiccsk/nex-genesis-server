# 📊 NEX Genesis Database Schema

Tento adresár obsahuje **Btrieve Data Definition Files (.bdf)** pre NEX Genesis ERP databázu.

---

## 📋 Čo sú .bdf súbory?

**.bdf súbory** sú **custom schema definition files** vytvorené pre NEX Genesis ERP systém. Obsahujú definície databázových tabuliek pre Btrieve file-based databázu.

### Prečo vlastný formát?

NEX Genesis vznikol v čase keď:
- ❌ Neexistoval Pervasive SQL (len Btrieve)
- ❌ Neboli .DDF systémové tabuľky
- ❌ Schéma sa musela definovať manuálne

**Riešenie:** ICC vytvorilo vlastný .bdf formát pre definíciu databázovej štruktúry.

---

## 📁 Súbory v tomto adresári

### gscat.bdf - Produktový katalóg ⭐
**Tabuľka:** GSCAT.btr  
**Účel:** Evidencia produktov a tovaru

**Kľúčové polia:**
- `GsCode` - Kód tovaru (PK, autoinc)
- `GsName` - Názov tovaru
- `StkCode` - Skladový kód
- `MgCode` - Kód tovarovej skupiny → MGLST
- `VatPrc` - DPH %
- `MsuName` - Merná jednotka
- `Weight` - Hmotnosť
- `CrtUser`, `CrtDate` - Audit info

**Indexy:**
- Index 0: GsCode (primary key)
- Index ?: MgCode (link na skupiny)
- Index ?: StkCode

**Poznámka:** Čiarové kódy sú v samostatnej tabuľke BARCODE

---

### barcode.bdf - Čiarové kódy ⭐
**Tabuľka:** BARCODE.btr  
**Účel:** Čiarové kódy priradené k produktom

**Kľúčové polia:**
- `GsCode` - Kód tovaru → GSCAT.GsCode
- `BarCode` - Čiarový kód (PK, unique)
- `CrtUser`, `CrtDate` - Audit info

**Indexy:**
- Index 0: BarCode (primary key, unique)
- Index 1: GsCode (foreign key)

**Vzťah:** Jeden produkt môže mať viacero čiarových kódov

---

### mglst.bdf - Tovarové skupiny
**Tabuľka:** MGLST.btr  
**Účel:** Evidencia tovarových skupín (Material Group List)

**Kľúčové polia:**
- `MgCode` - Kód skupiny (PK)
- `MgName` - Názov skupiny
- `MgParent` - Nadradená skupina (hierarchia)

**Indexy:**
- Index 0: MgCode (primary key)

**Použitie:** GSCAT.MgCode → MGLST.MgCode

---

### pab.bdf - Obchodní partneri
**Tabuľka:** PAB.btr  
**Účel:** Evidencia obchodných partnerov (dodávatelia, odberatelia)

**Kľúčové polia:**
- `PaCode` - Kód partnera (PK)
- `PaName` - Názov partnera
- `PaICO` - IČO (indexed, unique)
- `PaType` - Typ (1=dodávateľ, 2=odberateľ, 3=oboje)
- `PaAddress` - Adresa
- `PaCity` - Mesto

**Indexy:**
- Index 0: PaCode (primary key)
- Index ?: PaICO (unique, pre vyhľadávanie)

**Použitie:** Import ISDOC → vyhľadaj dodávateľa podľa IČO

---

### tsh.bdf - Dodacie listy (Header)
**Tabuľka:** TSH.btr  
**Účel:** Hlavičky dodávateľských dodacích listov

**Kľúčové polia:**
- `TshCode` - Kód dodacieho listu (PK, autoinc)
- `TshNum` - Číslo dodacieho listu
- `TshDate` - Dátum dodacieho listu
- `PaCode` - Kód dodávateľa → PAB.PaCode
- `TshState` - Stav (0=rozpracovaný, 1=dokončený)
- `CrtUser`, `CrtDate` - Audit info

**Indexy:**
- Index 0: TshCode (primary key)
- Index ?: TshNum (unique)
- Index ?: PaCode (foreign key)
- Index ?: TshDate (pre vyhľadávanie)

---

### tsi.bdf - Dodacie listy (Items)
**Tabuľka:** TSI.btr  
**Účel:** Položky dodávateľských dodacích listov

**Kľúčové polia:**
- `TshCode` - Kód dodacieho listu → TSH.TshCode
- `TsiLine` - Číslo riadku
- `GsCode` - Kód tovaru → GSCAT.GsCode
- `Quantity` - Množstvo
- `Price` - Jednotková cena
- `TotalPrice` - Celková cena
- `VatPrc` - DPH %

**Indexy:**
- Index 0: TshCode + TsiLine (composite PK)
- Index ?: GsCode (foreign key)

**Vzťah:** TSH (1) → TSI (N)

---

## 🔄 Vzťahy medzi tabuľkami

```
MGLST (Tovarové skupiny)
  ↓
GSCAT (Produkty) ← BARCODE (Čiarové kódy)
  ↓                    ↓
TSI (Položky) ← TSH (Hlavička) ← PAB (Partneri)
```

**Import workflow:**
1. Nájdi dodávateľa v **PAB** podľa IČO
2. Pre každú položku:
   - Nájdi produkt v **BARCODE** podľa čiarového kódu
   - Ak neexistuje: vytvor **GSCAT** + **BARCODE**
3. Vytvor **TSH** (header)
4. Vytvor **TSI** (items)

---

## 🔧 Ako používať .bdf súbory?

### 1. Analýza .bdf súboru

```python
# scripts/analyze_bdf.py
def parse_bdf(filename):
    """Parse .bdf file and extract field definitions"""
    with open(filename, 'r', encoding='cp1250') as f:
        # Parse field definitions
        # Parse indexes
        # Parse table info
    pass
```

### 2. Generovanie Python Record Layouts

```python
# python/models/gscat_layout.py
import struct

# Z gscat.bdf
GSCAT_RECORD_FORMAT = "<i30s15s..."  # TBD
GSCAT_RECORD_LENGTH = 250  # TBD

class GSCATRecord:
    def pack(self):
        return struct.pack(GSCAT_RECORD_FORMAT, ...)
    
    @staticmethod
    def unpack(binary_data):
        return struct.unpack(GSCAT_RECORD_FORMAT, binary_data)
```

### 3. Dokumentácia do database-schema.md

Každý .bdf súbor by mal byť zdokumentovaný v:
`docs/architecture/database-schema.md`

---

## 📖 Formát .bdf súboru

**.bdf formát** (NEX Genesis custom):

```
[Field Definitions]
FieldName=Type,Length,Offset

[Indexes]
IndexNum=FieldList,Type,Flags

[Table Info]
TableName=...
RecordLength=...
```

**Poznámka:** Presný formát bude analyzovaný počas Task 1.8

---

## 🎯 Použitie v projekte

### Phase 1: Setup (Aktuálne)
- [x] Pridať všetky .bdf súbory do tohto adresára
- [ ] Analyzovať .bdf formát
- [ ] Parsovať field definitions
- [ ] Zdokumentovať schému

### Phase 2: Development
- Generovať Python record layouts z .bdf
- Vytvoriť struct.pack/unpack definície
- Implementovať services

---

## ⚠️ Dôležité poznámky

### Character Encoding
**NEX Genesis používa CP-1250** (Windows Central European)

```python
# Pri práci s textom vždy:
text.encode('cp1250')
binary.decode('cp1250')
```

### Binary Layout
**Little-endian** format pre všetky numerické hodnoty:
```python
struct.pack("<i", value)  # Little-endian integer
```

### Index Numbering
- **Index 0** - vždy primary key
- **Indexy 1-N** - secondary indexes

### Btrieve API
Pre prístup k týmto tabuľkám použijeme:
- **Btrieve 2 API** (Python wrapper)
- **NEX Genesis wrappery** (referencia v delphi-sources/)

---

## 🔗 Project Manifest

Všetky .bdf súbory sú zahrnuté v JSON manifeste:

**Manifest URL:**
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_bdf.json
```

**Použitie:**
```python
import requests

# Načítaj manifest
manifest_url = "https://raw.githubusercontent.com/.../project_file_access_bdf.json"
manifest = requests.get(manifest_url).json()

# Zobraz všetky .bdf súbory
for file in manifest['files']:
    print(f"{file['name']}: {file['raw_url']}")
```

**Regenerovanie manifestu:**
```bash
cd scripts
python generate_project_access.py
```

---

## 🔗 Súvisiace dokumenty

- **[database-schema.md](../docs/architecture/database-schema.md)** - Kompletná dokumentácia schémy
- **[FULL_PROJECT_CONTEXT.md](../docs/FULL_PROJECT_CONTEXT.md)** - Kontext projektu
- **[Delphi Sources](../delphi-sources/)** - NEX Genesis Btrieve wrappery (referencia)

---

## 📝 TODOs

- [ ] Parsovať všetky .bdf súbory
- [ ] Vytvoriť `analyze_bdf.py` script
- [ ] Zdokumentovať všetky polia v `database-schema.md`
- [ ] Generovať Python record layouts
- [ ] Overiť s reálnou databázou

---

**Last Updated:** 2025-10-21  
**Version:** 0.2.0  
**Status:** 🚧 Initial Setup - Real NEX Genesis Schema