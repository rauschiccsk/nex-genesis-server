"""
Generate project_file_access JSON manifests for GitHub raw URLs
Supports multiple directories and file extensions
"""

import os
import json
from datetime import datetime
from pathlib import Path


def generate_manifest(
        base_path,
        target_dir,
        extensions,
        output_file,
        description,
        github_repo="rauschiccsk/nex-genesis-server",
        github_branch="main"
):
    """
    Generate JSON manifest for files in target directory

    Args:
        base_path: Base path of the project (e.g., "c:/Development/nex-genesis-server")
        target_dir: Target directory to scan (e.g., "delphi-sources" or "database-schema")
        extensions: List of file extensions to include (e.g., [".pas", ".dfm"])
        output_file: Output JSON filename (e.g., "project_file_access_delphi.json")
        description: Description for the manifest
        github_repo: GitHub repository (owner/repo)
        github_branch: GitHub branch name
    """

    base_path = Path(base_path)
    target_path = base_path / target_dir

    if not target_path.exists():
        print(f"❌ Adresár {target_path} neexistuje!")
        return False

    # Collect files
    files = []
    for ext in extensions:
        for filepath in target_path.rglob(f"*{ext}"):
            # Get relative path from project root
            rel_path = filepath.relative_to(base_path)

            # Convert to forward slashes for URLs
            rel_path_str = str(rel_path).replace('\\', '/')

            # Create raw GitHub URL
            raw_url = f"https://raw.githubusercontent.com/{github_repo}/{github_branch}/{rel_path_str}"

            # Get file size
            file_size = filepath.stat().st_size

            files.append({
                "path": rel_path_str,
                "raw_url": raw_url,
                "size": file_size,
                "extension": ext,
                "name": filepath.name
            })

    # Sort by path
    files.sort(key=lambda x: x['path'])

    # Create manifest
    manifest = {
        "project_name": "nex-genesis-server",
        "description": description,
        "generated_at": datetime.now().isoformat(),
        "base_url": f"https://raw.githubusercontent.com/{github_repo}/{github_branch}",
        "files": files
    }

    # Write to file
    output_path = base_path / "docs" / output_file
    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)

    print(f"✅ Manifest vytvorený: {output_path}")
    print(f"   📊 Počet súborov: {len(files)}")
    print(f"   📦 Extensions: {', '.join(extensions)}")
    print(f"   📁 Adresár: {target_dir}")

    return True


def main():
    """Generate all manifests"""

    # Base project path
    base_path = r"c:\Development\nex-genesis-server"

    print("🚀 Generujem project manifests...\n")

    # 1. Delphi sources manifest
    print("📝 1. Delphi Sources Manifest")
    generate_manifest(
        base_path=base_path,
        target_dir="delphi-sources",
        extensions=[".pas", ".dfm"],
        output_file="project_file_access_delphi.json",
        description="Delphi source codes - NEX Genesis reference (BtrTable.pas only)"
    )
    print()

    # 2. Database schema manifest (.bdf files)
    print("📝 2. Database Schema Manifest")
    generate_manifest(
        base_path=base_path,
        target_dir="database-schema",
        extensions=[".bdf"],
        output_file="project_file_access_bdf.json",
        description="Btrieve Data Definition Files (.bdf) - NEX Genesis database schema"
    )
    print()

    # 3. Documentation manifest (optional)
    print("📝 3. Documentation Manifest")
    generate_manifest(
        base_path=base_path,
        target_dir="docs",
        extensions=[".md"],
        output_file="project_file_access_docs.json",
        description="Project documentation files"
    )
    print()

    print("✅ Všetky manifesty vygenerované!")
    print("\n📋 Vytvorené súbory:")
    print("   - docs/project_file_access_delphi.json")
    print("   - docs/project_file_access_bdf.json")
    print("   - docs/project_file_access_docs.json")


if __name__ == "__main__":
    main()