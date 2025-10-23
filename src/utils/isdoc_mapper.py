# -*- coding: utf-8 -*-
"""
NEX Genesis Server - ISDOC to NEX Mapper
Maps ISDOC/InvoiceData to NEX Genesis database structures

Usage:
    from utils.isdoc_mapper import ISDOCToNEXMapper

    mapper = ISDOCToNEXMapper()
    pab_supplier = mapper.map_supplier_to_pab(invoice_data)
    gscat_items = mapper.map_items_to_gscat(invoice_data.items)
    tsh = mapper.map_to_tsh(invoice_data)
    tsi_items = mapper.map_items_to_tsi(invoice_data.items, tsh_id)
"""

import logging
from datetime import datetime
from decimal import Decimal
from typing import List, Optional, Dict, Any
from dataclasses import dataclass

logger = logging.getLogger(__name__)


# ============================================================================
# ISDOC Data Models (simplified from supplier_invoice_loader)
# ============================================================================

@dataclass
class InvoiceItem:
    """Jedna položka na faktúre - z ISDOC/PDF"""
    line_number: int
    item_code: str = ""
    ean_code: str = ""
    description: str = ""
    quantity: Optional[Decimal] = None
    unit: str = ""
    unit_price_no_vat: Optional[Decimal] = None
    unit_price_with_vat: Optional[Decimal] = None
    total_with_vat: Optional[Decimal] = None
    vat_rate: Optional[Decimal] = None
    discount_percent: Optional[Decimal] = None


@dataclass
class InvoiceData:
    """Kompletné dáta z faktúry - z ISDOC/PDF"""
    # Hlavička
    invoice_number: str = ""
    issue_date: str = ""
    due_date: str = ""
    tax_point_date: str = ""

    # Sumy
    total_amount: Optional[Decimal] = None
    tax_amount: Optional[Decimal] = None
    net_amount: Optional[Decimal] = None
    currency: str = "EUR"

    # Dodávateľ
    supplier_name: str = ""
    supplier_ico: str = ""
    supplier_dic: str = ""
    supplier_icdph: str = ""
    supplier_address: str = ""

    # Odberateľ
    customer_name: str = ""
    customer_ico: str = ""
    customer_dic: str = ""
    customer_icdph: str = ""
    customer_address: str = ""

    # Bankové údaje
    bank_name: str = ""
    iban: str = ""
    bic: str = ""
    variable_symbol: str = ""
    constant_symbol: str = ""

    # Položky
    items: List[InvoiceItem] = None

    def __post_init__(self):
        if self.items is None:
            self.items = []


# ============================================================================
# NEX Genesis Mapped Data (simplified structures for mapping)
# ============================================================================

@dataclass
class NEXPABData:
    """PAB (Obchodní partneri) mapped data"""
    IC: str  # IČO - 8 znakov
    Nazov: str  # Názov partnera - 60 znakov
    DIC: str = ""  # DIČ - 10 znakov
    ICDPH: str = ""  # IČ DPH - 12 znakov (SKxxxxxxxxxx)
    Ulica: str = ""  # Adresa - 40 znakov
    Mesto: str = ""  # Mesto - 40 znakov
    PSC: str = ""  # PSČ - 10 znakov
    Stat: str = "SK"  # Štát - 3 znaky
    Telefon: str = ""  # Telefón - 20 znakov
    Email: str = ""  # Email - 50 znakov


@dataclass
class NEXGSCATData:
    """GSCAT (Produktový katalóg) mapped data"""
    GsCode: int  # Kód produktu - integer
    Nazov: str  # Názov produktu - 20 znakov (Pascal string!)
    Ean: str = ""  # EAN - 13 znakov
    Cena: Optional[Decimal] = None  # Cena - float
    Mj: str = "KS"  # Merná jednotka - 3 znaky
    # Množstvo ďalších polí v GSCAT, ale pre základný import stačia tieto


@dataclass
class NEXBARCODEData:
    """BARCODE (Čiarové kódy) mapped data"""
    GsCode: int  # Kód produktu - integer
    Ean: str  # EAN - 13 znakov


@dataclass
class NEXTSHData:
    """TSH (Dodacie listy header) mapped data"""
    CisloDokladu: str  # Číslo dokladu
    Datum: str  # Dátum (DD.MM.YYYY)
    DatumSplatnosti: str = ""  # Dátum splatnosti
    DodavatelIC: str = ""  # IČO dodávateľa
    OdberatelIC: str = ""  # IČO odberateľa
    Celkom: Optional[Decimal] = None  # Celková suma
    CelkomSDPH: Optional[Decimal] = None  # Suma s DPH
    DPH: Optional[Decimal] = None  # DPH suma
    Mena: str = "EUR"  # Mena


@dataclass
class NEXTSIData:
    """TSI (Dodacie listy items) mapped data"""
    Por: int  # Poradové číslo
    GsCode: int  # Kód produktu
    Nazov: str  # Názov produktu
    Mnozstvo: Optional[Decimal] = None  # Množstvo
    Mj: str = "KS"  # Merná jednotka
    Cena: Optional[Decimal] = None  # Cena bez DPH
    CenaSDPH: Optional[Decimal] = None  # Cena s DPH
    CelkomSDPH: Optional[Decimal] = None  # Celkom s DPH
    SadzbaDPH: Optional[Decimal] = None  # Sadzba DPH (%)


# ============================================================================
# ISDOC to NEX Mapper
# ============================================================================

class ISDOCToNEXMapper:
    """
    Mapper pre konverziu ISDOC/InvoiceData → NEX Genesis štruktúry

    Usage:
        mapper = ISDOCToNEXMapper()

        # Map supplier/customer to PAB
        pab_supplier = mapper.map_supplier_to_pab(invoice_data)
        pab_customer = mapper.map_customer_to_pab(invoice_data)

        # Map items to GSCAT
        gscat_items = mapper.map_items_to_gscat(invoice_data.items)

        # Map to TSH/TSI
        tsh = mapper.map_to_tsh(invoice_data)
        tsi_items = mapper.map_items_to_tsi(invoice_data.items, tsh_id=1)
    """

    def __init__(self):
        self.logger = logging.getLogger(__name__)

    # ========================================================================
    # PAB Mapping (Obchodní partneri)
    # ========================================================================

    def map_supplier_to_pab(self, invoice_data: InvoiceData) -> NEXPABData:
        """
        Mapuje dodávateľa z ISDOC na PAB štruktúru

        Args:
            invoice_data: InvoiceData objekt

        Returns:
            NEXPABData pre dodávateľa
        """
        self.logger.info(f"Mapping supplier: {invoice_data.supplier_name}")

        # Parse address (zjednodušene)
        ulica, mesto, psc = self._parse_address(invoice_data.supplier_address)

        return NEXPABData(
            IC=self._format_ico(invoice_data.supplier_ico),
            Nazov=self._truncate(invoice_data.supplier_name, 60),
            DIC=self._format_dic(invoice_data.supplier_dic),
            ICDPH=self._format_icdph(invoice_data.supplier_icdph),
            Ulica=self._truncate(ulica, 40),
            Mesto=self._truncate(mesto, 40),
            PSC=self._truncate(psc, 10),
            Stat="SK"
        )

    def map_customer_to_pab(self, invoice_data: InvoiceData) -> NEXPABData:
        """
        Mapuje odberateľa z ISDOC na PAB štruktúru

        Args:
            invoice_data: InvoiceData objekt

        Returns:
            NEXPABData pre odberateľa
        """
        self.logger.info(f"Mapping customer: {invoice_data.customer_name}")

        ulica, mesto, psc = self._parse_address(invoice_data.customer_address)

        return NEXPABData(
            IC=self._format_ico(invoice_data.customer_ico),
            Nazov=self._truncate(invoice_data.customer_name, 60),
            DIC=self._format_dic(invoice_data.customer_dic),
            ICDPH=self._format_icdph(invoice_data.customer_icdph),
            Ulica=self._truncate(ulica, 40),
            Mesto=self._truncate(mesto, 40),
            PSC=self._truncate(psc, 10),
            Stat="SK"
        )

    # ========================================================================
    # GSCAT Mapping (Produkty)
    # ========================================================================

    def map_items_to_gscat(self, items: List[InvoiceItem]) -> List[NEXGSCATData]:
        """
        Mapuje položky faktúry na GSCAT štruktúru

        Args:
            items: List InvoiceItem objektov

        Returns:
            List NEXGSCATData
        """
        self.logger.info(f"Mapping {len(items)} items to GSCAT")

        gscat_items = []
        for item in items:
            if not item.item_code:
                self.logger.warning(f"Item {item.line_number} has no item_code, skipping")
                continue

            try:
                gscat = NEXGSCATData(
                    GsCode=int(item.item_code),
                    Nazov=self._truncate(item.description, 20),  # Pascal string limit
                    Ean=self._format_ean(item.ean_code),
                    Cena=item.unit_price_no_vat,
                    Mj=self._normalize_unit(item.unit)
                )
                gscat_items.append(gscat)
            except ValueError as e:
                self.logger.error(f"Error mapping item {item.line_number}: {e}")
                continue

        return gscat_items

    def map_items_to_barcode(self, items: List[InvoiceItem]) -> List[NEXBARCODEData]:
        """
        Mapuje položky s EAN kódmi na BARCODE štruktúru

        Args:
            items: List InvoiceItem objektov

        Returns:
            List NEXBARCODEData
        """
        self.logger.info(f"Mapping {len(items)} items to BARCODE")

        barcode_items = []
        for item in items:
            if not item.item_code or not item.ean_code:
                continue

            try:
                barcode = NEXBARCODEData(
                    GsCode=int(item.item_code),
                    Ean=self._format_ean(item.ean_code)
                )
                barcode_items.append(barcode)
            except ValueError:
                continue

        return barcode_items

    # ========================================================================
    # TSH Mapping (Delivery Header)
    # ========================================================================

    def map_to_tsh(self, invoice_data: InvoiceData) -> NEXTSHData:
        """
        Mapuje ISDOC header na TSH štruktúru

        Args:
            invoice_data: InvoiceData objekt

        Returns:
            NEXTSHData
        """
        self.logger.info(f"Mapping invoice {invoice_data.invoice_number} to TSH")

        return NEXTSHData(
            CisloDokladu=invoice_data.invoice_number,
            Datum=self._format_date_nex(invoice_data.issue_date),
            DatumSplatnosti=self._format_date_nex(invoice_data.due_date),
            DodavatelIC=self._format_ico(invoice_data.supplier_ico),
            OdberatelIC=self._format_ico(invoice_data.customer_ico),
            Celkom=invoice_data.net_amount,
            CelkomSDPH=invoice_data.total_amount,
            DPH=invoice_data.tax_amount,
            Mena=invoice_data.currency
        )

    # ========================================================================
    # TSI Mapping (Delivery Items)
    # ========================================================================

    def map_items_to_tsi(self, items: List[InvoiceItem], tsh_id: int = 1) -> List[NEXTSIData]:
        """
        Mapuje položky faktúry na TSI štruktúru

        Args:
            items: List InvoiceItem objektov
            tsh_id: ID TSH záznamu (pre referenciu)

        Returns:
            List NEXTSIData
        """
        self.logger.info(f"Mapping {len(items)} items to TSI")

        tsi_items = []
        for item in items:
            if not item.item_code:
                continue

            try:
                tsi = NEXTSIData(
                    Por=item.line_number,
                    GsCode=int(item.item_code),
                    Nazov=self._truncate(item.description, 40),
                    Mnozstvo=item.quantity,
                    Mj=self._normalize_unit(item.unit),
                    Cena=item.unit_price_no_vat,
                    CenaSDPH=item.unit_price_with_vat,
                    CelkomSDPH=item.total_with_vat,
                    SadzbaDPH=item.vat_rate
                )
                tsi_items.append(tsi)
            except ValueError as e:
                self.logger.error(f"Error mapping item {item.line_number} to TSI: {e}")
                continue

        return tsi_items

    # ========================================================================
    # Helper Methods
    # ========================================================================

    def _parse_address(self, address: str) -> tuple:
        """
        Parsuje adresu na komponenty

        Args:
            address: Celá adresa ako string

        Returns:
            (ulica, mesto, psc) tuple
        """
        if not address:
            return "", "", ""

        # Zjednodušený parser - rozdelí na čiarku
        parts = [p.strip() for p in address.split(",")]

        ulica = parts[0] if len(parts) > 0 else ""
        mesto = parts[1] if len(parts) > 1 else ""
        psc = parts[2] if len(parts) > 2 else ""

        return ulica, mesto, psc

    def _format_ico(self, ico: str) -> str:
        """Formátuje IČO na 8 znakov"""
        if not ico:
            return ""
        return ico.strip().zfill(8)[:8]

    def _format_dic(self, dic: str) -> str:
        """Formátuje DIČ na 10 znakov"""
        if not dic:
            return ""
        return dic.strip().zfill(10)[:10]

    def _format_icdph(self, icdph: str) -> str:
        """Formátuje IČ DPH na SKxxxxxxxxxx formát"""
        if not icdph:
            return ""

        # Odstráň medzery a prefix SK
        clean = icdph.replace(" ", "").upper()
        if not clean.startswith("SK"):
            clean = "SK" + clean

        return clean[:12]

    def _format_ean(self, ean: str) -> str:
        """Formátuje EAN na 13 znakov"""
        if not ean:
            return ""
        return ean.strip()[:13]

    def _normalize_unit(self, unit: str) -> str:
        """Normalizuje mernú jednotku"""
        if not unit:
            return "KS"

        # Mapping bežných jednotiek
        unit_map = {
            "KS": "KS",
            "L": "L",
            "M": "M",
            "KG": "KG",
            "M2": "M2",
            "M3": "M3"
        }

        return unit_map.get(unit.upper(), "KS")

    def _format_date_nex(self, date_str: str) -> str:
        """
        Konvertuje dátum na NEX formát (DD.MM.YYYY)

        Args:
            date_str: Dátum v rôznych formátoch

        Returns:
            Dátum vo formáte DD.MM.YYYY
        """
        if not date_str:
            return ""

        # Už je v správnom formáte
        if "." in date_str and len(date_str) == 10:
            return date_str

        # ISO formát YYYY-MM-DD
        if "-" in date_str:
            try:
                dt = datetime.strptime(date_str, "%Y-%m-%d")
                return dt.strftime("%d.%m.%Y")
            except:
                pass

        return date_str

    def _truncate(self, text: str, max_len: int) -> str:
        """Skráti text na max_len znakov"""
        if not text:
            return ""
        return text[:max_len]

    # ========================================================================
    # Complete Mapping (all-in-one)
    # ========================================================================


def map_invoice_complete(self, invoice_data: dict) -> Dict[str, Any]:
    """
    Kompletný mapping celej faktúry na všetky NEX štruktúry
    Args:
        invoice_data: Dict s ISDOC dátami (z API request)
    Returns:
        Dict so všetkými namapovanými dátami:
        {
            'supplier': NEXPABData,
            'customer': NEXPABData,
            'products': List[NEXGSCATData],
            'barcodes': List[NEXBARCODEData],
            'delivery_header': NEXTSHData,
            'delivery_items': List[NEXTSIData]
        }
    """
    invoice_number = invoice_data.get('invoice_number', 'N/A')
    self.logger.info(f"Complete mapping for invoice: {invoice_number}")

    items = invoice_data.get('items', [])

    return {
        'supplier': self.map_supplier_to_pab(invoice_data),
        'customer': self.map_customer_to_pab(invoice_data),
        'products': self.map_items_to_gscat(items),
        'barcodes': self.map_items_to_barcode(items),
        'delivery_header': self.map_to_tsh(invoice_data),
        'delivery_items': self.map_items_to_tsi(items)
    }

# ============================================================================
# Convenience Functions
# ============================================================================

def map_isdoc_to_nex(invoice_data: InvoiceData) -> Dict[str, Any]:
    """
    Convenience funkcia pre kompletný mapping

    Usage:
        from utils.isdoc_mapper import map_isdoc_to_nex

        mapped = map_isdoc_to_nex(invoice_data)
        supplier = mapped['supplier']
        products = mapped['products']
    """
    mapper = ISDOCToNEXMapper()
    return mapper.map_invoice_complete(invoice_data)