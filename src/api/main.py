"""
NEX Genesis Btrieve Bridge API - Main Application

FastAPI aplikácia pre NEX Genesis ERP databázové operácie.
"""

import logging
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from .routers import invoices

# Logging setup
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


# Lifecycle events
@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Startup and shutdown events.
    """
    # Startup
    logger.info("🚀 NEX Genesis Btrieve Bridge API starting...")
    logger.info("📡 API docs available at: http://localhost:8001/docs")
    logger.info("📊 ReDoc available at: http://localhost:8001/redoc")

    yield

    # Shutdown
    logger.info("🛑 NEX Genesis Btrieve Bridge API shutting down...")


# FastAPI application
app = FastAPI(
    title="NEX Genesis Btrieve Bridge API",
    description="""
    REST API pre NEX Genesis ERP databázové operácie cez Btrieve.

    ## Features

    * **Invoice Import** - Import ISDOC faktúr do NEX Genesis
    * **Partners Management** - CRUD operácie pre obchodných partnerov (PAB)
    * **Products Management** - CRUD operácie pre produktový katalóg (GSCAT)
    * **Deliveries Management** - CRUD operácie pre dodacie listy (TSH/TSI)

    ## Architecture

    Táto API slúži ako dátová vrstva (data access layer) pre NEX Genesis ERP.
    Poskytuje REST interface pre Btrieve databázové operácie.

    **Určené pre:**
    - Supplier Invoice Loader (hlavný klient)
    - NEX Automat (Delphi aplikácia)
    - Ďalšie interné nástroje

    **Beží lokálne na:** `localhost:8001`
    """,
    version="1.0.0",
    lifespan=lifespan,
    docs_url="/docs",
    redoc_url="/redoc"
)

# CORS middleware - localhost only
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:8000",  # Supplier Invoice Loader
        "http://localhost:8001",  # Self
        "http://127.0.0.1:8000",
        "http://127.0.0.1:8001"
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Global exception handler
@app.exception_handler(Exception)
async def global_exception_handler(request, exc):
    """
    Globálny handler pre neošetrené výjimky.
    """
    logger.error(f"Unhandled exception: {exc}", exc_info=True)
    return JSONResponse(
        status_code=500,
        content={
            "error": "Internal server error",
            "detail": str(exc),
            "type": type(exc).__name__
        }
    )


# Routers
app.include_router(
    invoices.router,
    prefix="/api/v1/invoices",
    tags=["invoices"]
)


# Health check endpoint
@app.get("/health", tags=["health"])
async def health_check():
    """
    Health check endpoint - overí, či API beží.
    """
    return {
        "status": "healthy",
        "service": "nex-genesis-btrieve-bridge",
        "version": "1.0.0"
    }


# Root endpoint
@app.get("/", tags=["root"])
async def root():
    """
    Root endpoint - základné info o API.
    """
    return {
        "service": "NEX Genesis Btrieve Bridge API",
        "version": "1.0.0",
        "docs": "http://localhost:8001/docs",
        "health": "http://localhost:8001/health"
    }