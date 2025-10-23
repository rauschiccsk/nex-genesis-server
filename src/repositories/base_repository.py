"""
Base Repository Pattern
Provides high-level CRUD operations combining BtrieveClient + Models

Usage:
    repo = BarcodeRepository()

    # Find by barcode
    record = repo.find_by_barcode("8594000123456")

    # Get all records
    records = repo.get_all()

    # Insert new
    repo.insert(new_record)
"""

from typing import Generic, TypeVar, Optional, List, Callable
from abc import ABC, abstractmethod
from src.btrieve.btrieve_client import BtrieveClient
import logging

logger = logging.getLogger(__name__)

T = TypeVar('T')  # Generic type for record model


class BaseRepository(Generic[T], ABC):
    """
    Base repository providing common CRUD operations

    Subclasses must implement:
    - table_name: str
    - model_class: Type[T]
    - from_bytes(data: bytes) -> T
    - to_bytes(record: T) -> bytes
    """

    def __init__(self, btrieve_client: BtrieveClient):
        """Initialize repository with Btrieve client"""
        self.client = btrieve_client
        self._is_open = False

    @property
    @abstractmethod
    def table_name(self) -> str:
        """Table name for BtrieveClient (e.g., 'gscat', 'barcode')"""
        pass

    @abstractmethod
    def from_bytes(self, data: bytes) -> T:
        """Convert raw Btrieve bytes to model instance"""
        pass

    @abstractmethod
    def to_bytes(self, record: T) -> bytes:
        """Convert model instance to raw Btrieve bytes"""
        pass

    def open(self) -> bool:
        """
        Open Btrieve table

        Returns:
            True if successful
        """
        if self._is_open:
            return True

        status = self.client.open_table(self.table_name)
        if status == BtrStatus.SUCCESS:
            self._is_open = True
            logger.debug(f"Opened table: {self.table_name}")
            return True
        else:
            logger.error(f"Failed to open table {self.table_name}: {status}")
            return False

    def close(self):
        """Close Btrieve table"""
        if self._is_open:
            self.client.close_file()
            self._is_open = False
            logger.debug(f"Closed table: {self.table_name}")

    def __enter__(self):
        """Context manager entry"""
        self.open()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context manager exit"""
        self.close()

    def get_first(self) -> Optional[T]:
        """
        Get first record in table

        Returns:
            First record or None if empty/error
        """
        if not self._is_open:
            if not self.open():
                return None

        status, data = self.client.get_first()
        if status == BtrStatus.SUCCESS:
            try:
                return self.from_bytes(data)
            except Exception as e:
                logger.error(f"Failed to deserialize record: {e}")
                return None
        elif status == BtrStatus.END_OF_FILE:
            logger.debug(f"Table {self.table_name} is empty")
            return None
        else:
            logger.error(f"Failed to get first record: {status}")
            return None

    def get_next(self) -> Optional[T]:
        """
        Get next record in current position

        Returns:
            Next record or None if EOF/error
        """
        if not self._is_open:
            return None

        status, data = self.client.get_next()
        if status == BtrStatus.SUCCESS:
            try:
                return self.from_bytes(data)
            except Exception as e:
                logger.error(f"Failed to deserialize record: {e}")
                return None
        elif status == BtrStatus.END_OF_FILE:
            return None
        else:
            logger.error(f"Failed to get next record: {status}")
            return None

    def get_all(self, max_records: int = 10000) -> List[T]:
        """
        Get all records from table

        Args:
            max_records: Maximum number of records to retrieve (safety limit)

        Returns:
            List of all records
        """
        records = []

        if not self._is_open:
            if not self.open():
                return records

        # Get first
        record = self.get_first()
        if record:
            records.append(record)
        else:
            return records

        # Get rest
        while len(records) < max_records:
            record = self.get_next()
            if record is None:
                break
            records.append(record)

        logger.info(f"Retrieved {len(records)} records from {self.table_name}")
        return records

    def find(self, predicate: Callable[[T], bool], max_results: int = 100) -> List[T]:
        """
        Find records matching predicate

        Args:
            predicate: Function that returns True for matching records
            max_results: Maximum number of results

        Returns:
            List of matching records
        """
        results = []

        if not self._is_open:
            if not self.open():
                return results

        record = self.get_first()
        while record and len(results) < max_results:
            if predicate(record):
                results.append(record)
            record = self.get_next()

        logger.debug(f"Found {len(results)} matching records in {self.table_name}")
        return results

    def find_one(self, predicate: Callable[[T], bool]) -> Optional[T]:
        """
        Find first record matching predicate

        Args:
            predicate: Function that returns True for matching record

        Returns:
            First matching record or None
        """
        if not self._is_open:
            if not self.open():
                return None

        record = self.get_first()
        while record:
            if predicate(record):
                return record
            record = self.get_next()

        return None

    def count(self) -> int:
        """
        Count all records in table

        Returns:
            Number of records
        """
        count = 0

        if not self._is_open:
            if not self.open():
                return 0

        if self.get_first():
            count = 1
            while self.get_next():
                count += 1

        logger.info(f"Table {self.table_name} has {count} records")
        return count

    def exists(self, predicate: Callable[[T], bool]) -> bool:
        """
        Check if any record matches predicate

        Args:
            predicate: Function that returns True for matching record

        Returns:
            True if at least one match found
        """
        return self.find_one(predicate) is not None

    def validate_all(self) -> dict:
        """
        Validate all records in table

        Returns:
            Dict with validation results:
            {
                'total': int,
                'valid': int,
                'invalid': int,
                'errors': [(record, [errors]), ...]
            }
        """
        results = {
            'total': 0,
            'valid': 0,
            'invalid': 0,
            'errors': []
        }

        if not self._is_open:
            if not self.open():
                return results

        record = self.get_first()
        while record:
            results['total'] += 1

            # Check if record has validate method
            if hasattr(record, 'validate'):
                errors = record.validate()
                if errors:
                    results['invalid'] += 1
                    results['errors'].append((record, errors))
                else:
                    results['valid'] += 1
            else:
                results['valid'] += 1

            record = self.get_next()

        logger.info(f"Validation: {results['valid']}/{results['total']} valid, "
                    f"{results['invalid']} invalid")
        return results


class ReadOnlyRepository(BaseRepository[T], ABC):
    """
    Read-only repository (no write operations)
    Use for tables that should not be modified from Python
    """

    def insert(self, record: T):
        """Not implemented for read-only repository"""
        raise NotImplementedError("Insert not allowed on read-only repository")

    def update(self, record: T):
        """Not implemented for read-only repository"""
        raise NotImplementedError("Update not allowed on read-only repository")

    def delete(self, record: T):
        """Not implemented for read-only repository"""
        raise NotImplementedError("Delete not allowed on read-only repository")


class CRUDRepository(BaseRepository[T], ABC):
    """
    Full CRUD repository with write operations

    Note: Btrieve write operations are complex and require careful handling.
    For production use, consider testing thoroughly.
    """

    def insert(self, record: T) -> bool:
        """
        Insert new record

        Args:
            record: Model instance to insert

        Returns:
            True if successful
        """
        if not self._is_open:
            if not self.open():
                return False

        # Validate before insert
        if hasattr(record, 'validate'):
            errors = record.validate()
            if errors:
                logger.error(f"Validation failed: {errors}")
                return False

        try:
            data = self.to_bytes(record)
            status = self.client.insert(data)
            if status == BtrStatus.SUCCESS:
                logger.info(f"Inserted record into {self.table_name}")
                return True
            else:
                logger.error(f"Insert failed: {status}")
                return False
        except Exception as e:
            logger.error(f"Insert error: {e}")
            return False

    def update(self, record: T) -> bool:
        """
        Update existing record

        Args:
            record: Model instance to update

        Returns:
            True if successful
        """
        if not self._is_open:
            if not self.open():
                return False

        # Validate before update
        if hasattr(record, 'validate'):
            errors = record.validate()
            if errors:
                logger.error(f"Validation failed: {errors}")
                return False

        try:
            data = self.to_bytes(record)
            status = self.client.update(data)
            if status == BtrStatus.SUCCESS:
                logger.info(f"Updated record in {self.table_name}")
                return True
            else:
                logger.error(f"Update failed: {status}")
                return False
        except Exception as e:
            logger.error(f"Update error: {e}")
            return False

    def delete_current(self) -> bool:
        """
        Delete current record (at current position)

        Returns:
            True if successful
        """
        if not self._is_open:
            return False

        status = self.client.delete()
        if status == BtrStatus.SUCCESS:
            logger.info(f"Deleted record from {self.table_name}")
            return True
        else:
            logger.error(f"Delete failed: {status}")
            return False