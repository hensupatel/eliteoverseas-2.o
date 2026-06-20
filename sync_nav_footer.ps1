$index_content = Get-Content -Path "c:\Users\Hensu patel\Desktop\eliteoverseas-2.o\index.html" -Raw

# Extract Footer
$footer_pattern = '(?s)<div class="rt-footer-full-wrapper">.*?(?=<script src="https://d3e54v103j8qbb.cloudfront.net)'
$footer_match = [regex]::Match($index_content, $footer_pattern)
if (-not $footer_match.Success) {
    Write-Output "Could not extract footer from index.html"
    exit
}
$footer = $footer_match.Value

# Extract Navbar
$nav_pattern = '(?s)<header class="rt-nav-wrapper">.*?</header>'
$nav_match = [regex]::Match($index_content, $nav_pattern)
if (-not $nav_match.Success) {
    Write-Output "Could not extract navbar from index.html"
    exit
}
$navbar = $nav_match.Value

$files = Get-ChildItem -Path "c:\Users\Hensu patel\Desktop\eliteoverseas-2.o" -Filter "*.html" | Where-Object { $_.Name -ne "index.html" }

foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    
    # Replace Footer
    $content = $content -replace '(?s)<div class="rt-footer-full-wrapper">.*?(?=<script src="https://d3e54v103j8qbb.cloudfront.net)', $footer
    
    # Replace Navbar
    $content = $content -replace '(?s)<header class="rt-nav-wrapper">.*?</header>', $navbar
    
    [IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Output "Synced navbar & footer in $($file.Name)"
}