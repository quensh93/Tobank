param(
  [string]$OutDir = "screenshots",
  [string]$Prefix = "android",
  [string]$Serial = ""
)

$ErrorActionPreference = "Stop"

function Require-Adb {
  $adb = Get-Command adb -ErrorAction SilentlyContinue
  if (-not $adb) {
    throw "adb not found. Install Android Platform Tools and ensure adb is in PATH."
  }
}

Require-Adb

if (-not (Test-Path $OutDir)) {
  New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
}

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$filename = "${Prefix}_${timestamp}.png"
$outPath = Join-Path $OutDir $filename

$adbArgs = @()
if ($Serial -and $Serial.Trim().Length -gt 0) {
  $adbArgs += "-s"
  $adbArgs += $Serial
}
$adbArgs += "exec-out"
$adbArgs += "screencap"
$adbArgs += "-p"

$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = "adb"
$psi.Arguments = ($adbArgs -join " ")
$psi.RedirectStandardOutput = $true
$psi.UseShellExecute = $false
$psi.CreateNoWindow = $true

$p = New-Object System.Diagnostics.Process
$p.StartInfo = $psi
[void]$p.Start()

$fs = [System.IO.File]::Open($outPath, [System.IO.FileMode]::Create, [System.IO.FileAccess]::Write)
try {
  $p.StandardOutput.BaseStream.CopyTo($fs)
} finally {
  $fs.Close()
}

$p.WaitForExit()
if ($p.ExitCode -ne 0) {
  throw "adb screencap failed with exit code $($p.ExitCode)."
}

Write-Host "Saved screenshot: $outPath"
