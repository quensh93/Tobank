$files=@(
'C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\ready_for_build\home_page.dart',
'C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\home_page\dart\home_page.dart',
'C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\ready_for_build\dashboard_real_shell.dart',
'C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\flows\dashboard_real\dart\dashboard_real_shell.dart'
)
$rx = [regex]"'([^'\r\n]*)'"
foreach($p in $files){
  $c = Get-Content -Raw -Encoding UTF8 $p
  $fixed = $rx.Replace($c, {
    param($m)
    $s = $m.Groups[1].Value
    if($s -match '[ØÙÚÛÃâ]'){
      $bytes = [System.Text.Encoding]::GetEncoding(1252).GetBytes($s)
      $d = [System.Text.Encoding]::UTF8.GetString($bytes)
      return "'" + $d + "'"
    }
    return $m.Value
  })
  if($fixed -ne $c){
    [System.IO.File]::WriteAllText($p, $fixed, [System.Text.UTF8Encoding]::new($false))
    Write-Output "fixed: $p"
  } else {
    Write-Output "nochange: $p"
  }
}
