param(
    [string]$SourceRoot = "lib/stac/tobank",
    [string]$ViewRoot = "graphify-json-view"
)

$ErrorActionPreference = "Stop"

function Add-JsonPaths {
    param(
        [Parameter(Mandatory = $true)]$Node,
        [Parameter(Mandatory = $true)][string]$Prefix,
        [Parameter(Mandatory = $true)][System.Collections.Generic.List[string]]$Paths
    )

    if ($null -eq $Node) {
        $Paths.Add($Prefix) | Out-Null
        return
    }

    if ($Node -is [System.Management.Automation.PSCustomObject]) {
        $props = $Node.PSObject.Properties
        if ($props.Count -eq 0) {
            $Paths.Add($Prefix) | Out-Null
            return
        }
        foreach ($prop in $props) {
            $next = if ([string]::IsNullOrEmpty($Prefix)) { $prop.Name } else { "$Prefix.$($prop.Name)" }
            Add-JsonPaths -Node $prop.Value -Prefix $next -Paths $Paths
        }
        return
    }

    if ($Node -is [System.Collections.IEnumerable] -and -not ($Node -is [string])) {
        $items = @($Node)
        if ($items.Count -eq 0) {
            $Paths.Add("$Prefix[]") | Out-Null
            return
        }
        for ($i = 0; $i -lt $items.Count; $i++) {
            $next = "$Prefix[$i]"
            Add-JsonPaths -Node $items[$i] -Prefix $next -Paths $Paths
        }
        return
    }

    $Paths.Add($Prefix) | Out-Null
}

function Get-RelativePathCompat {
    param(
        [Parameter(Mandatory = $true)][string]$BasePath,
        [Parameter(Mandatory = $true)][string]$TargetPath
    )

    $base = [System.Uri]((Resolve-Path -LiteralPath $BasePath).Path.TrimEnd('\') + '\')
    $target = [System.Uri]((Resolve-Path -LiteralPath $TargetPath).Path)
    return [System.Uri]::UnescapeDataString($base.MakeRelativeUri($target).ToString()).Replace('/', '\')
}

$srcResolved = (Resolve-Path -LiteralPath $SourceRoot).Path
$viewResolved = Join-Path (Get-Location).Path $ViewRoot
$mirrorRoot = Join-Path $viewResolved "mirrors"

if (Test-Path -LiteralPath $mirrorRoot) {
    Remove-Item -LiteralPath $mirrorRoot -Recurse -Force
}

New-Item -ItemType Directory -Path $mirrorRoot -Force | Out-Null

$jsonFiles = Get-ChildItem -LiteralPath $srcResolved -Recurse -File -Filter *.json | Sort-Object FullName

if ($jsonFiles.Count -eq 0) {
    throw "No JSON files found under '$SourceRoot'."
}

$indexLines = New-Object System.Collections.Generic.List[string]
$indexLines.Add("# Tobank STAC JSON View") | Out-Null
$indexLines.Add("") | Out-Null
$indexLines.Add("Generated from `"$SourceRoot`".") | Out-Null
$indexLines.Add("") | Out-Null
$indexLines.Add("Total files: $($jsonFiles.Count)") | Out-Null
$indexLines.Add("") | Out-Null
$indexLines.Add("## Files") | Out-Null
$indexLines.Add("") | Out-Null

foreach ($file in $jsonFiles) {
    $rel = (Get-RelativePathCompat -BasePath $srcResolved -TargetPath $file.FullName).Replace("\", "/")
    $outPath = Join-Path $mirrorRoot ($rel + ".md")
    $outDir = Split-Path -Parent $outPath
    New-Item -ItemType Directory -Path $outDir -Force | Out-Null

    $raw = Get-Content -LiteralPath $file.FullName -Raw

    $pathLines = @()
    try {
        $obj = $raw | ConvertFrom-Json -Depth 100
        $paths = New-Object System.Collections.Generic.List[string]
        Add-JsonPaths -Node $obj -Prefix '$' -Paths $paths
        $pathLines = $paths | Sort-Object -Unique | Select-Object -First 300
    } catch {
        $pathLines = @("Could not parse JSON structure for path extraction.")
    }

    $md = New-Object System.Collections.Generic.List[string]
    $md.Add("# $rel") | Out-Null
    $md.Add("") | Out-Null
    $md.Add("Source: lib/stac/tobank/$rel") | Out-Null
    $md.Add("") | Out-Null
    $md.Add("## JSON Paths (sample)") | Out-Null
    foreach ($p in $pathLines) {
        $md.Add("- $p") | Out-Null
    }
    $md.Add("") | Out-Null
    $md.Add("## Raw JSON") | Out-Null
    $md.Add('```json') | Out-Null
    $md.Add($raw.TrimEnd()) | Out-Null
    $md.Add('```') | Out-Null

    Set-Content -LiteralPath $outPath -Value ($md -join "`r`n") -Encoding UTF8
    $indexLines.Add("- [$rel](mirrors/$rel.md)") | Out-Null
}

Set-Content -LiteralPath (Join-Path $viewResolved "README.md") -Value ($indexLines -join "`r`n") -Encoding UTF8

Write-Output "Generated $($jsonFiles.Count) markdown mirror files in: $mirrorRoot"
Write-Output "Index file: $(Join-Path $viewResolved 'README.md')"
