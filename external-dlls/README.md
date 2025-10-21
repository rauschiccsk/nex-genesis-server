# 📚 External DLLs - Pervasive/Btrieve

Tento adresár obsahuje **Pervasive Btrieve DLL súbory** potrebné pre prístup k NEX Genesis databáze.

---

## 📋 Súbory v tomto adresári

### wdbnames.dll
**Vendor:** Pervasive Software Inc.  
**Účel:** Database Names Utility

**Funkcia:**
- Správa databázových aliasov
- Mapovanie logických názvov na fyzické cesty
- Konfigurácia databázových spojení

---

### wdbnm32.dll
**Vendor:** Pervasive Software Inc.  
**Účel:** Database Names Utility (32-bit)

**Funkcia:**
- 32-bit verzia wdbnames.dll
- Rovnaká funkcionalita ako wdbnames.dll
- Používa sa v 32-bit aplikáciách

---

### wssql32.dll
**Vendor:** Pervasive Software Inc.  
**Účel:** Pervasive SQL Engine (32-bit)

**Funkcia:**
- SQL query processing
- SQL API interface
- ODBC driver support

**Poznámka:** NEX Genesis používa **file-based Btrieve**, nie SQL engine, takže táto DLL možno nebude potrebná.

---

### wxqlcall.dll
**Vendor:** Pervasive Software Inc.  
**Účel:** XQL Call Interface

**Funkcia:**
- Extended Query Language support
- Query optimization
- Advanced SQL features

---

## 🎯 Použitie v projekte

### Potrebujeme tieto DLLs?

**Pre Python Btrieve prístup potrebujeme:**
- ✅ **wbtrv32.dll** alebo **w64btrv.dll** (hlavný Btrieve engine)
  - **Poznámka:** Tieto nie sú v tomto adresári!
  - Musia byť nainštalované s Pervasive/Actian Zen

**Tieto DLLs (wdbnames, wssql32, wxqlcall) sú:**
- ⚠️ **Možno potrebné** pre niektoré advanced features
- ⚠️ **Možno nepotrebné** ak používame len file-based prístup
- ⚠️ **Otestujeme** počas Python Btrieve setup

---

## 🔧 Hlavné Btrieve DLLs (nie v tomto adresári)

**Tieto musíme mať nainštalované:**

### wbtrv32.dll (32-bit Windows)
```
Location: C:\Program Files (x86)\Actian\Zen\Bin\wbtrv32.dll
Purpose: Btrieve API - 32-bit
```

### w64btrv.dll (64-bit Windows)
```
Location: C:\Program Files\Actian\Zen\Bin\w64btrv.dll
Purpose: Btrieve API - 64-bit
```

**Python Btrieve 2 API používa:**
```python
import btrievePython as btrv

# Interne volá wbtrv32.dll alebo w64btrv.dll
client = btrv.BtrieveClient(0x4232, 0)
```

---

## 📦 Inštalácia Pervasive/Actian Zen

### Option 1: Actian Zen (odporúčané)
```
Download: https://esd.actian.com/product/Zen_PSQL
Platform: Windows 64-bit
Components:
  - Btrieve 2 API
  - Client Engine
  - DLLs (wbtrv32.dll, w64btrv.dll)
```

### Option 2: Pervasive PSQL (legacy)
```
Starší produkt, ale funguje
Obsahuje potrebné Btrieve DLLs
```

---

## ⚙️ PATH Configuration

**Po inštalácii pridaj do PATH:**
```bash
# Windows
set PATH=%PATH%;C:\Program Files\Actian\Zen\Bin

# Alebo 32-bit
set PATH=%PATH%;C:\Program Files (x86)\Actian\Zen\Bin
```

**V Python aplikácii:**
```python
import os
os.add_dll_directory("C:/Program Files/Actian/Zen/Bin")
```

---

## 🧪 Test DLL Availability

```python
import ctypes
import os

# Test if wbtrv32.dll is available
try:
    dll_path = r"C:\Program Files (x86)\Actian\Zen\Bin\wbtrv32.dll"
    if os.path.exists(dll_path):
        btrv_dll = ctypes.WinDLL(dll_path)
        print(f"✅ wbtrv32.dll loaded successfully from {dll_path}")
    else:
        print(f"❌ wbtrv32.dll not found at {dll_path}")
except Exception as e:
    print(f"❌ Error loading wbtrv32.dll: {e}")
```

---

## 🚨 Licencovanie

**DÔLEŽITÉ:**
- Pervasive/Actian Zen je **komerčný produkt**
- NEX Genesis už má **licenciu** na production serveri
- Pre development potrebujeme:
  - Developer licenciu, alebo
  - Trial verziu, alebo
  - Prístup k production serveru

**Overiť s ICC/NEX Genesis tímom!**

---

## 📝 Troubleshooting

### Problem: "Cannot load wbtrv32.dll"
**Riešenie:**
1. Skontroluj či je Actian Zen nainštalovaný
2. Skontroluj PATH
3. Skontroluj 32-bit vs 64-bit
4. Použij `os.add_dll_directory()`

### Problem: "Access denied"
**Riešenie:**
1. Skontroluj používateľské oprávnenia
2. Run as Administrator
3. Skontroluj firewall/antivirus

### Problem: "DLL not compatible"
**Riešenie:**
1. 32-bit Python → wbtrv32.dll
2. 64-bit Python → w64btrv.dll
3. Prebuduj Python wrapper pre správnu architektúru

---

## 🔗 Súvisiace dokumenty

- **[python-btrieve-setup.md](../docs/architecture/python-btrieve-setup.md)** - Python Btrieve setup guide
- **[FULL_PROJECT_CONTEXT.md](../docs/FULL_PROJECT_CONTEXT.md)** - Kontext projektu
- **[Actian Documentation](https://docs.actian.com/)** - Oficiálna dokumentácia

---

## 📊 File Info

```
wdbnames.dll  - Size: ~XYZ KB
wdbnm32.dll   - Size: ~XYZ KB
wssql32.dll   - Size: ~XYZ KB
wxqlcall.dll  - Size: ~XYZ KB
```

**Tracked in Git:** ✅ Áno (pre backup/dokumentáciu)  
**Used in Production:** ⚠️ TBD (otestujeme)

---

## ⚠️ Poznámky

1. **Tieto DLLs sú z NEX Genesis inštalácie**
2. **Nie sú hlavné Btrieve DLLs** (wbtrv32.dll, w64btrv.dll)
3. **Možno nepotrebné** pre file-based prístup
4. **Ponechané pre dokumentáciu** a prípadné použitie

---

**Last Updated:** 2025-10-21  
**Version:** 0.2.0  
**Purpose:** 📚 Reference & Backup