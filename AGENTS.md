# AGENTS.md — Universal AI Collaboration & Continuation Guide

> **Project:** ApexTuner (Automated MSI Afterburner & RTSS Suite)  
> **Status:** Production-Ready / Fully Tested  
> **Target OS:** Windows 10 / Windows 11 (x64)  
> **Shell:** PowerShell 5.1+ & PowerShell 7+  
> **Standard:** Universal Open Source Standard 2026

---

## 1. Prime Directives for Any AI Agent
1. **Surgical Precision:** Modify only explicitly requested sections. Never rewrite entire scripts when addressing localized logic.
2. **Iron Law of Verification:** Never claim a bug is fixed, a test passed, or an installation succeeded without running console commands and capturing real stdout/stderr.
3. **Idempotency Preservation:** Every script must be safe to run repeatedly. If components are already installed and configurations match target state, execution must complete in under 5 seconds without re-downloading or reinstalling.
4. **Encoding Standard:** All `.ps1` files must preserve **UTF-8 with BOM** (`0xEF, 0xBB, 0xBF`) to guarantee clean execution across localized Windows PowerShell 5.1 environments.
5. **Universal Handoff:** When concluding any turn, always update `PROJECT_STATE.md` with current verified metrics, modified files, test outputs, and next actionable steps.

---

## 2. Universal Documentation Index for AI Agents
Any AI coding agent (Claude, ChatGPT, Gemini, Copilot, Cursor) can locate all project documentation via these deterministic paths:

* **Architecture & IPC:** [`docs/architecture/ARCHITECTURE.md`](docs/architecture/ARCHITECTURE.md)
* **Architectural Decisions (ADR):** [`docs/architecture/DECISIONS.md`](docs/architecture/DECISIONS.md)
* **Current Project State:** [`docs/project/PROJECT_STATE.md`](docs/project/PROJECT_STATE.md)
* **Project Roadmap:** [`docs/project/ROADMAP.md`](docs/project/ROADMAP.md)
* **Changelog & History:** [`docs/project/CHANGELOG.md`](docs/project/CHANGELOG.md)
* **Development & Test Guide:** [`docs/development/DEVELOPMENT.md`](docs/development/DEVELOPMENT.md)
* **Contribution Guidelines:** [`docs/development/CONTRIBUTING.md`](docs/development/CONTRIBUTING.md)
* **Known Issues & Workarounds:** [`docs/guides/KNOWN_ISSUES.md`](docs/guides/KNOWN_ISSUES.md)
* **Support & Diagnostics:** [`docs/guides/SUPPORT.md`](docs/guides/SUPPORT.md)
* **Security & Elevation Policy:** [`docs/security/SECURITY.md`](docs/security/SECURITY.md)

---

## 3. Repository Layout & Ownership
```
msi-afterburner-rtss/
├── Setup.ps1                       # Interactive 1-click master launcher
├── MSI-Afterburner-NextGen.ps1     # Esports streamlined OSD variant (FPS, Frametime, 1% Low, aggregate CPU/GPU)
├── MSI-Afterburner-Moi.ps1         # Detailed monitoring installer: per-core telemetry (CPU0..15), RTX 5080/all GPU support
├── MSI-Afterburner-Standalone.ps1  # Pure software installer (no driver/GPU tweaks)
├── README.md                       # Primary documentation (Russian)
├── README_EN.md                    # International overview (English)
├── README_RU.md                    # Complete Russian reference
├── AGENTS.md                       # Universal AI agent instruction hub (this file)
├── LICENSE                    # Software license & terms
├── profiles/                  # Isolated GPU undervolt/clock curves
│   ├── RTX-5080-Undervolt.ps1 # Verified RTX 5080 curve & memory offsets
│   └── RTX-3060-Undervolt.ps1 # Verified RTX 3060 curve & memory offsets
├── tools/                     # Portable binaries & low-latency profiles
│   ├── nvidiaProfileInspector.exe
│   ├── nvidiaProfileInspector.exe.config
│   ├── Reference.xml
│   └── NV-Esports-Ultimate.nip
├── tests/                     # Automated quality gates
│   └── Syntax.Tests.ps1       # AST syntax & encoding validator
├── docs/                      # Categorized documentation suite
│   ├── architecture/          # System design & ADRs
│   │   ├── ARCHITECTURE.md
│   │   └── DECISIONS.md
│   ├── development/           # Developer manuals & contributing rules
│   │   ├── DEVELOPMENT.md
│   │   └── CONTRIBUTING.md
│   ├── guides/                # Edge cases, troubleshooting & support
│   │   ├── KNOWN_ISSUES.md
│   │   └── SUPPORT.md
│   ├── project/               # Project state, history & milestones
│   │   ├── PROJECT_STATE.md
│   │   ├── CHANGELOG.md
│   │   └── ROADMAP.md
│   └── security/              # Vulnerability reporting & UAC security
│       └── SECURITY.md
├── assets/                    # Media & visual materials
│   ├── branding/              # Logos, banners & identity
│   ├── screenshots/           # OSD previews & telemetry captures
│   ├── animations/            # Visual workflow demonstrations
│   └── diagrams/              # Architectural schemas
└── Logs/                      # Auto-generated execution logs (git-ignored)
```

---

## 3. Critical Architectural Invariants
* **The Ghost Mode Contract:**
  * `SingleTrayIconMode = 1` in `MSIAfterburner.cfg` hides the secondary RTSS tray icon while preserving background server execution.
  * `EnableOSD = 0` in RTSS `Profiles\Global` ensures 3D applications boot with a clean screen.
  * `EnableServer = 1` in `MSIAfterburner.cfg` ensures RTSS starts at boot to hook the process creation table.
* **The Unified Hotkey Contract:**
  * `OSDToggleHotkey = 00040031h` in Afterburner and `OSDToggleHotkey = 00040031` in `HotkeyHandler.cfg` are strictly mapped to <kbd>Alt</kbd> + <kbd>1</kbd>.
* **Dynamic Hardware Detection:**
  * Never hardcode `VEN_10DE...cfg`. Always query existing `Profiles\VEN_*.cfg` to identify the host GPU's true PCI Device/Subsystem identifier.

---

## 4. Verification Commands (Run Before Any Commit)
```powershell
# 1. Validate AST syntax across all scripts
Get-ChildItem -Path . -Recurse -Filter '*.ps1' | ForEach-Object {
    $errs = $null; $toks = $null
    [System.Management.Automation.Language.Parser]::ParseFile($_.FullName, [ref]$toks, [ref]$errs) | Out-Null
    if ($errs.Count -gt 0) { throw "AST Error in $($_.Name): $($errs[0].Message)" }
}

# 2. Run automated test suite
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\Syntax.Tests.ps1

# 3. Check active processes and config parameters
Get-Content 'C:\Program Files (x86)\MSI Afterburner\Profiles\MSIAfterburner.cfg' | Select-String 'SingleTrayIconMode|EnableServer|OSDToggleHotkey'
Get-Content 'C:\Program Files (x86)\RivaTuner Statistics Server\Plugins\Client\HotkeyHandler.cfg' | Select-String 'OSDToggleHotkey'
```
