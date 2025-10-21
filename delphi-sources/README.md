# 🔧 NEX Genesis Btrieve Wrappers

Tento adresár obsahuje **NEX Genesis Btrieve wrappery** - referenčné Delphi zdrojové kódy pre pochopenie ako NEX Genesis pristupuje k Btrieve databáze.

---

## 📋 Účel týchto súborov

**⚠️ DÔLEŽITÉ:** Tieto súbory sú **iba ako referencia** pre implementáciu Python Btrieve služieb!

**Nebudeme ich kompilovať ani používať v produkcii.** Slúžia na:
- ✅ Pochopenie NEX Genesis patterns
- ✅ Referencia pre Python implementáciu
- ✅ Analýza databázových štruktúr
- ✅ Pochopenie Btrieve API volania

---

## 📁 Súbory v tomto adresári

### BtrTable.pas ⭐ **Najdôležitejší**
**Účel:** Hlavný wrapper pre Btrieve tabuľky

**Obsahuje:**
- `TBtrTable` class - základná Btrieve tabuľka
- `Open()`, `Close()` - otvorenie/zatvorenie súborov
- `Insert()`, `Update()`, `Delete()` - CRUD operácie
- `First()`, `Next()`, `Prior()`, `Last()` - navigácia
- `SetIndex()` - prepínanie indexov
- `RecordRetrieve()` - čítanie recordov

**Príklad použitia v Delphi:**
```pascal
var
  BtrTable: TBtrTable;
begin
  BtrTable := TBtrTable.Create('GSCAT.btr', DataPath);
  BtrTable.Open;
  BtrTable.SetIndex(0);  // Primary key
  BtrTable.First;
  while not BtrTable.Eof do
  begin
    // Process record
    BtrTable.Next;
  end;
  BtrTable.Close;
end;
```

**Python ekvivalent (čo vytvoríme):**
```python
btr_file = btrv.BtrieveFile()
client.FileOpen(btr_file, "GSCAT.btr", None, btrv.Btrieve.OPEN_MODE_NORMAL)
length = btr_file.RecordRetrieveFirst(0, record, 0)
while length > 0:
    # Process record
    length = btr_file.RecordRetrieveNext(record, 0)
```

---

### BtrApi32.pas
**Účel:** Nízkoúrovňové Btrieve API volania

**Obsahuje:**
- `BTRCALL()` - hlavná Btrieve funkcia
- Deklarácie pre `wbtrv32.dll`
- Operation codes (B_OPEN, B_INSERT, B_UPDATE, atď.)
- Status codes (0=OK, 4=Not Found, atď.)

**Dôležité pre Python:**
- Presné operation codes
- Error handling patterns
- Parameter štruktúry

---

### BtrConst.pas
**Účel:** Btrieve konštanty

**Obsahuje:**
- Operation codes konštanty
- Status codes konštanty
- Data type konštanty
- Lock mode konštanty

**Python ekvivalent:**
```python
# Tieto už má Btrieve 2 API
btrv.Btrieve.STATUS_CODE_NO_ERROR
btrv.Btrieve.B_INSERT
btrv.Btrieve.B_UPDATE
```

---

### BtrStruct.pas
**Účel:** Btrieve dátové štruktúry

**Obsahuje:**
- Position block štruktúra
- Key buffer štruktúra
- Data buffer handling

**Dôležité pre Python:**
- Record layout patterns
- Binary data handling
- Buffer management

---

### BtrHand.pas
**Účel:** High-level Btrieve handler

**Obsahuje:**
- Business logic pre operácie
- Transaction handling
- Error handling patterns

**Príklady pre Python implementáciu:**
- Ako spracovať chyby
- Ako robiť transakcie
- Ako logovať operácie

---

### BtrTools.pas
**Účel:** Utility funkcie

**Obsahuje:**
- Field value extraction
- Data type conversions
- String handling utilities

**Python ekvivalent:**
```python
# Namiesto Delphi utilities použijeme:
import struct
value = struct.unpack("<i", buffer[offset:offset+4])[0]
```

---

### SqlApi32.pas
**Účel:** Pervasive SQL API wrapper

**Poznámka:** Nie je relevantný pre nás, lebo NEX Genesis používa file-based Btrieve, nie SQL engine.

---

## 🎯 Ako používať tieto súbory?

### 1. Analýza Patterns

**Otvor BtrTable.pas a študuj:**
- Ako sa otvára súbor
- Ako sa číta/píše record
- Ako sa prepínajú indexy
- Ako sa spracovávajú chyby

### 2. Port do Pythonu

**Pattern z Delphi:**
```pascal
procedure TBtrTable.Insert;
begin
  // 1. Prepare record buffer
  // 2. Call BTRCALL with B_INSERT
  // 3. Check status
  // 4. Handle errors
end;
```

**Python implementácia:**
```python
def insert_record(self, record_data):
    # 1. Prepare record buffer
    buffer = record_data.pack()
    
    # 2. Call Btrieve API
    rc = self.btr_file.RecordCreate(buffer)
    
    # 3. Check status
    if rc != btrv.Btrieve.STATUS_CODE_NO_ERROR:
        # 4. Handle errors
        raise Exception(f"Insert failed: {rc}")
```

### 3. Record Layout Referencia

**Z BtrTable.pas zisti:**
- Field offsets
- Field lengths
- Data types

**Vytvor Python model:**
```python
# python/models/gscat_layout.py
GSCAT_RECORD_FORMAT = "<i30s15s..."  # Based on BtrTable.pas
```

---

## 🔗 Vzťah k Python implementácii

```
NEX Genesis (Delphi)              NEX Genesis Server (Python)
─────────────────────             ───────────────────────────
BtrTable.pas          →           BtrieveClient.py
  TBtrTable.Open()    →             open_file()
  TBtrTable.Insert()  →             RecordCreate()
  TBtrTable.First()   →             RecordRetrieveFirst()
  
BtrApi32.pas          →           btrievePython (SWIG wrapper)
  BTRCALL()           →             btrv.BtrieveFile.*
  
BtrConst.pas          →           btrv.Btrieve constants
  B_INSERT            →             btrv.Btrieve.B_INSERT
```

---

## 📊 Project Manifest

Tieto súbory sú zahrnuté v JSON manifeste:

**Manifest URL:**
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access_delphi.json
```

**Použitie:**
```python
import requests

manifest_url = "https://raw.githubusercontent.com/.../project_file_access_delphi.json"
manifest = requests.get(manifest_url).json()

for file in manifest['files']:
    if file['name'].endswith('.pas'):
        print(f"Analyzing: {file['name']}")
```

---

## 🚫 Čo NEBUDEME robiť

- ❌ Kompilovať tieto .pas súbory
- ❌ Vytvárať Delphi mikroslužbu
- ❌ Používať Delphi v produkcii
- ❌ Linkovat proti NEX Genesis kódom

**Dôvod:** Zvolili sme **Pure Python Btrieve** stratégiu!

---

## ✅ Čo BUDEME robiť

- ✅ Študovať patterns z týchto súborov
- ✅ Portovať logiku do Pythonu
- ✅ Použiť ako referenčnú dokumentáciu
- ✅ Pochopiť databázové štruktúry

---

## 🔗 Súvisiace dokumenty

- **[FULL_PROJECT_CONTEXT.md](../docs/FULL_PROJECT_CONTEXT.md)** - Kontext projektu
- **[database-schema.md](../docs/architecture/database-schema.md)** - Databázová schéma
- **[python-btrieve-setup.md](../docs/architecture/python-btrieve-setup.md)** - Python setup guide
- **[database-schema/](../database-schema/)** - .bdf súbory

---

## 📝 Ďalšie kroky

1. **Task 1.8** - Analyzovať tieto súbory
2. **Task 1.9** - Vytvoriť Python record layouts
3. **Phase 2** - Implementovať Python services

---

**Last Updated:** 2025-10-21  
**Version:** 0.2.0  
**Purpose:** 📚 Reference Only - Not for Production Use