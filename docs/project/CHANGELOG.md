# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-11-17

### Added
- **Ghost Tray Architecture:** Implemented `SingleTrayIconMode = 1` in MSI Afterburner configuration, suppressing the standalone RTSS notification icon while maintaining background render hooking.
- **Universal Hotkey Synchronization:** Bound both MSI Afterburner and RTSS `HotkeyHandler.dll` to <kbd>Alt</kbd> + <kbd>1</kbd> (`00040031`), ensuring instantaneous and collision-free overlay toggling.
- **Idempotent Deployment Engine:** Script automatically detects existing installations of `MSIAfterburner.exe` and `RTSS.exe`, reducing re-run execution time from 50+ seconds down to under 5 seconds.
- **Automated Configuration Snapshots:** Created timestamped backup generator (`Backup_YYYYMMDD_HHMMSS`) before committing any configuration changes to disk.
- **Dynamic Hardware Profile Matching:** Replaced hardcoded PCI-ID string with automated discovery of active `Profiles\VEN_*.cfg` descriptors.
- **Automated Test Suite:** Created `tests/Syntax.Tests.ps1` providing AST parsing, UTF-8 BOM validation, and live configuration contract verification.
- **Universal AI Handoff Suite:** Added `AGENTS.md`, `PROJECT_STATE.md`, `ARCHITECTURE.md`, `DECISIONS.md`, and `DEVELOPMENT.md`.

### Changed
- Refactored process management to dispatch cooperative `CloseMainWindow` signals with a 2.5-second timeout prior to invoking forced termination.
- Standardized logging to timestamped UTF-8 log files under `Logs\`.

### Fixed
- Fixed 404 dead link in fallback download URL pointing to outdated repository path.
- Fixed unhandled empty `$PSCommandPath` / `$PSScriptRoot` crash occurring when running in interactive or elevated sub-processes.
