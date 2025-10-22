# Python Version Requirements

## ⚠️ CRITICAL: 32-bit Python Required

**NEX Genesis Server requires 32-bit Python for Btrieve DLL compatibility.**

---

## 🔍 Why 32-bit?

NEX Genesis ERP uses **Pervasive PSQL v11**, which provides 32-bit DLLs:
- `wxqlcall.dll` (32-bit Btrieve API)
- `wdbnames.dll`, `wdbnm32.dll`, `wssql32.dll` (helpers)

**64-bit Python cannot load 32-bit DLLs.**

---

## ✅ Quick Check

```powershell
python scripts/check_python_version.py
```

### Expected Output (✅ OK):
```
✅ COMPATIBLE
✅ Python is 32-bit
✅ Can load wxqlcall.dll
```

### Problem Output (❌ FAIL):
```
❌ INCOMPATIBLE
❌ Python is 64-bit
❌ Cannot load wxqlcall.dll
```

---

## 📥 Installation

If you have 64-bit Python, follow the installation guide:

📖 **[docs/INSTALL_32BIT_PYTHON.md](INSTALL_32BIT_PYTHON.md)**

**Quick steps:**
1. Download Python 3.13 (32-bit) from python.org
2. Install to: `C:\Python313-32\`
3. Create venv: `py -3.13-32 -m venv venv32`
4. Activate: `.\venv32\Scripts\activate`
5. Install deps: `pip install -r requirements.txt`

---

## 🎯 Solutions

### ⭐ Option A: Install 32-bit Python (RECOMMENDED)
- **Pros:** Simple, direct, fast
- **Cons:** Need separate Python installation
- **Best for:** Development, single machine
- **Guide:** [INSTALL_32BIT_PYTHON.md](INSTALL_32BIT_PYTHON.md)

### 🔧 Option B: Bridge Service (FUTURE)
- **Pros:** Main app can be 64-bit
- **Cons:** Complex, two processes
- **Best for:** Production, multiple apps
- **Guide:** [BTRIEVE_BRIDGE_SERVICE.md](BTRIEVE_BRIDGE_SERVICE.md)

---

## 📊 Version Compatibility

| Python Version | Architecture | NEX Genesis | Status |
|----------------|--------------|-------------|--------|
| 3.13.x         | 32-bit       | ✅ Compatible | Recommended |
| 3.12.x         | 32-bit       | ✅ Compatible | OK |
| 3.11.x         | 32-bit       | ✅ Compatible | OK |
| 3.10.x         | 32-bit       | ✅ Compatible | OK |
| 3.9.x          | 32-bit       | ⚠️ Works | Old |
| **ANY**        | **64-bit**   | **❌ INCOMPATIBLE** | **Will not work** |

---

## 🚀 Workflow

### Using py launcher:
```powershell
# Check versions
py -0  # List all Python versions

# Run with 32-bit
py -3.13-32 tests/test_btrieve_basic.py
```

### Using virtual environment (recommended):
```powershell
# Create 32-bit venv
py -3.13-32 -m venv venv32

# Activate (Windows)
.\venv32\Scripts\activate

# Now 'python' is 32-bit
python --version
python tests/test_btrieve_basic.py
```

### Using direct path:
```powershell
C:\Python313-32\python.exe tests/test_btrieve_basic.py
```

---

## 🔧 PyCharm Setup

1. **File → Settings → Project → Python Interpreter**
2. **Add Interpreter → Add Local Interpreter**
3. **Select:** `C:\Development\nex-genesis-server\venv32\Scripts\python.exe`
4. **Apply**

Now PyCharm will use 32-bit Python for all runs.

---

## ⚠️ Common Issues

### Issue: "Could not load DLL"
```
Cause: Python is 64-bit
Solution: Install 32-bit Python
Check: python scripts/check_python_version.py
```

### Issue: "py -3.13-32 not found"
```
Cause: py launcher not configured
Solution: Use direct path
Example: C:\Python313-32\python.exe
```

### Issue: "venv still shows 64-bit"
```
Cause: venv created with 64-bit Python
Solution: Delete and recreate
Commands:
  rmdir /s venv32
  py -3.13-32 -m venv venv32
```

---

## 📖 Additional Resources

- [Installation Guide](INSTALL_32BIT_PYTHON.md) - Step-by-step 32-bit Python installation
- [Testing Guide](TESTING_GUIDE.md) - How to run tests
- [Pervasive DLL Info](PERVASIVE_DLL_INFO.md) - DLL details and troubleshooting
- [Bridge Service](BTRIEVE_BRIDGE_SERVICE.md) - Alternative 64-bit solution (future)

---

## 🎯 Summary

| What | Details |
|------|---------|
| **Requirement** | 32-bit Python |
| **Reason** | wxqlcall.dll is 32-bit |
| **Recommended Version** | Python 3.13.7 (32-bit) |
| **Installation Path** | `C:\Python313-32\` |
| **Virtual Env** | `venv32` |
| **Check Script** | `scripts/check_python_version.py` |

---

**Status:** MANDATORY  
**Priority:** CRITICAL  
**Created:** 2025-10-22  
**Author:** ICC (rausch@icc.sk)