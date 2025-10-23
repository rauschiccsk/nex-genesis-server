# -*- coding: utf-8 -*-
"""
Unit tests for ISDOC to NEX mapper

Run:
    pytest tests/test_isdoc_mapper.py -v
"""

import pytest
from decimal import Decimal
from datetime import datetime

# Import mapper and data models
import sys

sys.path.insert(0, 'src')

from utils.isdoc_mapper import (
    ISDOCToNEXMapper,
    InvoiceData,
    InvoiceItem,
    NEXPABData,
    NEXGSCATData,
    NEXBARCODEData,
    NEXTSHData,
    NEXTSIData
)


# ============================================================================
# Fixtures
# ============================================================================

@pytest.fixture
def sample_invoice_data():
    """Sample InvoiceData for testing"""
    return InvoiceData(
        invoice_number="2025001",
        issue_date="16.09.2025",
        due_date="30.09.2025",
        tax_point_date="16.09.2025",
        total_amount=Decimal("123.45"),
        tax_amount=Decimal("23.45"),
        net_amount=Decimal("100.00"),
        currency="EUR",
        supplier_name="L & Š, s.r.o.",
        supplier_ico="12345678",
        supplier_dic="1234567890",
        supplier_icdph="SK1234567890",
        supplier_address="Hlavná 123, Bratislava, 81101",
        customer_name="MÁGERSTAV, spol. s r.o.",
        customer_ico="31436871",
        customer_dic="2020367151",
        customer_icdph="SK2020367151",
        customer_address="Továrenská 1, Komárno, 94501",
        bank_name="VÚB banka",
        iban="SK1234567890123456789012",
        bic="SUBASKBX",
        variable_symbol="20250001",
        constant_symbol="0308",
        items=[
            InvoiceItem(
                line_number=1,
                item_code="293495",
                ean_code="8590000000001",
                description="Akcia KO",
                quantity=Decimal("3.0"),
                unit="KS",
                unit_price_no_vat=Decimal("0.010"),
                unit_price_with_vat=Decimal("0.012"),
                total_with_vat=Decimal("0.037"),
                vat_rate=Decimal("23.0")
            ),
            InvoiceItem(
                line_number=2,
                item_code="123456",
                ean_code="8590000000002",
                description="Test produkt s veľmi dlhým názvom ktorý presahuje limit",
                quantity=Decimal("5.0"),
                unit="L",
                unit_price_no_vat=Decimal("10.00"),
                unit_price_with_vat=Decimal("12.30"),
                total_with_vat=Decimal("61.50"),
                vat_rate=Decimal("23.0")
            )
        ]
    )


@pytest.fixture
def mapper():
    """ISDOC Mapper instance"""
    return ISDOCToNEXMapper()


# ============================================================================
# PAB Mapping Tests
# ============================================================================

def test_map_supplier_to_pab(mapper, sample_invoice_data):
    """Test mapping dodávateľa na PAB"""
    pab = mapper.map_supplier_to_pab(sample_invoice_data)

    assert isinstance(pab, NEXPABData)
    assert pab.IC == "12345678"
    assert pab.Nazov == "L & Š, s.r.o."
    assert pab.DIC == "1234567890"
    assert pab.ICDPH == "SK1234567890"
    assert pab.Ulica == "Hlavná 123"
    assert pab.Mesto == "Bratislava"
    assert pab.PSC == "81101"
    assert pab.Stat == "SK"


def test_map_customer_to_pab(mapper, sample_invoice_data):
    """Test mapping odberateľa na PAB"""
    pab = mapper.map_customer_to_pab(sample_invoice_data)

    assert isinstance(pab, NEXPABData)
    assert pab.IC == "31436871"
    assert pab.Nazov == "MÁGERSTAV, spol. s r.o."
    assert pab.DIC == "2020367151"
    assert pab.ICDPH == "SK2020367151"
    assert pab.Ulica == "Továrenská 1"
    assert pab.Mesto == "Komárno"
    assert pab.PSC == "94501"


def test_format_ico(mapper):
    """Test IČO formátovania"""
    assert mapper._format_ico("123456") == "00123456"
    assert mapper._format_ico("12345678") == "12345678"
    assert mapper._format_ico("") == ""
    assert mapper._format_ico("123456789") == "12345678"  # Truncate


def test_format_dic(mapper):
    """Test DIČ formátovania"""
    assert mapper._format_dic("123456789") == "0123456789"
    assert mapper._format_dic("1234567890") == "1234567890"
    assert mapper._format_dic("") == ""


def test_format_icdph(mapper):
    """Test IČ DPH formátovania"""
    assert mapper._format_icdph("SK1234567890") == "SK1234567890"
    assert mapper._format_icdph("1234567890") == "SK1234567890"
    assert mapper._format_icdph("SK 1234567890") == "SK1234567890"
    assert mapper._format_icdph("") == ""


def test_parse_address(mapper):
    """Test address parsing"""
    ulica, mesto, psc = mapper._parse_address("Hlavná 123, Bratislava, 81101")
    assert ulica == "Hlavná 123"
    assert mesto == "Bratislava"
    assert psc == "81101"

    # Empty address
    ulica, mesto, psc = mapper._parse_address("")
    assert ulica == ""
    assert mesto == ""
    assert psc == ""

    # Partial address
    ulica, mesto, psc = mapper._parse_address("Hlavná 123")
    assert ulica == "Hlavná 123"
    assert mesto == ""
    assert psc == ""


# ============================================================================
# GSCAT Mapping Tests
# ============================================================================

def test_map_items_to_gscat(mapper, sample_invoice_data):
    """Test mapping položiek na GSCAT"""
    gscat_items = mapper.map_items_to_gscat(sample_invoice_data.items)

    assert len(gscat_items) == 2

    # First item
    item1 = gscat_items[0]
    assert isinstance(item1, NEXGSCATData)
    assert item1.GsCode == 293495
    assert item1.Nazov == "Akcia KO"
    assert item1.Ean == "8590000000001"
    assert item1.Cena == Decimal("0.010")
    assert item1.Mj == "KS"

    # Second item (long description should be truncated)
    item2 = gscat_items[1]
    assert item2.GsCode == 123456
    assert len(item2.Nazov) <= 20
    assert item2.Mj == "L"


def test_map_items_to_gscat_skip_invalid(mapper):
    """Test že mapper preskočí položky bez item_code"""
    items = [
        InvoiceItem(line_number=1, item_code="", description="No code"),
        InvoiceItem(line_number=2, item_code="123", description="Valid")
    ]

    gscat_items = mapper.map_items_to_gscat(items)
    assert len(gscat_items) == 1
    assert gscat_items[0].GsCode == 123


def test_map_items_to_barcode(mapper, sample_invoice_data):
    """Test mapping EAN kódov na BARCODE"""
    barcode_items = mapper.map_items_to_barcode(sample_invoice_data.items)

    assert len(barcode_items) == 2

    item1 = barcode_items[0]
    assert isinstance(item1, NEXBARCODEData)
    assert item1.GsCode == 293495
    assert item1.Ean == "8590000000001"


def test_format_ean(mapper):
    """Test EAN formátovania"""
    assert mapper._format_ean("8590000000001") == "8590000000001"
    assert mapper._format_ean("85900000000012345") == "8590000000001"  # Truncate
    assert mapper._format_ean("") == ""


def test_normalize_unit(mapper):
    """Test normalizácie merných jednotiek"""
    assert mapper._normalize_unit("KS") == "KS"
    assert mapper._normalize_unit("ks") == "KS"
    assert mapper._normalize_unit("L") == "L"
    assert mapper._normalize_unit("M") == "M"
    assert mapper._normalize_unit("KG") == "KG"
    assert mapper._normalize_unit("") == "KS"  # Default
    assert mapper._normalize_unit("XYZ") == "KS"  # Unknown → default


# ============================================================================
# TSH Mapping Tests
# ============================================================================

def test_map_to_tsh(mapper, sample_invoice_data):
    """Test mapping na TSH (delivery header)"""
    tsh = mapper.map_to_tsh(sample_invoice_data)

    assert isinstance(tsh, NEXTSHData)
    assert tsh.CisloDokladu == "2025001"
    assert tsh.Datum == "16.09.2025"
    assert tsh.DatumSplatnosti == "30.09.2025"
    assert tsh.DodavatelIC == "12345678"
    assert tsh.OdberatelIC == "31436871"
    assert tsh.Celkom == Decimal("100.00")
    assert tsh.CelkomSDPH == Decimal("123.45")
    assert tsh.DPH == Decimal("23.45")
    assert tsh.Mena == "EUR"


def test_format_date_nex(mapper):
    """Test date formátovania na NEX formát"""
    # Already in NEX format
    assert mapper._format_date_nex("16.09.2025") == "16.09.2025"

    # ISO format conversion
    assert mapper._format_date_nex("2025-09-16") == "16.09.2025"

    # Empty date
    assert mapper._format_date_nex("") == ""


# ============================================================================
# TSI Mapping Tests
# ============================================================================

def test_map_items_to_tsi(mapper, sample_invoice_data):
    """Test mapping položiek na TSI (delivery items)"""
    tsi_items = mapper.map_items_to_tsi(sample_invoice_data.items, tsh_id=1)

    assert len(tsi_items) == 2

    # First item
    item1 = tsi_items[0]
    assert isinstance(item1, NEXTSIData)
    assert item1.Por == 1
    assert item1.GsCode == 293495
    assert item1.Nazov == "Akcia KO"
    assert item1.Mnozstvo == Decimal("3.0")
    assert item1.Mj == "KS"
    assert item1.Cena == Decimal("0.010")
    assert item1.CenaSDPH == Decimal("0.012")
    assert item1.CelkomSDPH == Decimal("0.037")
    assert item1.SadzbaDPH == Decimal("23.0")

    # Second item
    item2 = tsi_items[1]
    assert item2.Por == 2
    assert item2.GsCode == 123456
    assert len(item2.Nazov) <= 40  # TSI has 40 char limit


# ============================================================================
# Complete Mapping Tests
# ============================================================================

def test_complete_mapping(mapper, sample_invoice_data):
    """Test kompletného mappingu"""
    mapped = mapper.map_invoice_complete(sample_invoice_data)

    # Check all components present
    assert 'supplier' in mapped
    assert 'customer' in mapped
    assert 'products' in mapped
    assert 'barcodes' in mapped
    assert 'delivery_header' in mapped
    assert 'delivery_items' in mapped

    # Verify types
    assert isinstance(mapped['supplier'], NEXPABData)
    assert isinstance(mapped['customer'], NEXPABData)
    assert isinstance(mapped['products'], list)
    assert isinstance(mapped['barcodes'], list)
    assert isinstance(mapped['delivery_header'], NEXTSHData)
    assert isinstance(mapped['delivery_items'], list)

    # Verify counts
    assert len(mapped['products']) == 2
    assert len(mapped['barcodes']) == 2
    assert len(mapped['delivery_items']) == 2


# ============================================================================
# Edge Cases Tests
# ============================================================================

def test_truncate(mapper):
    """Test truncation"""
    assert mapper._truncate("Short", 10) == "Short"
    assert mapper._truncate("Very long text", 5) == "Very "
    assert mapper._truncate("", 10) == ""
    assert mapper._truncate("Exact", 5) == "Exact"


def test_pascal_string_limit():
    """Test že názov je správne skrátený pre Pascal string"""
    mapper = ISDOCToNEXMapper()

    # GSCAT Nazov limit je 20 znakov (Pascal string)
    long_text = "Very long product name that exceeds limit"
    item = InvoiceItem(
        line_number=1,
        item_code="123",
        description=long_text,
        quantity=Decimal("1.0")
    )

    gscat_items = mapper.map_items_to_gscat([item])
    assert len(gscat_items[0].Nazov) <= 20


def test_empty_invoice_items():
    """Test mapping prázdneho zoznamu položiek"""
    mapper = ISDOCToNEXMapper()
    invoice_data = InvoiceData(
        invoice_number="TEST001",
        supplier_ico="12345678",
        customer_ico="87654321",
        items=[]
    )

    products = mapper.map_items_to_gscat(invoice_data.items)
    barcodes = mapper.map_items_to_barcode(invoice_data.items)
    tsi_items = mapper.map_items_to_tsi(invoice_data.items)

    assert products == []
    assert barcodes == []
    assert tsi_items == []


def test_missing_optional_fields():
    """Test mapping s chýbajúcimi optional fields"""
    mapper = ISDOCToNEXMapper()
    invoice_data = InvoiceData(
        invoice_number="TEST001",
        supplier_ico="12345678",
        supplier_name="Test Supplier",
        customer_ico="87654321",
        customer_name="Test Customer"
        # Missing: addresses, dic, icdph, dates, amounts, etc.
    )

    # Should not crash
    supplier = mapper.map_supplier_to_pab(invoice_data)
    customer = mapper.map_customer_to_pab(invoice_data)
    tsh = mapper.map_to_tsh(invoice_data)

    # Verify defaults
    assert supplier.IC == "12345678"
    assert supplier.DIC == ""
    assert supplier.ICDPH == ""
    assert supplier.Ulica == ""


def test_decimal_none_handling():
    """Test handling None values v Decimal fields"""
    mapper = ISDOCToNEXMapper()
    invoice_data = InvoiceData(
        invoice_number="TEST001",
        supplier_ico="12345678",
        customer_ico="87654321",
        total_amount=None,
        tax_amount=None,
        net_amount=None
    )

    tsh = mapper.map_to_tsh(invoice_data)
    assert tsh.Celkom is None
    assert tsh.CelkomSDPH is None
    assert tsh.DPH is None


# ============================================================================
# Integration-style Tests
# ============================================================================

def test_realistic_invoice_scenario(mapper):
    """Test realistického scenára s L&Š faktúrou"""
    # Simuluje reálnu L&Š faktúru
    invoice_data = InvoiceData(
        invoice_number="FA2025123",
        issue_date="16.09.2025",
        due_date="30.09.2025",
        total_amount=Decimal("246.90"),
        tax_amount=Decimal("46.90"),
        net_amount=Decimal("200.00"),
        currency="EUR",
        supplier_name="L & Š, s.r.o.",
        supplier_ico="12345678",
        supplier_dic="1234567890",
        supplier_icdph="SK1234567890",
        supplier_address="Priemyselná 5, Košice, 04001",
        customer_name="MÁGERSTAV, spol. s r.o.",
        customer_ico="31436871",
        customer_dic="2020367151",
        customer_icdph="SK2020367151",
        customer_address="Továrenská 1, Komárno, 94501",
        variable_symbol="20251230001",
        items=[
            InvoiceItem(
                line_number=1,
                item_code="293495",
                ean_code="8590000000001",
                description="Akcia KO",
                quantity=Decimal("10.0"),
                unit="KS",
                unit_price_no_vat=Decimal("10.00"),
                unit_price_with_vat=Decimal("12.30"),
                total_with_vat=Decimal("123.00"),
                vat_rate=Decimal("23.0")
            ),
            InvoiceItem(
                line_number=2,
                item_code="123456",
                ean_code="8590000000002",
                description="Test produkt 2",
                quantity=Decimal("10.0"),
                unit="KS",
                unit_price_no_vat=Decimal("10.00"),
                unit_price_with_vat=Decimal("12.30"),
                total_with_vat=Decimal("123.00"),
                vat_rate=Decimal("23.0")
            )
        ]
    )

    # Complete mapping
    mapped = mapper.map_invoice_complete(invoice_data)

    # Verify all components
    assert mapped['supplier'].IC == "12345678"
    assert mapped['customer'].IC == "31436871"
    assert len(mapped['products']) == 2
    assert len(mapped['delivery_items']) == 2

    # Verify sums match
    tsh = mapped['delivery_header']
    assert tsh.CelkomSDPH == Decimal("246.90")
    assert tsh.Celkom == Decimal("200.00")
    assert tsh.DPH == Decimal("46.90")


if __name__ == "__main__":
    pytest.main([__file__, "-v"])