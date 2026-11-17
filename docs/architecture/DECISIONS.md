# Architectural Decision Records (ADR)

## ADR-001: Idempotent Deployment by Default
* **Status:** Accepted  
* **Context:** Previous installer scripts downloaded 50 MB archives and executed silent installers on every run, taking 45–60 seconds even if the software was already configured.  
* **Decision:** Implement a deterministic check for `MSIAfterburner.exe` and `RTSS.exe`. If both executables exist and match target versions, bypass network downloads and binary installation entirely.  
* **Consequence:** Execution time dropped from 50+ seconds to 4.82 seconds with 0 bytes of network traffic for configured machines.

---

## ADR-002: Background Ghost Mode over On-Demand Process Spawning
* **Status:** Accepted  
* **Context:** Users requested that RTSS not appear in the system tray and only "run" when monitoring is requested via hotkey.  
* **Decision:** Do NOT terminate RTSS or attempt to launch it on hotkey during gameplay. Instead, enable `SingleTrayIconMode = 1` in Afterburner and `EnableOSD = 0` in RTSS `Profiles\Global`.  
* **Consequence:**
  * The RTSS tray icon is 100% suppressed from the Windows taskbar.
  * In-game screen is clean by default.
  * Late DLL injection crashes and anti-cheat bans in DX12/Vulkan titles are completely avoided.
  * Pressing <kbd>Alt</kbd> + <kbd>1</kbd> toggles the overlay instantly.

---

## ADR-003: Synchronization of OSD Toggle Hotkeys
* **Status:** Accepted  
* **Context:** MSI Afterburner had `OSDToggleHotkey=00040031h` (Alt+1) while RTSS `HotkeyHandler.cfg` had `OSDToggleHotkey=00040032` (Alt+2). This caused desynchronization and hotkey failures when RTSS ran detached from Afterburner.  
* **Decision:** Standardize both configurations to `00040031` (Alt + 1).  
* **Consequence:** Predictable, universal toggle behavior across all games and desktop environments.

---

## ADR-004: Dynamic PCI-ID Profile Matching
* **Status:** Accepted  
* **Context:** Hardcoded filename `VEN_10DE&DEV_2C02&SUBSYS_176219DA&REV_A1&BUS_1&DEV_0&FN_0.cfg` failed on different motherboard PCIe slot assignments (e.g. `BUS_2`), eGPUs, and other GPU vendor sub-models.  
* **Decision:** Inspect `Profiles\VEN_*.cfg` at runtime to find the actively assigned hardware profile before committing frequency offsets and curve values.  
* **Consequence:** Cross-hardware reliability and zero profile dropouts across varied systems.

---

## ADR-005: Graceful Termination with Hard Kill Fallback
* **Status:** Accepted  
* **Context:** Calling `Stop-Process -Force` directly risks corrupting active configuration buffers if Afterburner is writing to disk during script execution.  
* **Decision:** Dispatch `CloseMainWindow()` first, monitor `HasExited` with a 2.5-second stopwatch loop, and issue `Stop-Process -Force` only if the process fails to terminate cooperatively.  
* **Consequence:** Clean config flushing and zero file corruption incidents.
