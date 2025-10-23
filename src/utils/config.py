"""
NEX Genesis Btrieve Bridge API - Dependencies

Dependency injection pre FastAPI endpoints.
Poskytuje singleton instances pre Btrieve client, repositories, config, etc.
"""

import logging
import yaml
from pathlib import Path
from functools import lru_cache
from typing import Annotated

from fastapi import Depends

from ..btrieve.btrieve_client import BtrieveClient
from ..repositories import (
    GSCATRepository,
    PABRepository,
    BarcodeRepository
)
from ..utils.isdoc_mapper import ISDOCToNEXMapper

logger = logging.getLogger(__name__)

# Singleton instances
_btrieve_client = None
_config = None


@lru_cache()
def get_config() -> dict:
    """
    Získa Config singleton.

    Returns:
        dict with config data
    """
    global _config
    if _config is None:
        config_path = Path("config/database.yaml")
        with open(config_path, 'r', encoding='utf-8') as f:
            _config = yaml.safe_load(f)
        logger.info("✅ Config loaded")
    return _config


def get_btrieve_client(
        config: Annotated[dict, Depends(get_config)]
) -> BtrieveClient:
    """
    Získa BtrieveClient singleton.

    Args:
        config: Config dict (injected)

    Returns:
        BtrieveClient instance

    Note:
        BtrieveClient je singleton - vytvorí sa len raz pri prvom použití.
    """
    global _btrieve_client
    if _btrieve_client is None:
        _btrieve_client = BtrieveClient(config)
        logger.info("✅ BtrieveClient initialized")
    return _btrieve_client


def get_gscat_repository(
        btrieve_client: Annotated[BtrieveClient, Depends(get_btrieve_client)]
) -> GSCATRepository:
    """
    Získa GSCATRepository (produktový katalóg).

    Args:
        btrieve_client: BtrieveClient instance (injected)

    Returns:
        GSCATRepository instance
    """
    return GSCATRepository(btrieve_client)


def get_pab_repository(
        btrieve_client: Annotated[BtrieveClient, Depends(get_btrieve_client)]
) -> PABRepository:
    """
    Získa PABRepository (obchodní partneri).

    Args:
        btrieve_client: BtrieveClient instance (injected)

    Returns:
        PABRepository instance
    """
    return PABRepository(btrieve_client)


def get_barcode_repository(
        btrieve_client: Annotated[BtrieveClient, Depends(get_btrieve_client)]
) -> BarcodeRepository:
    """
    Získa BarcodeRepository (čiarové kódy).

    Args:
        btrieve_client: BtrieveClient instance (injected)

    Returns:
        BarcodeRepository instance
    """
    return BarcodeRepository(btrieve_client)


@lru_cache()
def get_isdoc_mapper() -> ISDOCToNEXMapper:
    """
    Získa ISDOCToNEXMapper singleton.

    Returns:
        ISDOCToNEXMapper instance
    """
    return ISDOCToNEXMapper()


# Type aliases pre jednoduchšie použitie v endpoints
ConfigDep = Annotated[dict, Depends(get_config)]
BtrieveClientDep = Annotated[BtrieveClient, Depends(get_btrieve_client)]
GSCATRepositoryDep = Annotated[GSCATRepository, Depends(get_gscat_repository)]
PABRepositoryDep = Annotated[PABRepository, Depends(get_pab_repository)]
BarcodeRepositoryDep = Annotated[BarcodeRepository, Depends(get_barcode_repository)]
ISDOCMapperDep = Annotated[ISDOCToNEXMapper, Depends(get_isdoc_mapper)]