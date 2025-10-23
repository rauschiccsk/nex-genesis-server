# NEX Genesis Server - Development Guide

**Project Structure, Configuration, and Standards**

Version: 1.0.0  
Last Updated: 2025-10-23

---

## Project Structure

```
c:\Development\nex-genesis-server/
│
├─ docs/                                    
│  ├─ context/                          # Strategic context (NEW)
│  │  ├─ README.md
│  │  ├─ project_overview.md
│  │  ├─ architecture.md
│  │  ├─ database.md
│  │  ├─ development.md
│  │  └─ btrieve_rules.md
│  │
│  ├─ sessions/                         # Daily work logs
│  │  ├─ 2025-10-21_session.md
│  │  ├─ 2025-10-22_session.md
│  │  ├─ 2025-10-23_session.md
│  │  └─ README.md
│  │
│  ├─ INIT_CONTEXT.md                   # Quick start guide
│  ├─ NEX_DATABASE_STRUCTURE.md         # Detailed DB docs
│  ├─ TESTING_GUIDE.md                  # Testing procedures
│  └─ architecture/
│     └─ database-access-pattern.md     # Btrieve patterns
│
├─ database-schema/                     # Real .bdf schema files
│  ├─ barcode.bdf
│  ├─ gscat.bdf
│  ├─ mglst.bdf
│  ├─ pab.bdf
│  ├─ tsh.bdf
│  ├─ tsi.bdf
│  └─ README.md
│
├─ delphi-sources/                      # Reference implementation
│  ├─ BtrConst.pas                      # Btrieve constants
│  ├─ BtrHand.pas                       # Low-level handlers
│  ├─ BtrStruct.pas                     # Data structures
│  ├─ BtrTable.pas                      # Table definitions
│  ├─ BtrTools.pas                      # Helper functions
│  ├─ SqlApi32.pas                      # SQL API
│  ├─ btrapi32.pas                      # Btrieve API declarations
│  └─ README.md
│
├─ external-dlls/                       # Pervasive PSQL DLLs
│  └─ README.md
│
├─ src/
│  ├─ btrieve/                          # Btrieve wrapper (WORKING)
│  │  ├─ __init__.py
│  │  └─ btrieve_client.py              # Main wrapper
│  │
│  ├─ services/                         # Business logic (PLANNED)
│  │  ├─ __init__.py
│  │  ├─ product_service.py
│  │  ├─ barcode_service.py
│  │  ├─ delivery_note_service.py
│  │  └─ supplier_service.py
│  │
│  ├─ parsers/                          # XML/ISDOC (PLANNED)
│  │  ├─ __init__.py
│  │  ├─ isdoc_parser.py
│  │  └─ xml_validator.py
│  │
│  ├─ api/                              # FastAPI (PLANNED)
│  │  ├─ __init__.py
│  │  ├─ main.py
│  │  └─ endpoints.py
│  │
│  └─ utils/                            # Utilities (WORKING)
│     ├─ __init__.py
│     └─ config.py                      # Config loader
│
├─ tests/                               # Testing (ALL PASSING)
│  ├─ __init__.py
│  ├─ test_btrieve_basic.py            # Level 1: Config & DLL
│  ├─ test_btrieve_file.py             # Level 2: File operations
│  ├─ test_btrieve_read.py             # Level 3: Data reading
│  └─ test_file_opening_variants.py    # Edge cases
│
├─ config/
│  ├─ database.yaml                     # Main configuration (ACTIVE)
│  └─ config_template.yaml              # Template for new setups
│
├─ scripts/                             # Utility scripts
│  ├─ generate_project_access.py       # Manifest generator
│  ├─ create_directory_structure.py    # Setup script
│  ├─ check_python_version.py          # Version checker
│  └─ debug_dll_loading.py             # DLL diagnostics
│
├─ .gitignore
├─ README.md
├─ requirements.txt                     # Full dependencies
└─ requirements-minimal.txt             # Minimal dependencies (ACTIVE)
```

---

## Configuration Files

### database.yaml (Main Configuration)

**Location:** `config/database.yaml`

```yaml
nex_genesis:
  root_path: "C:\\NEX"
  yearact_path: "C:\\NEX\\YEARACT"
  
  database:
    stores_path: "C:\\NEX\\YEARACT\\STORES"
    dials_path: "C:\\NEX\\YEARACT\\DIALS"
  
  tables:
    gscat: "C:\\NEX\\YEARACT\\STORES\\GSCAT.BTR"
    barcode: "C:\\NEX\\YEARACT\\STORES\\BARCODE.BTR"
    mglst: "C:\\NEX\\YEARACT\\STORES\\MGLST.BTR"
    pab: "C:\\NEX\\YEARACT\\DIALS\\PAB00000.BTR"
    tsh: "C:\\NEX\\YEARACT\\STORES\\TSHA-{book_number}.BTR"
    tsi: "C:\\NEX\\YEARACT\\STORES\\TSIA-{book_number}.BTR"
  
  books:
    delivery_notes_book: "001"
    book_type: "A"

btrieve:
  dll_paths:
    - "C:\\Program Files (x86)\\Pervasive Software\\PSQL\\bin"
    - "C:\\PVSW\\bin"
    - "external-dlls/"
    - "C:\\Windows\\SysWOW64"

logging:
  enabled: true
  level: "INFO"
  path: "C:\\Logs\\NEXGenesisServer"
```

### Usage in Code

```python
from src.utils.config import get_config

config = get_config()

# Get table path
gscat_path = config.get_table_path('gscat')
# Returns: "C:\\NEX\\YEARACT\\STORES\\GSCAT.BTR"

# Get table with book number
tsh_path = config.get_table_path('tsh')
# Returns: "C:\\NEX\\YEARACT\\STORES\\TSHA-001.BTR"

# Validate all paths
config.validate_paths()
```

---

## Development Environment

### Python Setup

**Requirements:**
- Python 3.8+ (32-bit REQUIRED!)
- Virtual environment (venv32)
- Minimal dependencies installed

**Installation:**
```powershell
# Download 32-bit Python
# https://www.python.org/downloads/

# Create virtual environment
cd C:\Development\nex-genesis-server
C:\Python313-32\python.exe -m venv venv32

# Activate
.\venv32\Scripts\activate

# Install dependencies
pip install -r requirements-minimal.txt
```

**Verify Setup:**
```powershell
python scripts/check_python_version.py
```

### IDE Setup (PyCharm)

**Recommended Settings:**
- Python Interpreter: venv32/Scripts/python.exe
- Code Style: PEP 8
- Enable type checking (mypy)
- Enable auto-formatting (black)

**Plugins:**
- Python
- Markdown
- YAML
- Git Integration

---

## Coding Standards

### Python Style Guide

**Follow PEP 8:**
- 4 spaces indentation
- Max line length: 88 characters (black default)
- Use meaningful variable names
- Add docstrings to all functions/classes

### Type Hints

**Always use type hints:**
```python
def get_product(gs_code: int) -> Optional[dict]:
    """Get product by GsCode.
    
    Args:
        gs_code: Product code (GSCAT.GsCode)
        
    Returns:
        Product data dict or None if not found
    """
    pass
```

### Docstrings

**Use Google style:**
```python
def create_delivery_note(
    supplier_ico: str,
    items: List[DeliveryItem],
    date: datetime
) -> str:
    """Create new delivery note in NEX Genesis.
    
    Args:
        supplier_ico: Supplier ICO (8-digit string)
        items: List of delivery items
        date: Document date
        
    Returns:
        Document number (e.g., "DL-2025-0001")
        
    Raises:
        ValidationError: Invalid supplier or items
        BtrieveError: Database operation failed
    """
    pass
```

### Comments

**Slovak for business logic:**
```python
# Overenie či produkt existuje v katalógu
if not product_exists(gs_code):
    # Vytvorenie nového produktu z ISDOC dát
    create_product(isdoc_data)
```

**English for technical details:**
```python
# Btrieve operation: Get Equal with key_num=0 (primary key)
status = client.get_equal(pos_block, data_buffer, key_buffer, 0)
```

### Error Handling

**Always handle exceptions:**
```python
try:
    pos_block = client.open_file(file_path)
    try:
        # Operations
        data = client.read_record(pos_block)
        return data
    finally:
        # Always close file
        client.close_file(pos_block)
except BtrieveError as e:
    logger.error(f"Btrieve error: {e}")
    raise
except Exception as e:
    logger.error(f"Unexpected error: {e}")
    raise
```

### Testing

**Write tests for everything:**
```python
def test_product_creation():
    """Test product creation in GSCAT."""
    service = ProductService()
    
    # Given
    product_data = {
        'name': 'Test Product',
        'mglst_code': 1,
        'price': 100.0
    }
    
    # When
    gs_code = service.create_product(product_data)
    
    # Then
    assert gs_code > 0
    product = service.get_product(gs_code)
    assert product['name'] == 'Test Product'
```

---

## Git Workflow

### Commit Guidelines

**Conventional Commits:**
```
feat: Add product service implementation
fix: Correct Btrieve dataLen type (4 bytes)
docs: Update database context
test: Add integration tests for TSH/TSI
refactor: Simplify config loader
chore: Update dependencies
```

**Commit Often:**
- Small, focused commits
- Descriptive messages
- Test before commit
- Pull before push

### Branch Strategy

**Main branches:**
- `main` - Production-ready code
- `develop` - Integration branch

**Feature branches:**
- `feature/product-service`
- `feature/isdoc-parser`
- `fix/btrieve-datatype`

### Pre-commit Checklist

```
[ ] All tests pass: pytest tests/ -v
[ ] Code formatted: black src/ tests/
[ ] Linting passes: flake8 src/ tests/
[ ] Type checking: mypy src/
[ ] Documentation updated
[ ] Session notes updated (end of day)
```

---

## Testing Strategy

### Test Levels

**Level 1: Unit Tests**
- Individual functions
- Mock external dependencies
- Fast execution

**Level 2: Integration Tests**
- Real database operations
- Full workflows
- Require NEX database access

**Level 3: End-to-End Tests**
- Complete scenarios
- ISDOC import to delivery note
- Performance testing

### Running Tests

```powershell
# All tests
pytest tests/ -v

# Specific level
pytest tests/test_btrieve_basic.py -v

# With coverage
pytest tests/ --cov=src --cov-report=html

# Mark specific tests
pytest -m unit  # Unit tests only
pytest -m integration  # Integration tests only
```

### Test Data

**Use test database:**
- Separate test environment
- Mock data for unit tests
- Real data copy for integration tests

---

## Project File Access Manifests

### Purpose

Provide Claude with structured access to all project files via raw GitHub URLs.

### Files

```
docs/
├─ project_file_access.json              # Unified manifest (all files)
├─ project_file_access_docs.json         # Documentation only
├─ project_file_access_bdf.json          # Database schemas
└─ project_file_access_delphi.json       # Delphi reference
```

### Usage

**For Claude context loading:**
```
https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main/docs/project_file_access.json
```

### Refresh Manifests

**IMPORTANT: After creating/modifying files:**
```powershell
python scripts/generate_project_access.py
git add docs/project_file_access*.json
git commit -m "chore: refresh project manifests"
git push
```

---

## Dependencies Management

### Minimal Dependencies (Active)

**File:** `requirements-minimal.txt`

```
PyYAML>=6.0
pytest>=7.0
pytest-cov>=4.0
colorama>=0.4.0
black>=23.0
flake8>=6.0
```

### Full Dependencies (Future)

**File:** `requirements.txt`

```
# Minimal (always installed)
PyYAML>=6.0
pytest>=7.0
pytest-cov>=4.0

# API Layer (when implementing)
fastapi>=0.100.0
uvicorn[standard]>=0.23.0
pydantic>=2.0

# XML Processing
lxml>=4.9.0

# Code Quality
black>=23.0
flake8>=6.0
mypy>=1.0
```

### Installing Dependencies

```powershell
# Activate venv
.\venv32\Scripts\activate

# Minimal (for testing)
pip install -r requirements-minimal.txt

# Full (for production)
pip install -r requirements.txt
```

---

## Logging Configuration

### Log Levels

- **DEBUG:** Detailed Btrieve operations
- **INFO:** Successful operations
- **WARNING:** Recoverable errors
- **ERROR:** Failed operations
- **CRITICAL:** System failures

### Log Format

```python
import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('C:\\Logs\\NEXGenesisServer\\app.log'),
        logging.StreamHandler()
    ]
)
```

---

## Security Best Practices

### Current (Development)

- No sensitive data in git
- Use .gitignore for configs
- Local file access only

### Future (Production)

- API authentication
- Encrypted configuration
- Audit logging
- Rate limiting
- Input validation

---

## Documentation Standards

### Markdown Files

- Use clear headers
- Add code examples
- Keep files focused
- Update regularly

### Code Documentation

- Docstrings for all public functions
- Type hints everywhere
- Inline comments for complex logic
- README in each directory

---

**For current status:** See `docs/sessions/YYYY-MM-DD_session.md` (latest session)  
**For Btrieve rules:** See `docs/context/btrieve_rules.md`