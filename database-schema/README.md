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

### GSCAT.bdf - Produktový katalóg
**Tabuľka:** GSCAT.btr  
**Účel:** Evidencia produktov a tovaru

**Kľúčové polia:**
- `GsCode` - Kód tovaru (PK, autoinc)
- `GsName` - Názov tovaru
- `BarCode` - Čiarový kód (indexed)
- `StkCode` - Skladový kód
- `VatPrc` - DPH %
- `MsuName` - Merná jednotka

**Indexy:**
- Index 0: GsCode (primary key)
- Index 4: BarCode (unique)
- Index ?: MgGs, FgCode, GsName, etc.

---

### ISCAT.bdf - Skladové príjemky (Header)
**Tabuľka:** ISCAT.btr  
**Účel:** Hlavička skladových príjemiek

**Kľúčové polia:** TBD  
**Indexy:** TBD

---

### ISDET.bdf - Položky skladových príjemiek
**Tabuľka:** ISDET.btr  
**Účel:** Položky skladových príjemiek

**Kľúčové polia:** TBD  
**Indexy:** TBD

---

### CRDAT.bdf - Dodávatelia
**Tabuľka:** CRDAT.btr  
**Účel:** Evidencia dodávateľov

**Kľúčové polia:** TBD  
**Indexy:** TBD

---

## 🔧 Ako používať .bdf súbory?

### 1. Analýza .bdf súboru

```python
# scripts/analyze_bdf.py
def parse_bdf(filename):
    """Parse .bdf file and extract field definitions"""
    # TBD - implementovať parser
    pass
```

### 2. Generovanie Python Record Layouts

```python
# python/models/gscat_layout.py
import struct

# Z GSCAT.bdf
GSCAT_RECORD_FORMAT = "<i30s15s15sB..."
GSCAT_RECORD_LENGTH = 250

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
- ✅ Pridať všetky .bdf súbory do tohto adresára
- 🔄 Analyzovať .bdf formát
- 🔄 Parsovať field definitions
- 🔄 Zdokumentovať schému

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

---

## 📝 TODOs

- [ ] Parsovať všetky .bdf súbory
- [ ] Vytvoriť `analyze_bdf.py` script
- [ ] Zdokumentovať všetky polia v `database-schema.md`
- [ ] Generovať Python record layouts
- [ ] Overiť s reálnou databázou

---

## 🔗 Súvisiace dokumenty

- **[database-schema.md](../docs/architecture/database-schema.md)** - Kompletná dokumentácia schémy
- **[FULL_PROJECT_CONTEXT.md](../docs/FULL_PROJECT_CONTEXT.md)** - Kontext projektu
- **[BtrTable.pas](../delphi-sources/BtrTable.pas)** - NEX Genesis Btrieve wrapper (referencia)

---

**Last Updated:** 2025-10-21  
**Version:** 0.1.0  
**Status:** 🚧 Initial Setup