"""
NEX Genesis Btrieve Bridge API - Invoice Models

Pydantic modely pre ISDOC import endpoint.
"""

from enum import Enum
from typing import List, Optional, Dict, Any
from datetime import date
from decimal import Decimal

from pydantic import BaseModel, Field


class ImportStatus(str, Enum):
    """Status import operácie."""
    SUCCESS = "success"
    PARTIAL = "partial"
    FAILED = "failed"


class ValidationError(BaseModel):
    """Validačná chyba pri importe."""
    field: str = Field(..., description="Názov poľa s chybou")
    message: str = Field(..., description="Chybová správa")
    value: Optional[Any] = Field(None, description="Nevalidná hodnota")


# ISDOC Request Models (zjednodušené - podľa ISDOC štandardu)
class ISDOCParty(BaseModel):
    """Obchodný partner (dodávateľ/odberateľ)."""
    name: str
    ico: Optional[str] = None
    dic: Optional[str] = None
    ic_dph: Optional[str] = None
    street: Optional[str] = None
    city: Optional[str] = None
    zip: Optional[str] = None
    country: Optional[str] = "SK"


class ISDOCItem(BaseModel):
    """Položka faktúry."""
    line_number: int
    item_code: Optional[str] = None
    item_name: str
    quantity: Decimal
    unit: str = "KS"
    unit_price: Decimal
    vat_rate: Decimal = Field(..., description="DPH sadzba (napr. 20.0)")
    line_total: Decimal
    ean: Optional[str] = None


class ISDOCImportRequest(BaseModel):
    """
    Request pre import ISDOC faktúry do NEX Genesis.

    Tento model reprezentuje zjednodušenú ISDOC štruktúru.
    Supplier Invoice Loader pošle tento JSON po spracovaní PDF/XML.
    """

    # Invoice header
    invoice_number: str = Field(..., description="Číslo faktúry")
    invoice_date: date = Field(..., description="Dátum vystavenia")
    due_date: Optional[date] = Field(None, description="Dátum splatnosti")
    tax_point_date: Optional[date] = Field(None, description="Dátum zdaniteľného plnenia")

    # Parties
    supplier: ISDOCParty = Field(..., description="Dodávateľ")
    customer: ISDOCParty = Field(..., description="Odberateľ")

    # Items
    items: List[ISDOCItem] = Field(..., description="Položky faktúry", min_length=1)

    # Totals
    total_amount: Decimal = Field(..., description="Celková suma s DPH")
    total_vat: Decimal = Field(..., description="Celková suma DPH")
    total_without_vat: Decimal = Field(..., description="Celková suma bez DPH")

    # Optional metadata
    variable_symbol: Optional[str] = None
    constant_symbol: Optional[str] = None
    note: Optional[str] = None

    class Config:
        json_schema_extra = {
            "example": {
                "invoice_number": "2025001234",
                "invoice_date": "2025-10-23",
                "due_date": "2025-11-23",
                "tax_point_date": "2025-10-23",
                "supplier": {
                    "name": "L&Š PLUS s.r.o.",
                    "ico": "36531928",
                    "dic": "2021891916",
                    "ic_dph": "SK2021891916",
                    "street": "Továrenská 5",
                    "city": "Bratislava",
                    "zip": "82109",
                    "country": "SK"
                },
                "customer": {
                    "name": "MAGERSTAV spol. s r.o.",
                    "ico": "31411711",
                    "dic": "2020367151",
                    "ic_dph": "SK2020367151",
                    "street": "Priemyselná 1",
                    "city": "Komárno",
                    "zip": "94501",
                    "country": "SK"
                },
                "items": [
                    {
                        "line_number": 1,
                        "item_code": "12345",
                        "item_name": "Cement Portland 42,5 R",
                        "quantity": 10.0,
                        "unit": "KS",
                        "unit_price": 25.50,
                        "vat_rate": 20.0,
                        "line_total": 255.0,
                        "ean": "8590000123456"
                    }
                ],
                "total_amount": 306.0,
                "total_vat": 51.0,
                "total_without_vat": 255.0,
                "variable_symbol": "2025001234",
                "note": "Testovacia faktúra"
            }
        }


class ISDOCImportResponse(BaseModel):
    """
    Response z import operácie.

    Vráti status importu a zoznam vytvorených/updatnutých záznamov.
    """

    status: ImportStatus = Field(..., description="Status importu")
    message: str = Field(..., description="Hlavná správa")

    # Import statistics
    supplier_created: bool = Field(..., description="Dodávateľ vytvorený (True) alebo existujúci (False)")
    customer_created: bool = Field(..., description="Odberateľ vytvorený (True) alebo existujúci (False)")
    products_created: int = Field(..., description="Počet nových produktov")
    products_updated: int = Field(..., description="Počet updatnutých produktov")
    barcodes_created: int = Field(..., description="Počet nových čiarových kódov")
    delivery_created: bool = Field(..., description="Dodací list vytvorený")

    # Details
    supplier_ico: Optional[str] = Field(None, description="IČO dodávateľa")
    customer_ico: Optional[str] = Field(None, description="IČO odberateľa")
    product_codes: List[str] = Field(default_factory=list, description="Kódy spracovaných produktov")
    delivery_number: Optional[str] = Field(None, description="Číslo dodacieho listu (TSH)")

    # Errors and warnings
    errors: List[ValidationError] = Field(default_factory=list, description="Chyby pri importe")
    warnings: List[str] = Field(default_factory=list, description="Varovania")

    class Config:
        json_schema_extra = {
            "example": {
                "status": "success",
                "message": "Invoice imported successfully",
                "supplier_created": False,
                "customer_created": False,
                "products_created": 0,
                "products_updated": 1,
                "barcodes_created": 0,
                "delivery_created": True,
                "supplier_ico": "36531928",
                "customer_ico": "31411711",
                "product_codes": ["12345"],
                "delivery_number": "DL2025001234",
                "errors": [],
                "warnings": [
                    "Product 12345 already exists, updated price"
                ]
            }
        }