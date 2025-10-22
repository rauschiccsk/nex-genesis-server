# NEX Genesis Database Structure

## 📁 Adresárová štruktúra

```
C:\NEX\
├─ EXPORT/              # Export súbory
├─ IMPORT/              # Import súbory
└─ YEARACT/             # Aktuálny rok (active data)
   ├─ DBIDEF/           # Database definitions (*.bdf)
   │  ├─ gscat.bdf      # Produktový katalóg definícia
   │  ├─ barcode.bdf    # Čiarové kódy definícia
   │  ├─ mglst.bdf      # Tovarové skupiny definícia
   │  ├─ pab.bdf        # Partneri definícia
   │  ├─ tsh.bdf        # Dodacie listy header definícia
   │  └─ tsi.bdf        # Dodacie listy items definícia
   │
   ├─ DIALS/            # Číselníky (*.BTR)
   │  └─ PAB00000.BTR   # Katalóg obchodných partnerov
   │
   ├─ LEDGER/           # Podvojné účtovníctvo (nepoužívame)
   │
   ├─ STORES/           # Skladové hospodárstvo (*.BTR)
   │  ├─ GSCAT.BTR      # Produktový katalóg
   │  ├─ BARCODE.BTR    # Čiarové kódy
   │  ├─ MGLST.BTR      # Tovarové skupiny
   │  ├─ TSHA-001.BTR   # Dodacie listy header (actual year, book 1)
   │  ├─ TSIA-001.BTR   # Dodacie listy items (actual year, book 1)
   │  ├─ TSHA-002.BTR   # Dodacie listy header (actual year, book 2)
   │  ├─ TSIA-002.BTR   # Dodacie listy items (actual year, book 2)
   │  ├─ TSHP-001.BTR   # Dodacie listy header (previous years, book 1)
   │  └─ TSHIP-001.BTR  # Dodacie listy items (previous years, book 1)
   │
   └─ SYSTEM/           # Systémové súbory NEX Genesis
```

## 🔑 Kľúčové informácie

### Prípony súborov
- **`.BTR`** - Databázové tabuľky (Btrieve)
- **`.bdf`** - Definičné súbory (Binary Definition Files)

### Dôležité adresáre
- **`YEARACT`** - Obsahuje dáta aktuálneho roka
- **`STORES`** - Stock management - skladové hospodárstvo
- **`DIALS`** - Číselníky (reference tables)
- **`DBIDEF`** - Database Interface Definitions
- **`SYSTEM`** - Systémové súbory NEX Genesis

## 📝 Špeciálne pomenovanie TSH/TSI súborov

### Formát názvu
```
TSH{book_type}-{book_number}.BTR
TSI{book_type}-{book_number}.BTR
```

### Book Type
- **`A`** - Actual year (aktuálny rok)
- **`P`** - Previous years (predchádzajúce roky)

### Book Number
- **`001`**, **`002`**, **`003`**, ... - Číslovanie kníh

### Príklady
```
TSHA-001.BTR  # Hlavičky dodacích listov - aktuálny rok, kniha 1
TSIA-001.BTR  # Položky dodacích listov - aktuálny rok, kniha 1
TSHA-002.BTR  # Hlavičky dodacích listov - aktuálny rok, kniha 2
TSHP-001.BTR  # Hlavičky dodacích listov - predchádzajúce roky, kniha 1
TSIP-001.BTR  # Položky dodacích listov - predchádzajúce roky, kniha 1
```

### V našom projekte
**Default nastavenie:** TSHA-001.BTR a TSIA-001.BTR (aktuálny rok, kniha 001)

Číslo knihy je konfigurovateľné v `config/database.yaml`:
```yaml
books:
  delivery_notes_book: "001"  # Zmeniť na "002", "003", atď.
  book_type: "A"              # A=actual, P=previous
```

## 📋 Tabuľky

### GSCAT.BTR - Produktový katalóg
- **Cesta:** `C:\NEX\YEARACT\STORES\GSCAT.BTR`
- **Definícia:** `C:\NEX\YEARACT\DBIDEF\gscat.bdf`
- **Účel:** Master katalóg produktov
- **Primary Key:** GsCode (int)

### BARCODE.BTR - Čiarové kódy
- **Cesta:** `C:\NEX\YEARACT\STORES\BARCODE.BTR`
- **Definícia:** `C:\NEX\YEARACT\DBIDEF\barcode.bdf`
- **Účel:** Evidencia čiarových kódov produktov
- **Primary Key:** BarCode (string)

### MGLST.BTR - Tovarové skupiny
- **Cesta:** `C:\NEX\YEARACT\STORES\MGLST.BTR`
- **Definícia:** `C:\NEX\YEARACT\DBIDEF\mglst.bdf`
- **Účel:** Hierarchia tovarových skupín
- **Primary Key:** MglstCode (int)

### PAB00000.BTR - Obchodní partneri
- **Cesta:** `C:\NEX\YEARACT\DIALS\PAB00000.BTR`
- **Definícia:** `C:\NEX\YEARACT\DBIDEF\pab.bdf`
- **Účel:** Evidencia dodávateľov a odberateľov
- **Primary Key:** PabCode (int)
- **Poznámka:** V DIALS, nie v STORES

### TSHA-001.BTR - Dodacie listy (header)
- **Cesta:** `C:\NEX\YEARACT\STORES\TSHA-001.BTR`
- **Definícia:** `C:\NEX\YEARACT\DBIDEF\tsh.bdf`
- **Účel:** Hlavičky dodacích listov
- **Primary Key:** DocNumber (string)
- **Poznámka:** Číslo knihy konfigurovateľné

### TSIA-001.BTR - Dodacie listy (items)
- **Cesta:** `C:\NEX\YEARACT\STORES\TSIA-001.BTR`
- **Definícia:** `C:\NEX\YEARACT\DBIDEF\tsi.bdf`
- **Účel:** Položky dodacích listov
- **Primary Key:** DocNumber + LineNumber
- **Poznámka:** Číslo knihy konfigurovateľné

## 🔧 Použitie v Python

### Základné použitie
```python
from src.utils.config import get_config

config = get_config()

# Get table paths
gscat_path = config.get_table_path('gscat')
# Returns: "C:\\NEX\\YEARACT\\STORES\\GSCAT.BTR"

pab_path = config.get_table_path('pab')
# Returns: "C:\\NEX\\YEARACT\\DIALS\\PAB.00000.BTR"

tsh_path = config.get_table_path('tsh')
# Returns: "C:\\NEX\\YEARACT\\STORES\\TSHA-001.BTR"

# Get definition paths
gscat_def = config.get_definition_path('gscat')
# Returns: "C:\\NEX\\YEARACT\\DBIDEF\\gscat.bdf"

# Validate all paths
config.validate_paths()
```

### Book number handling
```python
from src.utils.config import get_config

config = get_config()

# Get current book settings
book_num = config.get_book_number()  # "001"
book_type = config.get_book_type()   # "A"

# Get TSH/TSI filenames
tsh_file = config.get_tsh_filename()  # "TSHA-001.BTR"
tsi_file = config.get_tsi_filename()  # "TSIA-001.BTR"

# Override book number
tsh_file_2 = config.get_tsh_filename("002")  # "TSHA-002.BTR"
```

## ⚠️ Dôležité poznámky

1. **Prípony súborov:** NEX Genesis používa `.BTR` nie `.DAT`
2. **Case sensitive:** Windows ignoruje case, ale je dobré dodržiavať konvenciu (uppercase)
3. **YEARACT:** Každý rok má svoj vlastný adresár
4. **STORES vs DIALS:** PAB je v DIALS, ostatné v STORES
5. **TSH/TSI naming:** Dynamické podľa book type a number
6. **Book number:** Default 001, konfigurovateľné v YAML
7. **Backup:** Pravidelne zálohuj `YEARACT/STORES/` a `YEARACT/DIALS/`
8. **Access rights:** Potrebné read/write práva na `C:\NEX\YEARACT\`
9. **Btrieve DLL:** NEX používa `wxqlcall.dll` (Pervasive PSQL v11)

## 📊 Súhrn tabuliek podľa umiestnenia

### STORES (skladové hospodárstvo)
- GSCAT.BTR - Produktový katalóg
- BARCODE.BTR - Čiarové kódy
- MGLST.BTR - Tovarové skupiny
- TSHA-nnn.BTR - Dodacie listy header
- TSIA-nnn.BTR - Dodacie listy items

### DIALS (číselníky)
- PAB00000.BTR - Obchodní partneri

### DBIDEF (definície)
- gscat.bdf, barcode.bdf, mglst.bdf, pab.bdf, tsh.bdf, tsi.bdf

---

**Vytvorené:** 2025-10-22  
**Verzia:** 1.1  
**Autor:** ICC (rausch@icc.sk)  
**Posledná zmena:** Oprava štruktúry STORES/DIALS a TSH/TSI naming