"""
Generate project file access manifests - SPLIT VERSION
Creates multiple JSON files to avoid token limits

Output files:
- project_file_access_CONTEXT.json  - For Claude (docs only)
- project_file_access_delphi.json   - Delphi sources
- project_file_access_output.json   - Generated microservices
- project_file_access_templates.json - Templates and scripts
"""

import os
import json
from pathlib import Path
from typing import Dict, List, Any
from datetime import datetime

# Configuration
PROJECT_ROOT = Path(r"c:\Development\nex-genesis-server")
BASE_URL = "https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main"

# Directories to include in each manifest
CONTEXT_DIRS = ["docs"]  # For Claude - documentation only
DELPHI_DIRS = ["delphi-sources"]  # Delphi source codes
OUTPUT_DIRS = ["output"]  # Generated microservices
TEMPLATE_DIRS = ["templates", "scripts", "config"]  # Templates and scripts

# File extensions to include
INCLUDE_EXTENSIONS = {
    '.md', '.pas', '.dpr', '.dfm', '.inc', '.res',
    '.py', '.json', '.ini', '.xml', '.http',
    '.txt', '.gitignore', '.bdf'
}

# Files to exclude
EXCLUDE_FILES = {
    'project_file_access.json',
    'project_file_access_CONTEXT.json',
    'project_file_access_delphi.json',
    'project_file_access_output.json',
    'project_file_access_templates.json',
    '.git',
    '__pycache__',
    '*.pyc',
    '*.dcu',
    '*.exe',
    '*.dll'
}


def should_include_file(file_path: Path) -> bool:
    """Check if file should be included in manifest"""
    # Check extension
    if file_path.suffix.lower() not in INCLUDE_EXTENSIONS:
        return False

    # Check if file is in exclude list
    if file_path.name in EXCLUDE_FILES:
        return False

    # Check if any parent directory is in exclude list
    for part in file_path.parts:
        if part in EXCLUDE_FILES:
            return False

    return True


def get_relative_path(file_path: Path, base_path: Path) -> str:
    """Get relative path from base path"""
    try:
        return str(file_path.relative_to(base_path)).replace('\\', '/')
    except ValueError:
        return str(file_path).replace('\\', '/')


def generate_manifest_for_dirs(dirs: List[str], output_filename: str, description: str) -> Dict[str, Any]:
    """Generate manifest for specific directories"""
    manifest = {
        "project_name": "nex-genesis-server",
        "description": description,
        "generated_at": datetime.now().isoformat(),
        "base_url": BASE_URL,
        "files": []
    }

    total_files = 0

    for dir_name in dirs:
        dir_path = PROJECT_ROOT / dir_name

        if not dir_path.exists():
            print(f"⚠️  Directory not found: {dir_name}")
            continue

        print(f"\n📁 Scanning {dir_name}/...")
        dir_files = 0

        for file_path in dir_path.rglob('*'):
            if file_path.is_file() and should_include_file(file_path):
                relative_path = get_relative_path(file_path, PROJECT_ROOT)
                raw_url = f"{BASE_URL}/{relative_path}"

                file_info = {
                    "path": relative_path,
                    "raw_url": raw_url,
                    "size": file_path.stat().st_size,
                    "extension": file_path.suffix,
                    "name": file_path.name
                }

                manifest["files"].append(file_info)
                dir_files += 1
                total_files += 1

        print(f"   ✅ Found {dir_files} files in {dir_name}/")

    # Sort files by path
    manifest["files"].sort(key=lambda x: x["path"])
    manifest["total_files"] = total_files

    # Save manifest
    output_path = PROJECT_ROOT / "docs" / output_filename
    output_path.parent.mkdir(parents=True, exist_ok=True)

    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)

    print(f"\n✅ Generated: {output_filename}")
    print(f"   📊 Total files: {total_files}")
    print(f"   💾 Size: {output_path.stat().st_size:,} bytes")

    return manifest


def generate_main_index() -> None:
    """Generate main index file that references all manifests"""
    index = {
        "project_name": "nex-genesis-server",
        "description": "Main index - references to all manifest files",
        "generated_at": datetime.now().isoformat(),
        "manifests": {
            "context": {
                "file": "project_file_access_CONTEXT.json",
                "description": "Documentation only - for Claude",
                "url": f"{BASE_URL}/docs/project_file_access_CONTEXT.json",
                "use_case": "Load this in Claude for working with project documentation"
            },
            "delphi": {
                "file": "project_file_access_delphi.json",
                "description": "Delphi source codes - NEX Genesis patterns",
                "url": f"{BASE_URL}/docs/project_file_access_delphi.json",
                "use_case": "Load this when analyzing NEX Genesis patterns"
            },
            "output": {
                "file": "project_file_access_output.json",
                "description": "Generated microservices output",
                "url": f"{BASE_URL}/docs/project_file_access_output.json",
                "use_case": "Load this when working with generated code"
            },
            "templates": {
                "file": "project_file_access_templates.json",
                "description": "Templates, scripts, and configuration",
                "url": f"{BASE_URL}/docs/project_file_access_templates.json",
                "use_case": "Load this when using code generation templates"
            }
        }
    }

    output_path = PROJECT_ROOT / "docs" / "project_file_access_INDEX.json"
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(index, f, indent=2, ensure_ascii=False)

    print(f"\n📋 Generated main index: project_file_access_INDEX.json")


def main():
    print("=" * 70)
    print("🏭 NEX-GENESIS-SERVER - Project File Access Generator (SPLIT)")
    print("=" * 70)

    if not PROJECT_ROOT.exists():
        print(f"❌ Error: Project root not found: {PROJECT_ROOT}")
        return

    print(f"\n📂 Project root: {PROJECT_ROOT}")
    print(f"🌐 Base URL: {BASE_URL}")

    # Generate CONTEXT manifest (for Claude)
    print("\n" + "=" * 70)
    print("1️⃣  CONTEXT Manifest (for Claude)")
    print("=" * 70)
    generate_manifest_for_dirs(
        CONTEXT_DIRS,
        "project_file_access_CONTEXT.json",
        "Documentation files - optimized for Claude"
    )

    # Generate DELPHI manifest
    print("\n" + "=" * 70)
    print("2️⃣  DELPHI Manifest")
    print("=" * 70)
    generate_manifest_for_dirs(
        DELPHI_DIRS,
        "project_file_access_delphi.json",
        "Delphi source codes - NEX Genesis patterns and implementations"
    )

    # Generate OUTPUT manifest
    print("\n" + "=" * 70)
    print("3️⃣  OUTPUT Manifest")
    print("=" * 70)
    generate_manifest_for_dirs(
        OUTPUT_DIRS,
        "project_file_access_output.json",
        "Generated microservices - REST API implementations"
    )

    # Generate TEMPLATES manifest
    print("\n" + "=" * 70)
    print("4️⃣  TEMPLATES Manifest")
    print("=" * 70)
    generate_manifest_for_dirs(
        TEMPLATE_DIRS,
        "project_file_access_templates.json",
        "Templates, scripts, and configuration files"
    )

    # Generate main index
    print("\n" + "=" * 70)
    print("📋 Main Index")
    print("=" * 70)
    generate_main_index()

    print("\n" + "=" * 70)
    print("✅ ALL MANIFESTS GENERATED SUCCESSFULLY!")
    print("=" * 70)
    print("\n💡 Usage:")
    print("   For Claude: Use project_file_access_CONTEXT.json")
    print("   For Delphi analysis: Use project_file_access_delphi.json")
    print("   For generated code: Use project_file_access_output.json")
    print("   For templates: Use project_file_access_templates.json")
    print("   Main index: project_file_access_INDEX.json")
    print("\n🌐 GitHub URLs:")
    print(f"   {BASE_URL}/docs/project_file_access_CONTEXT.json")
    print(f"   {BASE_URL}/docs/project_file_access_delphi.json")
    print(f"   {BASE_URL}/docs/project_file_access_output.json")
    print(f"   {BASE_URL}/docs/project_file_access_templates.json")
    print(f"   {BASE_URL}/docs/project_file_access_INDEX.json")


if __name__ == "__main__":
    main()