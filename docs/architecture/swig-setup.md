# SWIG Setup Guide

**Dátum:** 2025-10-21  
**Verzia SWIG:** 4.3.1  
**OS:** Windows 11  
**Task:** 1.7.1 - Install SWIG

---

## 🎯 Čo je SWIG?

SWIG (Simplified Wrapper and Interface Generator) je nástroj, ktorý generuje Python bindings pre C/C++ knižnice.

**Použitie v projekte:**
- Vytvorenie Python wrappera pre Pervasive Btrieve API (C DLLs)
- Umožňuje volať C funkcie priamo z Pythonu
- Automatická konverzia dátových typov medzi C a Python

---

## 📦 Inštalácia

### Prerequisites

- ✅ Windows 10/11
- ✅ PowerShell (Administrator)
- ✅ Chocolatey package manager

### Kroky

#### 1. Nainštaluj Chocolatey (ak nemáš)

```powershell
# Otvor PowerShell ako Administrator
# Win + X → "Terminal (Admin)" alebo "Windows PowerShell (Admin)"

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

**Over inštaláciu:**
```powershell
choco --version
```

**Troubleshooting:** Ak `choco` nie je rozpoznaný, reštartuj PowerShell.

---

#### 2. Nainštaluj SWIG

```powershell
# V PowerShell (Admin)
choco install swig -y
```

**Čo sa nainštaluje:**
- SWIG 4.3.1 (alebo novšia verzia)
- Umiestnenie: `C:\ProgramData\chocolatey\lib\swig`
- Automaticky pridané do PATH

**Trvanie:** ~1-2 minúty

---

#### 3. Over inštaláciu

```powershell
swig -version
```

**Očakávaný výstup:**
```
SWIG Version 4.3.1
Compiled with x86_64-w64-mingw32-g++ [x86_64-w64-mingw32]
Configured options: +pcre
Please see https://www.swig.org for reporting bugs and further information
```

---

## ✅ Výsledok

- ✅ SWIG Version 4.3.1 nainštalovaný
- ✅ Chocolatey v2.5.1 funkčný
- ✅ SWIG dostupný v PATH
- ✅ Pripravené na generovanie Python bindings

---

## 🔜 Ďalšie kroky

### Task 1.7.2: Download Pervasive PSQL v11 SDK
- Stiahnutie Pervasive SDK s Btrieve 2 API
- Umiestnenie DLLs a header súborov

### Task 1.7.3: Setup C++ compiler
- Visual Studio Build Tools
- Potrebné pre kompiláciu SWIG wrapperov

### Task 1.7.4: Build Python Btrieve wrapper
- Vytvorenie interface súborov (.i)
- Generovanie wrappera cez SWIG
- Kompilácia C extension module

---

## 📚 Resources

- **SWIG Official:** https://www.swig.org/
- **SWIG Documentation:** https://www.swig.org/doc.html
- **Chocolatey:** https://chocolatey.org/
- **SWIG Python Tutorial:** https://www.swig.org/Doc4.0/Python.html

---

## 🔧 Príkazy na Quick Reference

```powershell
# Over SWIG verziu
swig -version

# Over Chocolatey
choco --version

# Update SWIG (v budúcnosti)
choco upgrade swig -y

# Uninstall SWIG (ak treba)
choco uninstall swig -y
```

---

**Status:** ✅ HOTOVO (2025-10-21)  
**Developer:** rauschiccsk  
**Project:** nex-genesis-server