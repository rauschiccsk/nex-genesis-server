# src/utils/__init__.py
"""
Utilities Module

Configuration management and helper functions
"""

from .config import load_config, get_database_path, validate_paths

__all__ = [
    'load_config',
    'get_database_path', 
    'validate_paths',
]

__version__ = '0.2.1'