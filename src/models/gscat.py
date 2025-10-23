# src/models/gscat.py
"""
GSCAT - Produktový katalóg (Product Catalog)

Table: GSCAT.BTR
Location: C:\\NEX\\YEARACT\\STORES\\GSCAT.BTR
Definition: C:\\NEX\\YEARACT\\DBIDEF\\gscat.bdf
Record Size: 705 bytes

Description:
Master produktový katalóg NEX Genesis ERP systému.
Obsahuje všetky produkty, ich vlastnosti, ceny a väzby na tovarové skupiny.
"""

from dataclasses import dataclass, field
from typing import Optional
from datetime import datetime
from decimal import Decimal


@dataclass
class GSCATRecord:
    """
    GSCAT - Produktový katalóg record

    Primary Key: GsCode (INT32)

    Field Groups:
    - Identifikácia: GsCode, GsEAN, GsCatalog
    - Názvy: GsName, _GsName (search field)
    - Klasifikácia: MglstCode (FK), FgCode
    - Ceny: GsPrice, GsVatRate, GsPurchasePrice
    - Merné jednotky: GsUnit, GsUnitName, MsuQnt, MsuName
    - Fyzikálne vlastnosti: Volume, Weight
    - Vlastnosti: GsType, PackGs, SbcCnt
    - Sledovanie: DrbMust, PdnMust, GrcMth
    - Sklad: GsStock, GsMinStock, GsMaxStock
    - Audit: ModUser, ModDate, ModTime

    Note: Pascal strings (length-prefixed) used throughout
    """

    # === IDENTIFIKÁCIA ===
    GsCode: int = 0
    """Kód produktu (Primary Key, INT32)"""

    GsEAN: str = ""
    """EAN čiarový kód (13-15 znakov)"""

    GsCatalog: str = ""
    """Katalógové číslo dodávateľa"""

    # === NÁZVY ===
    GsName: str = ""
    """Názov produktu (primárny, max 80 znakov)"""

    GsName2: str = ""
    """Názov produktu (sekundárny, max 80 znakov)"""

    GsDescription: str = ""
    """Popis produktu (dlhší text)"""

    # === KLASIFIKÁCIA ===
    MglstCode: int = 0
    """Kód tovarovej skupiny (FK -> MGLST.BTR) - MgCode v BDF"""

    FgCode: int = 0
    """Kód finančnej skupiny"""

    # === CENY ===
    GsPrice: Decimal = Decimal('0.00')
    """Predajná cena bez DPH (FLOAT64)"""

    GsVatRate: Decimal = Decimal('20.00')
    """DPH sadzba v % (napr. 20.00 = 20%)"""

    GsPurchasePrice: Decimal = Decimal('0.00')
    """Nákupná cena (FLOAT64)"""

    # === MERNÉ JEDNOTKY ===
    GsUnit: int = 0
    """Kód mernej jednotky (INT32)"""

    GsUnitName: str = "ks"
    """Názov mernej jednotky (MsName v BDF: 'ks', 'kg', 'l', 'm')"""

    Volume: Decimal = Decimal('0.00')
    """Objem tovaru - množstvo MJ na 1 m3 (FLOAT64)"""

    Weight: Decimal = Decimal('0.00')
    """Váha tovaru - váha jednej MJ (FLOAT64)"""

    MsuQnt: Decimal = Decimal('0.00')
    """Množstvo tovaru v základnej jednotke (FLOAT64)"""

    MsuName: str = ""
    """Názov základnej jednotky (kg, m, l, m2, m3)"""

    # === VLASTNOSTI TOVARU ===
    GsType: str = "T"
    """Typ položky: T=riadny tovar, W=váhový tovar, O=obal"""

    PackGs: int = 0
    """Tovarové číslo pripojeného obalu (FK -> GSCAT.BTR)"""

    SbcCnt: int = 0
    """Počet pripojených druhotných kódov (word)"""

    # === SLEDOVANIE ===
    DrbMust: bool = False
    """Povinné zadávanie trvanlivosti tovaru (0/1)"""

    PdnMust: bool = False
    """Povinné sledovanie výrobných čísiel (0/1)"""

    GrcMth: int = 0
    """Záručná doba v mesiacoch (word)"""

    # === SKLAD ===
    GsStock: Decimal = Decimal('0.00')
    """Aktuálny stav na sklade"""

    GsMinStock: Decimal = Decimal('0.00')
    """Minimálny stav na sklade"""

    GsMaxStock: Decimal = Decimal('0.00')
    """Maximálny stav na sklade"""

    # === STAVY ===
    GsActive: bool = True
    """Aktívny produkt (True = áno, False = archivovaný)"""

    # === AUDIT POLIA ===
    ModUser: str = ""
    """Užívateľ ktorý naposledy upravil záznam (max 8 znakov)"""

    ModDate: Optional[datetime] = None
    """Dátum poslednej úpravy (DATE)"""

    ModTime: Optional[datetime] = None
    """Čas poslednej úpravy (TIME)"""

    # === RAW DATA ===
    _raw_bytes: bytes = field(default=b'', repr=False)
    """Raw bytes z Btrieve (705 bytes) - pre debugging"""

    # === COMPUTED PROPERTIES ===

    @property
    def price_with_vat(self) -> Decimal:
        """Vypočítaj cenu s DPH"""
        return self.GsPrice * (1 + self.GsVatRate / 100)

    @property
    def margin(self) -> Decimal:
        """Vypočítaj maržu (%)"""
        if self.GsPurchasePrice == 0:
            return Decimal('0.00')
        return ((self.GsPrice - self.GsPurchasePrice) / self.GsPurchasePrice) * 100

    @property
    def is_low_stock(self) -> bool:
        """Kontrola či je produkt pod minimálnym stavom"""
        return self.GsStock < self.GsMinStock

    @property
    def stock_status(self) -> str:
        """Status stavu na sklade"""
        if self.GsStock <= 0:
            return "OUT_OF_STOCK"
        elif self.is_low_stock:
            return "LOW_STOCK"
        elif self.GsStock > self.GsMaxStock:
            return "OVERSTOCK"
        else:
            return "OK"

    # === VALIDATION ===

    def validate(self) -> list[str]:
        """
        Validuj record

        Returns:
            List chybových hlášok (prázdny list = OK)
        """
        errors = []

        if self.GsCode <= 0:
            errors.append("GsCode musí byť > 0")

        if not self.GsName or len(self.GsName.strip()) == 0:
            errors.append("GsName nemôže byť prázdny")

        if self.GsPrice < 0:
            errors.append("GsPrice nemôže byť záporná")

        if self.GsVatRate < 0 or self.GsVatRate > 100:
            errors.append("GsVatRate musí byť 0-100%")

        if self.GsType and self.GsType not in ['T', 'W', 'O', '']:
            errors.append("GsType musí byť T (tovar), W (váhový), alebo O (obal)")

        return errors

    def is_valid(self) -> bool:
        """Kontrola či je record validný"""
        return len(self.validate()) == 0

    # === STRING REPRESENTATION ===

    def __str__(self) -> str:
        """Human-readable reprezentácia"""
        return f"GSCAT[{self.GsCode}]: {self.GsName} - {self.GsPrice}€"

    def to_dict(self) -> dict:
        """Konverzia na dictionary (pre JSON export)"""
        return {
            'gs_code': self.GsCode,
            'gs_name': self.GsName,
            'gs_name2': self.GsName2,
            'gs_ean': self.GsEAN,
            'gs_catalog': self.GsCatalog,
            'mglst_code': self.MglstCode,
            'fg_code': self.FgCode,
            'gs_price': float(self.GsPrice),
            'gs_vat_rate': float(self.GsVatRate),
            'gs_purchase_price': float(self.GsPurchasePrice),
            'gs_unit': self.GsUnit,
            'gs_unit_name': self.GsUnitName,
            'volume': float(self.Volume),
            'weight': float(self.Weight),
            'msu_qnt': float(self.MsuQnt),
            'msu_name': self.MsuName,
            'gs_type': self.GsType,
            'pack_gs': self.PackGs,
            'sbc_cnt': self.SbcCnt,
            'drb_must': self.DrbMust,
            'pdn_must': self.PdnMust,
            'grc_mth': self.GrcMth,
            'gs_stock': float(self.GsStock),
            'gs_min_stock': float(self.GsMinStock),
            'gs_max_stock': float(self.GsMaxStock),
            'gs_active': self.GsActive,
            'mod_user': self.ModUser,
            'mod_date': self.ModDate.isoformat() if self.ModDate else None,
            'mod_time': self.ModTime.isoformat() if self.ModTime else None,
            'price_with_vat': float(self.price_with_vat),
            'margin': float(self.margin),
            'stock_status': self.stock_status,
        }


# === FIELD OFFSET MAP ===
# Based on GSCAT.bdf analysis - Pascal strings (length-prefixed)

GSCAT_FIELD_MAP = {
    # Offset: (field_name, type, size)
    0: ('GsCode', 'int32', 4),  # Tovarové číslo (PLU)
    4: ('GsName', 'pstring30', 31),  # Názov tovaru (1+30 bytes)
    35: ('_GsName', 'pstring15', 16),  # Vyhľadávacie pole názvu (1+15 bytes)
    51: ('MgCode', 'int32', 4),  # Číslo tovarovej skupiny
    55: ('FgCode', 'int32', 4),  # Číslo finančnej skupiny
    59: ('BarCode', 'pstring15', 16),  # Prvotný identifikátor tovaru (1+15 bytes)
    75: ('StkCode', 'pstring15', 16),  # Skladový kód tovaru (1+15 bytes)
    91: ('MsName', 'pstring10', 11),  # Názov mernej jednotky (1+10 bytes)
    102: ('PackGs', 'int32', 4),  # Tovarové číslo pripojeného obalu
    106: ('GsType', 'pstring1', 2),  # Typ položky (T/W/O) (1+1 bytes)
    108: ('DrbMust', 'byte', 1),  # Povinné zadávanie trvanlivosti
    109: ('PdnMust', 'byte', 1),  # Povinné sledovanie výrobných čísiel
    110: ('GrcMth', 'word', 2),  # Záručná doba (počet mesiacov)
    112: ('VatPrc', 'byte', 1),  # Percentuálna sadzba DPH
    113: ('Volume', 'float64', 8),  # Objem tovaru (množstvo MJ na 1 m3)
    121: ('Weight', 'float64', 8),  # Váha tovaru (váha jednej MJ)
    129: ('MsuQnt', 'float64', 8),  # Množstvo tovaru v základnej jednotke
    137: ('MsuName', 'pstring5', 6),  # Názov základnej jednoty (kg,m,l,m2,m3) (1+5 bytes)
    143: ('SbcCnt', 'word', 2),  # Počet pripojených druhotných kódov
    # Total: 145+ bytes mapped, record is 705 bytes total
    # TODO: Map remaining fields as needed
}


# Field type descriptions:
# - int32: 4-byte signed integer (little-endian)
# - float64: 8-byte IEEE double (little-endian)
# - byte: 1-byte unsigned integer
# - word: 2-byte unsigned integer (little-endian)
# - pstringN: Pascal string (1 byte length + N bytes data)


# === HELPER FUNCTIONS ===

def parse_gscat_record(raw_bytes: bytes) -> GSCATRecord:
    """
    Parse raw Btrieve bytes do GSCATRecord

    Args:
        raw_bytes: 705 bytes z Btrieve GSCAT.BTR

    Returns:
        GSCATRecord instance
    """
    import struct

    def read_pascal_string(data: bytes, offset: int, max_len: int) -> str:
        """
        Read Pascal string (length-prefixed string)
        Format: 1 byte length + N bytes data

        Args:
            data: Raw bytes
            offset: Starting offset
            max_len: Maximum string length (not including length byte)

        Returns:
            Decoded string (trimmed)
        """
        if offset >= len(data):
            return ""

        # Read length byte
        str_len = data[offset]

        # Ensure we don't read beyond buffer
        actual_len = min(str_len, max_len, len(data) - offset - 1)

        if actual_len <= 0:
            return ""

        # Read string data (skip length byte)
        str_data = data[offset + 1: offset + 1 + actual_len]

        # Decode using CP852 (Czech/Slovak encoding)
        try:
            text = str_data.decode('cp852', errors='ignore')
        except:
            text = str_data.decode('ascii', errors='ignore')

        return text.rstrip('\x00 ')

    record = GSCATRecord()
    record._raw_bytes = raw_bytes

    # Parse GsCode (offset 0, INT32)
    record.GsCode = struct.unpack('<i', raw_bytes[0:4])[0]

    # Parse GsName (offset 4, Pascal Str30)
    record.GsName = read_pascal_string(raw_bytes, 4, 30)

    # Parse _GsName (offset 35, Pascal Str15) - search field
    # This is internal search field, we can skip or store in GsName2
    search_name = read_pascal_string(raw_bytes, 35, 15)
    record.GsName2 = search_name if search_name else ""

    # Parse MgCode (offset 51, INT32) - tovarová skupina
    record.MglstCode = struct.unpack('<i', raw_bytes[51:55])[0]

    # Parse FgCode (offset 55, INT32) - finančná skupina
    record.FgCode = struct.unpack('<i', raw_bytes[55:59])[0]

    # Parse BarCode (offset 59, Pascal Str15) - prvotný identifikátor
    record.GsEAN = read_pascal_string(raw_bytes, 59, 15)

    # Parse StkCode (offset 75, Pascal Str15) - skladový kód
    record.GsCatalog = read_pascal_string(raw_bytes, 75, 15)

    # Parse MsName (offset 91, Pascal Str10) - merná jednotka
    record.GsUnitName = read_pascal_string(raw_bytes, 91, 10)

    # Parse PackGs (offset 102, INT32) - pripojeného obalu
    record.PackGs = struct.unpack('<i', raw_bytes[102:106])[0]

    # Parse GsType (offset 106, Pascal Str1) - typ položky
    record.GsType = read_pascal_string(raw_bytes, 106, 1)

    # Parse DrbMust (offset 108, BYTE) - trvanlivosť
    record.DrbMust = raw_bytes[108] == 1 if 108 < len(raw_bytes) else False

    # Parse PdnMust (offset 109, BYTE) - výrobné čísla
    record.PdnMust = raw_bytes[109] == 1 if 109 < len(raw_bytes) else False

    # Parse GrcMth (offset 110, WORD) - záručná doba
    if 110 + 2 <= len(raw_bytes):
        record.GrcMth = struct.unpack('<H', raw_bytes[110:112])[0]

    # Parse VatPrc (offset 112, BYTE) - DPH sadzba
    if 112 < len(raw_bytes):
        vat_byte = raw_bytes[112]
        record.GsVatRate = Decimal(str(vat_byte))

    # Parse Volume (offset 113, FLOAT64) - objem
    if 113 + 8 <= len(raw_bytes):
        record.Volume = Decimal(str(struct.unpack('<d', raw_bytes[113:121])[0]))

    # Parse Weight (offset 121, FLOAT64) - váha
    if 121 + 8 <= len(raw_bytes):
        record.Weight = Decimal(str(struct.unpack('<d', raw_bytes[121:129])[0]))

    # Parse MsuQnt (offset 129, FLOAT64) - množstvo v základnej jednotke
    if 129 + 8 <= len(raw_bytes):
        record.MsuQnt = Decimal(str(struct.unpack('<d', raw_bytes[129:137])[0]))

    # Parse MsuName (offset 137, Pascal Str5) - základná jednotka
    record.MsuName = read_pascal_string(raw_bytes, 137, 5)

    # Parse SbcCnt (offset 143, WORD) - počet druhotných kódov
    if 143 + 2 <= len(raw_bytes):
        record.SbcCnt = struct.unpack('<H', raw_bytes[143:145])[0]

    # TODO: Parse GsPrice and other fields when we locate them in record
    # Note: Price fields are likely stored later in the record

    return record


def create_gscat_record(
        gs_code: int,
        gs_name: str,
        mglst_code: int,
        gs_price: float = 0.0,
        gs_vat_rate: float = 20.0,
        **kwargs
) -> GSCATRecord:
    """
    Helper na vytvorenie nového GSCAT recordu

    Args:
        gs_code: Kód produktu (required)
        gs_name: Názov produktu (required)
        mglst_code: Kód tovarovej skupiny (required)
        gs_price: Cena bez DPH (default: 0.0)
        gs_vat_rate: DPH sadzba % (default: 20.0)
        **kwargs: Ďalšie optional polia

    Returns:
        GSCATRecord instance
    """
    record = GSCATRecord(
        GsCode=gs_code,
        GsName=gs_name,
        MglstCode=mglst_code,
        GsPrice=Decimal(str(gs_price)),
        GsVatRate=Decimal(str(gs_vat_rate)),
        ModUser='SYSTEM',
        ModDate=datetime.now(),
        ModTime=datetime.now(),
    )

    # Apply optional fields
    for key, value in kwargs.items():
        if hasattr(record, key):
            setattr(record, key, value)

    return record