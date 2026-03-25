# SecureGuard — Demo Script
## Srijan 2026 | Team: Future Builders

---

### Opening Line (30 seconds)
"India loses $2.7 billion annually to phone fraud. 85% of supply chain attacks 
come from open-source packages. SecureGuard protects both attack surfaces — 
the human and the code — with zero cloud dependency."

---

### Demo Step 1 — OSS SecureScore CLI (2 minutes)

1. Open terminal
2. Run: `cd ossscore-cli && pip install -e .`
3. Run: `.\sg scan requests`
   - Show colored score banner appearing
   - Point out: CVE count, last commit date, safety score
4. Run: `.\sg scan numpy`
   - Show different score
5. Run again: `.\sg scan requests`
   - Show CACHED badge — works offline instantly
6. Run: `.\sg scan requirements.txt`
   - Show bulk scan of entire file

**Talking point:** "No extra commands. Zero friction. Security is invisible until it matters."

---

### Demo Step 2 — FakeCall Detector Flutter App (2 minutes)

1. Open Android emulator / physical device
2. Show HomeScreen — Shield ON, protection active
3. Tap "Simulate Incoming Call"
4. Show CallScreen:
   - Caller shows as "Mom" but number is VoIP
   - Pulse animation runs
   - Score calculates: 12% biometric match
   - Verdict: 🔴 FAKE CALL DETECTED
5. Show ContactsScreen — enrolled voiceprints list

**Talking point:** "Spoofers can fake a caller ID. They cannot fake a voiceprint."

---

### Closing Line (30 seconds)
"SecureGuard is not two tools. It is one security philosophy — 
trust nothing, verify everything, store nothing in the cloud. 
One platform protecting the full enterprise attack surface."

---

### Q&A Prep

Q: Is the AI model real?
A: Voice biometric logic is implemented. TFLite model is pre-trained for MVP. 
   Production version trains on user's own contact voiceprints on-device.

Q: Does it work offline?
A: Yes. Both tools use local SQLite cache. No internet required after first scan.

Q: Can it scale to enterprise?
A: CLI integrates into any CI/CD pipeline via pre-commit hooks. 
   App deploys via MDM to any Android fleet.
