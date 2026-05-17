$targets=@(
'C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\flows\dashboard_real\json\dashboard_real_shell.json',
'C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\home_page\json\tobank_home_page_dart.json',
'C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\home_page\api\GET_tobank_home_page_dart.json'
)
foreach($p in $targets){
  $c = Get-Content -Raw -Encoding UTF8 $p
  $bytes = [System.Text.Encoding]::GetEncoding(1252).GetBytes($c)
  $decoded = [System.Text.Encoding]::UTF8.GetString($bytes)
  [System.IO.File]::WriteAllText($p, $decoded, [System.Text.UTF8Encoding]::new($false))
  Write-Output "decoded: $p"
}
