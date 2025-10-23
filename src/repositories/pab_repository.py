"""
PAB Repository
High-level API for PAB (Business Partners) table operations

Usage:
    with PABRepository() as repo:
        # Find by code
        partner = repo.find_by_pab_code(123)

        # Search by name
        partners = repo.search_by_name("ICC")

        # Get suppliers
        suppliers = repo.get_suppliers()
"""

from typing import Optional, List
from src.repositories.base_repository import ReadOnlyRepository
from src.models.pab import PABRecord
import logging

logger = logging.getLogger(__name__)


class PABRepository(ReadOnlyRepository[PABRecord]):
    """
    Repository for PAB table (Business Partners)

    Read-only by default to prevent accidental modifications.
    """

    @property
    def table_name(self) -> str:
        return 'pab'

    def from_bytes(self, data: bytes) -> PABRecord:
        """Deserialize Btrieve bytes to PABRecord"""
        return PABRecord.from_bytes(data)

    def to_bytes(self, record: PABRecord) -> bytes:
        """Serialize PABRecord to Btrieve bytes"""
        return record.to_bytes()

    def find_by_pab_code(self, pab_code: int) -> Optional[PABRecord]:
        """
        Find partner by PabCode

        Args:
            pab_code: Partner code

        Returns:
            PABRecord or None if not found
        """
        return self.find_one(lambda r: r.pab_code == pab_code)

    def search_by_name(self, search_term: str, case_sensitive: bool = False) -> List[PABRecord]:
        """
        Search partners by name (name1, name2, or short_name)

        Args:
            search_term: Search string
            case_sensitive: Case sensitive search

        Returns:
            List of matching partners
        """
        if case_sensitive:
            return self.find(lambda r:
                             search_term in r.name1 or
                             search_term in r.name2 or
                             search_term in r.short_name
                             )
        else:
            term_lower = search_term.lower()
            return self.find(lambda r:
                             term_lower in r.name1.lower() or
                             term_lower in r.name2.lower() or
                             term_lower in r.short_name.lower()
                             )

    def find_by_ico(self, ico: str) -> Optional[PABRecord]:
        """
        Find partner by IČO (company ID)

        Args:
            ico: IČO to search for

        Returns:
            PABRecord or None if not found
        """
        return self.find_one(lambda r: r.ico == ico)

    def find_by_city(self, city: str) -> List[PABRecord]:
        """
        Find partners by city

        Args:
            city: City name

        Returns:
            List of partners in this city
        """
        return self.find(lambda r: r.city.lower() == city.lower())

    def get_suppliers(self) -> List[PABRecord]:
        """
        Get all suppliers (partner_type 1 or 3)

        Returns:
            List of supplier partners
        """
        return self.find(lambda r: r.is_supplier())

    def get_customers(self) -> List[PABRecord]:
        """
        Get all customers (partner_type 2 or 3)

        Returns:
            List of customer partners
        """
        return self.find(lambda r: r.is_customer())

    def get_active_partners(self) -> List[PABRecord]:
        """
        Get all active partners

        Returns:
            List of active partners
        """
        return self.find(lambda r: r.active)

    def get_vat_payers(self) -> List[PABRecord]:
        """
        Get all VAT payers

        Returns:
            List of VAT payer partners
        """
        return self.find(lambda r: r.vat_payer)

    def find_by_email(self, email: str) -> Optional[PABRecord]:
        """
        Find partner by email

        Args:
            email: Email address

        Returns:
            PABRecord or None if not found
        """
        return self.find_one(lambda r: r.email.lower() == email.lower())

    def find_by_payment_terms(self, days: int) -> List[PABRecord]:
        """
        Find partners with specific payment terms

        Args:
            days: Payment terms in days

        Returns:
            List of partners with these terms
        """
        return self.find(lambda r: r.payment_terms == days)

    def find_with_credit_limit(self, min_limit: float = 0) -> List[PABRecord]:
        """
        Find partners with credit limit above threshold

        Args:
            min_limit: Minimum credit limit

        Returns:
            List of partners with credit limit >= min_limit
        """
        return self.find(lambda r: r.credit_limit >= min_limit)

    def get_statistics(self) -> dict:
        """
        Get partner statistics

        Returns:
            Dict with statistics
        """
        all_partners = self.get_all()

        active = [p for p in all_partners if p.active]
        suppliers = [p for p in active if p.is_supplier()]
        customers = [p for p in active if p.is_customer()]
        both = [p for p in active if p.is_supplier() and p.is_customer()]
        vat_payers = [p for p in active if p.vat_payer]

        # City distribution
        cities = {}
        for partner in active:
            if partner.city:
                cities[partner.city] = cities.get(partner.city, 0) + 1
        top_cities = sorted(cities.items(), key=lambda x: x[1], reverse=True)[:5]

        # Payment terms distribution
        payment_terms_dist = {}
        for partner in active:
            payment_terms_dist[partner.payment_terms] = payment_terms_dist.get(partner.payment_terms, 0) + 1

        # Credit limits
        partners_with_credit = [p for p in active if p.credit_limit > 0]
        total_credit_limit = sum(p.credit_limit for p in partners_with_credit)

        return {
            'total_partners': len(all_partners),
            'active_partners': len(active),
            'suppliers': len(suppliers),
            'customers': len(customers),
            'both_supplier_and_customer': len(both),
            'vat_payers': len(vat_payers),
            'top_cities': top_cities,
            'payment_terms_distribution': payment_terms_dist,
            'partners_with_credit_limit': len(partners_with_credit),
            'total_credit_limit': total_credit_limit
        }

    def get_partner_info(self, pab_code: int) -> Optional[dict]:
        """
        Get complete partner information

        Args:
            pab_code: Partner code

        Returns:
            Dict with partner info or None
        """
        partner = self.find_by_pab_code(pab_code)
        if not partner:
            return None

        # Determine type string
        if partner.is_supplier() and partner.is_customer():
            type_str = "Supplier & Customer"
        elif partner.is_supplier():
            type_str = "Supplier"
        elif partner.is_customer():
            type_str = "Customer"
        else:
            type_str = "Other"

        return {
            'pab_code': partner.pab_code,
            'name': partner.get_full_name(),
            'short_name': partner.short_name,
            'type': type_str,
            'type_code': partner.partner_type,
            'address': partner.get_full_address(),
            'phone': partner.phone,
            'email': partner.email,
            'web': partner.web,
            'contact_person': partner.contact_person,
            'ico': partner.ico,
            'dic': partner.dic,
            'ic_dph': partner.ic_dph,
            'iban': partner.iban,
            'swift': partner.swift,
            'payment_terms': partner.payment_terms,
            'credit_limit': partner.credit_limit,
            'discount_percent': partner.discount_percent,
            'active': partner.active,
            'vat_payer': partner.vat_payer,
            'note': partner.note
        }

    def export_contact_list(self) -> List[dict]:
        """
        Export simplified contact list

        Returns:
            List of contact dicts (name, email, phone)
        """
        active = self.get_active_partners()

        contacts = []
        for partner in active:
            if partner.email or partner.phone:
                contacts.append({
                    'code': partner.pab_code,
                    'name': partner.get_full_name(),
                    'email': partner.email,
                    'phone': partner.phone,
                    'contact_person': partner.contact_person
                })

        return contacts


# Example usage
if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)

    with PABRepository() as repo:
        # Get statistics
        stats = repo.get_statistics()
        print("PAB Statistics:")
        print(f"  Total partners: {stats['total_partners']}")
        print(f"  Suppliers: {stats['suppliers']}")
        print(f"  Customers: {stats['customers']}")
        print(f"  VAT payers: {stats['vat_payers']}")

        # Search partner
        results = repo.search_by_name("ICC")
        print(f"\nSearch 'ICC': {len(results)} results")
        for partner in results:
            print(f"  - {partner.get_full_name()}")

        # Get partner info
        partner = repo.find_by_pab_code(1)
        if partner:
            info = repo.get_partner_info(1)
            print(f"\nPartner 1:")
            print(f"  Name: {info['name']}")
            print(f"  Type: {info['type']}")
            print(f"  Email: {info['email']}")