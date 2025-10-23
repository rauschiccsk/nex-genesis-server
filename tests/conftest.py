"""
Pytest configuration for NEX Genesis Server tests.

Adds project root to Python path for imports.
"""

import sys
from pathlib import Path

# Add project root to Python path
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))