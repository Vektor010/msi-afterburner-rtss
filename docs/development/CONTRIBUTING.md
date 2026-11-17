# Contributing to ApexTuner

Thank you for your interest in improving ApexTuner. We welcome issues, bug reports, and pull requests from both human engineers and AI coding agents.

---

## 1. Ground Rules & Coding Standards
* **Surgical Edits:** Avoid massive rewrites of working configuration dictionaries. Make localized, minimal, high-impact commits.
* **UTF-8 with BOM:** All `.ps1` files must be saved with UTF-8 BOM encoding (`0xEF, 0xBB, 0xBF`) to ensure clean compatibility with Windows PowerShell 5.1.
* **Zero Syntax Errors:** Run the automated test suite before opening a Pull Request. Pull Requests with AST errors will be rejected by CI.
* **Idempotency Invariant:** Any changes to the installer logic must preserve idempotency — running the script twice on the same machine must not duplicate tasks or corrupt settings.

---

## 2. Development Workflow
1. Fork the repository and create a descriptive branch:
   ```bash
   git checkout -b feature/dynamic-fan-curve
   ```
2. Make your targeted code adjustments.
3. Validate your code locally using the test suite:
   ```powershell
   powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\Syntax.Tests.ps1
   ```
4. Commit your changes following Conventional Commits:
   ```bash
   git commit -m "feat: add support for dynamic fan hysteresis"
   ```
5. Push to your branch and open a Pull Request with a clear summary of tests conducted.
