# ==============================================================================
# Automated Quality Gate & Syntax Test Suite
# Universal Open Source Standard 2026
# ==============================================================================

$root = Split-Path -Parent $PSScriptRoot
$scripts = Get-ChildItem -Path $root -Recurse -Filter "*.ps1" | Where-Object { $_.FullName -notmatch "\\\.git\\" }

$totalTests = 0
$passedTests = 0
$failedTests = 0

function Assert-Test {
    param([string]$Name, [bool]$Condition, [string]$Details = "")
    $script:totalTests++
    if ($Condition) {
        $script:passedTests++
        Write-Host "  [PASS] $Name" -ForegroundColor Green
    } else {
        $script:failedTests++
        Write-Host "  [FAIL] $Name - $Details" -ForegroundColor Red
    }
}

Write-Host "`n=== ApexTuner Automated Test Suite ===" -ForegroundColor Cyan
Write-Host "Discovered $($scripts.Count) PowerShell scripts for evaluation.`n" -ForegroundColor DarkGray

# 1. AST Syntax Validation
Write-Host "Test Group 1: Abstract Syntax Tree (AST) Validation" -ForegroundColor Yellow
foreach ($s in $scripts) {
    $errs = $null
    $toks = $null
    [System.Management.Automation.Language.Parser]::ParseFile($s.FullName, [ref]$toks, [ref]$errs) | Out-Null
    $hasErrors = ($errs.Count -gt 0)
    $errMsg = if ($hasErrors) { $errs[0].Message } else { "" }
    Assert-Test -Name "AST Syntax: $($s.Name)" -Condition (-not $hasErrors) -Details $errMsg
}

# 2. UTF-8 BOM Encoding Validation
Write-Host "`nTest Group 2: UTF-8 BOM Encoding Integrity" -ForegroundColor Yellow
foreach ($s in $scripts) {
    $bytes = [System.IO.File]::ReadAllBytes($s.FullName)
    $hasBom = ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF)
    Assert-Test -Name "UTF-8 BOM Header: $($s.Name)" -Condition $hasBom -Details "Missing standard 0xEF 0xBB 0xBF header"
}

# 3. Live Configuration Key Verification (If installed)
Write-Host "`nTest Group 3: Live Configuration Contracts" -ForegroundColor Yellow
$cfgPath = "C:\Program Files (x86)\MSI Afterburner\Profiles\MSIAfterburner.cfg"
if (Test-Path $cfgPath) {
    $content = Get-Content $cfgPath -Raw
    Assert-Test -Name "MSIAfterburner.cfg contains SingleTrayIconMode=1" -Condition ($content -match "SingleTrayIconMode\s*=\s*1")
    Assert-Test -Name "MSIAfterburner.cfg contains EnableServer=1" -Condition ($content -match "EnableServer\s*=\s*1")
    Assert-Test -Name "MSIAfterburner.cfg contains OSDToggleHotkey=00040031h" -Condition ($content -match "OSDToggleHotkey\s*=\s*00040031h")
} else {
    Write-Host "  [SKIP] MSI Afterburner is not installed in standard directory; live contract test skipped." -ForegroundColor DarkGray
}

$rtssHotkey = "C:\Program Files (x86)\RivaTuner Statistics Server\Plugins64\Client\HotkeyHandler.cfg"
if (-not (Test-Path $rtssHotkey)) {
    $rtssHotkey = "C:\Program Files (x86)\RivaTuner Statistics Server\Plugins\Client\HotkeyHandler.cfg"
}
if (Test-Path $rtssHotkey) {
    $content = Get-Content $rtssHotkey -Raw
    Assert-Test -Name "HotkeyHandler.cfg contains OSDToggleHotkey=00040031" -Condition ($content -match "OSDToggleHotkey\s*=\s*00040031")
}

# 4. Static Analyzer Error Gate (if PSScriptAnalyzer module is present)
if (Get-Module -ListAvailable -Name PSScriptAnalyzer) {
    Write-Host "`nTest Group 4: PSScriptAnalyzer Error Checks" -ForegroundColor Yellow
    foreach ($s in $scripts) {
        $psaErrors = @(Invoke-ScriptAnalyzer -Path $s.FullName -Severity Error)
        $errInfo = if ($psaErrors.Count -gt 0) { "$($psaErrors[0].RuleName) at L$($psaErrors[0].Line)" } else { "" }
        Assert-Test -Name "PSScriptAnalyzer (0 Errors): $($s.Name)" -Condition ($psaErrors.Count -eq 0) -Details $errInfo
    }
}

Write-Host "`n==================================================" -ForegroundColor Cyan
Write-Host "Test Results: Total: $totalTests | Passed: $passedTests | Failed: $failedTests" -ForegroundColor $(if ($failedTests -eq 0) { "Green" } else { "Red" })
Write-Host "==================================================`n" -ForegroundColor Cyan

if ($failedTests -gt 0) {
    exit 1
}
exit 0
