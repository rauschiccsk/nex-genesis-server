# NEX Genesis Server - Database Context

**NEX Genesis Database Schema and Structure**

Version: 1.0.0  
Last Updated: 2025-10-23

---

## Database Location

```
C:\NEX\YEARACT\
├─ STORES\              # Skladové hospodárstvo
│  ├─ GSCAT.BTR         # Produktový katalóg
│  ├─ BARCODE.BTR       # Čiarové kódy
│  ├─ MGLST.BTR         # Tovarové skupiny
│  ├─ TSHA-001.BTR      # Dodacie listy header
│  └─ TSIA-001.BTR      # Dodacie listy items
└─ DIALS\               # Číselníky
   └─ PAB00000.BTR      # Obchodní partneri
```

---

## Schema Files

Real NEX Genesis .bdf files available in: `database-schema/`

```
database-schema/
├─ barcode.bdf    # Čiarové kódy produktov
├─ gscat.bdf      # Produktový katalóg (master)
├─ mglst.bdf      # Tovarové skupiny
├─ pab.bdf        # Obchodní partneri (dodávatelia)
├─ tsh.bdf        # Dodacie listy (header)
├─ tsi.bdf        # Dodacie listy (items)
└─ README.md      # Dokumentácia schém
```

---

## Table Relationships

```
MGLST (Tovarové skupiny)
  ↓ 1:N
GSCAT (Produktový katalóg)
  ↓ 1:N
BARCODE (Čiarové kódy)

PAB (Dodávatelia)
  ↓ 1:N
TSH (Dodacie listy - header)
  ↓ 1:N
TSI (Dodacie listy - items)
  → N:1
GSCAT (Produkty)
```

---

## Tables Overview

### GSCAT.BTR - Produktový katalóg

**Purpose:** Master product catalog  
**Location:** `C:\NEX\YEARACT\STORES\GSCAT.BTR`  
**Definition:** `database-schema/gscat.bdf`  
**Primary Key:** GsCode (integer)  
**Record Size:** 705 bytes  
**Indexes:** 18

**Key Fields:**
- GsCode - Unique product code
- Name - Product name (Czech/Slovak)
- MglstCode - Product group reference
- Price - Current price
- VAT - VAT rate
- Unit - Measurement unit
- Supplier - Default supplier reference

**Status:** WORKING - Data reading verified (226 records)

---

### BARCODE.BTR - Čiarové kódy

**Purpose:** Product barcode registry  
**Location:** `C:\NEX\YEARACT\STORES\BARCODE.BTR`  
**Definition:** `database-schema/barcode.bdf`  
**Primary Key:** BarCode (string)  
**Record Size:** Variable  
**Indexes:** 2

**Key Fields:**
- BarCode - EAN/UPC barcode
- GsCode - Product reference
- Quantity - Barcode quantity multiplier
- IsDefault - Default barcode flag

**Status:** WORKING - Empty table verified

---

### MGLST.BTR - Tovarové skupiny

**Purpose:** Product groups hierarchy  
**Location:** `C:\NEX\YEARACT\STORES\MGLST.BTR`  
**Definition:** `database-schema/mglst.bdf`  
**Primary Key:** MglstCode (integer)  
**Record Size:** Variable  
**Indexes:** Multiple

**Key Fields:**
- MglstCode - Unique group code
- Name - Group name
- ParentCode - Parent group (hierarchy)
- Level - Hierarchy level

**Status:** WORKING - Structure verified

---

### PAB00000.BTR - Obchodní partneri

**Purpose:** Business partners (suppliers and customers)  
**Location:** `C:\NEX\YEARACT\DIALS\PAB00000.BTR`  
**Definition:** `database-schema/pab.bdf`  
**Primary Key:** PabCode (integer)  
**Record Size:** 1269 bytes  
**Indexes:** Multiple

**Key Fields:**
- PabCode - Unique partner code
- Name1 - Partner name (line 1)
- Name2 - Partner name (line 2)
- ICO - Company registration number
- DIC - Tax identification number
- Address - Street address
- City - City
- ZIP - Postal code
- Country - Country code

**Status:** WORKING - Data reading verified (ICC s.r.o., CONSULTING s.r.o. found)

**Note:** Located in DIALS directory, not STORES

---

### TSHA-001.BTR - Dodacie listy (header)

**Purpose:** Delivery notes header  
**Location:** `C:\NEX\YEARACT\STORES\TSHA-001.BTR`  
**Definition:** `database-schema/tsh.bdf`  
**Primary Key:** DocNumber (string)  
**Record Size:** Variable  
**Indexes:** Multiple

**Key Fields:**
- DocNumber - Unique document number
- DocDate - Document date
- PabCode - Supplier reference (PAB)
- TotalAmount - Total amount
- Currency - Currency code (EUR)
- BookNumber - Book number (001, 002, etc.)
- BookType - A=actual year, P=previous

**File Naming Convention:**
- Format: `TSH{BookType}-{BookNumber}.BTR`
- Examples: `TSHA-001.BTR`, `TSHA-002.BTR`, `TSHP-001.BTR`
- Default: `TSHA-001.BTR` (actual year, book 001)

**Status:** WORKING - File opening verified

---

### TSIA-001.BTR - Dodacie listy (items)

**Purpose:** Delivery note line items  
**Location:** `C:\NEX\YEARACT\STORES\TSIA-001.BTR`  
**Definition:** `database-schema/tsi.bdf`  
**Primary Key:** DocNumber + LineNumber  
**Record Size:** Variable  
**Indexes:** Multiple

**Key Fields:**
- DocNumber - Document reference (TSH)
- LineNumber - Line sequence number
- GsCode - Product reference (GSCAT)
- Quantity - Item quantity
- Price - Unit price
- Amount - Line amount
- VAT - VAT rate
- Unit - Measurement unit

**File Naming Convention:**
- Format: `TSI{BookType}-{BookNumber}.BTR`
- Examples: `TSIA-001.BTR`, `TSIA-002.BTR`, `TSIP-001.BTR`
- Default: `TSIA-001.BTR` (actual year, book 001)

**Status:** WORKING - File opening verified

---

## ISDOC to NEX Mapping

### Invoice Header Mapping

```xml
<Invoice>
  <ID>                     → SupplierInvoiceNumber (reference)
  <IssueDate>              → TSH.DocDate
  <DocumentCurrencyCode>   → Validate: must be EUR
  
  <AccountingSupplierParty>
    <Party>
      <PartyIdentification>
        <ID>               → PAB lookup by ICO
      </PartyIdentification>
      <PartyName>
        <Name>             → PAB.Name1
      </PartyName>
      <PostalAddress>
        <StreetName>       → PAB.Address
        <CityName>         → PAB.City
        <PostalZone>       → PAB.ZIP
        <Country>          → PAB.Country
      </PostalAddress>
    </Party>
  </AccountingSupplierParty>
```

### Invoice Lines Mapping

```xml
<InvoiceLine>
  <ID>                     → TSI.LineNumber
  <InvoicedQuantity>       → TSI.Quantity
  <LineExtensionAmount>    → TSI.Amount
  
  <Item>
    <Name>                 → GSCAT.Name (if creating new)
    <Description>          → GSCAT.Description
    <SellersItemIdentification>
      <ID>                 → BARCODE.BarCode (supplier code)
    </SellersItemIdentification>
  </Item>
  
  <Price>
    <PriceAmount>          → TSI.Price
    <BaseQuantity>         → Unit conversion
  </Price>
  
  <TaxTotal>
    <TaxSubtotal>
      <TaxCategory>
        <Percent>          → TSI.VAT (validate: 0, 10, 20)
      </TaxCategory>
    </TaxSubtotal>
  </TaxTotal>
</InvoiceLine>
```

---

## Book Numbering System

### TSH/TSI File Naming

**Format:**
```
TSH{BookType}-{BookNumber}.BTR
TSI{BookType}-{BookNumber}.BTR
```

**BookType Values:**
- `A` = Actual year (aktuálny rok)
- `P` = Previous years (predchádzajúce roky)

**BookNumber Values:**
- `001`, `002`, `003`, ... (3-digit zero-padded)

**Examples:**
```
TSHA-001.BTR  # Delivery notes header - current year, book 1
TSIA-001.BTR  # Delivery notes items - current year, book 1
TSHA-002.BTR  # Delivery notes header - current year, book 2
TSHP-001.BTR  # Delivery notes header - previous years, book 1
```

**Configuration:**
```yaml
# config/database.yaml
books:
  delivery_notes_book: "001"  # Default book number
  book_type: "A"              # A=actual, P=previous
```

---

## Important Notes

### File Extensions
- NEX Genesis uses `.BTR` extension (not `.DAT`)
- Case: Uppercase convention (Windows ignores case)

### Directory Structure
- **YEARACT** - Contains data for active year
- **STORES** - Stock management tables
- **DIALS** - Reference tables (číselníky)
- **DBIDEF** - Database definitions (.bdf files)

### Special Cases
- **PAB** is in DIALS, not STORES
- **TSH/TSI** have dynamic filenames based on book number
- **YEARACT** changes each year

### Access Rights
- Need read/write permissions on `C:\NEX\YEARACT\`
- Btrieve locks files during operations
- Always close files after use

### Backup Strategy
- Regular backups of `YEARACT\STORES\` and `YEARACT\DIALS\`
- Before major operations, create backup
- Test restore procedures

### Performance
- Use indexes for lookups
- Minimize file open/close cycles
- Cache frequently accessed data
- Close files when not in use

---

## Database Operations Best Practices

### Opening Files
```python
# Always use BtrieveClient wrapper
client = BtrieveClient()
pos_block = client.open_file(file_path, mode=-2)  # Read-only
```

### Reading Records
```python
# Use Get First + Get Next pattern
status = client.get_first(pos_block, data_buffer, key_num=0)
while status == 0:
    # Process record
    status = client.get_next(pos_block, data_buffer)
```

### Searching Records
```python
# Use Get Equal with key
key_buffer = struct.pack('i', gsCode)
status = client.get_equal(pos_block, data_buffer, key_buffer, key_num=0)
```

### Closing Files
```python
# Always close, even on errors
try:
    # Operations
finally:
    client.close_file(pos_block)
```

---

## Encoding and Character Sets

### String Encoding
- NEX Genesis uses **Windows-1250** or **CP852** (Czech/Slovak)
- Python strings must be encoded before write
- Decode bytes when reading

### Example:
```python
# Writing
name_encoded = "Produkt XYZ".encode('cp1250')

# Reading  
name_decoded = name_bytes.decode('cp1250')
```

---

## Data Validation Rules

### Required Fields
- GSCAT: GsCode, Name, MglstCode
- PAB: PabCode, Name1, ICO
- TSH: DocNumber, DocDate, PabCode
- TSI: DocNumber, LineNumber, GsCode, Quantity

### Field Lengths
- Check .bdf files for exact field lengths
- Truncate or validate before write
- Strings are fixed-length in Btrieve

### VAT Rates
- Valid values: 0%, 10%, 20%
- Default: 20%

### Currency
- Only EUR supported
- Validate ISDOC currency code

---

**For detailed schemas:** See `docs/NEX_DATABASE_STRUCTURE.md`  
**For Btrieve operations:** See `docs/context/btrieve_rules.md`  
**For current status:** See `docs/sessions/YYYY-MM-DD_session.md` (latest session)