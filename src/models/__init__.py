# src/models/__init__.py
"""
NEX Genesis Models Package
Python dataclasses pre všetky NEX Genesis tabuľky

Usage:
    from src.models import BarcodeRecord, GSCATRecord, PABRecord

    # Deserialize from Btrieve bytes
    barcode = BarcodeRecord.from_bytes(raw_data)

    # Create new record
    product = GSCATRecord(
        gs_code=123,
        gs_name="Test Product",
        price_sell=Decimal("99.99")
    )

    # Serialize to Btrieve bytes
    raw_data = product.to_bytes()
"""

from .barcode import BarcodeRecord
from .gscat import GSCATRecord
from .pab import PABRecord
from .mglst import MGLSTRecord
from .tsh import TSHRecord
from .tsi import TSIRecord

__all__ = [
    'BarcodeRecord',
    'GSCATRecord',
    'PABRecord',
    'MGLSTRecord',
    'TSHRecord',
    'TSIRecord',
]

__version__ = '1.0.0'