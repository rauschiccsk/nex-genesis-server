# NEX Genesis Server - Testing Guide

## 🧪 Testovacia stratégia

Máme **3 úrovne testovania** pre Btrieve klient:

### Level 1: Basic Tests ⚡
**Súbor:** `tests/test_btrieve_basic.py`  
**Účel:** Základné testy - DLL loading, konfigurácia  
**Potrebné:** Žiadny prístup k databáze  

**Testy:**
1. Config loading - načítanie YAML konfigurácie
2. DLL loading - načítanie Btrieve DLL
3. Path validation - kontrola databázových ciest

### Level 2: File Opening Tests 📂
**Súbor:** `tests/test_btrieve_file.py`  
**Účel:** Testovanie otvorenia Btrieve súborov  
**Potrebné:** Prístup k NEX databáze  

**Testy:**
1. GSCAT open - produktový katalóg
2. BARCODE open - čiarové kódy
3. PAB open - obchodní partneri (DIALS)
4. TSH open - dodacie listy header
5. TSI open - dodacie listy items

### Level 3: Data Reading Tests 📊
**Súbor:** `tests/test_btrieve_read.py`  
**Účel:** Testovanie čítania dát z tabuliek  
**Potrebné:** Prístup k databáze s dátami  

**Testy:**
1. GSCAT read first - prvý záznam
2. GSCAT read multiple - viacero záznamov
3. BARCODE read - čiarové kódy
4. PAB read - partneri

---

## 🚀 Spustenie testov

### Príprava

1. **Nainštaluj dependencies:**
```powershell
cd c:\Development\nex-genesis-server
pip install -r requirements.txt
```

2. **Overiť konfiguráciu:**
```powershell
# Skontroluj config/database.yaml
# Uprav cesty ak je potrebné
```

3. **Overiť DLL súbory:**
```powershell
# Skontroluj external-dlls/
# Musia tam byť w3btrv7.dll alebo podobné
dir external-dlls
```

---

### Test 1: Basic Tests (VŽDY ZAČNI TÝMTO)

**V PyCharm:**
```
1. Otvor tests/test_btrieve_basic.py
2. Right-click → Run 'test_btrieve_basic'
```

**V PowerShell:**
```powershell
python tests/test_btrieve_basic.py
```

**Očakávaný výstup:**
```
🧪 TEST 1.1: Configuration Loading
=============================================================
✅ Config loaded successfully!

📊 Configuration:
  Root path: C:\NEX
  STORES path: C:\NEX\YEARACT\STORES
  ...

🧪 TEST 1.2: Btrieve DLL Loading
=============================================================
✅ DLL directory found: external-dlls
...
✅ Btrieve client loaded successfully!

🧪 TEST 1.3: Path Validation
=============================================================
✅ Root path: C:\NEX
...

📊 TEST SUMMARY
=============================================================
Config Loading: ✅ PASSED
DLL Loading: ✅ PASSED
Path Validation: ✅ PASSED

Total: 3/3 tests passed
🎉 All basic tests passed!
```

**Ak test 1 ZLYHAL:**
- ❌ Config loading failed → Skontroluj `config/database.yaml`
- ❌ DLL loading failed → Skontroluj `external-dlls/` directory
- ⚠️ Path validation warnings → Databáza nemusí existovať (OK pre test 1)

---

### Test 2: File Opening

**SPUSTI LEN ak Test 1 prešiel!**

**V PyCharm:**
```
1. Otvor tests/test_btrieve_file.py
2. Right-click → Run 'test_btrieve_file'
```

**V PowerShell:**
```powershell
python tests/test_btrieve_file.py
```

**Očakávaný výstup:**
```
🧪 TEST 2.1: Open GSCAT Table
=============================================================
📁 GSCAT path: C:\NEX\YEARACT\STORES\GSCAT.BTR
✅ File exists
✅ Loaded Btrieve DLL: w3btrv7.dll
✅ Found Btrieve function: BTRV
✅ Opened file: C:\NEX\YEARACT\STORES\GSCAT.BTR
✅ GSCAT opened successfully!
...

📊 TEST SUMMARY
=============================================================
GSCAT: ✅ PASSED
BARCODE: ✅ PASSED
PAB: ✅ PASSED
TSH: ✅ PASSED
TSI: ✅ PASSED

Total: 5/5 tests passed
🎉 All file opening tests passed!
```

**Ak test 2 ZLYHAL:**
- ❌ File not found → Skontroluj cesty v `config/database.yaml`
- ❌ Failed to open → Btrieve chyba, pozri status code
- ⚠️ TSH/TSI not found → OK ak ešte neexistujú dodacie listy

---

### Test 3: Data Reading

**SPUSTI LEN ak Test 2 prešiel!**

**V PyCharm:**
```
1. Otvor tests/test_btrieve_read.py
2. Right-click → Run 'test_btrieve_read'
```

**V PowerShell:**
```powershell
python tests/test_btrieve_read.py
```

**Očakávaný výstup:**
```
🧪 TEST 3.1: Read First GSCAT Record
=============================================================
✅ File opened
✅ First record read successfully!
   Record size: 1024 bytes
   First 100 bytes: b'...'
   Hex: 01000000...
   
   Possible GsCode: 1

🧪 TEST 3.2: Read Multiple GSCAT Records
=============================================================
✅ File opened
✅ Record 1: 1024 bytes
✅ Record 2: 1024 bytes
...
📊 Total records read: 5

📊 TEST SUMMARY
=============================================================
GSCAT Read First: ✅ PASSED
GSCAT Read Multiple: ✅ PASSED
BARCODE Read: ✅ PASSED
PAB Read: ✅ PASSED

Total: 4/4 tests passed
🎉 All data reading tests passed!
✅ Btrieve client is working correctly!
```

**Ak test 3 ZLYHAL:**
- ⚠️ Table is empty → OK, len prázdna tabuľka
- ❌ Failed to read → Btrieve chyba, pozri status code
- ❌ Record size 0 → Problém s data bufferom

---

## 🎯 Quick Test - Spusti všetko naraz

```powershell
# Test 1
python tests/test_btrieve_basic.py
# Ak OK, pokračuj

# Test 2
python tests/test_btrieve_file.py
# Ak OK, pokračuj

# Test 3
python tests/test_btrieve_read.py
# Ak OK - HOTOVO! 🎉
```

---

## 🔧 Config Test - Samostatný test konfigurácie

```powershell
python src/utils/config.py
```

**Výstup:**
```
📊 NEX Genesis Configuration
============================================================
Root path: C:\NEX
STORES path: C:\NEX\YEARACT\STORES
DIALS path: C:\NEX\YEARACT\DIALS
DLL path: external-dlls

Book settings:
  Book number: 001
  Book type: A
  TSH filename: TSHA-001.BTR
  TSI filename: TSIA-001.BTR

Table paths:
  GSCAT: C:\NEX\YEARACT\STORES\GSCAT.BTR
  BARCODE: C:\NEX\YEARACT\STORES\BARCODE.BTR
  ...

✅ All paths validated successfully!
```

---

## 🐛 Troubleshooting

### Problém: "Config file not found"
```
Riešenie:
1. Skontroluj že config/database.yaml existuje
2. Spusti zo správneho adresára (c:\Development\nex-genesis-server)
```

### Problém: "DLL loading failed"
```
Riešenie:
1. Skontroluj external-dlls/ directory
2. NEX Genesis používa wxqlcall.dll (Pervasive PSQL v11)
3. Skontroluj že wxqlcall.dll existuje v external-dlls/
4. Alternatívne: w3btrv7.dll, wbtrv32.dll, btrieve.dll
5. Skontroluj že DLL je 32-bit (NEX Genesis je 32-bit)
```

### Problém: "File not found: C:\NEX\..."
```
Riešenie:
1. Uprav cesty v config/database.yaml
2. Skontroluj že NEX Genesis je nainštalovaný na C:\NEX
3. Skontroluj že YEARACT adresár existuje
```

### Problém: "Failed to open: status=12"
```
Status 12 = FILE_NOT_FOUND
Riešenie:
1. Súbor neexistuje
2. Skontroluj cestu v config/database.yaml
3. Skontroluj že súbor má príponu .BTR (nie .DAT)
```

### Problém: "Failed to open: status=14"
```
Status 14 = PERMISSION_ERROR
Riešenie:
1. Súbor je uzamknutý iným procesom
2. Zatvor NEX Genesis aplikáciu
3. Skontroluj Windows file permissions
```

---

## ✅ Kritériá úspechu

**Level 1 OK:**
- ✅ Config sa načíta
- ✅ DLL sa načíta
- ✅ Cesty sú validné (warnings OK)

**Level 2 OK:**
- ✅ GSCAT sa otvorí
- ✅ BARCODE sa otvorí
- ✅ PAB sa otvorí
- ⚠️ TSH/TSI môžu byť missing (OK)

**Level 3 OK:**
- ✅ GSCAT prvý záznam sa prečíta
- ✅ GSCAT viacero záznamov sa prečíta
- ✅ BARCODE/PAB záznamy sa prečítajú
- ⚠️ Prázdne tabuľky sú OK

**🎉 Všetky 3 levely OK = Btrieve client funguje!**

---

## 📊 Ďalšie kroky po úspešných testoch

1. ✅ Task 1.7b COMPLETE - Python Btrieve Setup
2. 📋 Task 1.8 - Databázová schéma dokumentácia
3. 📋 Task 1.9 - Python record layouts (dataclasses)
4. 📋 Task 1.10 - ISDOC XML mapping

---

**Vytvorené:** 2025-10-22  
**Verzia:** 1.0  
**Autor:** ICC (rausch@icc.sk)