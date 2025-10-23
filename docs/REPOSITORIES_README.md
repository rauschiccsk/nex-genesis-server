# NEX Genesis Repositories Documentation

**Version:** 1.0.0  
**Date:** 2025-10-23  
**Author:** ICC (rauschiccsk)

---

## 📋 Obsah

1. [Prehľad](#prehľad)
2. [Architektúra](#architektúra)
3. [Používanie](#používanie)
4. [Repositories](#repositories)
5. [Best Practices](#best-practices)
6. [Advanced Usage](#advanced-usage)

---

## 🎯 Prehľad

Repository pattern poskytuje high-level API pre prácu s NEX Genesis tabuľkami. Kombinuje:

✅ **BtrieveClient** (low-level Btrieve operations)  
✅ **Models** (type-safe dataclasses)  
✅ **Business Logic** (domain-specific queries)  
✅ **Context Management** (automatic open/close)  
✅ **Error Handling** (safe operations)

### Výhody

- **Clean API** - jednoduché, intuitívne metódy
- **Type Safety** - Python type hints + dataclasses
- **Testovateľné** - ľahko mockovateľné pre unit testy
- **DRY** - žiadna duplicitná logika
- **Read-Only Default** - ochrana proti náhodným zmenám

---

## 🏗️ Architektúra

```
┌─────────────────────────────────────────────────────┐
│ Application Layer (Business Logic)                 │
│ - REST API endpoints                                │
│ - ISDOC import services                             │
│ - Report generators                                 │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ Repository Layer (This Package)                     │
│ - BarcodeRepository                                 │
│ - GSCATRepository                                   │
│ - PABRepository                                     │
│ - Domain-specific queries                           │
│ - Business logic helpers                            │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ Model Layer (Dataclasses)                           │
│ - BarcodeRecord                                     │
│ - GSCATRecord                                       │
│ - PABRecord                                         │
│ - Serialization/Deserialization                     │
│ - Validation                                        │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ Client Layer (BtrieveClient)                        │
│ - Low-level Btrieve operations                      │
│ - DLL loading                                       │
│ - File operations                                   │
│ - Raw bytes handling                                │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ Database Layer (Btrieve)                            │
│ - BARCODE.BTR                                       │
│ - GSCAT.BTR                                         │
│ - PAB00000.BTR                                      │
└─────────────────────────────────────────────────────┘
```

---

## 🚀 Používanie

### Základné použitie

```python
from src.repositories import GSCATRepository

# Context manager (recommended)
with GSCATRepository() as repo:
    # Find product
    product = repo.find_by_gs_code(12345)
    
    if product:
        print(f"Product: {product.gs_name}")
        print(f"Price: {product.price_sell} EUR")
        print(f"Stock: {product.stock_current} {product.unit}")
```

### Manual Open/Close

```python
from src.repositories import BarcodeRepository

repo = BarcodeRepository()

try:
    repo.open()
    
    # Find barcode
    barcode = repo.find_by_barcode("8594000123456")
    if barcode:
        print(f"Product code: {barcode.gs_code}")
    
finally:
    repo.close()
```

### Hromadné operácie

```python
from src.repositories import GSCATRepository

with GSCATRepository() as repo:
    # Get all active products
    products = repo.get_active_products()
    
    # Search by name
    electronics = repo.search_by_name("elektronika")
    
    # Find low stock
    low_stock = repo.find_low_stock()
    
    # Statistics
    stats = repo.get_statistics()
    print(f"Total products: {stats['total_products']}")
    print(f"Low stock: {stats['low_stock_count']}")
```

---

## 📚 Repositories

### BarcodeRepository

**Účel:** Práca s čiarovými kódmi produktov

**Tabuľka:** BARCODE.BTR

**Key Methods:**
```python
# Find by barcode
barcode = repo.find_by_barcode("8594000123456")

# Get all barcodes for product
barcodes = repo.find_by_gs_code(12345)

# Check existence
exists = repo.exists_barcode("8594000123456")
exists_combo = repo.exists_combination(12345, "8594000123456")

# Get product code from barcode
gs_code = repo.get_product_code("8594000123456")

# Count barcodes for product
count = repo.count_by_product(12345)

# Get barcode list
barcode_list = repo.get_barcode_list(12345)
# Returns: ["8594000123456", "PROD-12345", "QR-12345"]

# Find duplicates
duplicates = repo.find_duplicates()
# Returns: {"8594000123456": [123, 456], ...}

# Statistics
stats = repo.get_statistics()
```

**Example:**
```python
with BarcodeRepository() as repo:
    # Lookup product by barcode
    barcode = "8594000123456"
    gs_code = repo.get_product_code(barcode)
    
    if gs_code:
        print(f"Barcode {barcode} belongs to product {gs_code}")
        
        # Get all barcodes for this product
        all_barcodes = repo.get_barcode_list(gs_code)
        print(f"Product has {len(all_barcodes)} barcodes:")
        for bc in all_barcodes:
            print(f"  - {bc}")
```

---

### GSCATRepository

**Účel:** Práca s produktovým katalógom

**Tabuľka:** GSCAT.BTR

**Key Methods:**
```python
# Find by GsCode
product = repo.find_by_gs_code(12345)

# Search by name
products = repo.search_by_name("notebook", case_sensitive=False)

# Find by category
category_products = repo.find_by_category(mglst_code=10)

# Find by supplier
supplier_products = repo.find_by_supplier(supplier_code=100)

# Get active/discontinued
active = repo.get_active_products()
discontinued = repo.get_discontinued_products()

# Stock management
low_stock = repo.find_low_stock()
over_stock = repo.find_over_stock()
low_stock_custom = repo.find_low_stock(threshold=Decimal("10.0"))

# Price queries
price_range = repo.find_by_price_range(
    min_price=Decimal("50.00"),
    max_price=Decimal("500.00")
)

# VAT queries
vat_20 = repo.find_by_vat_rate(Decimal("20.0"))

# Financial calculations
stock_value = repo.calculate_total_stock_value()
# Returns: {
#     'total_buy_value': Decimal,
#     'total_sell_value': Decimal,
#     'potential_profit': Decimal,
#     'profit_margin_percent': Decimal
# }

# Product info
info = repo.get_product_info(12345)
# Returns complete product dict with calculated fields

# Statistics
stats = repo.get_statistics()
```

**Example:**
```python
with GSCATRepository() as repo:
    # Low stock alert
    low_stock = repo.find_low_stock()
    
    if low_stock:
        print(f"⚠️  {len(low_stock)} products have low stock:")
        for product in low_stock:
            print(f"  - {product.gs_name}: {product.stock_current}/{product.stock_min}")
    
    # Calculate inventory value
    value = repo.calculate_total_stock_value()
    print(f"\n📊 Inventory Value:")
    print(f"  Buy value: {value['total_buy_value']:.2f} EUR")
    print(f"  Sell value: {value['total_sell_value']:.2f} EUR")
    print(f"  Profit: {value['potential_profit']:.2f} EUR ({value['profit_margin_percent']:.1f}%)")
```

---

### PABRepository

**Účel:** Práca s obchodnými partnermi

**Tabuľka:** PAB00000.BTR

**Key Methods:**
```python
# Find by code
partner = repo.find_by_pab_code(123)

# Search by name
partners = repo.search_by_name("ICC", case_sensitive=False)

# Find by IČO
partner = repo.find_by_ico("12345678")

# Find by city
bratislava_partners = repo.find_by_city("Bratislava")

# Get by type
suppliers = repo.get_suppliers()
customers = repo.get_customers()

# Get active
active = repo.get_active_partners()

# VAT payers
vat_payers = repo.get_vat_payers()

# Find by email
partner = repo.find_by_email("info@icc.sk")

# Payment terms
net30 = repo.find_by_payment_terms(days=30)

# Credit limit
high_credit = repo.find_with_credit_limit(min_limit=10000.0)

# Partner info
info = repo.get_partner_info(123)
# Returns complete partner dict

# Export contacts
contacts = repo.export_contact_list()
# Returns list of simplified contact dicts

# Statistics
stats = repo.get_statistics()
```

**Example:**
```python
with PABRepository() as repo:
    # Search partner
    results = repo.search_by_name("ICC")
    
    if results:
        partner = results[0]
        info = repo.get_partner_info(partner.pab_code)
        
        print(f"Partner: {info['name']}")
        print(f"Type: {info['type']}")
        print(f"Email: {info['email']}")
        print(f"Phone: {info['phone']}")
        print(f"Payment terms: {info['payment_terms']} days")
        print(f"Credit limit: {info['credit_limit']:.2f} EUR")
    
    # Get supplier list
    suppliers = repo.get_suppliers()
    print(f"\nActive suppliers: {len(suppliers)}")
    
    # Export contacts for email campaign
    contacts = repo.export_contact_list()
    for contact in contacts:
        if contact['email']:
            print(f"Send email to: {contact['name']} <{contact['email']}>")
```

---

## ✅ Best Practices

### 1. Vždy používaj Context Manager

```python
# ✅ SPRÁVNE - automatic open/close
with GSCATRepository() as repo:
    product = repo.find_by_gs_code(123)

# ❌ ZLE - manual management, easy to forget close()
repo = GSCATRepository()
repo.open()
product = repo.find_by_gs_code(123)
# Forgot to close! ❌
```

### 2. Error Handling

```python
# ✅ SPRÁVNE - check for None
with GSCATRepository() as repo:
    product = repo.find_by_gs_code(123)
    
    if product:
        print(product.gs_name)
    else:
        print("Product not found")

# ❌ ZLE - assume product exists
product = repo.find_by_gs_code(123)
print(product.gs_name)  # AttributeError if None!
```

### 3. Use Type Hints

```python
from typing import Optional
from src.repositories import GSCATRepository
from src.models import GSCATRecord

def get_product_price(gs_code: int) -> Optional[Decimal]:
    """Get product price by code"""
    with GSCATRepository() as repo:
        product: Optional[GSCATRecord] = repo.find_by_gs_code(gs_code)
        return product.price_sell if product else None
```

### 4. Limit Results

```python
# ✅ SPRÁVNE - use max_results for safety
products = repo.find(lambda p: p.active, max_results=100)

# ⚠️  NEBEZPEČNÉ - unlimited results (može byť veľmi pomalé)
products = repo.find(lambda p: p.active, max_results=999999)
```

### 5. Batch Processing

```python
# ✅ SPRÁVNE - process in batches
with GSCATRepository() as repo:
    batch_size = 100
    processed = 0
    
    product = repo.get_first()
    batch = []
    
    while product:
        batch.append(product)
        
        if len(batch) >= batch_size:
            process_batch(batch)
            batch = []
            processed += batch_size
            print(f"Processed {processed} products...")
        
        product = repo.get_next()
    
    # Process remaining
    if batch:
        process_batch(batch)
```

### 6. Kombinovanie Repositories

```python
from src.repositories import GSCATRepository, BarcodeRepository

def find_product_by_barcode(barcode: str) -> Optional[dict]:
    """Find product info using barcode"""
    
    # 1. Lookup barcode
    with BarcodeRepository() as barcode_repo:
        barcode_record = barcode_repo.find_by_barcode(barcode)
        
        if not barcode_record:
            return None
        
        gs_code = barcode_record.gs_code
    
    # 2. Get product details
    with GSCATRepository() as product_repo:
        return product_repo.get_product_info(gs_code)
```

---

## 🔧 Advanced Usage

### Custom Queries

```python
from src.repositories import GSCATRepository
from decimal import Decimal

with GSCATRepository() as repo:
    # Complex predicate
    expensive_low_stock = repo.find(
        predicate=lambda p: (
            p.active and 
            not p.discontinued and
            p.price_sell > Decimal("100.00") and
            p.stock_current < p.stock_min
        ),
        max_results=50
    )
```

### Statistics & Reporting

```python
from src.repositories import GSCATRepository, PABRepository

def generate_inventory_report():
    """Generate comprehensive inventory report"""
    
    with GSCATRepository() as repo:
        # Basic stats
        stats = repo.get_statistics()
        
        # Stock analysis
        low_stock = repo.find_low_stock()
        over_stock = repo.find_over_stock()
        
        # Financial analysis
        value = repo.calculate_total_stock_value()
        
        # Category breakdown
        categories = {}
        for product in repo.get_active_products():
            cat = product.mglst_code
            if cat not in categories:
                categories[cat] = {
                    'count': 0,
                    'total_value': Decimal("0.00")
                }
            categories[cat]['count'] += 1
            categories[cat]['total_value'] += (
                product.stock_current * product.price_sell
            )
        
        return {
            'stats': stats,
            'alerts': {
                'low_stock': len(low_stock),
                'over_stock': len(over_stock)
            },
            'value': value,
            'categories': categories
        }
```

### Validation

```python
from src.repositories import GSCATRepository

def validate_catalog():
    """Validate entire product catalog"""
    
    with GSCATRepository() as repo:
        results = repo.validate_all()
        
        print(f"Validation Results:")
        print(f"  Total: {results['total']}")
        print(f"  Valid: {results['valid']}")
        print(f"  Invalid: {results['invalid']}")
        
        if results['errors']:
            print("\nErrors:")
            for record, errors in results['errors']:
                print(f"  Product {record.gs_code}: {errors}")
        
        return results['invalid'] == 0
```

---

## 🐛 Troubleshooting

### Repository won't open

```python
# Problem: repo.open() returns False

# Debug:
with GSCATRepository() as repo:
    if not repo._is_open:
        print("Failed to open table")
        # Check:
        # 1. Is BtrieveClient configured correctly?
        # 2. Does table file exist?
        # 3. Check permissions
```

### Records not found

```python
# Problem: find_by_*() returns None

# Debug:
with GSCATRepository() as repo:
    # Check if table has data
    count = repo.count()
    print(f"Table has {count} records")
    
    # Get first record to verify deserialization
    first = repo.get_first()
    if first:
        print(f"First record: {first}")
    else:
        print("Table is empty or deserialization failed")
```

### Slow queries

```python
# Problem: Queries take long time

# Solution 1: Limit results
products = repo.find(predicate, max_results=100)

# Solution 2: Use index-based methods when available
# (Future enhancement)

# Solution 3: Cache results
_product_cache = {}

def get_product_cached(gs_code: int):
    if gs_code not in _product_cache:
        with GSCATRepository() as repo:
            _product_cache[gs_code] = repo.find_by_gs_code(gs_code)
    return _product_cache[gs_code]
```

---

## 📝 Next Steps

1. **Implement remaining repositories:**
   - MGLSTRepository (categories)
   - TSHRepository (delivery notes header)
   - TSIRepository (delivery notes items)

2. **Add index-based searches:**
   - Use Btrieve indexes for faster lookups
   - Implement step_first/step_next operations

3. **Implement CRUD operations:**
   - Currently read-only
   - Add insert/update/delete when needed

4. **Add caching layer:**
   - In-memory cache for frequently accessed data
   - Cache invalidation strategies

5. **Add transaction support:**
   - Multi-table operations
   - Rollback on error

---

**Created:** 2025-10-23  
**Version:** 1.0.0  
**Author:** ICC (rauschiccsk)  
**Project:** nex-genesis-server

🎯 **NEX Genesis Repositories - Complete Documentation** ✨