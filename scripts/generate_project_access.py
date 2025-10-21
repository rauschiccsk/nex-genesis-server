#!/usr/bin/env python3
"""
generate_project_access.py - Generovanie project_file_access.json

Tento script prehľadá projekt a vytvorí JSON súbor s odkazmi
na všetky súbory v GitHub repository.

Usage:
    python scripts/generate_project_access.py

Output:
    docs/project_file_access.json
"""

import json
import os
from pathlib import Path
from typing import Dict, List
from datetime import datetime

# ============================================================================
# CONFIGURATION
# ============================================================================

GITHUB_USER = "rauschiccsk"
GITHUB_REPO = "nex-genesis-server"
GITHUB_BRANCH = "main"
LOCAL_PROJECT_ROOT = Path(r"c:\Development\nex-genesis-server")

# Directories to scan
SCAN_DIRECTORIES = [
    "docs",
    "delphi-sources",
    "output",
    "templates",
    "config",
    "scripts",
    "tests"
]

# File extensions to include
DELPHI_EXTENSIONS = [".pas", ".dpr", ".dfm", ".dproj", ".res", ".inc"]
DOCS_EXTENSIONS = [".md", ".txt"]
CONFIG_EXTENSIONS = [".ini", ".yaml", ".yml", ".json", ".xml"]
SCRIPT_EXTENSIONS = [".py", ".bat", ".ps1"]
ALL_EXTENSIONS = DELPHI_EXTENSIONS + DOCS_EXTENSIONS + CONFIG_EXTENSIONS + SCRIPT_EXTENSIONS

# Files to always include (root level)
ROOT_FILES = [
    "README.md",
    "LICENSE",
    "CHANGELOG.md",
    ".gitignore",
    "requirements.txt"
]


# ============================================================================
# HELPER FUNCTIONS
# ============================================================================

def get_raw_github_url(relative_path: str) -> str:
    """Vytvorí raw GitHub URL pre daný súbor."""
    # Convert Windows path separators to Unix
    relative_path = relative_path.replace("\\", "/")
    return f"https://raw.githubusercontent.com/{GITHUB_USER}/{GITHUB_REPO}/{GITHUB_BRANCH}/{relative_path}"


def get_file_category(file_path: Path) -> str:
    """Určí kategóriu súboru na základe prípony a lokácie."""
    ext = file_path.suffix.lower()
    parent_dir = file_path.parent.name.lower()

    if ext in DELPHI_EXTENSIONS:
        return "delphi"
    elif ext in DOCS_EXTENSIONS:
        return "documentation"
    elif ext in CONFIG_EXTENSIONS:
        return "configuration"
    elif ext in SCRIPT_EXTENSIONS:
        return "scripts"
    else:
        return "other"


def get_file_description(file_path: Path) -> str:
    """Vytvorí popis súboru."""
    name = file_path.name
    category = get_file_category(file_path)

    # Special cases
    if name == "FULL_PROJECT_CONTEXT.md":
        return "Main project documentation - single source of truth"
    elif name == "project_file_access.json":
        return "This file - manifest of all project files"
    elif name == "README.md":
        return "Project overview and quick start guide"
    elif name.endswith(".pas"):
        return f"Delphi unit: {file_path.stem}"
    elif name.endswith(".dpr"):
        return f"Delphi project: {file_path.stem}"
    elif name.endswith(".ini"):
        return f"Configuration file: {file_path.stem}"
    else:
        return f"{category.capitalize()} file"


def scan_directory(directory: Path, base_path: Path) -> List[Dict]:
    """Prehľadá adresár a vráti zoznam súborov."""
    files = []

    if not directory.exists():
        print(f"⚠️  Directory not found: {directory}")
        return files

    for item in directory.rglob("*"):
        if item.is_file():
            # Check if file extension is in our list
            if item.suffix.lower() in ALL_EXTENSIONS or item.name in ROOT_FILES:
                # Get relative path from project root
                try:
                    relative_path = item.relative_to(base_path)

                    file_info = {
                        "name": item.name,
                        "path": str(relative_path),
                        "category": get_file_category(item),
                        "description": get_file_description(item),
                        "size": item.stat().st_size,
                        "raw_url": get_raw_github_url(str(relative_path))
                    }

                    files.append(file_info)

                except ValueError:
                    # File is outside base_path, skip it
                    continue

    return files


def generate_project_access() -> Dict:
    """Hlavná funkcia - generuje kompletný manifest projektu."""

    print("=" * 70)
    print("🚀 NEX Genesis Server - Project File Access Generator")
    print("=" * 70)
    print()

    # Initialize structure
    manifest = {
        "project_name": "nex-genesis-server",
        "github_repository": f"https://github.com/{GITHUB_USER}/{GITHUB_REPO}",
        "github_branch": GITHUB_BRANCH,
        "generated_at": datetime.now().isoformat(),
        "local_path": str(LOCAL_PROJECT_ROOT),
        "statistics": {
            "total_files": 0,
            "delphi_files": 0,
            "documentation_files": 0,
            "configuration_files": 0,
            "script_files": 0,
            "other_files": 0
        },
        "files": []
    }

    all_files = []

    # Scan root files
    print("📁 Scanning root files...")
    for root_file in ROOT_FILES:
        file_path = LOCAL_PROJECT_ROOT / root_file
        if file_path.exists():
            relative_path = Path(root_file)
            file_info = {
                "name": file_path.name,
                "path": str(relative_path),
                "category": get_file_category(file_path),
                "description": get_file_description(file_path),
                "size": file_path.stat().st_size,
                "raw_url": get_raw_github_url(str(relative_path))
            }
            all_files.append(file_info)
            print(f"   ✓ {root_file}")

    # Scan directories
    for directory_name in SCAN_DIRECTORIES:
        directory_path = LOCAL_PROJECT_ROOT / directory_name
        print(f"\n📁 Scanning {directory_name}/...")

        files = scan_directory(directory_path, LOCAL_PROJECT_ROOT)
        all_files.extend(files)

        print(f"   ✓ Found {len(files)} files")

    # Sort files by path
    all_files.sort(key=lambda x: x["path"])

    # Update statistics
    manifest["files"] = all_files
    manifest["statistics"]["total_files"] = len(all_files)

    for file_info in all_files:
        category = file_info["category"]
        stat_key = f"{category}_files"
        if stat_key in manifest["statistics"]:
            manifest["statistics"][stat_key] += 1

    # Print statistics
    print()
    print("=" * 70)
    print("📊 STATISTICS")
    print("=" * 70)
    for key, value in manifest["statistics"].items():
        print(f"{key.replace('_', ' ').title()}: {value}")

    return manifest


def save_manifest(manifest: Dict, output_path: Path):
    """Uloží manifest do JSON súboru."""
    print()
    print("💾 Saving manifest...")

    # Create directory if doesn't exist
    output_path.parent.mkdir(parents=True, exist_ok=True)

    # Write JSON file
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)

    print(f"   ✓ Saved to: {output_path}")
    print(f"   ✓ Size: {output_path.stat().st_size} bytes")


# ============================================================================
# MAIN
# ============================================================================

if __name__ == "__main__":
    try:
        # Generate manifest
        manifest = generate_project_access()

        # Save to file
        output_path = LOCAL_PROJECT_ROOT / "docs" / "project_file_access.json"
        save_manifest(manifest, output_path)

        print()
        print("=" * 70)
        print("✅ SUCCESS!")
        print("=" * 70)
        print()
        print("Next steps:")
        print("1. Review the generated file: docs/project_file_access.json")
        print("2. Commit and push to GitHub:")
        print("   git add docs/project_file_access.json")
        print("   git commit -m 'docs: Generate project file access manifest'")
        print("   git push")
        print()
        print("🔗 Raw URL will be:")
        print(f"   {get_raw_github_url('docs/project_file_access.json')}")
        print()

    except Exception as e:
        print()
        print("=" * 70)
        print("❌ ERROR")
        print("=" * 70)
        print(f"Error: {e}")
        import traceback

        traceback.print_exc()
        exit(1)