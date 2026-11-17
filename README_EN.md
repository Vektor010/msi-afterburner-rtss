# ⚡ MSI Afterburner & RTSS Esports & Tuning Suite

[🇬🇧 English](README.md) | [🇷🇺 Русский](README_RU.md)

A specialized, zero-bloat automation suite for installing, configuring, and optimizing **MSI Afterburner** and **RivaTuner Statistics Server (RTSS)** for competitive gaming and hardware benchmarking.

---

## 🎯 Quick Start: 1-Click Interactive Setup

Run the master interactive launcher from an elevated PowerShell terminal:

```powershell
powershell -ExecutionPolicy Bypass -File .\Setup.ps1
```

```
========================================================================
             MSI AFTERBURNER & RTSS AUTOMATED SETUP SUITE               
========================================================================
  [1] Esports Minimal OSD (Setup-Esports-OSD.ps1)
  [2] Detailed Telemetry OSD (Setup-Detailed-OSD.ps1)
  [3] Base Software Only (Setup-Base-NoOC.ps1)
  [4] Apply RTX 5080 Undervolt Only (0.950V / 2850MHz)
  [5] Apply RTX 3060 Undervolt Only (0.875V / 1875MHz)
  [T] Run Quality Gate Tests (Syntax.Tests.ps1)
  [Q] Exit
========================================================================
```

---

## 📊 Preset Comparison & Workload Fit

| Feature | 🟢 `Setup-Esports-OSD.ps1` *(Esports)* | 🟡 `Setup-Detailed-OSD.ps1` *(Benchmarking)* | ⚪ `Setup-Base-NoOC.ps1` *(Base)* |
|---|---|---|---|
| **Primary Goal** | Minimal input latency and clean display for competitive titles (CS2, Apex, Warzone) | Stress-testing, thermal throttling detection, clock stability | Clean software installation without GPU or driver tuning |
| **OSD Visual Style** | **Compact vertical stack**: FPS, Frametime (ms), 1% Low, 0.1% Low, aggregate CPU/GPU | **Full diagnostic dashboard**: telemetry for **every CPU core** (CPU0..CPU15), VRAM, fans, frametime graph | Standard clean overlay |
| **Visual Clutter** | **0% clutter**: preserves radar, crosshair, HUD, and chat visibility | High-density telemetry for testers | Standard minimal |
| **GPU Tuning / Undervolt**| Applies RTX 5080 undervolt (0.950V / 2850MHz) to Profile 1 | Applies RTX 5080 undervolt (0.950V / 2850MHz) to Profile 1 | **Untouched** (safe across all hardware) |
| **NVIDIA Driver Profile** | Low-latency profile via NPI (Unlimited shader cache, P-State 1, Threaded On) | Low-latency driver profile via NPI | **Untouched** |
| **Ghost Tray Mode** | ✅ Enabled (`SingleTrayIconMode = 1`) | ✅ Enabled (`SingleTrayIconMode = 1`) | ✅ Enabled (`SingleTrayIconMode = 1`) |
| **OSD Hotkey** | <kbd>Alt</kbd> + <kbd>1</kbd> | <kbd>Alt</kbd> + <kbd>1</kbd> | <kbd>Alt</kbd> + <kbd>1</kbd> |
| **Default Display State** | Hidden (`EnableOSD = 0`) | Hidden (`EnableOSD = 0`) | Hidden (`EnableOSD = 0`) |

---

## ⌨️ In-Game Hotkeys

| Hotkey | Action | Mechanics |
|---|---|---|
| **<kbd>Alt</kbd> + <kbd>1</kbd>** | **Toggle OSD Visibility** | Games start with a clean screen. Pressing **Alt + 1** instantly toggles telemetry. Synchronized between Afterburner and RTSS. |
| **<kbd>Alt</kbd> + <kbd>F1</kbd>** | **Activate Profile 1 (Undervolt)** | Cool temperatures, silent acoustics, locked maximum boost clocks. |
| **<kbd>Alt</kbd> + <kbd>F2</kbd>** | **Activate Profile 2 (Overclock / Stock)** | Maximum clock profile for pushing peak frame rates. |

---

## 🛡️ Engineering Guarantees

* **Ghost Mode (`SingleTrayIconMode = 1`):** Hides the secondary RTSS blue monitor icon from the taskbar notification area while keeping the background hooking engine active.
* **Idempotent Speed Engine (< 5s):** Re-runs automatically detect installed binaries, skipping network downloads and repeated installations.
* **Dynamic Hardware Matching:** Dynamically scans host GPU device IDs (`VEN_10DE...cfg`) rather than hardcoding static vendor strings.
* **Safety First:** Creates automatic timestamped backups in `Profiles\Backup_YYYYMMDD_HHMMSS` before modifying configurations.
* **Zero Syntax Errors (AST 0):** Every script passes PowerShell Abstract Syntax Tree validation and enforces standard UTF-8 BOM encoding.

---

## 📂 Project Structure

```
msi-afterburner-rtss/
├── Setup.ps1                  # Interactive 1-click launcher
├── Setup-Esports-OSD.ps1      # Esports compact OSD configuration
├── Setup-Detailed-OSD.ps1     # Per-core detailed monitoring configuration
├── Setup-Base-NoOC.ps1        # Pure software installer (no driver/GPU tweaks)
├── README.md                  # This documentation (English)
├── README_RU.md               # Detailed guide (Russian)
├── AGENTS.md                  # Universal guidelines for AI agents
├── LICENSE                    # Open source license
├── profiles/                  # Hardware-specific undervolt profiles
│   ├── RTX-5080-Undervolt.ps1 # 0.950V / 2850MHz undervolt curve
│   └── RTX-3060-Undervolt.ps1 # 0.875V / 1875MHz undervolt curve
├── tools/                     # Portable helper utilities
│   ├── nvidiaProfileInspector.exe
│   ├── nvidiaProfileInspector.exe.config
│   ├── Reference.xml
│   └── NV-Esports-Ultimate.nip
├── tests/                     # Quality assurance & validation
│   └── Syntax.Tests.ps1       # Automated AST and contract verification
└── docs/                      # Technical documentation
    ├── architecture/          # Architecture & ADRs
    │   ├── ARCHITECTURE.md
    │   └── DECISIONS.md
    ├── development/           # Development & contributing guides
    │   ├── DEVELOPMENT.md
    │   └── CONTRIBUTING.md
    ├── guides/                # Support & edge-case workarounds
    │   ├── KNOWN_ISSUES.md
    │   └── SUPPORT.md
    ├── project/               # Project state & historical records
    │   ├── PROJECT_STATE.md
    │   ├── CHANGELOG.md
    │   └── ROADMAP.md
    └── security/              # Security and privilege management
        └── SECURITY.md
```

---

## 🧪 Automated Verification

Run the built-in quality gate test suite locally:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tests\Syntax.Tests.ps1
```

All 7 scripts are checked for valid Abstract Syntax Trees (0 errors), standard 3-byte UTF-8 BOM headers, and live configuration key contracts.
