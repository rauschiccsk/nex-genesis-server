"""
Generate unified project_file_access.json manifest
Combines docs, database schemas, and Delphi sources into ONE file
"""
import os
import json
from datetime import datetime
from pathlib import Path

# Configuration
PROJECT_NAME = "nex-genesis-server"
BASE_URL = "https://raw.githubusercontent.com/rauschiccsk/nex-genesis-server/main"
OUTPUT_FILE = "docs/project_file_access.json"

# Categories to scan
CATEGORIES = {
    "documentation": {
        "description": "Project documentation and guides",
        "directories": ["docs"],
        "extensions": [".md"],
        "recursive": True
    },
    "database_schemas": {
        "description": "Btrieve database definition files",
        "directories": ["database-schema"],
        "extensions": [".bdf"],
        "recursive": False
    },
    "delphi_sources": {
        "description": "NEX Genesis Delphi patterns and implementations",
        "directories": ["delphi-sources"],
        "extensions": [".pas", ".dfm", ".PAS"],
        "recursive": True
    },
    "configuration": {
        "description": "Configuration files and templates",
        "directories": ["config"],
        "extensions": [".yaml", ".yml", ".json"],
        "recursive": False
    },
    "python_sources": {
        "description": "Python source code",
        "directories": ["src", "tests", "scripts"],
        "extensions": [".py"],
        "recursive": True
    }
}

def should_skip(path):
    """Check if path should be skipped"""
    skip_patterns = [
        "__pycache__",
        ".git",
        ".pytest_cache",
        "venv",
        "venv32",
        ".venv",
        "node_modules",
        ".idea",
        "*.pyc",
        ".DS_Store"
    ]

    path_str = str(path)
    for pattern in skip_patterns:
        if pattern in path_str:
            return True
    return False

def scan_category(category_name, config, base_path):
    """Scan files for a specific category"""
    files = []

    for directory in config["directories"]:
        dir_path = base_path / directory

        if not dir_path.exists():
            print(f"⚠️  Directory not found: {dir_path}")
            continue

        # Scan directory
        if config["recursive"]:
            pattern = "**/*"
        else:
            pattern = "*"

        for file_path in dir_path.glob(pattern):
            if file_path.is_file() and not should_skip(file_path):
                # Check extension
                if file_path.suffix in config["extensions"]:
                    relative_path = file_path.relative_to(base_path)

                    files.append({
                        "path": str(relative_path).replace("\\", "/"),
                        "raw_url": f"{BASE_URL}/{str(relative_path).replace(os.sep, '/')}",
                        "size": file_path.stat().st_size,
                        "extension": file_path.suffix,
                        "name": file_path.name,
                        "category": category_name
                    })

    return files

def generate_manifest():
    """Generate unified project file access manifest"""
    print("=" * 60)
    print("🔨 Generating Unified Project File Access Manifest")
    print("=" * 60)

    # Get project root
    script_dir = Path(__file__).parent
    project_root = script_dir.parent

    print(f"\n📁 Project root: {project_root}")

    # Collect all files by category
    all_files = []
    category_stats = {}

    for category_name, category_config in CATEGORIES.items():
        print(f"\n🔍 Scanning: {category_name}")
        print(f"   Description: {category_config['description']}")
        print(f"   Directories: {', '.join(category_config['directories'])}")
        print(f"   Extensions: {', '.join(category_config['extensions'])}")

        files = scan_category(category_name, category_config, project_root)
        all_files.extend(files)
        category_stats[category_name] = len(files)

        print(f"   ✅ Found: {len(files)} files")

    # Sort files by path
    all_files.sort(key=lambda x: x["path"])

    # Create manifest
    manifest = {
        "project_name": PROJECT_NAME,
        "description": "Unified project file access manifest - all categories in one file",
        "generated_at": datetime.now().isoformat(),
        "base_url": BASE_URL,
        "categories": list(CATEGORIES.keys()),
        "category_descriptions": {
            name: config["description"]
            for name, config in CATEGORIES.items()
        },
        "statistics": {
            "total_files": len(all_files),
            "by_category": category_stats
        },
        "files": all_files
    }

    # Write manifest
    output_path = project_root / OUTPUT_FILE
    output_path.parent.mkdir(parents=True, exist_ok=True)

    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(manifest, f, indent=2, ensure_ascii=False)

    print("\n" + "=" * 60)
    print("✅ Manifest Generated Successfully!")
    print("=" * 60)
    print(f"\n📄 Output: {output_path}")
    print(f"📊 Total files: {len(all_files)}")
    print(f"\n📈 By category:")
    for category, count in category_stats.items():
        print(f"   • {category}: {count} files")

    print(f"\n🔗 GitHub URL:")
    print(f"   {BASE_URL}/docs/project_file_access.json")

    print("\n💡 Usage:")
    print("   1. Commit and push to GitHub")
    print("   2. Use this ONE URL in new Claude chats:")
    print(f"      {BASE_URL}/docs/project_file_access.json")
    print("   3. Claude will have access to ALL project files!")

    return manifest

if __name__ == "__main__":
    try:
        manifest = generate_manifest()
        print("\n✅ Done!")
    except Exception as e:
        print(f"\n❌ Error: {e}")
        import traceback
        traceback.print_exc()