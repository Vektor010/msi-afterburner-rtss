# Support & Community Help

Welcome to the **MSI Afterburner & RTSS Suite** support guide.

---

## 🔍 Before Opening an Issue

Before submitting a support request, please check if your problem is already addressed:

1. **Known Issues & Workarounds:** Read [KNOWN_ISSUES.md](KNOWN_ISSUES.md) for solutions to common edge cases (hidden tray access, late hooking, anti-cheat compatibility).
2. **Architecture & Internal Contracts:** Review [ARCHITECTURE.md](../architecture/ARCHITECTURE.md) to understand how the process IPC and overlay injection operate.
3. **Automated Diagnostic Run:** Execute the test suite to ensure system contracts are valid:
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\Syntax.Tests.ps1
   ```

---

## 🛠️ How to File an Effective Issue

When reporting an issue on GitHub:

1. **Provide System Details:**
   - Windows Version and OS Build (`winver` or `[System.Environment]::OSVersion`).
   - GPU Model (e.g. GeForce RTX 5080, RTX 3060).
   - NVIDIA Driver Version.
2. **Attach Diagnostic Logs:**
   - Attach the latest session log from the repository's `Logs/` directory (e.g., `Logs/MsiInstaller_*.log`).
3. **Describe Expected vs Actual Behavior:**
   - Clearly state what script was run (`Setup.ps1`, `MSI-Afterburner-Moi.ps1`, `MSI-Afterburner-NextGen.ps1`, or `MSI-Afterburner-Standalone.ps1`).
   - Include any console error messages or screenshots.

---

## 💬 Community Channels

- **GitHub Issues:** Bug reports and feature proposals.
- **Maintainer:** [Vektor010](https://github.com/Vektor010)
