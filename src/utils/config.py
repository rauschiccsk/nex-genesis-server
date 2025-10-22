# src/utils/config.py
"""
Configuration Management

YAML-based configuration loader for NEX Genesis Server
"""

import yaml
from pathlib import Path
from typing import Dict, Any, Optional

def load_config(config_path: Optional[str] = None) -> Dict[str, Any]:
    """
    Load configuration from YAML file

    Args:
        config_path: Path to config file (default: config/database.yaml)

    Returns:
        Configuration dictionary
    """
    if config_path is None:
        # Default to config/database.yaml
        config_path = Path(__file__).parent.parent.parent / "config" / "database.yaml"
    else:
        config_path = Path(config_path)

    if not config_path.exists():
        raise FileNotFoundError(f"Config file not found: {config_path}")

    with open(config_path, 'r', encoding='utf-8') as f:
        config = yaml.safe_load(f)

    return config


def get_database_path(config: Dict[str, Any], table_name: str) -> Path:
    """
    Get full path to a database table file

    Args:
        config: Configuration dictionary
        table_name: Table name (e.g., 'GSCAT', 'PAB', 'TSH')

    Returns:
        Full path to table file
    """
    db_config = config.get('database', {})

    # Determine which directory (STORES or DIALS)
    if table_name in ['GSCAT', 'BARCODE', 'MGLST', 'TSH', 'TSI']:
        base_path = Path(db_config['stores_path'])
    elif table_name == 'PAB':
        base_path = Path(db_config['dials_path'])
    else:
        raise ValueError(f"Unknown table: {table_name}")

    # Determine filename
    if table_name in ['GSCAT', 'BARCODE', 'MGLST']:
        filename = f"{table_name}.BTR"
    elif table_name == 'PAB':
        filename = "PAB00000.BTR"
    elif table_name == 'TSH':
        book = db_config.get('book_number', '001')
        book_type = db_config.get('book_type', 'A')
        filename = f"TSH{book_type}-{book}.BTR"
    elif table_name == 'TSI':
        book = db_config.get('book_number', '001')
        book_type = db_config.get('book_type', 'A')
        filename = f"TSI{book_type}-{book}.BTR"

    return base_path / filename


def validate_paths(config: Dict[str, Any]) -> bool:
    """
    Validate that all configured paths exist

    Args:
        config: Configuration dictionary

    Returns:
        True if all paths valid
    """
    db_config = config.get('database', {})

    # Check root path
    root_path = Path(db_config['path'])
    if not root_path.exists():
        print(f"❌ Root path not found: {root_path}")
        return False

    # Check STORES path
    stores_path = Path(db_config['stores_path'])
    if not stores_path.exists():
        print(f"❌ STORES path not found: {stores_path}")
        return False

    # Check DIALS path
    dials_path = Path(db_config['dials_path'])