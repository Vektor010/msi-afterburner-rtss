# ==============================================================================
# MSI Afterburner & RTSS Automated Suite - Interactive Setup Launcher
# Universal Open Source Standard 2026
# ==============================================================================

# Проверка прав администратора
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")
if (-not $isAdmin) {
    $realPath = if ($PSCommandPath) { $PSCommandPath } elseif ($MyInvocation.MyCommand.Path) { $MyInvocation.MyCommand.Path } else { Join-Path (Get-Location).Path "Setup.ps1" }
    Write-Host "[UAC] Запуск от имени Администратора..." -ForegroundColor Yellow
    Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $realPath) -Verb RunAs
    Exit
}

$Host.UI.RawUI.WindowTitle = "MSI Afterburner & RTSS Suite Launcher"
$root = if ($PSScriptRoot) { $PSScriptRoot } elseif ($MyInvocation.MyCommand.Path) { Split-Path -Parent $MyInvocation.MyCommand.Path } else { (Get-Location).Path }

function Show-Header {
    Clear-Host
    Write-Host "========================================================================" -ForegroundColor Cyan
    Write-Host "             MSI AFTERBURNER & RTSS AUTOMATED SETUP SUITE               " -ForegroundColor Cyan
    Write-Host "========================================================================" -ForegroundColor Cyan
    Write-Host " Выберите конфигурацию для развертывания:`n" -ForegroundColor DarkGray
}

while ($true) {
    Show-Header
    Write-Host "  [1] NextGen — Киберспортивный OSD (MSI-Afterburner-NextGen.ps1)" -ForegroundColor Green
    Write-Host "      -> Компактный минималистичный оверлей для CS2 / Apex / шутеров." -ForegroundColor Gray
    Write-Host "      -> Только важное: FPS, фреймтайм, 1% Low, 0.1% Low, общий CPU/GPU." -ForegroundColor Gray
    Write-Host "      -> Не перегружает экран и зрение в соревновательных играх.`n" -ForegroundColor Gray

    Write-Host "  [2] Moi — Детальный OSD для бенчмарков (MSI-Afterburner-Moi.ps1)" -ForegroundColor Yellow
    Write-Host "      -> Максимальная поядерная телеметрия: частота, нагрузка и нагрев" -ForegroundColor Gray
    Write-Host "         КАЖДОГО ядра CPU (CPU0..CPU15), видеопамять, кулеры, график кадра." -ForegroundColor Gray
    Write-Host "      -> Идеально для стресс-тестов, поиска троттлинга и замера стабильности.`n" -ForegroundColor Gray

    Write-Host "  [3] Standalone — Чистая базовая установка (MSI-Afterburner-Standalone.ps1)" -ForegroundColor White
    Write-Host "      -> Установка MSI Afterburner + RTSS с тихим треем и хоткеем Alt+1." -ForegroundColor Gray
    Write-Host "      -> БЕЗ изменения частот GPU, кривых напряжения и профилей драйвера.`n" -ForegroundColor Gray

    Write-Host "  [T] Запустить автоматические тесты качества (Syntax.Tests.ps1)" -ForegroundColor Cyan
    Write-Host "  [Q] Выход`n" -ForegroundColor DarkGray
    Write-Host "========================================================================" -ForegroundColor Cyan

    $choice = Read-Host "Введите номер действия [1-3, T, Q]"

    switch ($choice.ToUpper().Trim()) {
        "1" {
            $target = Join-Path $root "MSI-Afterburner-NextGen.ps1"
            Write-Host "`nЗапуск MSI-Afterburner-NextGen.ps1..." -ForegroundColor Green
            powershell.exe -NoProfile -ExecutionPolicy Bypass -File $target
            Read-Host "`nНажмите Enter для возврата в меню..."
        }
        "2" {
            $target = Join-Path $root "MSI-Afterburner-Moi.ps1"
            Write-Host "`nЗапуск MSI-Afterburner-Moi.ps1..." -ForegroundColor Yellow
            powershell.exe -NoProfile -ExecutionPolicy Bypass -File $target
            Read-Host "`nНажмите Enter для возврата в меню..."
        }
        "3" {
            $target = Join-Path $root "MSI-Afterburner-Standalone.ps1"
            Write-Host "`nЗапуск MSI-Afterburner-Standalone.ps1..." -ForegroundColor White
            powershell.exe -NoProfile -ExecutionPolicy Bypass -File $target
            Read-Host "`nНажмите Enter для возврата в меню..."
        }
        "T" {
            $target = Join-Path $root "tests\Syntax.Tests.ps1"
            Write-Host "`nЗапуск тестов..." -ForegroundColor Cyan
            powershell.exe -NoProfile -ExecutionPolicy Bypass -File $target
            Read-Host "`nНажмите Enter для возврата в меню..."
        }
        "Q" {
            Write-Host "Выход." -ForegroundColor DarkGray
            exit 0
        }
        default {
            Write-Host "Неверный выбор. Пожалуйста, введите цифру от 1 до 5, T или Q." -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
}
