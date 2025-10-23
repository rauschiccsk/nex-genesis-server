"""
GSCAT Repository
High-level API for GSCAT (Product Catalog) table operations

Usage:
    with GSCATRepository() as repo:
        # Find by GsCode
        product = repo.find_by_gs_code(12345)

        # Search by name
        products = repo.search_by_name("elektronika")

        # Get active products
        active = repo.get_active_products()
"""

from typing import Optional, List
from decimal import Decimal
from src.repositories.base_repository import ReadOnlyRepository
from src.models.gscat import GSCATRecord
import logging

logger = logging.getLogger(__name__)


class GSCATRepository(ReadOnlyRepository[GSCATRecord]):
    """
    Repository for GSCAT table (Product Catalog)

    Read-only by default to prevent accidental modifications.
    """

    @property
    def table_name(self) -> str:
        return 'gscat'

    def from_bytes(self, data: bytes) -> GSCATRecord:
        """Deserialize Btrieve bytes to GSCATRecord"""
        return GSCATRecord.from_bytes(data)

    def to_bytes(self, record: GSCATRecord) -> bytes:
        """Serialize GSCATRecord to Btrieve bytes"""
        return record.to_bytes()

    def find_by_gs_code(self, gs_code: int) -> Optional[GSCATRecord]:
        """
        Find product by GsCode

        Args:
            gs_code: Product code

        Returns:
            GSCATRecord or None if not found
        """
        return self.find_one(lambda r: r.gs_code == gs_code)

    def search_by_name(self, search_term: str, case_sensitive: bool = False) -> List[GSCATRecord]:
        """
        Search products by name (gs_name or gs_name2)

        Args:
            search_term: Search string
            case_sensitive: Case sensitive search

        Returns:
            List of matching products
        """
        if case_sensitive:
            return self.find(lambda r: search_term in r.gs_name or search_term in r.gs_name2)
        else:
            term_lower = search_term.lower()
            return self.find(lambda r:
                             term_lower in r.gs_name.lower() or
                             term_lower in r.gs_name2.lower()
                             )

    def find_by_category(self, mglst_code: int) -> List[GSCATRecord]:
        """
        Find all products in category

        Args:
            mglst_code: Category code (MglstCode)

        Returns:
            List of products in category
        """
        return self.find(lambda r: r.mglst_code == mglst_code)

    def find_by_supplier(self, supplier_code: int) -> List[GSCATRecord]:
        """
        Find all products from supplier

        Args:
            supplier_code: Supplier PAB code

        Returns:
            List of products from supplier
        """
        return self.find(lambda r: r.supplier_code == supplier_code)

    def get_active_products(self) -> List[GSCATRecord]:
        """
        Get all active products

        Returns:
            List of active products
        """
        return self.find(lambda r: r.active and not r.discontinued)

    def get_discontinued_products(self) -> List[GSCATRecord]:
        """
        Get all discontinued products

        Returns:
            List of discontinued products
        """
        return self.find(lambda r: r.discontinued)

    def find_low_stock(self, threshold: Optional[Decimal] = None) -> List[GSCATRecord]:
        """
        Find products with low stock (below minimum)

        Args:
            threshold: Custom threshold (if None, uses stock_min)

        Returns:
            List of products with low stock
        """
        if threshold:
            return self.find(lambda r: r.stock_current < threshold)
        else:
            return self.find(lambda r: r.stock_current < r.stock_min)

    def find_over_stock(self) -> List[GSCATRecord]:
        """
        Find products with stock above maximum

        Returns:
            List of products with over stock
        """
        return self.find(lambda r: r.stock_current > r.stock_max and r.stock_max > 0)

    def find_by_price_range(self, min_price: Decimal, max_price: Decimal) -> List[GSCATRecord]:
        """
        Find products in price range

        Args:
            min_price: Minimum price (sell)
            max_price: Maximum price (sell)

        Returns:
            List of products in range
        """
        return self.find(lambda r: min_price <= r.price_sell <= max_price)

    def find_by_vat_rate(self, vat_rate: Decimal) -> List[GSCATRecord]:
        """
        Find products with specific VAT rate

        Args:
            vat_rate: VAT rate (e.g., 20.0 for 20%)

        Returns:
            List of products with this VAT rate
        """
        return self.find(lambda r: r.vat_rate == vat_rate)

    def calculate_total_stock_value(self) -> dict:
        """
        Calculate total stock value (current stock * buy price)

        Returns:
            Dict with total values
        """
        all_products = self.get_all()

        total_buy_value = Decimal("0.00")
        total_sell_value = Decimal("0.00")

        for product in all_products:
            if product.active and not product.discontinued:
                buy_value = product.stock_current * product.price_buy
                sell_value = product.stock_current * product.price_sell
                total_buy_value += buy_value
                total_sell_value += sell_value

        return {
            'total_buy_value': total_buy_value,
            'total_sell_value': total_sell_value,
            'potential_profit': total_sell_value - total_buy_value,
            'profit_margin_percent': ((
                                                  total_sell_value - total_buy_value) / total_buy_value * 100) if total_buy_value > 0 else Decimal(
                "0.00")
        }

    def get_statistics(self) -> dict:
        """
        Get product catalog statistics

        Returns:
            Dict with statistics
        """
        all_products = self.get_all()

        active = [p for p in all_products if p.active and not p.discontinued]
        discontinued = [p for p in all_products if p.discontinued]

        # Category distribution
        categories = {}
        for product in active:
            categories[product.mglst_code] = categories.get(product.mglst_code, 0) + 1

        # VAT distribution
        vat_rates = {}
        for product in active:
            vat_rates[float(product.vat_rate)] = vat_rates.get(float(product.vat_rate), 0) + 1

        # Stock status
        low_stock = self.find_low_stock()
        over_stock = self.find_over_stock()
        zero_stock = [p for p in active if p.stock_current == 0]

        # Price ranges
        prices = [p.price_sell for p in active if p.price_sell > 0]
        avg_price = sum(prices) / len(prices) if prices else Decimal("0.00")
        min_price = min(prices) if prices else Decimal("0.00")
        max_price = max(prices) if prices else Decimal("0.00")

        return {
            'total_products': len(all_products),
            'active_products': len(active),
            'discontinued_products': len(discontinued),
            'categories_used': len(categories),
            'vat_rates_used': len(vat_rates),
            'vat_distribution': vat_rates,
            'low_stock_count': len(low_stock),
            'over_stock_count': len(over_stock),
            'zero_stock_count': len(zero_stock),
            'price_avg': avg_price,
            'price_min': min_price,
            'price_max': max_price
        }

    def get_product_info(self, gs_code: int) -> Optional[dict]:
        """
        Get complete product information including related data

        Args:
            gs_code: Product code

        Returns:
            Dict with product info or None
        """
        product = self.find_by_gs_code(gs_code)
        if not product:
            return None

        # Calculate profit margin
        profit = product.price_sell - product.price_buy
        profit_percent = (profit / product.price_buy * 100) if product.price_buy > 0 else Decimal("0.00")

        # Stock status
        stock_status = "OK"
        if product.stock_current < product.stock_min:
            stock_status = "LOW"
        elif product.stock_current > product.stock_max and product.stock_max > 0:
            stock_status = "HIGH"
        elif product.stock_current == 0:
            stock_status = "EMPTY"

        return {
            'gs_code': product.gs_code,
            'name': product.gs_name,
            'name2': product.gs_name2,
            'short_name': product.gs_short_name,
            'category_code': product.mglst_code,
            'unit': product.unit,
            'price_buy': product.price_buy,
            'price_sell': product.price_sell,
            'profit': profit,
            'profit_percent': profit_percent,
            'vat_rate': product.vat_rate,
            'stock_current': product.stock_current,
            'stock_min': product.stock_min,
            'stock_max': product.stock_max,
            'stock_status': stock_status,
            'active': product.active,
            'discontinued': product.discontinued,
            'supplier_code': product.supplier_code,
            'supplier_item_code': product.supplier_item_code,
            'mod_user': product.mod_user,
            'mod_date': product.mod_date
        }


# Example usage
if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)

    with GSCATRepository() as repo:
        # Get statistics
        stats = repo.get_statistics()
        print("GSCAT Statistics:")
        print(f"  Total products: {stats['total_products']}")
        print(f"  Active: {stats['active_products']}")
        print(f"  Average price: {stats['price_avg']:.2f} EUR")

        # Find product
        product = repo.find_by_gs_code(1)
        if product:
            print(f"\nProduct 1: {product.gs_name}")
            info = repo.get_product_info(1)
            print(f"  Price: {info['price_sell']} EUR")
            print(f"  Stock: {info['stock_current']} {info['unit']}")

        # Low stock alert
        low_stock = repo.find_low_stock()
        print(f"\nLow stock products: {len(low_stock)}")