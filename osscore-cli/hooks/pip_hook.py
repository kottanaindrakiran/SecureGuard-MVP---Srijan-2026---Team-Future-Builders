import os
import subprocess
import sys

def post_install_hook(package_name):
    """
    Runs sg scan after a successful pip install.
    This is designed to be called by a wrapper or monkey-patch.
    """
    try:
        # Run scan in a non-blocking way or catch errors
        # Using subprocess to run the 'sg' command which should be in path after install
        print(f"\n[SecureGuard] Scanning installed package: {package_name}...")
        subprocess.run(["sg", "scan", package_name], capture_output=False)
    except Exception as e:
        print(f"[SecureGuard] Auto-scan failed: {e}")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        post_install_hook(sys.argv[1])
