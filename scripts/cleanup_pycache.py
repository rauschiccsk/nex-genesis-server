"""
Cleanup utility pre __pycache__ adresáre a .pyc súbory
Rekurzívne prehľadá projekt a vymaže všetky cache súbory
"""
import os
import shutil
import sys
from pathlib import Path
from typing import List, Tuple


def find_pycache_dirs(root_dir: Path) -> List[Path]:
    """Nájdi všetky __pycache__ adresáre"""
    pycache_dirs = []

    for dirpath, dirnames, filenames in os.walk(root_dir):
        # Skip venv directories
        if 'venv' in dirpath or 'venv32' in dirpath or '.venv' in dirpath:
            continue

        if '__pycache__' in dirnames:
            pycache_path = Path(dirpath) / '__pycache__'
            pycache_dirs.append(pycache_path)

    return pycache_dirs


def find_pyc_files(root_dir: Path) -> List[Path]:
    """Nájdi všetky .pyc súbory mimo __pycache__"""
    pyc_files = []

    for dirpath, dirnames, filenames in os.walk(root_dir):
        # Skip venv directories
        if 'venv' in dirpath or 'venv32' in dirpath or '.venv' in dirpath:
            continue

        # Skip __pycache__ directories (tie riešime samostatne)
        if '__pycache__' in dirpath:
            continue

        for filename in filenames:
            if filename.endswith('.pyc'):
                pyc_path = Path(dirpath) / filename
                pyc_files.append(pyc_path)

    return pyc_files


def calculate_size(paths: List[Path]) -> int:
    """Vypočítaj celkovú veľkosť"""
    total_size = 0
    for path in paths:
        if path.is_file():
            total_size += path.stat().st_size
        elif path.is_dir():
            for item in path.rglob('*'):
                if item.is_file():
                    total_size += item.stat().st_size
    return total_size


def format_size(size_bytes: int) -> str:
    """Formátuj veľkosť do čitateľnej podoby"""
    if size_bytes < 1024:
        return f"{size_bytes} B"
    elif size_bytes < 1024 * 1024:
        return f"{size_bytes / 1024:.2f} KB"
    else:
        return f"{size_bytes / (1024 * 1024):.2f} MB"


def cleanup_pycache(root_dir: Path = None, dry_run: bool = False, verbose: bool = True) -> Tuple[int, int, int]:
    """
    Vymaže všetky __pycache__ adresáre a .pyc súbory

    Args:
        root_dir: Koreňový adresár (default: aktuálny adresár)
        dry_run: Len zobraz čo by sa vymazalo, nemazaj (default: False)
        verbose: Zobraz detailné info (default: True)

    Returns:
        (počet_adresárov, počet_súborov, celková_veľkosť)
    """
    if root_dir is None:
        root_dir = Path.cwd()

    # Nájdi všetko čo treba vymazať
    pycache_dirs = find_pycache_dirs(root_dir)
    pyc_files = find_pyc_files(root_dir)

    # Vypočítaj veľkosť
    total_size = calculate_size(pycache_dirs + pyc_files)

    if verbose:
        print(f"📁 Adresár: {root_dir}")
        print(f"🔍 Nájdené:")
        print(f"   - __pycache__ adresáre: {len(pycache_dirs)}")
        print(f"   - .pyc súbory: {len(pyc_files)}")
        print(f"   - Celková veľkosť: {format_size(total_size)}")
        print()

    if dry_run:
        print("🔍 DRY RUN - nič sa nemazalo")
        if verbose and (pycache_dirs or pyc_files):
            print("\nBudú vymazané:")
            for pycache_dir in pycache_dirs:
                print(f"  📂 {pycache_dir.relative_to(root_dir)}")
            for pyc_file in pyc_files:
                print(f"  📄 {pyc_file.relative_to(root_dir)}")
        return len(pycache_dirs), len(pyc_files), total_size

    # Mazanie
    deleted_dirs = 0
    deleted_files = 0

    if verbose and (pycache_dirs or pyc_files):
        print("🗑️  Mazanie...")

    # Vymaž __pycache__ adresáre
    for pycache_dir in pycache_dirs:
        try:
            shutil.rmtree(pycache_dir)
            deleted_dirs += 1
            if verbose:
                print(f"  ✅ Vymazaný: {pycache_dir.relative_to(root_dir)}")
        except Exception as e:
            if verbose:
                print(f"  ❌ Chyba pri mazaní {pycache_dir}: {e}")

    # Vymaž .pyc súbory
    for pyc_file in pyc_files:
        try:
            pyc_file.unlink()
            deleted_files += 1
            if verbose:
                print(f"  ✅ Vymazaný: {pyc_file.relative_to(root_dir)}")
        except Exception as e:
            if verbose:
                print(f"  ❌ Chyba pri mazaní {pyc_file}: {e}")

    if verbose:
        print()
        print("✨ Hotovo!")
        print(f"   - Vymazané adresáre: {deleted_dirs}")
        print(f"   - Vymazané súbory: {deleted_files}")
        print(f"   - Uvoľnené miesto: {format_size(total_size)}")

    return deleted_dirs, deleted_files, total_size


def main():
    """Main function"""
    import argparse

    parser = argparse.ArgumentParser(
        description='Vymaže všetky __pycache__ adresáre a .pyc súbory',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Príklady použitia:
  python cleanup_pycache.py                  # Vyčistí aktuálny adresár
  python cleanup_pycache.py --dry-run        # Len zobraz čo by sa vymazalo
  python cleanup_pycache.py --quiet          # Tichý režim
  python cleanup_pycache.py C:\\Dev\\project  # Vyčistí konkrétny adresár
        """
    )

    parser.add_argument(
        'directory',
        nargs='?',
        default='.',
        help='Adresár na vyčistenie (default: aktuálny adresár)'
    )
    parser.add_argument(
        '--dry-run',
        action='store_true',
        help='Len zobraz čo by sa vymazalo, nemazaj'
    )
    parser.add_argument(
        '--quiet', '-q',
        action='store_true',
        help='Tichý režim - minimálny output'
    )

    args = parser.parse_args()

    root_dir = Path(args.directory).resolve()

    if not root_dir.exists():
        print(f"❌ Adresár neexistuje: {root_dir}")
        sys.exit(1)

    if not root_dir.is_dir():
        print(f"❌ Nie je to adresár: {root_dir}")
        sys.exit(1)

    try:
        dirs_count, files_count, size = cleanup_pycache(
            root_dir,
            dry_run=args.dry_run,
            verbose=not args.quiet
        )

        if args.quiet:
            print(f"Vymazané: {dirs_count} adresárov, {files_count} súborov ({format_size(size)})")

        sys.exit(0)
    except Exception as e:
        print(f"❌ Chyba: {e}")
        sys.exit(1)


if __name__ == '__main__':
    main()