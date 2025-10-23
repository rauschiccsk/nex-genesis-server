"""
NEX Genesis Btrieve Bridge API - Invoice Import Tests

Testy pre /api/v1/invoices/import endpoint.
"""

import pytest
from fastapi.testclient import TestClient
from decimal import Decimal

from src.api.main import app

# Test client
client = TestClient(app)


def test_health_check():
    """Test health check endpoint."""
    response = client.get("/health")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert data["service"] == "nex-genesis-btrieve-bridge"
    assert data["version"] == "1.0.0"


def test_root_endpoint():
    """Test root endpoint."""
    response = client.get("/")
    assert response.status_code == 200
    data = response.json()
    assert data["service"] == "NEX Genesis Btrieve Bridge API"
    assert data["version"] == "1.0.0"


def test_invoice_import_valid():
    """
    Test invoice import with valid ISDOC data.

    Note: Tento test vyžaduje bežiacu NEX Genesis DEV databázu.
    """
    invoice_data = {
        "invoice_number": "TEST2025001",
        "invoice_date": "2025-10-23",
        "due_date": "2025-11-23",
        "tax_point_date": "2025-10-23",
        "supplier": {
            "name": "Test Supplier s.r.o.",
            "ico": "99999999",
            "dic": "9999999999",
            "ic_dph": "SK9999999999",
            "street": "Testovacia 123",
            "city": "Bratislava",
            "zip": "82109",
            "country": "SK"
        },
        "customer": {
            "name": "Test Customer s.r.o.",
            "ico": "88888888",
            "dic": "8888888888",
            "ic_dph": "SK8888888888",
            "street": "Testovacia 456",
            "city": "Komárno",
            "zip": "94501",
            "country": "SK"
        },
        "items": [
            {
                "line_number": 1,
                "item_code": "TEST001",
                "item_name": "Test Product 1",
                "quantity": 5.0,
                "unit": "KS",
                "unit_price": 100.0,
                "vat_rate": 20.0,
                "line_total": 500.0,
                "ean": "8590000999999"
            }
        ],
        "total_amount": 600.0,
        "total_vat": 100.0,
        "total_without_vat": 500.0,
        "variable_symbol": "TEST2025001"
    }

    response = client.post("/api/v1/invoices/import", json=invoice_data)

    # Should return 200 OK
    assert response.status_code == 200

    data = response.json()

    # Check response structure
    assert "status" in data
    assert "message" in data
    assert "supplier_created" in data
    assert "customer_created" in data
    assert "products_created" in data
    assert "products_updated" in data
    assert "barcodes_created" in data
    assert "errors" in data
    assert "warnings" in data

    # Status should be success or partial
    assert data["status"] in ["success", "partial"]

    # IČO should match
    assert data["supplier_ico"] == "99999999"
    assert data["customer_ico"] == "88888888"

    # Should have product codes
    assert "TEST001" in data["product_codes"]

    print(f"✅ Invoice import test passed")
    print(f"   Status: {data['status']}")
    print(f"   Message: {data['message']}")
    print(f"   Products created: {data['products_created']}")
    print(f"   Products updated: {data['products_updated']}")


def test_invoice_import_missing_supplier_ico():
    """Test invoice import with missing supplier IČO."""
    invoice_data = {
        "invoice_number": "TEST2025002",
        "invoice_date": "2025-10-23",
        "supplier": {
            "name": "Test Supplier s.r.o.",
            # ico missing!
        },
        "customer": {
            "name": "Test Customer s.r.o.",
            "ico": "88888888"
        },
        "items": [
            {
                "line_number": 1,
                "item_code": "TEST001",
                "item_name": "Test Product 1",
                "quantity": 5.0,
                "unit": "KS",
                "unit_price": 100.0,
                "vat_rate": 20.0,
                "line_total": 500.0
            }
        ],
        "total_amount": 600.0,
        "total_vat": 100.0,
        "total_without_vat": 500.0
    }

    response = client.post("/api/v1/invoices/import", json=invoice_data)

    # Should return 400 Bad Request
    assert response.status_code == 400

    data = response.json()
    assert "detail" in data
    assert "errors" in data["detail"]

    # Should have validation error for supplier.ico
    errors = data["detail"]["errors"]
    assert any(e["field"] == "supplier.ico" for e in errors)


def test_invoice_import_empty_items():
    """Test invoice import with empty items list."""
    invoice_data = {
        "invoice_number": "TEST2025003",
        "invoice_date": "2025-10-23",
        "supplier": {
            "name": "Test Supplier s.r.o.",
            "ico": "99999999"
        },
        "customer": {
            "name": "Test Customer s.r.o.",
            "ico": "88888888"
        },
        "items": [],  # Empty items!
        "total_amount": 0.0,
        "total_vat": 0.0,
        "total_without_vat": 0.0
    }

    response = client.post("/api/v1/invoices/import", json=invoice_data)

    # Should return 400 Bad Request
    assert response.status_code == 400

    data = response.json()
    assert "detail" in data
    assert "errors" in data["detail"]

    # Should have validation error for items
    errors = data["detail"]["errors"]
    assert any(e["field"] == "items" for e in errors)


def test_invoice_import_invalid_quantity():
    """Test invoice import with invalid (negative) quantity."""
    invoice_data = {
        "invoice_number": "TEST2025004",
        "invoice_date": "2025-10-23",
        "supplier": {
            "name": "Test Supplier s.r.o.",
            "ico": "99999999"
        },
        "customer": {
            "name": "Test Customer s.r.o.",
            "ico": "88888888"
        },
        "items": [
            {
                "line_number": 1,
                "item_code": "TEST001",
                "item_name": "Test Product 1",
                "quantity": -5.0,  # Invalid quantity!
                "unit": "KS",
                "unit_price": 100.0,
                "vat_rate": 20.0,
                "line_total": -500.0
            }
        ],
        "total_amount": -600.0,
        "total_vat": -100.0,
        "total_without_vat": -500.0
    }

    response = client.post("/api/v1/invoices/import", json=invoice_data)

    # Should return 400 Bad Request
    assert response.status_code == 400

    data = response.json()
    assert "detail" in data
    assert "errors" in data["detail"]

    # Should have validation error for quantity
    errors = data["detail"]["errors"]
    assert any("quantity" in e["field"] for e in errors)


if __name__ == "__main__":
    # Run tests with pytest
    pytest.main([__file__, "-v"])