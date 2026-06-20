$index_content = Get-Content -Path "c:\Users\Hensu patel\Desktop\eliteoverseas-2.o\index.html" -Raw
$pattern = '(?s)<div class="rt-footer-full-wrapper">.*?(?=<script src="https://d3e54v103j8qbb.cloudfront.net)'
$match = [regex]::Match($index_content, $pattern)

if (-not $match.Success) {
    Write-Output "Could not extract footer from index.html"
    exit
}
$footer = $match.Value

$files = Get-ChildItem -Path "c:\Users\Hensu patel\Desktop\eliteoverseas-2.o" -Filter "*.html" | Where-Object { $_.Name -ne "index.html" -and -not $_.Name.StartsWith("scratch_") }

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $new_content = $content -replace '(?s)<div class="rt-footer-full-wrapper">.*?(?=<script src="https://d3e54v103j8qbb.cloudfront.net)', $footer
    [IO.File]::WriteAllText($file.FullName, $new_content, [System.Text.Encoding]::UTF8)
    Write-Output "Updated footer in $($file.Name)"
}