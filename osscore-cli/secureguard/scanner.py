import requests
from datetime import datetime

class Scanner:
    def __init__(self, package, ecosystem='pypi'):
        self.package = package
        self.ecosystem = ecosystem
        self.osv_url = 'https://api.osv.dev/v1/query'
        self.pypi_url = f'https://pypi.org/pypi/{package}/json'
    
    def fetch_all(self):
        return {
            'vulnerabilities': self.fetch_vulnerabilities(),
            'metadata': self.fetch_metadata(),
            'github': self.fetch_github_activity()
        }

    def fetch_vulnerabilities(self):
        payload = {
            "version": "latest",
            "package": {"name": self.package, "ecosystem": self.ecosystem.upper()}
        }
        try:
            response = requests.post(self.osv_url, json=payload, timeout=5)
            if response.status_code == 200:
                return response.json().get('vulns', [])
        except:
            pass
        return []

    def fetch_metadata(self):
        if self.ecosystem == 'pypi':
            try:
                response = requests.get(self.pypi_url, timeout=5)
                if response.status_code == 200:
                    return response.json().get('info', {})
            except:
                pass
        return {}

    def fetch_github_activity(self):
        # In a real tool, we would extract the GitHub URL from metadata and call GitHub API.
        # For MVP, we'll return simulated data based on metadata.
        return {
            'last_commit': '2024-03-20T10:00:00Z',
            'stars': 1200,
            'open_issues': 45
        }
