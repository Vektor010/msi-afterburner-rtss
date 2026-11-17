# Development & Testing Guide

## 1. Prerequisites
* **Operating System:** Windows 10 (Build 19041+) or Windows 11 (21H2+) 64-bit
* **PowerShell:** Windows PowerShell 5.1 (built-in) or PowerShell 7+
* **Privileges:** Local Administrator rights (required for service and config management)
* **Git:** Git 2.30+ for Windows

---

## 2. Setting Up the Workspace
```powershell
# Clone the repository
git clone https://github.com/your-username/msi-afterburner-rtss.git
cd msi-afterburner-rtss

# Inspect repository status
git status
```

---

## 3. Running Automated Tests
The repository includes a static analysis and syntax validation suite located in `tests/Syntax.Tests.ps1`.

Execute the test suite directly:
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\Syntax.Tests.ps1
```

### What the test suite validates:
1. **AST Parser Syntax:** Every `.ps1` file is parsed using `[System.Management.Automation.Language.Parser]::ParseFile`. Zero syntax errors are tolerated.
2. **Encoding Compliance:** Confirms every script starts with standard UTF-8 BOM bytes (`0xEF`, `0xBB`, `0xBF`).
3. **Configuration Key Integrity:** Verifies required keys (`EnableServer`, `SingleTrayIconMode`, `OSDToggleHotkey`) exist in generated files.

---

## 4. Local Deployment Testing
To run a dry or live test of the installer:
```powershell
# Launch the interactive menu or run directly:
powershell -NoProfile -ExecutionPolicy Bypass -File .\Setup.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\MSI-Afterburner-Moi.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\MSI-Afterburner-NextGen.ps1

# Inspect execution logs
Get-ChildItem .\Logs | Sort-Object LastWriteTime -Descending | Select-Object -First 1 | Get-Content
```
