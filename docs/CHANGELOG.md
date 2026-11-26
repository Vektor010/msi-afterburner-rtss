# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-11-26

### Fixed
- **MSI-Afterburner-Standalone.ps1 Installer Bug & 90 MB Temp Leak:** Added proper `.NET` wrapper (`inner.zip`) extraction for `MSIAfterburnerSetup467Beta2.zip`, idempotency check, graceful termination of active processes before config write, automatic `Backup_YYYYMMDD_HHMMSS` snapshots, IFEO redist blocking, RTSS setup, automatic cleanup of temporary archives in `%TEMP%`, and clean background launch without forcing a browser window.
- **GPU Safety Guard (`Moi` & `NextGen`):** Added strict hardware check (`DEV_2C02`) so RTX 5080 `VFCurve` and `+2500` memory offset are applied only when RTX 5080 is detected, keeping non-5080 NVIDIA/AMD/Intel GPUs safely on stock clocks.
- **AMD / Intel Compatibility & NPI Temp Cleanup:** Guarded `nvidiaProfileInspector.exe` invocation with `Win32_VideoController` (`VEN_10DE`) detection, unified session logging, and automatic removal of `%TEMP%\npi` fallback artifacts.
- **Verification Null-Index Crash & Dynamic RTSS Plugin Path:** Fixed `Matches[0]` crash in Step 8 when config keys are missing, consolidated verification to single file reads via `[System.IO.File]::ReadAllText`, aligned `fr33thy.ovl` and `HotkeyHandler.cfg` paths to dynamic `$RtssClient`, and fixed `[1-3]` menu validation typo in `Setup.ps1`.
- **Network Check & PSScriptAnalyzer Cleanliness:** Replaced hardcoded `Test-Connection 8.8.8.8` (which caused `PSAvoidUsingComputerNameHardcoded` errors and ICMP firewall timeouts) with instant `NetworkInterface::GetIsNetworkAvailable()`.

### Performance & Maintenance
- **2.5-Second Faster Process Shutdown:** `Stop-ComponentGraceful` now skips the 2.5-second spin-wait when Afterburner/RTSS are minimized to system tray (`MainWindowHandle -eq 0`), and explicitly stops all `Stopwatch` timers.
- **Automatic Log Rotation:** Installer scripts retain the 10 most recent session logs under `Logs\` to prevent unbounded disk growth.

## [1.0.0] - 2026-11-17

### Added
- **Ghost Tray Architecture:** Implemented `SingleTrayIconMode = 1` in MSI Afterburner configuration, suppressing the standalone RTSS notification icon while maintaining background render hooking.
- **Universal Hotkey Synchronization:** Bound both MSI Afterburner and RTSS `HotkeyHandler.dll` to <kbd>Alt</kbd> + <kbd>1</kbd> (`00040031`), ensuring instantaneous and collision-free overlay toggling.
- **Idempotent Deployment Engine:** Script automatically detects existing installations of `MSIAfterburner.exe` and `RTSS.exe`, reducing re-run execution time from 50+ seconds down to under 5 seconds.
- **Automated Configuration Snapshots:** Created timestamped backup generator (`Backup_YYYYMMDD_HHMMSS`) before committing any configuration changes to disk.
- **Dynamic Hardware Profile Matching:** Replaced hardcoded PCI-ID string with automated discovery of active `Profiles\VEN_*.cfg` descriptors.
- **Automated Test Suite:** Created `tests/Syntax.Tests.ps1` providing AST parsing, UTF-8 BOM validation, and live configuration contract verification.
- **Documentation Suite:** Added `AGENTS.md`, `docs/ARCHITECTURE.md`, `docs/CONTRIBUTING.md`, `docs/KNOWN_ISSUES.md`, and `docs/SECURITY.md`.

### Changed
- Refactored process management to dispatch cooperative `CloseMainWindow` signals with a 2.5-second timeout prior to invoking forced termination.
- Standardized logging to timestamped UTF-8 log files under `Logs\`.

### Fixed
- Fixed 404 dead link in fallback download URL pointing to outdated repository path.
- Fixed unhandled empty `$PSCommandPath` / `$PSScriptRoot` crash occurring when running in interactive or elevated sub-processes.
