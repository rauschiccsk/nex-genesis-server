# SYSTEM PROMPT - NEX Genesis Database Access

**Pre Claude pri generovaní Delphi 6 kódu pre NEX Genesis Server**

---

## 🗄️ DATABASE ACCESS PATTERN

Keď generuješ kód pre prístup k Pervasive SQL databáze v NEX Genesis:

### 1. VŽDY používaj h*.pas handlers

```pascal
// ✅ SPRÁVNE
var
  BarcodeHnd: TBarcodeHnd;
begin
  BarcodeHnd := TBarcodeHnd.Create;
  try
    if BarcodeHnd.LocateGsCode(pGsCode) then
      Result := BarcodeHnd.BarCode;
  finally
    BarcodeHnd.Free;
  end;
end;

// ❌ ZLE - NIE SQL queries
Query.SQL.Text := 'SELECT BarCode FROM BARCODE WHERE GsCode = :GsCode';
```

### 2. VŽDY používaj type-safe properties

```pascal
// ✅ SPRÁVNE
BarcodeHnd.GsCode := 12345;
BarcodeHnd.BarCode := '8594000123456';

// ❌ ZLE
BarcodeHnd.oBtrTable.FieldByName('GsCode').AsInteger := 12345;
```

### 3. VŽDY používaj Locate methods

```pascal
// ✅ SPRÁVNE - index-based search
if BarcodeHnd.LocateGsCode(pGsCode) then
  // Found

// ❌ ZLE - full table scan
BarcodeHnd.First;
while not BarcodeHnd.Eof do
begin
  if BarcodeHnd.GsCode = pGsCode then Break;
  BarcodeHnd.Next;
end;
```

### 4. VŽDY update audit fields

```pascal
BarcodeHnd.Insert;
BarcodeHnd.GsCode := pGsCode;
BarcodeHnd.BarCode := pBarCode;
BarcodeHnd.ModUser := 'API';      // ← VŽDY!
BarcodeHnd.ModDate := Now;        // ← VŽDY!
BarcodeHnd.ModTime := Now;        // ← VŽDY!
BarcodeHnd.Post;
```

### 5. VŽDY wrap do try..finally

```pascal
// ✅ SPRÁVNE
TableHnd := TTableHnd.Create;
try
  // Práca s tabuľkou
finally
  TableHnd.Free;  // ← Memory leak prevention!
end;

// ❌ ZLE
TableHnd := TTableHnd.Create;
// Práca s tabuľkou
TableHnd.Free;  // Môže byť preskočený pri exception!
```

### 6. Custom business logic LEN v h*.pas

```pascal
// ✅ SPRÁVNE - v hBARCODE.pas
procedure TBarcodeHnd.Del(pGsCode:longint);
begin
  While LocateGsCode(pGsCode) do Delete;
end;

// ❌ ZLE - NIE v bBARCODE.pas (regeneruje sa!)
```

---

## 📋 CODE GENERATION CHECKLIST

Keď generuješ kód pre databázové operácie:

- [ ] Používam h*.pas handler class?
- [ ] Používam type-safe properties?
- [ ] Používam Locate methods namiesto loops?
- [ ] Updatujem ModUser, ModDate, ModTime?
- [ ] Wrapujem do try..finally?
- [ ] Logujem databázové operácie?
- [ ] Validujem vstupné dáta?
- [ ] Handlujem errors správne?

---

## 🎯 PATTERN EXAMPLES

### Example 1: Check or Create Record

```pascal
function CheckOrCreateBarcode(pGsCode:longint; pBarCode:string):boolean;
var
  BarcodeHnd: TBarcodeHnd;
begin
  Result := False;
  BarcodeHnd := TBarcodeHnd.Create;
  try
    // Check duplicita (composite index)
    if BarcodeHnd.LocateGsBc(pGsCode, pBarCode) then
    begin
      Result := True;  // Už existuje
      Exit;
    end;
    
    // Vytvor nový
    BarcodeHnd.Insert;
    BarcodeHnd.GsCode := pGsCode;
    BarcodeHnd.BarCode := pBarCode;
    BarcodeHnd.ModUser := 'API';
    BarcodeHnd.ModDate := Now;
    BarcodeHnd.ModTime := Now;
    BarcodeHnd.Post;
    
    LogInfo('Barcode created: ' + pBarCode);
    Result := True;
  except
    on E: Exception do
    begin
      LogError('Barcode creation failed: ' + E.Message);
      raise;
    end;
  end;
  finally
    BarcodeHnd.Free;
  end;
end;
```

### Example 2: Find by Key

```pascal
function GetProductByBarcode(pBarCode:string):longint;
var
  BarcodeHnd: TBarcodeHnd;
begin
  Result := 0;
  BarcodeHnd := TBarcodeHnd.Create;
  try
    if BarcodeHnd.LocateBarCode(pBarCode) then
      Result := BarcodeHnd.GsCode
    else
      LogWarning('Barcode not found: ' + pBarCode);
  finally
    BarcodeHnd.Free;
  end;
end;
```

### Example 3: Update Record

```pascal
procedure UpdateBarcode(pGsCode:longint; pOldBarcode, pNewBarcode:string);
var
  BarcodeHnd: TBarcodeHnd;
begin
  BarcodeHnd := TBarcodeHnd.Create;
  try
    if BarcodeHnd.LocateGsBc(pGsCode, pOldBarcode) then
    begin
      BarcodeHnd.Edit;
      BarcodeHnd.BarCode := pNewBarcode;
      BarcodeHnd.ModUser := 'API';
      BarcodeHnd.ModDate := Now;
      BarcodeHnd.ModTime := Now;
      BarcodeHnd.Post;
      
      LogInfo(Format('Barcode updated: %s → %s', [pOldBarcode, pNewBarcode]));
    end
    else
      raise Exception.Create('Barcode not found');
  finally
    BarcodeHnd.Free;
  end;
end;
```

### Example 4: Delete with Validation

```pascal
procedure DeleteBarcodeWithValidation(pGsCode:longint);
var
  BarcodeHnd: TBarcodeHnd;
  nCount: integer;
begin
  BarcodeHnd := TBarcodeHnd.Create;
  try
    // Počítaj koľko barcodes má produkt
    nCount := 0;
    if BarcodeHnd.LocateGsCode(pGsCode) then
    begin
      repeat
        Inc(nCount);
      until not (BarcodeHnd.LocateGsCode(pGsCode) and (BarcodeHnd.GsCode = pGsCode));
    end;
    
    // Validácia - produkt musí mať aspoň jeden barcode
    if nCount <= 1 then
      raise Exception.Create('Cannot delete last barcode for product');
    
    // Vymaž všetky barcodes
    BarcodeHnd.Del(pGsCode);  // Custom method z hBARCODE.pas
    
    LogInfo(Format('Deleted %d barcodes for GsCode: %d', [nCount, pGsCode]));
  finally
    BarcodeHnd.Free;
  end;
end;
```

---

## 🚨 COMMON MISTAKES TO AVOID

### ❌ Mistake 1: Using FieldByName()
```pascal
// ZLE
Table.oBtrTable.FieldByName('GsCode').AsInteger := 123;

// SPRÁVNE
Table.GsCode := 123;
```

### ❌ Mistake 2: Full Table Scan
```pascal
// ZLE
Table.First;
while not Table.Eof do
begin
  if Table.GsCode = 123 then Break;
  Table.Next;
end;

// SPRÁVNE
if Table.LocateGsCode(123) then
  // Found
```

### ❌ Mistake 3: Forgetting Audit Fields
```pascal
// ZLE
Table.Insert;
Table.GsCode := 123;
Table.Post;  // ModUser, ModDate, ModTime sú NULL!

// SPRÁVNE
Table.Insert;
Table.GsCode := 123;
Table.ModUser := 'API';
Table.ModDate := Now;
Table.ModTime := Now;
Table.Post;
```

### ❌ Mistake 4: No Error Handling
```pascal
// ZLE
Table := TTableHnd.Create;
Table.LocateGsCode(123);
Table.Free;

// SPRÁVNE
Table := TTableHnd.Create;
try
  if Table.LocateGsCode(123) then
    // Process
  else
    LogWarning('Record not found');
except
  on E: Exception do
  begin
    LogError('Error: ' + E.Message);
    raise;
  end;
end;
finally
  Table.Free;
end;
```

---

## 📚 QUICK REFERENCE

### Available Handler Classes:
- `TBarcodeHnd` - BARCODE tabuľka (čiarové kódy)
- `TProductHnd` - PRODUCT tabuľka (produkty) [TBD]
- `TStockHnd` - STOCK tabuľka (skladové zásoby) [TBD]
- `TReceiptHnd` - RECEIPT tabuľka (príjemky) [TBD]

### Common Locate Methods:
```pascal
LocateGsCode(pGsCode: longint): boolean;
LocateBarCode(pBarCode: Str15): boolean;
LocateGsBc(pGsCode: longint; pBarCode: Str15): boolean;
NearestGsCode(pGsCode: longint): boolean;  // Range search
```

### Common Properties:
```pascal
property GsCode: longint;
property BarCode: Str15;
property ModUser: Str8;
property ModDate: TDatetime;
property ModTime: TDatetime;
```

---

**Dokumentácia:** `docs/architecture/database-access-pattern.md`  
**Template:** `templates/h_table_handler_template.pas`

✨ **Vždy generuj kód podľa tohto patternu!** ✨
✨ **Vždy generuj kód podľa tohto patternu!** ✨