# Btrieve Bridge Service (Future Design)

## 🎯 Účel

Alternatívne
riešenie
pre
64 - bit
Python
kompatibilitu.

** Problém: ** 64 - bit
Python
nemôže
načítať
32 - bit
wxqlcall.dll
** Riešenie: ** Malá
32 - bit
služba
ktorá
poskytuje
Btrieve
API
cez
HTTP

---

## 🏗️ Architektúra

```
┌────────────────────────────────────────────────────────┐
│  NEX
Genesis
Server(64 - bit
Python)                    │
│  ├─ FastAPI
main
application                           │
│  ├─ Business
logic(ISDOC
parsing, validation)         │
│  ├─ Product / Delivery
Note
services                     │
│  └─ HTTP
Client → calls
Btrieve
Bridge                 │
└──────────────────┬─────────────────────────────────────┘
│
│ HTTP / REST(localhost: 8001)
│ JSON
requests / responses
│
▼
┌────────────────────────────────────────────────────────┐
│  Btrieve
Bridge
Service(32 - bit
Python)                │
│  ├─ Minimal
Flask / FastAPI
app                          │
│  ├─ Only
database
operations                           │
│  ├─ BtrieveClient
wrapper                              │
│  └─ ctypes → wxqlcall.dll(32 - bit)                     │
└──────────────────┬─────────────────────────────────────┘
│
│ Direct
DLL
calls
│
▼
┌────────────────────────────────────────────────────────┐
│  NEX
Genesis
Database(Pervasive
Btrieve)              │
│  ├─ GSCAT.BTR, BARCODE.BTR, etc.                       │
│  └─ C:\NEX\YEARACT\STORES\                             │
└────────────────────────────────────────────────────────┘
```

---

## 📋 API Endpoints (Bridge)

### 1. Open Table
```http
POST / api / table / open
Content - Type: application / json

{
    "table_name": "gscat"
}

Response:
{
    "success": true,
    "table_id": "gscat_session_123"
}
```

### 2. Get First Record
```http
POST / api / table / get - first
Content - Type: application / json

{
    "table_id": "gscat_session_123",
    "key_number": 0
}

Response:
{
    "success": true,
    "status": 0,
    "data": "base64_encoded_record_data",
    "length": 1024
}
```

### 3. Get Next Record
```http
POST / api / table / get - next
Content - Type: application / json

{
    "table_id": "gscat_session_123",
    "key_number": 0
}

Response:
{
    "success": true,
    "status": 0,
    "data": "base64_encoded_record_data"
}
```

### 4. Get Equal (Search)
```http
POST / api / table / get - equal
Content - Type: application / json

{
    "table_id": "gscat_session_123",
    "key_value": "base64_encoded_key",
    "key_number": 0
}

Response:
{
    "success": true,
    "status": 0,
    "data": "base64_encoded_record_data"
}
```

### 5. Insert Record
```http
POST / api / table / insert
Content - Type: application / json

{
    "table_id": "gscat_session_123",
    "data": "base64_encoded_record_data"
}

Response:
{
    "success": true,
    "status": 0
}
```

### 6. Close Table
```http
POST / api / table / close
Content - Type: application / json

{
    "table_id": "gscat_session_123"
}

Response:
{
    "success": true
}
```

### 7. Health Check
```http
GET / health

Response:
{
    "status": "ok",
    "version": "1.0.0",
    "python_bits": 32,
    "dll_loaded": true
}
```

---

## 💻 Implementation

### Bridge Service (32-bit Python)

** File: ** `bridge_service / main.py`

```python
"""
Btrieve Bridge Service
32-bit Python FastAPI service for Btrieve database access
"""

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import base64
import uuid
from typing import Dict, Optional

# Import Btrieve client (32-bit compatible)
from btrieve_client import BtrieveClient, BtrStatus

app = FastAPI(title="Btrieve Bridge Service")

# Session management
sessions: Dict[str, BtrieveClient] = {}


# Models
class OpenTableRequest(BaseModel):
    table_name: str


class GetFirstRequest(BaseModel):
    table_id: str
    key_number: int = 0


class GetEqualRequest(BaseModel):
    table_id: str
    key_value: str  # base64
    key_number: int = 0


class InsertRequest(BaseModel):
    table_id: str
    data: str  # base64


class CloseTableRequest(BaseModel):
    table_id: str


# Endpoints
@app.post("/api/table/open")
async def open_table(req: OpenTableRequest):
    """Open Btrieve table"""
    try:
        client = BtrieveClient()
        status = client.open_table(req.table_name)

        if status == BtrStatus.SUCCESS:
            table_id = f"{req.table_name}_{uuid.uuid4().hex[:8]}"
            sessions[table_id] = client
            return {"success": True, "table_id": table_id}
        else:
            raise HTTPException(400, f"Failed to open table: status={status}")

    except Exception as e:
        raise HTTPException(500, str(e))


@app.post("/api/table/get-first")
async def get_first(req: GetFirstRequest):
    """Get first record"""
    if req.table_id not in sessions:
        raise HTTPException(404, "Table session not found")

    client = sessions[req.table_id]
    status, data = client.get_first(req.key_number)

    return {
        "success": status == BtrStatus.SUCCESS,
        "status": status,
        "data": base64.b64encode(data).decode() if data else None,
        "length": len(data)
    }


@app.post("/api/table/get-next")
async def get_next(req: GetFirstRequest):
    """Get next record"""
    if req.table_id not in sessions:
        raise HTTPException(404, "Table session not found")

    client = sessions[req.table_id]
    status, data = client.get_next(req.key_number)

    return {
        "success": status == BtrStatus.SUCCESS,
        "status": status,
        "data": base64.b64encode(data).decode() if data else None,
        "length": len(data)
    }


@app.post("/api/table/get-equal")
async def get_equal(req: GetEqualRequest):
    """Get record by key"""
    if req.table_id not in sessions:
        raise HTTPException(404, "Table session not found")

    client = sessions[req.table_id]
    key_value = base64.b64decode(req.key_value)
    status, data = client.get_equal(key_value, req.key_number)

    return {
        "success": status == BtrStatus.SUCCESS,
        "status": status,
        "data": base64.b64encode(data).decode() if data else None
    }


@app.post("/api/table/insert")
async def insert_record(req: InsertRequest):
    """Insert new record"""
    if req.table_id not in sessions:
        raise HTTPException(404, "Table session not found")

    client = sessions[req.table_id]
    record_data = base64.b64decode(req.data)
    status = client.insert(record_data)

    return {
        "success": status == BtrStatus.SUCCESS,
        "status": status
    }


@app.post("/api/table/close")
async def close_table(req: CloseTableRequest):
    """Close table"""
    if req.table_id not in sessions:
        raise HTTPException(404, "Table session not found")

    client = sessions[req.table_id]
    status = client.close_file()
    del sessions[req.table_id]

    return {"success": status == BtrStatus.SUCCESS}


@app.get("/health")
async def health_check():
    """Health check"""
    import platform
    return {
        "status": "ok",
        "version": "1.0.0",
        "python_bits": platform.architecture()[0],
        "dll_loaded": True,
        "active_sessions": len(sessions)
    }


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="127.0.0.1", port=8001)
```

---

### Main Application Client (64-bit Python)

** File: ** `src / btrieve / bridge_client.py`

```python
"""
Btrieve Bridge Client
Communicates with 32-bit bridge service via HTTP
"""

import requests
import base64
from typing import Tuple


class BtrieveBridgeClient:
    """Client for Btrieve Bridge Service"""

    def __init__(self, bridge_url: str = "http://127.0.0.1:8001"):
        self.bridge_url = bridge_url
        self.table_id = None

    def open_table(self, table_name: str) -> int:
        """Open table via bridge"""
        response = requests.post(
            f"{self.bridge_url}/api/table/open",
            json={"table_name": table_name}
        )

        if response.ok:
            data = response.json()
            self.table_id = data["table_id"]
            return 0  # SUCCESS
        else:
            return 12  # FILE_NOT_FOUND

    def get_first(self, key_number: int = 0) -> Tuple[int, bytes]:
        """Get first record"""
        response = requests.post(
            f"{self.bridge_url}/api/table/get-first",
            json={"table_id": self.table_id, "key_number": key_number}
        )

        data = response.json()
        if data["success"]:
            record = base64.b64decode(data["data"]) if data["data"] else b""
            return (data["status"], record)
        else:
            return (data["status"], b"")

    def get_next(self, key_number: int = 0) -> Tuple[int, bytes]:
        """Get next record"""
        response = requests.post(
            f"{self.bridge_url}/api/table/get-next",
            json={"table_id": self.table_id, "key_number": key_number}
        )

        data = response.json()
        record = base64.b64decode(data["data"]) if data["data"] else b""
        return (data["status"], record)

    def close_file(self) -> int:
        """Close table"""
        response = requests.post(
            f"{self.bridge_url}/api/table/close",
            json={"table_id": self.table_id}
        )

        return 0 if response.ok else 16


```

---

## 🚀 Deployment

### 1. Build 32-bit Bridge Service
```powershell
# Install 32-bit Python
# Create venv
py - 3.13 - 32 - m
venv
bridge_venv

# Activate
.\bridge_venv\Scripts\activate

# Install dependencies
pip
install
fastapi
uvicorn

# Copy bridge files
bridge_service /
├─ main.py
├─ btrieve_client.py
└─ config.py
```

### 2. Run Bridge Service (32-bit)
```powershell
cd
bridge_service
py - 3.13 - 32 - m
uvicorn
main: app - -host
127.0
.0
.1 - -port
8001
```

### 3. Run Main Application (64-bit)
```powershell
cd..
python
main.py  # 64-bit Python OK!
```

---

## ✅ Advantages

1. ** 64 - bit
Main
App ** - Moderný
Python
2. ** Small
Bridge ** - Len
Btrieve
operácie
3. ** Separation ** - Business
logic
oddělená
od
DB
4. ** Scalable ** - Bridge
môže
byť
na
inom
serveri
5. ** Testable ** - Mock
bridge
pre
testing

---

## ⚠️ Disadvantages

1. ** Complexity ** - Dva
procesy
namiesto
jedného
2. ** Latency ** - HTTP
overhead
3. ** Management ** - Dva
services
na
správu
4. ** Debugging ** - Komplikovanejšie

---

## 📊 When to Use

### Use Bridge Service if:
- ✅ Hlavná
aplikácia
musí
byť
64 - bit
- ✅ Deployment
na
server
bez
32 - bit
Python
- ✅ Múltiple
aplikácie
pristupujú
k
Btrieve
- ✅ Load
balancing
potrebný

### Use Direct 32-bit if:
- ✅ Development
environment
- ✅ Single
application
- ✅ Simplicity
preferred
- ✅ Low
latency
required

---

## 🎯 Current Recommendation

** Pre
NEX
Genesis
Server: **

** Phase
1(Development): **
→ Use
32 - bit
Python
directly(Option
A)

** Phase
2(Production): **
→ Consider
Bridge
Service if needed

** Dôvod: ** Jednoduchosť
a
výkon
pre
začiatok.

---

** Status: ** Future
Design(Not
Implemented)
** Priority: ** LOW(Option
A
preferred)
** Created: ** 2025 - 10 - 22
** Author: ** ICC(rausch @ icc.sk)