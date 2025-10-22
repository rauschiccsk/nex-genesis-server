# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### In Progress
- Task 1.7b - Python Btrieve Setup (70% complete, blocked on DLL issue)
- Task 1.8 - Database schema dokumentácia (planned)

## [0.2.1] - 2025-10-22

### Added - Python Btrieve Client
- Python Btrieve client wrapper using ctypes for direct DLL access
- YAML-based configuration system for database paths
- 3-level testing framework (basic, file opening, data reading)
- DLL diagnostics and debugging tools

#### Core Components
- `src/btrieve/btrieve_client.py` - Main Btrieve API wrapper
- `src/utils/config.py` - Configuration loader with YAML support
- `config/database.yaml` - Database configuration template
- `src/btrieve/__init__.py` - Btrieve module initialization
- `src/utils/__init__.py` - Utils module initialization

#### Testing Suite
- `tests/test_btrieve_basic.py` - Level 1: Config and DLL loading tests
- `tests/test_btrieve_file.py` - Level 2: File opening tests
- `tests/test_btrieve_read.py` - Level 3: Data reading tests

#### Scripts and Tools
- `scripts/check_python_version.py` - Verify 32-bit Python requirement
- `scripts/debug_dll_loading.py` - Diagnostic tool for DLL issues

#### Documentation
- `docs/NEX_DATABASE_STRUCTURE.md` - Complete database schema (STORES/DIALS)
- `docs/TESTING_GUIDE.md` - Comprehensive testing procedures
- `docs/PERVASIVE_DLL_INFO.md` - Pervasive PSQL v11 DLL information
- `docs/PYTHON_VERSION_REQUIREMENTS.md` - 32-bit Python requirement explanation
- `docs/INSTALL_32BIT_PYTHON.md` - Step-by-step 32-bit Python installation
- `docs/BTRIEVE_BRIDGE_SERVICE.md` - Future: 64-bit Python solution design
- `docs/SESSION_SUMMARY_2025-10-22.md` - Development session notes
- `README_32BIT_PYTHON.md` - Quick start guide for 32-bit Python setup

#### Dependencies
- `requirements-minimal.txt` - Minimal dependencies for development and testing
- Updated `requirements.txt` with 32-bit Python notes and comprehensive packages

### Changed - Database Structure
- Corrected database directory structure:
  - STORES (not STKDAT) - stock management tables
  - DIALS (not STKDAT) - reference tables (číselníky)
- Fixed PAB filename: `PAB00000.BTR` (not `PAB.00000.BTR`)
- Fixed TSH/TSI naming convention: `TSHA-001.BTR`, `TSIA-001.BTR`
- Updated book numbering system with dynamic filename generation

### Technical Decisions
- **32-bit Python Required**: NEX Genesis uses 32-bit Pervasive PSQL v11
- **ctypes Approach**: Direct DLL loading without SWIG compilation
- **Minimal Requirements**: Separate minimal requirements file to avoid build tools
- **Split Manifests**: project_file_access_docs.json, _bdf.json, _delphi.json

### Known Issues
- **BLOCKED**: wxqlcall.dll in external-dlls/ is not a valid PE file
- DLL loading fails with "WinError 193: Not a valid Win32 application"
- Need to source correct Pervasive PSQL v11 DLLs from installation
- httptools dependency requires Visual C++ Build Tools (deferred)

### Progress
- Phase 1: 70% complete (7/10 tasks)
- Task 1.1-1.6: ✅ COMPLETE
- Task 1.7b: 🔄 IN PROGRESS (70%, blocked on DLL)
- Task 1.8-1.10: 📋 PLANNED

## [0.2.0] - 2025-10-21

### Added - Database Schema and Delphi References
- Real NEX Genesis .bdf schema files (6 tables)
- Delphi Btrieve wrapper source code (7 files)
- Pervasive PSQL DLLs (4 files)
- Database schema documentation

### Changed - Strategic Direction
- **PIVOT**: Pure Python Btrieve approach (not Delphi microservice)
- Updated project focus to Python services with direct Btrieve access

### Documentation
- `database-schema/` - 6 .bdf files with README
- `delphi-sources/` - NEX Genesis Btrieve wrappers
- `external-dlls/` - Pervasive PSQL v11 DLLs
- Updated `docs/architecture/btrieve-access.md`
- Split project file access manifests (docs, bdf, delphi)

### Progress
- Phase 1: 60% → 70%
- Tasks 1.1-1.6: COMPLETE
- Task 1.7: Started

## [0.1.0] - 2025-10-21

### Added - Initial Project Setup
- GitHub repository: nex-genesis-server
- Local project: c:\Development\nex-genesis-server
- Git initialized with .gitignore, README.md
- Basic project structure

### Documentation
- `docs/FULL_PROJECT_CONTEXT.md` - Single-file project context
- `scripts/generate_project_access.py` - Manifest generator
- `scripts/create_directory_structure.py` - Directory creator

### Progress
- Phase 1: 40%
- Tasks 1.1-1.4: COMPLETE

---

## Version History Summary

- **v0.2.1** (2025-10-22) - Python Btrieve client, 32-bit support, comprehensive testing
- **v0.2.0** (2025-10-21) - Database schema, Delphi references, strategic pivot
- **v0.1.0** (2025-10-21) - Initial project setup

---

## Change Categories

### Added
New features, files, or functionality

### Changed
Changes to existing functionality

### Deprecated
Soon-to-be removed features

### Removed
Removed features

### Fixed
Bug fixes

### Security
Security fixes or improvements

---

**Maintained by:** ICC (rausch@icc.sk)  
**Project:** NEX Genesis Server  
**Repository:** https://github.com/rauschiccsk/nex-genesis-server