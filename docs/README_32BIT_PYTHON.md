# ⚠️ IMPORTANT: 32-bit Python Required

## 🚨 Before You Start

**NEX Genesis Server requires 32-bit Python!**

If you see this error:
```
❌ Python is 64-bit
❌ Cannot load wxqlcall.dll
```

**→ Follow the guide below to install 32-bit Python.**

---

## ⚡ Quick Setup (3 Steps)

### 1️⃣ Check Your Python Version
```powershell
python scripts/check_python_version.py
```

**If output shows:**
- ✅ `32bit` → You're good! Skip to step 3
- ❌ `64bit` → Continue to step 2

### 2️⃣ Install 32-bit Python

**Download:**
- Go to: https://www.python.org/downloads/release/python-3137/
- Download: `Windows installer (32-bit)` ← **NOT** `-amd64`

**Install:**
- Run installer
- ⚠️ **Custom installation path:** `C:\Python313-32\`
- ✅ Check "Add to PATH"

**Create virtual environment:**
```powershell
cd C:\Development\nex-genesis-server
py -3.13-32 -m venv venv32
.\venv32\Scripts\activate
```

### 3️⃣ Install Dependencies & Test
```powershell
# Make sure venv32 is activated
pip install -r requirements.txt

# Run tests
python tests/test_btrieve_basic.py
```

**Expected output:**
```
✅ Config loaded successfully!
✅ Loaded Btrieve DLL: wxqlcall.dll
✅ Found Btrieve function: BTRV
✅ All paths validated!

Total: 3/3 tests passed
🎉 All basic tests passed!
```

---

## 📖 Detailed Guides

- 📘 [Full Installation Guide](docs/INSTALL_32BIT_PYTHON.md)
- 🧪 [Testing Guide](docs/TESTING_GUIDE.md)
- 🔧 [Python Version Requirements](docs/PYTHON_VERSION_REQUIREMENTS.md)

---

## ❓ Why 32-bit?

NEX Genesis uses **Pervasive PSQL v11** (32-bit) for database access.

```
NEX Genesis ERP (Delphi 6, 32-bit)
    ↓
wxqlcall.dll (Pervasive PSQL v11, 32-bit)
    ↓
NEX Genesis Server (Python, MUST BE 32-bit)
```

**64-bit Python cannot load 32-bit DLLs.**

---

## 🆘 Need Help?

### Can't install 32-bit Python?
→ See: [BTRIEVE_BRIDGE_SERVICE.md](docs/BTRIEVE_BRIDGE_SERVICE.md) (alternative solution)

### Tests still failing?
→ See: [TESTING_GUIDE.md](docs/TESTING_GUIDE.md) (troubleshooting)

### DLL issues?
→ See: [PERVASIVE_DLL_INFO.md](docs/PERVASIVE_DLL_INFO.md) (DLL details)

---

## ✅ Success Criteria

After setup, you should have:
- ✅ 32-bit Python installed (`C:\Python313-32\`)
- ✅ Virtual environment created (`venv32`)
- ✅ Dependencies installed
- ✅ All basic tests passing
- ✅ Btrieve DLL loading successfully

---

**Once all tests pass, you're ready to develop! 🚀**

Continue with: [Main README](README.md)