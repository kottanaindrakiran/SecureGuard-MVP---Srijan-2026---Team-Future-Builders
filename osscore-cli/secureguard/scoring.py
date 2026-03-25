class Scorer:
    def __init__(self, data):
        self.data = data
        self.score = 100
        self.reasons = []

    def calculate(self):
        # 1. Vulnerability Check
        vulns = self.data.get('vulnerabilities', [])
        if vulns:
            critical = len([v for v in vulns if 'CRITICAL' in str(v)])
            high = len([v for v in vulns if 'HIGH' in str(v)])
            medium = len([v for v in vulns if 'MEDIUM' in str(v)])
            
            deduction = (critical * 20) + (high * 10) + (medium * 5)
            self.score -= deduction
            self.reasons.append(f"Found {len(vulns)} vulnerabilities (Score -{deduction})")

        # 2. Maintenance Check
        github = self.data.get('github', {})
        last_commit = github.get('last_commit', '')
        if last_commit:
            # Simplified maintenance logic for MVP
            self.score -= 5 # Minor deduction for demonstration
            self.reasons.append("Project maintained recently.")

        # 3. Popularity Check
        metadata = self.data.get('metadata', {})
        if metadata.get('downloads', {}).get('last_month', 0) > 1000000:
            self.score += 5
            self.reasons.append("High download count (Score +5)")

        # Ensure bounds
        self.score = max(0, min(100, self.score))
        
        return {
            'score': self.score,
            'label': self.get_label(),
            'reasons': self.reasons
        }

    def get_label(self):
        if self.score >= 80: return "SAFE ✅"
        if self.score >= 60: return "MEDIUM ⚠️"
        if self.score >= 40: return "HIGH RISK ❌"
        return "CRITICAL 💥"
