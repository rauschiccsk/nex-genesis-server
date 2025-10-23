#!/usr/bin/env python
"""
NEX Genesis Btrieve Bridge API - Startup Script

Spustí FastAPI server na porte 8001.

Usage:
    python run_api.py

    # Alebo s custom portom:
    python run_api.py --port 8002

    # Development mode (auto-reload):
    python run_api.py --reload
"""

import sys
import argparse
import uvicorn


def main():
    parser = argparse.ArgumentParser(
        description="NEX Genesis Btrieve Bridge API Server"
    )
    parser.add_argument(
        "--host",
        type=str,
        default="127.0.0.1",
        help="Host to bind to (default: 127.0.0.1)"
    )
    parser.add_argument(
        "--port",
        type=int,
        default=8001,
        help="Port to bind to (default: 8001)"
    )
    parser.add_argument(
        "--reload",
        action="store_true",
        help="Enable auto-reload for development"
    )
    parser.add_argument(
        "--log-level",
        type=str,
        default="info",
        choices=["critical", "error", "warning", "info", "debug", "trace"],
        help="Logging level (default: info)"
    )

    args = parser.parse_args()

    print("=" * 60)
    print("🚀 NEX Genesis Btrieve Bridge API")
    print("=" * 60)
    print(f"📡 Starting server on http://{args.host}:{args.port}")
    print(f"📚 API Docs: http://{args.host}:{args.port}/docs")
    print(f"📊 ReDoc: http://{args.host}:{args.port}/redoc")
    print(f"💚 Health: http://{args.host}:{args.port}/health")
    print(f"🔧 Mode: {'Development (auto-reload)' if args.reload else 'Production'}")
    print("=" * 60)
    print()

    try:
        uvicorn.run(
            "src.api.main:app",
            host=args.host,
            port=args.port,
            reload=args.reload,
            log_level=args.log_level,
            access_log=True
        )
    except KeyboardInterrupt:
        print("\n🛑 Server stopped by user")
        sys.exit(0)
    except Exception as e:
        print(f"\n❌ Server failed to start: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()