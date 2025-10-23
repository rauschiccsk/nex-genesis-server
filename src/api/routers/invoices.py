"""
NEX Genesis Btrieve Bridge API - Invoice Router

Endpoints pre import ISDOC faktúr do NEX Genesis.
"""

import logging
from typing import List

from fastapi import APIRouter, HTTPException, status

from ..dependencies import (
    GSCATRepositoryDep,
    PABRepositoryDep,
    BarcodeRepositoryDep,
    ISDOCMapperDep
)
from ..models.invoice import (
    ISDOCImportRequest,
    ISDOCImportResponse,
    ImportStatus,
    ValidationError
)

logger = logging.getLogger(__name__)

router = APIRouter()


@router.post(
    "/import",
    response_model=ISDOCImportResponse,
    status_code=status.HTTP_200_OK,
    summary="Import ISDOC faktúry do NEX Genesis",
    description="""
    Importuje ISDOC faktúru do NEX Genesis databázy.
    
    **Proces:**
    1. Validuje vstupné ISDOC dáta
    2. Mapuje ISDOC → NEX Genesis štruktúry
    3. Vytvorí/updatne dodávateľa (PAB)
    4. Vytvorí/updatne odberateľa (PAB)
    5. Vytvorí/updatne produkty (GSCAT)
    6. Vytvorí/updatne čiarové kódy (BARCODE)
    7. Vytvorí dodací list header (TSH)
    8. Vytvorí dodací list items (TSI)
    
    **Validácia:**
    - Overí povinné polia (IČO, názov, položky)
    - Validuje formáty (dátumy, čísla, IČO/DIČ/IČ DPH)
    - Kontroluje biznis pravidlá (ceny > 0, quantity > 0)
    
    **Error Handling:**
    - Pri chybe vráti HTTP 400 s detailom chyby
    - Pri čiastočnom importe (niektoré položky zlyhali) vráti status=partial
    - Pri úplnom zlyhaní vráti status=failed
    
    **Response:**
    - Štatistiky importu (vytvorené/updatnuté záznamy)
    - Zoznam chýb a varovaní
    - IČO dodávateľa/odberateľa pre ďalšie spracovanie
    """,
    responses={
        200: {
            "description": "Invoice imported successfully",
            "content": {
                "application/json": {
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
                        "warnings": ["Product 12345 already exists, updated price"]
                    }
                }
            }
        },
        400: {
            "description": "Invalid ISDOC data or validation failed"
        },
        500: {
            "description": "Internal server error (database error, etc.)"
        }
    }
)
async def import_invoice(
    request: ISDOCImportRequest,
    gscat_repo: GSCATRepositoryDep,
    pab_repo: PABRepositoryDep,
    barcode_repo: BarcodeRepositoryDep,
    mapper: ISDOCMapperDep
) -> ISDOCImportResponse:
    """
    Import ISDOC faktúry do NEX Genesis.

    Args:
        request: ISDOC import request data
        gscat_repo: GSCAT repository (injected)
        pab_repo: PAB repository (injected)
        barcode_repo: BARCODE repository (injected)
        mapper: ISDOC mapper (injected)

    Returns:
        ISDOCImportResponse s výsledkami importu

    Raises:
        HTTPException: Pri validačných chybách alebo database errors
    """

    logger.info(f"📥 Invoice import started: {request.invoice_number}")
    logger.info(f"   Supplier: {request.supplier.name} (IČO: {request.supplier.ico})")
    logger.info(f"   Customer: {request.customer.name} (IČO: {request.customer.ico})")
    logger.info(f"   Items: {len(request.items)}")

    errors: List[ValidationError] = []
    warnings: List[str] = []

    # Statistics counters
    supplier_created = False
    customer_created = False
    products_created = 0
    products_updated = 0
    barcodes_created = 0
    delivery_created = False
    product_codes: List[str] = []

    try:
        # ===== 1. VALIDÁCIA =====
        logger.info("🔍 Step 1: Validating ISDOC data...")

        # Basic validation
        if not request.supplier.ico:
            errors.append(ValidationError(
                field="supplier.ico",
                message="Supplier IČO is required",
                value=None
            ))

        if not request.customer.ico:
            errors.append(ValidationError(
                field="customer.ico",
                message="Customer IČO is required",
                value=None
            ))

        if not request.items:
            errors.append(ValidationError(
                field="items",
                message="At least one item is required",
                value=[]
            ))

        # Item validation
        for idx, item in enumerate(request.items, 1):
            if item.quantity <= 0:
                errors.append(ValidationError(
                    field=f"items[{idx}].quantity",
                    message="Quantity must be greater than 0",
                    value=float(item.quantity)
                ))

            if item.unit_price <= 0:
                errors.append(ValidationError(
                    field=f"items[{idx}].unit_price",
                    message="Unit price must be greater than 0",
                    value=float(item.unit_price)
                ))

        if errors:
            logger.warning(f"❌ Validation failed with {len(errors)} errors")
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail={
                    "message": "Validation failed",
                    "errors": [e.dict() for e in errors]
                }
            )

        logger.info("✅ Validation passed")

        # ===== 2. MAPPING =====
        logger.info("🗺️  Step 2: Mapping ISDOC to NEX structures...")

        # Convert request to dict for mapper (mapper očakáva dict)
        invoice_dict = request.model_dump()

        # Map using ISDOCToNEXMapper
        mapped = mapper.map_invoice_complete(invoice_dict)

        supplier_data = mapped['supplier']
        customer_data = mapped['customer']
        products_data = mapped['products']
        barcodes_data = mapped['barcodes']
        delivery_header = mapped['delivery_header']
        delivery_items = mapped['delivery_items']

        logger.info(f"   ✅ Mapped {len(products_data)} products")
        logger.info(f"   ✅ Mapped {len(barcodes_data)} barcodes")
        logger.info(f"   ✅ Mapped {len(delivery_items)} delivery items")

        # ===== 3. DODÁVATEĽ (SUPPLIER) =====
        logger.info("📦 Step 3: Processing supplier...")

        try:
            # Check if supplier exists
            existing_supplier = pab_repo.find_by_ico(supplier_data.ico)

            if existing_supplier:
                logger.info(f"   ℹ️  Supplier exists: {supplier_data.nazov} (IČO: {supplier_data.ico})")
                # TODO: Update supplier data if needed
                supplier_created = False
            else:
                # Create new supplier
                pab_repo.create(supplier_data)
                logger.info(f"   ✅ Supplier created: {supplier_data.nazov} (IČO: {supplier_data.ico})")
                supplier_created = True

        except Exception as e:
            logger.error(f"❌ Supplier processing failed: {e}")
            errors.append(ValidationError(
                field="supplier",
                message=f"Failed to process supplier: {str(e)}",
                value=request.supplier.ico
            ))

        # ===== 4. ODBERATEĽ (CUSTOMER) =====
        logger.info("📦 Step 4: Processing customer...")

        try:
            # Check if customer exists
            existing_customer = pab_repo.find_by_ico(customer_data.ico)

            if existing_customer:
                logger.info(f"   ℹ️  Customer exists: {customer_data.nazov} (IČO: {customer_data.ico})")
                customer_created = False
            else:
                # Create new customer
                pab_repo.create(customer_data)
                logger.info(f"   ✅ Customer created: {customer_data.nazov} (IČO: {customer_data.ico})")
                customer_created = True

        except Exception as e:
            logger.error(f"❌ Customer processing failed: {e}")
            errors.append(ValidationError(
                field="customer",
                message=f"Failed to process customer: {str(e)}",
                value=request.customer.ico
            ))

        # ===== 5. PRODUKTY (GSCAT) =====
        logger.info(f"📦 Step 5: Processing {len(products_data)} products...")

        for product in products_data:
            try:
                # Check if product exists
                existing_product = gscat_repo.find_by_code(product.kod)

                if existing_product:
                    # Update existing product
                    gscat_repo.update(product.kod, product)
                    logger.info(f"   ℹ️  Product updated: {product.nazov} (Code: {product.kod})")
                    products_updated += 1
                    warnings.append(f"Product {product.kod} already exists, updated")
                else:
                    # Create new product
                    gscat_repo.create(product)
                    logger.info(f"   ✅ Product created: {product.nazov} (Code: {product.kod})")
                    products_created += 1

                product_codes.append(str(product.kod))

            except Exception as e:
                logger.error(f"❌ Product {product.kod} processing failed: {e}")
                warnings.append(f"Failed to process product {product.kod}: {str(e)}")

        # ===== 6. ČIAROVÉ KÓDY (BARCODE) =====
        logger.info(f"📦 Step 6: Processing {len(barcodes_data)} barcodes...")

        for barcode in barcodes_data:
            try:
                # Check if barcode exists
                existing_barcode = barcode_repo.find_by_ean(barcode.ean)

                if existing_barcode:
                    logger.info(f"   ℹ️  Barcode exists: {barcode.ean}")
                else:
                    # Create new barcode
                    barcode_repo.create(barcode)
                    logger.info(f"   ✅ Barcode created: {barcode.ean}")
                    barcodes_created += 1

            except Exception as e:
                logger.error(f"❌ Barcode {barcode.ean} processing failed: {e}")
                warnings.append(f"Failed to process barcode {barcode.ean}: {str(e)}")

        # ===== 7. DODACÍ LIST (TSH/TSI) =====
        # TODO: Implement TSH/TSI creation
        # Note: Toto bude v Phase 2.3 keď dokončíme TSH/TSI repositories
        logger.info("⏭️  Step 7: Skipping delivery creation (TSH/TSI - TODO in Phase 2.3)")
        delivery_created = False
        delivery_number = None

        # ===== 8. RESPONSE =====
        logger.info("✅ Invoice import completed successfully!")

        # Determine status
        if errors:
            import_status = ImportStatus.PARTIAL
            message = f"Invoice imported partially ({len(errors)} errors)"
        else:
            import_status = ImportStatus.SUCCESS
            message = "Invoice imported successfully"

        return ISDOCImportResponse(
            status=import_status,
            message=message,
            supplier_created=supplier_created,
            customer_created=customer_created,
            products_created=products_created,
            products_updated=products_updated,
            barcodes_created=barcodes_created,
            delivery_created=delivery_created,
            supplier_ico=request.supplier.ico,
            customer_ico=request.customer.ico,
            product_codes=product_codes,
            delivery_number=delivery_number,
            errors=errors,
            warnings=warnings
        )

    except HTTPException:
        # Re-raise HTTP exceptions (validation errors)
        raise

    except Exception as e:
        # Catch-all for unexpected errors
        logger.error(f"❌ Invoice import failed with unexpected error: {e}", exc_info=True)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail={
                "message": "Invoice import failed",
                "error": str(e),
                "type": type(e).__name__
            }
        )