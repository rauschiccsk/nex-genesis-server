# ISDOC to NEX Genesis Mapping

**Version:** 1.0.0  
**Date:** 2025-10-23  
**Purpose:** Mapping špecifikácia pre ISDOC XML ↔ NEX Genesis databázu

---

## Overview

Tento dokument popisuje mapping medzi:
- **ISDOC 6.0.1 XML** (slovenský štandard elektronických faktúr)
- **InvoiceData** (Python dataclass z supplier_invoice_loader)
- **NEX Genesis Database** (Btrieve tabuľky)

### Hlavné Komponenty

```
ISDOC XML / InvoiceData
    ↓
ISDOCToNEXMapper
    ↓
NEX Genesis Database (PAB, GSCAT, BARCODE, TSH, TSI)
```

---

## 1. PAB Mapping (Obchodní Partneri)

### 1.1 Dodávateľ (Supplier)

| ISDOC Field | InvoiceData Field | NEX PAB Field | Type | Max Length | Notes |
|-------------|------------------|---------------|------|------------|-------|
| AccountingSupplierParty/Party/PartyIdentification/ID | supplier_ico | IC | string | 8 | IČO, zero-padded |
| AccountingSupplierParty/Party/PartyName/Name | supplier_name | Nazov | string | 60 | Obchodné meno |
| AccountingSupplierParty/Party/PartyTaxScheme[DIČ]/CompanyID | supplier_dic | DIC | string | 10 | DIČ, zero-padded |
| AccountingSupplierParty/Party/PartyTaxScheme[VAT]/CompanyID | supplier_icdph | ICDPH | string | 12 | IČ DPH (SKxxxxxxxxxx) |
| AccountingSupplierParty/Party/PostalAddress/StreetName | supplier_address | Ulica | string | 40 | Ulica a číslo |
| AccountingSupplierParty/Party/PostalAddress/CityName | supplier_address | Mesto | string | 40 | Mesto |
| AccountingSupplierParty/Party/PostalAddress/PostalZone | - | PSC | string | 10 | PSČ |
| AccountingSupplierParty/Party/PostalAddress/Country/IdentificationCode | - | Stat | string | 3 | Kód krajiny (SK) |

### 1.2 Odberateľ (Customer)

| ISDOC Field | InvoiceData Field | NEX PAB Field | Type | Max Length | Notes |
|-------------|------------------|---------------|------|------------|-------|
| AccountingCustomerParty/Party/PartyIdentification/ID | customer_ico | IC | string | 8 | IČO, zero-padded |
| AccountingCustomerParty/Party/PartyName/Name | customer_name | Nazov | string | 60 | Obchodné meno |
| AccountingCustomerParty/Party/PartyTaxScheme[DIČ]/CompanyID | customer_dic | DIC | string | 10 | DIČ, zero-padded |
| AccountingCustomerParty/Party/PartyTaxScheme[VAT]/CompanyID | customer_icdph | ICDPH | string | 12 | IČ DPH (SKxxxxxxxxxx) |
| AccountingCustomerParty/Party/PostalAddress/StreetName | customer_address | Ulica | string | 40 | Ulica a číslo |
| AccountingCustomerParty/Party/PostalAddress/CityName | customer_address | Mesto | string | 40 | Mesto |

**Transformácie:**
- `IC`: Zero-pad na 8 znakov (napr. "123456" → "00123456")
- `DIC`: Zero-pad na 10 znakov
- `ICDPH`: Formát SKxxxxxxxxxx (10 číslic po SK)
- `Adresa`: Parsing z jedného stringu na komponenty (ulica, mesto, PSČ)

---

## 2. GSCAT Mapping (Produktový Katalóg)

### 2.1 Field Mapping

| ISDOC Field | InvoiceData Field | NEX GSCAT Field | Type | Max Length | Notes |
|-------------|------------------|-----------------|------|------------|-------|
| InvoiceLine/Item/SellersItemIdentification/ID | item_code | GsCode | integer | 2 bytes | Kód produktu |
| InvoiceLine/Item/Description | description | Nazov | Pascal string | 20 chars | **Pascal string!** |
| InvoiceLine/UnitPrice | unit_price_no_vat | Cena | float | - | Cena bez DPH |
| InvoiceLine/InvoicedQuantity/@unitCode | unit | Mj | string | 3 | Merná jednotka |
| InvoiceLine/Item/StandardItemIdentification/ID | ean_code | Ean | string | 13 | EAN kód (→ BARCODE) |

**CRITICAL: Pascal String Handling**
```python
# NEX Genesis používa Pascal strings (length-prefixed)
# Nazov v GSCAT má limit 20 znakov + 1 byte pre dĺžku
# 
# Example:
# "Produkt ABC" → b'\x0bProdukt ABC'
#                  ^^ length byte (11 chars)
```

### 2.2 Unit Normalization

| ISDOC Unit | InvoiceData | NEX Unit | Notes |
|------------|-------------|----------|-------|
| PCE, EA | KS | KS | Kusy (pieces) |
| LTR | L | L | Litre |
| MTR | M | M | Metre |
| KGM | KG | KG | Kilogramy |
| MTK | M2 | M2 | Štvorcové metre |
| MTQ | M3 | M3 | Kubické metre |

---

## 3. BARCODE Mapping (Čiarové Kódy)

### 3.1 Field Mapping

| ISDOC Field | InvoiceData Field | NEX BARCODE Field | Type | Max Length | Notes |
|-------------|------------------|-------------------|------|------------|-------|
| InvoiceLine/Item/SellersItemIdentification/ID | item_code | GsCode | integer | 2 bytes | Kód produktu |
| InvoiceLine/Item/StandardItemIdentification/ID | ean_code | Ean | string | 13 | EAN-13 kód |

**Poznámka:** 
- BARCODE záznam sa vytvorí **len ak** InvoiceItem má both `item_code` AND `ean_code`
- EAN musí byť validný 13-znakový kód

---

## 4. TSH Mapping (Dodacie Listy - Header)

### 4.1 Field Mapping

| ISDOC Field | InvoiceData Field | NEX TSH Field | Type | Format | Notes |
|-------------|------------------|---------------|------|--------|-------|
| Invoice/ID | invoice_number | CisloDokladu | string | - | Číslo faktúry |
| Invoice/IssueDate | issue_date | Datum | string | DD.MM.YYYY | Dátum vystavenia |
| Invoice/PaymentDueDate | due_date | DatumSplatnosti | string | DD.MM.YYYY | Dátum splatnosti |
| AccountingSupplierParty/.../ID | supplier_ico | DodavatelIC | string | 8 chars | IČO dodávateľa |
| AccountingCustomerParty/.../ID | customer_ico | OdberatelIC | string | 8 chars | IČO odberateľa |
| LegalMonetaryTotal/TaxExclusiveAmount | net_amount | Celkom | Decimal | - | Suma bez DPH |
| LegalMonetaryTotal/TaxInclusiveAmount | total_amount | CelkomSDPH | Decimal | - | Suma s DPH |
| TaxTotal/TaxAmount | tax_amount | DPH | Decimal | - | Suma DPH |
| Invoice/CurrencyCode | currency | Mena | string | 3 | Kód meny (EUR) |

**Date Format Conversion:**
```python
# ISDOC: ISO 8601 format (YYYY-MM-DD)
"2025-10-23"

# NEX Genesis: Slovak format (DD.MM.YYYY)
"23.10.2025"

# Transformation:
datetime.strptime("2025-10-23", "%Y-%m-%d").strftime("%d.%m.%Y")
```

---

## 5. TSI Mapping (Dodacie Listy - Items)

### 5.1 Field Mapping

| ISDOC Field | InvoiceData Field | NEX TSI Field | Type | Notes |
|-------------|------------------|---------------|------|-------|
| InvoiceLine/ID | line_number | Por | integer | Poradové číslo (1, 2, 3...) |
| InvoiceLine/Item/SellersItemIdentification/ID | item_code | GsCode | integer | Kód produktu |
| InvoiceLine/Item/Description | description | Nazov | string | Názov produktu (40 chars) |
| InvoiceLine/InvoicedQuantity | quantity | Mnozstvo | Decimal | Množstvo |
| InvoiceLine/InvoicedQuantity/@unitCode | unit | Mj | string | Merná jednotka (3 chars) |
| InvoiceLine/UnitPrice | unit_price_no_vat | Cena | Decimal | Cena bez DPH |
| InvoiceLine/UnitPriceTaxInclusive | unit_price_with_vat | CenaSDPH | Decimal | Cena s DPH |
| InvoiceLine/LineExtensionAmountTaxInclusive | total_with_vat | CelkomSDPH | Decimal | Celkom s DPH |
| InvoiceLine/ClassifiedTaxCategory/Percent | vat_rate | SadzbaDPH | Decimal | Sadzba DPH (%) |

---

## 6. Data Transformations

### 6.1 String Cleaning

```python
# Remove whitespace from numeric identifiers
"1 2 3 4 5 6 7 8" → "12345678"  # IČO
"SK 2 0 2 0 3 6 7 1 5 1" → "SK2020367151"  # IČ DPH
```

### 6.2 Decimal Conversion

```python
# ISDOC uses dot as decimal separator
"123.45" → Decimal("123.45")

# Handle European format from PDF
"123,45" → Decimal("123.45")
```

### 6.3 Pascal String Encoding

```python
# NEX Genesis používa Pascal strings (CP852 encoding)
def encode_pascal_string(text: str, max_len: int = 20) -> bytes:
    """Encode text as Pascal string (length-prefixed)"""
    truncated = text[:max_len]
    encoded = truncated.encode('cp852')
    length = len(encoded)
    return bytes([length]) + encoded
```

### 6.4 Address Parsing

```python
# Input (single string)
"Hlavná 123, Bratislava, 81101"

# Output (components)
Ulica: "Hlavná 123"
Mesto: "Bratislava"
PSC: "81101"
```

---

## 7. Validation Rules

### 7.1 Required Fields

**PAB (Obchodní partneri):**
- ✅ `IC` (IČO) - REQUIRED, 8 chars
- ✅ `Nazov` - REQUIRED, max 60 chars
- ⚠️ `DIC`, `ICDPH` - Optional, ale recommended

**GSCAT (Produkty):**
- ✅ `GsCode` - REQUIRED, integer
- ✅ `Nazov` - REQUIRED, max 20 chars (Pascal string!)
- ⚠️ `Cena` - Optional, ale recommended

**TSH (Delivery Header):**
- ✅ `CisloDokladu` - REQUIRED
- ✅ `Datum` - REQUIRED (DD.MM.YYYY)
- ✅ `DodavatelIC`, `OdberatelIC` - REQUIRED

**TSI (Delivery Items):**
- ✅ `Por` - REQUIRED (line number)
- ✅ `GsCode` - REQUIRED (must exist in GSCAT)
- ✅ `Mnozstvo` - REQUIRED

### 7.2 Data Type Validation

```python
# IČO: 8-digit number
assert re.match(r'^\d{8}$', ico)

# DIČ: 10-digit number
assert re.match(r'^\d{10}$', dic)

# IČ DPH: SK + 10 digits
assert re.match(r'^SK\d{10}$', icdph)

# EAN: 13-digit code
assert re.match(r'^\d{13}$', ean)

# Datum: DD.MM.YYYY
assert re.match(r'^\d{2}\.\d{2}\.\d{4}$', datum)
```

### 7.3 Business Rules

1. **Dodávateľ & Odberateľ musia existovať v PAB** pred vytvorením TSH
2. **Produkty musia existovať v GSCAT** pred vytvorením TSI
3. **TSH záznam musí byť vytvorený** pred TSI items
4. **GsCode v TSI** musí referencovať existujúci GSCAT záznam
5. **Sumy musia byť konzistentné:**
   ```
   TSH.CelkomSDPH = TSH.Celkom + TSH.DPH
   TSI.CelkomSDPH = TSI.Mnozstvo * TSI.CenaSDPH
   ```

---

## 8. Usage Examples

### 8.1 Basic Usage

```python
from utils.isdoc_mapper import ISDOCToNEXMapper, InvoiceData

# Create mapper
mapper = ISDOCToNEXMapper()

# Load invoice data (from ISDOC XML or PDF extraction)
invoice_data = InvoiceData(
    invoice_number="2025001",
    supplier_ico="12345678",
    supplier_name="L & Š, s.r.o.",
    # ... more fields
)

# Map to NEX structures
supplier_pab = mapper.map_supplier_to_pab(invoice_data)
customer_pab = mapper.map_customer_to_pab(invoice_data)
products = mapper.map_items_to_gscat(invoice_data.items)
tsh = mapper.map_to_tsh(invoice_data)
tsi_items = mapper.map_items_to_tsi(invoice_data.items)
```

### 8.2 Complete Mapping

```python
from utils.isdoc_mapper import map_isdoc_to_nex

# One-shot mapping
mapped = map_isdoc_to_nex(invoice_data)

# Access components
supplier = mapped['supplier']  # NEXPABData
customer = mapped['customer']  # NEXPABData
products = mapped['products']  # List[NEXGSCATData]
barcodes = mapped['barcodes']  # List[NEXBARCODEData]
tsh = mapped['delivery_header']  # NEXTSHData
tsi = mapped['delivery_items']  # List[NEXTSIData]
```

### 8.3 Integration with Repositories

```python
from repositories import GSCATRepository, PABRepository, TSHRepository
from utils.isdoc_mapper import ISDOCToNEXMapper

mapper = ISDOCToNEXMapper()
gscat_repo = GSCATRepository()
pab_repo = PABRepository()

# Map and insert supplier
supplier_pab = mapper.map_supplier_to_pab(invoice_data)
pab_repo.create(supplier_pab)  # Insert into PAB.BTR

# Map and insert products
products = mapper.map_items_to_gscat(invoice_data.items)
for product in products:
    gscat_repo.create(product)  # Insert into GSCAT.BTR
```

---

## 9. Error Handling

### 9.1 Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| `ValueError: invalid literal for int()` | item_code nie je číslo | Skip item alebo use default |
| Pascal string too long | Nazov > 20 chars | Truncate to 20 chars |
| Missing required field | InvoiceData incomplete | Validate before mapping |
| Invalid date format | Dátum nie je DD.MM.YYYY | Convert using _format_date_nex() |
| Encoding error | Non-CP852 characters | Use transliteration |

### 9.2 Logging

```python
import logging

logger = logging.getLogger(__name__)

# Mapper logs warnings for skipped items
logger.warning(f"Item {item.line_number} has no item_code, skipping")

# Mapper logs errors for conversion failures
logger.error(f"Error mapping item {item.line_number}: {e}")
```

---

## 10. Testing

### 10.1 Unit Tests

```bash
# Run mapper tests
pytest tests/test_isdoc_mapper.py -v

# Expected tests:
# ✓ test_map_supplier_to_pab
# ✓ test_map_customer_to_pab
# ✓ test_map_items_to_gscat
# ✓ test_map_items_to_barcode
# ✓ test_map_to_tsh
# ✓ test_map_items_to_tsi
# ✓ test_complete_mapping
# ✓ test_pascal_string_truncation
# ✓ test_date_format_conversion
# ✓ test_address_parsing
```

### 10.2 Integration Tests

```bash
# Test with real ISDOC XML
pytest tests/test_isdoc_integration.py -v

# Test end-to-end flow:
# PDF → InvoiceData → NEX Mapping → Btrieve Insert
```

---

## 11. Reference Documents

### 11.1 Related Files

- **Mapper Implementation:** `src/utils/isdoc_mapper.py`
- **NEX Models:** `src/models/*.py` (gscat.py, pab.py, tsh.py, tsi.py)
- **Repositories:** `src/repositories/*.py`
- **ISDOC Generator:** `supplier_invoice_loader/isdoc.py`
- **Database Schema:** `database-schema/*.bdf`
- **NEX DB Structure:** `docs/NEX_DATABASE_STRUCTURE.md`

### 11.2 External Standards

- **ISDOC 6.0.1:** [http://www.isdoc.org](http://www.isdoc.org)
- **NEX Genesis ERP:** Proprietary Btrieve database
- **Pervasive PSQL:** [Pervasive Documentation](https://www.actian.com)

---

## 12. Future Enhancements

### Phase 2 (Planned)
- [ ] Advanced address parsing (Google Maps API?)
- [ ] VAT rate validation (23%, 20%, 10%, 0%)
- [ ] Currency conversion (EUR ↔ CZK)
- [ ] Duplicate detection (prevent re-import)
- [ ] ISDOC XML validation against XSD schema

### Phase 3 (Planned)
- [ ] Reverse mapping (NEX → ISDOC export)
- [ ] Batch import optimization
- [ ] Real-time validation API
- [ ] Web UI for mapping configuration

---

**Created:** 2025-10-23  
**Last Updated:** 2025-10-23  
**Version:** 1.0.0  
**Author:** ICC (rausch@icc.sk)