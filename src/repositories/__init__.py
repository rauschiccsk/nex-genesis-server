"""
NEX Genesis Repositories Package
High-level API combining BtrieveClient + Models

Usage:
    from src.repositories import BarcodeRepository, GSCATRepository, PABRepository

    # Using context manager (recommended)
    with GSCATRepository() as repo:
        product = repo.find_by_gs_code(123)
        print(product.gs_name)

    # Manual open/close
    repo = BarcodeRepository()
    repo.open()
    barcode = repo.find_by_barcode("8594000123456")
    repo.close()
"""

from .base_repository import BaseRepository, ReadOnlyRepository, CRUDRepository
from .barcode_repository import BarcodeRepository
from .gscat_repository import GSCATRepository
from .pab_repository import PABRepository

__all__ = [
    # Base classes
    'BaseRepository',
    'ReadOnlyRepository',
    'CRUDRepository',

    # Concrete repositories
    'BarcodeRepository',
    'GSCATRepository',
    'PABRepository',
]

__version__ = '1.0.0'