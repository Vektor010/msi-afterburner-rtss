# Known Issues & Operational Boundaries

### 1. Manual Access to RTSS GUI while in Ghost Mode
* **Symptom:** Double-clicking the notification tray area does not open the RTSS configuration window.  
* **Root Cause:** By design, `SingleTrayIconMode = 1` in `MSIAfterburner.cfg` suppresses the RTSS tray icon to eliminate taskbar clutter.  
* **Workaround:** Directly execute `C:\Program Files (x86)\RivaTuner Statistics Server\RTSS.exe` (or open via Win+R). Alternatively, set `SingleTrayIconMode = 0` in `MSIAfterburner.cfg` if continuous tray GUI access is desired.

---

### 2. Launching RTSS into an Active 3D Render Loop
* **Symptom:** Starting RTSS while a DirectX 12 game is already running results in no overlay appearing, or triggers an anti-cheat crash.  
* **Root Cause:** Modern graphics APIs (DirectX 12, Vulkan) do not allow late SwapChain hooking without resetting the display device. Anti-cheat engines flag runtime hook insertion as malicious DLL injection.  
* **Resolution:** Ensure RTSS runs in the background prior to game launch (enabled by default via `EnableServer = 1`).

---

### 3. Elevated Privilege Requirement
* **Symptom:** The installer requests User Account Control (UAC) elevation upon startup.  
* **Root Cause:** Writing to `C:\Program Files (x86)\` and managing system-level scheduled tasks requires Windows Administrator privileges.  
* **Resolution:** Elevated relaunch is built directly into the script engine; approve the UAC prompt when launching.

---

### 4. Custom Anti-Cheat Whitelisting
* **Symptom:** Rare competitive titles (e.g. Counter-Strike 2 in Trusted Mode) suppress third-party overlays.  
* **Resolution:** In CS2, third-party software can be permitted with launch option `-allow_third_party_software`, or hardware metrics can be monitored via second screen / logging tools.
