# 🗄️ NEX GENESIS DATABASE ACCESS PATTERN

**Dokument:** Architektúra prístupu k databázovým tabuľkám v NEX Genesis  
**Vytvorené:** 2025-10-21  
**Účel:** Referenčná príručka pre prácu s Pervasive SQL tabuľkami  
**Projekt:** nex-genesis-server

---

## 📋 OBSAH

1. [Prehľad Architektúry](#prehľad-architektúry)
2. [Vrstvy Prístupu](#vrstvy-prístupu)
3. [Príklad: BARCODE Tabuľka](#príklad-barcode-tabuľka)
4. [Auto-generované Wrappery (b*.pas)](#auto-generované-wrappery-bpas)
5. [Business Logic Handlers (h*.pas)](#business-logic-handlers-hpas)
6. [Design Patterns](#design-patterns)
7. [Best Practices](#best-practices)
8. [Použitie v NEX-Genesis-Server](#použitie-v-nex-genesis-server)

---

## 🏗️ PREHĽAD ARCHITEKTÚRY

NEX Genesis používa **5-vrstvovú architektúru** pre prístup k Pervasive SQL databáze.

### Prečo táto architektúra?

✅ **Type Safety** - Kompilátor odchytí preklepy  
✅ **Code Generation** - Automatická regenerácia pri zmene schémy  
✅ **Business Logic Preservation** - Custom kód prežije regeneráciu  
✅ **Separation of Concerns** - Data access vs. Business logic  
✅ **Index Management** - Automatické prepínanie indexov  
✅ **Maintainability** - Konzistentný pattern pre všetky tabuľky

---

## 📊 VRSTVY PRÍSTUPU

```
┌─────────────────────────────────────────────────────┐
│ LAYER 1: Fyzická databáza                          │
│ BARCODE.BTR (Pervasive SQL súbor)                  │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ LAYER 2: Definičný súbor (Metadata)                │
│ BARCODE.bdf                                         │
│ - Field definitions (názov, typ, veľkosť)          │
│ - Index definitions (GsCode, BarCode, composite)    │
│ - Constraints (duplicates, modifications)           │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ LAYER 3: Low-level database engine                 │
│ NexBtrTable.pas (TNexBtrTable)                      │
│ - Priamy prístup k Pervasive SQL                    │
│ - FieldByName() access                              │
│ - Index switching                                   │
│ - CRUD operations                                   │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ LAYER 4: AUTO-GENERATED WRAPPER                    │
│ bBARCODE.pas (TBarcodeBtr)                          │
│ - Type-safe properties                              │
│ - Index constants                                   │
│ - Locate/Nearest methods                            │
│ - CRUD wrappers                                     │
│ ⚠️ REGENERUJE SA pri zmene .bdf!                    │
└──────────────────┬──────────────────────────────────┘
                   │
┌──────────────────▼──────────────────────────────────┐
│ LAYER 5: BUSINESS LOGIC HANDLER                    │
│ hBARCODE.pas (TBarcodeHnd)                          │
│ - Custom business methods                           │
│ - Validácie                                         │
│ - Complex operations                                │
│ ✅ NEREGENERUJE SA - ručne udržiavaný!              │
└─────────────────────────────────────────────────────┘
```

---

## 📝 PRÍKLAD: BARCODE TABUĽKA

### Layer 1: Fyzická tabuľka
```
Súbor: BARCODE.BTR
Umiestnenie: <NEX_PATH>\Data\
Formát: Pervasive SQL (.BTR)
```

### Layer 2: Definičný súbor (.bdf)
```delphi
BARCODE.BTR cPrealloc+cFree10   ;Druhotné identifikačné kódy

// Field definitions
GsCode     longint      ;Tovarové číslo (PLU)
BarCode    Str15        ;Druhotný identifikačný kód
ModUser    Str8         ;Užívateľ
ModDate    DateType     ;Dátum úpravy
ModTime    TimeType     ;Čas úpravy

// Index 1: GsCode (pre vyhľadávanie podľa produktu)
IND GsCode=GsCode
GLB cModif+cDuplic      ;Povoliť duplicity
SEG

// Index 2: BarCode (pre vyhľadávanie podľa čiarového kódu)
IND BarCode=BarCode
GLB cModif+cDuplic      ;Povoliť duplicity
SEG

// Index 3: GsBc (composite - pre unique constraint)
IND GsCode,BarCode=GsBc
GLB cModif              ;Bez duplicít
SEG
```

**Dôležité:**
- `GsCode` = Interné číslo tovaru (Primary key v produktovej tabuľke)
- `BarCode` = Čiarový kód (EAN, Code128, QR, atď.)
- Jeden produkt môže mať viacero čiarových kódov
- Composite index `GsBc` zabezpečuje, že jeden barcode nemôže byť priradený viac krát k tomu istému produktu

---

## 🤖 AUTO-GENEROVANÉ WRAPPERY (b*.pas)

### Účel
- Poskytujú **type-safe prístup** k databázovým poliam
- **Automaticky sa regenerujú** pri zmene .bdf súboru
- **Nesmú obsahovať** business logiku (tá je v h*.pas)

### Štruktúra bBARCODE.pas

#### 1. Index Constants
```pascal
const
  ixGsCode = 'GsCode';    // Index podľa tovarového čísla
  ixBarCode = 'BarCode';  // Index podľa čiarového kódu
  ixGsBc = 'GsBc';        // Composite index
```

#### 2. Class Definition
```pascal
type
  TBarcodeBtr = class (TComponent)
  private
    oBtrTable: TNexBtrTable;  // Low-level database access
    
    // Field accessors (getters/setters)
    function  ReadGsCode:longint;
    procedure WriteGsCode(pValue:longint);
    function  ReadBarCode:Str15;
    procedure WriteBarCode(pValue:Str15);
    // ... ostatné polia
    
  public
    constructor Create; overload;
    constructor Create(pPath:ShortString); overload;
    destructor  Destroy; override;
    
    // Locate methods (exact match)
    function LocateGsCode(pGsCode:longint):boolean;
    function LocateBarCode(pBarCode:Str15):boolean;
    function LocateGsBc(pGsCode:longint; pBarCode:Str15):boolean;
    
    // Nearest methods (range search)
    function NearestGsCode(pGsCode:longint):boolean;
    function NearestBarCode(pBarCode:Str15):boolean;
    function NearestGsBc(pGsCode:longint; pBarCode:Str15):boolean;
    
    // CRUD operations
    procedure Insert;
    procedure Edit;
    procedure Post; virtual;
    procedure Delete;
    
    // Navigation
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    function  Eof: boolean;
    
  published
    // Type-safe properties
    property GsCode:longint read ReadGsCode write WriteGsCode;
    property BarCode:Str15 read ReadBarCode write WriteBarCode;
    property ModUser:Str8 read ReadModUser write WriteModUser;
    property ModDate:TDatetime read ReadModDate write WriteModDate;
    property ModTime:TDatetime read ReadModTime write WriteModTime;
  end;
```

#### 3. Property Implementation (Príklad)
```pascal
// Getter
function TBarcodeBtr.ReadGsCode:longint;
begin
  Result := oBtrTable.FieldByName('GsCode').AsInteger;
end;

// Setter
procedure TBarcodeBtr.WriteGsCode(pValue:longint);
begin
  oBtrTable.FieldByName('GsCode').AsInteger := pValue;
end;
```

**Výhoda:**
```pascal
// ❌ BEZ WRAPPERU (error-prone)
oBtrTable.FieldByName('GsCod').AsInteger := 123;  // Preklep = runtime error!

// ✅ S WRAPPEROM (type-safe)
BarcodeTable.GsCode := 123;  // Preklep = compile-time error!
```

#### 4. Locate Implementation
```pascal
function TBarcodeBtr.LocateGsCode(pGsCode:longint):boolean;
begin
  SetIndex(ixGsCode);                    // Prepni na správny index
  Result := oBtrTable.FindKey([pGsCode]); // Nájdi záznam
end;
```

**Automatické prepínanie indexov:**
- `LocateGsCode()` → automaticky prepne na `ixGsCode`
- `LocateBarCode()` → automaticky prepne na `ixBarCode`
- Developer nemusí riešiť index management

---

## 🎯 BUSINESS LOGIC HANDLERS (h*.pas)

### Účel
- Obsahujú **custom business logic** špecifickú pre danú tabuľku
- **Neregenerujú sa** - sú ručne udržiavané
- **Dedia** všetku funkcionalitu z b*.pas
- **Prežijú** regeneráciu b*.pas súborov

### Štruktúra hBARCODE.pas

```pascal
unit hBARCODE;

interface

uses
  IcTypes, NexPath, NexGlob, 
  bBARCODE,  // ← Dedí z generovaného wrapperu
  Forms, Windows, Messages, SysUtils, Variants, Classes, Graphics, 
  Controls, Dialogs;

type
  TBarcodeHnd = class(TBarcodeBtr)  // ← Dedí z TBarcodeBtr
  private
    // Private helper methods
  public
    // Custom business methods
    procedure Del(pGsCode:longint);
  published
  end;

implementation

procedure TBarcodeHnd.Del(pGsCode:longint);
begin
  // Vymaže VŠETKY čiarové kódy pre daný produkt
  While LocateGsCode(pGsCode) do Delete;
end;

end.
```

### Del() Method - Detail Analysis

#### Čo robí:
Vymaže **všetky** čiarové kódy priradené k danému produktu.

#### Prečo While a nie If:
Jeden produkt môže mať viacero čiarových kódov:
- EAN-13: `8594000123456`
- Code128: `PROD-12345`
- QR Code: `https://shop.com/prod/12345`
- Vlastný kód: `CUSTOM-001`

#### Krok-za-krokom exekúcia:

**Pred volaním Del(12345):**
```
BARCODE tabuľka:
┌────────┬───────────────┬─────────┐
│ GsCode │ BarCode       │ ModUser │
├────────┼───────────────┼─────────┤
│ 12345  │ 8594000123456 │ admin   │ ← Prvý záznam
│ 12345  │ PROD-12345    │ admin   │ ← Druhý záznam
│ 12345  │ CUSTOM-001    │ admin   │ ← Tretí záznam
│ 67890  │ 8594000654321 │ user1   │
└────────┴───────────────┴─────────┘
```

**Iterácia 1:**
```pascal
LocateGsCode(12345)  → Nájde prvý záznam, Result = True
Delete()             → Vymaže "8594000123456"
```

**Iterácia 2:**
```pascal
LocateGsCode(12345)  → Nájde druhý záznam, Result = True
Delete()             → Vymaže "PROD-12345"
```

**Iterácia 3:**
```pascal
LocateGsCode(12345)  → Nájde tretí záznam, Result = True
Delete()             → Vymaže "CUSTOM-001"
```

**Iterácia 4:**
```pascal
LocateGsCode(12345)  → Nenájde žiadny záznam, Result = False
While loop sa ukončí
```

**Po Del(12345):**
```
BARCODE tabuľka:
┌────────┬───────────────┬─────────┐
│ GsCode │ BarCode       │ ModUser │
├────────┼───────────────┼─────────┤
│ 67890  │ 8594000654321 │ user1   │ ← Zostal len tento
└────────┴───────────────┴─────────┘
```

### Ďalšie príklady custom metód (typicky v h*.pas):

```pascal
// Validácia pred uložením
procedure TBarcodeHnd.Post; override;
begin
  if Trim(BarCode) = '' then
    raise Exception.Create('Čiarový kód nemôže byť prázdny!');
    
  if Length(BarCode) < 8 then
    raise Exception.Create('Čiarový kód musí mať aspoň 8 znakov!');
    
  ModUser := gCurrentUser;  // Automaticky nastav užívateľa
  ModDate := Now;
  ModTime := Now;
  
  inherited Post;  // Zavolaj parent Post()
end;

// Kontrola duplicity
function TBarcodeHnd.IsDuplicate(pBarCode:Str15):boolean;
begin
  Result := LocateBarCode(pBarCode);
end;

// Získaj všetky barcodes pre produkt
function TBarcodeHnd.GetBarcodesForProduct(pGsCode:longint): TStringList;
begin
  Result := TStringList.Create;
  if LocateGsCode(pGsCode) then
  begin
    repeat
      Result.Add(BarCode);
    until not (LocateGsCode(pGsCode) and (GsCode = pGsCode));
  end;
end;
```

---

## 🎨 DESIGN PATTERNS

### 1. Wrapper Pattern
```
Complex API (TNexBtrTable + Pervasive SQL)
    ↓ wrapped by
Simple API (TBarcodeBtr)
```

### 2. Template Method Pattern
```pascal
// bBARCODE.pas (template)
procedure Post; virtual;  // ← Môže byť override

// hBARCODE.pas (concrete)
procedure TBarcodeHnd.Post; override;
begin
  // Custom validácia
  inherited Post;  // Zavolá parent
end;
```

### 3. Facade Pattern
```
TNexBtrTable (low-level, komplexný)
    ↓ simplified by
TBarcodeBtr (high-level, jednoduchý)
```

### 4. Repository Pattern
```pascal
TBarcodeHnd = Repository pre BARCODE tabuľku

Methods:
- Del(GsCode) = DeleteAllByGsCode()
- IsDuplicate() = ExistsByBarCode()
- GetBarcodesForProduct() = FindAllByGsCode()
```

---

## ✅ BEST PRACTICES

### 1. Vždy používaj Wrapper Properties

```pascal
// ❌ ZLE - priamy prístup
Table.oBtrTable.FieldByName('GsCode').AsInteger := 123;

// ✅ SPRÁVNE - cez property
Table.GsCode := 123;
```

### 2. Vždy používaj Index Constants

```pascal
// ❌ ZLE - hardcoded string
Table.SetIndex('GsCode');

// ✅ SPRÁVNE - cez konštantu
Table.SetIndex(ixGsCode);
```

### 3. Vždy používaj Locate Methods

```pascal
// ❌ ZLE - full table scan
Table.First;
while not Table.Eof do
begin
  if Table.GsCode = 123 then Break;
  Table.Next;
end;

// ✅ SPRÁVNE - index-based search
if Table.LocateGsCode(123) then
  // Found!
```

### 4. Business Logic VŽDY v h*.pas

```pascal
// ❌ ZLE - business logic v b*.pas
// bBARCODE.pas
procedure TBarcodeBtr.DeleteAllForProduct(pGsCode:longint);
// Táto metóda sa stratí pri regenerácii!

// ✅ SPRÁVNE - business logic v h*.pas
// hBARCODE.pas
procedure TBarcodeHnd.Del(pGsCode:longint);
// Táto metóda prežije regeneráciu!
```

### 5. Vždy Free objects

```pascal
var
  BarcodeHnd: TBarcodeHnd;
begin
  BarcodeHnd := TBarcodeHnd.Create;
  try
    // Práca s tabuľkou
    BarcodeHnd.LocateGsCode(123);
  finally
    BarcodeHnd.Free;  // ← Dôležité!
  end;
end;
```

### 6. Update ModUser, ModDate, ModTime

```pascal
BarcodeHnd.Insert;
BarcodeHnd.GsCode := 123;
BarcodeHnd.BarCode := '8594000123456';
BarcodeHnd.ModUser := gCurrentUser;  // ← Vždy!
BarcodeHnd.ModDate := Now;           // ← Vždy!
BarcodeHnd.ModTime := Now;           // ← Vždy!
BarcodeHnd.Post;
```

---

## 🚀 POUŽITIE V NEX-GENESIS-SERVER

### Príklad 1: Check or Create Barcode

```pascal
function CheckOrCreateBarcode(pGsCode:longint; pBarCode:string):boolean;
var
  BarcodeHnd: TBarcodeHnd;
begin
  Result := False;
  BarcodeHnd := TBarcodeHnd.Create;
  try
    // Skontroluj duplicitu (composite index)
    if BarcodeHnd.LocateGsBc(pGsCode, pBarCode) then
    begin
      Result := True;  // Už existuje
      Exit;
    end;
    
    // Pridaj nový barcode
    BarcodeHnd.Insert;
    BarcodeHnd.GsCode := pGsCode;
    BarcodeHnd.BarCode := pBarCode;
    BarcodeHnd.ModUser := 'API';
    BarcodeHnd.ModDate := Now;
    BarcodeHnd.ModTime := Now;
    BarcodeHnd.Post;
    
    Result := True;
  finally
    BarcodeHnd.Free;
  end;
end;
```

### Príklad 2: Get Product by Barcode

```pascal
function GetProductByBarcode(pBarCode:string):longint;
var
  BarcodeHnd: TBarcodeHnd;
begin
  Result := 0;
  BarcodeHnd := TBarcodeHnd.Create;
  try
    if BarcodeHnd.LocateBarCode(pBarCode) then
      Result := BarcodeHnd.GsCode;
  finally
    BarcodeHnd.Free;
  end;
end;
```

### Príklad 3: Delete Product with All Barcodes

```pascal
procedure DeleteProductCompletely(pGsCode:longint);
var
  BarcodeHnd: TBarcodeHnd;
  ProductHnd: TProductHnd;
begin
  // 1. Vymaž všetky barcodes
  BarcodeHnd := TBarcodeHnd.Create;
  try
    BarcodeHnd.Del(pGsCode);  // Custom method z hBARCODE.pas
  finally
    BarcodeHnd.Free;
  end;
  
  // 2. Vymaž produkt
  ProductHnd := TProductHnd.Create;
  try
    if ProductHnd.LocateGsCode(pGsCode) then
      ProductHnd.Delete;
  finally
    ProductHnd.Free;
  end;
end;
```

### Príklad 4: Import from ISDOC XML

```pascal
procedure ImportBarcodeFromISDOC(pXMLNode: IXMLNode; pGsCode:longint);
var
  BarcodeHnd: TBarcodeHnd;
  sBarcode: string;
begin
  sBarcode := pXMLNode.ChildValues['SellersItemIdentification.ID'];
  
  if Trim(sBarcode) = '' then Exit;
  
  BarcodeHnd := TBarcodeHnd.Create;
  try
    // Skip ak už existuje
    if BarcodeHnd.LocateGsBc(pGsCode, sBarcode) then
      Exit;
      
    // Pridaj nový
    BarcodeHnd.Insert;
    BarcodeHnd.GsCode := pGsCode;
    BarcodeHnd.BarCode := sBarcode;
    BarcodeHnd.ModUser := 'ISDOC_IMPORT';
    BarcodeHnd.ModDate := Now;
    BarcodeHnd.ModTime := Now;
    BarcodeHnd.Post;
    
    LogInfo('Barcode added: ' + sBarcode + ' for GsCode: ' + IntToStr(pGsCode));
  finally
    BarcodeHnd.Free;
  end;
end;
```

---

## 📚 SUMMARY

### Kľúčové Poznatky:

1. **Päť vrstiev prístupu:**
   - Fyzická databáza (.BTR)
   - Definičný súbor (.bdf)
   - Low-level engine (NexBtrTable.pas)
   - Auto-generovaný wrapper (b*.pas)
   - Business logic handler (h*.pas)

2. **Type Safety:**
   - Properties namiesto FieldByName()
   - Compile-time error checking
   - IntelliSense support

3. **Code Generation:**
   - b*.pas sa regeneruje automaticky
   - h*.pas zostáva nedotknutý
   - Business logic prežije zmeny schémy

4. **Index Management:**
   - Locate methods automaticky prepínajú indexy
   - Index constants pre type-safety
   - Nearest methods pre range queries

5. **Best Practices:**
   - Vždy používaj wrapper properties
   - Business logic len v h*.pas
   - Vždy update ModUser, ModDate, ModTime
   - Vždy Free objects v finally bloku

### Pre NEX-Genesis-Server:

- ✅ Používaj TBarcodeHnd namiesto priameho SQL
- ✅ Využívaj Locate methods pre vyhľadávanie
- ✅ Wrap do try..finally blokov
- ✅ Log všetky operácie
- ✅ Validuj vstupné dáta pred Insert/Post

---

**Verzia:** 1.0  
**Vytvorené:** 2025-10-21  
**Autor:** ICC (rauschiccsk)  
**Projekt:** nex-genesis-server

🏭 **NEX Genesis Database Access Pattern - Kompletná Referencia** ✨