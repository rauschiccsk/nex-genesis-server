# Pervasive PSQL DLL Information

## 🔧 NEX Genesis Btrieve DLLs

NEX Genesis používa **Pervasive PSQL v11** pre databázový prístup.

---

## 📦 DLL súbory v external-dlls/

### wxqlcall.dll ⭐ PRIMARY
- **Názov:** wxqlcall.dll
- **Účel:** Pervasive PSQL v11 Btrieve API
- **Verzia:** 11.x (32-bit)
- **Použitie:** Hlavný Btrieve interface pre NEX Genesis
- **Status:** ✅ Toto je správny DLL pre NEX Genesis!

### wdbnames.dll
- **Názov:** wdbnames.dll
- **Účel:** Database naming services
- **Použitie:** Pomocný súbor pre Pervasive PSQL

### wdbnm32.dll
- **Názov:** wdbnm32.dll
- **Účel:** 32-bit database naming
- **Použitie:** Pomocný súbor pre Pervasive PSQL

### wssql32.dll
- **Názov:** wssql32.dll
- **Účel:** SQL interface
- **Použitie:** SQL queries (nepoužívame, len Btrieve)

---

## 🎯 Ktorý DLL použiť?

### Pre NEX Genesis Server (Python):
```
Primary:   wxqlcall.dll  ✅ Použiť tento!
Fallback:  wbtrv32.dll   (ak wxqlcall nefunguje)
Fallback:  w3btrv7.dll   (starší Btrieve)
```

### Priorita načítania v kóde:
```python
dll_names = [
    "wxqlcall.dll",   # 1. Pervasive PSQL v11 (primary)
    "wbtrv32.dll",    # 2. Btrieve 32-bit
    "w3btrv7.dll",    # 3. Btrieve alternative
    "btrieve.dll"     # 4. Generic Btrieve
]
```

---

## 🔍 Btrieve API funkcie

### wxqlcall.dll exportuje:
```
BTRV()      - Hlavná Btrieve funkcia
BTRVID()    - Btrieve s client ID
BTRCALL()   - Alternatívny názov
```

### Signatúra BTRV funkcie:
```c
int BTRV(
    unsigned short *operation,    // Operation code (0-36)
    char *posBlock,                // Position block (128 bytes)
    char *dataBuffer,              // Data buffer
    unsigned short *dataLength,    // Data length
    char *keyBuffer,               // Key buffer
    unsigned char keyLength,       // Key length
    char keyNumber                 // Key number (index)
);
```

### Python ctypes mapping:
```python
self.btrv_func.argtypes = [
    POINTER(c_ushort),  # operation
    POINTER(c_char),    # posBlock (128 bytes)
    POINTER(c_char),    # dataBuffer
    POINTER(c_ushort),  # dataLength
    POINTER(c_char),    # keyBuffer
    c_ubyte,            # keyLength
    c_byte              # keyNumber
]
self.btrv_func.restype = c_int
```

---

## ⚠️ Dôležité poznámky

### 32-bit vs 64-bit
```
NEX Genesis je 32-bit aplikácia
→ wxqlcall.dll je 32-bit
→ Python musí byť 32-bit!

Overenie Python verzie:
>>> import platform
>>> platform.architecture()
('32bit', 'WindowsPE')  # ✅ OK
('64bit', 'WindowsPE')  # ❌ Nebude fungovať!
```

### Pervasive PSQL verzie
```
NEX Genesis používa: v11.x
wxqlcall.dll verzia:  11.x (32-bit)

Kompatibilita:
- v11.x ✅ (používané)
- v12.x ✅ (pravdepodobne OK)
- v13.x ⚠️  (netestované)
```

### Funkcia naming
```
wxqlcall.dll používa:
- BTRV      ✅ Štandardný názov
- BTRVID    ✅ S client ID
- BTRCALL   ✅ Alternatívny názov

Kód kontroluje všetky tri názvy.
```

---

## 🧪 Testovanie DLL

### Test 1: Kontrola DLL existencie
```python
import os
dll_path = "external-dlls/wxqlcall.dll"
if os.path.exists(dll_path):
    print("✅ DLL found")
else:
    print("❌ DLL not found")
```

### Test 2: Načítanie DLL
```python
import ctypes
dll = ctypes.windll.LoadLibrary("external-dlls/wxqlcall.dll")
print(f"✅ DLL loaded: {dll}")
```

### Test 3: Kontrola funkcie
```python
if hasattr(dll, "BTRV"):
    print("✅ BTRV function found")
else:
    print("❌ BTRV function not found")
```

### Test 4: Kompletný test
```powershell
python tests/test_btrieve_basic.py
```

---

## 🔧 Troubleshooting

### Error: "Could not load DLL"
```
Možné príčiny:
1. DLL neexistuje v external-dlls/
2. Python je 64-bit (potrebný 32-bit)
3. Chýbajú dependencies (iné Pervasive DLL)
4. DLL je poškodený

Riešenie:
1. Skontroluj že wxqlcall.dll existuje
2. Overenie: python --version (musí byť 32-bit)
3. Skopíruj všetky 4 DLL z Pervasive PSQL
4. Reinstaluj Pervasive PSQL v11
```

### Error: "Function not found"
```
Možné príčiny:
1. DLL neobsahuje BTRV funkciu
2. Zlý DLL (nie Btrieve)
3. Incompatible verzia

Riešenie:
1. Použiť správny wxqlcall.dll
2. Kontrola: dumpbin /exports wxqlcall.dll
3. Skúsiť alternatívny DLL (wbtrv32.dll)
```

### Error: "Access violation"
```
Možné príčiny:
1. Zlá signatúra ctypes
2. Buffer overflow
3. Invalid pointer

Riešenie:
1. Skontroluj argtypes definíciu
2. Skontroluj veľkosť bufferov
3. Inicializuj posBlock správne (128 bytes)
```

---

## 📚 Zdroje

### Pervasive PSQL Dokumentácia
- Btrieve 2 API Guide
- Pervasive PSQL v11 Developer Guide
- Database Management Guide

### NEX Genesis
- Delphi sources: `delphi-sources/Common/BtrApi32.pas`
- Database definitions: `database-schema/*.bdf`

---

**Vytvorené:** 2025-10-22  
**Verzia:** 1.0  
**Autor:** ICC (rausch@icc.sk)  
**Účel:** Dokumentácia Pervasive PSQL DLL pre Python Btrieve client