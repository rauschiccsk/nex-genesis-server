# scripts/backup_dev_db.py
"""
Quick backup dev database before write tests
"""
import shutil
from datetime import datetime
import os


def backup_dev_database():
    """Create backup of dev database"""
    source = "C:/NEX/YEARACT"
    backup_dir = "C:/NEX/BACKUPS"

    # Create backups directory
    os.makedirs(backup_dir, exist_ok=True)

    # Timestamp
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    backup_path = f"{backup_dir}/YEARACT_BACKUP_{timestamp}"

    print(f"📦 Creating backup...")
    print(f"   From: {source}")
    print(f"   To: {backup_path}")

    try:
        shutil.copytree(source, backup_path)
        print(f"✅ Backup complete: {backup_path}")
        return backup_path
    except Exception as e:
        print(f"❌ Backup failed: {e}")
        return None


def restore_from_backup(backup_path: str):
    """Restore database from backup"""
    target = "C:/NEX/YEARACT"

    print(f"🔄 Restoring from backup...")
    print(f"   From: {backup_path}")
    print(f"   To: {target}")

    try:
        # Remove current
        if os.path.exists(target):
            shutil.rmtree(target)

        # Restore
        shutil.copytree(backup_path, target)
        print(f"✅ Restore complete")
        return True
    except Exception as e:
        print(f"❌ Restore failed: {e}")
        return False


if __name__ == "__main__":
    backup_path = backup_dev_database()
    print(f"\nBackup saved to: {backup_path}")
    print("You can restore with: restore_from_backup('{backup_path}')")