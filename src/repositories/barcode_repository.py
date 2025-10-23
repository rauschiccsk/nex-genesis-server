"""
Barcode Repository
High-level API for BARCODE table operations

Usage:
    with BarcodeRepository() as repo:
        # Find by barcode
        record = repo.find_by_barcode("8594000123456")

        # Get all barcodes for product
        barcodes = repo.find_by_gs_code(12345)

        # Check if exists
        exists = repo.exists_barcode("8594000123456")
"""

from typing import Optional, List
from src.repositories.base_repository import ReadOnlyRepository
from src.models.barcode import BarcodeRecord
import logging

logger = logging.getLogger(__name__)


class BarcodeRepository(ReadOnlyRepository[BarcodeRecord]):
    """
    Repository for BARCODE table

    Read-only by default (use with caution for writes).
    """

    @property
    def table_name(self) -> str:
        return 'barcode'

    def from_bytes(self, data: bytes) -> BarcodeRecord:
        """Deserialize Btrieve bytes to BarcodeRecord"""
        return BarcodeRecord.from_bytes(data)

    def to_bytes(self, record: BarcodeRecord) -> bytes:
        """Serialize BarcodeRecord to Btrieve bytes"""
        return record.to_bytes()

    def find_by_barcode(self, bar_code: str) -> Optional[BarcodeRecord]:
        """
        Find barcode by barcode string

        Args:
            bar_code: Barcode to search for

        Returns:
            BarcodeRecord or None if not found
        """
        return self.find_one(lambda r: r.bar_code == bar_code)

    def find_by_gs_code(self, gs_code: int) -> List[BarcodeRecord]:
        """
        Find all barcodes for a product

        Args:
            gs_code: Product code (GsCode)

        Returns:
            List of BarcodeRecords for this product
        """
        return self.find(lambda r: r.gs_code == gs_code)

    def exists_barcode(self, bar_code: str) -> bool:
        """
        Check if barcode exists

        Args:
            bar_code: Barcode to check

        Returns:
            True if exists
        """
        return self.exists(lambda r: r.bar_code == bar_code)

    def exists_combination(self, gs_code: int, bar_code: str) -> bool:
        """
        Check if specific GsCode + BarCode combination exists

        Args:
            gs_code: Product code
            bar_code: Barcode

        Returns:
            True if combination exists
        """
        return self.exists(lambda r: r.gs_code == gs_code and r.bar_code == bar_code)

    def get_product_code(self, bar_code: str) -> Optional[int]:
        """
        Get product code (GsCode) for a barcode

        Args:
            bar_code: Barcode to lookup

        Returns:
            GsCode or None if not found
        """
        record = self.find_by_barcode(bar_code)
        return record.gs_code if record else None

    def count_by_product(self, gs_code: int) -> int:
        """
        Count barcodes for a product

        Args:
            gs_code: Product code

        Returns:
            Number of barcodes
        """
        return len(self.find_by_gs_code(gs_code))

    def get_barcode_list(self, gs_code: int) -> List[str]:
        """
        Get list of barcode strings for a product

        Args:
            gs_code: Product code

        Returns:
            List of barcode strings
        """
        records = self.find_by_gs_code(gs_code)
        return [r.bar_code for r in records]

    def find_duplicates(self) -> dict:
        """
        Find duplicate barcodes (same barcode, different products)

        Returns:
            Dict: {barcode: [gs_code1, gs_code2, ...]}
        """
        duplicates = {}
        all_records = self.get_all()

        # Group by barcode
        barcode_map = {}
        for record in all_records:
            if record.bar_code not in barcode_map:
                barcode_map[record.bar_code] = []
            barcode_map[record.bar_code].append(record.gs_code)

        # Find duplicates
        for bar_code, gs_codes in barcode_map.items():
            if len(gs_codes) > 1:
                duplicates[bar_code] = gs_codes

        if duplicates:
            logger.warning(f"Found {len(duplicates)} duplicate barcodes")

        return duplicates

    def get_statistics(self) -> dict:
        """
        Get barcode table statistics

        Returns:
            Dict with statistics
        """
        all_records = self.get_all()

        # Count unique products
        unique_products = set(r.gs_code for r in all_records)

        # Count barcodes per product
        product_counts = {}
        for record in all_records:
            product_counts[record.gs_code] = product_counts.get(record.gs_code, 0) + 1

        # Find products with most barcodes
        max_barcodes = max(product_counts.values()) if product_counts else 0
        products_with_max = [gs for gs, count in product_counts.items() if count == max_barcodes]

        return {
            'total_barcodes': len(all_records),
            'unique_products': len(unique_products),
            'avg_barcodes_per_product': len(all_records) / len(unique_products) if unique_products else 0,
            'max_barcodes_per_product': max_barcodes,
            'products_with_most_barcodes': products_with_max,
            'duplicates': len(self.find_duplicates())
        }


# Example usage
if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)

    with BarcodeRepository() as repo:
        # Get statistics
        stats = repo.get_statistics()
        print("Barcode Statistics:")
        print(f"  Total barcodes: {stats['total_barcodes']}")
        print(f"  Unique products: {stats['unique_products']}")
        print(f"  Avg per product: {stats['avg_barcodes_per_product']:.2f}")

        # Find by barcode
        barcode = repo.find_by_barcode("8594000123456")
        if barcode:
            print(f"\nFound: {barcode}")

        # Get all barcodes for product
        barcodes = repo.find_by_gs_code(1)
        print(f"\nProduct 1 has {len(barcodes)} barcodes")