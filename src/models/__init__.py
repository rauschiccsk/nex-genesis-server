# src/models/__init__.py
"""
NEX Genesis Database Models

Python dataclasses pre všetky NEX Genesis tabuľky.
Poskytujú type-safe prístup k Btrieve databázovým záznamom.

Available Models:
- GSCATRecord: Produktový katalóg (GSCAT.BTR)

Usage:
    from src.models import GSCATRecord, parse_gscat_record

    # Parse raw Btrieve bytes
    record = parse_gscat_record(raw_bytes)

    # Create new record
    record = GSCATRecord(
        GsCode=123,
        GsName="Test Product",
        MglstCode=1
    )
"""

from .gscat import (
    GSCATRecord,
    GSCAT_FIELD_MAP,
    parse_gscat_record,
    create_gscat_record,
)

__all__ = [
    # GSCAT
    'GSCATRecord',
    'GSCAT_FIELD_MAP',
    'parse_gscat_record',
    'create_gscat_record',

    # TODO: Add more models
    # 'PABRecord',
    # 'BARCODERecord',
    # 'MGLSTRecord',
    # 'TSHRecord',
    # 'TSIRecord',
]

__version__ = '0.1.0'