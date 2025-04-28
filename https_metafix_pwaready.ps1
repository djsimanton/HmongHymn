# Save as: add-pwa-tags.ps1
$indexFolder = Join-Path $PSScriptRoot "index"
$htmlFiles = Get-ChildItem -Path $indexFolder -Filter *.html

foreach ($file in $htmlFiles) {
    Write-Output "Processing: $($file.Name)"

    # Read file
    $content = Get-Content $file.FullName -Raw

    # If PWA tags already exist, skip
    if ($content -match '<link\s+rel=["'']manifest["'']') {
        Write-Output "Skipping $($file.Name) - manifest already present."
        continue
    }

    # Insert PWA link tag right after the <head> tag
    $content = $content -replace '(?i)(<head[^>]*>)', '${1}' + "`n    <link rel=""manifest"" href=""/manifest.json"">" + "`n    <meta name=""theme-color"" content=""#003366"">"

    # Fix Google Fonts link if needed (http -> https)
    $content = $content -replace 'http://fonts\.googleapis\.com', 'https://fonts.googleapis.com'

    # Save back
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Output "✅ All files updated with PWA tags successfully."
