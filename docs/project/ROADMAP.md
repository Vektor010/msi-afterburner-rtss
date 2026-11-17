# Product Roadmap

## Vision
To provide the definitive, zero-friction, production-grade automation suite for Windows GPU telemetry, low-latency display hooks, and precision hardware tuning.

---

## Milestone 1: v1.0.0 — Production Core (Current)
* [x] **Ghost Tray Mode:** Clean taskbar with `SingleTrayIconMode = 1`.
* [x] **Unified Hotkey Sync:** Universal <kbd>Alt</kbd> + <kbd>1</kbd> mapping across Afterburner and RTSS.
* [x] **Idempotent Deployment:** Execution in < 5 seconds for pre-installed systems.
* [x] **Dynamic Hardware Detection:** Automatic matching of `Profiles\VEN_*.cfg` without hardcoded PCI IDs.
* [x] **Automated Quality Gate:** Syntax AST and UTF-8 BOM test suite.
* [x] **Universal AI Handoff:** Comprehensive `AGENTS.md`, `PROJECT_STATE.md`, and architectural documentation.

---

## Milestone 2: v1.1.0 — Telemetry & Profiles (Q1 2027)
* [ ] **Modular CLI Parameters:** Add support for `-Profile <Classic|NextGen>`, `-GpuPreset <5080|3060|Custom>`, and `-DryRun` flags.
* [ ] **AMD Radeon & Intel Arc Profile Support:** Extend monitoring profiles to AMD RDNA and Intel Battlemage graphics architectures.
* [ ] **Automated Benchmark Harness:** In-script synthetic load test to verify undervolt stability prior to locking frequencies.

---

## Milestone 3: v1.2.0 — Cloud & GitOps Integration (Q2 2027)
* [ ] **JSON Export of Active Telemetry:** Export real-time metrics to web endpoints or local JSON loggers for external stream overlays.
* [ ] **Package Manager Distribution:** Publish to `winget` and `Chocolatey` for automated single-command installation.
