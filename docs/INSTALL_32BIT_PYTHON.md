# Installing 32-bit Python for NEX Genesis Server

## ⚠️ Prečo potrebujeme 32-bit Python?

NEX Genesis používa **32-bit Pervasive PSQL v11 DLLs** (wxqlcall.dll).
64-bit Python **nemôže** načítať 32-bit DLLs.

**Riešenie:** Nainštaluj 32-bit Python **vedľa** existujúceho 64-bit Pythonu.

---

## 📥 Krok 1: Download 32-bit Python

1. **Choď na:** https://www.python.org/downloads/
2. **Vyber verziu:** Python 3.13.7 (alebo 3.11+)
3. **Scroll dole na "Files"**
4. **Stiahni:** `Windows installer (32-bit)` 
   - **NIE** `-amd64` verziu!
   - Súbor: `python-3.13.7.exe` (cca 25 MB)

---

## 🔧 Krok 2: Inštalácia

### Spusti installer:
```
python-3.13.7.exe
```

### Nastavenia inštalácie:

#### Screen 1: Install Python
```
✅ Install launcher for all users (py.exe)
✅ Add python.exe to PATH
📁 Customize installation  👈 KLIKNI
```

#### Screen 2: Optional Features
```
✅ Documentation
✅ pip
✅ tcl/tk and IDLE
✅ Python test suite
✅ py launcher
✅ for all users
```

#### Screen 3: Advanced Options
```
✅ Install Python 3.13 for all users
✅ Associate files with Python
✅ Create shortcuts
✅ Add Python to environment variables
✅ Precompile standard library
⚠️  Customize install location:
   C:\Python313-32\     👈 DÔLEŽITÉ!
```

**CRITICAL:** Zmeň cestu na `C:\Python313-32\` aby si rozlíšil 32-bit od 64-bit!

### Klikni: Install

---

## ✅ Krok 3: Verifikácia

### Test py launcher:
```powershell
# 64-bit Python
py -3.13-64 --version
# Python 3.13.7

# 32-bit Python
py -3.13-32 --version
# Python 3.13.7

# Check architecture
py -3.13-32 -c "import platform; print(platform.architecture())"
# ('32bit', 'WindowsPE')  ✅
```

### Test direct exe:
```powershell
C:\Python313-32\python.exe --version
# Python 3.13.7

C:\Python313-32\python.exe -c "import platform; print(platform.architecture())"
# ('32bit', 'WindowsPE')  ✅
```

---

## 🐍 Krok 4: Virtual Environment (32-bit)

### Vytvor venv:
```powershell
cd C:\Development\nex-genesis-server

# Vytvoriť 32-bit venv
py -3.13-32 -m venv venv32

# Alebo direct path:
C:\Python313-32\python.exe -m venv venv32
```

### Aktivuj venv:
```powershell
.\venv32\Scripts\activate

# Prompt by mal zmeniť na:
(venv32) PS C:\Development\nex-genesis-server>
```

### Overenie:
```powershell
python --version
# Python 3.13.7

python scripts/check_python_version.py
# ✅ COMPATIBLE
# ✅ Python is 32-bit
```

---

## 📦 Krok 5: Install Dependencies

```powershell
# Aktivuj venv ak nie je aktivovaný
.\venv32\Scripts\activate

# Upgrade pip
python -m pip install --upgrade pip

# Install dependencies
pip install -r requirements.txt

# Verify installation
pip list
```

---

## 🧪 Krok 6: Spusti Tests

```powershell
# Aktivuj venv
.\venv32\Scripts\activate

# Test 1: Basic
python tests/test_btrieve_basic.py

# Očakávaný výstup:
# ✅ Loaded Btrieve DLL: wxqlcall.dll
# ✅ Found Btrieve function: BTRV
# ✅ Btrieve client loaded successfully!

# Test 2: File Opening
python tests/test_btrieve_file.py

# Test 3: Data Reading
python tests/test_btrieve_read.py
```

---

## 🎯 Workflow - Používanie 32-bit Python

### Option A: py launcher (jednoduchšie)
```powershell
# Spusti script s 32-bit Python
py -3.13-32 tests/test_btrieve_basic.py

# Run from any directory
cd C:\Development\nex-genesis-server
py -3.13-32 -m pytest tests/
```

### Option B: venv (odporúčané)
```powershell
# Aktivuj venv (raz)
.\venv32\Scripts\activate

# Teraz všetky python príkazy sú 32-bit
python tests/test_btrieve_basic.py
python src/btrieve/btrieve_client.py
pytest

# Deaktivuj keď hotovo
deactivate
```

### Option C: direct path
```powershell
C:\Python313-32\python.exe tests/test_btrieve_basic.py
```

---

## 📝 PyCharm Configuration

### Pridaj 32-bit Python interpreter:

1. **File → Settings → Project → Python Interpreter**
2. **Add Interpreter → Add Local Interpreter**
3. **Existing environment:**
   ```
   C:\Development\nex-genesis-server\venv32\Scripts\python.exe
   ```
4. **OK**

### Prepni interpreter:
```
Bottom right corner: venv32 (Python 3.13)
```

### Spusti tests v PyCharm:
```
Right-click na test file → Run 'test_btrieve_basic'
PyCharm automatically uses venv32 interpreter
```

---

## 🔄 Prepínanie medzi 32-bit a 64-bit

### Máš oba naraz:
```powershell
# 64-bit Python (default)
python --version
C:\Users\user\AppData\Local\Programs\Python\Python313\python.exe

# 32-bit Python (nový)
C:\Python313-32\python.exe --version
```

### Virtual Environments:
```powershell
# 64-bit venv
python -m venv venv64
.\venv64\Scripts\activate

# 32-bit venv
py -3.13-32 -m venv venv32
.\venv32\Scripts\activate
```

### Pre NEX Genesis Server:
```
✅ VŽDY používaj 32-bit Python (venv32)
❌ 64-bit Python nebude fungovať s Btrieve DLL
```

---

## ⚠️ Troubleshooting

### Problém: "py -3.13-32" not found
```powershell
# Riešenie: Použiť direct path
C:\Python313-32\python.exe --version
```

### Problém: venv stále 64-bit
```powershell
# Skontroluj ktorý Python vytvoril venv
.\venv32\Scripts\python.exe -c "import platform; print(platform.architecture())"

# Ak je 64-bit, vymazať a vytvoriť znova
rmdir /s venv32
C:\Python313-32\python.exe -m venv venv32
```

### Problém: pip install fails
```powershell
# Upgrade pip
python -m pip install --upgrade pip

# Reinstall package
pip install --upgrade --force-reinstall <package>
```

### Problém: DLL still not loading
```powershell
# Verify Python is 32-bit
python scripts/check_python_version.py
# Must show: 32bit

# Check DLL exists
dir external-dlls\wxqlcall.dll

# Try basic test
python tests/test_btrieve_basic.py
```

---

## 📊 Summary

### Pred inštaláciou:
```
❌ Python 3.13.7 64-bit
❌ Cannot load wxqlcall.dll
❌ Btrieve client fails
```

### Po inštalácii:
```
✅ Python 3.13.7 32-bit (C:\Python313-32\)
✅ Can load wxqlcall.dll
✅ Btrieve client works
✅ All tests pass
```

---

## 🚀 Next Steps

Po úspešnej inštalácii 32-bit Pythonu:

1. ✅ Vytvor venv32
2. ✅ Nainštaluj dependencies
3. ✅ Spusti tests (všetky 3 úrovne)
4. 📋 Task 1.7b COMPLETE
5. 📋 Pokračuj na Task 1.8 (Database Schema)

---

**Vytvorené:** 2025-10-22  
**Verzia:** 1.0  
**Autor:** ICC (rausch@icc.sk)  
**Účel:** Návod na inštaláciu 32-bit Python pre NEX Genesis Server