# NEX Genesis Models Documentation

**Version:** 1.0.0  
**Date:** 2025-10-23  
**Author:** ICC (rauschiccsk)

---

## 📋 Obsah

1. [Prehľad](#prehľad)
2. [Inštalácia](#inštalácia)
3. [Používanie](#používanie)
4. [Tabuľky](#tabuľky)
5. [Field Mappings](#field-mappings)
6. [Type Conversions](#type-conversions)
7. [Best Practices](#best-practices)

---

## 🎯 Prehľad

Python dataclasses pre všetky NEX Genesis Btrieve tabuľky. Poskytujú:

✅ **Type-safe** prístup k databázovým poliam  
✅ **Serialization/Deserialization** (bytes ↔ Python objects)  
✅ **Validation** (field constraints, business rules)  
✅ **Documentation** (každé pole je zdokumentované)  
✅ **Helper methods** (výpočty, formátovanie, hierarchia)

### Podporované tabuľky

| Model | Tabuľka | Účel | Record Size |
|-------|---------|------|-------------|
| `BarcodeRecord` | BARCODE.BTR | Čiarové kódy produktov | ~50 bytes |
| `GSCATRecord` | GSCAT.BTR | Produktový katalóg | 705 bytes |
| `PABRecord` | PAB00000.BTR | Obchodní partneri | 1269 bytes |
| `MGLSTRecord` | MGLST.BTR | Tovarové skupiny | ~200 bytes |
| `TSHRecord` | TSHA-001.BTR | Dodacie listy header | ~800 bytes |
| `TSIRecord` | TSIA-001.BTR | Dodacie listy items | ~400 bytes |

---

## 📦 Inštalácia

```bash
# Models sú súčasťou projektu
cd C:\Development\nex-genesis-server
.\venv32\Scripts\activate

# Žiadne extra dependencies
# Používajú len Python stdlib (dataclasses, struct, datetime, decimal)
```

---

## 🚀 Používanie

### Základné použitie

```python
from src.models import BarcodeRecord, GSCATRecord
from src.btrieve.btrieve_client import BtrieveClient

# 1. Načítanie dát z Btrieve
client = BtrieveClient()
client.open_table('barcode')

status, raw_data = client.get_first()
if status == BtrStatus.SUCCESS:
    # 2. Deserialize do Python objektu
    barcode = BarcodeRecord.from_bytes(raw_data)
    
    # 3. Práca s objektom (type-safe)
    print(f"GsCode: {barcode.gs_code}")
    print(f"BarCode: {barcode.bar_code}")
    print(f"ModUser: {barcode.mod_user}")
    
    # 4. Validácia
    errors = barcode.validate()
    if errors:
        print(f"Validation errors: {errors}")
    
    # 5. Serialize späť do bytes
    updated_data = barcode.to_bytes()

client.close_file()
```

### Vytváranie nových záznamov

```python
from src.models import GSCATRecord
from datetime import datetime
from decimal import Decimal

# Create new product
product = GSCATRecord(
    gs_code=12345,
    gs_name="Nový produkt",
    gs_short_name="NP-001",
    mglst_code=10,
    unit="ks",
    price_buy=Decimal("50.00"),
    price_sell=Decimal("99.99"),
    vat_rate=Decimal("20.0"),
    active=True,
    mod_user="API",
    mod_date=datetime.now(),
    mod_time=datetime.now()
)

# Validate
errors = product.validate()
if not errors:
    # Serialize pre Btrieve
    raw_data = product.to_bytes()
    
    # Insert do Btrieve
    # client.insert(raw_data)
```

### Práca s partnermi (PAB)

```python
from src.models import PABRecord

# Načítanie partnera
status, raw_data = client.get_first()
partner = PABRecord.from_bytes(raw_data)

# Helper methods
print(partner.get_full_name())  # "ICC s.r.o. CONSULTING"
print(partner.get_full_address())  # "Ulica 123, Mesto 12345, Slovakia"
print(f"Supplier: {partner.is_supplier()}")  # True/False
print(f"Customer: {partner.is_customer()}")  # True/False

# Update
partner.email = "new@email.com"
partner.phone = "+421 123 456 789"
partner.mod_user = "ADMIN"
partner.mod_date = datetime.now()

# Serialize
updated_data = partner.to_bytes()
```

### Hierarchia tovarových skupín (MGLST)

```python
from src.models import MGLSTRecord

# Load all categories
categories = []
while True:
    status, raw_data = client.get_next()
    if status != BtrStatus.SUCCESS:
        break
    categories.append(MGLSTRecord.from_bytes(raw_data))

# Find category
electronics = next(c for c in categories if c.mglst_code == 10)

# Get hierarchy path
path = electronics.get_path(categories)
print([c.mglst_name for c in path])  # ['Root', 'Elektronika', 'Počítače']

# Get full path name
print(electronics.get_full_path_name(categories))
# Output: "Root > Elektronika > Počítače"

# Find children
children = [c for c in categories if c.is_child_of(electronics.mglst_code)]
print(f"Children: {[c.mglst_name for c in children]}")
```

### Dodacie listy (TSH + TSI)

```python
from src.models import TSHRecord, TSIRecord
from decimal import Decimal

# Load header
client.open_table('tsh')
status, raw_data = client.get_first()
header = TSHRecord.from_bytes(raw_data)

print(f"Doc: {header.doc_number}")
print(f"Partner: {header.pab_name}")
print(f"Total: {header.amount_total} {header.currency}")

# Load items for this document
client.open_table('tsi')
items = []
# ... load all items with matching doc_number

# Calculate item line totals
for item in items:
    item.calculate_line_totals()  # Updates line_base, line_vat, line_total
    print(f"  Line {item.line_number}: {item.gs_name} - {item.line_total} EUR")
```

---

## 📊 Tabuľky

### BARCODE - Čiarové kódy

```python
BarcodeRecord(
    gs_code: int,           # Tovarové číslo (FK to GSCAT)
    bar_code: str,          # Čiarový kód (EAN, Code128, QR, custom)
    mod_user: str,          # Užívateľ poslednej zmeny
    mod_date: datetime,     # Dátum zmeny
    mod_time: datetime      # Čas zmeny
)

# Indexes
INDEX_GSCODE = 'GsCode'     # Find by product
INDEX_BARCODE = 'BarCode'   # Find by barcode
INDEX_GSBC = 'GsBc'         # Composite unique index
```

### GSCAT - Produktový katalóg

```python
GSCATRecord(
    gs_code: int,           # PK - Tovarové číslo
    gs_name: str,           # Názov produktu (hlavný)
    gs_name2: str,          # Názov (alternatívny)
    gs_short_name: str,     # Krátky názov
    mglst_code: int,        # FK to MGLST (tovarová skupina)
    unit: str,              # Merná jednotka (ks, kg, m, l)
    price_buy: Decimal,     # Nákupná cena
    price_sell: Decimal,    # Predajná cena
    vat_rate: Decimal,      # DPH sadzba (%)
    stock_min: Decimal,     # Minimálny stav
    stock_max: Decimal,     # Maximálny stav
    stock_current: Decimal, # Aktuálny stav
    active: bool,           # Aktívny produkt
    supplier_code: int,     # FK to PAB (dodávateľ)
    # ... + audit fields
)

# Indexes
INDEX_GSCODE = 'GsCode'         # Primary
INDEX_NAME = 'GsName'           # Find by name
INDEX_MGLST = 'MglstCode'       # Find by category
INDEX_SUPPLIER = 'SupplierCode' # Find by supplier
```

### PAB - Obchodní partneri

```python
PABRecord(
    pab_code: int,          # PK - Kód partnera
    name1: str,             # Názov firmy (riadok 1)
    name2: str,             # Názov firmy (riadok 2)
    short_name: str,        # Skrátený názov
    # Address
    street: str,
    city: str,
    zip_code: str,
    country: str,
    # Contact
    phone: str,
    email: str,
    web: str,
    # Tax
    ico: str,               # IČO
    dic: str,               # DIČ
    ic_dph: str,            # IČ DPH
    # Bank
    iban: str,
    swift: str,
    # Business
    partner_type: int,      # 1=supplier, 2=customer, 3=both
    payment_terms: int,     # Platobné podmienky (dni)
    # ... + audit fields
)

# Helper methods
.get_full_name() -> str
.get_full_address() -> str
.is_supplier() -> bool
.is_customer() -> bool
```

### MGLST - Tovarové skupiny

```python
MGLSTRecord(
    mglst_code: int,        # PK - Kód skupiny
    mglst_name: str,        # Názov skupiny
    parent_code: int,       # FK to MGLST (parent category)
    level: int,             # Úroveň v hierarchii (1=top)
    sort_order: int,        # Poradie zobrazovania
    default_vat_rate: float, # Predvolená DPH (%)
    default_unit: str,      # Predvolená jednotka
    active: bool,
    # ... + audit fields
)

# Helper methods
.is_root() -> bool
.is_child_of(parent_code) -> bool
.get_path(all_categories) -> list[MGLSTRecord]
.get_full_path_name(all_categories, separator) -> str
```

### TSH - Dodacie listy Header

```python
TSHRecord(
    doc_number: str,        # PK - Číslo dokladu
    doc_type: int,          # 1=príjem, 2=výdaj, 3=transfer
    doc_date: date,         # Dátum vystavenia
    pab_code: int,          # FK to PAB
    pab_name: str,          # Názov partnera (cache)
    currency: str,          # Mena (EUR, USD, CZK)
    amount_base: Decimal,   # Základ dane
    amount_vat: Decimal,    # DPH
    amount_total: Decimal,  # Celkom s DPH
    # VAT breakdown
    vat_20_base: Decimal,
    vat_20_amount: Decimal,
    vat_10_base: Decimal,
    vat_10_amount: Decimal,
    # Payment
    payment_method: int,    # 1=hotovosť, 2=prevodom, 3=karta
    paid: bool,
    paid_date: date,
    # ... + audit fields
)
```

### TSI - Dodacie listy Items

```python
TSIRecord(
    doc_number: str,        # FK to TSH
    line_number: int,       # Poradové číslo položky
    gs_code: int,           # FK to GSCAT
    gs_name: str,           # Názov produktu (cache)
    quantity: Decimal,      # Množstvo
    unit: str,              # Merná jednotka
    price_unit: Decimal,    # Jednotková cena bez DPH
    vat_rate: Decimal,      # DPH sadzba (%)
    discount_percent: Decimal, # Zľava (%)
    line_base: Decimal,     # Základ dane (po zľave)
    line_vat: Decimal,      # DPH
    line_total: Decimal,    # Celkom s DPH
    # ... + audit fields
)

# Helper methods
.calculate_line_totals() -> None  # Prepočíta line_base, line_vat, line_total
```

---

## 🔄 Type Conversions

### Delphi ↔ Python

| Delphi Type | Python Type | Notes |
|-------------|-------------|-------|
| `longint` (4 bytes) | `int` | Signed 32-bit integer |
| `string` (fixed) | `str` | Decoded with cp852, null-terminated |
| `double` (8 bytes) | `Decimal` | Financial precision |
| `boolean` (1 byte) | `bool` | 0=False, 1=True |
| `TDateTime` (date) | `date` | Days since 1899-12-30 |
| `TDateTime` (time) | `datetime` | Milliseconds since midnight |

### String Encoding

```python
# NEX Genesis používa CP852 (Czech/Slovak)
DEFAULT_ENCODING = 'cp852'

# Pri deserialize
text = data[0:100].decode('cp852', errors='ignore').rstrip('\x00 ')

# Pri serialize
data[0:100] = text.encode('cp852')[:100]  # Truncate to max length
```

### Delphi Date/Time

```python
# Delphi TDateTime = days since 1899-12-30
def decode_delphi_date(days: int) -> date:
    base = datetime(1899, 12, 30)
    return (base + timedelta(days=days)).date()

def encode_delphi_date(dt: date) -> int:
    base = datetime(1899, 12, 30)
    return (datetime.combine(dt, datetime.min.time()) - base).days

# Delphi Time = milliseconds since midnight
def decode_delphi_time(ms: int) -> datetime:
    base = datetime.now().replace(hour=0, minute=0, second=0, microsecond=0)
    return base + timedelta(milliseconds=ms)

def encode_delphi_time(dt: datetime) -> int:
    midnight = dt.replace(hour=0, minute=0, second=0, microsecond=0)
    return int((dt - midnight).total_seconds() * 1000)
```

### Decimal Precision

```python
# Vždy používaj Decimal pre finančné hodnoty!
from decimal import Decimal

# ❌ ZLE - float môže mať nepresnosti
price = 99.99
vat = price * 0.20  # 19.998000000000001

# ✅ SPRÁVNE - Decimal je presný
price = Decimal("99.99")
vat = price * Decimal("0.20")  # 19.9980 -> 20.00 po round(2)
```

---

## ✅ Best Practices

### 1. Vždy validuj pred uložením

```python
product = GSCATRecord(...)

errors = product.validate()
if errors:
    raise ValueError(f"Invalid product: {errors}")

# Now safe to serialize
raw_data = product.to_bytes()
```

### 2. Používaj Decimal pre peniaze

```python
# ❌ ZLE
price = 99.99  # float
total = price * 1.20

# ✅ SPRÁVNE
price = Decimal("99.99")
total = price * Decimal("1.20")
```

### 3. Nastav audit fields

```python
record.mod_user = "API"
record.mod_date = datetime.now()
record.mod_time = datetime.now()
```

### 4. Používaj type hints

```python
def process_product(product: GSCATRecord) -> Decimal:
    return product.price_sell * Decimal("1.20")
```

### 5. Try/except pri deserialize

```python
try:
    record = BarcodeRecord.from_bytes(raw_data)
except ValueError as e:
    logger.error(f"Failed to deserialize: {e}")
    return None
```

### 6. Helper methods

```python
# Používaj helper methods namiesto priameho prístupu

# ❌ Komplikované
full_name = f"{partner.name1} {partner.name2}".strip()

# ✅ Čisté
full_name = partner.get_full_name()
```

---

## 📚 Príklady

Viac príkladov nájdeš v:
- `tests/test_models.py` - Unit testy pre modely
- `examples/models_usage.py` - Praktické príklady použitia
- `docs/sessions/` - Real-world use cases

---

## 🐛 Troubleshooting

### Record size mismatch

```python
# Problem: len(data) != expected size
# Solution: Check .bdf definition, adjust field offsets

# Debug: Print actual sizes
print(f"Expected: 705 bytes, Got: {len(data)} bytes")
print(f"First 100 bytes (hex): {data[:100].hex()}")
```

### Encoding issues

```python
# Problem: Garbage characters in text fields
# Solution: Try different encoding

# cp852 - Czech/Slovak (default)
# windows-1250 - Central European
# latin2 - ISO-8859-2

text = data[0:100].decode('windows-1250', errors='ignore')
```

### Date/Time conversion

```python
# Problem: Invalid dates (negative or huge numbers)
# Solution: Check for sentinel values

if date_int > 0:  # Only convert valid dates
    date_value = decode_delphi_date(date_int)
else:
    date_value = None
```

---

## 📝 Field Offsets

Pre debugging a analýzu record layouts:

```python
# GSCAT.BTR (705 bytes)
0-3:     GsCode (longint)
4-83:    GsName (string, 80)
84-163:  GsName2 (string, 80)
164-193: GsShortName (string, 30)
194-197: MglstCode (longint)
...

# PAB.BTR (1269 bytes)
0-3:     PabCode (longint)
4-103:   Name1 (string, 100)
104-203: Name2 (string, 100)
...
```

Kompletné field offsets sú v komentároch v každom modeli (`*.py` súbory).

---

**Created:** 2025-10-23  
**Version:** 1.0.0  
**Author:** ICC (rauschiccsk)  
**Project:** nex-genesis-server

🎯 **NEX Genesis Models - Complete Documentation** ✨