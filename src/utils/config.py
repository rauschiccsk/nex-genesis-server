"""
NEX Genesis Server - Configuration Manager
Loads database paths and settings from YAML
"""

import yaml
import os
from typing import Dict, Any

class Config:
    """Configuration manager for NEX Genesis Server"""

    def __init__(self, config_file: str = "config/database.yaml"):
        """
        Load configuration from YAML file

        Args:
            config_file: Path to YAML config file
        """
        self.config_file = config_file
        self.config = self._load_config()

    def _load_config(self) -> Dict[str, Any]:
        """Load YAML configuration"""
        if not os.path.exists(self.config_file):
            raise FileNotFoundError(f"Config file not found: {self.config_file}")

        with open(self.config_file, 'r', encoding='utf-8') as f:
            return yaml.safe_load(f)

    def get_book_number(self) -> str:
        """
        Get current book number (e.g., '001')

        Returns:
            Book number as 3-digit string
        """
        return self.config['nex_genesis']['books']['delivery_notes_book']

    def get_book_type(self) -> str:
        """
        Get book type (A=actual, P=previous)

        Returns:
            'A' or 'P'
        """
        return self.config['nex_genesis']['books']['book_type']

    def get_table_path(self, table_name: str) -> str:
        """
        Get path to database table file

        Args:
            table_name: Table name (gscat, barcode, tsh, tsi, etc.)

        Returns:
            Full path to .BTR file
        """
        tables = self.config['nex_genesis']['tables']
        if table_name.lower() not in tables:
            raise ValueError(f"Unknown table: {table_name}")

        path = tables[table_name.lower()]

        # Handle TSH/TSI dynamic paths
        if '{book_number}' in path:
            book_num = self.get_book_number()
            path = path.replace('{book_number}', book_num)

        if '{book_type}' in path:
            book_type = self.get_book_type()
            path = path.replace('{book_type}', book_type)

        return path

    def get_definition_path(self, table_name: str) -> str:
        """
        Get path to table definition file

        Args:
            table_name: Table name

        Returns:
            Full path to .bdf file
        """
        definitions = self.config['nex_genesis']['definitions']
        if table_name.lower() not in definitions:
            raise ValueError(f"Unknown definition: {table_name}")

        return definitions[table_name.lower()]

    def get_dll_path(self) -> str:
        """Get Btrieve DLL directory path"""
        return self.config['btrieve']['dll_path']

    def get_root_path(self) -> str:
        """Get NEX root path"""
        return self.config['nex_genesis']['root_path']

    def get_stores_path(self) -> str:
        """Get STORES directory path (stock management)"""
        return self.config['nex_genesis']['database']['stores_path']

    def get_dials_path(self) -> str:
        """Get DIALS directory path (reference tables)"""
        return self.config['nex_genesis']['database']['dials_path']

    def get_dbidef_path(self) -> str:
        """Get DBIDEF directory path (definitions)"""
        return self.config['nex_genesis']['database']['dbidef_path']

    def get_tsh_filename(self, book_number: str = None) -> str:
        """
        Get TSH filename (e.g., 'TSHA-001.BTR')

        Args:
            book_number: Override book number (default: from config)

        Returns:
            Filename only (not full path)
        """
        book_type = self.get_book_type()
        book_num = book_number or self.get_book_number()
        return f"TSH{book_type}-{book_num}.BTR"

    def get_tsi_filename(self, book_number: str = None) -> str:
        """
        Get TSI filename (e.g., 'TSIA-001.BTR')

        Args:
            book_number: Override book number (default: from config)

        Returns:
            Filename only (not full path)
        """
        book_type = self.get_book_type()
        book_num = book_number or self.get_book_number()
        return f"TSI{book_type}-{book_num}.BTR"

    def validate_paths(self) -> bool:
        """
        Validate that all configured paths exist

        Returns:
            True if all paths valid, False otherwise
        """
        errors = []
        warnings = []

        # Check root path
        root = self.get_root_path()
        if not os.path.exists(root):
            errors.append(f"❌ Root path not found: {root}")
        else:
            print(f"✅ Root path: {root}")

        # Check STORES directory
        stores = self.get_stores_path()
        if not os.path.exists(stores):
            errors.append(f"❌ STORES path not found: {stores}")
        else:
            print(f"✅ STORES path: {stores}")

        # Check DIALS directory
        dials = self.get_dials_path()
        if not os.path.exists(dials):
            errors.append(f"❌ DIALS path not found: {dials}")
        else:
            print(f"✅ DIALS path: {dials}")

        # Check DBIDEF directory
        dbidef = self.get_dbidef_path()
        if not os.path.exists(dbidef):
            errors.append(f"❌ DBIDEF path not found: {dbidef}")
        else:
            print(f"✅ DBIDEF path: {dbidef}")

        # Check table files
        print("\n📋 Checking table files:")
        for table_name in ['gscat', 'barcode', 'mglst', 'pab', 'tsh', 'tsi']:
            try:
                table_path = self.get_table_path(table_name)
                if not os.path.exists(table_path):
                    warnings.append(f"⚠️  Table not found: {table_path}")
                else:
                    print(f"✅ {table_name.upper()}: {table_path}")
            except Exception as e:
                errors.append(f"❌ Error checking {table_name}: {e}")

        # Print results
        if errors:
            print("\n❌ ERRORS:")
            print("=" * 60)
            for error in errors:
                print(error)

        if warnings:
            print("\n⚠️  WARNINGS:")
            print("=" * 60)
            for warning in warnings:
                print(warning)

        if not errors and not warnings:
            print("\n✅ All paths validated successfully!")

        return len(errors) == 0


# Global config instance
_config = None

def get_config() -> Config:
    """Get global config instance"""
    global _config
    if _config is None:
        _config = Config()
    return _config


# Usage example
if __name__ == "__main__":
    config = Config()

    print("\n📊 NEX Genesis Configuration")
    print("=" * 60)
    print(f"Root path: {config.get_root_path()}")
    print(f"STORES path: {config.get_stores_path()}")
    print(f"DIALS path: {config.get_dials_path()}")
    print(f"DLL path: {config.get_dll_path()}")
    print()
    print("Book settings:")
    print(f"  Book number: {config.get_book_number()}")
    print(f"  Book type: {config.get_book_type()}")
    print(f"  TSH filename: {config.get_tsh_filename()}")
    print(f"  TSI filename: {config.get_tsi_filename()}")
    print()
    print("Table paths:")
    for table in ['gscat', 'barcode', 'mglst', 'pab', 'tsh', 'tsi']:
        try:
            print(f"  {table.upper()}: {config.get_table_path(table)}")
        except Exception as e:
            print(f"  {table.upper()}: ERROR - {e}")
    print()

    # Validate
    config.validate_paths()